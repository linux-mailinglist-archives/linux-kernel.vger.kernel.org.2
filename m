Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565C03A0E6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhFIIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:05:43 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37638 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhFIIEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:04:09 -0400
Received: by mail-wr1-f51.google.com with SMTP id i94so19342563wri.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LMs7Yy0q9szMs473kW5Dr9pdXQ8OgBWvW7DSmQbHAkI=;
        b=tP29ijPhCAMTLBDh5b493Wf6iLrFZ8oVShO2ksWN1+Qjb7pFMBENvXd4EE7J6DHgcz
         6lDjdW/HjczVIrGi20H9XDahtpwpejG3HcL7PUJO2u/y4uEgVNrBVG9+MlMAx939XpuS
         5aBXrmviF008S3kakssOGQ4BWASHrlpjJ6A8klgFJLALph8AhIrPn/aag0xqOSWPJjJG
         poUt5KhMvpke33gY0JHS2PmbZw9x/ekWB/vxohfZjJ81kSTNmqbffi4tDFTOi77fsBAc
         xwB6iu2R4TdGeAJI3bt8w8/dT5I4jWMyagkxrcfbnifqgYHA2hCpt9jSadQSI08LQ2gi
         MVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LMs7Yy0q9szMs473kW5Dr9pdXQ8OgBWvW7DSmQbHAkI=;
        b=Yi5mukZfR1Sxq/rnO9qIwYl4D7flFuhqReDhuhDwWxAFpv2DgHoqREF21algKKGun7
         3CSV0ffVdxidj2tbC5BaOStbmegLpHuZVYSovGc7rDxkR9TY0wVG53/gUJy/GBxrHuQP
         H2sLjwsBXUT+7t1lvNFca/232Jxfq5KCX4JsO5SVF7SVumoVkJhml/JqJh8Tlb/6lL6S
         rcgrO2ZjKsHIGNdTuAVUD59KFl7rAUWYW6jN6dV7xtHUIB3BvHwJMM6gDUTht8kvEHsx
         nmZyoAjBV7cNw5Wbf6wwWPGeMc0eiY7dROmJiu1WVZIe5S8AHZAo8aasGlzGTuCpCyN6
         aDWA==
X-Gm-Message-State: AOAM532MDJbiHRNf20wxucV99/is8oPt/NaStBYb1BUHQrw2wTLSghU3
        LgjRGWyozuv9385ck0lQfEtT1w==
X-Google-Smtp-Source: ABdhPJwUjsG5H19gMUYalje04t2uk2PMYjCmA2vZoKVxFpeEOZwmP3Wvr4FF9CIIGPsaRj2ZVmckOQ==
X-Received: by 2002:adf:b648:: with SMTP id i8mr20557139wre.425.1623225661663;
        Wed, 09 Jun 2021 01:01:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id g17sm17851200wrp.61.2021.06.09.01.01.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 01:01:01 -0700 (PDT)
Subject: Re: [PATCH -next] ASoC: codecs: wcd: Remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, broonie@kernel.org
References: <1623221171-105359-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8ae5c164-0915-1440-54f3-bd490cd3edfa@linaro.org>
Date:   Wed, 9 Jun 2021 09:01:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1623221171-105359-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2021 07:46, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./sound/soc/codecs/wcd-mbhc-v2.c:990:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/codecs/wcd-mbhc-v2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
> index dee9410..405128c 100644
> --- a/sound/soc/codecs/wcd-mbhc-v2.c
> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
> @@ -987,7 +987,7 @@ static void wcd_mbhc_adc_update_fsm_source(struct wcd_mbhc *mbhc,
>   		wcd_mbhc_write_field(mbhc, WCD_MBHC_BTN_ISRC_CTL, 0);
>   		break;
>   
> -	};
> +	}
>   }
>   
>   static void wcd_mbhc_bcs_enable(struct wcd_mbhc *mbhc, int plug_type, bool enable)
> 
