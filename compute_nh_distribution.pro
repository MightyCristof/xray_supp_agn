PRO compute_nh_distribution


common _det_wac
common _agnlum
common _quality
common _lum_ratio


;; NH distribution from all detections/non-detections
nhxdet = ll2nh(llxdet,'2-10')
nhxnon = ll2nh(llxnon,'2-10')

binsz = 0.2
;binsz = freedman(nhdet[where(iiagn_det)])

yhist_det = histogram(nhxdet[where(iiagn_det)],locations=xhist_det,bin=binsz)
yhist_non = histogram(nhxnon[where(iiagn_non)],locations=xhist_non,bin=binsz)

xhist_det = [xhist_det[0]-binsz,xhist_det,xhist_det[-1]+binsz]
xhist_non = [xhist_non[0]-binsz,xhist_non,xhist_non[-1]+binsz]
yhist_det = [0.,yhist_det,0.]
yhist_non = [0.,yhist_non,0.]

sav_vars = ['BINSZ','NHXDET','NHXNON', $
                    'YHIST_DET','XHIST_DET','YHIST_NON','XHIST_NON']
sav_inds = []

;; construct distributions by type WAC/Remaining
;; indices of WISE AGN detections/non-detections
iiwdet = iiagn_det and iidet_wac
iiwnon = iiagn_non and iidet_wac
;; indices of remaining detections/non-detections
iirdet = iiagn_det and ~iidet_wac
iirnon = iiagn_non and ~iidet_wac

yhist_wdet = histogram(nhxdet[where(iiwdet)],locations=xhist_wdet,bin=binsz)
yhist_wnon = histogram(nhxnon[where(iiwnon)],locations=xhist_wnon,bin=binsz)
yhist_rdet = histogram(nhxdet[where(iirdet)],locations=xhist_rdet,bin=binsz)
yhist_rnon = histogram(nhxnon[where(iirnon)],locations=xhist_rnon,bin=binsz)


xhist_wdet = [xhist_wdet[0]-binsz,xhist_wdet,xhist_wdet[-1]+binsz]
xhist_wnon = [xhist_wnon[0]-binsz,xhist_wnon,xhist_wnon[-1]+binsz]
xhist_rdet = [xhist_rdet[0]-binsz,xhist_rdet,xhist_rdet[-1]+binsz]
xhist_rnon = [xhist_rnon[0]-binsz,xhist_rnon,xhist_rnon[-1]+binsz]
yhist_wdet = [0.,yhist_wdet,0.]
yhist_wnon = [0.,yhist_wnon,0.]
yhist_rdet = [0.,yhist_rdet,0.]
yhist_rnon = [0.,yhist_rnon,0.]


sav_vars = [sav_vars,'YHIST_WDET','XHIST_WDET','YHIST_WNON','XHIST_WNON', $
                     'YHIST_RDET','XHIST_RDET','YHIST_RNON','XHIST_RNON']
sav_inds = [sav_inds,'IIWDET','IIWNON','IIRDET','IIRNON']


sav_str = strjoin([sav_vars,sav_inds],',')
re = execute('save,'+sav_str+',/compress,file="nh_dist.sav"')


END




