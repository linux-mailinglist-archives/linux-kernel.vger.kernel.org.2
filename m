Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9A53986F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhFBKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhFBKux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:50:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF662C061342
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:49:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h3so970117wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uVBlsRFTHCeuVjtOR8DvHR+ZbSUU8NiMoCv4vvQPWR4=;
        b=PFKMes1CWeW4Lt7ekTMQhneKZrfRvqa5iHYBdQT0dS8+fFS/W+pLftluaZsbFxlx+0
         EF4O43ljaMI4YsjGSOolRDMS1FGAstanDEsaD9mfcrqEdgm4rI5NBCIL3wdo6/wMmCMZ
         P3LiP0n5bZa6EvAG+Ldcggrn0edt25gvns5JYcXYbXs5r/uli3pj+YIUFzLIayTR7urd
         awOuCbstqgC9y+8NTSqnvmeCiKinSWCovc3M/M9e0N0qaLzKLlWu6ggkk8aJUmR2bBdy
         u9nFlBrbl0Dxa5twRixrCfJVs9X1rZzWtOS2hs2+E1yD1HdSircZozbF82C87PTKhFEQ
         NCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uVBlsRFTHCeuVjtOR8DvHR+ZbSUU8NiMoCv4vvQPWR4=;
        b=jPlLY10ddqJq4iMx2IM9ShTIZHfPBnbyDVlOU8Ld9FI8unRTjhDvSpG10OCI+blnqn
         +A2MZoT6reOyNDESx1AarTy0YB2eYTnu6w+nCpMzUwJ/oP57Wtvo4fv4u2kIrbPQTYrJ
         WbQX8dCjWT/9BtNXwgqmvHa0Hq+Y1pNPZ9HdVFT649BTodu7svR2bnOPDiqXNOvH4G+M
         xBOEM81ev/C5sulj0mfqGMJJ2UD3Oh00WsMbjsiM9TIhM8Z2NYlE6BfmbUqg7JlsRYvV
         B3N61QjG29SleuEgQL2o3D/zRJS8RHQIrDcNwHHTXA3Fd8gdKJ0puD6WZLo+AMtbhYsZ
         mzFQ==
X-Gm-Message-State: AOAM532nWe3xXdq2kFnmVmk1m2QqT+F/RCeX9j09Oqzo+QYpCW9/S8mH
        A8+R3D0Bt7YZa4enJp8iaHSiqw==
X-Google-Smtp-Source: ABdhPJzgntdzIWxpFimBaoTHOianeW/vQhWeASnbGWI/4VhnVm0R8ODbgjoEEfwMUS2Fb0yYBN4xsA==
X-Received: by 2002:a1c:1dd5:: with SMTP id d204mr4527775wmd.140.1622630946359;
        Wed, 02 Jun 2021 03:49:06 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id p20sm2255262wmq.10.2021.06.02.03.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:49:05 -0700 (PDT)
Date:   Wed, 2 Jun 2021 11:49:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, luka.perkov@sartura.hr,
        jmp@epiphyte.org, pmenzel@molgen.mpg.de, buczek@molgen.mpg.de
Subject: Re: [PATCH v3 1/6] mfd: simple-mfd-i2c: Add Delta TN48M CPLD support
Message-ID: <20210602104904.GJ2173308@dell>
References: <20210531125143.257622-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210531125143.257622-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021, Robert Marko wrote:
65;6200;1c
> Delta TN48M switches have a Lattice CPLD that serves
> multiple purposes including being a GPIO expander.
> 
> So, lets use the simple I2C MFD driver to provide the MFD core.
> 
> Also add a virtual symbol which pulls in the simple-mfd-i2c driver and
> provide a common symbol on which the subdevice drivers can depend on.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v2:
> * Drop the custom MFD driver and header
> * Use simple I2C MFD driver
> 
>  drivers/mfd/Kconfig          | 10 ++++++++++
>  drivers/mfd/simple-mfd-i2c.c |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b74efa469e90..2b5ad314125d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -297,6 +297,16 @@ config MFD_ASIC3
>  	  This driver supports the ASIC3 multifunction chip found on many
>  	  PDAs (mainly iPAQ and HTC based ones)
>  
> +config MFD_TN48M_CPLD
> +	tristate "Delta Networks TN48M switch CPLD driver"
> +	depends on I2C
> +	select MFD_SIMPLE_MFD_I2C
> +	help
> +	  Select this option to enable support for Delta Networks TN48M switch
> +	  CPLD. It consists of MFD and GPIO drivers. CPLD provides GPIOS-s

Not entirely sure what MFD means in this context.

Please replace the MFD mention with Reset.

> +	  for the SFP slots as well as power supply related information.
> +	  SFP support depends on the GPIO driver being selected.
> +
>  config PMIC_DA903X
>  	bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
>  	depends on I2C=y
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 87f684cff9a1..af8e91781417 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -39,6 +39,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>  
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "kontron,sl28cpld" },
> +	{ .compatible = "delta,tn48m-cpld" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);

Once fixed, please apply my:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
