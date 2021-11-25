Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184BC45E017
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346786AbhKYSAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbhKYR6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:58:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FFEC061397
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:45:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so8912015wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4vKqoKfjDwsNRdAizQ80SN172ZaMHTtRepnJkLw9D24=;
        b=jXcv+8tm92aTNy0ngcHrZEFmgOqgRAV0p1GYWK5dAoWC3KDsYbfKcT9deZSlDsgzww
         dCEnyMEYlYdaGiDAzL3l49J9OefCtj32tRakYPAx1cKtNhzOweg0lnImcrCh6zrqq9jf
         ze/NoEl2eCLFCZW7SydWLI5Jy+UkEG26MSjjciakeFp1rsb76sY7ovij45yinkTxYxJx
         S6DaZAGDH7LkT85Vj8GWjWZcP6pn0ALEMAA0ao+PfXaM3YE6oH7Gi4buVPmR6WNjnezk
         oxF9Z3XJv6SJV/OUJGREOIYC7u29ZjKyRrZtbZ8rzfEytQ7soUIm+1LbHKw2/ctcj2oM
         yzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4vKqoKfjDwsNRdAizQ80SN172ZaMHTtRepnJkLw9D24=;
        b=dmu+5gmQ0COONeVeO7sqp9i1auKZEsDSF4m/EAFMK5rd0xcEMLdxT7wze/C5r4Sh3X
         A6OjB+RMxIhTRIAvQbTxo8wfiudl9qnwS/2JhaY8QiSDgPglToV13pgn3HaP6O0tLoNp
         jh+TFoa/yjnh4AuKxm5xzmMQZApAk1E8MokiALAqoVL8U6UEtTm/eRMdSYcS4RW0HIhE
         x31TR/mzGnYOZJunMhaf2W7I3nbZ8tn981ewfu0Dovr2C/q94FRnbEMY5ZsV2FmJQI+P
         fC/05vXFCpERpSsfdWAMaX930GPvU22xDE+JFJCrEjmD2IbAmvsnIw6IJE1k/vJB5qoS
         2ohQ==
X-Gm-Message-State: AOAM530Tg5MZGp+cXUMmAjzjrtPOQjmVmI0C11AHfqpGg6J4EHUfL47L
        as8Gyp+Bsxw4Y4Zzs6qZ/zU=
X-Google-Smtp-Source: ABdhPJxH0bo/xUh688xVLIl06WpH3hPkdySXAVIOcjOcP/WVpDGWSc8Si3r1Udvhh9k0LVEjSKpiAQ==
X-Received: by 2002:a05:600c:6016:: with SMTP id az22mr9726744wmb.11.1637862351044;
        Thu, 25 Nov 2021 09:45:51 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::7311? ([2a02:8108:96c0:3b88::7311])
        by smtp.gmail.com with ESMTPSA id r83sm8596136wma.22.2021.11.25.09.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 09:45:50 -0800 (PST)
Message-ID: <a484ba55-7d3c-4238-7821-08826e8b0faa@gmail.com>
Date:   Thu, 25 Nov 2021 18:45:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/4] staging: r8188eu: remove _ps_open_RF
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211125164745.8188-1-martin@kaiser.cx>
 <20211125164745.8188-3-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211125164745.8188-3-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 17:47, Martin Kaiser wrote:
> The _ps_open_RF function is empty. Remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c | 8 --------
>   1 file changed, 8 deletions(-)
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
> 

Hi Martin,

The prototype of _ps_open_RF() should also be removed from
rtl8188e_hal.h.

Thanks,
Michael
