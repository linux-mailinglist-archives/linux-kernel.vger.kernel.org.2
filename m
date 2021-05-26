Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC33391C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhEZPvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:51:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34076 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbhEZPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:51:19 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llvml-0005fx-R2
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 15:49:31 +0000
Received: by mail-ua1-f71.google.com with SMTP id t19-20020ab021530000b029020bc458f62fso939165ual.20
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 08:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUY/OX0+pta5kTvyLKotdE7y+h+efskwB6GqpwrAtbE=;
        b=tdGT/81E3gIrbyoP/7xRDVM/bfhhFgdKxSRLBeLrBw1gOA9EXob3JnqJMokA9Ig0Q6
         bAYlAWnmcp9M19bTK3ybMldxn+BW/AkdsVsEqr8oh9GYd4YWh7YF7twa8DLWDez/zksn
         79on+oV/PukMIkMSqBWd/8CDgGsPlzvkcgjfBohq5SDcbzRSR/BOD5byQwB5vsOM6CNx
         B/oNNBdKwkunNKbV1qW7lITtTc1bwkZEWSPj5xt638/W8ub/FT4QFJkyrI6YNf6XTpkD
         MGIi3LeXmd/kJUxIifC54gSeAo4Cvghnp2Ysg3latCuuAyWos9jnkun/EP6NUgUOIfaV
         rjIA==
X-Gm-Message-State: AOAM530t20ppi6EBHT722FWLrOeYsFc/ecwKPll+L+eDTgUT+njfLgou
        CLlXEUwBQ2FXYB24tid7pykJ96vMVWD5xkrzLn5CBJ+9tmN7OckF6T1QUPngqyDUAxVTKqlGz+Z
        K2qX1bSwGbfhGeRUttPEH1aJuhYe4+JMt8VB41EQZOg==
X-Received: by 2002:a05:6102:c2:: with SMTP id u2mr31702923vsp.33.1622044170965;
        Wed, 26 May 2021 08:49:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvefn6kxtU4lD+c0/LmjrXRf549ePApFZ2JMocX7btTNnsZ72vHEsRMfGiA3/hAMPICFaOMQ==
X-Received: by 2002:a05:6102:c2:: with SMTP id u2mr31702889vsp.33.1622044170743;
        Wed, 26 May 2021 08:49:30 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id o2sm2258084vsq.30.2021.05.26.08.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 08:49:29 -0700 (PDT)
Subject: Re: [PATCH -next] ASoC: samsung: midas_wm1811: Fix build error when
 CONFIG_GPIOLIB is not set
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Simon Shields <simon@lineageos.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210526144339.2392592-1-weiyongjun1@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d1aad7a0-a27e-286f-1bcf-51b035d1d8ae@canonical.com>
Date:   Wed, 26 May 2021 11:49:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526144339.2392592-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2021 10:43, Wei Yongjun wrote:
> Fix build error when CONFIG_GPIOLIB is not set:
> 
> sound/soc/samsung/midas_wm1811.c: In function 'midas_fm_set':
> sound/soc/samsung/midas_wm1811.c:205:3: error:
>  implicit declaration of function 'gpiod_set_value_cansleep';
>  did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
>   205 |   gpiod_set_value_cansleep(priv->gpio_fm_sel, 1);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~
>       |   gpio_set_value_cansleep
> sound/soc/samsung/midas_wm1811.c: In function 'midas_probe':
> sound/soc/samsung/midas_wm1811.c:445:22: error:
>  implicit declaration of function 'devm_gpiod_get_optional';
>  did you mean 'devm_clk_get_optional'? [-Werror=implicit-function-declaration]
>   445 |  priv->gpio_fm_sel = devm_gpiod_get_optional(dev, "fm-sel", GPIOD_OUT_HIGH);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~
>       |                      devm_clk_get_optional

The fix does not match the error. The consumer.h has necessary stubs for
!GPIOLIB case.

To fix this error, you do not depend on GPIOLIB, but include proper
header (consumer.h). The dependency (with compile test) is still nice,
but for runtime fix, not build time, which is a separate patch.


Best regards,
Krzysztof

> sound/soc/samsung/midas_wm1811.c:445:61:
>  error: 'GPIOD_OUT_HIGH' undeclared (first use in this function);
>  did you mean 'GPIOF_INIT_HIGH'?
>   445 |  priv->gpio_fm_sel = devm_gpiod_get_optional(dev, "fm-sel", GPIOD_OUT_HIGH);
>       |                                                             ^~~~~~~~~~~~~~
>       |                                                             GPIOF_INIT_HIGH
> 
> Fixes: fd0ea9cd9698 ("ASoC: samsung: Add sound support for Midas boards")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/samsung/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index a2221ebb1b6a..22be597b1dd9 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -228,6 +228,7 @@ config SND_SOC_SAMSUNG_ARIES_WM8994
>  config SND_SOC_SAMSUNG_MIDAS_WM1811
>  	tristate "SoC I2S Audio support for Midas boards"
>  	depends on SND_SOC_SAMSUNG
> +	depends on GPIOLIB
>  	select SND_SAMSUNG_I2S
>  	select SND_SOC_WM8994
>  	help
> 
