Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE2E345AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCWJVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhCWJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:21:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE0FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:21:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u9so25885674ejj.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OeYTtzFFVQYAu3mqgnfF3k2nxsKXQIGzKw8WTsN6rJ8=;
        b=wocVuzyOt62na5kwmtZNmF7FujKZUVq7+Nz2W70dew8hNkpd4yoKo8hu8QRVOVtdB4
         +a1i8MBS0SqS8PYA2Gan9pO/bexE+5o5+i0LgxX8QGn888K8yMLPB7L9nN4IAn46KtRD
         ujV5gKWyPkaI4vU0eAFysT1wS4I6iL1Cb8rrRrgZ3zVchoiEFrtdxNgkj61PPz3HHRaF
         ehxWuhlGsq7e7tUaLoMSL1QuZDI0m5tn3FfD0Tl1Xk+LwQnEeNdf+AuxjQzp9HI4k5Ft
         24HOfUs2BmvQb3P/osH7kOi0goLUoN3u8uKRl143BeNd8a/8pYSNvcKs+KDuGrnXDry3
         4IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OeYTtzFFVQYAu3mqgnfF3k2nxsKXQIGzKw8WTsN6rJ8=;
        b=fkWTOr4qxdFKOWNzcgBu6wNSR5A0Fhc08Lp80R0IIG2RA2ZVbW5qYnAUdwNjaystmW
         QkDMVAJFKvbUQvhWAM2PxyV+mOM6KFAWSGOpRctPeytZqeivSVwwJAsC7vRAaJl0/cCZ
         66TyIDQAsffWN3DyxnFn0WWSgQqR7InzwpxSyw7VHQvtOuRei4MhIc9BP0jb4ETJRmCB
         9Tr/Z8SXAadEGpiNAxlujpLK3b/Z9L/sxto9voTacvuBVGi4J71SX1Xz9ZXx12ATkUEC
         5TABenSb39ybfJ9PZWZkJnMoYxws+9Ii8fDcH1bU/4Eiw6+d+W4vmRa+r9NMO9wBjB+E
         +xWg==
X-Gm-Message-State: AOAM530z0Bn164YzMvBlZGm0615FdJWzKuxOTAWtCatFFXxQEDM8ajdf
        X6ZL28W/sHOWeK4kHxgpn76KO9Ehucibjg==
X-Google-Smtp-Source: ABdhPJwYzt/CApjwNq5eUcehahI6RfyXk0eXjZQCnytCaMmCHOVqkl2b00dcmJJq6S2HcTsZcualMw==
X-Received: by 2002:a17:906:aada:: with SMTP id kt26mr3865790ejb.137.1616491259261;
        Tue, 23 Mar 2021 02:20:59 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id n16sm10783459ejy.35.2021.03.23.02.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:20:58 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:20:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] mfd: intel_quark_i2c_gpio: Reuse BAR definitions
 for MFD cell indexing
Message-ID: <20210323092057.GM2916463@dell>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
 <20210302135620.89958-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302135620.89958-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021, Andy Shevchenko wrote:

> It's convenient and less error prone to use definitions to address
> different cells in an array. For this purpose we may reuse existing
> BAR definitions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> index 7af22d1399e1..40871ce34e82 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -98,14 +98,6 @@ static struct mfd_cell_acpi_match intel_quark_acpi_match_gpio = {
>  };
>  
>  static struct mfd_cell intel_quark_mfd_cells[] = {
> -	{
> -		.id = MFD_GPIO_BAR,
> -		.name = "gpio-dwapb",
> -		.acpi_match = &intel_quark_acpi_match_gpio,
> -		.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
> -		.resources = intel_quark_gpio_res,
> -		.ignore_resource_conflicts = true,
> -	},
>  	{
>  		.id = MFD_I2C_BAR,
>  		.name = "i2c_designware",
> @@ -114,6 +106,14 @@ static struct mfd_cell intel_quark_mfd_cells[] = {
>  		.resources = intel_quark_i2c_res,
>  		.ignore_resource_conflicts = true,
>  	},
> +	{
> +		.id = MFD_GPIO_BAR,
> +		.name = "gpio-dwapb",
> +		.acpi_match = &intel_quark_acpi_match_gpio,
> +		.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
> +		.resources = intel_quark_gpio_res,
> +		.ignore_resource_conflicts = true,
> +	},
>  };

I would make this more explicit.

[MFD_I2C_BAR] = { }

If someone comes along and re-reorders these, it will break.

>  static const struct pci_device_id intel_quark_mfd_ids[] = {
> @@ -245,11 +245,11 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  
> -	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[1]);
> +	ret = intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[MFD_I2C_BAR]);
>  	if (ret)
>  		goto err_unregister_i2c_clk;
>  
> -	ret = intel_quark_gpio_setup(pdev, &intel_quark_mfd_cells[0]);
> +	ret = intel_quark_gpio_setup(pdev, &intel_quark_mfd_cells[MFD_GPIO_BAR]);
>  	if (ret)
>  		goto err_unregister_i2c_clk;
>  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
