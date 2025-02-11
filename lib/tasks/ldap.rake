# frozen_string_literal: true
namespace :ldap do
  desc "Fetches the university ID from LDAP for a given netid and adds it to the user record"
  task update_id: :environment do |_, args|
    User.all.where(university_id: nil).each do |user|
      puts "User #{user.uid} has no university ID"
      ldap_user = Ldap.find_by_netid(user.uid)
      if ldap_user
          user.update(:university_id, ldap_user[:universityid].first)
          puts "Updated user #{netid} with university ID #{ldap_user[:universityid].first}"
      else
        puts "User #{user.uid} not found in LDAP"
      end
    end
  end
end
