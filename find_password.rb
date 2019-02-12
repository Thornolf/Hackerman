# coding: utf-8
require 'digest/md5'

# Liste des passwords en MD5
$password_list = ['88faf21d7683c18b3fdb30928110f8da','aeb586ac03a1d0a5b295a9179a474b3c','bc752b2ea8cc392102e0c1862ed02922','bdd798531152c2dd6f069856b7175ead','50046704613df1356ab6f585a7165ba3','6ab68f3a93ebe465a1e60c83f15cacc2','b124bae9773ce0dca46f040b5e121870','723abaadfc4a5d7cad4d8bed78f6ba7d','38f9969db9571de675bd53a92eacd56c','58c4e7591e9924ac2b680f32367af787','faf727b65e18771084717e100efaa433','f3ae993f81259cc366d31a007559a28e','528b14f0ff9b498d3ae97693e6849b32','eceb6c4f0ffae7ce75499784016e68bd','4dafe193731dfc3933682cf593c49142']

$alphabet = "abcdefghijklmnopqrstuvwxyz0123456789!@\#$%&*"

# size_max est incrémenter pour pouvoir explorer toutes
# les possibiliés selon les tailles de plus en plus grande

$size_max = 1

def dictionnary(list)
  items_found = Array.new
  File.open("mots-8-et-moins.txt").each do |line|
    list.each_with_index do |hash, index|
      if(Digest::MD5.hexdigest(line.strip) == hash)
        items_found.push(hash)
        puts line.strip + " = " + hash
      end
    end
  end
  return items_found
end

def enumeration(password = "", list)
  #On return quand on arrive à size_max pour utiliser un autre symbol de alphabet
  if (password.length == $size_max)
    return
  else
    $alphabet.split('').each do |symbol|
      new_password = password + symbol
      # On test chaque mot de passe pour voir si il est dans la liste
      list.each do |hash|
        if(Digest::MD5.hexdigest(new_password) == hash)
          puts "Before : #{$password_list}\n"
          $password_list.delete(hash)
          puts "After : #{$password_list}\n"
          puts "Password : #{new_password} | MD5: #{hash}"
        end
      end
      enumeration(new_password, list)
    end
  end
end


puts "Programme réalisé par Remi GIACOMETTI & Quentin BAUDET suivant la liste n°15 des mots de passe.\n"
puts "Recherche des mots de passe via une attaque par dictionnaire :\n\n"
password_founded = dictionnary($password_list)
puts "\nOn enlève les mots de passe trouvé de la liste.\nEt on relance la recherche avec une attaque par énumération: \n\n"

8.times.each do
  puts "Les mots de passe de taille #{$size_max} sont en cours d'évaluation"
  #On soustrait password_list à password_founded pour réduire le temps de recherche
  enumeration($password_list - password_founded)
  $size_max += 1
end
