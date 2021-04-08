Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5441D358350
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhDHMbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhDHMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:31:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA871C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 05:31:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w23so2192717edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gym23n3kGjGPozjpdEEgiFjUAV/Ah9a8RiDZDRT6MTg=;
        b=QZjFGmNWe1Fn1wg37pYJ4+/w15e/JT9fdQEpiLnREO5vkzH4PmdkFxR60o2C+S0bYP
         eAhrYFSGwb5I6oAEaKFj5sg/uxs6WgNS+s13tK0wRuCfxpWRTu+MnsB1uVqk5BS6D3pW
         ThhmHEbmJaeuulhiTLadp0c7YYb4VL0H/tZnR8SYDodPYX/5FZW4DT1fVAi0dsUpB2R9
         6okkec/QAaV/P7iuXRtLeZLiarQfL0HNFbg3eAC4o7KFt5aaebGgId7JjjE7o8ob1VjZ
         AnLYxiXPDKS+/3cV3dxH/cxeygD9PTGoPmdR4AJWnehdnsqAi/FEvp4oCirY8HBtCUhe
         BeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gym23n3kGjGPozjpdEEgiFjUAV/Ah9a8RiDZDRT6MTg=;
        b=PRuiSF9ACe32OdF5gZbga9xw2C7FGUAML9ZzQ91wxMiFxTkJRIwMP0jmohy2HMdDiR
         VLiq80SZL1n+sY2GeQUydNNV3cMqgABFchEhOP5Gjz1ajb536JW70NxeY1evjol57wTB
         KHSLMwHe5eWxIgsek001KjFVSS8EBVQFARF34nzLJFWINSscORhGbTOeUZmNbaL6Weg2
         mQkVIqDh7brM33g0dCd6VNzYavvhyP/xW0T9vUogup5GvpsBAvB1t9XgBF5MG7Ltn/Ar
         rXw7hDVO0FEivZHBHYOE8pBCkt9Qluv/LKIjoW0oJfToit3KWz6fHN3PYfNyqel0dBmM
         96vQ==
X-Gm-Message-State: AOAM532O4D1MDwufIQMQ5f15JaR2xXgs8IE7me4pQ89jAHpmgwO746aU
        eLUlh5mn2jUOQgwLYs6CK1c4VxxY5/MX9yfq
X-Google-Smtp-Source: ABdhPJw9xXG3UzGS6xAa0PZShFQ7na9T3WVoIgIyhymmikoCCwTyDAEIFfHnXfo9EHePnZ0iEmZUeA==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr10890711edd.322.1617885061274;
        Thu, 08 Apr 2021 05:31:01 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id rh6sm7741732ejb.39.2021.04.08.05.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 05:31:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: Remove camelcase in several files
Date:   Thu, 08 Apr 2021 14:30:59 +0200
Message-ID: <2019699.EkM3Idjzxb@localhost.localdomain>
In-Reply-To: <20210408115529.GL2531743@casper.infradead.org>
References: <20210408103954.22857-1-fmdefrancesco@gmail.com> <20210408115529.GL2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 8, 2021 1:55:29 PM CEST Matthew Wilcox wrote:
> On Thu, Apr 08, 2021 at 12:39:54PM +0200, Fabio M. De Francesco wrote:
> > Remove camelcase in bFwCurrentInPSMode, a variable used by code
> > of several subdirectories/files of the driver. Issue detected by
> > checkpatch.pl.
> 
> It looks like you sent this as a diff against v1 instead of as a
> replacement for v1.
> 
I wrongly assumed it could go. I still don't know how to reset and replace 
a commit that is not in HEAD. I have to read a tutorial about this subject.

Let me take some time to understand how to do that replacement and then I 
will send the patch again. 

Obviously, I'd appreciate any help that guides me to the proper workflow.

Thanks for your review,

Fabio
 >
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > Changes from v1: Rewrite comment for the purpose of specifying which
> > variable changes. Shorten its name by removing two unnecessary
> > characters (b_).
> > 
> >  drivers/staging/rtl8723bs/core/rtw_cmd.c       |  2 +-
> >  drivers/staging/rtl8723bs/core/rtw_mlme.c      |  2 +-
> >  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c   | 18 +++++++++---------
> >  drivers/staging/rtl8723bs/hal/hal_intf.c       |  2 +-
> >  drivers/staging/rtl8723bs/hal/rtl8723b_dm.c    |  6 +++---
> >  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  2 +-
> >  drivers/staging/rtl8723bs/hal/sdio_ops.c       | 14 +++++++-------
> >  .../staging/rtl8723bs/include/rtw_pwrctrl.h    |  2 +-
> >  8 files changed, 24 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > a08f22b53592..feb53b8c0ff2 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > @@ -1510,7 +1510,7 @@ static void rtw_lps_change_dtim_hdl(struct
> > adapter *padapter, u8 dtim)> 
> >  	if (pwrpriv->dtim != dtim)
> >  	
> >  		pwrpriv->dtim = dtim;
> > 
> > -	if ((pwrpriv->b_fw_current_in_ps_mode == true) && (pwrpriv-
>pwr_mode
> > > PS_MODE_ACTIVE)) { +	if ((pwrpriv->fw_current_in_ps_mode == 
true) &&
> > (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {> 
> >  		u8 ps_mode = pwrpriv->pwr_mode;
> >  		
> >  		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, 
(u8
> >  		*)(&ps_mode));
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > b/drivers/staging/rtl8723bs/core/rtw_mlme.c index
> > 51cea6cf46e7..895997868c81 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > @@ -1684,7 +1684,7 @@ void rtw_dynamic_check_timer_handler(struct
> > adapter *adapter)> 
> >  	if (adapter->net_closed)
> >  	
> >  		return;
> > 
> > -	if ((adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode)
> > +	if ((adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
> > 
> >  		&& !(hal_btcoex_IsBtControlLps(adapter))
> >  		) {
> >  		u8 bEnterPS;
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> > b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c index
> > 21e7a847866f..481e2ad60853 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> > @@ -365,7 +365,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8
> > ps_mode, u8 smart_ps, u8 bcn_a> 
> >  			rtw_set_rpwm(padapter, PS_STATE_S4);
> >  			
> >  			rtw_hal_set_hwreg(padapter, 
HW_VAR_H2C_FW_PWRMODE, (u8
> >  			*)(&ps_mode));
> > 
> > -			pwrpriv->b_fw_current_in_ps_mode = false;
> > +			pwrpriv->fw_current_in_ps_mode = false;
> > 
> >  			hal_btcoex_LpsNotify(padapter, ps_mode);
> >  		
> >  		}
> > 
> > @@ -377,7 +377,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8
> > ps_mode, u8 smart_ps, u8 bcn_a> 
> >  			hal_btcoex_LpsNotify(padapter, ps_mode);
> > 
> > -			pwrpriv->b_fw_current_in_ps_mode = true;
> > +			pwrpriv->fw_current_in_ps_mode = true;
> > 
> >  			pwrpriv->pwr_mode = ps_mode;
> >  			pwrpriv->smart_ps = smart_ps;
> >  			pwrpriv->bcn_ant_mode = bcn_ant_mode;
> > 
> > @@ -734,7 +734,7 @@ s32 rtw_register_task_alive(struct adapter
> > *padapter, u32 task)> 
> >  	register_task_alive(pwrctrl, task);
> > 
> > -	if (pwrctrl->b_fw_current_in_ps_mode) {
> > +	if (pwrctrl->fw_current_in_ps_mode) {
> > 
> >  		if (pwrctrl->cpwm < pslv) {
> >  		
> >  			if (pwrctrl->cpwm < PS_STATE_S2)
> >  			
> >  				res = _FAIL;
> > 
> > @@ -782,7 +782,7 @@ void rtw_unregister_task_alive(struct adapter
> > *padapter, u32 task)> 
> >  	unregister_task_alive(pwrctrl, task);
> > 
> > -	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) &&
> > pwrctrl->b_fw_current_in_ps_mode) { +	if ((pwrctrl->pwr_mode !=
> > PS_MODE_ACTIVE) && pwrctrl->fw_current_in_ps_mode) {> 
> >  		if (pwrctrl->cpwm > pslv)
> >  		
> >  			if ((pslv >= PS_STATE_S2) || (pwrctrl-
>alives == 0))
> >  			
> >  				rtw_set_rpwm(padapter, pslv);
> > 
> > @@ -819,7 +819,7 @@ s32 rtw_register_tx_alive(struct adapter *padapter)
> > 
> >  	register_task_alive(pwrctrl, XMIT_ALIVE);
> > 
> > -	if (pwrctrl->b_fw_current_in_ps_mode) {
> > +	if (pwrctrl->fw_current_in_ps_mode) {
> > 
> >  		if (pwrctrl->cpwm < pslv) {
> >  		
> >  			if (pwrctrl->cpwm < PS_STATE_S2)
> >  			
> >  				res = _FAIL;
> > 
> > @@ -864,7 +864,7 @@ s32 rtw_register_cmd_alive(struct adapter
> > *padapter)
> > 
> >  	register_task_alive(pwrctrl, CMD_ALIVE);
> > 
> > -	if (pwrctrl->b_fw_current_in_ps_mode) {
> > +	if (pwrctrl->fw_current_in_ps_mode) {
> > 
> >  		if (pwrctrl->cpwm < pslv) {
> >  		
> >  			if (pwrctrl->cpwm < PS_STATE_S2)
> >  			
> >  				res = _FAIL;
> > 
> > @@ -909,7 +909,7 @@ void rtw_unregister_tx_alive(struct adapter
> > *padapter)> 
> >  	unregister_task_alive(pwrctrl, XMIT_ALIVE);
> > 
> > -	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) &&
> > pwrctrl->b_fw_current_in_ps_mode) { +	if ((pwrctrl->pwr_mode !=
> > PS_MODE_ACTIVE) && pwrctrl->fw_current_in_ps_mode) {> 
> >  		if (pwrctrl->cpwm > pslv)
> >  		
> >  			if ((pslv >= PS_STATE_S2) || (pwrctrl-
>alives == 0))
> >  			
> >  				rtw_set_rpwm(padapter, pslv);
> > 
> > @@ -945,7 +945,7 @@ void rtw_unregister_cmd_alive(struct adapter
> > *padapter)> 
> >  	unregister_task_alive(pwrctrl, CMD_ALIVE);
> > 
> > -	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) &&
> > pwrctrl->b_fw_current_in_ps_mode) { +	if ((pwrctrl->pwr_mode !=
> > PS_MODE_ACTIVE) && pwrctrl->fw_current_in_ps_mode) {> 
> >  		if (pwrctrl->cpwm > pslv) {
> >  		
> >  			if ((pslv >= PS_STATE_S2) || (pwrctrl-
>alives == 0))
> >  			
> >  				rtw_set_rpwm(padapter, pslv);
> > 
> > @@ -978,7 +978,7 @@ void rtw_init_pwrctrl_priv(struct adapter
> > *padapter)
> > 
> >  	pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/* 
> >  	PS_MODE_MIN; */ pwrctrlpriv->bLeisurePs = pwrctrlpriv-
>power_mgnt !=
> >  	PS_MODE_ACTIVE;> 
> > -	pwrctrlpriv->b_fw_current_in_ps_mode = false;
> > +	pwrctrlpriv->fw_current_in_ps_mode = false;
> > 
> >  	pwrctrlpriv->rpwm = 0;
> >  	pwrctrlpriv->cpwm = PS_STATE_S4;
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > b/drivers/staging/rtl8723bs/hal/hal_intf.c index
> > a73c2f76628d..96fe172ced8d 100644
> > --- a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > +++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
> > @@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
> > 
> >  void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
> >  {
> > 
> > -	if (adapter_to_pwrctl(padapter)->b_fw_current_in_ps_mode == 
true) {
> > +	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode == true) 
{
> > 
> >  		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
> >  		
> >  			padapter-
>HalFunc.hal_dm_watchdog_in_lps(padapter); /* this
> >  			function caller is in interrupt context 
*/>  	
> >  	}
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> > b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c index
> > 265db187b8d5..23be025ceb5b 100644
> > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> > @@ -141,7 +141,7 @@ void rtl8723b_InitHalDm(struct adapter *Adapter)
> > 
> >  void rtl8723b_HalDmWatchDog(struct adapter *Adapter)
> >  {
> > 
> > -	bool b_fw_current_in_ps_mode = false;
> > +	bool fw_current_in_ps_mode = false;
> > 
> >  	bool bFwPSAwake = true;
> >  	u8 hw_init_completed = false;
> >  	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
> > 
> > @@ -151,12 +151,12 @@ void rtl8723b_HalDmWatchDog(struct adapter
> > *Adapter)> 
> >  	if (hw_init_completed == false)
> >  	
> >  		goto skip_dm;
> > 
> > -	b_fw_current_in_ps_mode =
> > adapter_to_pwrctl(Adapter)->b_fw_current_in_ps_mode;
> > +	fw_current_in_ps_mode =
> > adapter_to_pwrctl(Adapter)->fw_current_in_ps_mode;> 
> >  	rtw_hal_get_hwreg(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)
(&bFwPSAwake));
> >  	
> >  	if (
> >  	
> >  		(hw_init_completed == true) &&
> > 
> > -		((!b_fw_current_in_ps_mode) && bFwPSAwake)
> > +		((!fw_current_in_ps_mode) && bFwPSAwake)
> > 
> >  	) {
> >  	
> >  		/*  */
> >  		/*  Calculate Tx/Rx statistics. */
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c index
> > 7ebc438870fd..1ab0c9e8760b 100644
> > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > @@ -430,7 +430,7 @@ void rtl8723b_InitializeFirmwareVars(struct adapter
> > *padapter)> 
> >  	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
> >  	
> >  	/*  Init Fw LPS related. */
> > 
> > -	adapter_to_pwrctl(padapter)->b_fw_current_in_ps_mode = false;
> > +	adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;
> > 
> >  	/* Init H2C cmd. */
> >  	rtw_write8(padapter, REG_HMETFR, 0x0f);
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> > b/drivers/staging/rtl8723bs/hal/sdio_ops.c index
> > c78a6724fc1c..abe8f2f8f452 100644
> > --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> > +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> > @@ -173,7 +173,7 @@ static u32 sdio_read32(struct intf_hdl *intfhdl,
> > u32 addr)> 
> >  	if (
> >  	
> >  		((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 
0x100)) ||
> >  		(!mac_pwr_ctrl_on) ||
> > 
> > -		(adapter_to_pwrctl(adapter)-
>b_fw_current_in_ps_mode)
> > +		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
> > 
> >  	) {
> >  	
> >  		err = sd_cmd52_read(intfhdl, ftaddr, 4, (u8 
*)&le_tmp);
> >  
> >  #ifdef SDIO_DEBUG_IO
> > 
> > @@ -230,7 +230,7 @@ static s32 sdio_readN(struct intf_hdl *intfhdl, u32
> > addr, u32 cnt, u8 *buf)> 
> >  	if (
> >  	
> >  		((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 
0x100)) ||
> >  		(!mac_pwr_ctrl_on) ||
> > 
> > -		(adapter_to_pwrctl(adapter)-
>b_fw_current_in_ps_mode)
> > +		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
> > 
> >  	)
> >  	
> >  		return sd_cmd52_read(intfhdl, ftaddr, cnt, buf);
> > 
> > @@ -297,7 +297,7 @@ static s32 sdio_write32(struct intf_hdl *intfhdl,
> > u32 addr, u32 val)> 
> >  	if (
> >  	
> >  		((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 
0x100)) ||
> >  		(!mac_pwr_ctrl_on) ||
> > 
> > -		(adapter_to_pwrctl(adapter)-
>b_fw_current_in_ps_mode)
> > +		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
> > 
> >  	) {
> >  	
> >  		le_tmp = cpu_to_le32(val);
> > 
> > @@ -334,7 +334,7 @@ static s32 sdio_writeN(struct intf_hdl *intfhdl,
> > u32 addr, u32 cnt, u8 *buf)> 
> >  	if (
> >  	
> >  		((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 
0x100)) ||
> >  		(!mac_pwr_ctrl_on) ||
> > 
> > -		(adapter_to_pwrctl(adapter)-
>b_fw_current_in_ps_mode)
> > +		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
> > 
> >  	)
> >  	
> >  		return sd_cmd52_write(intfhdl, ftaddr, cnt, buf);
> > 
> > @@ -565,7 +565,7 @@ s32 sdio_local_read(
> > 
> >  	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, 
&mac_pwr_ctrl_on);
> >  	if (
> >  	
> >  		(!mac_pwr_ctrl_on) ||
> > 
> > -		(adapter_to_pwrctl(adapter)-
>b_fw_current_in_ps_mode)
> > +		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
> > 
> >  	)
> >  	
> >  		return sd_cmd52_read(intfhdl, addr, cnt, buf);
> > 
> > @@ -611,7 +611,7 @@ s32 sdio_local_write(
> > 
> >  	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, 
&mac_pwr_ctrl_on);
> >  	if (
> >  	
> >  		(!mac_pwr_ctrl_on) ||
> > 
> > -		(adapter_to_pwrctl(adapter)-
>b_fw_current_in_ps_mode)
> > +		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
> > 
> >  	)
> >  	
> >  		return sd_cmd52_write(intfhdl, addr, cnt, buf);
> > 
> > @@ -660,7 +660,7 @@ static u32 sdio_local_cmd53_read4byte(struct
> > adapter *adapter, u32 addr)> 
> >  	hal_sdio_get_cmd_addr_8723b(adapter, SDIO_LOCAL_DEVICE_ID, 
addr,
> >  	&addr);
> >  	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, 
&mac_pwr_ctrl_on);
> > 
> > -	if (!mac_pwr_ctrl_on ||
> > adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode) { +	if
> > (!mac_pwr_ctrl_on ||
> > adapter_to_pwrctl(adapter)->fw_current_in_ps_mode) {> 
> >  		sd_cmd52_read(intfhdl, addr, 4, (u8 *)&le_tmp);
> >  		val = le32_to_cpu(le_tmp);
> >  	
> >  	} else {
> > 
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h index
> > fcb06a95fdf6..5450d20b44a6 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > @@ -203,7 +203,7 @@ struct pwrctrl_priv {
> > 
> >  	u8 LpsIdleCount;
> >  	u8 power_mgnt;
> >  	u8 org_power_mgnt;
> > 
> > -	u8 b_fw_current_in_ps_mode;
> > +	u8 fw_current_in_ps_mode;
> > 
> >  	unsigned long	DelayLPSLastTimeStamp;
> >  	s32		pnp_current_pwr_state;
> >  	u8 pnp_bstop_trx;




