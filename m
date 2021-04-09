Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE63596AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhDIHpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhDIHpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:45:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EE1C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 00:45:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so5389989edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xy0Vao0tdVjFYlW/wITfeVvtikD+bPVCKwCpJGCLmRg=;
        b=PCPyTiRfCvpOfrmJEJ/BHYzh5A0PV/3w1GAMbedMBe5mdFKUjdz22ZaZGSLUYHqo8T
         M4aocy0wsDFcZoC30sl8Vtg7KOB/VSXVgkjYxHgZvG2M/rA57/BdDo3azMcvQbEltuaL
         5ii+UmV8jX05F0sOeYNxfFsDMTN3s02fnHpPGXfwHj7vKIhzfIcr2+JmZPMht1mos5fa
         FkC5TEeelhB23i5NOApK9ou8VVzN2PN42bUOhbnYFuaO5J48VXG04HB8+KeI+OOZeoFP
         ICt2s/jEnE3MCA5kMFEUEfgdo/8hLedEjg/vSIYNQoYmXKNc1vlrjgXsK3OF4pCV4Fhk
         Jsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xy0Vao0tdVjFYlW/wITfeVvtikD+bPVCKwCpJGCLmRg=;
        b=rHECDXnJWcOcG5DZqYJAK+0X5UcFeA699rcJupx8IgDTdLA0Ajs9XM4seZZ8D+fvhz
         uZMp6zFnaiRlHcdca3TOMUU/NiPVXq930JgRdpkk/MubszrnhNv8B8JwtsdrsZdgBKVu
         51bvBWA4VZxla7Sv7E233cYCZQzy2c1JF1jVLZ/jXIVLOmM+ccVvV9l9amqEBGtjuPuS
         onYq2U10O5KWNgQ49Z0PeCPX2PmgjLCcgsOUCO2jgfD4rqdk2ZuL0fthDg4kGAtzpnpM
         8co4CWmqEXIPzSFyxwbJES2LIw/Qk7ZA3j2MVRRDxMWhxCw2oviVEu4+wA57FTk43HsX
         AiKQ==
X-Gm-Message-State: AOAM532BNDbyx32fMiaYi8mV7SF0x1fyzfySmAmjyEkO+Gg0pLssIvxv
        k2IjQ6T1V2dEFhXzbYHrumY=
X-Google-Smtp-Source: ABdhPJzqfOQUCL6KsLoo2mykgMBDu2PVeQF9fQwROCQgBNUNF06WDYaPkWTbwhFz94ND9BgsqWWU0A==
X-Received: by 2002:aa7:c694:: with SMTP id n20mr15898695edq.51.1617954302150;
        Fri, 09 Apr 2021 00:45:02 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id s11sm952148edt.27.2021.04.09.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 00:45:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v5] staging: rtl8723bs: Remove camelcase in several files
Date:   Fri, 09 Apr 2021 09:45:00 +0200
Message-ID: <7856458.1kExZPAqk2@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104090922210.4597@hadrien>
References: <20210409063458.7961-1-fmdefrancesco@gmail.com> <alpine.DEB.2.22.394.2104090922210.4597@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 9, 2021 9:22:54 AM CEST Julia Lawall wrote:
> On Fri, 9 Apr 2021, Fabio M. De Francesco wrote:
> > Remove camelcase in bFwCurrentInPSMode, a variable used by code
> > of several subdirectories/files of the driver. Issue detected by
> > checkpatch.pl. Delete the unnecessary "b" (that stands for "byte") from
> > the beginning of the name.
> 
> Isn't this still against your previous patch?  I see b_ on the removed
> lines.
> 

Sorry, Julia. You're right: it's against the wrong patch (again and again 
and...).
Version 6 is on the way.

Thanks,

Fabio

> julia
> 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > Changes from v4: Mention the removal of the initial "b" in log message.
> > Changes from v3: Fix errors in the format of the patch.
> > Changes from v2: Remove unnecessary comment. Shortened a function name.
> > Changes from v1: No changes to the code but only to the subject for the
> > purpose to differentiate this patch because other removes of camelcase
> > have been made in other files of the same directory.
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
> > 
> > --
> > 2.31.1
> > 
> > --
> > You received this message because you are subscribed to the Google
> > Groups "outreachy-kernel" group. To unsubscribe from this group and
> > stop receiving emails from it, send an email to
> > outreachy-kernel+unsubscribe@googlegroups.com. To view this discussion
> > on the web visit
> > https://groups.google.com/d/msgid/outreachy-kernel/20210409063458.7961
> > -1-fmdefrancesco%40gmail.com.




