@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul

title æ€'s reader module version %ver% do not modify.

set "parse_on=//:n:\\"

set "ver=0.1.5"

if "%~1"=="/ver" (
echo %ver%
exit
)

if "%~1"=="/?" (
echo # This software is a module designed for artificial intelligence implemented through batch. No other modules are used within this module. 
echo You can use this module as follows:
echo This module that can read specific type of data structure , like :
echo ^+^+"Layer" ^<-- ^(the layer name^)
echo :^[ ^<-- ^(cluster start parameter^) ^{"Cluster"^} ^<-- ^(cluster name^)
echo Info inside a cluster. ^<-- ^(Your Info^) ^#0001 ^<-- ^(your tag here^)
echo ^]: ^<-- ^(End of the cluster parameter which should be added for a correct data structure.^)
echo --End ^<-- ^(end of the current layer^)
echo Enviromental rules that MUST be obeyed for order:
echo - Layers can contain multiple clusters.
echo - Clusters can contain multiple data's.
echo - Please provide the individual layer names enclosed in quotes that need to be read for special layer recognition input.
echo - Please provide the individual cluster names enclosed in quotes that need to be read for special cluster recognition input.
echo - Data can contain only 1 tag.
echo - Layer cannot contain a layer inside.
echo - Cluster cannot contain a cluster inside.
echo - Except data NOTHING can contain "!" and "%" signs. Meaning layers , clusters and tags can't contain "%" and "!".
echo - Every data should contain a tag.
echo - Tag have a range of 4 steps. Using integer is not necessary but recomended.
echo - To make a data visable you have to make it have a tag which inside a cluster and that cluster inside a layer. 
echo - Tag must be inside every data and it must be at the last 5 steps. Example: Here is my data! ^#0001 ^<--- 
echo - The first step of the tag MUST be "^#" .
echo  ALL enviromental rules above must be obeyed too.
echo  ALL enviromental rules above must be obeyed too.
echo  These are the rules of the module.
echo More and more updates will come soon.
echo Dont forget that this is a module that re-designed for users use.
echo Calling parameter ability :
echo Call Reader64bytes.bat "File that is going to be read here" "Layers that is going to be read here" "Clusters that is going to be read here" "Tags that is going to be read here"
echo ^# The usage of this module is completely free and open to everyone. 
echo ^# If you have taken this project to use in any of your other projects, please don't forget to share my GitHub username. ^(aeE011000010110010101000101^)
echo ^# If you find any errors or deficiencies, I would be very happy to hear about them.
exit /b
)

echo Reader module incorporated with an ai.
echo Do not modify. Version %ver%

if "%~1"=="" (
    set /p readpath="File path?: "
	set /p special_layer="Any special layer you want to read?: "
    set /p special_cluster="Any special cluster you want to read?: "
    set /p special_tag="Any special tag you want to read?: "
) ELSE (
 set "readpath=%~1"
 set "special_layer=%~2"
 set "special_cluster=%~3"
 set "special_tag=%~4"
)

if "%readpath%"=="" (
    echo Enter a valid path.
    pause
    exit
) ELSE (
if NOT EXIST "%readpath%" (
    echo Enter a valid path.
    pause
    exit
 )
)

set "current_layer="
set "current_cluster_name="
set "layer_started=false"
set "cluster_started=false"
set "ndata_structureallowance=false"
set "unread.ndata=0"

for /f "tokens=*" %%A in ('findstr /n "^" %readpath%') do (
    
    set "value1="
    set "value2="
    set "line=%%A"
    set "process_code=false"
	set "mytag_="
	set "mytag__="

    set /a at_line+=1

    if !at_line! LEQ 9 (
        set "line=!line:~2!"
    ) ELSE (
        if !at_line! LEQ 99 (
            set "line=!line:~3!"
        ) ELSE (
            if !at_line! LEQ 999 (                        
                set "line=!line:~4!"
            ) ELSE (
                if NOT "!at_line!"=="1000" (
                    cls
                    echo SCRIPT HALT!
                    echo ARE YOU CRAZY?!
                    echo ISN'T 999 LINES ARE ENOUGH HUH???                                        REM If you are here to ask me why I did this freaking lazy if staments here is the explanation:
                    echo FUNCTION ERROR: CANNOT ENTER MORE THAN 999 LINES OF STRINGS!             REM instead of using "tokens=2* delims=:" I used this because the machine dont count empty lines as a line,
                    pause > nul                                                                   REM AND because that parameter would destroy line number specificion , that would cause empty lines
                    exit /b                                                                       REM to be ignored which would instantly corrupted the line count system. 
                )
            )
        )
    )
	
    for /l %%B in (0,1,512) do (
        if "!line:~0,1!"==" " (
            set "line=!line:~1!"
        )
        if "!line:~0,-1!"==" " (
            set "line=!line:~0,-1!"
        )
    )

    if NOT "!line!"=="" (
        if "!line:~0,2!"=="++" (
            set "process_code=true"
            for %%T in (!special_layer!) do (
                if "%%~T"=="!line:~3,-1!" (
                    set "value1=true"  
                )
			)	
                if NOT "!value1!"=="true" (
                    set "ndata_structureallowance_type_layer=-"    
                )
                if NOT "!layer_started!"=="true" (
                    set "layer_started=true"
                    set "current_layer=!line:~3,-1!"
                    echo Layer : !current_layer!
                ) ELSE (
                    echo Function error : Cannot use a layer while a layer is already started.
                    echo Function error at line "!at_line!", you can solve this error by removing that useless layer start parameter.
                    pause
                    exit /b
                )
        ) else (
            if "!line:~0,2!"==":[" (
                set "process_code=true"
                for %%C in (!special_cluster!) do (
                    if "%%~C"=="!line:~5,-2!" (
                        set "value2=true"
                    )
				)
                    if NOT "!value2!"=="true" (
                        set "ndata_structureallowance_type_cluster=-"
                    )
                    if NOT "!cluster_started!"=="true" (
                        set "cluster_started=true"
                        set "current_cluster_name=!line:~5,-2!"
                        echo Layer: !current_layer! includes !current_cluster_name! cluster.
                    ) ELSE (
                        echo Function error: Cannot use a cluster head parameter while it is already started.
                        echo Function error at "!at_line!", do not make our clusters sad.
                        echo You can fix it by removing the useless head parameter.
                        pause
                        exit /b
                    )
                
            ) else (
                if "!line:~0,2!"=="]:" (
                    set "process_code=true"
                    if "!ndata_structureallowance_type_cluster!"=="-" (
                        set "ndata_structureallowance_type_cluster="
                    )
                    if NOT "!cluster_started!"=="false" (
                        set "cluster_started=false"
                        echo Layer: !current_layer! that included !current_cluster_name! cluster ended.
                        set "rigidbody.allwanted=!rigidbody.allwanted!set "!current_layer!_!current_cluster_name!=!my_current!" "
						set "current_cluster_name="
						set "my_current="
                    ) ELSE (
                        echo Function error: Cannot use an end parameter without a start parameter.
                        echo Function error at line "!at_line!". Don't forget, clusters come in pairs.
                        echo You cannot use one without the other.
                        pause
                        exit /b
                    )
                ) else (
                    if "!line!"=="--End" (
                        set "process_code=true"
                        if "!ndata_structureallowance_type_layer!"=="-" (
                            set "ndata_structureallowance_type_layer="
                        )
                        if NOT "!layer_started!"=="false" (
                            set "layer_started=false"
                            echo Layer: !current_layer! ended.
                            set "current_layer="
                        ) ELSE (
                            echo Function error: Cannot end a layer while it is already ended.
                            echo Function error at line "!at_line!", you can consider removing that line.
                            echo Errorful line : !line! .
                            pause
                            exit /b
                        )
                    ) else (
                        if NOT "!process_code!"=="true" (
                            if "!current_layer!" neq "" (
                                if "!current_cluster_name!" neq "" (
                                    echo Layer: !current_layer! includes !current_cluster_name! cluster includes data: !line:~0,-5!
                                    if "!ndata_structureallowance_type_layer!"=="" (
									 if "!ndata_structureallowance_type_cluster!"=="" (
                                       for %%D in (!special_tag!) do (
									     if "%%D"=="!line:~-5!" (				 
										 set "mytag_=!line:~-5!" 
										 set "mytag__=true" 
										  ) 
										 )
							     	   if "!mytag__!"=="true" (
										if "!mytag_:~0,1!"=="#" (
     									   set "my_current=!my_current!!line:~0,-5! !parse_on! "								     	  									  
										  ) ELSE (
										  echo ERROR: FALSE STRUCTURING DATA IS NOT ACCEPTED! 
										  echo ERROR: TAG IS NOT IN USE!
										  echo Line : !at_line! 									  
										     )
										  ) ELSE (
										    echo ERROR : Tag is wrong or no tag is used!
											echo !at_line! might be consisting an error , we suggest you go check it.
										     )										  
										  ) ELSE (
										    echo ERROR: FALSE STRUCTURING DATA IS NOT ACCEPTED! 
                                            echo ERROR.SHELL.STRUCTURE:CLUSTER
                                            echo !at_line! definitly consists an error you might want to check :^)											
										  )
										) ELSE (
										echo ERROR: FALSE STRUCTURING, DATA IS NOT ACCEPTED!
										echo ERROR.SHELL:CLUSTER
										echo !at_line! consists an annoying error which you might want to check like all the time :,^)
										)
                                    ) ELSE (
									    echo ERROR: FALSE STRUCTURING, DATA IS NOT ACCEPTED!
										echo ERROR.SHELL:NONEXISTENT.CLUSTER
										echo !at_line! just consists an error... Go check it okay? 
									)
                                ) else (
                                    echo Layer: !current_layer! includes an unnamed cluster inside, data of cluster: !line!
                                    echo ERROR: FALSE STRUCTURING, NO CLUSTER INCLUDED TO THIS DATA , IT IS NOT ACCEPTED.
									echo Well it knows his country not his home town! Oh and he is in !at_line! by the way.
                                )
                            ) else (
                                if "!current_cluster_name!" neq "" (
                                    echo Unnamed layer, the current file includes !current_cluster_name! cluster includes data: !line!
                                    echo ERROR: FALSE STRUCTURING, DATA IS NOT ACCEPTED.
									echo Why'd it mattered if you'd know your home town while you dont know your REGION!? Confused data is at the line : !at_line!
                                ) else (
                                    echo Unnamed layer, the current file includes an unnamed cluster inside, data of cluster: !line!
                                    echo ERROR: FALSE STRUCTURING, DATA IS NOT ACCEPTED.
									echo The regionless data is at the line : !at_line!
                                )
                            )
                        )
                    )
                )
            )
        )
    )
)

if "!layer_started!"=="true" (
    echo Function error: Cannot complete the structuring process without ending the layer.
    echo Function error at "!at_line!", you can end the lonely !current_layer! named layers suffering...
    echo Forever... Alone...
    echo Errorful line : !line!
    pause
    exit /b
)

if "!cluster_started!"=="true" (
    echo Function error: Cannot complete the structuring process without ending the cluster.
    echo Function error at "!at_line!", you can end the lonely !current_cluster_name! named clusters suffering...
    echo Forever... Alone...
    pause
    exit /b
)

endlocal & set "transfered.data=%rigidbody.allwanted%"
echo %transfered.data%
pause

