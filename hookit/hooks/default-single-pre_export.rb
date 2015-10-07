
if payload[:new_member][:schema][:meta][:disk].to_i < `du -s /data/var/db/mongodb | awk '{print $1}`.to_i
  puts "Receiving side too small!!"
  exit 1
end #unless payload[:clear_data] == "false"

# issue save to the local redis
# 'save' rather than 'bgsave' so it blocks
execute 'execute save' do
  command '/data/bin/redis-cli save'
end

execute "send bulk data to new member" do
  command "tar -cf - /data/var/db/mongodb | ssh #{payload[:new_member][:local_ip]} tar -xpf -"
end
