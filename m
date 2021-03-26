Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F301134A314
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCZIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhCZIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:16:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E379C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 01:16:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o19so5324094edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j2Hcrmn3nUH30Jkj2X8xN5fYJ4H6ig3egm18GXZOjww=;
        b=ewP+kxc1GhUVrEZKr5c1RV1TwEwb+vKfDlyhaKz/J6xfp+P2iMONlw8J7LA8cxIwQa
         9JSXHC1Rqhdr/VLCjmeEfWGljq4BOCTxvI1SZo+apVbrRb/+GbpbBCHvOcFbnWPSJgfX
         Wt2hZs6cPym8yS0WrKn0S1w12KUhc0WCo/e7Tdp+K2+r70PWG5nK3BdA3dXZ1fJlFlq+
         SmI0KH/p7+FZtnYqU6hV6md67UeFZWr/cCu16BHQrrRDH94TrJMQHOwTbfhnxpZ2F6n9
         tSzobsMPxNRZxBAxFrMD3ptSMG+7Hy96mw+CRbxVzSVNPA75KAF+kNw6uPa/SZ7n1kI7
         jfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j2Hcrmn3nUH30Jkj2X8xN5fYJ4H6ig3egm18GXZOjww=;
        b=LuP4nHvcFKBLs6XSjpxAQTki/rxdIx6DPADfGfOZcQA4rymqEfZW1WzaMabBnZTFOr
         vml59EIiGtd7LcdjrDndlH8cN5HpTnQujr8k+hbQd33DJnNyE3mm5Lzm8eW7PvROr6Mi
         ta4J5r9BUWB60a+Min1C3l8Zs+IclWMsrX8lMMyo7YEMrl+bBPrVeafdQk2rYRLUJx+e
         7RUJMqxrp+y8HJAm+rh4sUoHYYoVto2sUueK8BNnfAKSUQg9Lg/EvzVcd0TKQj/vF2KO
         3+MPtG002aOFTE1/lz/0EM1bPqrFee4g/pDXGCiwwt9H02fOjWaUPTWNjyJ1N+OpjICC
         8hZQ==
X-Gm-Message-State: AOAM530poJ5fDwGExnxr8mY52XOlt1clZVfTFGCGFn5SjBzeolgvl4nG
        BM0G4+sGsv38nhOMVsHIk40WeA==
X-Google-Smtp-Source: ABdhPJylQ4WOE2rsVVTxRd0lBGIUWFci3zXcW9mLSypc9OS+wKfnQ9GTr/bwnv+cASvgLrCZRZFi8A==
X-Received: by 2002:a50:fd8b:: with SMTP id o11mr13444232edt.346.1616746608316;
        Fri, 26 Mar 2021 01:16:48 -0700 (PDT)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id ho19sm3465077ejc.57.2021.03.26.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 01:16:47 -0700 (PDT)
Date:   Fri, 26 Mar 2021 08:16:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick
 with const
Message-ID: <20210326081646.GX2916463@dell>
References: <20210325192347.67326-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210325192347.67326-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021, Andy Shevchenko wrote:

> As Linus rightfully noticed, the driver plays dirty trick with const,
> i.e. it assigns a place holder data structure to the const field
> in the MFD cell and then drops the const by explicit casting. This
> is not how it should be.
> 
> Replace cell parameter by bar and assign local pointer res to the
> respective non-const place holder in the intel_quark_i2c_setup()
> and intel_quark_gpio_setup().
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks for spotting this Linus.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> index 7f90e6f022ba..f2bce2ade510 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -157,17 +157,16 @@ static void intel_quark_unregister_i2c_clk(struct device *dev)
>  	clk_unregister(quark_mfd->i2c_clk);
>  }
>  
> -static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
> +static int intel_quark_i2c_setup(struct pci_dev *pdev, int bar)
>  {
> +	struct mfd_cell *cell = &intel_quark_mfd_cells[bar];

What's stopping you from removing the seemingly superfluous 'bar'
parameter and simply doing:

	struct mfd_cell *cell = &intel_quark_mfd_cells[MFD_I2C_BAR];	  

> +	struct resource *res = intel_quark_i2c_res;
>  	const struct dmi_system_id *dmi_id;
>  	struct dw_i2c_platform_data *pdata;
> -	struct resource *res = (struct resource *)cell->resources;
>  	struct device *dev = &pdev->dev;
>  
> -	res[INTEL_QUARK_IORES_MEM].start =
> -		pci_resource_start(pdev, MFD_I2C_BAR);
> -	res[INTEL_QUARK_IORES_MEM].end =
> -		pci_resource_end(pdev, MFD_I2C_BAR);
> +	res[INTEL_QUARK_IORES_MEM].start = pci_resource_start(pdev, bar);
> +	res[INTEL_QUARK_IORES_MEM].end = pci_resource_end(pdev, bar);

If you do end up using 'MFD_I2C_BAR' again in here, please omit the
line wrap.  80-char lines are so 1990s!

>  	res[INTEL_QUARK_IORES_IRQ].start = pci_irq_vector(pdev, 0);
>  	res[INTEL_QUARK_IORES_IRQ].end = pci_irq_vector(pdev, 0);
> @@ -189,16 +188,15 @@ static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
>  	return 0;
>  }

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
