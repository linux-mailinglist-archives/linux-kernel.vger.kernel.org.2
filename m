Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDFA4301AB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbhJPJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbhJPJq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:46:59 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D500C061764
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:44:51 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mbgFD-0003AN-Ce; Sat, 16 Oct 2021 11:44:47 +0200
Date:   Sat, 16 Oct 2021 11:44:47 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] staging: r8188eu: pBandType is never set
Message-ID: <20211016094447.qfo6kmwilobexc5x@viti.kaiser.cx>
References: <20211015163507.9091-1-straube.linux@gmail.com>
 <20211015163507.9091-6-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015163507.9091-6-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> pBandType is never set, it stays at the default value 0. Remove it
> from odm_dm_struct and remove related unneeded code.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 2 +-
>  drivers/staging/r8188eu/hal/odm.c            | 3 ---
>  drivers/staging/r8188eu/include/odm.h        | 8 --------
>  3 files changed, 1 insertion(+), 12 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> index f01ee3cd8795..8e9fbc9cf84d 100644
> --- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> +++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> @@ -317,7 +317,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
>  					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][4];
>  					Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][5];

> -					if ((X != 0) && (*dm_odm->pBandType == ODM_BAND_2_4G)) {
> +					if (X != 0) {
>  						if ((X & 0x00000200) != 0)	/* consider minus */
>  							X = X | 0xFFFFFC00;
>  						ele_A = ((X * ele_D) >> 8) & 0x000003FF;
> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index d3d13164ca8f..85bc5050cda5 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -243,9 +243,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
>  	case	ODM_CMNINFO_WM_MODE:
>  		pDM_Odm->pWirelessMode = (u8 *)pValue;
>  		break;
> -	case	ODM_CMNINFO_BAND:
> -		pDM_Odm->pBandType = (u8 *)pValue;
> -		break;
>  	case	ODM_CMNINFO_SEC_CHNL_OFFSET:
>  		pDM_Odm->pSecChOffset = (u8 *)pValue;
>  		break;
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index a8e9089433ba..9745069060d7 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -273,7 +273,6 @@ enum odm_common_info_def {
>  	ODM_CMNINFO_TX_UNI,
>  	ODM_CMNINFO_RX_UNI,
>  	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
> -	ODM_CMNINFO_BAND,		/*  ODM_BAND_TYPE_E */
>  	ODM_CMNINFO_SEC_CHNL_OFFSET,	/*  ODM_SEC_CHNL_OFFSET_E */
>  	ODM_CMNINFO_SEC_MODE,		/*  ODM_SECURITY_E */
>  	ODM_CMNINFO_BW,			/*  ODM_BW_E */
> @@ -405,11 +404,6 @@ enum odm_wireless_mode {
>  	ODM_WM_AUTO	= BIT(5),
>  };

> -/*  ODM_CMNINFO_BAND */
> -enum odm_band_type {
> -	ODM_BAND_2_4G	= BIT(0),
> -};
> -
>  /*  ODM_CMNINFO_SEC_CHNL_OFFSET */
>  enum odm_sec_chnl_offset {
>  	ODM_DONT_CARE	= 0,
> @@ -635,8 +629,6 @@ struct odm_dm_struct {
>  	u64	*pNumRxBytesUnicast;
>  	/*  Wireless mode B/G/A/N = BIT(0)/BIT(1)/BIT(2)/BIT(3) */
>  	u8	*pWirelessMode; /* ODM_WIRELESS_MODE_E */
> -	/*  Frequence band 2.4G/5G = 0/1 */
> -	u8	*pBandType;
>  	/*  Secondary channel offset don't_care/below/above = 0/1/2 */
>  	u8	*pSecChOffset;
>  	/*  Security mode Open/WEP/AES/TKIP = 0/1/2/3 */
> -- 
> 2.33.0

Acked-by: Martin Kaiser <martin@kaiser.cx>
