Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC8C352E93
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhDBRkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:40:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52980C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:40:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so5336715wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bOVEsMEEKHgEn+kcOO6h2vGODl02flAX5WTE4ztr3ZQ=;
        b=AR9pwFqrRZ6xixYs+EfUY462axx1V8+727fcOm2LkUE+dOsrPQmd0GZmXu/VHWxlAq
         Er8M+DSvZ65GvDRXSEnTB/CUMjqwrilfFiWZuIvoTJoQLFYQssGeHDosa4j1nFq2RK8S
         HvkkkVhWUqAzcvk+HNrMk1fjznVt/6GG0Vy2ma2fgkwsvrOwfF8SurpE3ks/7ToTR91R
         PeJZqUreMG1YEXMbV74j8SQEgMJcGPX4zvs4SriOpymrHtrACiRom9swDTj+jifRskJI
         CrBy4TBhMFAvXKLSsrzC0wJ2xqPDpxEGUFeVajgWYfDvHrif3z51hq/gDOLZ2sElnKVf
         LLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bOVEsMEEKHgEn+kcOO6h2vGODl02flAX5WTE4ztr3ZQ=;
        b=I7abbeGwLldNQnTzn4H9bwAiESGuuUnX6BqUdD5E4wiahNiqNSqTVOG6VL9ZkYC1Mm
         MLKWxRMFRIJ15uBA3qPsV9ofZvKK7/PwbtOneN1olofx5nrI+ksOENC4PwO6jQYC7Zt4
         t2YS68xq5/zHCQ070GAQlbkVBG6QcCcHW97NO15j3dEuf8p4HepDjS98y7gIKwrH5cht
         U9kHJXNF+D/NPTPg2fdkdTzd5E6h0tVxWlNkExR1iPvyl1ouhC+U4f2Y2E2shjm5dJc6
         9FKN/fOccIORutGsby4uVlKS2/3kTgMGCAIhnw17hAhA4inqdNnnVRGcT8Upt3icZcVp
         G/TQ==
X-Gm-Message-State: AOAM531wxHXhjlC9LhqP1/tlKQ6Vc6NVj6mcb4pLNTqZs4xFYMvpjhZY
        fSrsFas5k2uns6dvjyCyJ84=
X-Google-Smtp-Source: ABdhPJzAkAazfeE8Zpz8kLaDxDlF0XIdJx801GJOiy2aoGzN5ksbTB5f+xxsFXjBR1AQ4M8N7kmmyA==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr16287890wru.381.1617385208446;
        Fri, 02 Apr 2021 10:40:08 -0700 (PDT)
Received: from agape.jhs ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id u2sm17029856wmm.5.2021.04.02.10.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:40:07 -0700 (PDT)
Date:   Fri, 2 Apr 2021 19:40:04 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/16] staging: rtl8723bs: remove all RT_TRACE logs in
 core/rtw_wlan_util.c
Message-ID: <20210402174003.GA1399@agape.jhs>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
 <34bf6cdc7bdf5c64d47cb3525897970644de7052.1617356821.git.fabioaiuto83@gmail.com>
 <2014e0fc141d73d907c781ca31c822c96d3a7c47.camel@perches.com>
 <20210402125127.GB1420@agape.jhs>
 <c845d8ea7d0d8e7a613471edb53d780d660142a9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c845d8ea7d0d8e7a613471edb53d780d660142a9.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 08:20:17AM -0700, Joe Perches wrote:
> On Fri, 2021-04-02 at 14:51 +0200, Fabio Aiuto wrote:
> > On Fri, Apr 02, 2021 at 03:37:57AM -0700, Joe Perches wrote:
> > > On Fri, 2021-04-02 at 12:01 +0200, Fabio Aiuto wrote:
> > > > remove all RT_TRACE logs
> > > > 
> > > > fix patch-related checkpatch issues
> > > > 
> > > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > > ---
> > > >  .../staging/rtl8723bs/core/rtw_wlan_util.c    | 26 +++++--------------
> > > >  1 file changed, 6 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> > > []
> > > > @@ -1382,25 +1374,19 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
> > > >  	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
> > > >  		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
> > > >  		if (pbuf && (wpa_ielen > 0)) {
> > > > -			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
> > > > -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
> > > > -						("%s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is %d\n", __func__,
> > > > -						 pairwise_cipher, group_cipher, is_8021x));
> > > > -			}
> > > > +			if (rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher,
> > > > +					     &pairwise_cipher, &is_8021x) == _SUCCESS)
> > > > +				;
> > > 
> > > 		This sort of if is a bit silly.
> > > 		Better would be to remove the test and just use:
> > > 
> > > 			rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher,
> > > 					 &pairwise_cipher, &is_8021x);
> > > 
> > > >  		} else {
> > > >  			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
> > > >  
> > > > 
> > > >  			if (pbuf && (wpa_ielen > 0)) {
> > > > -				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
> > > > -					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
> > > > -							("%s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_802x is %d\n",
> > > > -							 __func__, pairwise_cipher, group_cipher, is_8021x));
> > > > -				}
> > > > +				if (rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher,
> > > > +						      &pairwise_cipher, &is_8021x) == _SUCCESS)
> > > > +					;
> > > 
> > > 				rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher,
> > > 						  &pairwise_cipher, &is_8021x);
> > > 
> > > etc...
> > > 
> > > Lastly, another suggestion would be to just submit a single patch
> > > removing _ALL_ the RT_TRACE uses not intermixing various other cleanups
> > > with the series and then do those other cleanups.
> > > 
> > > Using a coccinelle script like:
> > > 
> > > $ cat RT_TRACE.cocci
> > > @@
> > > expression a, b, c;
> > > @@
> > > 
> > > -	RT_TRACE(a, b, (c));
> > > 
> > > $ spatch -sp-file RT_TRACE.cocci drivers/staging/rtl8723bs/
> > > 
> > > And then clean up the various bits you think are inappropriately done.
> > > 
> > > 
> > 
> > thank you Joe, I tried with (RT_TRACE.cocci in parent folder)
> > 
> > user@host:~/src/git/kernels/staging$ spatch -sp-file ../RT_TRACE.cocci drivers/staging/rtl8723bs/
> > init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> > 0 files match
> 
> Likely you are running the script on the tree after you have
> applied all your patches.
> 
> Try running the cocci script on a fresh copy of -next.
> 
> Using the script and adding the script in the commit message helps
> others to verify that the changes you make do not have any other effect.
> 
> $ cat RT_TRACE.cocci
> @@
> expression a, b, c;
> @@
> 
> -	RT_TRACE(a, b, (c));
> 
> $ git checkout next-20210401
> $ spatch -sp-file RT_TRACE.cocci --in-place --no-show-diff --very-quiet drivers/staging/rtl8723bs/
> 31 files match
> $ git diff --stat -p
>  drivers/staging/rtl8723bs/core/rtw_cmd.c          |  34 +------
>  drivers/staging/rtl8723bs/core/rtw_eeprom.c       |  11 ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c    |  41 --------
>  drivers/staging/rtl8723bs/core/rtw_ioctl_set.c    |  68 +------------
>  drivers/staging/rtl8723bs/core/rtw_mlme.c         |  72 +-------------
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |  24 -----
>  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c      |  45 ---------
>  drivers/staging/rtl8723bs/core/rtw_recv.c         | 113 +---------------------
>  drivers/staging/rtl8723bs/core/rtw_security.c     |  35 -------
>  drivers/staging/rtl8723bs/core/rtw_sta_mgt.c      |  25 -----
>  drivers/staging/rtl8723bs/core/rtw_wlan_util.c    |  16 ---
>  drivers/staging/rtl8723bs/core/rtw_xmit.c         |  59 +----------
>  drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c      |  46 ---------
>  drivers/staging/rtl8723bs/hal/hal_intf.c          |   2 -
>  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c |  93 ------------------
>  drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  32 +-----
>  drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c    |   2 -
>  drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  32 ------
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c      |  34 -------
>  drivers/staging/rtl8723bs/hal/sdio_ops.c          |  31 ------
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   6 --
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    |  53 ----------
>  drivers/staging/rtl8723bs/os_dep/mlme_linux.c     |   4 -
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c       |  46 ---------
>  drivers/staging/rtl8723bs/os_dep/osdep_service.c  |   1 -
>  drivers/staging/rtl8723bs/os_dep/recv_linux.c     |   9 --
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c      |  15 ---
>  drivers/staging/rtl8723bs/os_dep/xmit_linux.c     |   5 -
>  28 files changed, 19 insertions(+), 935 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 2aaf25b48f96..ff4d771d8b8a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -221,8 +221,6 @@ int rtw_init_evt_priv(struct evt_priv *pevtpriv)
>  
>  void _rtw_free_evt_priv(struct	evt_priv *pevtpriv)
>  {
> -	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+_rtw_free_evt_priv\n"));
> -
>  	_cancel_workitem_sync(&pevtpriv->c2h_wk);
>  	while (pevtpriv->c2h_wk_alive)
>  		msleep(10);
> @@ -233,8 +231,6 @@ void _rtw_free_evt_priv(struct	evt_priv *pevtpriv)
>  			kfree(c2h);
>  	}
>  	kfree(pevtpriv->c2h_queue);
> -
> -	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("-_rtw_free_evt_priv\n"));
>  }
>  
>  void _rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
> @@ -299,13 +295,11 @@ struct	cmd_obj	*_rtw_dequeue_cmd(struct __queue *queue)
>  
>  void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
>  {
> -	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("rtw_free_evt_priv\n"));
>  	_rtw_free_evt_priv(pevtpriv);
>  }
>  
>  void rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
>  {
> -	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("rtw_free_cmd_priv\n"));
>  	_rtw_free_cmd_priv(pcmdpriv);
>  }
>  
> @@ -415,8 +409,6 @@ int rtw_cmd_thread(void *context)
>  	atomic_set(&(pcmdpriv->cmdthd_running), true);
>  	complete(&pcmdpriv->terminate_cmdthread_comp);
>  
> -	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("start r871x rtw_cmd_thread !!!!\n"));
> -
>  	while (1) {
>  		if (wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp)) {
>  			DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp) return != 0, break\n", FUNC_ADPT_ARG(padapter));
> @@ -440,8 +432,6 @@ int rtw_cmd_thread(void *context)
>  		}
>  
>  		if (rtw_register_cmd_alive(padapter) != _SUCCESS) {
> -			RT_TRACE(_module_hal_xmit_c_, _drv_notice_,
> -					 ("%s: wait to leave LPS_LCLK\n", __func__));
>  			continue;
>  		}
>  
> @@ -512,14 +502,12 @@ int rtw_cmd_thread(void *context)
>  		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
>  			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
>  			if (pcmd_callback == NULL) {
> -				RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n", pcmd_callback, pcmd->cmdcode));
>  				rtw_free_cmd_obj(pcmd);
>  			} else {
>  				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
>  				pcmd_callback(pcmd->padapter, pcmd);/* need consider that free cmd_obj in rtw_cmd_callback */
>  			}
>  		} else {
> -			RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("%s: cmdcode = 0x%x callback not defined!\n", __func__, pcmd->cmdcode));
>  			rtw_free_cmd_obj(pcmd);
>  		}
>  
> @@ -583,8 +571,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
>  
>  	rtw_free_network_queue(padapter, false);
>  
> -	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("%s: flush network queue\n", __func__));
> -
>  	init_h2fwcmd_w_parm_no_rsp(ph2c, psurveyPara, GEN_CMD_CODE(_SiteSurvey));
>  
>  	/* psurveyPara->bsslimit = 48; */
> @@ -677,9 +663,9 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
>  	u8 res = _SUCCESS;
>  
>  	if (pmlmepriv->assoc_ssid.SsidLength == 0)
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
> +		{}
>  	else
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
> +		{}
>  
>  	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
>  	if (pcmd == NULL) {
> @@ -767,14 +753,13 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
>  	u8 *ptmp = NULL;
>  
>  	if (pmlmepriv->assoc_ssid.SsidLength == 0)
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+Join cmd: Any SSid\n"));
> +		{}
>  	else
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+Join cmd: SSid =[%s]\n", pmlmepriv->assoc_ssid.Ssid));
> +		{}
>  
>  	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
>  	if (pcmd == NULL) {
>  		res = _FAIL;
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd: memory allocate for cmd_obj fail!!!\n"));
>  		goto exit;
>  	}
>  	/* for IEs is fix buf size */
> @@ -883,8 +868,6 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
>  	struct cmd_priv *cmdpriv = &padapter->cmdpriv;
>  	u8 res = _SUCCESS;
>  
> -	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_disassoc_cmd\n"));
> -
>  	/* prepare cmd parameter */
>  	param = rtw_zmalloc(sizeof(*param));
>  	if (param == NULL) {
> @@ -1209,8 +1192,6 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
>  
>  	u8 res = _SUCCESS;
>  
> -	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_set_chplan_cmd\n"));
> -
>  	/*  check if allow software config */
>  	if (swconfig && rtw_hal_is_disable_sw_channel_plan(padapter) == true) {
>  		res = _FAIL;
> @@ -1981,7 +1962,6 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
>  		_set_timer(&pmlmepriv->scan_to_timer, 1);
>  	} else if (pcmd->res != H2C_SUCCESS) {
>  		_set_timer(&pmlmepriv->scan_to_timer, 1);
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: MgntActrtw_set_802_11_bssid_LIST_SCAN Fail ************\n\n."));
>  	}
>  
>  	/*  free cmd */
> @@ -1997,7 +1977,6 @@ void rtw_disassoc_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
>  		set_fwstate(pmlmepriv, _FW_LINKED);
>  		spin_unlock_bh(&pmlmepriv->lock);
>  
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ***Error: disconnect_cmd_callback Fail ***\n."));
>  		return;
>  	}
>  	/*  free cmd */
> @@ -2031,7 +2010,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
>  		goto exit;
>  
>  	if ((pcmd->res != H2C_SUCCESS)) {
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: rtw_createbss_cmd_callback  Fail ************\n\n."));
>  		_set_timer(&pmlmepriv->assoc_timer, 1);
>  	}
>  
> @@ -2045,7 +2023,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
>  		if (!psta) {
>  			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
>  			if (psta == NULL) {
> -				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nCan't alloc sta_info when createbss_cmd_callback\n"));
>  				goto createbss_cmd_fail;
>  			}
>  		}
> @@ -2057,7 +2034,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
>  		if (pwlan == NULL) {
>  			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
>  			if (pwlan == NULL) {
> -				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n Error:  can't get pwlan in rtw_joinbss_event_callback\n"));
>  				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
>  				goto createbss_cmd_fail;
>  			}
> @@ -2102,7 +2078,6 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
>  	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
>  
>  	if (psta == NULL) {
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: rtw_setstaKey_cmdrsp_callback => can't get sta_info\n\n"));
>  		goto exit;
>  	}
>  exit:
> @@ -2118,7 +2093,6 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
>  	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
>  
>  	if (psta == NULL) {
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: setassocsta_cmdrsp_callbac => can't get sta_info\n\n"));
>  		goto exit;
>  	}
>  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> index 3cbd65dee741..796868304359 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> @@ -36,7 +36,6 @@ void shift_out_bits(_adapter *padapter, u16 data, u16 count)
>  _func_enter_;
>  
>  	if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  	mask = 0x01 << (count - 1);
> @@ -49,7 +48,6 @@ _func_enter_;
>  		if (data & mask)
>  			x |= _EEDI;
>  		if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  		}
>  		rtw_write8(padapter, EE_9346CR, (u8)x);
> @@ -59,7 +57,6 @@ _func_enter_;
>  		mask = mask >> 1;
>  	} while (mask);
>  	if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  	x &= ~_EEDI;
> @@ -73,7 +70,6 @@ u16 shift_in_bits(_adapter *padapter)
>  	u16 x, d = 0, i;
>  _func_enter_;
>  	if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  	x = rtw_read8(padapter, EE_9346CR);
> @@ -85,7 +81,6 @@ _func_enter_;
>  		d = d << 1;
>  		up_clk(padapter, &x);
>  	if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  		x = rtw_read8(padapter, EE_9346CR);
> @@ -123,23 +118,19 @@ void eeprom_clean(_adapter *padapter)
>  	u16 x;
>  _func_enter_;
>  	if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  	x = rtw_read8(padapter, EE_9346CR);
>  	if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  	x &= ~(_EECS | _EEDI);
>  	rtw_write8(padapter, EE_9346CR, (u8)x);
>  	if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  	up_clk(padapter, &x);
>  		if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  	down_clk(padapter, &x);
> @@ -156,14 +147,12 @@ u16 eeprom_read16(_adapter *padapter, u16 reg) /*ReadEEprom*/
>  _func_enter_;
>  
>  	if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  	/* select EEPROM, reset bits, set _EECS*/
>  	x = rtw_read8(padapter, EE_9346CR);
>  
>  	if (padapter->bSurpriseRemoved == true) {
> -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
>  		goto out;
>  	}
>  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index cccbea555a32..4e447383f8a3 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -489,8 +489,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
>  		left -= WPA_SELECTOR_LEN;
>  
>  	} else if (left > 0) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
> -
>  		return _FAIL;
>  	}
>  
> @@ -502,8 +500,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
>  		left -= 2;
>  
>  		if (count == 0 || left < count * WPA_SELECTOR_LEN) {
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
> -						"count %u left %u", __func__, count, left));
>  			return _FAIL;
>  		}
>  
> @@ -515,7 +511,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
>  		}
>  
>  	} else if (left == 1) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",   __func__));
>  		return _FAIL;
>  	}
>  
> @@ -523,7 +518,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
>  		if (left >= 6) {
>  			pos += 2;
>  			if (!memcmp(pos, SUITE_1X, 4)) {
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s : there has 802.1x auth\n", __func__));
>  				*is_8021x = 1;
>  			}
>  		}
> @@ -560,7 +554,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
>  		left -= RSN_SELECTOR_LEN;
>  
>  	} else if (left > 0) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
>  		return _FAIL;
>  	}
>  
> @@ -572,8 +565,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
>  		left -= 2;
>  
>  		if (count == 0 || left < count * RSN_SELECTOR_LEN) {
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
> -						 "count %u left %u", __func__, count, left));
>  			return _FAIL;
>  		}
>  
> @@ -585,8 +576,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
>  		}
>  
>  	} else if (left == 1) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",  __func__));
> -
>  		return _FAIL;
>  	}
>  
> @@ -594,7 +583,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
>  		if (left >= 6) {
>  			pos += 2;
>  			if (!memcmp(pos, SUITE_1X, 4)) {
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s (): there has 802.1x auth\n", __func__));
>  				*is_8021x = 1;
>  			}
>  		}
> @@ -630,9 +618,6 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
>  				memcpy(wapi_ie, &in_ie[cnt], in_ie[cnt+1]+2);
>  
>  				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
> -					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
> -								wapi_ie[i], wapi_ie[i+1], wapi_ie[i+2], wapi_ie[i+3], wapi_ie[i+4],
> -								wapi_ie[i+5], wapi_ie[i+6], wapi_ie[i+7]));
>  				}
>  			}
>  
> @@ -668,15 +653,10 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
>  		authmode = in_ie[cnt];
>  
>  		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt+2], &wpa_oui[0], 4))) {
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n rtw_get_wpa_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n", sec_idx, in_ie[cnt+1]+2));
> -
>  				if (wpa_ie) {
>  				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
>  
>  				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
> -						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
> -									wpa_ie[i], wpa_ie[i+1], wpa_ie[i+2], wpa_ie[i+3], wpa_ie[i+4],
> -									wpa_ie[i+5], wpa_ie[i+6], wpa_ie[i+7]));
>  					}
>  				}
>  
> @@ -684,15 +664,10 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
>  				cnt += in_ie[cnt+1]+2;  /* get next */
>  		} else {
>  			if (authmode == WLAN_EID_RSN) {
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n get_rsn_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n", sec_idx, in_ie[cnt+1]+2));
> -
>  				if (rsn_ie) {
>  				memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt+1]+2);
>  
>  				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
> -						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
> -									rsn_ie[i], rsn_ie[i+1], rsn_ie[i+2], rsn_ie[i+3], rsn_ie[i+4],
> -									rsn_ie[i+5], rsn_ie[i+6], rsn_ie[i+7]));
>  					}
>  				}
>  
> @@ -1137,28 +1112,20 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
>  	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
>  
>  	if (pbuf && (wpa_ielen > 0)) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_cipher_info: wpa_ielen: %d", wpa_ielen));
>  		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
>  			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
>  			pnetwork->BcnInfo.group_cipher = group_cipher;
>  			pnetwork->BcnInfo.is_8021x = is8021x;
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d, is_8021x is %d",
> -						__func__, pnetwork->BcnInfo.pairwise_cipher, pnetwork->BcnInfo.is_8021x));
>  			ret = _SUCCESS;
>  		}
>  	} else {
>  		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
>  
>  		if (pbuf && (wpa_ielen > 0)) {
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE\n"));
>  			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE  OK!!!\n"));
>  				pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
>  				pnetwork->BcnInfo.group_cipher = group_cipher;
>  				pnetwork->BcnInfo.is_8021x = is8021x;
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d,"
> -							"pnetwork->group_cipher is %d, is_8021x is %d",	__func__, pnetwork->BcnInfo.pairwise_cipher,
> -							pnetwork->BcnInfo.group_cipher, pnetwork->BcnInfo.is_8021x));
>  				ret = _SUCCESS;
>  			}
>  		}
> @@ -1188,10 +1155,6 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
>  		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
>  	}
>  	rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
>  
>  	if (rsn_len > 0) {
>  		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
> @@ -1201,10 +1164,6 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
>  		if (bencrypt)
>  			pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WEP;
>  	}
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
> -				pnetwork->BcnInfo.encryp_protocol));
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
> -				pnetwork->BcnInfo.encryp_protocol));
>  	rtw_get_cipher_info(pnetwork);
>  
>  	/* get bwmode and ch_offset */
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> index cb14855742f7..0eb2e7114f6f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> @@ -28,7 +28,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
>  	u8 ret = true;
>  
>  	if (ssid->SsidLength > 32) {
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("ssid length >32\n"));
>  		ret = false;
>  		goto exit;
>  	}
> @@ -50,8 +49,6 @@ u8 rtw_do_join(struct adapter *padapter)
>  	phead = get_list_head(queue);
>  	plist = get_next(phead);
>  
> -	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("\n rtw_do_join: phead = %p; plist = %p\n\n\n", phead, plist));
> -
>  	pmlmepriv->cur_network.join_res = -2;
>  
>  	set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> @@ -70,12 +67,10 @@ u8 rtw_do_join(struct adapter *padapter)
>  		if (pmlmepriv->LinkDetectInfo.bBusyTraffic == false
>  			|| rtw_to_roam(padapter) > 0
>  		) {
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_do_join(): site survey if scanned_queue is empty\n."));
>  			/*  submit site_survey_cmd */
>  			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
>  			if (_SUCCESS != ret) {
>  				pmlmepriv->to_join = false;
> -				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_do_join(): site survey return error\n."));
>  			}
>  		} else {
>  			pmlmepriv->to_join = false;
> @@ -108,15 +103,12 @@ u8 rtw_do_join(struct adapter *padapter)
>  				rtw_generate_random_ibss(pibss);
>  
>  				if (rtw_createbss_cmd(padapter) != _SUCCESS) {
> -					RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>do_goin: rtw_createbss_cmd status FAIL***\n "));
>  					ret =  false;
>  					goto exit;
>  				}
>  
>  				pmlmepriv->to_join = false;
>  
> -				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("***Error => rtw_select_and_join_from_scanned_queue FAIL under STA_Mode***\n "));
> -
>  			} else {
>  				/*  can't associate ; reset under-linking */
>  				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
> @@ -130,7 +122,6 @@ u8 rtw_do_join(struct adapter *padapter)
>  					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
>  					if (_SUCCESS != ret) {
>  						pmlmepriv->to_join = false;
> -						RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("do_join(): site survey return error\n."));
>  					}
>  				} else {
>  					ret = _FAIL;
> @@ -170,16 +161,10 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
>  		goto release_mlme_lock;
>  
>  	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
> -
>  		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
>  			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
>  				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
>  		} else {
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set BSSID not the same bssid\n"));
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid =%pM\n", MAC_ARG(bssid)));
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("cur_bssid =%pM\n", MAC_ARG(pmlmepriv->cur_network.network.MacAddress)));
> -
>  			rtw_disassoc_cmd(padapter, 0, true);
>  
>  			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
> @@ -213,8 +198,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
>  	spin_unlock_bh(&pmlmepriv->lock);
>  
>  exit:
> -	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
> -		("rtw_set_802_11_bssid: status =%d\n", status));
>  
>  	return status;
>  }
> @@ -230,8 +213,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
>  			ssid->Ssid, get_fwstate(pmlmepriv));
>  
>  	if (padapter->hw_init_completed == false) {
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
> -			 ("set_ssid: hw_init_completed ==false =>exit!!!\n"));
>  		status = _FAIL;
>  		goto exit;
>  	}
> @@ -245,16 +226,9 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
>  		goto release_mlme_lock;
>  
>  	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
> -			 ("set_ssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
> -
>  		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
>  		    (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength))) {
>  			if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)) {
> -				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
> -					 ("Set SSID is the same ssid, fw_state = 0x%08x\n",
> -					  get_fwstate(pmlmepriv)));
> -
>  				if (rtw_is_same_ibss(padapter, pnetwork) == false) {
>  					/* if in WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE, create bss or rejoin again */
>  					rtw_disassoc_cmd(padapter, 0, true);
> @@ -275,10 +249,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
>  				rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_JOINBSS, 1);
>  			}
>  		} else {
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set SSID not the same ssid\n"));
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_ssid =[%s] len = 0x%x\n", ssid->Ssid, (unsigned int)ssid->SsidLength));
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("assoc_ssid =[%s] len = 0x%x\n", pmlmepriv->assoc_ssid.Ssid, (unsigned int)pmlmepriv->assoc_ssid.SsidLength));
> -
>  			rtw_disassoc_cmd(padapter, 0, true);
>  
>  			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
> @@ -316,8 +286,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
>  	spin_unlock_bh(&pmlmepriv->lock);
>  
>  exit:
> -	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
> -		("-rtw_set_802_11_ssid: status =%d\n", status));
>  
>  	return status;
>  }
> @@ -343,8 +311,6 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
>  	}
>  
>  	if (padapter->hw_init_completed == false) {
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
> -			 ("set_ssid: hw_init_completed ==false =>exit!!!\n"));
>  		status = _FAIL;
>  		goto exit;
>  	}
> @@ -396,12 +362,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
>  	struct	wlan_network	*cur_network = &pmlmepriv->cur_network;
>  	enum ndis_802_11_network_infrastructure *pold_state = &(cur_network->network.InfrastructureMode);
>  
> -	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
> -		 ("+rtw_set_802_11_infrastructure_mode: old =%d new =%d fw_state = 0x%08x\n",
> -		  *pold_state, networktype, get_fwstate(pmlmepriv)));
> -
>  	if (*pold_state != networktype) {
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, (" change mode!"));
>  		/* DBG_871X("change mode, old_mode =%d, new_mode =%d, fw_state = 0x%x\n", *pold_state, networktype, get_fwstate(pmlmepriv)); */
>  
>  		if (*pold_state == Ndis802_11APMode) {
> @@ -468,8 +429,6 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
>  	spin_lock_bh(&pmlmepriv->lock);
>  
>  	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_disassociate: rtw_indicate_disconnect\n"));
> -
>  		rtw_disassoc_cmd(padapter, 0, true);
>  		rtw_indicate_disconnect(padapter);
>  		/* modify for CONFIG_IEEE80211W, none 11w can use it */
> @@ -488,28 +447,24 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
>  	struct	mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
>  	u8 res = true;
>  
> -	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("+rtw_set_802_11_bssid_list_scan(), fw_state =%x\n", get_fwstate(pmlmepriv)));
> -
>  	if (padapter == NULL) {
>  		res = false;
>  		goto exit;
>  	}
>  	if (padapter->hw_init_completed == false) {
>  		res = false;
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n ===rtw_set_802_11_bssid_list_scan:hw_init_completed ==false ===\n"));
>  		goto exit;
>  	}
>  
>  	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true) ||
>  		(pmlmepriv->LinkDetectInfo.bBusyTraffic == true)) {
>  		/*  Scan or linking is in progress, do nothing. */
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_set_802_11_bssid_list_scan fail since fw_state = %x\n", get_fwstate(pmlmepriv)));
>  		res = true;
>  
>  		if (check_fwstate(pmlmepriv, (_FW_UNDER_SURVEY|_FW_UNDER_LINKING)) == true)
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###_FW_UNDER_SURVEY|_FW_UNDER_LINKING\n\n"));
> +			{}
>  		else
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###pmlmepriv->sitesurveyctrl.traffic_busy ==true\n\n"));
> +			{}
>  	} else {
>  		if (rtw_is_scan_deny(padapter)) {
>  			DBG_871X(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
> @@ -534,12 +489,8 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
>  	int res;
>  	u8 ret;
>  
> -	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_802_11_auth.mode(): mode =%x\n", authmode));
> -
>  	psecuritypriv->ndisauthtype = authmode;
>  
> -	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_set_802_11_authentication_mode:psecuritypriv->ndisauthtype =%d", psecuritypriv->ndisauthtype));
> -
>  	if (psecuritypriv->ndisauthtype > 3)
>  		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
>  
> @@ -563,7 +514,6 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
>  	keyid = wep->KeyIndex & 0x3fffffff;
>  
>  	if (keyid >= 4) {
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("MgntActrtw_set_802_11_add_wep:keyid>4 =>fail\n"));
>  		ret = false;
>  		goto exit;
>  	}
> @@ -571,35 +521,21 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
>  	switch (wep->KeyLength) {
>  	case 5:
>  		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength =5\n"));
>  		break;
>  	case 13:
>  		psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength = 13\n"));
>  		break;
>  	default:
>  		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
> -		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength!=5 or 13\n"));
>  		break;
>  	}
>  
> -	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
> -		 ("rtw_set_802_11_add_wep:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
> -		  wep->KeyLength, wep->KeyIndex, keyid));
> -
>  	memcpy(&(psecuritypriv->dot11DefKey[keyid].skey[0]), &(wep->KeyMaterial), wep->KeyLength);
>  
>  	psecuritypriv->dot11DefKeylen[keyid] = wep->KeyLength;
>  
>  	psecuritypriv->dot11PrivacyKeyIndex = keyid;
>  
> -	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_set_802_11_add_wep:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n",
> -		psecuritypriv->dot11DefKey[keyid].skey[0], psecuritypriv->dot11DefKey[keyid].skey[1], psecuritypriv->dot11DefKey[keyid].skey[2],
> -		psecuritypriv->dot11DefKey[keyid].skey[3], psecuritypriv->dot11DefKey[keyid].skey[4], psecuritypriv->dot11DefKey[keyid].skey[5],
> -		psecuritypriv->dot11DefKey[keyid].skey[6], psecuritypriv->dot11DefKey[keyid].skey[7], psecuritypriv->dot11DefKey[keyid].skey[8],
> -		psecuritypriv->dot11DefKey[keyid].skey[9], psecuritypriv->dot11DefKey[keyid].skey[10], psecuritypriv->dot11DefKey[keyid].skey[11],
> -		psecuritypriv->dot11DefKey[keyid].skey[12]));
> -
>  	res = rtw_set_key(padapter, psecuritypriv, keyid, 1, true);
>  
>  	if (res == _FAIL)
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 95cfef118a94..95aa7552ff42 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -157,8 +157,6 @@ struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
>  
>  	list_del_init(&pnetwork->list);
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
> -		 ("rtw_alloc_network: ptr =%p\n", plist));
>  	pnetwork->network_type = 0;
>  	pnetwork->fixed = false;
>  	pnetwork->last_scanned = jiffies;
> @@ -301,7 +299,6 @@ signed int rtw_if_up(struct adapter *padapter)
>  
>  	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
>  		(check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false)) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_if_up:bDriverStopped(%d) OR bSurpriseRemoved(%d)", padapter->bDriverStopped, padapter->bSurpriseRemoved));
>  		res = false;
>  	} else
>  		res =  true;
> @@ -341,7 +338,6 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
>  
>  void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
>  {
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_mlme_priv\n"));
>  	_rtw_free_mlme_priv(pmlmepriv);
>  }
>  
> @@ -615,7 +611,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
>  			/* list_del_init(&oldest->list); */
>  			pnetwork = oldest;
>  			if (!pnetwork) {
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
>  				goto exit;
>  			}
>  			memcpy(&(pnetwork->network), target,  get_wlan_bssid_ex_sz(target));
> @@ -636,7 +631,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
>  			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
>  
>  			if (!pnetwork) {
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
>  				goto exit;
>  			}
>  
> @@ -757,7 +751,6 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
>  /* TODO: Perry : For Power Management */
>  void rtw_atimdone_event_callback(struct adapter	*adapter, u8 *pbuf)
>  {
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("receive atimdone_event\n"));
>  }
>  
>  void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
> @@ -768,11 +761,8 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
>  
>  	pnetwork = (struct wlan_bssid_ex *)pbuf;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_survey_event_callback, ssid =%s\n",  pnetwork->Ssid.Ssid));
> -
>  	len = get_wlan_bssid_ex_sz(pnetwork);
>  	if (len > (sizeof(struct wlan_bssid_ex))) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n ****rtw_survey_event_callback: return a wrong bss ***\n"));
>  		return;
>  	}
>  
> @@ -819,14 +809,10 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
>  		pmlmepriv->wps_probe_req_ie = NULL;
>  	}
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_surveydone_event_callback: fw_state:%x\n\n", get_fwstate(pmlmepriv)));
> -
>  	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
>  		del_timer_sync(&pmlmepriv->scan_to_timer);
>  		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
>  	} else {
> -
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("nic status =%x, survey done event comes too late!\n", get_fwstate(pmlmepriv)));
>  	}
>  
>  	rtw_set_signal_stat_timer(&adapter->recvpriv);
> @@ -845,8 +831,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
>  					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;because don't set assoc_timer */
>  					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
>  
> -					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("switching to adhoc master\n"));
> -
>  					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
>  
>  					rtw_update_registrypriv_dev_network(adapter);
> @@ -855,7 +839,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
>  					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
>  
>  					if (rtw_createbss_cmd(adapter) != _SUCCESS)
> -						RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
> +						{}
>  
>  					pmlmepriv->to_join = false;
>  				}
> @@ -927,7 +911,6 @@ static void free_scanqueue(struct	mlme_priv *pmlmepriv)
>  	struct __queue *scan_queue = &pmlmepriv->scanned_queue;
>  	struct list_head	*plist, *phead, *ptemp;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+free_scanqueue\n"));
>  	spin_lock_bh(&scan_queue->lock);
>  	spin_lock_bh(&free_queue->lock);
>  
> @@ -965,7 +948,7 @@ static void find_network(struct adapter *adapter)
>  	if (pwlan)
>  		pwlan->fixed = false;
>  	else
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources : pwlan == NULL\n\n"));
> +		{}
>  
>  	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
>  	    (adapter->stapriv.asoc_sta_count == 1))
> @@ -983,10 +966,6 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
>  	struct dvobj_priv *psdpriv = adapter->dvobj;
>  	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("tgt_network->network.MacAddress =%pM ssid =%s\n",
> -		MAC_ARG(tgt_network->network.MacAddress), tgt_network->network.Ssid.Ssid));
> -
>  	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_AP_STATE)) {
>  		struct sta_info *psta;
>  
> @@ -1024,8 +1003,6 @@ void rtw_indicate_connect(struct adapter *padapter)
>  {
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_connect\n"));
> -
>  	pmlmepriv->to_join = false;
>  
>  	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
> @@ -1037,8 +1014,6 @@ void rtw_indicate_connect(struct adapter *padapter)
>  
>  	rtw_set_to_roam(padapter, 0);
>  	rtw_set_scan_deny(padapter, 3000);
> -
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("-rtw_indicate_connect: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
>  }
>  
>  /*
> @@ -1048,8 +1023,6 @@ void rtw_indicate_disconnect(struct adapter *padapter)
>  {
>  	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_disconnect\n"));
> -
>  	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING|WIFI_UNDER_WPS);
>  
>  	/* DBG_871X("clear wps when %s\n", __func__); */
> @@ -1215,9 +1188,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
>  	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
>  	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\nfw_state:%x, BSSID:%pM\n"
> -		, get_fwstate(pmlmepriv), MAC_ARG(pnetwork->network.MacAddress)));
> -
>  	/*  why not use ptarget_wlan?? */
>  	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
>  	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
> @@ -1259,7 +1229,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
>  			break;
>  	default:
>  			pmlmepriv->fw_state = WIFI_NULL_STATE;
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Invalid network_mode\n"));
>  			break;
>  	}
>  
> @@ -1288,20 +1257,17 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
>  	unsigned int		the_same_macaddr = false;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("joinbss event call back received with res =%d\n", pnetwork->join_res));
> -
>  	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
>  
>  	if (pmlmepriv->assoc_ssid.SsidLength == 0)
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   joinbss event call back  for Any SSid\n"));
> +		{}
>  	else
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   rtw_joinbss_event_callback for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
> +		{}
>  
>  	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
>  
>  	pnetwork->network.Length = get_wlan_bssid_ex_sz(&pnetwork->network);
>  	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex)) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n ***joinbss_evt_callback return a wrong bss ***\n\n"));
>  		return;
>  	}
>  
> @@ -1310,8 +1276,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  	pmlmepriv->LinkDetectInfo.TrafficTransitionCount = 0;
>  	pmlmepriv->LinkDetectInfo.LowPowerTransitionCount = 0;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n rtw_joinbss_event_callback !! spin_lock_irqsave\n"));
> -
>  	if (pnetwork->join_res > 0) {
>  		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
>  		retry = 0;
> @@ -1357,7 +1321,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
>  				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
>  				if (!ptarget_sta) {
> -					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
>  					spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
>  					goto ignore_joinbss_callback;
>  				}
> @@ -1368,17 +1331,12 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  				pmlmepriv->cur_network_scanned = ptarget_wlan;
>  				rtw_indicate_connect(adapter);
>  			} else {
> -				/* adhoc mode will rtw_indicate_connect when rtw_stassoc_event_callback */
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("adhoc mode, fw_state:%x", get_fwstate(pmlmepriv)));
>  			}
>  
>  			/* s5. Cancel assoc_timer */
>  			del_timer_sync(&pmlmepriv->assoc_timer);
>  
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("Cancel assoc_timer\n"));
> -
>  		} else {
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_joinbss_event_callback err: fw_state:%x", get_fwstate(pmlmepriv)));
>  			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
>  			goto ignore_joinbss_callback;
>  		}
> @@ -1392,7 +1350,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  		/* rtw_free_assoc_resources(adapter, 1); */
>  
>  		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true) {
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("fail! clear _FW_UNDER_LINKING ^^^fw_state =%x\n", get_fwstate(pmlmepriv)));
>  			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
>  		}
>  
> @@ -1402,7 +1359,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  		res = _FAIL;
>  		if (retry < 2) {
>  			res = rtw_select_and_join_from_scanned_queue(pmlmepriv);
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_select_and_join_from_scanned_queue again! res:%d\n", res));
>  		}
>  
>  		if (res == _SUCCESS) {
> @@ -1413,7 +1369,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
>  			rtw_indicate_connect(adapter);
>  		} else {
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Set Assoc_Timer = 1; can't find match ssid in scanned_q\n"));
>  		#endif
>  
>  			_set_timer(&pmlmepriv->assoc_timer, 1);
> @@ -1501,16 +1456,12 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
>  	/* for AD-HOC mode */
>  	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
>  	if (psta) {
> -		/* the sta have been in sta_info_queue => do nothing */
> -
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
>  
>  		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
>  	}
>  
>  	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
>  	if (!psta) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
>  		return;
>  	}
>  
> @@ -1661,7 +1612,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
>  			}
>  
>  			if (rtw_createbss_cmd(adapter) != _SUCCESS)
> -				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>stadel_event_callback: rtw_createbss_cmd status FAIL***\n "));
> +				{}
>  		}
>  
>  	}
> @@ -1673,7 +1624,6 @@ void rtw_cpwm_event_callback(struct adapter *padapter, u8 *pbuf)
>  {
>  	struct reportpwrstate_parm *preportpwrstate;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_cpwm_event_callback !!!\n"));
>  	preportpwrstate = (struct reportpwrstate_parm *)pbuf;
>  	preportpwrstate->state |= (u8)(adapter_to_pwrctl(padapter)->cpwm_tog + 0x80);
>  	cpwm_int_hdl(padapter, preportpwrstate);
> @@ -1939,7 +1889,6 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
>  
>  		pnetwork = container_of(mlme->pscanned, struct wlan_network, list);
>  		if (!pnetwork) {
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
>  			ret = _FAIL;
>  			goto exit;
>  		}
> @@ -2069,7 +2018,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
>  
>  		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
>  		if (!pnetwork) {
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
>  			ret = _FAIL;
>  			goto exit;
>  		}
> @@ -2146,8 +2094,6 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
>  
>  	INIT_LIST_HEAD(&pcmd->list);
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("after enqueue set_auth_cmd, auth_mode =%x\n", psecuritypriv->dot11AuthAlgrthm));
> -
>  	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
>  
>  exit:
> @@ -2170,10 +2116,8 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
>  
>  	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
>  		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =(unsigned char)psecuritypriv->dot118021XGrpPrivacy =%d\n", psetkeyparm->algorithm));
>  	} else {
>  		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm;
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =(u8)psecuritypriv->dot11PrivacyAlgrthm =%d\n", psetkeyparm->algorithm));
>  
>  	}
>  	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
> @@ -2182,7 +2126,6 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
>  		adapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
>  
>  	DBG_871X("==> rtw_set_key algorithm(%x), keyid(%x), key_mask(%x)\n", psetkeyparm->algorithm, psetkeyparm->keyid, adapter->securitypriv.key_mask);
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =%d psetkeyparm->keyid =(u8)keyid =%d\n", psetkeyparm->algorithm, keyid));
>  
>  	switch (psetkeyparm->algorithm) {
>  
> @@ -2205,7 +2148,6 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
>  		psetkeyparm->grpkey = 1;
>  		break;
>  	default:
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key:psecuritypriv->dot11PrivacyAlgrthm = %x (must be 1 or 2 or 4 or 5)\n", psecuritypriv->dot11PrivacyAlgrthm));
>  		res = _FAIL;
>  		kfree(psetkeyparm);
>  		goto exit;
> @@ -2339,9 +2281,6 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
>  	struct security_priv *psecuritypriv = &adapter->securitypriv;
>  	uint	ndisauthmode = psecuritypriv->ndisauthtype;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
> -		 ("+rtw_restruct_sec_ie: ndisauthmode =%d\n", ndisauthmode));
> -
>  	/* copy fixed ie only */
>  	memcpy(out_ie, in_ie, 12);
>  	ielength = 12;
> @@ -2438,7 +2377,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
>  	}
>  
>  	pdev_network->Configuration.DSConfig = (pregistrypriv->channel);
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("pregistrypriv->channel =%d, pdev_network->Configuration.DSConfig = 0x%x\n", pregistrypriv->channel, pdev_network->Configuration.DSConfig));
>  
>  	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
>  		pdev_network->Configuration.ATIMWindow = (0);
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 8aadcf72a7ba..ea52e8762372 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -526,12 +526,7 @@ void mgt_dispatcher(struct adapter *padapter, union recv_frame *precv_frame)
>  	struct dvobj_priv *psdpriv = padapter->dvobj;
>  	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
> -		 ("+mgt_dispatcher: type(0x%x) subtype(0x%x)\n",
> -		  GetFrameType(pframe), GetFrameSubType(pframe)));
> -
>  	if (GetFrameType(pframe) != WIFI_MGT_TYPE) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("mgt_dispatcher: type(0x%x) error!\n", GetFrameType(pframe)));
>  		return;
>  	}
>  
> @@ -546,7 +541,6 @@ void mgt_dispatcher(struct adapter *padapter, union recv_frame *precv_frame)
>  	index = GetFrameSubType(pframe) >> 4;
>  
>  	if (index >= ARRAY_SIZE(mlme_sta_tbl)) {
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Currently we do not support reserved sub-fr-type =%d\n", index));
>  		return;
>  	}
>  	ptable += index;
> @@ -2675,8 +2669,6 @@ static int _issue_probereq(struct adapter *padapter,
>  	int	bssrate_len = 0;
>  	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+issue_probereq\n"));
> -
>  	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
>  	if (!pmgntframe)
>  		goto exit;
> @@ -2743,8 +2735,6 @@ static int _issue_probereq(struct adapter *padapter,
>  
>  	pattrib->last_txcmdsz = pattrib->pktlen;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("issuing probe_req, tx_len =%d\n", pattrib->last_txcmdsz));
> -
>  	if (wait_ack) {
>  		ret = dump_mgntframe_and_wait_ack(padapter, pmgntframe);
>  	} else {
> @@ -4441,8 +4431,6 @@ void start_create_ibss(struct adapter *padapter)
>  
>  		/* issue beacon */
>  		if (send_beacon(padapter) == _FAIL) {
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("issuing beacon frame fail....\n"));
> -
>  			report_join_res(padapter, -1);
>  			pmlmeinfo->state = WIFI_FW_NULL_STATE;
>  		} else {
> @@ -4622,8 +4610,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
>  		memset(country, 0, 4);
>  		memcpy(country, p, 3);
>  		p += 3;
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
> -				("%s: 802.11d country =%s\n", __func__, country));
>  
>  		i = 0;
>  		while ((ie - p) >= 3) {
> @@ -4813,9 +4799,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
>  					break;
>  
>  				chplan_new[i].ScanType = SCAN_ACTIVE;
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
> -						 ("%s: change channel %d scan type from passive to active\n",
> -						  __func__, channel));
>  			}
>  			break;
>  		}
> @@ -6332,10 +6315,6 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
>  	#ifdef CHECK_EVENT_SEQ
>  	/*  checking event sequence... */
>  	if (evt_seq != (atomic_read(&pevt_priv->event_seq) & 0x7f)) {
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
> -			 ("Event Seq Error! %d vs %d\n", (evt_seq & 0x7f),
> -			  (atomic_read(&pevt_priv->event_seq) & 0x7f)));
> -
>  		pevt_priv->event_seq = (evt_seq+1)&0x7f;
>  
>  		goto _abort_event_;
> @@ -6344,7 +6323,6 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
>  
>  	/*  checking if event code is valid */
>  	if (evt_code >= MAX_C2HEVT) {
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nEvent Code(%d) mismatch!\n", evt_code));
>  		goto _abort_event_;
>  	}
>  
> @@ -6352,8 +6330,6 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
>  	if ((wlanevents[evt_code].parmsize != 0) &&
>  			(wlanevents[evt_code].parmsize != evt_sz)) {
>  
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nEvent(%d) Parm Size mismatch (%d vs %d)!\n",
> -			evt_code, wlanevents[evt_code].parmsize, evt_sz));
>  		goto _abort_event_;
>  
>  	}
> diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> index 8bf80e6f4a11..db43061fc0dd 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> @@ -268,29 +268,18 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
>  	} else {
>  		if ((pwrpriv->rpwm == pslv)
>  			|| ((pwrpriv->rpwm >= PS_STATE_S2) && (pslv >= PS_STATE_S2))) {
> -			RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
> -				("%s: Already set rpwm[0x%02X], new = 0x%02X!\n", __func__, pwrpriv->rpwm, pslv));
>  			return;
>  		}
>  	}
>  
>  	if ((padapter->bSurpriseRemoved) || !(padapter->hw_init_completed)) {
> -		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
> -				 ("%s: SurpriseRemoved(%d) hw_init_completed(%d)\n",
> -				  __func__, padapter->bSurpriseRemoved, padapter->hw_init_completed));
> -
>  		pwrpriv->cpwm = PS_STATE_S4;
>  
>  		return;
>  	}
>  
>  	if (padapter->bDriverStopped) {
> -		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
> -				 ("%s: change power state(0x%02X) when DriverStopped\n", __func__, pslv));
> -
>  		if (pslv < PS_STATE_S2) {
> -			RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
> -					 ("%s: Reject to enter PS_STATE(0x%02X) lower than S2 when DriverStopped!!\n", __func__, pslv));
>  			return;
>  		}
>  	}
> @@ -299,8 +288,6 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
>  	/*  only when from PS_STATE S0/S1 to S2 and higher needs ACK */
>  	if ((pwrpriv->cpwm < PS_STATE_S2) && (pslv >= PS_STATE_S2))
>  		rpwm |= PS_ACK;
> -	RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
> -			 ("rtw_set_rpwm: rpwm = 0x%02x cpwm = 0x%02x\n", rpwm, pwrpriv->cpwm));
>  
>  	pwrpriv->rpwm = pslv;
>  
> @@ -382,12 +369,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
>  {
>  	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
>  
> -	RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
> -			 ("%s: PowerMode =%d Smart_PS =%d\n",
> -			  __func__, ps_mode, smart_ps));
> -
>  	if (ps_mode > PM_Card_Disable) {
> -		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_, ("ps_mode:%d error\n", ps_mode));
>  		return;
>  	}
>  
> @@ -700,9 +682,6 @@ void cpwm_int_hdl(struct adapter *padapter, struct reportpwrstate_parm *preportp
>  
>  exit:
>  	mutex_unlock(&pwrpriv->lock);
> -
> -	RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
> -			 ("cpwm_int_hdl: cpwm = 0x%02x\n", pwrpriv->cpwm));
>  }
>  
>  static void cpwm_event_callback(struct work_struct *work)
> @@ -817,10 +796,6 @@ s32 rtw_register_task_alive(struct adapter *padapter, u32 task)
>  	register_task_alive(pwrctrl, task);
>  
>  	if (pwrctrl->bFwCurrentInPSMode) {
> -		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
> -				 ("%s: task = 0x%x cpwm = 0x%02x alives = 0x%08x\n",
> -				  __func__, task, pwrctrl->cpwm, pwrctrl->alives));
> -
>  		if (pwrctrl->cpwm < pslv) {
>  			if (pwrctrl->cpwm < PS_STATE_S2)
>  				res = _FAIL;
> @@ -869,10 +844,6 @@ void rtw_unregister_task_alive(struct adapter *padapter, u32 task)
>  	unregister_task_alive(pwrctrl, task);
>  
>  	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
> -		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
> -				 ("%s: cpwm = 0x%02x alives = 0x%08x\n",
> -				  __func__, pwrctrl->cpwm, pwrctrl->alives));
> -
>  		if (pwrctrl->cpwm > pslv)
>  			if ((pslv >= PS_STATE_S2) || (pwrctrl->alives == 0))
>  				rtw_set_rpwm(padapter, pslv);
> @@ -910,10 +881,6 @@ s32 rtw_register_tx_alive(struct adapter *padapter)
>  	register_task_alive(pwrctrl, XMIT_ALIVE);
>  
>  	if (pwrctrl->bFwCurrentInPSMode) {
> -		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
> -				 ("rtw_register_tx_alive: cpwm = 0x%02x alives = 0x%08x\n",
> -				  pwrctrl->cpwm, pwrctrl->alives));
> -
>  		if (pwrctrl->cpwm < pslv) {
>  			if (pwrctrl->cpwm < PS_STATE_S2)
>  				res = _FAIL;
> @@ -959,10 +926,6 @@ s32 rtw_register_cmd_alive(struct adapter *padapter)
>  	register_task_alive(pwrctrl, CMD_ALIVE);
>  
>  	if (pwrctrl->bFwCurrentInPSMode) {
> -		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_info_,
> -				 ("rtw_register_cmd_alive: cpwm = 0x%02x alives = 0x%08x\n",
> -				  pwrctrl->cpwm, pwrctrl->alives));
> -
>  		if (pwrctrl->cpwm < pslv) {
>  			if (pwrctrl->cpwm < PS_STATE_S2)
>  				res = _FAIL;
> @@ -1008,10 +971,6 @@ void rtw_unregister_tx_alive(struct adapter *padapter)
>  	unregister_task_alive(pwrctrl, XMIT_ALIVE);
>  
>  	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
> -		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
> -				 ("%s: cpwm = 0x%02x alives = 0x%08x\n",
> -				  __func__, pwrctrl->cpwm, pwrctrl->alives));
> -
>  		if (pwrctrl->cpwm > pslv)
>  			if ((pslv >= PS_STATE_S2) || (pwrctrl->alives == 0))
>  				rtw_set_rpwm(padapter, pslv);
> @@ -1048,10 +1007,6 @@ void rtw_unregister_cmd_alive(struct adapter *padapter)
>  	unregister_task_alive(pwrctrl, CMD_ALIVE);
>  
>  	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
> -		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_info_,
> -				 ("%s: cpwm = 0x%02x alives = 0x%08x\n",
> -				  __func__, pwrctrl->cpwm, pwrctrl->alives));
> -
>  		if (pwrctrl->cpwm > pslv) {
>  			if ((pslv >= PS_STATE_S2) || (pwrctrl->alives == 0))
>  				rtw_set_rpwm(padapter, pslv);
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 1fa381663b4c..b4ea2c3d0c37 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -326,10 +326,6 @@ signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvfra
>  	stainfo = rtw_get_stainfo(&adapter->stapriv, &prxattrib->ta[0]);
>  
>  	if (prxattrib->encrypt == _TKIP_) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic:prxattrib->encrypt == _TKIP_\n"));
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic:da = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
> -			prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2], prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5]));
> -
>  		/* calculate mic code */
>  		if (stainfo) {
>  			if (IS_MCAST(prxattrib->ra)) {
> @@ -337,28 +333,22 @@ signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvfra
>  				/* iv = precvframe->u.hdr.rx_data+prxattrib->hdrlen; */
>  				/* rxdata_key_idx =(((iv[3])>>6)&0x3) ; */
>  				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
> -
> -				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic: bcmc key\n"));
>  				/* DBG_871X("\n recvframe_chkmic: bcmc key psecuritypriv->dot118021XGrpKeyid(%d), pmlmeinfo->key_index(%d) , recv key_id(%d)\n", */
>  				/* psecuritypriv->dot118021XGrpKeyid, pmlmeinfo->key_index, rxdata_key_idx); */
>  
>  				if (psecuritypriv->binstallGrpkey == false) {
>  					res = _FAIL;
> -					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n"));
>  					DBG_871X("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n");
>  					goto exit;
>  				}
>  			} else {
>  				mickey = &stainfo->dot11tkiprxmickey.skey[0];
> -				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n recvframe_chkmic: unicast key\n"));
>  			}
>  
>  			datalen = precvframe->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len-prxattrib->icv_len-8;/* icv_len included the mic code */
>  			pframe = precvframe->u.hdr.rx_data;
>  			payload = pframe+prxattrib->hdrlen+prxattrib->iv_len;
>  
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n prxattrib->iv_len =%d prxattrib->icv_len =%d\n", prxattrib->iv_len, prxattrib->icv_len));
> -
>  
>  			rtw_seccalctkipmic(mickey, pframe, payload, datalen, &miccode[0], (unsigned char)prxattrib->priority); /* care the length of the data */
>  
> @@ -368,7 +358,6 @@ signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvfra
>  
>  			for (i = 0; i < 8; i++) {
>  				if (miccode[i] != *(pframemic+i)) {
> -					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic:miccode[%d](%02x) != *(pframemic+%d)(%02x) ", i, miccode[i], i, *(pframemic+i)));
>  					bmic_err = true;
>  				}
>  			}
> @@ -376,29 +365,12 @@ signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvfra
>  
>  			if (bmic_err == true) {
>  
> -				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n *(pframemic-8)-*(pframemic-1) = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
> -					*(pframemic-8), *(pframemic-7), *(pframemic-6), *(pframemic-5), *(pframemic-4), *(pframemic-3), *(pframemic-2), *(pframemic-1)));
> -				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n *(pframemic-16)-*(pframemic-9) = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
> -					*(pframemic-16), *(pframemic-15), *(pframemic-14), *(pframemic-13), *(pframemic-12), *(pframemic-11), *(pframemic-10), *(pframemic-9)));
> -
>  				{
>  					uint i;
> -					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ======demp packet (len =%d) ======\n", precvframe->u.hdr.len));
>  					for (i = 0; i < precvframe->u.hdr.len; i = i+8) {
> -						RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x",
> -							*(precvframe->u.hdr.rx_data+i), *(precvframe->u.hdr.rx_data+i+1),
> -							*(precvframe->u.hdr.rx_data+i+2), *(precvframe->u.hdr.rx_data+i+3),
> -							*(precvframe->u.hdr.rx_data+i+4), *(precvframe->u.hdr.rx_data+i+5),
> -							*(precvframe->u.hdr.rx_data+i+6), *(precvframe->u.hdr.rx_data+i+7)));
>  					}
> -					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ======demp packet end [len =%d]======\n", precvframe->u.hdr.len));
> -					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n hrdlen =%d,\n", prxattrib->hdrlen));
>  				}
>  
> -				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ra = 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x psecuritypriv->binstallGrpkey =%d ",
> -					prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2],
> -					prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5], psecuritypriv->binstallGrpkey));
> -
>  				/*  double check key_index for some timing issue , */
>  				/*  cannot compare with psecuritypriv->dot118021XGrpKeyid also cause timing issue */
>  				if ((IS_MCAST(prxattrib->ra) == true)  && (prxattrib->key_index != pmlmeinfo->key_index))
> @@ -406,10 +378,8 @@ signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvfra
>  
>  				if ((prxattrib->bdecrypted == true) && (brpt_micerror == true)) {
>  					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
> -					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted =%d ", prxattrib->bdecrypted));
>  					DBG_871X(" mic error :prxattrib->bdecrypted =%d\n", prxattrib->bdecrypted);
>  				} else {
> -					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted =%d ", prxattrib->bdecrypted));
>  					DBG_871X(" mic error :prxattrib->bdecrypted =%d\n", prxattrib->bdecrypted);
>  				}
>  
> @@ -419,12 +389,11 @@ signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvfra
>  				/* mic checked ok */
>  				if ((psecuritypriv->bcheck_grpkey == false) && (IS_MCAST(prxattrib->ra) == true)) {
>  					psecuritypriv->bcheck_grpkey = true;
> -					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("psecuritypriv->bcheck_grpkey =true"));
>  				}
>  			}
>  
>  		} else
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic: rtw_get_stainfo == NULL!!!\n"));
> +			{}
>  
>  		recvframe_pull_tail(precvframe, 8);
>  
> @@ -445,8 +414,6 @@ union recv_frame *decryptor(struct adapter *padapter, union recv_frame *precv_fr
>  	union recv_frame *return_packet = precv_frame;
>  	u32  res = _SUCCESS;
>  
> -	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("prxstat->decrypted =%x prxattrib->encrypt = 0x%03x\n", prxattrib->bdecrypted, prxattrib->encrypt));
> -
>  	if (prxattrib->encrypt > 0) {
>  		u8 *iv = precv_frame->u.hdr.rx_data+prxattrib->hdrlen;
>  		prxattrib->key_index = (((iv[3])>>6)&0x3);
> @@ -555,16 +522,10 @@ union recv_frame *portctrl(struct adapter *adapter, union recv_frame *precv_fram
>  
>  	psta = rtw_get_stainfo(pstapriv, psta_addr);
>  
> -	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:adapter->securitypriv.dot11AuthAlgrthm =%d\n", adapter->securitypriv.dot11AuthAlgrthm));
> -
>  	if (auth_alg == 2) {
>  		if ((psta) && (psta->ieee8021x_blocked)) {
>  			__be16 be_tmp;
>  
> -			/* blocked */
> -			/* only accept EAPOL frame */
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:psta->ieee8021x_blocked == 1\n"));
> -
>  			prtnframe = precv_frame;
>  
>  			/* get ether_type */
> @@ -580,13 +541,9 @@ union recv_frame *portctrl(struct adapter *adapter, union recv_frame *precv_fram
>  				prtnframe = NULL;
>  			}
>  		} else {
> -			/* allowed */
> -			/* check decryption status, and decrypt the frame if needed */
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:psta->ieee8021x_blocked == 0\n"));
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("portctrl:precv_frame->hdr.attrib.privacy =%x\n", precv_frame->u.hdr.attrib.privacy));
>  
>  			if (pattrib->bdecrypted == 0)
> -				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("portctrl:prxstat->decrypted =%x\n", pattrib->bdecrypted));
> +				{}
>  
>  			prtnframe = precv_frame;
>  			/* check is the EAPOL frame or not (Rekey) */
> @@ -615,15 +572,11 @@ signed int recv_decache(union recv_frame *precv_frame, u8 bretry, struct stainfo
>  		(precv_frame->u.hdr.attrib.frag_num & 0xf);
>  
>  	if (tid > 15) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_decache, (tid>15)! seq_ctrl = 0x%x, tid = 0x%x\n", seq_ctrl, tid));
> -
>  		return _FAIL;
>  	}
>  
>  	if (1) { /* if (bretry) */
>  		if (seq_ctrl == prxcache->tid_rxseq[tid]) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_decache, seq_ctrl = 0x%x, tid = 0x%x, tid_rxseq = 0x%x\n", seq_ctrl, tid, prxcache->tid_rxseq[tid]));
> -
>  			return _FAIL;
>  		}
>  	}
> @@ -777,7 +730,6 @@ signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *precv_f
>  
>  		/*  filter packets that SA is myself or multicast or broadcast */
>  		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA ==myself\n"));
>  			ret = _FAIL;
>  			goto exit;
>  		}
> @@ -799,7 +751,6 @@ signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *precv_f
>  	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
>  		/*  For Station mode, sa and bssid should always be BSSID, and DA is my mac-address */
>  		if (memcmp(pattrib->bssid, pattrib->src, ETH_ALEN)) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("bssid != TA under STATION_MODE; drop pkt\n"));
>  			ret = _FAIL;
>  			goto exit;
>  		}
> @@ -841,7 +792,6 @@ signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *precv_f
>  		*psta = rtw_get_stainfo(pstapriv, sta_addr); /*  get ap_info */
>  
>  	if (!*psta) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under sta2sta_data_frame ; drop pkt\n"));
>  		ret = _FAIL;
>  		goto exit;
>  	}
> @@ -871,7 +821,6 @@ signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *precv_fr
>  
>  		/*  filter packets that SA is myself or multicast or broadcast */
>  		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA ==myself\n"));
>  			#ifdef DBG_RX_DROP_FRAME
>  			DBG_871X("DBG_RX_DROP_FRAME %s SA =%pM, myhwaddr =%pM\n",
>  				__func__, MAC_ARG(pattrib->src), MAC_ARG(myhwaddr));
> @@ -882,8 +831,6 @@ signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *precv_fr
>  
>  		/*  da should be for me */
>  		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast)) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
> -				(" ap2sta_data_frame:  compare DA fail; DA =%pM\n", MAC_ARG(pattrib->dst)));
>  			#ifdef DBG_RX_DROP_FRAME
>  			DBG_871X("DBG_RX_DROP_FRAME %s DA =%pM\n", __func__, MAC_ARG(pattrib->dst));
>  			#endif
> @@ -896,9 +843,6 @@ signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *precv_fr
>  		if (!memcmp(pattrib->bssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
>  		     !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
>  		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
> -				(" ap2sta_data_frame:  compare BSSID fail ; BSSID =%pM\n", MAC_ARG(pattrib->bssid)));
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid =%pM\n", MAC_ARG(mybssid)));
>  			#ifdef DBG_RX_DROP_FRAME
>  			DBG_871X("DBG_RX_DROP_FRAME %s BSSID =%pM, mybssid =%pM\n",
>  				__func__, MAC_ARG(pattrib->bssid), MAC_ARG(mybssid));
> @@ -920,7 +864,6 @@ signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *precv_fr
>  			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get ap_info */
>  
>  		if (!*psta) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ap2sta: can't get psta under STATION_MODE ; drop pkt\n"));
>  			#ifdef DBG_RX_DROP_FRAME
>  			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under STATION_MODE ; drop pkt\n", __func__);
>  			#endif
> @@ -949,7 +892,6 @@ signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *precv_fr
>  
>  		*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
>  		if (!*psta) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under MP_MODE ; drop pkt\n"));
>  			#ifdef DBG_RX_DROP_FRAME
>  			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under WIFI_MP_STATE ; drop pkt\n", __func__);
>  			#endif
> @@ -1013,7 +955,6 @@ signed int sta2ap_data_frame(struct adapter *adapter, union recv_frame *precv_fr
>  
>  		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
>  		if (!*psta) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
>  			DBG_871X("issue_deauth to sta =%pM for the reason(7)\n", MAC_ARG(pattrib->src));
>  
>  			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
> @@ -1190,13 +1131,9 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
>  signed int validate_recv_mgnt_frame(struct adapter *padapter, union recv_frame *precv_frame);
>  signed int validate_recv_mgnt_frame(struct adapter *padapter, union recv_frame *precv_frame)
>  {
> -	/* struct mlme_priv *pmlmepriv = &adapter->mlmepriv; */
> -
> -	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+validate_recv_mgnt_frame\n"));
>  
>  	precv_frame = recvframe_chk_defrag(padapter, precv_frame);
>  	if (!precv_frame) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("%s: fragment packet\n", __func__));
>  		return _SUCCESS;
>  	}
>  
> @@ -1279,7 +1216,6 @@ signed int validate_recv_data_frame(struct adapter *adapter, union recv_frame *p
>  		memcpy(pattrib->ra, GetAddr1Ptr(ptr), ETH_ALEN);
>  		memcpy(pattrib->ta, GetAddr2Ptr(ptr), ETH_ALEN);
>  		ret = _FAIL;
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" case 3\n"));
>  		break;
>  
>  	default:
> @@ -1299,7 +1235,6 @@ signed int validate_recv_data_frame(struct adapter *adapter, union recv_frame *p
>  
>  
>  	if (!psta) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" after to_fr_ds_chk; psta == NULL\n"));
>  		#ifdef DBG_RX_DROP_FRAME
>  		DBG_871X("DBG_RX_DROP_FRAME %s psta == NULL\n", __func__);
>  		#endif
> @@ -1337,7 +1272,6 @@ signed int validate_recv_data_frame(struct adapter *adapter, union recv_frame *p
>  
>  	/*  decache, drop duplicate recv packets */
>  	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decache : drop pkt\n"));
>  		#ifdef DBG_RX_DROP_FRAME
>  		DBG_871X("DBG_RX_DROP_FRAME %s recv_decache return _FAIL\n", __func__);
>  		#endif
> @@ -1347,13 +1281,8 @@ signed int validate_recv_data_frame(struct adapter *adapter, union recv_frame *p
>  
>  	if (pattrib->privacy) {
>  
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("validate_recv_data_frame:pattrib->privacy =%x\n", pattrib->privacy));
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ^^^^^^^^^^^IS_MCAST(pattrib->ra(0x%02x)) =%d^^^^^^^^^^^^^^^6\n", pattrib->ra[0], IS_MCAST(pattrib->ra)));
> -
>  		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, IS_MCAST(pattrib->ra));
>  
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n pattrib->encrypt =%d\n", pattrib->encrypt));
> -
>  		SET_ICE_IV_LEN(pattrib->iv_len, pattrib->icv_len, pattrib->encrypt);
>  	} else {
>  		pattrib->encrypt = 0;
> @@ -1478,7 +1407,6 @@ signed int validate_recv_frame(struct adapter *adapter, union recv_frame *precv_
>  
>  	/* add version chk */
>  	if (ver != 0) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! (ver!= 0)\n"));
>  		retval = _FAIL;
>  		goto exit;
>  	}
> @@ -1513,13 +1441,13 @@ signed int validate_recv_frame(struct adapter *adapter, union recv_frame *precv_
>  
>  		retval = validate_recv_mgnt_frame(adapter, precv_frame);
>  		if (retval == _FAIL)
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_mgnt_frame fail\n"));
> +			{}
>  		retval = _FAIL; /*  only data frame return _SUCCESS */
>  		break;
>  	case WIFI_CTRL_TYPE: /* ctrl */
>  		retval = validate_recv_ctrl_frame(adapter, precv_frame);
>  		if (retval == _FAIL)
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_ctrl_frame fail\n"));
> +			{}
>  		retval = _FAIL; /*  only data frame return _SUCCESS */
>  		break;
>  	case WIFI_DATA_TYPE: /* data */
> @@ -1545,7 +1473,6 @@ signed int validate_recv_frame(struct adapter *adapter, union recv_frame *precv_
>  		}
>  		break;
>  	default:
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! type = 0x%x\n", type));
>  		#ifdef DBG_RX_DROP_FRAME
>  		DBG_871X("DBG_RX_DROP_FRAME validate_recv_data_frame fail! type = 0x%x\n", type);
>  		#endif
> @@ -1594,8 +1521,6 @@ signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
>  	rmv_len = pattrib->hdrlen + pattrib->iv_len + (bsnaphdr?SNAP_SIZE:0);
>  	len = precvframe->u.hdr.len - rmv_len;
>  
> -	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ===pattrib->hdrlen: %x,  pattrib->iv_len:%x ===\n\n", pattrib->hdrlen,  pattrib->iv_len));
> -
>  	memcpy(&be_tmp, ptr+rmv_len, 2);
>  	eth_type = ntohs(be_tmp); /* pattrib->ether_type */
>  	pattrib->eth_type = eth_type;
> @@ -1699,8 +1624,6 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
>  	/* free the defrag_q queue and return the prframe */
>  	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
>  
> -	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Performance defrag!!!!!\n"));
> -
>  	return prframe;
>  }
>  
> @@ -1758,9 +1681,6 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
>  			/* spin_lock(&pdefrag_q->lock); */
>  			phead = get_list_head(pdefrag_q);
>  			list_add_tail(&pfhdr->list, phead);
> -			/* spin_unlock(&pdefrag_q->lock); */
> -
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Enqueuq: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
>  
>  			prtnframe = NULL;
>  
> @@ -1768,7 +1688,6 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
>  			/* can't find this ta's defrag_queue, so free this recv_frame */
>  			rtw_free_recvframe(precv_frame, pfree_recv_queue);
>  			prtnframe = NULL;
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q == NULL: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
>  		}
>  
>  	}
> @@ -1783,7 +1702,6 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
>  			/* spin_unlock(&pdefrag_q->lock); */
>  
>  			/* call recvframe_defrag to defrag */
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("defrag: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
>  			precv_frame = recvframe_defrag(padapter, pdefrag_q);
>  			prtnframe = precv_frame;
>  
> @@ -1791,7 +1709,6 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
>  			/* can't find this ta's defrag_queue, so free this recv_frame */
>  			rtw_free_recvframe(precv_frame, pfree_recv_queue);
>  			prtnframe = NULL;
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q == NULL: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
>  		}
>  
>  	}
> @@ -1800,7 +1717,6 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
>  	if ((prtnframe) && (prtnframe->u.hdr.attrib.privacy)) {
>  		/* after defrag we must check tkip mic code */
>  		if (recvframe_chkmic(padapter,  prtnframe) == _FAIL) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic(padapter,  prtnframe) == _FAIL\n"));
>  			rtw_free_recvframe(prtnframe, pfree_recv_queue);
>  			prtnframe = NULL;
>  		}
> @@ -2067,10 +1983,6 @@ int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctr
>  		pattrib = &prframe->u.hdr.attrib;
>  
>  		if (!SN_LESS(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
> -				 ("recv_indicatepkts_in_order: indicate =%d seq =%d amsdu =%d\n",
> -				  preorder_ctrl->indicate_seq, pattrib->seq_num, pattrib->amsdu));
> -
>  			plist = get_next(plist);
>  			list_del_init(&(prframe->u.hdr.list));
>  
> @@ -2142,8 +2054,6 @@ int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *prframe
>  		if (pattrib->qos != 1) {
>  			if ((padapter->bDriverStopped == false) &&
>  			    (padapter->bSurpriseRemoved == false)) {
> -				RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@  recv_indicatepkt_reorder -recv_func recv_indicatepkt\n"));
> -
>  				rtw_recv_indicatepkt(padapter, prframe);
>  				return _SUCCESS;
>  
> @@ -2203,10 +2113,6 @@ int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *prframe
>  
>  	spin_lock_bh(&ppending_recvframe_queue->lock);
>  
> -	RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
> -		 ("recv_indicatepkt_reorder: indicate =%d seq =%d\n",
> -		  preorder_ctrl->indicate_seq, pattrib->seq_num));
> -
>  	/* s2. check if winstart_b(indicate_seq) needs to been updated */
>  	if (!check_indicate_seq(preorder_ctrl, pattrib->seq_num)) {
>  		pdbgpriv->dbg_rx_ampdu_drop_count++;
> @@ -2305,7 +2211,6 @@ int process_recv_indicatepkts(struct adapter *padapter, union recv_frame *prfram
>  	} else { /* B/G mode */
>  		retval = wlanhdr_to_ethhdr(prframe);
>  		if (retval != _SUCCESS) {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("wlanhdr_to_ethhdr: drop pkt\n"));
>  			#ifdef DBG_RX_DROP_FRAME
>  			DBG_871X("DBG_RX_DROP_FRAME %s wlanhdr_to_ethhdr error!\n", __func__);
>  			#endif
> @@ -2314,14 +2219,10 @@ int process_recv_indicatepkts(struct adapter *padapter, union recv_frame *prfram
>  
>  		if ((padapter->bDriverStopped == false) && (padapter->bSurpriseRemoved == false)) {
>  			/* indicate this recv_frame */
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@ process_recv_indicatepkts- recv_func recv_indicatepkt\n"));
>  			rtw_recv_indicatepkt(padapter, prframe);
>  
>  
>  		} else {
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@ process_recv_indicatepkts- recv_func free_indicatepkt\n"));
> -
> -			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_func:bDriverStopped(%d) OR bSurpriseRemoved(%d)", padapter->bDriverStopped, padapter->bSurpriseRemoved));
>  			retval = _FAIL;
>  			return retval;
>  		}
> @@ -2340,7 +2241,6 @@ static int recv_func_prehandle(struct adapter *padapter, union recv_frame *rfram
>  	/* check the frame crtl field and decache */
>  	ret = validate_recv_frame(padapter, rframe);
>  	if (ret != _SUCCESS) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("recv_func: validate_recv_frame fail! drop pkt\n"));
>  		rtw_free_recvframe(rframe, pfree_recv_queue);/* free this recv_frame */
>  		goto exit;
>  	}
> @@ -2358,7 +2258,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
>  
>  	prframe = decryptor(padapter, prframe);
>  	if (!prframe) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decryptor: drop pkt\n"));
>  		#ifdef DBG_RX_DROP_FRAME
>  		DBG_871X("DBG_RX_DROP_FRAME %s decryptor: drop pkt\n", __func__);
>  		#endif
> @@ -2368,7 +2267,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
>  
>  	prframe = recvframe_chk_defrag(padapter, prframe);
>  	if (!prframe)	{
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chk_defrag: drop pkt\n"));
>  		#ifdef DBG_RX_DROP_FRAME
>  		DBG_871X("DBG_RX_DROP_FRAME %s recvframe_chk_defrag: drop pkt\n", __func__);
>  		#endif
> @@ -2377,7 +2275,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
>  
>  	prframe = portctrl(padapter, prframe);
>  	if (!prframe) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("portctrl: drop pkt\n"));
>  		#ifdef DBG_RX_DROP_FRAME
>  		DBG_871X("DBG_RX_DROP_FRAME %s portctrl: drop pkt\n", __func__);
>  		#endif
> @@ -2389,7 +2286,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
>  
>  	ret = process_recv_indicatepkts(padapter, prframe);
>  	if (ret != _SUCCESS) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recv_func: process_recv_indicatepkts fail!\n"));
>  		#ifdef DBG_RX_DROP_FRAME
>  		DBG_871X("DBG_RX_DROP_FRAME %s process_recv_indicatepkts fail!\n", __func__);
>  		#endif
> @@ -2472,7 +2368,6 @@ s32 rtw_recv_entry(union recv_frame *precvframe)
>  
>  	ret = recv_func(padapter, precvframe);
>  	if (ret == _FAIL) {
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("rtw_recv_entry: recv_func return fail!!!\n"));
>  		goto _recv_entry_drop;
>  	}
>  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 44e2b362c867..dc35daefd866 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -296,14 +296,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  		*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
>  
>  		if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
> -			RT_TRACE(_module_rtl871x_security_c_,
> -				 _drv_err_,
> -				 ("%s:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
> -					__func__,
> -					crc[3], payload[length - 1],
> -					crc[2], payload[length - 2],
> -					crc[1], payload[length - 3],
> -					crc[0], payload[length - 4]));
>  		}
>  
>  		WEP_SW_DEC_CNT_INC(psecuritypriv, prxattrib->ra);
> @@ -670,8 +662,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  	if (pattrib->encrypt == _TKIP_) {
>  
>  		{
> -			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
> -
>  			if (IS_MCAST(pattrib->ra))
>  				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
>  			else
> @@ -692,7 +682,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  
>  				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
>  					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
> -					RT_TRACE(_module_rtl871x_security_c_, _drv_info_, ("pattrib->iv_len =%x, pattrib->icv_len =%x\n", pattrib->iv_len, pattrib->icv_len));
>  					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
>  
>  					arcfour_init(&mycontext, rc4key, 16);
> @@ -803,19 +792,11 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
>  
>  			if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
> -				RT_TRACE(_module_rtl871x_security_c_,
> -					 _drv_err_,
> -					 ("rtw_wep_decrypt:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
> -						crc[3], payload[length - 1],
> -						crc[2], payload[length - 2],
> -						crc[1], payload[length - 3],
> -						crc[0], payload[length - 4]));
>  				res = _FAIL;
>  			}
>  
>  			TKIP_SW_DEC_CNT_INC(psecuritypriv, prxattrib->ra);
>  		} else {
> -			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo == NULL!!!\n", __func__));
>  			res = _FAIL;
>  		}
>  	}
> @@ -1445,8 +1426,6 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  
>  	/* 4 start to encrypt each fragment */
>  	if (pattrib->encrypt == _AES_) {
> -		RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
> -
>  		if (IS_MCAST(pattrib->ra))
>  			prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
>  		else
> @@ -1678,13 +1657,6 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
>  	/* compare the mic */
>  	for (i = 0; i < 8; i++) {
>  		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
> -			RT_TRACE(_module_rtl871x_security_c_,
> -				 _drv_err_,
> -				 ("%s:mic check error mic[%d]: pframe(%x) != message(%x)\n",
> -					__func__,
> -					i,
> -					pframe[hdrlen + 8 + plen - 8 + i],
> -					message[hdrlen + 8 + plen - 8 + i]));
>  			DBG_871X("%s:mic check error mic[%d]: pframe(%x) != message(%x)\n",
>  					__func__,
>  					i,
> @@ -1716,10 +1688,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
>  	if (prxattrib->encrypt == _AES_) {
>  		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
>  		if (stainfo) {
> -			RT_TRACE(_module_rtl871x_security_c_,
> -				 _drv_err_,
> -				 ("%s: stainfo!= NULL!!!\n", __func__));
> -
>  			if (IS_MCAST(prxattrib->ra)) {
>  				static unsigned long start;
>  				static u32 no_gkey_bc_cnt;
> @@ -1774,9 +1742,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
>  
>  			AES_SW_DEC_CNT_INC(psecuritypriv, prxattrib->ra);
>  		} else {
> -			RT_TRACE(_module_rtl871x_security_c_,
> -				 _drv_err_,
> -				 ("%s: stainfo == NULL!!!\n", __func__));
>  			res = _FAIL;
>  		}
>  	}
> diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> index f96dd0b40e04..7dcac4dd9de2 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> @@ -216,10 +216,7 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
>  
>  		index = wifi_mac_hash(hwaddr);
>  
> -		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_, ("rtw_alloc_stainfo: index  = %x", index));
> -
>  		if (index >= NUM_STA) {
> -			RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("ERROR => rtw_alloc_stainfo: index >= NUM_STA"));
>  			spin_unlock_bh(&(pstapriv->sta_hash_lock));
>  			psta = NULL;
>  			goto exit;
> @@ -242,17 +239,6 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
>  		for (i = 0; i < 16; i++)
>  			memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i], &wRxSeqInitialValue, 2);
>  
> -		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
> -			 ("alloc number_%d stainfo  with hwaddr = %x %x %x %x %x %x \n",
> -			  pstapriv->asoc_sta_count,
> -			  hwaddr[0],
> -			  hwaddr[1],
> -			  hwaddr[2],
> -			  hwaddr[3],
> -			  hwaddr[4],
> -			  hwaddr[5])
> -		);
> -
>  		init_addba_retry_timer(pstapriv->padapter, psta);
>  
>  		/* for A-MPDU Rx reordering buffer control */
> @@ -363,16 +349,6 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
>  	spin_unlock_bh(&pxmitpriv->lock);
>  
>  	list_del_init(&psta->hash_list);
> -	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
> -		 ("\n free number_%d stainfo  with hwaddr = 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x \n",
> -		  pstapriv->asoc_sta_count,
> -		  psta->hwaddr[0],
> -		  psta->hwaddr[1],
> -		  psta->hwaddr[2],
> -		  psta->hwaddr[3],
> -		  psta->hwaddr[4],
> -		  psta->hwaddr[5])
> -	);
>  	pstapriv->asoc_sta_count--;
>  
>  	/*  re-init sta_info; 20061114 will be init in alloc_stainfo */
> @@ -543,7 +519,6 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
>  
>  	if (!psta) {
>  		res = _FAIL;
> -		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("rtw_alloc_stainfo fail"));
>  		goto exit;
>  	}
>  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> index bfd55a0356f5..fce854e9d5ce 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> @@ -1337,11 +1337,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
>  	memcpy(bssid->Ssid.Ssid, (p + 2), ssid_len);
>  	bssid->Ssid.SsidLength = ssid_len;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s bssid.Ssid.Ssid:%s bssid.Ssid.SsidLength:%d "
> -				"cur_network->network.Ssid.Ssid:%s len:%d\n", __func__, bssid->Ssid.Ssid,
> -				bssid->Ssid.SsidLength, cur_network->network.Ssid.Ssid,
> -				cur_network->network.Ssid.SsidLength));
> -
>  	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
>  			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
>  		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
> @@ -1358,9 +1353,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
>  	else
>  		bssid->Privacy = 0;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
> -			("%s(): cur_network->network.Privacy is %d, bssid.Privacy is %d\n",
> -			 __func__, cur_network->network.Privacy, bssid->Privacy));
>  	if (cur_network->network.Privacy != bssid->Privacy) {
>  		DBG_871X("%s(), privacy is not match\n", __func__);
>  		goto _mismatch;
> @@ -1386,24 +1378,16 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
>  		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
>  		if (pbuf && (wpa_ielen > 0)) {
>  			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
> -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
> -						("%s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is %d\n", __func__,
> -						 pairwise_cipher, group_cipher, is_8021x));
>  			}
>  		} else {
>  			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
>  
>  			if (pbuf && (wpa_ielen > 0)) {
>  				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
> -					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
> -							("%s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_802x is %d\n",
> -							 __func__, pairwise_cipher, group_cipher, is_8021x));
>  				}
>  			}
>  		}
>  
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
> -				("%s cur_network->group_cipher is %d: %d\n", __func__, cur_network->BcnInfo.group_cipher, group_cipher));
>  		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
>  			DBG_871X("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match\n", __func__,
>  					pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index 2daf5c461a4d..e453697ffe0c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -69,7 +69,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  
>  	if (!pxmitpriv->pallocated_frame_buf) {
>  		pxmitpriv->pxmit_frame_buf = NULL;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_frame fail!\n"));
>  		res = _FAIL;
>  		goto exit;
>  	}
> @@ -105,7 +104,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  	pxmitpriv->pallocated_xmitbuf = vzalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
>  
>  	if (!pxmitpriv->pallocated_xmitbuf) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_buf fail!\n"));
>  		res = _FAIL;
>  		goto exit;
>  	}
> @@ -155,7 +153,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  
>  	if (!pxmitpriv->xframe_ext_alloc_addr) {
>  		pxmitpriv->xframe_ext = NULL;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xframe_ext fail!\n"));
>  		res = _FAIL;
>  		goto exit;
>  	}
> @@ -188,7 +185,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  	pxmitpriv->pallocated_xmit_extbuf = vzalloc(NR_XMIT_EXTBUFF * sizeof(struct xmit_buf) + 4);
>  
>  	if (!pxmitpriv->pallocated_xmit_extbuf) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
>  		res = _FAIL;
>  		goto exit;
>  	}
> @@ -481,12 +477,9 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
>  	pattrib->mac_id = psta->mac_id;
>  
>  	if (psta->ieee8021x_blocked == true) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\n psta->ieee8021x_blocked == true\n"));
> -
>  		pattrib->encrypt = 0;
>  
>  		if ((pattrib->ether_type != 0x888e) && (check_fwstate(pmlmepriv, WIFI_MP_STATE) == false)) {
> -			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\npsta->ieee8021x_blocked == true,  pattrib->ether_type(%.4x) != 0x888e\n", pattrib->ether_type));
>  			#ifdef DBG_TX_DROP_FRAME
>  			DBG_871X("DBG_TX_DROP_FRAME %s psta->ieee8021x_blocked == true,  pattrib->ether_type(%04x) != 0x888e\n", __func__, pattrib->ether_type);
>  			#endif
> @@ -568,19 +561,11 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
>  	if (pattrib->encrypt > 0)
>  		memcpy(pattrib->dot118021x_UncstKey.skey, psta->dot118021x_UncstKey.skey, 16);
>  
> -	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
> -		("update_attrib: encrypt =%d  securitypriv.sw_encrypt =%d\n",
> -		pattrib->encrypt, padapter->securitypriv.sw_encrypt));
> -
>  	if (pattrib->encrypt &&
>  		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false))) {
>  		pattrib->bswenc = true;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
> -			("update_attrib: encrypt =%d securitypriv.hw_decrypted =%d bswenc =true\n",
> -			pattrib->encrypt, padapter->securitypriv.sw_encrypt));
>  	} else {
>  		pattrib->bswenc = false;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("update_attrib: bswenc =false\n"));
>  	}
>  
>  exit:
> @@ -685,7 +670,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
>  					((tmp[21] == 67) && (tmp[23] == 68))) {
>  					/*  68 : UDP BOOTP client */
>  					/*  67 : UDP BOOTP server */
> -					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("======================update_attrib: get DHCP Packet\n"));
>  					pattrib->dhcp_pkt = 1;
>  				}
>  			}
> @@ -720,7 +704,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
>  	} else {
>  		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
>  		if (!psta)	{ /*  if we cannot get psta => drop the pkt */
> -			RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:%pM\n", MAC_ARG(pattrib->ra)));
>  			#ifdef DBG_TX_DROP_FRAME
>  			DBG_871X("DBG_TX_DROP_FRAME %s get sta_info fail, ra:%pM\n", __func__, MAC_ARG(pattrib->ra));
>  			#endif
> @@ -734,7 +717,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
>  
>  	if (!psta) {
>  		/*  if we cannot get psta => drop the pkt */
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:%pM\n", MAC_ARG(pattrib->ra)));
>  		#ifdef DBG_TX_DROP_FRAME
>  		DBG_871X("DBG_TX_DROP_FRAME %s get sta_info fail, ra:%pM\n", __func__, MAC_ARG(pattrib->ra));
>  		#endif
> @@ -842,11 +824,8 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
>  
>  			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
>  				payload = (u8 *)round_up((SIZE_PTR)(payload), 4);
> -				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("===curfragnum =%d, pframe = 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x,!!!\n",
> -					curfragnum, *payload, *(payload+1), *(payload+2), *(payload+3), *(payload+4), *(payload+5), *(payload+6), *(payload+7)));
>  
>  				payload = payload+pattrib->hdrlen+pattrib->iv_len;
> -				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("curfragnum =%d pattrib->hdrlen =%d pattrib->iv_len =%d", curfragnum, pattrib->hdrlen, pattrib->iv_len));
>  				if ((curfragnum+1) == pattrib->nr_frags) {
>  					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
>  					rtw_secmicappend(&micdata, payload, length);
> @@ -855,26 +834,17 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
>  					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
>  					rtw_secmicappend(&micdata, payload, length);
>  					payload = payload+length+pattrib->icv_len;
> -					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("curfragnum =%d length =%d pattrib->icv_len =%d", curfragnum, length, pattrib->icv_len));
>  				}
>  			}
>  			rtw_secgetmic(&micdata, &mic[0]);
> -			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: before add mic code!!!\n"));
> -			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: pattrib->last_txcmdsz =%d!!!\n", pattrib->last_txcmdsz));
> -			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: mic[0]= 0x%.2x , mic[1]= 0x%.2x , mic[2]= 0x%.2x , mic[3]= 0x%.2x\n\
> -  mic[4]= 0x%.2x , mic[5]= 0x%.2x , mic[6]= 0x%.2x , mic[7]= 0x%.2x !!!!\n",
> -				mic[0], mic[1], mic[2], mic[3], mic[4], mic[5], mic[6], mic[7]));
>  			/* add mic code  and add the mic code length in last_txcmdsz */
>  
>  			memcpy(payload, &mic[0], 8);
>  			pattrib->last_txcmdsz += 8;
>  
> -			RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("\n ========last pkt ========\n"));
>  			payload = payload-pattrib->last_txcmdsz+8;
>  			for (curfragnum = 0; curfragnum < pattrib->last_txcmdsz; curfragnum = curfragnum+8)
> -					RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, (" %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x ",
> -					*(payload+curfragnum), *(payload+curfragnum+1), *(payload+curfragnum+2), *(payload+curfragnum+3),
> -					*(payload+curfragnum+4), *(payload+curfragnum+5), *(payload+curfragnum+6), *(payload+curfragnum+7)));
> +					{}
>  			}
>  /*
>  */
> @@ -887,7 +857,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
>  	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
>  
>  	if (pattrib->bswenc) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("### xmitframe_swencrypt\n"));
>  		switch (pattrib->encrypt) {
>  		case _WEP40_:
>  		case _WEP104_:
> @@ -903,7 +872,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
>  				break;
>  		}
>  	} else {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_, ("### xmitframe_hwencrypt\n"));
>  	}
>  
>  	return _SUCCESS;
> @@ -957,7 +925,6 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
>  			if (pattrib->qos_en)
>  				qos_option = true;
>  		} else {
> -			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
>  			res = _FAIL;
>  			goto exit;
>  		}
> @@ -1111,7 +1078,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
>  	mem_start = pbuf_start +	hw_hdr_offset;
>  
>  	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n"));
>  		DBG_8192C("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n");
>  		res = _FAIL;
>  		goto exit;
> @@ -1139,10 +1105,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
>  		if (pattrib->iv_len) {
>  			memcpy(pframe, pattrib->iv, pattrib->iv_len);
>  
> -			RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_,
> -				 ("rtw_xmitframe_coalesce: keyid =%d pattrib->iv[3]=%.2x pframe =%.2x %.2x %.2x %.2x\n",
> -				  padapter->securitypriv.dot11PrivacyKeyIndex, pattrib->iv[3], *pframe, *(pframe+1), *(pframe+2), *(pframe+3)));
> -
>  			pframe += pattrib->iv_len;
>  
>  			mpdu_len -= pattrib->iv_len;
> @@ -1183,7 +1145,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
>  
>  			break;
>  		} else {
> -			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: There're still something in packet!\n", __func__));
>  		}
>  
>  		addr = (SIZE_PTR)(pframe);
> @@ -1193,7 +1154,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
>  	}
>  
>  	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n"));
>  		DBG_8192C("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
>  		res = _FAIL;
>  		goto exit;
> @@ -1718,7 +1678,6 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
>  	spin_lock_bh(&pfree_xmit_queue->lock);
>  
>  	if (list_empty(&pfree_xmit_queue->queue)) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe:%d\n", pxmitpriv->free_xmitframe_cnt));
>  		pxframe =  NULL;
>  	} else {
>  		phead = get_list_head(pfree_xmit_queue);
> @@ -1729,7 +1688,6 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
>  
>  		list_del_init(&pxframe->list);
>  		pxmitpriv->free_xmitframe_cnt--;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe():free_xmitframe_cnt =%d\n", pxmitpriv->free_xmitframe_cnt));
>  	}
>  
>  	spin_unlock_bh(&pfree_xmit_queue->lock);
> @@ -1747,7 +1705,6 @@ struct xmit_frame *rtw_alloc_xmitframe_ext(struct xmit_priv *pxmitpriv)
>  	spin_lock_bh(&queue->lock);
>  
>  	if (list_empty(&queue->queue)) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe_ext:%d\n", pxmitpriv->free_xframe_ext_cnt));
>  		pxframe =  NULL;
>  	} else {
>  		phead = get_list_head(queue);
> @@ -1756,7 +1713,6 @@ struct xmit_frame *rtw_alloc_xmitframe_ext(struct xmit_priv *pxmitpriv)
>  
>  		list_del_init(&pxframe->list);
>  		pxmitpriv->free_xframe_ext_cnt--;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe_ext():free_xmitframe_cnt =%d\n", pxmitpriv->free_xframe_ext_cnt));
>  	}
>  
>  	spin_unlock_bh(&queue->lock);
> @@ -1802,7 +1758,6 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
>  	struct sk_buff *pndis_pkt = NULL;
>  
>  	if (!pxmitframe) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("======rtw_free_xmitframe():pxmitframe == NULL!!!!!!!!!!\n"));
>  		goto exit;
>  	}
>  
> @@ -1830,10 +1785,8 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
>  	list_add_tail(&pxmitframe->list, get_list_head(queue));
>  	if (pxmitframe->ext_tag == 0) {
>  		pxmitpriv->free_xmitframe_cnt++;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_debug_, ("rtw_free_xmitframe():free_xmitframe_cnt =%d\n", pxmitpriv->free_xmitframe_cnt));
>  	} else if (pxmitframe->ext_tag == 1) {
>  		pxmitpriv->free_xframe_ext_cnt++;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_debug_, ("rtw_free_xmitframe():free_xframe_ext_cnt =%d\n", pxmitpriv->free_xframe_ext_cnt));
>  	} else {
>  	}
>  
> @@ -1871,8 +1824,6 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
>  s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
>  {
>  	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
> -			 ("rtw_xmitframe_enqueue: drop xmit pkt for classifier fail\n"));
>  		return _FAIL;
>  	}
>  
> @@ -1888,21 +1839,18 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
>  	case 2:
>  		ptxservq = &psta->sta_xmitpriv.bk_q;
>  		*(ac) = 3;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BK\n"));
>  		break;
>  
>  	case 4:
>  	case 5:
>  		ptxservq = &psta->sta_xmitpriv.vi_q;
>  		*(ac) = 1;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : VI\n"));
>  		break;
>  
>  	case 6:
>  	case 7:
>  		ptxservq = &psta->sta_xmitpriv.vo_q;
>  		*(ac) = 0;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : VO\n"));
>  		break;
>  
>  	case 0:
> @@ -1910,7 +1858,6 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
>  	default:
>  		ptxservq = &psta->sta_xmitpriv.be_q;
>  		*(ac) = 2;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BE\n"));
>  	break;
>  	}
>  
> @@ -1939,7 +1886,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
>  	if (!psta) {
>  		res = _FAIL;
>  		DBG_8192C("rtw_xmit_classifier: psta == NULL\n");
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmit_classifier: psta == NULL\n"));
>  		goto exit;
>  	}
>  
> @@ -2059,7 +2005,6 @@ static void do_queue_select(struct adapter	*padapter, struct pkt_attrib *pattrib
>  	u8 qsel;
>  
>  	qsel = pattrib->priority;
> -	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("### do_queue_select priority =%d , qsel = %d\n", pattrib->priority, qsel));
>  
>  	pattrib->qsel = qsel;
>  }
> @@ -2096,14 +2041,12 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
>  
>  	if (!pxmitframe) {
>  		drop_cnt++;
> -		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: no more pxmitframe\n", __func__));
>  		return -1;
>  	}
>  
>  	res = update_attrib(padapter, *ppkt, &pxmitframe->attrib);
>  
>  	if (res == _FAIL) {
> -		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: update attrib fail\n", __func__));
>  		#ifdef DBG_TX_DROP_FRAME
>  		DBG_871X("DBG_TX_DROP_FRAME %s update attrib fail\n", __func__);
>  		#endif
> diff --git a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
> index 932b31fda6ad..b1f271c65c3e 100644
> --- a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
> +++ b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
> @@ -53,22 +53,6 @@ u8 HalPwrSeqCmdParsing(
>  	do {
>  		PwrCfgCmd = PwrSeqCmd[AryIdx];
>  
> -		RT_TRACE(
> -			_module_hal_init_c_,
> -			_drv_info_,
> -			(
> -				"HalPwrSeqCmdParsing: offset(%#x) cut_msk(%#x) fab_msk(%#x) interface_msk(%#x) base(%#x) cmd(%#x) msk(%#x) value(%#x)\n",
> -				GET_PWR_CFG_OFFSET(PwrCfgCmd),
> -				GET_PWR_CFG_CUT_MASK(PwrCfgCmd),
> -				GET_PWR_CFG_FAB_MASK(PwrCfgCmd),
> -				GET_PWR_CFG_INTF_MASK(PwrCfgCmd),
> -				GET_PWR_CFG_BASE(PwrCfgCmd),
> -				GET_PWR_CFG_CMD(PwrCfgCmd),
> -				GET_PWR_CFG_MASK(PwrCfgCmd),
> -				GET_PWR_CFG_VALUE(PwrCfgCmd)
> -			)
> -		);
> -
>  		/* 2 Only Handle the command whose FAB, CUT, and Interface are matched */
>  		if (
>  			(GET_PWR_CFG_FAB_MASK(PwrCfgCmd) & FabVersion) &&
> @@ -77,19 +61,9 @@ u8 HalPwrSeqCmdParsing(
>  		) {
>  			switch (GET_PWR_CFG_CMD(PwrCfgCmd)) {
>  			case PWR_CMD_READ:
> -				RT_TRACE(
> -					_module_hal_init_c_,
> -					_drv_info_,
> -					("HalPwrSeqCmdParsing: PWR_CMD_READ\n")
> -				);
>  				break;
>  
>  			case PWR_CMD_WRITE:
> -				RT_TRACE(
> -					_module_hal_init_c_,
> -					_drv_info_,
> -					("HalPwrSeqCmdParsing: PWR_CMD_WRITE\n")
> -				);
>  				offset = GET_PWR_CFG_OFFSET(PwrCfgCmd);
>  
>  				/*  */
> @@ -124,11 +98,6 @@ u8 HalPwrSeqCmdParsing(
>  				break;
>  
>  			case PWR_CMD_POLLING:
> -				RT_TRACE(
> -					_module_hal_init_c_,
> -					_drv_info_,
> -					("HalPwrSeqCmdParsing: PWR_CMD_POLLING\n")
> -				);
>  
>  				bPollingBit = false;
>  				offset = GET_PWR_CFG_OFFSET(PwrCfgCmd);
> @@ -160,11 +129,6 @@ u8 HalPwrSeqCmdParsing(
>  				break;
>  
>  			case PWR_CMD_DELAY:
> -				RT_TRACE(
> -					_module_hal_init_c_,
> -					_drv_info_,
> -					("HalPwrSeqCmdParsing: PWR_CMD_DELAY\n")
> -				);
>  				if (GET_PWR_CFG_VALUE(PwrCfgCmd) == PWRSEQ_DELAY_US)
>  					udelay(GET_PWR_CFG_OFFSET(PwrCfgCmd));
>  				else
> @@ -173,19 +137,9 @@ u8 HalPwrSeqCmdParsing(
>  
>  			case PWR_CMD_END:
>  				/*  When this command is parsed, end the process */
> -				RT_TRACE(
> -					_module_hal_init_c_,
> -					_drv_info_,
> -					("HalPwrSeqCmdParsing: PWR_CMD_END\n")
> -				);
>  				return true;
>  
>  			default:
> -				RT_TRACE(
> -					_module_hal_init_c_,
> -					_drv_err_,
> -					("HalPwrSeqCmdParsing: Unknown CMD!!\n")
> -				);
>  				break;
>  			}
>  		}
> diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
> index aa4356327636..7fbac4c8f2f8 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_intf.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
> @@ -108,8 +108,6 @@ uint rtw_hal_init(struct adapter *padapter)
>  		DBG_871X("rtw_hal_init: hal__init fail\n");
>  	}
>  
> -	RT_TRACE(_module_hal_init_c_, _drv_err_, ("-rtl871x_hal_init:status = 0x%x\n", status));
> -
>  	return status;
>  }
>  
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index 0081fe0a431f..fd5ab45e566e 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> @@ -65,17 +65,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
>  	remainSize_p1 = buffSize % blockSize_p1;
>  
>  	if (blockCount_p1) {
> -		RT_TRACE(
> -			_module_hal_init_c_,
> -			_drv_notice_,
> -			(
> -				"_BlockWrite: [P1] buffSize(%d) blockSize_p1(%d) blockCount_p1(%d) remainSize_p1(%d)\n",
> -				buffSize,
> -				blockSize_p1,
> -				blockCount_p1,
> -				remainSize_p1
> -			)
> -		);
>  	}
>  
>  	for (i = 0; i < blockCount_p1; i++) {
> @@ -94,17 +83,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
>  		remainSize_p2 = remainSize_p1%blockSize_p2;
>  
>  		if (blockCount_p2) {
> -				RT_TRACE(
> -					_module_hal_init_c_,
> -					_drv_notice_,
> -					(
> -						"_BlockWrite: [P2] buffSize_p2(%d) blockSize_p2(%d) blockCount_p2(%d) remainSize_p2(%d)\n",
> -						(buffSize-offset),
> -						blockSize_p2,
> -						blockCount_p2,
> -						remainSize_p2
> -					)
> -				);
>  		}
>  
>  	}
> @@ -115,10 +93,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
>  
>  		blockCount_p3 = remainSize_p2 / blockSize_p3;
>  
> -		RT_TRACE(_module_hal_init_c_, _drv_notice_,
> -				("_BlockWrite: [P3] buffSize_p3(%d) blockSize_p3(%d) blockCount_p3(%d)\n",
> -				(buffSize-offset), blockSize_p3, blockCount_p3));
> -
>  		for (i = 0; i < blockCount_p3; i++) {
>  			ret = rtw_write8(padapter, (FW_8723B_START_ADDRESS + offset + i), *(bufferPtr + offset + i));
>  
> @@ -181,7 +155,6 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
>  			goto exit;
>  		}
>  	}
> -	RT_TRACE(_module_hal_init_c_, _drv_info_, ("_WriteFW Done- for Normal chip.\n"));
>  
>  exit:
>  	return ret;
> @@ -334,10 +307,8 @@ void rtl8723b_FirmwareSelfReset(struct adapter *padapter)
>  			udelay(50);
>  			u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
>  		}
> -		RT_TRACE(_module_hal_init_c_, _drv_notice_, ("-%s: 8051 reset success (%d)\n", __func__, Delay));
>  
>  		if (Delay == 0) {
> -			RT_TRACE(_module_hal_init_c_, _drv_notice_, ("%s: Force 8051 reset!!!\n", __func__));
>  			/* force firmware reset */
>  			u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
>  			rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp&(~BIT2));
> @@ -368,7 +339,6 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
>  	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
>  	u8 tmp_ps;
>  
> -	RT_TRACE(_module_hal_init_c_, _drv_info_, ("+%s\n", __func__));
>  	pFirmware = kzalloc(sizeof(struct rt_firmware), GFP_KERNEL);
>  	if (!pFirmware)
>  		return _FAIL;
> @@ -409,11 +379,6 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
>  
>  	if (fw->size > FW_8723B_SIZE) {
>  		rtStatus = _FAIL;
> -		RT_TRACE(
> -			_module_hal_init_c_,
> -			_drv_err_,
> -			("Firmware size exceed 0x%X. Check it.\n", FW_8188E_SIZE)
> -		);
>  		goto exit;
>  	}
>  
> @@ -1948,12 +1913,6 @@ static void ResumeTxBeacon(struct adapter *padapter)
>  {
>  	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
>  
> -
> -	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
> -	/*  which should be read from register to a global variable. */
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+ResumeTxBeacon\n"));
> -
>  	pHalData->RegFwHwTxQCtrl |= BIT(6);
>  	rtw_write8(padapter, REG_FWHW_TXQ_CTRL+2, pHalData->RegFwHwTxQCtrl);
>  	rtw_write8(padapter, REG_TBTT_PROHIBIT+1, 0xff);
> @@ -1965,12 +1924,6 @@ static void StopTxBeacon(struct adapter *padapter)
>  {
>  	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
>  
> -
> -	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
> -	/*  which should be read from register to a global variable. */
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+StopTxBeacon\n"));
> -
>  	pHalData->RegFwHwTxQCtrl &= ~BIT(6);
>  	rtw_write8(padapter, REG_FWHW_TXQ_CTRL+2, pHalData->RegFwHwTxQCtrl);
>  	rtw_write8(padapter, REG_TBTT_PROHIBIT+1, 0x64);
> @@ -2314,7 +2267,6 @@ static bool Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
>  		else if (12 <= Channel && Channel <= 14)
>  			*pGroup = 4;
>  		else {
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("==>Hal_GetChnlGroup8723B in 2.4 G, but Channel %d in Group not found\n", Channel));
>  		}
>  	} else {
>  		bIn24G = false;
> @@ -2348,20 +2300,9 @@ static bool Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
>  		else if (173  <= Channel && Channel <= 177)
>  			*pGroup = 13;
>  		else {
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("==>Hal_GetChnlGroup8723B in 5G, but Channel %d in Group not found\n", Channel));
>  		}
>  
>  	}
> -	RT_TRACE(
> -		_module_hci_hal_init_c_,
> -		_drv_info_,
> -		(
> -			"<==Hal_GetChnlGroup8723B,  (%s) Channel = %d, Group =%d,\n",
> -			bIn24G ? "2.4G" : "5G",
> -			Channel,
> -			*pGroup
> -		)
> -	);
>  	return bIn24G;
>  }
>  
> @@ -2376,7 +2317,6 @@ void Hal_InitPGData(struct adapter *padapter, u8 *PROMContent)
>  			memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
>  		}
>  	} else {/* autoload fail */
> -		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("AutoLoad Fail reported from CR9346!!\n"));
>  		if (!pEEPROM->EepromOrEfuse)
>  			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
>  		memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
> @@ -2397,8 +2337,6 @@ void Hal_EfuseParseIDCode(struct adapter *padapter, u8 *hwinfo)
>  		pEEPROM->bautoload_fail_flag = true;
>  	} else
>  		pEEPROM->bautoload_fail_flag = false;
> -
> -	RT_TRACE(_module_hal_init_c_, _drv_notice_, ("EEPROM ID = 0x%04x\n", EEPROMId));
>  }
>  
>  static void Hal_ReadPowerValueFromPROM_8723B(
> @@ -2540,9 +2478,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
>  				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
>  			}
>  #ifdef DEBUG
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("======= Path %d, ChannelIndex %d, Group %d =======\n", rfPath, ch, group));
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]));
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]));
>  #endif
>  		}
>  
> @@ -2553,11 +2488,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
>  			pHalData->BW40_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW40_Diff[rfPath][TxCount];
>  
>  #ifdef DEBUG
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("--------------------------------------- 2.4G ---------------------------------------\n"));
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("CCK_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->CCK_24G_Diff[rfPath][TxCount]));
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("OFDM_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->OFDM_24G_Diff[rfPath][TxCount]));
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("BW20_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->BW20_24G_Diff[rfPath][TxCount]));
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("BW40_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->BW40_24G_Diff[rfPath][TxCount]));
>  #endif
>  		}
>  	}
> @@ -2569,8 +2499,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
>  			pHalData->EEPROMRegulatory = (EEPROM_DEFAULT_BOARD_OPTION&0x7);	/* bit0~2 */
>  	} else
>  		pHalData->EEPROMRegulatory = 0;
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROMRegulatory = 0x%x\n", pHalData->EEPROMRegulatory));
>  }
>  
>  void Hal_EfuseParseBTCoexistInfo_8723B(
> @@ -2660,8 +2588,6 @@ void Hal_EfuseParseEEPROMVer_8723B(
>  		pHalData->EEPROMVersion = hwinfo[EEPROM_VERSION_8723B];
>  	else
>  		pHalData->EEPROMVersion = 1;
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("Hal_EfuseParseEEPROMVer(), EEVer = %d\n",
> -		pHalData->EEPROMVersion));
>  }
>  
>  
> @@ -2728,8 +2654,6 @@ void Hal_EfuseParseChnlPlan_8723B(
>  	);
>  
>  	Hal_ChannelPlanToRegulation(padapter, padapter->mlmepriv.ChannelPlan);
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM ChannelPlan = 0x%02x\n", padapter->mlmepriv.ChannelPlan));
>  }
>  
>  void Hal_EfuseParseCustomerID_8723B(
> @@ -2743,8 +2667,6 @@ void Hal_EfuseParseCustomerID_8723B(
>  		pHalData->EEPROMCustomerID = hwinfo[EEPROM_CustomID_8723B];
>  	else
>  		pHalData->EEPROMCustomerID = 0;
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM Customer ID: 0x%2x\n", pHalData->EEPROMCustomerID));
>  }
>  
>  void Hal_EfuseParseAntennaDiversity_8723B(
> @@ -2768,8 +2690,6 @@ void Hal_EfuseParseXtal_8723B(
>  			pHalData->CrystalCap = EEPROM_Default_CrystalCap_8723B;	   /* what value should 8812 set? */
>  	} else
>  		pHalData->CrystalCap = EEPROM_Default_CrystalCap_8723B;
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM CrystalCap: 0x%2x\n", pHalData->CrystalCap));
>  }
>  
>  
> @@ -2792,8 +2712,6 @@ void Hal_EfuseParseThermalMeter_8723B(
>  		pHalData->bAPKThermalMeterIgnore = true;
>  		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_8723B;
>  	}
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter));
>  }
>  
>  
> @@ -3111,10 +3029,7 @@ static void rtl8723b_fill_default_txdesc(
>  			ptxdesc->sw_define = (u8)(GET_PRIMARY_ADAPTER(padapter)->xmitpriv.seq_no);
>  		}
>  	} else if (pxmitframe->frame_tag == TXAGG_FRAMETAG) {
> -		RT_TRACE(_module_hal_xmit_c_, _drv_warning_, ("%s: TXAGG_FRAMETAG\n", __func__));
>  	} else {
> -		RT_TRACE(_module_hal_xmit_c_, _drv_warning_, ("%s: frame_tag = 0x%x\n", __func__, pxmitframe->frame_tag));
> -
>  		ptxdesc->macid = pattrib->mac_id; /*  CAM_ID(MAC_ID) */
>  		ptxdesc->rate_id = pattrib->raid; /*  Rate ID */
>  		ptxdesc->qsel = pattrib->qsel;
> @@ -3588,7 +3503,6 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
>  		break;
>  	case C2H_DBG:
>  		{
> -			RT_TRACE(_module_hal_init_c_, _drv_info_, ("c2h_handler_8723b: %s\n", pC2hEvent->payload));
>  		}
>  		break;
>  
> @@ -3601,9 +3515,7 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
>  		break;
>  
>  	case C2H_HW_INFO_EXCH:
> -		RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], C2H_HW_INFO_EXCH\n"));
>  		for (index = 0; index < pC2hEvent->plen; index++) {
> -			RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], tmpBuf[%d]= 0x%x\n", index, pC2hEvent->payload[index]));
>  		}
>  		break;
>  
> @@ -3637,7 +3549,6 @@ static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC
>  		break;
>  	case C2H_DBG:
>  		{
> -			RT_TRACE(_module_hal_init_c_, _drv_info_, ("C2HCommandHandler: %s\n", c2hBuf));
>  		}
>  		break;
>  
> @@ -3650,9 +3561,7 @@ static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC
>  		break;
>  
>  	case C2H_HW_INFO_EXCH:
> -		RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], C2H_HW_INFO_EXCH\n"));
>  		for (index = 0; index < pC2hEvent->CmdLen; index++) {
> -			RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], tmpBuf[%d]= 0x%x\n", index, c2hBuf[index]));
>  		}
>  		break;
>  
> @@ -4054,7 +3963,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
>  			u32 usNavUpper = *((u32 *)val);
>  
>  			if (usNavUpper > HAL_NAV_UPPER_UNIT_8723B * 0xFF) {
> -				RT_TRACE(_module_hal_init_c_, _drv_notice_, ("The setting value (0x%08X us) of NAV_UPPER is larger than (%d * 0xFF)!!!\n", usNavUpper, HAL_NAV_UPPER_UNIT_8723B));
>  				break;
>  			}
>  
> @@ -4358,7 +4266,6 @@ void rtl8723b_start_thread(struct adapter *padapter)
>  
>  	xmitpriv->SdioXmitThread = kthread_run(rtl8723bs_xmit_thread, padapter, "RTWHALXT");
>  	if (IS_ERR(xmitpriv->SdioXmitThread)) {
> -		RT_TRACE(_module_hal_xmit_c_, _drv_err_, ("%s: start rtl8723bs_xmit_thread FAIL!!\n", __func__));
>  	}
>  }
>  
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> index 2abff4673be2..e5f0e48db557 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> @@ -551,7 +551,6 @@ void PHY_SetTxPowerIndex(
>  			break;
>  		}
>  	} else {
> -		RT_TRACE(_module_hal_init_c_, _drv_err_, ("Invalid RFPath!!\n"));
>  	}
>  }
>  
> @@ -604,11 +603,7 @@ void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 Channel)
>  		RFPath = pHalData->ant_path;
>  	}
>  
> -	RT_TRACE(_module_hal_init_c_, _drv_info_, ("==>PHY_SetTxPowerLevel8723B()\n"));
> -
>  	PHY_SetTxPowerLevelByPath(Adapter, Channel, RFPath);
> -
> -	RT_TRACE(_module_hal_init_c_, _drv_info_, ("<==PHY_SetTxPowerLevel8723B()\n"));
>  }
>  
>  void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel)
> @@ -648,23 +643,13 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
>  	u8 SCSettingOf40 = 0, SCSettingOf20 = 0;
>  	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
>  
> -	RT_TRACE(
> -		_module_hal_init_c_,
> -		_drv_info_,
> -		(
> -			"SCMapping: VHT Case: pHalData->CurrentChannelBW %d, pHalData->nCur80MhzPrimeSC %d, pHalData->nCur40MhzPrimeSC %d\n",
> -			pHalData->CurrentChannelBW,
> -			pHalData->nCur80MhzPrimeSC,
> -			pHalData->nCur40MhzPrimeSC
> -		)
> -	);
>  	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
>  		if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
>  			SCSettingOf40 = VHT_DATA_SC_40_LOWER_OF_80MHZ;
>  		else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
>  			SCSettingOf40 = VHT_DATA_SC_40_UPPER_OF_80MHZ;
>  		else
> -			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
> +			{}
>  
>  		if (
>  			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) &&
> @@ -687,27 +672,16 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
>  		)
>  			SCSettingOf20 = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
>  		else
> -			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
> +			{}
>  	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
> -		RT_TRACE(
> -			_module_hal_init_c_,
> -			_drv_info_,
> -			(
> -				"SCMapping: VHT Case: pHalData->CurrentChannelBW %d, pHalData->nCur40MhzPrimeSC %d\n",
> -				pHalData->CurrentChannelBW,
> -				pHalData->nCur40MhzPrimeSC
> -			)
> -		);
> -
>  		if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
>  			SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
>  		else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
>  			SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
>  		else
> -			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
> +			{}
>  	}
>  
> -	RT_TRACE(_module_hal_init_c_, _drv_info_, ("SCMapping: SC Value %x\n", ((SCSettingOf40 << 4) | SCSettingOf20)));
>  	return  (SCSettingOf40 << 4) | SCSettingOf20;
>  }
>  
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
> index 17a3e7bf66ef..d27d56920a11 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
> @@ -346,7 +346,6 @@ static void rtl8723bs_recv_tasklet(struct tasklet_struct *t)
>  						update_recvframe_phyinfo(precvframe, (struct phy_stat *)ptr);
>  
>  					if (rtw_recv_entry(precvframe) != _SUCCESS) {
> -						RT_TRACE(_module_rtl871x_recv_c_, _drv_dump_, ("%s: rtw_recv_entry(precvframe) != _SUCCESS\n", __func__));
>  					}
>  				} else if (pattrib->pkt_rpt_type == C2H_PACKET) {
>  					struct c2h_evt_hdr_t	C2hEvent;
> @@ -404,7 +403,6 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
>  	precvpriv->pallocated_recv_buf = rtw_zmalloc(n);
>  	if (!precvpriv->pallocated_recv_buf) {
>  		res = _FAIL;
> -		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("alloc recv_buf fail!\n"));
>  		goto exit;
>  	}
>  
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> index 597cf3a88c51..c18587cc78a5 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> @@ -102,11 +102,6 @@ static s32 rtl8723_dequeue_writeport(struct adapter *padapter)
>  		(padapter->bSurpriseRemoved) ||
>  		(padapter->bDriverStopped)
>  	) {
> -		RT_TRACE(
> -			_module_hal_xmit_c_,
> -			_drv_notice_,
> -			("%s: bSurpriseRemoved(write port)\n", __func__)
> -		);
>  		goto free_xmitbuf;
>  	}
>  
> @@ -151,16 +146,6 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
>  
>  	ret = (padapter->bDriverStopped) || (padapter->bSurpriseRemoved);
>  	if (ret) {
> -		RT_TRACE(
> -			_module_hal_xmit_c_,
> -			_drv_err_,
> -			(
> -				"%s: bDriverStopped(%d) bSurpriseRemoved(%d)!\n",
> -				__func__,
> -				padapter->bDriverStopped,
> -				padapter->bSurpriseRemoved
> -			)
> -		);
>  		return _FAIL;
>  	}
>  
> @@ -374,8 +359,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
>  
>  		/*  dump xmit_buf to hw tx fifo */
>  		if (pxmitbuf) {
> -			RT_TRACE(_module_hal_xmit_c_, _drv_info_, ("pxmitbuf->len =%d enqueue\n", pxmitbuf->len));
> -
>  			if (pxmitbuf->len > 0) {
>  				struct xmit_frame *pframe;
>  				pframe = (struct xmit_frame *)pxmitbuf->priv_data;
> @@ -424,16 +407,6 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
>  		(padapter->bDriverStopped) ||
>  		(padapter->bSurpriseRemoved)
>  	) {
> -		RT_TRACE(
> -			_module_hal_xmit_c_,
> -			_drv_notice_,
> -			(
> -				"%s: bDriverStopped(%d) bSurpriseRemoved(%d)\n",
> -				__func__,
> -				padapter->bDriverStopped,
> -				padapter->bSurpriseRemoved
> -			)
> -		);
>  		return _FAIL;
>  	}
>  
> @@ -492,8 +465,6 @@ int rtl8723bs_xmit_thread(void *context)
>  
>  	complete(&pxmitpriv->SdioXmitTerminate);
>  
> -	RT_TRACE(_module_hal_xmit_c_, _drv_notice_, ("-%s\n", __func__));
> -
>  	thread_exit();
>  }
>  
> @@ -509,8 +480,6 @@ s32 rtl8723bs_mgnt_xmit(
>  	u8 *pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
>  	u8 txdesc_size = TXDESC_SIZE;
>  
> -	RT_TRACE(_module_hal_xmit_c_, _drv_info_, ("+%s\n", __func__));
> -
>  	pattrib = &pmgntframe->attrib;
>  	pxmitbuf = pmgntframe->pxmitbuf;
>  
> @@ -572,7 +541,6 @@ s32 rtl8723bs_hal_xmit(
>  	err = rtw_xmitframe_enqueue(padapter, pxmitframe);
>  	spin_unlock_bh(&pxmitpriv->lock);
>  	if (err != _SUCCESS) {
> -		RT_TRACE(_module_hal_xmit_c_, _drv_err_, ("rtl8723bs_hal_xmit: enqueue xmitframe fail\n"));
>  		rtw_free_xmitframe(pxmitpriv, pxmitframe);
>  
>  		pxmitpriv->tx_drop++;
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> index b1c4bbf29790..faedeeffcead 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> @@ -57,11 +57,6 @@ u8 _InitPowerOn_8723BS(struct adapter *padapter)
>  	/*  only cmd52 can be used before power on(card enable) */
>  	ret = CardEnable(padapter);
>  	if (!ret) {
> -		RT_TRACE(
> -			_module_hci_hal_init_c_,
> -			_drv_emerg_,
> -			("%s: run power on flow fail\n", __func__)
> -		);
>  		return _FAIL;
>  	}
>  
> @@ -680,7 +675,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
>  
>  	ret = _InitPowerOn_8723BS(padapter);
>  	if (_FAIL == ret) {
> -		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init Power On!\n"));
>  		return _FAIL;
>  	}
>  
> @@ -688,12 +682,10 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
>  
>  	ret = rtl8723b_FirmwareDownload(padapter, false);
>  	if (ret != _SUCCESS) {
> -		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("%s: Download Firmware failed!!\n", __func__));
>  		padapter->bFWReady = false;
>  		pHalData->fw_ractrl = false;
>  		return ret;
>  	} else {
> -		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("rtl8723bs_hal_init(): Download Firmware Success!!\n"));
>  		padapter->bFWReady = true;
>  		pHalData->fw_ractrl = true;
>  	}
> @@ -719,7 +711,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
>  #if (HAL_MAC_ENABLE == 1)
>  	ret = PHY_MACConfig8723B(padapter);
>  	if (ret != _SUCCESS) {
> -		RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure MAC!!\n"));
>  		return ret;
>  	}
>  #endif
> @@ -729,7 +720,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
>  #if (HAL_BB_ENABLE == 1)
>  	ret = PHY_BBConfig8723B(padapter);
>  	if (ret != _SUCCESS) {
> -		RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure BB!!\n"));
>  		return ret;
>  	}
>  #endif
> @@ -741,7 +731,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
>  #if (HAL_RF_ENABLE == 1)
>  		ret = PHY_RFConfig8723B(padapter);
>  		if (ret != _SUCCESS) {
> -			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure RF!!\n"));
>  			return ret;
>  		}
>  #endif
> @@ -893,8 +882,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
>  	/*  Init BT hw config. */
>  	hal_btcoex_InitHwConfig(padapter, false);
>  
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("-%s\n", __func__));
> -
>  	return _SUCCESS;
>  }
>  
> @@ -1030,10 +1017,6 @@ static u32 rtl8723bs_inirp_init(struct adapter *padapter)
>  
>  static u32 rtl8723bs_inirp_deinit(struct adapter *padapter)
>  {
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+rtl8723bs_inirp_deinit\n"));
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("-rtl8723bs_inirp_deinit\n"));
> -
>  	return _SUCCESS;
>  }
>  
> @@ -1130,10 +1113,6 @@ static void Hal_EfuseParseMACAddr_8723BS(
>  		/* Read Permanent MAC address */
>  		memcpy(pEEPROM->mac_addr, &hwinfo[EEPROM_MAC_ADDR_8723BS], ETH_ALEN);
>  	}
> -/* 	NicIFSetMacAddress(padapter, padapter->PermanentAddress); */
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_,
> -		 ("Hal_EfuseParseMACAddr_8723BS: Permanent Address = %pM\n", pEEPROM->mac_addr));
>  }
>  
>  static void Hal_EfuseParseBoardType_8723BS(
> @@ -1148,7 +1127,6 @@ static void Hal_EfuseParseBoardType_8723BS(
>  			pHalData->BoardType = (EEPROM_DEFAULT_BOARD_OPTION & 0xE0) >> 5;
>  	} else
>  		pHalData->BoardType = 0;
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Board Type: 0x%2x\n", pHalData->BoardType));
>  }
>  
>  static void _ReadEfuseInfo8723BS(struct adapter *padapter)
> @@ -1156,8 +1134,6 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
>  	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
>  	u8 *hwinfo = NULL;
>  
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("====>_ReadEfuseInfo8723BS()\n"));
> -
>  	/*  */
>  	/*  This part read and parse the eeprom/efuse content */
>  	/*  */
> @@ -1191,8 +1167,6 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
>  	Hal_EfuseParseVoltage_8723B(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
>  
>  	Hal_ReadRFGainOffset(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
> -
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("<==== _ReadEfuseInfo8723BS()\n"));
>  }
>  
>  static void _ReadPROMContent(struct adapter *padapter)
> @@ -1205,12 +1179,6 @@ static void _ReadPROMContent(struct adapter *padapter)
>  	pEEPROM->EepromOrEfuse = (eeValue & BOOT_FROM_EEPROM) ? true : false;
>  	pEEPROM->bautoload_fail_flag = (eeValue & EEPROM_EN) ? false : true;
>  
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_,
> -		 ("%s: 9346CR = 0x%02X, Boot from %s, Autoload %s\n",
> -		  __func__, eeValue,
> -		  (pEEPROM->EepromOrEfuse ? "EEPROM" : "EFUSE"),
> -		  (pEEPROM->bautoload_fail_flag ? "Fail" : "OK")));
> -
>  /* 	pHalData->EEType = IS_BOOT_FROM_EEPROM(Adapter) ? EEPROM_93C46 : EEPROM_BOOT_EFUSE; */
>  
>  	_ReadEfuseInfo8723BS(padapter);
> @@ -1233,8 +1201,6 @@ static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
>  	u8 val8;
>  	unsigned long start;
>  
> -	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+_ReadAdapterInfo8723BS\n"));
> -
>  	/*  before access eFuse, make sure card enable has been called */
>  	if (!padapter->hw_init_completed)
>  		_InitPowerOn_8723BS(padapter);
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index 170a28f4b191..3d2288683461 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -777,30 +777,10 @@ void EnableInterrupt8723BSdio(struct adapter *adapter)
>  	himr = cpu_to_le32(haldata->sdio_himr);
>  	sdio_local_write(adapter, SDIO_REG_HIMR, 4, (u8 *)&himr);
>  
> -	RT_TRACE(
> -		_module_hci_ops_c_,
> -		_drv_notice_,
> -		(
> -			"%s: enable SDIO HIMR = 0x%08X\n",
> -			__func__,
> -			haldata->sdio_himr
> -		)
> -	);
> -
>  	/*  Update current system IMR settings */
>  	tmp = rtw_read32(adapter, REG_HSIMR);
>  	rtw_write32(adapter, REG_HSIMR, tmp | haldata->SysIntrMask);
>  
> -	RT_TRACE(
> -		_module_hci_ops_c_,
> -		_drv_notice_,
> -		(
> -			"%s: enable HSIMR = 0x%08X\n",
> -			__func__,
> -			haldata->SysIntrMask
> -		)
> -	);
> -
>  	/*  */
>  	/*  <Roger_Notes> There are some C2H CMDs have been sent before system interrupt is enabled, e.g., C2H, CPWM. */
>  	/*  So we need to clear all C2H events that FW has notified, otherwise FW won't schedule any commands anymore. */
> @@ -894,7 +874,6 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
>  	readbuf = recvbuf->pskb->data;
>  	ret = sdio_read_port(&adapter->iopriv.intf, WLAN_RX0FF_DEVICE_ID, readsize, readbuf);
>  	if (ret == _FAIL) {
> -		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("%s: read port FAIL!\n", __func__));
>  		return NULL;
>  	}
>  
> @@ -1064,9 +1043,6 @@ void sd_int_hdl(struct adapter *adapter)
>  
>  		sd_int_dpc(adapter);
>  	} else {
> -		RT_TRACE(_module_hci_ops_c_, _drv_err_,
> -				("%s: HISR(0x%08x) and HIMR(0x%08x) not match!\n",
> -				__func__, hal->sdio_hisr, hal->sdio_himr));
>  	}
>  }
>  
> @@ -1090,13 +1066,6 @@ u8 HalQueryTxBufferStatus8723BSdio(struct adapter *adapter)
>  	numof_free_page = SdioLocalCmd53Read4Byte(adapter, SDIO_REG_FREE_TXPG);
>  
>  	memcpy(hal->SdioTxFIFOFreePage, &numof_free_page, 4);
> -	RT_TRACE(_module_hci_ops_c_, _drv_notice_,
> -			("%s: Free page for HIQ(%#x), MIDQ(%#x), LOWQ(%#x), PUBQ(%#x)\n",
> -			__func__,
> -			hal->SdioTxFIFOFreePage[HI_QUEUE_IDX],
> -			hal->SdioTxFIFOFreePage[MID_QUEUE_IDX],
> -			hal->SdioTxFIFOFreePage[LOW_QUEUE_IDX],
> -			hal->SdioTxFIFOFreePage[PUBLIC_QUEUE_IDX]));
>  
>  	return true;
>  }
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index a577ddcce8cd..73d525ebe1fc 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -875,7 +875,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
>  
>  	if (strcmp(param->u.crypt.alg, "WEP") == 0)
>  	{
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
>  		DBG_8192C("wpa_set_encryption, crypt.alg = WEP\n");
>  
>  		wep_key_idx = param->u.crypt.idx;
> @@ -1798,7 +1797,6 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
>  	}
>  
>  	if (ielen < RSN_HEADER_LEN) {
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
>  		ret  = -1;
>  		goto exit;
>  	}
> @@ -1902,10 +1900,6 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
>  		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
>  		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
>  
> -	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
> -		("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
> -		pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
> -
>  exit:
>  	kfree(buf);
>  	if (ret)
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index 9909dece0b01..ed0a1c0ec6cb 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -232,8 +232,6 @@ static char *translate_scan(struct adapter *padapter,
>  		u16 wpa_len = 0, rsn_len = 0;
>  		u8 *p;
>  		rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
>  
>  		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
>  		if (!buf)
> @@ -423,7 +421,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  	}
>  
>  	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
>  		DBG_871X("wpa_set_encryption, crypt.alg = WEP\n");
>  
>  		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
> @@ -433,20 +430,16 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  		wep_key_idx = param->u.crypt.idx;
>  		wep_key_len = param->u.crypt.key_len;
>  
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(1)wep_key_idx =%d\n", wep_key_idx));
>  		DBG_871X("(1)wep_key_idx =%d\n", wep_key_idx);
>  
>  		if (wep_key_idx > WEP_KEYS)
>  			return -EINVAL;
>  
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(2)wep_key_idx =%d\n", wep_key_idx));
> -
>  		if (wep_key_len > 0) {
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
>  			pwep = kzalloc(wep_total_len, GFP_KERNEL);
>  			if (pwep == NULL) {
> -				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
>  				goto exit;
>  			}
>  
> @@ -612,7 +605,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
>  		}
>  
>  		if (ielen < RSN_HEADER_LEN) {
> -			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
>  			ret  = -1;
>  			goto exit;
>  		}
> @@ -715,10 +707,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
>                  /*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
>                  rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
>  
> -	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
> -		 ("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
> -		  pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
> -
>  exit:
>  
>  	kfree(buf);
> @@ -738,8 +726,6 @@ static int rtw_wx_get_name(struct net_device *dev,
>  	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
>  	NDIS_802_11_RATES_EX *prates = NULL;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cmd_code =%x\n", info->cmd));
> -
>  	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
>  		/* parsing HT_CAP_IE */
>  		p = rtw_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY, &ht_ielen, pcur_bss->IELength-12);
> @@ -785,8 +771,6 @@ static int rtw_wx_set_freq(struct net_device *dev,
>  			     struct iw_request_info *info,
>  			     union iwreq_data *wrqu, char *extra)
>  {
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_wx_set_freq\n"));
> -
>  	return 0;
>  }
>  
> @@ -850,7 +834,6 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
>  		break;
>  	default:
>  		ret = -EINVAL;
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported \n", iw_operation_mode[wrqu->mode]));
>  		goto exit;
>  	}
>  
> @@ -884,8 +867,6 @@ static int rtw_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
>  	struct adapter *padapter = rtw_netdev_priv(dev);
>  	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_get_mode\n"));
> -
>  	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
>  		wrqu->mode = IW_MODE_INFRA;
>  	} else if  ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
> @@ -999,8 +980,6 @@ static int rtw_wx_get_range(struct net_device *dev,
>  	u16 val;
>  	int i;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_range. cmd_code =%x\n", info->cmd));
> -
>  	wrqu->data.length = sizeof(*range);
>  	memset(range, 0, sizeof(*range));
>  
> @@ -1178,8 +1157,6 @@ static int rtw_wx_get_wap(struct net_device *dev,
>  
>  	eth_zero_addr(wrqu->ap_addr.sa_data);
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_wap\n"));
> -
>  	if  (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
>  			((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
>  			((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true)) {
> @@ -1232,7 +1209,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
>  	struct adapter *padapter = rtw_netdev_priv(dev);
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_set_scan\n"));
>  
>  	#ifdef DBG_IOCTL
>  	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
> @@ -1393,9 +1369,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
>  	u32 ret = 0;
>  	signed int wait_status;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan\n"));
> -	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, (" Start of Query SIOCGIWSCAN .\n"));
> -
>  	#ifdef DBG_IOCTL
>  	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
>  	#endif
> @@ -1477,9 +1450,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
>  	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
>  	#endif
>  
> -	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
> -		 ("+rtw_wx_set_essid: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
> -
>  	rtw_ps_deny(padapter, PS_DENY_JOIN);
>  	if (_FAIL == rtw_pwr_wakeup(padapter)) {
>  		ret = -1;
> @@ -1513,16 +1483,12 @@ static int rtw_wx_set_essid(struct net_device *dev,
>  		memcpy(ndis_ssid.Ssid, extra, len);
>  		src_ssid = ndis_ssid.Ssid;
>  
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("rtw_wx_set_essid: ssid =[%s]\n", src_ssid));
>  		spin_lock_bh(&queue->lock);
>  		phead = get_list_head(queue);
>  		pmlmepriv->pscanned = get_next(phead);
>  
>  		while (1) {
>  			if (phead == pmlmepriv->pscanned) {
> -			        RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_warning_,
> -					 ("rtw_wx_set_essid: scan_q is empty, set ssid to check if scanning again!\n"));
> -
>  				break;
>  			}
>  
> @@ -1532,15 +1498,8 @@ static int rtw_wx_set_essid(struct net_device *dev,
>  
>  			dst_ssid = pnetwork->network.Ssid.Ssid;
>  
> -			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
> -				 ("rtw_wx_set_essid: dst_ssid =%s\n",
> -				  pnetwork->network.Ssid.Ssid));
> -
>  			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)) &&
>  				(pnetwork->network.Ssid.SsidLength == ndis_ssid.SsidLength)) {
> -				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
> -					 ("rtw_wx_set_essid: find match, set infra mode\n"));
> -
>  				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
>  					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
>  						continue;
> @@ -1556,8 +1515,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
>  			}
>  		}
>  		spin_unlock_bh(&queue->lock);
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
> -			 ("set ssid: set_802_11_auth. mode =%d\n", authmode));
>  		rtw_set_802_11_authentication_mode(padapter, authmode);
>  		/* set_802_11_encryption_mode(padapter, padapter->securitypriv.ndisencryptstatus); */
>  		if (rtw_set_802_11_ssid(padapter, &ndis_ssid) == false) {
> @@ -1588,8 +1545,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
>  	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
>  	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_essid\n"));
> -
>  	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) ||
>  	      (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
>  		len = pcur_bss->Ssid.SsidLength;
> @@ -1620,9 +1575,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
>  	u32 ratevalue = 0;
>  	u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_set_rate\n"));
> -	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("target_rate = %d, fixed = %d\n", target_rate, fixed));
> -
>  	if (target_rate == -1) {
>  		ratevalue = 11;
>  		goto set_rate;
> @@ -1681,12 +1633,9 @@ static int rtw_wx_set_rate(struct net_device *dev,
>  		} else {
>  			datarates[i] = 0xff;
>  		}
> -
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("datarate_inx =%d\n", datarates[i]));
>  	}
>  
>  	if (rtw_setdatarate_cmd(padapter, datarates) != _SUCCESS) {
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("rtw_wx_set_rate Fail!!!\n"));
>  		ret = -1;
>  	}
>  	return ret;
> @@ -3180,8 +3129,6 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
>  			break;
>  		}
>  
> -		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("wpa_set_param:padapter->securitypriv.ndisauthtype =%d\n", padapter->securitypriv.ndisauthtype));
> -
>  		break;
>  
>  	case IEEE_PARAM_TKIP_COUNTERMEASURES:
> diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> index ba4d3789a41e..b46c086233bb 100644
> --- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> @@ -145,12 +145,8 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
>  	u8 *buff, *p, i;
>  	union iwreq_data wrqu;
>  
> -	RT_TRACE(_module_mlme_osdep_c_, _drv_info_, ("+rtw_report_sec_ie, authmode =%d\n", authmode));
> -
>  	buff = NULL;
>  	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
> -		RT_TRACE(_module_mlme_osdep_c_, _drv_info_, ("rtw_report_sec_ie, authmode =%d\n", authmode));
> -
>  		buff = rtw_zmalloc(IW_CUSTOM_MAX);
>  		if (NULL == buff) {
>  			DBG_871X(FUNC_ADPT_FMT ": alloc memory FAIL!!\n",
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 9ae7d46fb501..80bb5a0c0bc8 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -481,8 +481,6 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
>  	struct adapter *padapter;
>  	struct net_device *pnetdev;
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+init_net_dev\n"));
> -
>  	if (old_padapter)
>  		pnetdev = rtw_alloc_etherdev_with_old_priv(sizeof(struct adapter), (void *)old_padapter);
>  	else
> @@ -531,7 +529,6 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
>  {
>  	u32 _status = _SUCCESS;
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_start_drv_threads\n"));
>  	padapter->xmitThread = kthread_run(rtw_xmit_thread, padapter, "RTW_XMIT_THREAD");
>  	if (IS_ERR(padapter->xmitThread))
>  		_status = _FAIL;
> @@ -548,14 +545,11 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
>  
>  void rtw_stop_drv_threads(struct adapter *padapter)
>  {
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_stop_drv_threads\n"));
> -
>  	rtw_stop_cmd_thread(padapter);
>  
>  	/*  Below is to termindate tx_thread... */
>  	complete(&padapter->xmitpriv.xmit_comp);
>  	wait_for_completion(&padapter->xmitpriv.terminate_xmitthread_comp);
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("\n drv_halt: rtw_xmit_thread can be terminated !\n"));
>  
>  	rtw_hal_stop_thread(padapter);
>  }
> @@ -699,14 +693,11 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>  {
>  	u8 ret8 = _SUCCESS;
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
> -
>  	rtw_init_default_value(padapter);
>  
>  	rtw_init_hal_com_default_value(padapter);
>  
>  	if (rtw_init_cmd_priv(&padapter->cmdpriv)) {
> -		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init cmd_priv\n"));
>  		ret8 = _FAIL;
>  		goto exit;
>  	}
> @@ -714,14 +705,12 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>  	padapter->cmdpriv.padapter = padapter;
>  
>  	if (rtw_init_evt_priv(&padapter->evtpriv)) {
> -		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init evt_priv\n"));
>  		ret8 = _FAIL;
>  		goto exit;
>  	}
>  
>  
>  	if (rtw_init_mlme_priv(padapter) == _FAIL) {
> -		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_priv\n"));
>  		ret8 = _FAIL;
>  		goto exit;
>  	}
> @@ -762,29 +751,21 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>  
>  exit:
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_init_drv_sw\n"));
> -
>  	return ret8;
>  }
>  
>  void rtw_cancel_all_timer(struct adapter *padapter)
>  {
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_cancel_all_timer\n"));
> -
>  	del_timer_sync(&padapter->mlmepriv.assoc_timer);
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel association timer complete!\n"));
>  
>  	del_timer_sync(&padapter->mlmepriv.scan_to_timer);
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel scan_to_timer!\n"));
>  
>  	del_timer_sync(&padapter->mlmepriv.dynamic_chk_timer);
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel dynamic_chk_timer!\n"));
>  
>  	del_timer_sync(&(adapter_to_pwrctl(padapter)->pwr_state_check_timer));
>  
>  	del_timer_sync(&padapter->mlmepriv.set_scan_deny_timer);
>  	rtw_clear_scan_deny(padapter);
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel set_scan_deny_timer!\n"));
>  
>  	del_timer_sync(&padapter->recvpriv.signal_stat_timer);
>  
> @@ -794,8 +775,6 @@ void rtw_cancel_all_timer(struct adapter *padapter)
>  
>  u8 rtw_free_drv_sw(struct adapter *padapter)
>  {
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>rtw_free_drv_sw"));
> -
>  	free_mlme_ext_priv(&padapter->mlmeextpriv);
>  
>  	rtw_free_cmd_priv(&padapter->cmdpriv);
> @@ -818,8 +797,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
>  
>  	rtw_hal_free_data(padapter);
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("<==rtw_free_drv_sw\n"));
> -
>  	/* free the old_pnetdev */
>  	if (padapter->rereg_nd_name_priv.old_pnetdev) {
>  		free_netdev(padapter->rereg_nd_name_priv.old_pnetdev);
> @@ -830,8 +807,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
>  	if (padapter->pbuddy_adapter)
>  		padapter->pbuddy_adapter->pbuddy_adapter = NULL;
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_free_drv_sw\n"));
> -
>  	return _SUCCESS;
>  }
>  
> @@ -881,7 +856,6 @@ int _netdev_open(struct net_device *pnetdev)
>  	struct adapter *padapter = rtw_netdev_priv(pnetdev);
>  	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+871x_drv - dev_open\n"));
>  	DBG_871X("+871x_drv - drv_open, bup =%d\n", padapter->bup);
>  
>  	padapter->netif_up = true;
> @@ -898,7 +872,6 @@ int _netdev_open(struct net_device *pnetdev)
>  
>  		status = rtw_hal_init(padapter);
>  		if (status == _FAIL) {
> -			RT_TRACE(_module_os_intfs_c_, _drv_err_, ("rtl871x_hal_init(): Can't init h/w!\n"));
>  			goto netdev_open_error;
>  		}
>  
> @@ -929,7 +902,6 @@ int _netdev_open(struct net_device *pnetdev)
>  
>  netdev_open_normal_process:
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-871x_drv - dev_open\n"));
>  	DBG_871X("-871x_drv - drv_open, bup =%d\n", padapter->bup);
>  
>  	return 0;
> @@ -941,7 +913,6 @@ int _netdev_open(struct net_device *pnetdev)
>  	netif_carrier_off(pnetdev);
>  	rtw_netif_stop_queue(pnetdev);
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_err_, ("-871x_drv - dev_open, fail!\n"));
>  	DBG_871X("-871x_drv - drv_open fail, bup =%d\n", padapter->bup);
>  
>  	return (-1);
> @@ -980,7 +951,6 @@ static int  ips_netdrv_open(struct adapter *padapter)
>  
>  	status = rtw_hal_init(padapter);
>  	if (status == _FAIL) {
> -		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("ips_netdrv_open(): Can't init h/w!\n"));
>  		goto netdev_open_error;
>  	}
>  
> @@ -1053,8 +1023,6 @@ static int netdev_close(struct net_device *pnetdev)
>  	struct adapter *padapter = rtw_netdev_priv(pnetdev);
>  	struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+871x_drv - drv_close\n"));
> -
>  	if (pwrctl->bInternalAutoSuspend) {
>  		/* rtw_pwr_wakeup(padapter); */
>  		if (pwrctl->rf_pwrstate == rf_off)
> @@ -1095,7 +1063,6 @@ static int netdev_close(struct net_device *pnetdev)
>  	rtw_scan_abort(padapter);
>  	adapter_wdev_data(padapter)->bandroid_scan = false;
>  
> -	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-871x_drv - drv_close\n"));
>  	DBG_871X("-871x_drv - drv_close, bup =%d\n", padapter->bup);
>  
>  	return 0;
> @@ -1116,8 +1083,6 @@ void rtw_dev_unload(struct adapter *padapter)
>  	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
>  	u8 cnt = 0;
>  
> -	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+%s\n", __func__));
> -
>  	if (padapter->bup) {
>  
>  		padapter->bDriverStopped = true;
> @@ -1127,8 +1092,6 @@ void rtw_dev_unload(struct adapter *padapter)
>  		if (padapter->intf_stop)
>  			padapter->intf_stop(padapter);
>  
> -		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ rtw_dev_unload: stop intf complete!\n"));
> -
>  		if (!pwrctl->bInternalAutoSuspend)
>  			rtw_stop_drv_threads(padapter);
>  
> @@ -1143,8 +1106,6 @@ void rtw_dev_unload(struct adapter *padapter)
>  			}
>  		}
>  
> -		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ %s: stop thread complete!\n", __func__));
> -
>  		/* check the status of IPS */
>  		if (rtw_hal_check_ips_status(padapter) || pwrctl->rf_pwrstate == rf_off) {
>  			/* check HW status and SW state */
> @@ -1163,17 +1124,12 @@ void rtw_dev_unload(struct adapter *padapter)
>  
>  			padapter->bSurpriseRemoved = true;
>  		}
> -		RT_TRACE(_module_hci_intfs_c_, _drv_notice_,
> -			 ("@ %s: deinit hal complete!\n", __func__));
>  
>  		padapter->bup = false;
>  
>  	} else {
> -		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("%s: bup ==false\n", __func__));
>  		DBG_871X("%s: bup ==false\n", __func__);
>  	}
> -
> -	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("-%s\n", __func__));
>  }
>  
>  static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
> @@ -1332,14 +1288,12 @@ static int rtw_resume_process_normal(struct adapter *padapter)
>  	/* if (sdio_init(adapter_to_dvobj(padapter)) != _SUCCESS) */
>  	if ((padapter->intf_init) && (padapter->intf_init(adapter_to_dvobj(padapter)) != _SUCCESS)) {
>  		ret = -1;
> -		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: initialize SDIO Failed!!\n", __func__));
>  		goto exit;
>  	}
>  	rtw_hal_disable_interrupt(padapter);
>  	/* if (sdio_alloc_irq(adapter_to_dvobj(padapter)) != _SUCCESS) */
>  	if ((padapter->intf_alloc_irq) && (padapter->intf_alloc_irq(adapter_to_dvobj(padapter)) != _SUCCESS)) {
>  		ret = -1;
> -		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: sdio_alloc_irq Failed!!\n", __func__));
>  		goto exit;
>  	}
>  
> diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
> index 843003b91ea2..7b2aad346d20 100644
> --- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
> +++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
> @@ -161,7 +161,6 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
>  		ret = register_netdevice(pnetdev);
>  
>  	if (ret != 0) {
> -		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("register_netdev() failed\n"));
>  		goto error;
>  	}
>  
> diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
> index fbdbcd04d44a..a2a28803c8d9 100644
> --- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
> @@ -202,22 +202,15 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
>  
>  	skb = precv_frame->u.hdr.pkt;
>  	if (skb == NULL) {
> -		RT_TRACE(_module_recv_osdep_c_, _drv_err_, ("rtw_recv_indicatepkt():skb == NULL something wrong!!!!\n"));
>  		goto _recv_indicatepkt_drop;
>  	}
>  
> -	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("rtw_recv_indicatepkt():skb != NULL !!!\n"));
> -	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("rtw_recv_indicatepkt():precv_frame->u.hdr.rx_head =%p  precv_frame->hdr.rx_data =%p\n", precv_frame->u.hdr.rx_head, precv_frame->u.hdr.rx_data));
> -	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("precv_frame->hdr.rx_tail =%p precv_frame->u.hdr.rx_end =%p precv_frame->hdr.len =%d\n", precv_frame->u.hdr.rx_tail, precv_frame->u.hdr.rx_end, precv_frame->u.hdr.len));
> -
>  	skb->data = precv_frame->u.hdr.rx_data;
>  
>  	skb_set_tail_pointer(skb, precv_frame->u.hdr.len);
>  
>  	skb->len = precv_frame->u.hdr.len;
>  
> -	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("\n skb->head =%p skb->data =%p skb->tail =%p skb->end =%p skb->len =%d\n", skb->head, skb->data, skb_tail_pointer(skb), skb_end_pointer(skb), skb->len));
> -
>  	rtw_os_recv_indicate_pkt(padapter, skb, pattrib);
>  
>  	/* pointers to NULL before rtw_free_recvframe() */
> @@ -225,8 +218,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
>  
>  	rtw_free_recvframe(precv_frame, pfree_recv_queue);
>  
> -	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("\n rtw_recv_indicatepkt :after rtw_os_recv_indicate_pkt!!!!\n"));
> -
>  	return _SUCCESS;
>  
>  _recv_indicatepkt_drop:
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 8f8549eee23e..daca82d4b929 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -159,9 +159,6 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
>  	struct sdio_func *func;
>  	int err;
>  
> -
> -	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+sdio_deinit\n"));
> -
>  	func = dvobj->intf_data.func;
>  
>  	if (func) {
> @@ -201,7 +198,6 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
>  	psdio->func = func;
>  
>  	if (sdio_init(dvobj) != _SUCCESS) {
> -		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: initialize SDIO Failed!\n", __func__));
>  		goto free_dvobj;
>  	}
>  	rtw_reset_continual_io_error(dvobj);
> @@ -306,8 +302,6 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
>  	padapter->intf_free_irq = &sdio_free_irq;
>  
>  	if (rtw_init_io_priv(padapter, sdio_set_intf_ops) == _FAIL) {
> -		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
> -			("rtw_drv_init: Can't init io_priv\n"));
>  		goto free_hal_data;
>  	}
>  
> @@ -322,8 +316,6 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
>  
>  	/* 3 7. init driver common data */
>  	if (rtw_init_drv_sw(padapter) == _FAIL) {
> -		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
> -			 ("rtw_drv_init: Initialize driver software resource Failed!\n"));
>  		goto free_hal_data;
>  	}
>  
> @@ -406,7 +398,6 @@ static int rtw_drv_init(
>  
>  	dvobj = sdio_dvobj_init(func);
>  	if (dvobj == NULL) {
> -		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("initialize device object priv Failed!\n"));
>  		goto exit;
>  	}
>  
> @@ -424,8 +415,6 @@ static int rtw_drv_init(
>  	if (sdio_alloc_irq(dvobj) != _SUCCESS)
>  		goto free_if2;
>  
> -	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-871x_drv - drv_init, success!\n"));
> -
>  	rtw_ndev_notifier_register();
>  	status = _SUCCESS;
>  
> @@ -447,8 +436,6 @@ static void rtw_dev_remove(struct sdio_func *func)
>  	struct dvobj_priv *dvobj = sdio_get_drvdata(func);
>  	struct adapter *padapter = dvobj->if1;
>  
> -	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+rtw_dev_remove\n"));
> -
>  	dvobj->processing_dev_remove = true;
>  
>  	rtw_unregister_netdevs(dvobj);
> @@ -478,8 +465,6 @@ static void rtw_dev_remove(struct sdio_func *func)
>  	rtw_sdio_if1_deinit(padapter);
>  
>  	sdio_dvobj_deinit(func);
> -
> -	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("-rtw_dev_remove\n"));
>  }
>  
>  extern int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
> diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> index a3b6584ca0d0..610da93ac188 100644
> --- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> @@ -196,10 +196,7 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	s32 res = 0;
>  
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("+xmit_enry\n"));
> -
>  	if (rtw_if_up(padapter) == false) {
> -		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("rtw_xmit_entry: rtw_if_up fail\n"));
>  		#ifdef DBG_TX_DROP_FRAME
>  		DBG_871X("DBG_TX_DROP_FRAME %s if_up fail\n", __func__);
>  		#endif
> @@ -232,13 +229,11 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
>  		goto drop_packet;
>  	}
>  
> -	RT_TRACE(_module_xmit_osdep_c_, _drv_info_, ("rtw_xmit_entry: tx_pkts =%d\n", (u32)pxmitpriv->tx_pkts));
>  	goto exit;
>  
>  drop_packet:
>  	pxmitpriv->tx_drop++;
>  	dev_kfree_skb_any(pkt);
> -	RT_TRACE(_module_xmit_osdep_c_, _drv_notice_, ("rtw_xmit_entry: drop, tx_drop =%d\n", (u32)pxmitpriv->tx_drop));
>  
>  exit:
>  	return 0;
> 
> $ $ git diff | ./scripts/checkpatch.pl
> ERROR: that open brace { should be on the previous line
> #82: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:665:
>  	if (pmlmepriv->assoc_ssid.SsidLength == 0)
> +		{}
> 
> ERROR: that open brace { should be on the previous line
> #85: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:667:
>  	else
> +		{}
> 
> ERROR: that open brace { should be on the previous line
> #94: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:755:
>  	if (pmlmepriv->assoc_ssid.SsidLength == 0)
> +		{}
> 
> ERROR: that open brace { should be on the previous line
> #97: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:757:
>  	else
> +		{}
> 
> ERROR: that open brace { should be on the previous line
> #613: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:464:
>  		if (check_fwstate(pmlmepriv, (_FW_UNDER_SURVEY|_FW_UNDER_LINKING)) == true)
> +			{}
> 
> ERROR: that open brace { should be on the previous line
> #616: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:466:
>  		else
> +			{}
> 
> ERROR: that open brace { should be on the previous line
> #771: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:841:
>  					if (rtw_createbss_cmd(adapter) != _SUCCESS)
> +						{}
> 
> ERROR: that open brace { should be on the previous line
> #788: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:950:
>  	else
> +		{}
> 
> ERROR: that open brace { should be on the previous line
> #858: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:1262:
>  	if (pmlmepriv->assoc_ssid.SsidLength == 0)
> +		{}
> 
> ERROR: that open brace { should be on the previous line
> #861: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:1264:
>  	else
> +		{}
> 
> ERROR: that open brace { should be on the previous line
> #952: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:1614:
>  			if (rtw_createbss_cmd(adapter) != _SUCCESS)
> +				{}
> 
> ERROR: that open brace { should be on the previous line
> #1368: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:395:
>  		} else
> +			{}
> 
> ERROR: that open brace { should be on the previous line
> #1409: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:545:
>  			if (pattrib->bdecrypted == 0)
> +				{}
> 
> ERROR: that open brace { should be on the previous line
> #1569: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:1443:
>  		if (retval == _FAIL)
> +			{}
> 
> ERROR: that open brace { should be on the previous line
> #1576: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:1449:
>  		if (retval == _FAIL)
> +			{}
> 
> ERROR: that open brace { should be on the previous line
> #2086: FILE: drivers/staging/rtl8723bs/core/rtw_xmit.c:846:
>  			for (curfragnum = 0; curfragnum < pattrib->last_txcmdsz; curfragnum = curfragnum+8)
> +					{}
> 
> ERROR: that open brace { should be on the previous line
> #2722: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:651:
>  		else
> +			{}
> 
> ERROR: that open brace { should be on the previous line
> #2731: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:674:
>  		else
> +			{}
> 
> ERROR: that open brace { should be on the previous line
> #2749: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:681:
>  		else
> +			{}
> 
> total: 19 errors, 0 warnings, 0 checks, 3295 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> Your patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 

thank you Joe, this mail is so precious ;)

regards,

fabio
