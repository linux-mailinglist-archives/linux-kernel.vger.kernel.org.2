Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDEE435EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhJUKVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhJUKVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:21:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EDCC061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:19:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y3so305122wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Zt3EBXSJ3pXR9PlfH7wniqE4IJP+VKUHm4SeDxQYOCU=;
        b=Tzs2CsYYHm66cqHYF2IH3kq2+Hdy1sUbDuRk0FizAfzY6TsMknVdibhYH1m01wSTja
         24bhXBvrwbfgsaU0tYipM7IE5Ad4bvGbc6IpAFWHo5df6peaTO3qlhpgMdAezPIVhPgW
         f50tiv0yvz9sLPQRodbhZQIrrx97VAzCgNp9+Ym1zZYIbvlXOUFg2+2CMSijmgW69Nj5
         tzxFM8C0D6ZS2dpp0cwIJGeazyX380fVUBISKWLwVGW7+0lEMx7+uvW+xgAKvsWxkBgR
         gMWnnizN153KJgBU+f92YRbSChzoL7qf8cRR4piPiUQ3UGQgX5f9Lfeq8ne9d1nnR5yS
         +rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zt3EBXSJ3pXR9PlfH7wniqE4IJP+VKUHm4SeDxQYOCU=;
        b=AsH5dO87AGkh33g+CwTwF1Ulki6yb6pvwgIhwvsZ5iB2o/UpjlLLy97g8FjvBP2wEQ
         O/BKVL2VUNyE3JuuFDCoGLs5khgHRiJgBtqr2e2+oWftGIXrR2P3dpxRPu1RYyhEujE/
         VSGLjNs0CdpWKsblkMJWP20dYjmB4/kEvOEP1lSuylDbKZkY90adbyu5q9pjNg9Mt4ZK
         gDuFabsgJzSzVKq1sLuvRiv60E2Dmb1KjRzDl0JTmdq70Bt1Br5qiBQvY6lKEPIeFGCv
         k25xxrncqn+RVXo22HbiKdYT9rI0KVS1ttVALUkhnUeqJdBnWhBBeon2SNQ0rhF2tgHC
         pTOg==
X-Gm-Message-State: AOAM531xlP+Kcsti2G76/2SqDNoGCcn/K7Yl6UlDa4hB0ulYdXOcTTWW
        OXHlBVkynELPIgHyfyf9k3c=
X-Google-Smtp-Source: ABdhPJwA7rJlWbUalxs+nHmq1UOmX5riy4U7hz8ri9jxUzq7lQkot/Qp3owyWqkZNPooekM/36dwSw==
X-Received: by 2002:a5d:64c9:: with SMTP id f9mr6107757wri.284.1634811539701;
        Thu, 21 Oct 2021 03:18:59 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id 10sm8444867wme.27.2021.10.21.03.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 03:18:59 -0700 (PDT)
Message-ID: <66a8498b-33dc-892c-f3f0-2adfb7e77d9a@gmail.com>
Date:   Thu, 21 Oct 2021 12:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/5] staging: r8188eu: odm_rate_adapt Type is constant
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211020195401.12931-1-martin@kaiser.cx>
 <20211020195401.12931-2-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211020195401.12931-2-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 21:53, Martin Kaiser wrote:
> Type in struct odm_rate_adapt is always DM_Type_ByDriver.
> Therefore, bUseRAMask is always true.
> 
> Remove the constant components, unused defines and dead code.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/odm.c     | 9 ---------
>   drivers/staging/r8188eu/include/odm.h | 6 ------
>   2 files changed, 15 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 47d8cdf1c3e8..67cf8f7baba5 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -669,12 +669,6 @@ void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm)
>   {
>   	struct odm_rate_adapt *pOdmRA = &pDM_Odm->RateAdaptive;
>   
> -	pOdmRA->Type = DM_Type_ByDriver;
> -	if (pOdmRA->Type == DM_Type_ByDriver)
> -		pDM_Odm->bUseRAMask = true;
> -	else
> -		pDM_Odm->bUseRAMask = false;
> -
>   	pOdmRA->RATRState = DM_RATR_STA_INIT;
>   	pOdmRA->HighRSSIThresh = 50;
>   	pOdmRA->LowRSSIThresh = 20;
> @@ -755,9 +749,6 @@ void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
>   	if (pAdapter->bDriverStopped)
>   		return;
>   
> -	if (!pDM_Odm->bUseRAMask)
> -		return;
> -
>   	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
>   		struct sta_info *pstat = pDM_Odm->pODM_StaInfo[i];
>   		if (IS_STA_VALID(pstat)) {
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 1fc90a8dc063..f08655208b32 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -150,7 +150,6 @@ struct edca_turbo {
>   };
>   
>   struct odm_rate_adapt {
> -	u8	Type;		/*  DM_Type_ByFW/DM_Type_ByDriver */
>   	u8	HighRSSIThresh;	/*  if RSSI > HighRSSIThresh	=> RATRState is DM_RATR_STA_HIGH */
>   	u8	LowRSSIThresh;	/*  if RSSI <= LowRSSIThresh	=> RATRState is DM_RATR_STA_LOW */
>   	u8	RATRState;	/*  Current RSSI level, DM_RATR_STA_HIGH/DM_RATR_STA_MIDDLE/DM_RATR_STA_LOW */
> @@ -165,8 +164,6 @@ struct odm_rate_adapt {
>   #define AVG_THERMAL_NUM		8
>   #define IQK_Matrix_REG_NUM	8
>   
> -#define	DM_Type_ByDriver	1
> -
>   struct odm_phy_dbg_info {
>   	/* ODM Write,debug info */
>   	s8	RxSNRdB[MAX_PATH_NUM_92CS];
> @@ -586,9 +583,6 @@ struct odm_dm_struct {
>   	bool	bPSDinProcess;
>   	bool	bDMInitialGainEnable;
>   
> -	/* for rate adaptive, in fact,  88c/92c fw will handle this */
> -	u8	bUseRAMask;
> -
>   	struct odm_rate_adapt RateAdaptive;
>   
>   	struct odm_rf_cal RFCalibrateInfo;
> 


Looks good, thanks.

Acked-by: Michael Straube <straube.linux@gmail.com>
