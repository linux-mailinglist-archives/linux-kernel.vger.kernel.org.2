Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0A35EF95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhDNI03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhDNI0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:26:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51AE2613C1;
        Wed, 14 Apr 2021 08:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618388763;
        bh=Pg3fNT7/oU63EmAB4eQU10EvR8ucuRZPqA3qE6a4JKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbsH9o4TCChcsYGeh1wgxzI9+vojbCZ3BM243OQtYDpJxgVvccSOD/nh6amYtY1tv
         ybrm1Vk/iAocx/b5fK9glIFAG0rmEOPnQOv9olWtszCWXEfJeILmscHWP5RCAyf3Ff
         K2pEewuYlfeMzSyrCdCD9E+iadOpfuLq19ULOAwI=
Date:   Wed, 14 Apr 2021 10:26:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] staging: rtl8723bs: replace DBG_871X_SEL_NL with
 netdev_dbg()
Message-ID: <YHanGdS1Kc/4zq4q@kroah.com>
References: <cover.1618325614.git.fabioaiuto83@gmail.com>
 <a798262b8e1dacf225dd42f2863243c543667d5f.1618325614.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a798262b8e1dacf225dd42f2863243c543667d5f.1618325614.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:56:32PM +0200, Fabio Aiuto wrote:
> replace DGB_871X_SEL_NL macro with netdev_dbg().
> 
> DBG_871X_SEL_NL macro expands to a raw prink call or a
> seq_printf if selected stream _is not_ a local
> debug symbol set to null.
> This second scenario never occurs so replace
> all macro usages with netdev_dbg().
> 
> This is done with the following coccinelle script:
> 
> @@
> expression sel;
> expression list args;
> identifier padapter;
> identifier func;
> @@
> 
> func(..., struct adapter *padapter, ...) {
> 	<...
> -	DBG_871X_SEL_NL(sel, args);
> +	netdev_dbg(padapter->pnetdev, args);
> 	...>
> }
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_debug.c | 16 +++----
>  drivers/staging/rtl8723bs/core/rtw_odm.c   | 49 +++++++++++-----------
>  drivers/staging/rtl8723bs/hal/hal_com.c    | 31 ++++++--------
>  3 files changed, 46 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
> index 324c7e5248f8..79fd968bb147 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_debug.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
> @@ -20,7 +20,7 @@ void sd_f0_reg_dump(void *sel, struct adapter *adapter)
>  
>  	for (i = 0x0; i <= 0xff; i++) {
>  		if (i%16 == 0)
> -			DBG_871X_SEL_NL(sel, "0x%02x ", i);
> +			netdev_dbg(adapter->pnetdev, "0x%02x ", i);
>  
>  		DBG_871X_SEL(sel, "%02x ", rtw_sd_f0_read8(adapter, i));
>  
> @@ -35,11 +35,11 @@ void mac_reg_dump(void *sel, struct adapter *adapter)
>  {
>  	int i, j = 1;
>  
> -	DBG_871X_SEL_NL(sel, "======= MAC REG =======\n");
> +	netdev_dbg(adapter->pnetdev, "======= MAC REG =======\n");
>  
>  	for (i = 0x0; i < 0x800; i += 4) {
>  		if (j%4 == 1)
> -			DBG_871X_SEL_NL(sel, "0x%03x", i);
> +			netdev_dbg(adapter->pnetdev, "0x%03x", i);
>  		DBG_871X_SEL(sel, " 0x%08x ", rtw_read32(adapter, i));
>  		if ((j++)%4 == 0)
>  			DBG_871X_SEL(sel, "\n");
> @@ -50,10 +50,10 @@ void bb_reg_dump(void *sel, struct adapter *adapter)
>  {
>  	int i, j = 1;
>  
> -	DBG_871X_SEL_NL(sel, "======= BB REG =======\n");
> +	netdev_dbg(adapter->pnetdev, "======= BB REG =======\n");
>  	for (i = 0x800; i < 0x1000 ; i += 4) {
>  		if (j%4 == 1)
> -			DBG_871X_SEL_NL(sel, "0x%03x", i);
> +			netdev_dbg(adapter->pnetdev, "0x%03x", i);
>  		DBG_871X_SEL(sel, " 0x%08x ", rtw_read32(adapter, i));
>  		if ((j++)%4 == 0)
>  			DBG_871X_SEL(sel, "\n");
> @@ -73,14 +73,14 @@ void rf_reg_dump(void *sel, struct adapter *adapter)
>  	else
>  		path_nums = 2;
>  
> -	DBG_871X_SEL_NL(sel, "======= RF REG =======\n");
> +	netdev_dbg(adapter->pnetdev, "======= RF REG =======\n");
>  
>  	for (path = 0; path < path_nums; path++) {
> -		DBG_871X_SEL_NL(sel, "RF_Path(%x)\n", path);
> +		netdev_dbg(adapter->pnetdev, "RF_Path(%x)\n", path);
>  		for (i = 0; i < 0x100; i++) {
>  			value = rtw_hal_read_rfreg(adapter, path, i, 0xffffffff);
>  			if (j%4 == 1)
> -				DBG_871X_SEL_NL(sel, "0x%02x ", i);
> +				netdev_dbg(adapter->pnetdev, "0x%02x ", i);
>  			DBG_871X_SEL(sel, " 0x%08x ", value);
>  			if ((j++)%4 == 0)
>  				DBG_871X_SEL(sel, "\n");
> diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
> index 53f7cc0444ba..084f6ae040ee 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_odm.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
> @@ -96,12 +96,13 @@ void rtw_odm_dbg_comp_msg(void *sel, struct adapter *adapter)
>  	int i;
>  
>  	rtw_hal_get_def_var(adapter, HW_DEF_ODM_DBG_FLAG, &dbg_comp);
> -	DBG_871X_SEL_NL(sel, "odm.DebugComponents = 0x%016llx\n", dbg_comp);
> +	netdev_dbg(adapter->pnetdev, "odm.DebugComponents = 0x%016llx\n",
> +		   dbg_comp);
>  	for (i = 0; i < RTW_ODM_COMP_MAX; i++) {
>  		if (odm_comp_str[i])
> -			DBG_871X_SEL_NL(sel, "%cBIT%-2d %s\n",
> -					(BIT0 << i) & dbg_comp ? '+' : ' ',
> -					i, odm_comp_str[i]);
> +			netdev_dbg(adapter->pnetdev, "%cBIT%-2d %s\n",
> +				   (BIT0 << i) & dbg_comp ? '+' : ' ', i,
> +				   odm_comp_str[i]);
>  	}
>  }
>  
> @@ -116,11 +117,11 @@ void rtw_odm_dbg_level_msg(void *sel, struct adapter *adapter)
>  	int i;
>  
>  	rtw_hal_get_def_var(adapter, HW_DEF_ODM_DBG_LEVEL, &dbg_level);
> -	DBG_871X_SEL_NL(sel, "odm.DebugLevel = %u\n", dbg_level);
> +	netdev_dbg(adapter->pnetdev, "odm.DebugLevel = %u\n", dbg_level);
>  	for (i = 0; i < RTW_ODM_DBG_LEVEL_NUM; i++) {
>  		if (odm_dbg_level_str[i])
> -			DBG_871X_SEL_NL(sel, "%u %s\n",
> -					i, odm_dbg_level_str[i]);
> +			netdev_dbg(adapter->pnetdev, "%u %s\n", i,
> +				   odm_dbg_level_str[i]);
>  	}
>  }
>  
> @@ -135,12 +136,12 @@ void rtw_odm_ability_msg(void *sel, struct adapter *adapter)
>  	int i;
>  
>  	rtw_hal_get_hwreg(adapter, HW_VAR_DM_FLAG, (u8 *)&ability);
> -	DBG_871X_SEL_NL(sel, "odm.SupportAbility = 0x%08x\n", ability);
> +	netdev_dbg(adapter->pnetdev, "odm.SupportAbility = 0x%08x\n", ability);
>  	for (i = 0; i < RTW_ODM_ABILITY_MAX; i++) {
>  		if (odm_ability_str[i])
> -			DBG_871X_SEL_NL(sel, "%cBIT%-2d %s\n",
> -					(BIT0 << i) & ability ? '+' : ' ', i,
> -					odm_ability_str[i]);
> +			netdev_dbg(adapter->pnetdev, "%cBIT%-2d %s\n",
> +				   (BIT0 << i) & ability ? '+' : ' ', i,
> +				   odm_ability_str[i]);
>  	}
>  }
>  
> @@ -154,17 +155,16 @@ void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter)
>  	struct hal_com_data *pHalData = GET_HAL_DATA(adapter);
>  	struct dm_odm_t *odm = &pHalData->odmpriv;
>  
> -	DBG_871X_SEL_NL(sel, "%10s %16s %8s %10s %11s %14s\n",
> -			"TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base",
> -			"ForceEDCCA", "AdapEn_RSSI", "IGI_LowerBound");
> -	DBG_871X_SEL_NL(sel, "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
> -			(u8)odm->TH_L2H_ini,
> -			odm->TH_EDCCA_HL_diff,
> -			odm->IGI_Base,
> -			odm->ForceEDCCA,
> -			odm->AdapEn_RSSI,
> -			odm->IGI_LowerBound
> -	);
> +	netdev_dbg(adapter->pnetdev, "%10s %16s %8s %10s %11s %14s\n",
> +		   "TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base", "ForceEDCCA",
> +		   "AdapEn_RSSI", "IGI_LowerBound");netdev_dbg(adapter->pnetdev,
> +							       "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
> +							       (u8)odm->TH_L2H_ini,
> +							       odm->TH_EDCCA_HL_diff,
> +							       odm->IGI_Base,
> +							       odm->ForceEDCCA,
> +							       odm->AdapEn_RSSI,
> +							       odm->IGI_LowerBound);

Something went wrong with this change :(
