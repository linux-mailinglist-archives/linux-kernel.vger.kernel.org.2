Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E573345FD54
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 08:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352758AbhK0IAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 03:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349664AbhK0H6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 02:58:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8368DC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 23:55:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so23619463wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 23:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ztUfsM3SCWC3T/1ssUN94OZah+ZrqUmO5RAaQ/3oAdQ=;
        b=bEmLbNv4bFVJx2M+bi+NTotdFyuLewPa3hpoxcyfimGQ6IrrBEujoqiwowtnK6v2DN
         zvhJI/0AUf32enTzqF0VeRfYlrbifVsS+P7q738oVgwFIgGVxpNWhg2suOaVLg2Qo7zP
         oQDdjk9sBbX1Xu4t+NMQ+J8ueEiC+UGg9jLzXdhbzo3RoMfxqvMjONEeFVCS7bGcHrbV
         G3I2noCCXTaUw/Tg4xSsvk0V8MswC1Wn2Bt/sSYhO3moRIfcCXQf3uV4msAFdBTkuoML
         MaUuWk31mAqwF3GDQlpP26WE4yRkQ8lMDlC9HfIacMHRMATI7yqL4ZUNkDENNlWNcalo
         Fzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ztUfsM3SCWC3T/1ssUN94OZah+ZrqUmO5RAaQ/3oAdQ=;
        b=XYoSlB2/2eg72QbajBRlMkQ6tjjNxy3f5p9IHpd51OeLELUIBFEUsaXzt1152sjvg4
         0vjjTSadTNTo6Wp/0EWNmDo7NgzvO5MZp5seEBSURqbCF2iWIazHQzWQOeTBB+M3IAtJ
         7DKspJ1jVHl5/YjYsiW+xufWefvQzsSc2eAIymJ9Wf+lxOa+PUcpLaiwReg8tR6UBfOW
         ZG8VCb0S0wbIgIf0VZ+uLq7KamUQEjLvHZKq2qjuNolsyGptu7ICVSpvtxia/zYicp3s
         dc9D6Zu53D0BlNOSlwyAPJBeY9bhW8odUxlR9gyWTG2tY7ZJdUj1pw0IjLha2p1a23Qr
         Mh9w==
X-Gm-Message-State: AOAM533dYY7IbxofiHrGGT+E9/WWmDc8aSBpNfGeMpN9Q4REF4lwTQxo
        z5RdC6dMkHkYilt/3uuC6FA04A8HBwA=
X-Google-Smtp-Source: ABdhPJzJDaAsvTssbI58AndTpFmzasC2jF/GJ7nbOCsjdP9VsoibqWQ+ioY8mMelkqgNpeGdMedaAg==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr19348772wrv.106.1637999734158;
        Fri, 26 Nov 2021 23:55:34 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::ac86? ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id g18sm16180524wmq.4.2021.11.26.23.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 23:55:33 -0800 (PST)
Message-ID: <dad54a5a-3f75-8f45-ce78-3d8313c6a451@gmail.com>
Date:   Sat, 27 Nov 2021 08:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/4] staging: r8188eu: remove _ps_open_RF
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211125164745.8188-1-martin@kaiser.cx>
 <20211126130400.26151-1-martin@kaiser.cx>
 <20211126130400.26151-3-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211126130400.26151-3-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/21 14:03, Martin Kaiser wrote:
> The _ps_open_RF function is empty. Remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>   - remove _ps_open_RF prototype
> 
>   drivers/staging/r8188eu/hal/usb_halinit.c      | 8 --------
>   drivers/staging/r8188eu/include/rtl8188e_hal.h | 1 -
>   2 files changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 04518e9838ea..995ea4a55435 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -615,8 +615,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>   	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_BEGIN);
>   
>   	if (Adapter->pwrctrlpriv.bkeepfwalive) {
> -		_ps_open_RF(Adapter);
> -
>   		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
>   			PHY_IQCalibrate_8188E(Adapter, true);
>   		} else {
> @@ -852,12 +850,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>   	return status;
>   }
>   
> -void _ps_open_RF(struct adapter *adapt)
> -{
> -	/* here call with bRegSSPwrLvl 1, bRegSSPwrLvl 2 needs to be verified */
> -	/* phy_SsPwrSwitch92CU(adapt, rf_on, 1); */
> -}
> -
>   static void _ps_close_RF(struct adapter *adapt)
>   {
>   	/* here call with bRegSSPwrLvl 1, bRegSSPwrLvl 2 needs to be verified */
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index 5848f1d4191a..176b82219459 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -331,6 +331,5 @@ void rtl8188e_read_chip_version(struct adapter *padapter);
>   
>   s32 rtl8188e_iol_efuse_patch(struct adapter *padapter);
>   void rtw_cancel_all_timer(struct adapter *padapter);
> -void _ps_open_RF(struct adapter *adapt);
>   
>   #endif /* __RTL8188E_HAL_H__ */
> 

Reviewed-by: Michael Straube <straube.linux@gmail.com>
