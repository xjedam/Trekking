require "json"
require "open-uri"
require "active_support/core_ext"
require "net/http"

ELEVATION_BASE_URL = 'http://maps.googleapis.com/maps/api/elevation/json'
CHART_BASE_URL = 'http://chart.apis.google.com/chart'
class TrailGenerator

  def initialize( longitude_start,latitude_start, longitude_end, latitude_end)
    startStr = latitude_start + ',' + longitude_start
    endStr = latitude_end + ',' + longitude_end
    pathStr = startStr + "|" + endStr
    getElevation(pathStr)
  end

  def getChart(chartData, chartDataScaling="-500,5000", chartType="lc",chartLabel="Elevation in Meters",chartSize="500x160",chartColor="orange", chart_args={})

      chart_args.merge!({
        cht: chartType,
        chs: chartSize,
        chl: chartLabel,
        chco: chartColor,
        chds: chartDataScaling,
        chxt: 'x,y',
        chxr: '1,-500,5000'
      })

      dataString = 't:' + chartData.join(',')
      chart_args['chd'] = dataString

      @chartUrl = CHART_BASE_URL + '?' + chart_args.to_query
  end

  def getElevation(path="36.578581,-118.291994|36.23998,-116.83171",samples="100",sensor="false", elvtn_args={})
        elvtn_args.merge!({
          path: path,
          samples: samples,
          sensor: sensor
        })

        url = ELEVATION_BASE_URL + '?' + elvtn_args.to_query
        resp = Net::HTTP.get_response(URI.parse(url))

        response = JSON.parse(resp.body)

        # Create a dictionary for each results[] object
        elevationArray = []

        for resultset in response['results'] do
          elevationArray << resultset['elevation'].round(1)
        end

        # Create the chart passing the array of elevation data
        getChart(chartData=elevationArray)
  end

  def getChartUrl() return @chartUrl; end

 end