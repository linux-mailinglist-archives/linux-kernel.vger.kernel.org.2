Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE83943087A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245610AbhJQLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbhJQLsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:48:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB5C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:46:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so7485989wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EsnsKlwKPf18kTpcWRLEIskoZFP21ejOKCvXg1wekUU=;
        b=LM0yftK7ohggDLAqfHmk2uRjp4//2RdkeUHkvqsaK90z7zj4k7KvqW3KZT2DCVt3D6
         OaLCg1kw6gQcQnuUmY63Pwd0kCGoKIHTDOSoW8dxtUILsPRQp97w8Sd0FuR/IXnMdoPu
         dspwS0CkNCBJd6TztFpmMzB+dzwC/UBMF7AymH27QadxhSHD6Rt8BhbFuJr5KG1Hfpgm
         9B6iMKC6X+SAqweBdmMAWh5RbI8Sez/eezAH99Sh2SXCATsG+BnZ2tWlZc6dvykc8CZC
         exRU/WZtZWy1MfILBml0/IpowIzl2bVp0heX+Ys9tMPcD12Ys5HCoTm88H8Hcj3bYc2Z
         9yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EsnsKlwKPf18kTpcWRLEIskoZFP21ejOKCvXg1wekUU=;
        b=GMh/raHdFPnrCqqIcNI1ZnrIHuVUT0qBwRlMCPe/tpI1aDNbYb/ve02BOIp2Rer0X+
         TOFl0+r/lULbqeQl7HT/HsmcOFsFgj5z+6DAp3jA1hzYHG3qhTtiuI08sMhBwOtvQLMD
         iUxS3pDDqJXCIzGxECwPkHMm3HIzVjksj//xFDx0amrA5WDk3RaY4LdDPXOpEBe1tLN4
         tX9Mehz0mZjsMUhfQirUg7aPPwNTaxJqNCr4EuNm1y4I9j7aoXAH/scVl0idrifxkbrA
         MZeXsxcC+5Auq73zTVEYPP5/xhCZ67GLsyvCz40S+FUArsbrh7AU3x0Ib/gB/ynxuYEz
         11qg==
X-Gm-Message-State: AOAM530sGDNZjU7Y2fKzznvD5Mj8GS0oLtDVB4p9ovhCjpYw8PlhRz60
        xuc7RI4Zjh2c5d+ZLIhbb9c=
X-Google-Smtp-Source: ABdhPJzldpQC6kKA1gXqKQI4eQc0ULqEVmEcX1224wCJmMDgHAwL+yKuGwue4F0S2cAJfMSdh1A0sw==
X-Received: by 2002:a7b:c149:: with SMTP id z9mr7618921wmi.177.1634471195189;
        Sun, 17 Oct 2021 04:46:35 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id 10sm13458491wme.27.2021.10.17.04.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 04:46:34 -0700 (PDT)
Message-ID: <b17bbae4-2297-3247-a40b-38a0de1afafd@gmail.com>
Date:   Sun, 17 Oct 2021 13:46:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/8] staging: r8188eu: interface type is always usb
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211016113008.27549-1-martin@kaiser.cx>
 <20211016113008.27549-3-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211016113008.27549-3-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/21 13:30, Martin Kaiser wrote:
> SupportInterface in struct odm_dm_struct is always ODM_ITRF_USB.
> Remove the variable and the code to configure the interface.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c  |  9 +++------
>   drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c |  3 +--
>   drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c  |  3 +--
>   drivers/staging/r8188eu/hal/odm.c               |  3 ---
>   drivers/staging/r8188eu/hal/rtl8188e_dm.c       |  2 --
>   drivers/staging/r8188eu/include/odm.h           | 11 +----------
>   6 files changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
> index 17b55c31f6eb..a623e0aaa0d0 100644
> --- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
> +++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
> @@ -176,7 +176,6 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
>   {
>   	u32     hex         = 0;
>   	u32     i           = 0;
> -	u8     interfaceValue   = dm_odm->SupportInterface;
>   	u32     arraylen    = sizeof(array_agc_tab_1t_8188e) / sizeof(u32);
>   	u32    *array       = array_agc_tab_1t_8188e;
>   	bool		biol = false;
> @@ -185,7 +184,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
>   	u8 bndy_cnt = 1;
>   	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
>   
> -	hex += interfaceValue << 8;
> +	hex += ODM_ITRF_USB << 8;
>   	hex += ODM_CE << 16;
>   	hex += 0xFF000000;
>   	biol = rtw_IOL_applied(adapter);
> @@ -453,7 +452,6 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
>   {
>   	u32     hex         = 0;
>   	u32     i           = 0;
> -	u8     interfaceValue   = dm_odm->SupportInterface;
>   	u32     arraylen    = sizeof(array_phy_reg_1t_8188e) / sizeof(u32);
>   	u32    *array       = array_phy_reg_1t_8188e;
>   	bool	biol = false;
> @@ -461,7 +459,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
>   	struct xmit_frame *pxmit_frame = NULL;
>   	u8 bndy_cnt = 1;
>   	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
> -	hex += interfaceValue << 8;
> +	hex += ODM_ITRF_USB << 8;
>   	hex += ODM_CE << 16;
>   	hex += 0xFF000000;
>   	biol = rtw_IOL_applied(adapter);
> @@ -659,11 +657,10 @@ void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
>   {
>   	u32  hex;
>   	u32  i           = 0;
> -	u8  interfaceValue   = dm_odm->SupportInterface;
>   	u32  arraylen    = sizeof(array_phy_reg_pg_8188e) / sizeof(u32);
>   	u32 *array       = array_phy_reg_pg_8188e;
>   
> -	hex = interfaceValue << 8;
> +	hex = ODM_ITRF_USB << 8;
>   	hex += (ODM_CE << 16) + 0xFF000000;
>   
>   	for (i = 0; i < arraylen; i += 3) {
> diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
> index bb57e93eb959..b4c55863d3fb 100644
> --- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
> +++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
> @@ -133,7 +133,6 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
>   
>   	u32     hex         = 0;
>   	u32     i;
> -	u8     interface_val   = dm_odm->SupportInterface;
>   	u32     array_len    = sizeof(array_MAC_REG_8188E) / sizeof(u32);
>   	u32    *array       = array_MAC_REG_8188E;
>   	bool	biol = false;
> @@ -142,7 +141,7 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
>   	struct xmit_frame	*pxmit_frame = NULL;
>   	u8 bndy_cnt = 1;
>   	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
> -	hex += interface_val << 8;
> +	hex += ODM_ITRF_USB << 8;
>   	hex += ODM_CE << 16;
>   	hex += 0xFF000000;
>   
> diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
> index 7a8faa7885a1..3e2a09fc2619 100644
> --- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
> +++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
> @@ -144,7 +144,6 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
>   
>   	u32     hex         = 0;
>   	u32     i           = 0;
> -	u8     interfaceValue   = pDM_Odm->SupportInterface;
>   	u32     ArrayLen    = sizeof(Array_RadioA_1T_8188E) / sizeof(u32);
>   	u32    *Array       = Array_RadioA_1T_8188E;
>   	bool		biol = false;
> @@ -153,7 +152,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
>   	u8 bndy_cnt = 1;
>   	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
>   
> -	hex += interfaceValue << 8;
> +	hex += ODM_ITRF_USB << 8;
>   	hex += ODM_CE << 16;
>   	hex += 0xFF000000;
>   	biol = rtw_IOL_applied(Adapter);
> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 2178ffe41bb3..a90597b82e12 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -214,9 +214,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
>   	case	ODM_CMNINFO_ABILITY:
>   		pDM_Odm->SupportAbility = (u32)Value;
>   		break;
> -	case	ODM_CMNINFO_INTERFACE:
> -		pDM_Odm->SupportInterface = (u8)Value;
> -		break;
>   	case	ODM_CMNINFO_MP_TEST_CHIP:
>   		pDM_Odm->bIsMPChip = (u8)Value;
>   		break;
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> index 1ca24a507d6d..869d95f3cf33 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> @@ -33,8 +33,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
>   
>   	dm_odm->Adapter = Adapter;
>   
> -	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_INTERFACE, ODM_ITRF_USB);
> -
>   	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
>   
>   	if (hal_data->rf_type == RF_1T1R)
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 187f872d09b5..ba936d30a0db 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -262,7 +262,6 @@ enum odm_common_info_def {
>   
>   	/* HOOK BEFORE REG INIT----------- */
>   	ODM_CMNINFO_ABILITY,		/* ODM_ABILITY_E */
> -	ODM_CMNINFO_INTERFACE,		/* ODM_INTERFACE_E */
>   	ODM_CMNINFO_MP_TEST_CHIP,
>   	ODM_CMNINFO_RF_TYPE,		/* RF_PATH_E or ODM_RF_TYPE_E? */
>   	/* HOOK BEFORE REG INIT-----------  */
> @@ -343,13 +342,7 @@ enum odm_ability_def {
>   	ODM_RF_CALIBRATION		= BIT(26),
>   };
>   
> -/* 	ODM_CMNINFO_INTERFACE */
> -enum odm_interface_def {
> -	ODM_ITRF_PCIE	=	0x1,
> -	ODM_ITRF_USB	=	0x2,
> -	ODM_ITRF_SDIO	=	0x4,
> -	ODM_ITRF_ALL	=	0x7,
> -};
> +# define ODM_ITRF_USB 0x2
>   
>   /*  ODM_CMNINFO_RF_TYPE */
>   /*  For example 1T2R (A+AB = BIT(0)|BIT(4)|BIT(5)) */
> @@ -611,8 +604,6 @@ struct odm_dm_struct {
>   /* HOOK BEFORE REG INIT----------- */
>   	/*  ODM Support Ability DIG/RATR/TX_PWR_TRACK/ �K�K = 1/2/3/�K */
>   	u32	SupportAbility;
> -	/*  ODM PCIE/USB/SDIO/GSPI = 0/1/2/3 */
> -	u8	SupportInterface;
>   	/*  RF Type 4T4R/3T3R/2T2R/1T2R/1T1R/... */
>   	u8	RFType;
>   
> 

Acked-by: Michael Straube <straube.linux@gmail.com>
