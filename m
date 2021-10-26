Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238A643B818
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbhJZRYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhJZRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:24:23 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28464C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:21:59 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so20838746ote.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KrMEDb93NVG8wBaIY/4mJVXhQY324aYui9XsvdWiaGg=;
        b=H+g0ntGG+dkWUCwYkPQTAbz0vzmuMB8ZCM+Dybev/ZIepNKfnJMZD/XVsT8tce7zmh
         2+3ntmO4nI2k7ncVAZYays+7p2FeYqBBUJmLuPE9C8W48fwK5hSTDQL2KvqJjzKfXA/6
         ZLjSlof+2tq40F5R0rel1Mk+ErOCt9jwUpajiGWgLeOQZ2e9vKODYo9GhLPedK1raDco
         u2GLGztd9lNSxWH7Es6cng5OfNjZ4NZQk1wxsIe8h2zc97xGRb4PwAPvIBJ2in1Vt6JH
         2TJvEBcp6Akz6CDYF/V2JpuY9sw9ZWaJJCqgSYkhe2w8jrfp9rjL+Ilwc6frcr5nL2q0
         adfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KrMEDb93NVG8wBaIY/4mJVXhQY324aYui9XsvdWiaGg=;
        b=PP+ZbUpKTI9Y0LRHLtOtSLX7TsswkYfJj0MpZ8TkfwDQKYHUtv1K/nfjnmfODCl7ur
         /MNaydNN0606t1M2MSRGMXvE8sG32paiNosttUXWmwPDCPHwO9ZX8u4qZmCjkcLKE3aU
         14zgRR13RBfMPuGBSsPxutGhn0fZHEeIwkVHXLrrDOAtRYkUe5wey0to9RZzgWhJybMk
         5nJQT1pee4a+LMFRZVBBsHP7fataWOKqQEGncxDixUvmj3egJnEC5elzSdmo6mhqx0Qr
         9yZUjwZOTt82CnlwPl9txe3zbaE+VI7FE5NFOk28dQwK+pDC8LDtZSLy1wDKvgwQrKHy
         Rl8A==
X-Gm-Message-State: AOAM5327CRVErA90hvO2qBleBBrxCERoT2wIzsmNO4yyAaRvpJAacO5A
        vfF42Ed7wJelk5XBb1cE7dCRhQ==
X-Google-Smtp-Source: ABdhPJzDesfHmFCkImYfH73SnvFwV7aHPTFhD3dKa2TYYZpEfWB2qU/WgSuxba4An1Ex4b7Hd8GHrw==
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr20294397ots.32.1635268918467;
        Tue, 26 Oct 2021 10:21:58 -0700 (PDT)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id w17sm4782682otm.50.2021.10.26.10.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:21:58 -0700 (PDT)
Message-ID: <65243a98-61b9-3311-f41d-fa4782448baa@kali.org>
Date:   Tue, 26 Oct 2021 12:21:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v7 1/3] pwm: Introduce single-PWM of_xlate function
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/25/21 12:09 PM, Bjorn Andersson wrote:
> The existing pxa driver and the upcoming addition of PWM support in the
> TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
> thereby a need for a of_xlate function with the period as its single
> argument.
>
> Introduce a common helper function in the core that can be used as
> of_xlate by such drivers and migrate the pxa driver to use this.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> ---
>
> Changes since v6:
> - None
>
>   drivers/pwm/core.c    | 26 ++++++++++++++++++++++++++
>   drivers/pwm/pwm-pxa.c | 16 +---------------
>   include/linux/pwm.h   |  2 ++
>   3 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4527f09a5c50..2c6b155002a2 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -152,6 +152,32 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
>   }
>   EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
>   
> +struct pwm_device *
> +of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> +{
> +	struct pwm_device *pwm;
> +
> +	if (pc->of_pwm_n_cells < 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* validate that one cell is specified, optionally with flags */
> +	if (args->args_count != 1 && args->args_count != 2)
> +		return ERR_PTR(-EINVAL);
> +
> +	pwm = pwm_request_from_chip(pc, 0, NULL);
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	pwm->args.period = args->args[0];
> +	pwm->args.polarity = PWM_POLARITY_NORMAL;
> +
> +	if (args->args_count == 2 && args->args[2] & PWM_POLARITY_INVERTED)
> +		pwm->args.polarity = PWM_POLARITY_INVERSED;
> +
> +	return pwm;
> +}
> +EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
> +
>   static void of_pwmchip_add(struct pwm_chip *chip)
>   {
>   	if (!chip->dev || !chip->dev->of_node)
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index a9efdcf839ae..238ec88c130b 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -148,20 +148,6 @@ static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
>   	return id ? id->data : NULL;
>   }
>   
> -static struct pwm_device *
> -pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> -{
> -	struct pwm_device *pwm;
> -
> -	pwm = pwm_request_from_chip(pc, 0, NULL);
> -	if (IS_ERR(pwm))
> -		return pwm;
> -
> -	pwm->args.period = args->args[0];
> -
> -	return pwm;
> -}
> -
>   static int pwm_probe(struct platform_device *pdev)
>   {
>   	const struct platform_device_id *id = platform_get_device_id(pdev);
> @@ -187,7 +173,7 @@ static int pwm_probe(struct platform_device *pdev)
>   	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
>   
>   	if (IS_ENABLED(CONFIG_OF)) {
> -		pc->chip.of_xlate = pxa_pwm_of_xlate;
> +		pc->chip.of_xlate = of_pwm_single_xlate;
>   		pc->chip.of_pwm_n_cells = 1;
>   	}
>   
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 725c9b784e60..dd51d4931fdc 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -414,6 +414,8 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
>   
>   struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
>   		const struct of_phandle_args *args);
> +struct pwm_device *of_pwm_single_xlate(struct pwm_chip *pc,
> +				       const struct of_phandle_args *args);
>   
>   struct pwm_device *pwm_get(struct device *dev, const char *con_id);
>   struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,

v7 of the series is tested by me on the Lenovo Yoga C630

Tested-By: Steev Klimaszewski <steev@kali.org>

