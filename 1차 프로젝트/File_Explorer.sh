#!/bin/bash

# TITLE
TITLE() {
tput civis
tput setab 6
tput setaf 0
tput cup 0 0
echo "File Explorer                                                     2015405060_OSC"
}
TITLE



# UI
UI() {
tput sivis
tput setab 7
tput cup 1 0
echo "--------------------------------------------------------------------------------"
tput cup 2 0
echo "|                                                                              |"
tput cup 3 0
echo "--------------------------------------------------------------------------------"

for (( i = 4; i<29; i++ ))
do
    tput cup $i 0
    echo "|                                      |                                       |"
done

tput cup 29 0
echo "--------------------------------------------------------------------------------"
tput cup 30 0
echo "|                                                                              |"
tput cup 31 0
echo "--------------------------------------------------------------------------------"
}
UI



# 현재 경로 출력
show_pwd() {
tput setaf 5
tput cup 2 1
echo "Current path: `pwd`"

}
show_pwd



#현재 경로의 파일 출력
file_show() {

        ls_lahs=($(ls -lahs))          # ls -lahs 명령어를 배열에 초기화
        ls_lahs[2]="-"
        ls_lahs[12]="-"
        l=4                            #입력할 행의 위치

        #디렉토리 출력
        for(( i=3; i<203; i+=10 ))
        do
                if [ "${ls_lahs[$i]:0:1}" = "d" ]; then
                    tput setaf 4
                    tput cup $l 1
                    echo ${ls_lahs[$i+8]}
                    tput cup $l 18
                    echo ${ls_lahs[$i]}
                    tput cup $l 33
                    echo ${ls_lahs[$i - 1]}
                    ls_home[$l]=$l
                    ls_home[$l+20]=${ls_lahs[$i+8]}
                    ls_home[$l+40]=${ls_lahs[$i]}
                    ls_home[$l+60]=${ls_lahs[$i - 1]}

                    l=`expr $l + 1`
                fi
        done
        #실행파일 출력
        for (( i=3; i<203; i+=10 ))
        do
                if [ "${ls_lahs[$i]:0:1}" = "-" -a "${ls_lahs[$i]:3:1}" = "x" ]; then
                    tput cup $l 1
                    tput setaf 2
                    echo ${ls_lahs[$i+8]}
                    tput cup $l 18
                    echo ${ls_lahs[$i]}
                    tput cup $l 33
                    echo ${ls_lahs[$i - 1]}
                    ls_home[$l]=$l
                    ls_home[$l+20]=${ls_lahs[$i+8]}
                    ls_home[$l+40]=${ls_lahs[$i]}
                    ls_home[$l+60]=${ls_lahs[$i - 1]}

                    l=`expr $l + 1`
                fi
        done
        #일반파일 출력
        for (( i=3; i<203; i+=10 ))
        do
                if [ "${ls_lahs[$i]:0:1}" = "-" -a "${ls_lahs[$i]:3:1}" = "-" ]; then
                    tput cup $l 1
                    tput setaf 0
                    echo ${ls_lahs[$i+8]}
                    tput cup $l 18
                    echo ${ls_lahs[$i]}
                    tput cup $l 33
                    echo ${ls_lahs[$i - 1]}
                    ls_home[$l]=$l
                    ls_home[$l+20]=${ls_lahs[$i+8]}
                    ls_home[$l+40]=${ls_lahs[$i]}
                    ls_home[$l+60]=${ls_lahs[$i - 1]}

                    l=`expr $l + 1`
                fi
        done
}
file_show




# 디렉토리 파일 수 출력, 총 용량 출력
dfc_show() {
        tput setaf 0
        tput cup 30 6
        echo "Directory : `ls -l | grep ^d | wc -l`  File : `ls -l | grep ^- | wc -l`      Current Directory Size : `du -sh 2>/dev/null |cut -d$'\t' -f 1`" 
}
dfc_show




#Tree 구현
tree_show() {

    ls_l=($(ls -l))
    tput setaf 4
    tput cup 4 41
    pwd | rev | cut -d '/' -f 1 | rev

    val=5

    for (( i=2; i<164; i+=9 ))     # 디렉토리
         do
            if [ ${val} -gt 28 ]; then
                break
            else
                if [ "${ls_l[$i]:0:1}" = "d" ]; then
                   tput setaf 0
                   tput cup $val 41
                   echo "├"
                   tput setaf 4
                   tput cup $val 43
                   echo ${ls_l[$i+8]}
                   val=`expr $val + 1`

                   cd ${ls_l[$i+8]}  # 하위파일 진입
                    ls_se=($(ls -l))
                     for (( j=2; j<164; j+=9 ))
                        do
                           if [ ${val} -gt 28 ]; then
                               break
                             else
                               if [ "${ls_se[$j]:0:1}" = "d" ]; then
                               tput setaf 0
                               tput cup $val 41
                               echo "│"
                               tput cup $val 43
                               echo "└"
                               tput setaf 4
                               tput cup $val 45
                               echo ${ls_se[$j+8]}
                               val=`expr $val + 1`
                              

                               cd ${ls_se[$j+8]}       # Enter under

                               ls_te=($(ls -l))
                                 for (( k=2; k<164; k+=9 ))
                                  do
                                     if [ ${val} -gt 28 ]; then
                                        break
                                     else
                                       if [ "${ls_te[$k]:0:1}" = "d" ]; then
                                        tput setaf 0
                                        tput cup $val 41
                                        echo "│"
                                        tput cup $val 43
                                        echo "│"
                                        tput cup $val 45
                                        echo "└"
                                        tput setaf 4
                                        tput cup $val 47
                                        echo ${ls_te[$k+8]}
                                        val=`expr $val + 1`
                                      

                                      cd ${ls_te[$k+8]}       #Enter

                                  ls_de=($(ls -l))
                                  for (( h=2; h<164; h+=9 ))
                                  do
                                  if [ ${val} -gt 28 ]; then
                                   break
                                  else
                                   if [ "${ls_de[$h]:0:1}" = "d" ]; then
                                        tput setaf 0
                                        tput cup $val 41
                                        echo "│"
                                        tput cup $val 43                  
                                        echo "│"
                                        tput cup $val 45
                                        echo "│"
                                        tput cup $val 47
                                        echo "└"
                                        tput setaf 4
                                        tput cup $val 49
                                        echo ${ls_de[$h+8]}
                                        val=`expr $val + 1`
                                        else
                                            continue
                                        fi
                                      fi
                                   done


                                 for (( h=2; h<164; h+=9 ))
                                 do
                                     if [ ${val} -gt 28 ]; then
                                        break
                                     else
                                        if [ "${ls_de[$h]:0:1}" = "-" -a "${ls_de[$h]:3:1}" = "x" ]; then
                                         tput setaf 0
                                         tput cup $val 41
                                         echo "│"
                                         tput cup $val 43
                                         echo "│"
                                         tput cup $val 45
                                         echo "│"
                                         tput cup $val 47
                                         echo "└"
                                         tput setaf 2
                                         tput cup $val 49
                                         echo ${ls_de[$h+8]}
                                         val=`expr $val + 1`
                                        else
                                         continue
                                        fi
                                     fi
                                 done
                                 
                                 for (( h=2; h<164; h+=9 ))
                                 do
                                     if [ ${val} -gt 28 ]; then
                                        break
                                     else
                                        if [ "${ls_de[$h]:0:1}" = "-" -a "${ls_de[$h]:3:1}" = "-" ]; then
                                         tput setaf 0
                                         tput cup $val 41
                                         echo "│"
                                         tput cup $val 43
                                         echo "│"
                                         tput cup $val 45
                                         echo "│"
                                         tput cup $val 47
                                         echo "└"
                                         tput setaf 2
                                         tput cup $val 49
                                         echo ${ls_de[$h+8]}
                                         val=`expr $val + 1`
                                        else
                                         continue
                                        fi
                                     fi
                                 done


                         cd ..  # return

#
                                       else
                                           continue
                                       fi
                                     fi
                                   done

#

                                 for (( k=2; k<164; k+=9 ))
                                 do
                                     if [ ${val} -gt 28 ]; then
                                        break
                                     else
                                        if [ "${ls_te[$k]:0:1}" = "-" -a "${ls_te[$k]:3:1}" = "x" ]; then
                                         tput setaf 0
                                         tput cup $val 41
                                         echo "│"
                                         tput cup $val 43
                                         echo "│"
                                         tput cup $val 45
                                         echo "└"
                                         tput setaf 2
                                         tput cup $val 47
                                         echo ${ls_te[$k+8]}
                                         val=`expr $val + 1`
                                        else
                                         continue
                                        fi
                                     fi
                                 done

                                 for (( k=2; k<164; k+=9 ))
                                 do
                                     if [ ${val} -gt 28 ]; then
                                        break
                                     else
                                        if [ "${ls_te[$k]:0:1}" = "-" -a "${ls_te[$k]:3:1}" = "-" ]; then
                                         tput setaf 0
                                         tput cup $val 41
                                         echo "│"
                                         tput cup $val 43
                                         echo "│"
                                         tput cup $val 45
                                         echo "└"
                                         tput setaf 0
                                         tput cup $val 47
                                         echo ${ls_te[$k+8]}
                                         val=`expr $val + 1`
                                        else
                                         continue
                                        fi
                                     fi
                                 done                                


                             cd ..  # return
#
                                       else
                                        continue
                                       fi
                                     fi
                                    
                                 done
                        
                       for (( j=2; j<164; j+=9 ))     # 하위 실행파일
                          do
                            if [ ${val} -gt 28 ]; then
                                break
                            else
                                if [ "${ls_se[$j]:0:1}" = "-" -a "${ls_se[$j]:3:1}" = "x" ]; then
                                 tput setaf 0
                                 tput cup $val 41
                                 echo "│"
                                 tput cup $val 43
                                 echo "└"
                                 tput setaf 2
                                 tput cup $val 45
                                 echo ${ls_se[$j+8]}
                                 val=`expr $val + 1`
                              else
                                continue
                                fi
                            fi
                        done
                        
                        for (( j=2; j<164; j+=9 ))     # 하위  일반파일
                           do
                             if [ ${val} -gt 28 ]; then
                                break
                             else
                                if [ "${ls_se[$j]:0:1}" = "-" -a "${ls_se[$j]:3:1}" = "-" ]; then
                                 tput setaf 0
                                 tput cup $val 41
                                 echo "│"
                                 tput cup $val 43
                                 echo "└"
                                 tput setaf 0
                                 tput cup $val 45
                                 echo ${ls_se[$j+8]}
                                 val=`expr $val + 1`
                             else
                                 continue
                                fi
                             fi
                        done
                   
                      
                     cd .. # 상위 파일로 복귀
                else
                   continue
                fi
             fi
         done

    for (( i=2; i<164; i+=9 ))     # 실행파일
         do
            if [ ${val} -gt 28 ]; then
                break
            else
                if [ "${ls_l[$i]:0:1}" = "-" -a "${ls_l[$i]:3:1}" = "x" ]; then
                   tput setaf 0
                   tput cup $val 41
                   echo "├"
                   tput setaf 2
                   tput cup $val 43
                   echo ${ls_l[$i+8]}
                   val=`expr $val + 1`
                else
                    continue
                fi
             fi
         done

    for (( i=2; i<164; i+=9 ))     # 일반파일
         do
            if [ ${val} -gt 28 ]; then
                break
            else
                if [ "${ls_l[$i]:0:1}" = "-" -a "${ls_l[$i]:3:1}" = "-" ]; then
                   tput setaf 0
                   tput cup $val 41
                   echo "├"
                   tput setaf 0
                   tput cup $val 43
                   echo ${ls_l[$i+8]}
                   val=`expr $val + 1`
                else
                    continue
                fi
             fi
         done

}
tree_show



#방향키,커서,엔터 구현
w=4
h=40
xlim=`expr $lim * 4`

while :
do
        lim=`expr $l - 2`
        wr=5
         tput civis
         TITLE
         UI
         show_pwd
         file_show
         dfc_show
         tree_show 
         tl=`expr $val - 2`

        tput cup $w 1

        for (( i=4; i<25; i++ ))
        do
        if [ ${ls_home[$i]} == $w ]; then
         if [ "${ls_home[$i+40]:0:1}" = "d" ]; then
         tput setab 4
         echo "                                      "
         tput setaf 7
         tput cup $w 1
         echo ${ls_home[$i+20]}
         tput cup $w 18
         echo ${ls_home[$i+40]}
         tput cup $w 33
         echo ${ls_home[$i+60]}
         tput setaf 0
         break
         elif [ "${ls_home[$i+40]:0:1}" = "-" -a "${ls_home[$i+40]:3:1}" = "x" ]; then
         tput setab 2
         echo "                                      "
         tput setaf 7
         tput cup $w 1
         echo ${ls_home[$i+20]}
         tput cup $w 18
         echo ${ls_home[$i+40]}
         tput cup $w 33
         echo ${ls_home[$i+60]}
         tput setaf 0
         break
         elif [ "${ls_home[$i+40]:0:1}" = "-" -a "${ls_home[$i+40]:3:1}" = "-" ]; then
         tput setab 0
         echo "                                      "
         tput setaf 7
         tput cup $w 1
         echo ${ls_home[$i+20]}
         tput cup $w 18
         echo ${ls_home[$i+40]}
         tput cup $w 33
         echo ${ls_home[$i+60]}
         tput setaf 0
         break
         fi
         fi
         done

        read -sn 3 key

        if [ "$key" = "[A" ]; then
           if [ $w -lt 5 ]; then
              continue
           else
              w=`expr $w - 1`
           fi


        elif [ "$key" = "[B"  ]; then
           if [ $w -gt $lim ]; then
              continue
           else
              w=`expr $w + 1`
           fi

       elif [ "$key" = "[C" ]; then
         wr=5 
         TITLE
         UI          
         show_pwd
         file_show
         dfc_show
         tree_show
         tl=`expr $val - 2`

         tput cup $wr 70
         tput setaf 1
         echo '<-'
         tput setaf 0
         until [ "$key" == "[D" ];
         do
         read -sn 3 key
           if [ "$key" = "[A" ]; then
              if [ $wr -lt 6 ]; then
                 continue
              else
                 TITLE
                 UI
                 show_pwd
                 file_show
                 dfc_show
                 tree_show
                 wr=`expr $wr - 1`
                 tput civis
                 tput cup $wr 70
                 tput setaf 1
                 echo '<-'
                 tput setaf 0
              fi
           elif [ "$key" = "[B" ]; then
                if [ $wr -gt $tl ]; then
                   continue
                else
                   TITLE
                   UI
                   show_pwd
                   file_show
                   dfc_show
                   tree_show 

                   wr=`expr $wr + 1`
                   tput cup $wr 70
                   tput setaf 1
                   echo '<-'
                   tput setaf 0                           
                 fi
            fi
            done

           elif [ "$key" = "[D" ]; then
                 continue;

           else
              for (( i=4; i<24; i++ ))
               do
               if [ "${ls_home[$i]}" == "$w" ];then
                if [ "${ls_home[$i+40]:0:1}" = "d" ]; then
                 cd ${ls_home[$i+20]}
                 w=4
                fi
               else
                continue
               fi
              done
        fi
done
