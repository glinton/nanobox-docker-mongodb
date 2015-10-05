
# get host ip address
host = `ifconfig eth0`.match(/inet addr:(\d+\.\d+\.\d+\.\d+)/)[1]

# simple json, no need to require anything
puts <<-EOF
{
  "HOST": "#{host}",
  "PORT": "27017"
}
EOF