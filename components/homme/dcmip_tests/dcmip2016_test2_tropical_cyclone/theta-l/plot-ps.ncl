;***********************************************
; plot_supercell_wvel.ncl
;
; Version 1.0
;***********************************************

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"  

begin

;****************************************************************************
; DO NOT EDIT ABOVE THIS LINE
;****************************************************************************
; Read in data and store as follows:
;
;   Output:
;     maxw(time)
;     time series maximum vertical velocity (units m/s)
;
;     time_s(time)
;     time of each sample (units s)
;
;   Dimensions:
;     time:  arbitrary
;----------------------------------------------------------------------------

  min_ps  = asciiread("./measurement_psmin.txt", -1, "double")
  time_s  = asciiread("./measurement_time.txt", -1, "double")

print("min_ps    ="+min_ps)
print("time_s="+time_s)

;****************************************************************************
; DO NOT EDIT BELOW THIS LINE
;****************************************************************************

;------------------------------------------------
; Workspace
;------------------------------------------------
  wks = gsn_open_wks("pdf","min_ps")

;------------------------------------------------
; Plot resources [options]
;------------------------------------------------
; Resources:
  res                     = True

  res@gsnDraw             = False
  res@gsnFrame            = False

  res@vpKeepAspect        = True
  res@vpWidthF            = 0.8
  res@vpHeightF           = 0.6
  res@gsnMaximize         = True
  res@gsnPaperOrientation = "portrait"

  res@tmXBLabelsOn      = True
  res@tmXBOn            = True

  res@tmXTLabelsOn      = False
  res@tmXTOn            = False

  res@tmXBMinorOn       = True
  res@tmYLMinorOn       = True

  res@xyLineThicknessF  = 2.0
;  res@xyMarkLineMode    = "MarkLines"

  resw = res

;------------------------------------------------
; Vertical velocity plot
;------------------------------------------------

  resw@tiXAxisOn = True
  resw@tiXAxisString = "time (days)"

  resw@tiYAxisOn = True
  resw@tiYAxisString = "minimum surface pressure (hPa)"

;  resw@trXMinF = 0.0
;  resw@trXMaxF = 120.0 ;7200.0 ; max(time_s)
  
; resw@trYMinF = 0.0
;  resw@trYMaxF = ymax

;  resw@tmXBMode = "Manual"
;  resw@tmXBTickStartF   = 0.0
;  resw@tmXBTickEndF     = 120 ;7200.0
;  resw@tmXBTickSpacingF = 20 ;1800.0

;  resw@tmYLMode = "Explicit"
;  resw@tmYLTickStartF = 0.0
;  resw@tmYLTickEndF = 50.0

  plot = gsn_csm_xy(wks, time_s/3660.0/24, min_ps/100.0, resw)

;------------------------------------------------
; Panel plot
;------------------------------------------------

  pres = True
  pres@gsnPanelBottom = 0.1
  pres@gsnPanelTop = 0.9
  pres@gsnPanelYWhiteSpacePercent = 5
  pres@gsnPanelXWhiteSpacePercent = 5
  gsn_panel(wks, plot, (/1,1/), pres)

end

