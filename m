Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DB63CFD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbhGTOob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbhGTO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:26:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF1CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:07:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c17so5427432wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZchSkqqeZHzePVYsbmpNPWMr8AHwfOK/Nimhsgdw20k=;
        b=wceYh3thBth6Xa62fuP1K5Ul4BsCMcJuj9jMyeBMI6EHhauuhkeYgIbSNH2GW+adn6
         h1QXKDD3eaiBN2uG2HgonalMI1tAPXtvf8XvdcGNz+kHmAE0myT8VjKY1qNxXTKovdig
         CSs7hHT9M+/UaDqrofrtU+uxzOaqaiA+t/rTOr3v+wcxs9IKFEuJUAdiNSbbIX8Z5JQI
         Gp3LOOxJ1N5MkQmFkogou6Bk06IHNXmqqcnzbS4xL5oNc4ZBBps0exNOWkVVdjGyLvob
         cUBIVOi1M3MTj5fMeS6Xc/DrirM0Wm9dwbUl1D5DH8Mciyy5ALWoTqZaZ7q0CV3e4ExP
         Lm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZchSkqqeZHzePVYsbmpNPWMr8AHwfOK/Nimhsgdw20k=;
        b=QSKA7ne6ZcJmn7HlL8pq94YDc9ovvA0HyUyoXou47K0VHmDdiU9uKCWPrOMB/Qspab
         ssgxHWs73W6vbrWN5H51CvjiujQKaJhGQGyJc4Q4qJXyyRQTSkAVxx/VWwoxzMv3+Xov
         DaYpOtkW6bhQ81Oop5LCbql4+xbf2JFfsOkKYBCHsktcJ98P0E8YPUO2FN6lpIjDJPEX
         r/rkE1ZCNQ2tpz254zgHiYH3VTqLBIs5T17hp5ESJNgP7G01oDd8bZAgM83H03LCelZ/
         ajfl7W6pO9mmJbUDVaWxgMEgyrA6rBb6lqkLY1XAkZJt2jQXSEBSL5ron3Kf+luY0iyU
         YcdA==
X-Gm-Message-State: AOAM530g4zsmvo9bS+WSbk5HxsmXXLwK77Zrp1JTZMnaF1SGPPNZeJ70
        vxsHyZP2JI1zfh3i3te3ntC+9w==
X-Google-Smtp-Source: ABdhPJz4swRydDEinMuj8EVyfy7S6E0iFeWjbsF6RSRqUQMZ4nsjJslx2T3fEkUS2AtZ6FigTFlw/Q==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr32300209wmh.186.1626793629290;
        Tue, 20 Jul 2021 08:07:09 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id b12sm24216314wro.1.2021.07.20.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 08:07:08 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:07:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
Message-ID: <YPbmmqfOuE5w6EgW@google.com>
References: <20210625224744.1020108-1-kernel@esmil.dk>
 <20210625224744.1020108-3-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625224744.1020108-3-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2021, Emil Renner Berthing wrote:

> The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> the SoC, but it is still useful to be able to reach the PMIC over I2C
> for the other functionality it provides.
> 
> [1] https://github.com/beagleboard/beaglev-starlight
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---

This is not present in my current tree.

Looks like it's still *.txt.

Am I missing a patch?

>  drivers/mfd/tps65086.c                        | 21 ++++++++++---------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> index ba638bd10a58..4b629fcc0df9 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> @@ -87,9 +87,6 @@ additionalProperties: false
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-controller
> -  - '#interrupt-cells'
>    - gpio-controller
>    - '#gpio-cells'
>    - regulators
> diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
> index 341466ef20cc..cc3478ee9a64 100644
> --- a/drivers/mfd/tps65086.c
> +++ b/drivers/mfd/tps65086.c
> @@ -100,29 +100,30 @@ static int tps65086_probe(struct i2c_client *client,
>  		 (char)((version & TPS65086_DEVICEID_OTP_MASK) >> 4) + 'A',
>  		 (version & TPS65086_DEVICEID_REV_MASK) >> 6);
>  
> -	ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
> -				  &tps65086_irq_chip, &tps->irq_data);
> -	if (ret) {
> -		dev_err(tps->dev, "Failed to register IRQ chip\n");
> -		return ret;
> +	if (tps->irq > 0) {
> +		ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
> +					  &tps65086_irq_chip, &tps->irq_data);
> +		if (ret) {
> +			dev_err(tps->dev, "Failed to register IRQ chip\n");
> +			return ret;
> +		}
>  	}
>  
>  	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65086_cells,
>  			      ARRAY_SIZE(tps65086_cells), NULL, 0,
>  			      regmap_irq_get_domain(tps->irq_data));
> -	if (ret) {
> +	if (ret && tps->irq > 0)
>  		regmap_del_irq_chip(tps->irq, tps->irq_data);
> -		return ret;
> -	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int tps65086_remove(struct i2c_client *client)
>  {
>  	struct tps65086 *tps = i2c_get_clientdata(client);
>  
> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
> +	if (tps->irq > 0)
> +		regmap_del_irq_chip(tps->irq, tps->irq_data);
>  
>  	return 0;
>  }

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
