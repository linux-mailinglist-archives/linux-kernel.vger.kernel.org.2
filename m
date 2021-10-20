Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3AD4354E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJTVIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:08:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470F9C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:06:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so12279714wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ccjx7hnRxE/J/c9yyhLNRfffYR9pyQjf+fAAPM9NmOQ=;
        b=dbwfCsQOOqfBeIcdWjxFeoDZqcnQuMwAbCmORcXtkJb1GG/GrmmYY2+ltqyhIVHYE+
         fK6+8+ZCFLRwygXXw2XHvpHif4n+PmJsGdbcxnyY38q8MdvH+8HsN9JWoif3ZOcRWpWh
         FblxRdtsScbeh2mgIuU/tAzfQGZLLjqFcuqgTRtD5xpJl6rbcGi/lIOuTBl6qCFCzFbd
         cEX9ctPx925hn6vjcIFX5xrFaiOafzpuPLQbSvIWpEMK03B3ZO4sunH4ay/NE6keQFxI
         CJjbVFqMxShUzFLaH0BMEG/mLKo992ZeBrIUqi386uOy2tZDilmbLqhPAKQ2YgXWPx+R
         Wnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ccjx7hnRxE/J/c9yyhLNRfffYR9pyQjf+fAAPM9NmOQ=;
        b=GXK2oUU8nQHHL/pEY0/UGTN1ZdGxWCbKC6eXjIjLBZZVEUJRLYJsKnMJb6v5BBJtlU
         Rb6vdvsL7BtZSMntDOinIOIO98J10x+Z/NSchuJzOSDLpbslLQvtV+xl591uhT9XeN9a
         HaRGzhU/fOaifV7sCi4AQJkE1U4yKbku262cA3pF0S0S1mqCwY/wGb+3lnashiLYYZli
         qsk/YSUyztVtgZtbMoQVHgXxt8xYHQy2CV7J/uE2ZZY6cNEZurO9T1dxvC+tGW6OISQK
         0IkQUPvqBliCiMIqv/vQNcKD4rmywfxDE85lhX+rRlIaWn0yfm0aF/7K3QTFlfHGMWHH
         W7bQ==
X-Gm-Message-State: AOAM530LC8Ylym3wk6vAMw8JvqKfH5xZYvsfzlISSbJOvhfi3/aih5qy
        x1aCBJ7psP+TH1yDdk7h3cn7OQ==
X-Google-Smtp-Source: ABdhPJyBmE92RiaoeeOP3asyWGRenIYhhxVUwqTEL8jS/NhElmzqIcTD6Hthg5sbnHZ4kKfPSPbSdQ==
X-Received: by 2002:a1c:1dcb:: with SMTP id d194mr1823387wmd.156.1634763995864;
        Wed, 20 Oct 2021 14:06:35 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id 196sm2907486wme.20.2021.10.20.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:06:35 -0700 (PDT)
Date:   Wed, 20 Oct 2021 22:06:33 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] staging: r8188eu: odm_rate_adapt Type is constant
Message-ID: <YXCE2RSwiOP/nsfS@equinox>
References: <20211020195401.12931-1-martin@kaiser.cx>
 <20211020195401.12931-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020195401.12931-2-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:53:58PM +0200, Martin Kaiser wrote:
> Type in struct odm_rate_adapt is always DM_Type_ByDriver.
> Therefore, bUseRAMask is always true.
> 
> Remove the constant components, unused defines and dead code.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/odm.c     | 9 ---------
>  drivers/staging/r8188eu/include/odm.h | 6 ------
>  2 files changed, 15 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 47d8cdf1c3e8..67cf8f7baba5 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -669,12 +669,6 @@ void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm)
>  {
>  	struct odm_rate_adapt *pOdmRA = &pDM_Odm->RateAdaptive;
>  
> -	pOdmRA->Type = DM_Type_ByDriver;
> -	if (pOdmRA->Type == DM_Type_ByDriver)
> -		pDM_Odm->bUseRAMask = true;
> -	else
> -		pDM_Odm->bUseRAMask = false;
> -
>  	pOdmRA->RATRState = DM_RATR_STA_INIT;
>  	pOdmRA->HighRSSIThresh = 50;
>  	pOdmRA->LowRSSIThresh = 20;
> @@ -755,9 +749,6 @@ void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
>  	if (pAdapter->bDriverStopped)
>  		return;
>  
> -	if (!pDM_Odm->bUseRAMask)
> -		return;
> -
>  	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
>  		struct sta_info *pstat = pDM_Odm->pODM_StaInfo[i];
>  		if (IS_STA_VALID(pstat)) {
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 1fc90a8dc063..f08655208b32 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -150,7 +150,6 @@ struct edca_turbo {
>  };
>  
>  struct odm_rate_adapt {
> -	u8	Type;		/*  DM_Type_ByFW/DM_Type_ByDriver */
>  	u8	HighRSSIThresh;	/*  if RSSI > HighRSSIThresh	=> RATRState is DM_RATR_STA_HIGH */
>  	u8	LowRSSIThresh;	/*  if RSSI <= LowRSSIThresh	=> RATRState is DM_RATR_STA_LOW */
>  	u8	RATRState;	/*  Current RSSI level, DM_RATR_STA_HIGH/DM_RATR_STA_MIDDLE/DM_RATR_STA_LOW */
> @@ -165,8 +164,6 @@ struct odm_rate_adapt {
>  #define AVG_THERMAL_NUM		8
>  #define IQK_Matrix_REG_NUM	8
>  
> -#define	DM_Type_ByDriver	1
> -
>  struct odm_phy_dbg_info {
>  	/* ODM Write,debug info */
>  	s8	RxSNRdB[MAX_PATH_NUM_92CS];
> @@ -586,9 +583,6 @@ struct odm_dm_struct {
>  	bool	bPSDinProcess;
>  	bool	bDMInitialGainEnable;
>  
> -	/* for rate adaptive, in fact,  88c/92c fw will handle this */
> -	u8	bUseRAMask;
> -
>  	struct odm_rate_adapt RateAdaptive;
>  
>  	struct odm_rf_cal RFCalibrateInfo;
> -- 
> 2.20.1
> 

Looks good.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
