Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F94435EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJUKTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:19:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC2C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:17:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d13so171061wrf.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1eulVtgnBse6T07v3i1s5Tmo6HHXX3u1XOsvEFwTjqI=;
        b=bOscBNW6BzvTWF1npFjKU35mUMZogJ8SypjvwFkSQ78EwxsaG5yXPvQsTimzP5LlgZ
         y4sJHUdmY5VJ4xlztxaj1ijB0L6ePopmMejNIh3XfTWuSTK+DTptyogmoheiFcrU8ydZ
         fVirY2s71iXx+peQOulGx4gZjZqRfbjiCQXdP2SplXCt8Zw4svCCUf3pYDCu+kdIxrJ5
         5hQumIpYKkFnpaKoQKEgA1klNO6XVedgGxVoKIQM8+mtCadYFmA8uA9al/JNqEZf4E0i
         jM4+pni/a91cs8zHIgakspMB6/N83N3UFsmPD/PLgFS+H5AgsvDgpmOEYY0jwNXxLDn6
         1ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1eulVtgnBse6T07v3i1s5Tmo6HHXX3u1XOsvEFwTjqI=;
        b=Mm4cesWuXV+zTGjkr3AON0s6rwlfn8m8tIFL++QmcFPJbmG5DjEkXwCcGBL/jhQl0D
         XD93q6bxXbc0mzG/IcBHwh6wOiDgBV/++IVCY+B75iKBJH360fQ5wEa6QIvraxKsKsF9
         J2DsLuntut9rAgAtHcvhF/OLslIK0hDGkt7/e2hNhVoTPY3pCiSTBvUpL785vlUfZUYU
         NTvI+7oEMWv4kwKbyKh5cuqxs80W8bRWWP2vX7Ew8wvs1kK6dduoO7mz8+pkd7y2s/lT
         p/Z9DeHbXYXZJQBpVzoeiHxH1Jx/hQOrToTahMphEstjCGWaAQkfjJtWjGx6namijyaC
         tstQ==
X-Gm-Message-State: AOAM533nO4jcDTYZYrqrL9VMrni1hZEx/dtJ4C9SMsCTeR2cAYXfhkG1
        DOF2x2AMFg2Z5a4kPX9arQ0=
X-Google-Smtp-Source: ABdhPJy8FI6uWBSB3kvM0sQ1+NJPGq5YDrc9WQNCn08d0g+SrTN3pI8Qha9VQuCB0kTC35VKeTF0ew==
X-Received: by 2002:adf:b348:: with SMTP id k8mr6034289wrd.435.1634811439870;
        Thu, 21 Oct 2021 03:17:19 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id q12sm4550935wrp.13.2021.10.21.03.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 03:17:19 -0700 (PDT)
Message-ID: <243e691c-4fb5-6cb0-1a46-c27c1fbb218a@gmail.com>
Date:   Thu, 21 Oct 2021 12:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/5] staging: r8188eu: remove unused dm_priv components
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211020195401.12931-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211020195401.12931-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.10.21 um 21:53 schrieb Martin Kaiser:
> Remove unused components from struct dm_priv.
> 
> DMFlag is only written to, but never read.
> InitDMFlag is assigned to DMFlag and not used elsewhere.
> DM_Type is also write-only.
> UndecoratedSmoothedPWDB and UndecoratedSmoothedCCK are not used at all.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 3 ---
>   drivers/staging/r8188eu/hal/usb_halinit.c     | 1 -
>   drivers/staging/r8188eu/include/rtl8188e_dm.h | 5 -----
>   3 files changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> index 4ce2c3749665..5d76f6ea91c4 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> @@ -87,12 +87,9 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
>   void rtl8188e_InitHalDm(struct adapter *Adapter)
>   {
>   	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
> -	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
>   	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
>   
>   	dm_InitGPIOSetting(Adapter);
> -	pdmpriv->DM_Type = DM_Type_ByDriver;
> -	pdmpriv->DMFlag = DYNAMIC_FUNC_DISABLE;
>   	Update_ODM_ComInfo_88E(Adapter);
>   	ODM_DMInit(dm_odm);
>   	Adapter->fix_rate = 0xFF;
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index cdc602fa9af8..ef1ae95d7db0 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -1469,7 +1469,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
>   		break;
>   	case HW_VAR_DM_FUNC_SET:
>   		if (*((u32 *)val) == DYNAMIC_ALL_FUNC_ENABLE) {
> -			pdmpriv->DMFlag = pdmpriv->InitDMFlag;
>   			podmpriv->SupportAbility =	pdmpriv->InitODMFlag;
>   		} else {
>   			podmpriv->SupportAbility |= *((u32 *)val);
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
> index 4a0608313f7a..208bea050f6f 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
> @@ -15,14 +15,9 @@ enum{
>   #define HP_THERMAL_NUM		8
>   /*  duplicate code,will move to ODM ######### */
>   struct	dm_priv {
> -	u8	DM_Type;
> -	u8	DMFlag;
> -	u8	InitDMFlag;
>   	u32	InitODMFlag;
>   
>   	/*  Upper and Lower Signal threshold for Rate Adaptive*/
> -	int	UndecoratedSmoothedPWDB;
> -	int	UndecoratedSmoothedCCK;
>   	int	EntryMinUndecoratedSmoothedPWDB;
>   	int	EntryMaxUndecoratedSmoothedPWDB;
>   	int	MinUndecoratedPWDBForDM;
> 

Looks good, thanks.

Acked-by: Michael Straube <straube.linux@gmail.com>

