Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05827347620
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhCXK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhCXK3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:29:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC2C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:29:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j18so23872399wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c2bNZdsfH6Ornhceiin2qh2qkiBpR6XhPGrMT4pcVH4=;
        b=ePw5E1g0o+kVI0kXUc2WxsHd9/XvJaZsJGQUd+O+AY4EXhSd3OkOLrOn/D60yFuzd8
         U+fKspon/J4LCQ7lKkvfpJtz3TWCqWn42eDdgMZBYx/ZYZoRq8Letdbh7eUfc+1Kx/uO
         I9rVH0tVs0DIhPamdAJQ+pUzULh4tBHQzJzlrod/G/+L+g3E2gt/MpcN0VZ3hfP3tCUQ
         7HXyRJM2ouR/2sG8OMW99vSlMx8BtQeIr36ifLcBGN80VB09AEvh5EfT+nNw3vkwp8Kh
         1kVETmafy1909ggWHlmQ3VgJferCVQnOY4cYB7FXVL90XV7b288O4zHDH+YL/rPmIxpZ
         uyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c2bNZdsfH6Ornhceiin2qh2qkiBpR6XhPGrMT4pcVH4=;
        b=UMBklNj51D5Er2RD9YUO6h3l72vp7QEJJkVWksBufVJJMpMn4K0L26H2iN7K3eOPLo
         EhCIekgTo95yS390Z8TS9UiKlyhTw6NMWPdFWutSg3cYwBrOwRcpT5XjLM5MftFMQ7+Y
         kC/ZptKLEunzmY9jnbfOH3HEwcs6k1WRLHuolVYPHVt29RxEKxzEi8wuCFNdCoOFwB2l
         ltQxWsj3MzcpXz0io0BLAeddQzfTVahrOWwXRdUYB/f0KSDjN4BJB+SNLzZjc9IFGp3O
         SXNW9J6WDuUy1F5lWbRz3/9+NmgbXTn6VDsoEGwVdwESVhGurN+rkWV0fRy67LnUEqOj
         cIcA==
X-Gm-Message-State: AOAM530PbQXINtMZZJtxVegSJlhY6pLmqXzcFMi1yFjZLKrKgNnJ1d+6
        ct9D8NF/l8ag3ju745+gmQh/hw==
X-Google-Smtp-Source: ABdhPJwDJ/HYRu2tt07xQ/N/R2M81twGT7VbQY4hiubrWSbgHY4t4ZAZJxIq7NhaXJ04A2JjtugTsw==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr2702895wro.249.1616581773314;
        Wed, 24 Mar 2021 03:29:33 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id l5sm1892722wmh.0.2021.03.24.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 03:29:32 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:29:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <20210324102931.GH2916463@dell>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
 <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021, Andy Shevchenko wrote:

> Allow interrupts to be MSI if supported by hardware.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: new patch
>  drivers/mfd/intel_quark_i2c_gpio.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> index 52728a963c17..16ce9cb3aa2f 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -169,8 +169,8 @@ static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
>  	res[INTEL_QUARK_IORES_MEM].end =
>  		pci_resource_end(pdev, MFD_I2C_BAR);
>  
> -	res[INTEL_QUARK_IORES_IRQ].start = pdev->irq;
> -	res[INTEL_QUARK_IORES_IRQ].end = pdev->irq;
> +	res[INTEL_QUARK_IORES_IRQ].start = pci_irq_vector(pdev, 0);
> +	res[INTEL_QUARK_IORES_IRQ].end = pci_irq_vector(pdev, 0);
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
> @@ -217,7 +217,7 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
>  	pdata->properties->idx		= 0;
>  	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
>  	pdata->properties->gpio_base	= INTEL_QUARK_MFD_GPIO_BASE;
> -	pdata->properties->irq[0]	= pdev->irq;
> +	pdata->properties->irq[0]	= pci_irq_vector(pdev, 0);
>  
>  	cell->platform_data = pdata;
>  	cell->pdata_size = sizeof(*pdata);
> @@ -245,22 +245,30 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  
> +	pci_set_master(pdev);
> +
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);

Is there any way these magic number can be defined or sizeof()'ed?

[...]

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
