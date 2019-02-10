# coding: utf-8
require 'digest/md5'

# Liste des passwords en MD5
$password_list = ['88faf21d7683c18b3fdb30928110f8da','aeb586ac03a1d0a5b295a9179a474b3c','bc752b2ea8cc392102e0c1862ed02922','bdd798531152c2dd6f069856b7175ead','50046704613df1356ab6f585a7165ba3','6ab68f3a93ebe465a1e60c83f15cacc2','b124bae9773ce0dca46f040b5e121870','723abaadfc4a5d7cad4d8bed78f6ba7d','38f9969db9571de675bd53a92eacd56c','58c4e7591e9924ac2b680f32367af787','faf727b65e18771084717e100efaa433','f3ae993f81259cc366d31a007559a28e','528b14f0ff9b498d3ae97693e6849b32','eceb6c4f0ffae7ce75499784016e68bd','4dafe193731dfc3933682cf593c49142']

$size_max = 1

def cracking(alphabet, password)
  #On return quand on arrive à size_max pour utiliser un autre symbol de alphabet
  if (password.length == $size_max)
    return
  else
    alphabet.split('').each do |symbol|
      new_password = password + symbol
      # On test chaque mot de passe pour voir si il est dans la liste
      $password_list.each do |hash|
        if(Digest::MD5.hexdigest(new_password) == hash)
          puts "Password : #{new_password} | MD5: #{hash}"
        end
      end
      cracking(alphabet, new_password)
    end
  end
end

# size_max est incrémenter pour pouvoir explorer toutes
# les possibiliés selon les tailles de plus en plus grande

puts "Programme réalisé par Remi GIACOMETTI & Quentin BAUDET suivant la liste n°15 des mots de passe."
8.times.each do
  puts "Les mots de passe de taille #{$size_max} sont en cours d'évaluation"
  cracking("abcdefghijklmnopqrstuvwxyz0123456789!@\#$%&*", "")
  $size_max += 1
end
