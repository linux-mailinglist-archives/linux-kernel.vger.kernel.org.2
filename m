Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCDD42332D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbhJEWIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhJEWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:08:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0105EC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:06:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s15so2292202wrv.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M9Muhp4IM6S5/hNPD1GTAHwYmi2Jj0Q80AHPZokCdCA=;
        b=NbZ3SJ3Hn/Pqz/FFYfvEnxNGWTO92yuKpW3QtVsNa8G1mkSmm9FURvqBXgnBon/kbF
         AW5rWmUYdbE/61HUkandHx+VowpnyxJlE8ZiNquZhifRCG2OE66nuIoTaMjswGfMrSLN
         gqivptvDQ0AasDg4YAmH3+Y2obySW6IpALLTbDpCR7mATQs1l8OAdcOLxCtgmni5JDxJ
         nfewOZdm9yHwxOMwJOUUYU8S75VKrE5aXjTUalExheiPgzAGLXR/IK5N3/aRT5zpiLcT
         iZH/Jw+QOYybEl+AN+6550/VqLK3IcjoHQO6hctcBxS4CGTxr3LyZwR//P3x3yvDeTP5
         mB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M9Muhp4IM6S5/hNPD1GTAHwYmi2Jj0Q80AHPZokCdCA=;
        b=jgBpiKowJXWr6fmG1/ObHsD5Qz3GXfRS/oGEN5U+eyjzEgNz0ngz2PDFiokFbdEqU3
         YcNqCBpFhe2EmIsk/sknVRWjulSxd1TlWxGfInVVcBwE/Pu+ZTjdt/mhVv4M/3qExYxb
         P4ah0mvAySbqoCRzrEfm0BV5TM9TcyTmblSCILu3ASycbuyGu+EuZmrTnDwVVg9vH14X
         thGg5pLrY8HGQtoPqHJkKMl48yGgoiRYMlB5UgEjkKvZ9xG0v1ZmUCH/ldETvjjNq5eT
         mZIHK86yJZYqvXL8psEnShVIbaub77ISroUnZSiXCBy7PjqqCZ++kmefTWYi/r26ExR2
         bmwQ==
X-Gm-Message-State: AOAM531KAPMHwwzmeAYGKM9LIpFqJ53OmextXJrbioUXtF4YQXneSmpK
        69ES0zAsTk0llqc8BVnnyEw=
X-Google-Smtp-Source: ABdhPJyXb7dSIs5lTN3TL+YdL/peE1Jn3E5DaXgmF5ArxE1yW/BHgn14TNUv8yl2Z8OUoXRDk1QQ7g==
X-Received: by 2002:adf:a31d:: with SMTP id c29mr23783587wrb.381.1633471572643;
        Tue, 05 Oct 2021 15:06:12 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id c204sm3310204wme.11.2021.10.05.15.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:06:12 -0700 (PDT)
Message-ID: <faa44ffb-197c-a6a9-3f0e-fd031c7b6b98@gmail.com>
Date:   Wed, 6 Oct 2021 00:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 3/9] staging: r8188eu: remove write-only HwRxPageSize
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211005200821.19783-1-martin@kaiser.cx>
 <20211005200821.19783-3-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211005200821.19783-3-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 22:08, Martin Kaiser wrote:
> HwRxPageSize from struct hal_data_8188e is set but never read. Remove
> the component and the code to initialise it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c     | 20 -------------------
>   .../staging/r8188eu/include/rtl8188e_hal.h    |  1 -
>   .../staging/r8188eu/include/rtl8188e_spec.h   |  4 ----
>   3 files changed, 25 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index ab7b80144403..f71f25e234ab 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -524,26 +524,6 @@ usb_AggSettingRxUpdate(
>   		/*  TODO: */
>   		break;
>   	}
> -
> -	switch (PBP_128) {
> -	case PBP_128:
> -		haldata->HwRxPageSize = 128;
> -		break;
> -	case PBP_64:
> -		haldata->HwRxPageSize = 64;
> -		break;
> -	case PBP_256:
> -		haldata->HwRxPageSize = 256;
> -		break;
> -	case PBP_512:
> -		haldata->HwRxPageSize = 512;
> -		break;
> -	case PBP_1024:
> -		haldata->HwRxPageSize = 1024;
> -		break;
> -	default:
> -		break;
> -	}
>   }	/*  usb_AggSettingRxUpdate */
>   
>   static void InitUsbAggregationSetting(struct adapter *Adapter)
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index 08dedf4c91b8..fc6acbba17e7 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -360,7 +360,6 @@ struct hal_data_8188e {
>   	u8	C2hArray[16];
>   	u8	UsbTxAggMode;
>   	u8	UsbTxAggDescNum;
> -	u16	HwRxPageSize;		/*  Hardware setting */
>   	u32	MaxUsbRxAggBlock;
>   
>   	enum usb_rx_agg_mode UsbRxAggMode;
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
> index 1c96f7b81245..01aeaa4ac605 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
> @@ -893,11 +893,7 @@ Current IOREG MAP
>   #define _PSRX(x)			(x)
>   #define _PSTX(x)			((x) << 4)
>   
> -#define PBP_64				0x0
>   #define PBP_128				0x1
> -#define PBP_256				0x2
> -#define PBP_512				0x3
> -#define PBP_1024			0x4
>   
>   /* 2 TX/RXDMA */
>   #define RXDMA_ARBBW_EN			BIT(0)
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
