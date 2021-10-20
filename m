Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538B24354E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhJTVHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhJTVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:07:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:05:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so249284wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T77iytDqhp9H0uodyxGcNpBMzkLQE3z2HpWpG8HbcZ4=;
        b=sSOED3ext07+4nJWteaYcNEQpXkMHR+7NP8nSkpFJJ+PCQ5xTB7Lc4baz8r86FngQ7
         RdFKodfn+ciAlrGMUXxrpRUggJrLLwdUXAjhRLj8xlyjoJ9wcELO9poiNoNdo8Z4gdLJ
         5pfKmNG8Ce576vBNrPQaueaD1KkweblneiD5WnFM07LyieOUqPX6v2qwSxvYy32n+yTi
         1CJotex6FafvIj/UKJA2MuuLVvziYRHFZHExEm1WQXJsgAh4CHxZXAQK8RFm64CjSyMs
         ZpRML0V3oEBt0RhSxn7I8uk50fsBXEbDCPRnspva8Cb+4ecJTjnfHsOzJVg6yvVcaB7O
         ic5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T77iytDqhp9H0uodyxGcNpBMzkLQE3z2HpWpG8HbcZ4=;
        b=xX7dhIfUMm9anWr8gO+uHb/OrTBb2UoPEda9qq8d0M68ELdbklhGxT13PSCQhOwvIZ
         lY0nAwsnLjOqcwgct7K7PYyYc3BPPDepLCE2ZY5neCFeNivkCYKSLKhUYuTTb71kAYZj
         IlGDqf5xH2UdHptgHh2W6ZIuhcVc6oS5NL6LFBexqYpDrfjplr5Hu2x9oGWs/hz4g2IN
         d8I9/3G2fi3IlSsbvKbjLcymRTxRYIFSz1sQIojdtWRS+SaUH8+1cpeiMKrbLVsJ0bXV
         Q82p/KVYEnuKzzsN/K7bSZkCzOHEJu3oKJqdjBiGJDNO70Ud8DHfTJJS/Ya0BooNJzv0
         JLgQ==
X-Gm-Message-State: AOAM530yOMNqfsoHHk+il81SJtARJcv152nj0iRzIXxA0VDfKSdh/qlP
        N0+yT9Yt3lHWFRNMv6TZHhK/HTwLnPRFKg==
X-Google-Smtp-Source: ABdhPJyzhaESlmMmaDyssgwpQ833qQsnwkKEQjQHodZ7elzBJAnWEQaqACu1XYq1NWVkDlfQDXLG7g==
X-Received: by 2002:adf:a48e:: with SMTP id g14mr2008477wrb.11.1634763936696;
        Wed, 20 Oct 2021 14:05:36 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id o10sm3398416wmq.46.2021.10.20.14.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:05:35 -0700 (PDT)
Date:   Wed, 20 Oct 2021 22:05:34 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: r8188eu: remove unused dm_priv components
Message-ID: <YXCEnhapnJEl9KZo@equinox>
References: <20211020195401.12931-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020195401.12931-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:53:57PM +0200, Martin Kaiser wrote:
> Remove unused components from struct dm_priv.
> 
> DMFlag is only written to, but never read.
> InitDMFlag is assigned to DMFlag and not used elsewhere.
> DM_Type is also write-only.
> UndecoratedSmoothedPWDB and UndecoratedSmoothedCCK are not used at all.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 3 ---
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 1 -
>  drivers/staging/r8188eu/include/rtl8188e_dm.h | 5 -----
>  3 files changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> index 4ce2c3749665..5d76f6ea91c4 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> @@ -87,12 +87,9 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
>  void rtl8188e_InitHalDm(struct adapter *Adapter)
>  {
>  	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
> -	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
>  	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
>  
>  	dm_InitGPIOSetting(Adapter);
> -	pdmpriv->DM_Type = DM_Type_ByDriver;
> -	pdmpriv->DMFlag = DYNAMIC_FUNC_DISABLE;
>  	Update_ODM_ComInfo_88E(Adapter);
>  	ODM_DMInit(dm_odm);
>  	Adapter->fix_rate = 0xFF;
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index cdc602fa9af8..ef1ae95d7db0 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -1469,7 +1469,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
>  		break;
>  	case HW_VAR_DM_FUNC_SET:
>  		if (*((u32 *)val) == DYNAMIC_ALL_FUNC_ENABLE) {
> -			pdmpriv->DMFlag = pdmpriv->InitDMFlag;
>  			podmpriv->SupportAbility =	pdmpriv->InitODMFlag;
>  		} else {
>  			podmpriv->SupportAbility |= *((u32 *)val);
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
> index 4a0608313f7a..208bea050f6f 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
> @@ -15,14 +15,9 @@ enum{
>  #define HP_THERMAL_NUM		8
>  /*  duplicate code,will move to ODM ######### */
>  struct	dm_priv {
> -	u8	DM_Type;
> -	u8	DMFlag;
> -	u8	InitDMFlag;
>  	u32	InitODMFlag;
>  
>  	/*  Upper and Lower Signal threshold for Rate Adaptive*/
> -	int	UndecoratedSmoothedPWDB;
> -	int	UndecoratedSmoothedCCK;
>  	int	EntryMinUndecoratedSmoothedPWDB;
>  	int	EntryMaxUndecoratedSmoothedPWDB;
>  	int	MinUndecoratedPWDBForDM;
> -- 
> 2.20.1
> 

Looks good.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
