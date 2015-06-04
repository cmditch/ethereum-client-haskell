
module Blockchain.PeerUrls where

import Network

-- Working 0, 1, 2, 67, 119

ipAddresses::[(String, PortNumber)]
ipAddresses =
  [
    ("127.0.0.1", 30303),
    ("poc-9.ethdev.com", 30303),
    ("poc-8.ethdev.com", 30303),
    ("api.blockapps.net", 30303),
    ("stablenet.blockapps.net", 30303),
    ("gav.ethdev.com", 30303),
    ("52.5.60.7", 30303),
    ("52.4.40.229", 30303),
    ("52.4.180.23", 30303),
    ("52.4.131.128", 30303),
    ("52.16.188.185", 30303),
    ("52.0.243.36", 30303),
    ("92.51.165.126", 30303),
    ("144.76.62.101", 30303),
    ("52.5.26.21", 30303),
    ("52.5.26.15", 30303),
    ("52.5.25.137", 30303),
    ("54.207.93.166", 30303),

    ("207.12.89.180", 30303),
    ("24.90.136.85", 40404), 
    ("185.43.109.23", 30303),
    ("76.220.27.23", 30303),
    ("194.151.205.61", 30303),
    ("104.236.44.20", 30303),
    ("90.215.69.132", 30303),
    ("46.115.170.122", 30303),
    ("82.113.99.187", 30303),
    ("54.73.114.158", 30303),
    ("94.197.120.233", 30303),
    ("99.36.164.218", 30301),
    ("79.205.230.196", 30303),
    ("213.61.84.226", 30303),
    ("82.217.72.169", 20818),
    ("66.91.18.59", 30303),
    ("92.225.49.139", 30303),
    ("46.126.19.53", 30303),
    ("209.6.197.196", 30303),
    ("95.91.196.230", 30303),
    ("77.87.49.7", 30303),
    ("77.50.138.143", 22228),
    ("84.232.211.95", 30300),
    ("213.127.159.150", 30303),
    ("89.71.42.180", 30303),
    ("216.240.30.23", 30303),
    ("62.163.114.115", 30304),
    ("178.198.11.18", 30303),
    ("94.117.148.121", 30303),
    ("80.185.182.157", 30303),
    ("129.194.71.126", 30303),
    ("129.194.71.126", 12667),
    ("199.254.238.167", 30303),
    ("71.208.244.211", 30303),
    ("46.114.45.182", 30303),
    ("178.37.149.29", 30303),
    ("81.38.156.153", 30303),
    ("5.144.60.120", 30304),
    ("67.188.113.229", 30303),
    ("23.121.237.24", 30303),
    ("37.120.31.241", 30303),
    ("79.178.55.18", 30303),
    ("50.1.116.44", 30303),
    ("213.129.230.10", 30303),
    ("91.64.116.234", 30303),
    ("86.164.51.215", 30303),
    ("46.127.142.224", 30300),
    ("195.221.66.4", 30300),
    ("95.90.239.241", 30303),
    ("176.67.169.137", 30303),
    ("94.224.199.123", 30303),
    ("38.117.159.162", 30303),
    ("5.9.141.240", 30303),
    ("110.164.236.93", 30303),
    ("86.147.58.164", 30303),
    ("188.63.78.132", 30303),
    ("128.12.255.172", 30303),
    ("90.35.135.242", 30303),
    ("82.232.60.209", 30303),
    ("87.215.30.74", 30303),
    ("129.194.81.234", 22318),
    ("178.19.221.38", 30303),
    ("94.174.162.250", 30303),
    ("193.138.219.234", 30303),
    ("188.122.16.76", 30303),
    ("71.237.182.164", 30303),
    ("207.12.89.180", 30303),
    ("207.12.89.180", 30300),
    ("84.72.161.78", 30303),
    ("173.238.50.70", 30303),
    ("90.213.167.21", 30303),
    ("120.148.4.242", 30303),
    ("67.237.187.247", 30303),
    ("77.101.50.246", 30303),
    ("88.168.242.87", 30300),
    ("40.141.47.2", 30303),
    ("109.201.154.150", 30303),
    ("5.228.251.149", 30303),
    ("79.205.244.3", 30303),
    ("77.129.6.180", 30303),
    ("208.52.154.136", 30300),
    ("199.254.238.167", 30303),
    ("80.185.170.70", 30303),
    ("188.220.9.241", 30303),
    ("129.194.81.234", 30303),
    ("76.100.20.104", 30300),
    ("162.210.197.234", 30303),
    ("89.246.69.218", 30303),
    ("178.19.221.38", 29341),
    ("217.91.252.61", 30303),
    ("118.241.70.83", 30303),
    ("190.17.13.160", 30303),
    ("68.7.46.39", 30303),
    ("99.36.164.218", 30301),
    ("37.157.38.10", 30303),
    ("24.176.161.133", 30303),
    ("82.113.99.187", 30303),
    ("194.151.205.61", 30303),
    ("54.235.157.173", 30303),
    ("95.91.210.151", 10101),
    ("108.59.8.182", 30303),
    ("217.247.70.175", 30303),
    ("173.238.52.23", 30303),
    ("82.217.72.169", 30304),
    ("176.114.249.240", 30303),
    ("178.19.221.38", 10101),
    ("87.149.174.176", 990),
    ("95.90.239.67", 30300),
    ("77.129.3.69", 30303),
    ("88.116.98.234", 30303),
    ("216.164.146.72", 22880),
    ("107.170.255.207", 30303),
    ("178.62.221.246", 30303),
    ("177.205.165.56", 30303),
    ("115.188.14.179", 112),
    ("145.129.59.101", 30303),
    ("64.134.53.142", 30303),
    ("68.142.28.137", 30303),
    ("162.243.131.173", 30303),
    ("81.181.146.231", 30303),
    ("23.22.211.45", 30303),
    ("24.134.75.192", 30303),
    ("188.63.251.204", 30303),
    ("93.159.121.155", 30303),
    ("109.20.132.214", 30303),
    ("204.50.102.246", 30303),
    ("50.245.145.217", 30303),
    ("86.143.179.69", 30303),
    ("77.50.138.143", 22228),
    ("23.22.211.45", 992),
    ("65.206.95.146", 30303),
    ("68.60.166.58", 30303),
    ("178.198.215.3", 30303),
    ("64.134.58.80", 30303),
    ("207.229.173.166", 30303),
    ("kobigurk.dyndns.org", 30303),
    ("37.142.103.9", 30303)
  ]
  
