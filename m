Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85C8347676
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCXKrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhCXKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:47:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD99C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:47:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x7so1465960wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RFJC5LVgMGym5UjOW55CJgbtGhV9mkAemOL0bTvX1iI=;
        b=EqQoqzA7HsaTzNuntCIkR+riixnRU68VFyohSNUUooZevc/p8Z/654bZuFr1UQCwQp
         umUWUxdY4bN1xHR0+w4HKEJ5b/YQ4GI2SqeTshED862aIEQGV01Oe/KQ9VJ7efLWrW1+
         NFPSzvhYZeInFTIDO3YiZ4wjliG+S5pvx/TF69jXmM2E0J91qJT+NvtiyVi1AUR0hyys
         hP4zNVBJudbL6POsdanAh6JljNLXzChVYzcNk5lGxTu4jVREbBtyhpcykqhJkCCY4tla
         QH4VGhLXRH1pUVOzY0SFoz8UhIngb+wVi8sC4NlJz+hrh0m+zg7ugXcZ1JVVyG5pSWbb
         kN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RFJC5LVgMGym5UjOW55CJgbtGhV9mkAemOL0bTvX1iI=;
        b=jNz7DWKtM6apuWSUmIP95vY5ge9k1/BVGlNOfNSw2qIine/77TizF5+PSHeTGiSuE4
         SafyCkyIt5F35m/7FfnqiEIUxMU/FxhpG5qPvAvXe4WyxVrw8BOLPQ5L7lbu87oPhur8
         xliBxtwmNSph4inmky3UPNTUopN40zeRlr/5Dog8j0hMetK0e8ZSlj21EjnKlrHSvW+e
         wHXYkeqP/uZ1PJaoPRbHebnhzAE6iHmXk2wGb3G7jZSOAl6Jof42QBBzap2ntygazIpH
         9iGAZU9ECeZQHSbvbn8xeWR51kAHH/lKdO56sGoUMdlwMnrDKiEPpzN/sdIEsj08k3K1
         j54A==
X-Gm-Message-State: AOAM5334pryRi+ZwHa7NJei47yU0QbHxhOk/L5g+1b8IzV5re8qHSPPY
        tnMz7BoN+cb4mIPLPbgLCQXEjw==
X-Google-Smtp-Source: ABdhPJyPlcyZoZ7V+z7aDolfoaRFyWtPmcuNvbU0EVaR4/UQ+3hvEkE/qnsyogmsxUVOpxnzO35GUw==
X-Received: by 2002:a5d:4105:: with SMTP id l5mr2871878wrp.105.1616582852031;
        Wed, 24 Mar 2021 03:47:32 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id h21sm1852674wmp.10.2021.03.24.03.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 03:47:31 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:47:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <20210324104729.GL2916463@dell>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
 <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
 <20210324102931.GH2916463@dell>
 <YFsW26BH1LZM9ZBs@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFsW26BH1LZM9ZBs@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Andy Shevchenko wrote:

> On Wed, Mar 24, 2021 at 10:29:31AM +0000, Lee Jones wrote:
> > On Tue, 23 Mar 2021, Andy Shevchenko wrote:
> > 
> > > Allow interrupts to be MSI if supported by hardware.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > v2: new patch
> > >  drivers/mfd/intel_quark_i2c_gpio.c | 21 +++++++++++++++------
> > >  1 file changed, 15 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> > > index 52728a963c17..16ce9cb3aa2f 100644
> > > --- a/drivers/mfd/intel_quark_i2c_gpio.c
> > > +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> > > @@ -169,8 +169,8 @@ static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
> > >  	res[INTEL_QUARK_IORES_MEM].end =
> > >  		pci_resource_end(pdev, MFD_I2C_BAR);
> > >  
> > > -	res[INTEL_QUARK_IORES_IRQ].start = pdev->irq;
> > > -	res[INTEL_QUARK_IORES_IRQ].end = pdev->irq;
> > > +	res[INTEL_QUARK_IORES_IRQ].start = pci_irq_vector(pdev, 0);
> > > +	res[INTEL_QUARK_IORES_IRQ].end = pci_irq_vector(pdev, 0);
> > >  
> > >  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > >  	if (!pdata)
> > > @@ -217,7 +217,7 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
> > >  	pdata->properties->idx		= 0;
> > >  	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
> > >  	pdata->properties->gpio_base	= INTEL_QUARK_MFD_GPIO_BASE;
> > > -	pdata->properties->irq[0]	= pdev->irq;
> > > +	pdata->properties->irq[0]	= pci_irq_vector(pdev, 0);
> > >  
> > >  	cell->platform_data = pdata;
> > >  	cell->pdata_size = sizeof(*pdata);
> > > @@ -245,22 +245,30 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	pci_set_master(pdev);
> > > +
> > > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> > 
> > Is there any way these magic number can be defined or sizeof()'ed?
> 
> Grep for it in the kernel, it's rarely defined.

I already did.  It is sometimes defined, other times not.

Also, past acceptance does not guarantee ideal/correct usage.

> The semantic is min-max range and having two defines (*) here for these seems
> to me as an utter overkill.
> 
> Of course, if you insist I may do it.
> 
> *) since value is the same, we might have one definition, but it will be even
>    more confusion to have it as a min and max at the same time.

It's just tricky to decypher for people who do not know the API, which
is most people, myself included.  For APIs like usleep_range() et al.,
obviously this makes no sense at all.

What defines a vector?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
