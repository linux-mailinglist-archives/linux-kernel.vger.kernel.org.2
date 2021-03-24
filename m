Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA334764F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhCXKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:39:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:17580 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233141AbhCXKj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:39:26 -0400
IronPort-SDR: OasJ0VLNRIjTPMaedq3CQfSMh8nA47dytzFkjrSIuQHKgQiBJqXlN7Enqh04ltAuLN2II2upkc
 OPDc2C5JoTLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="170650664"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="170650664"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 03:39:26 -0700
IronPort-SDR: 3KuTO0JoxT8SXmgX21poq3U5q2s70H8CwL4wp4ui3Uvj+JEBjxzCxmLOx3PDyfgt5TN1fmLlBf
 pb3emPBz62xQ==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="514139851"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 03:39:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lP0v5-00Fdt8-Ew; Wed, 24 Mar 2021 12:39:23 +0200
Date:   Wed, 24 Mar 2021 12:39:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <YFsW26BH1LZM9ZBs@smile.fi.intel.com>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
 <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
 <20210324102931.GH2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324102931.GH2916463@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:29:31AM +0000, Lee Jones wrote:
> On Tue, 23 Mar 2021, Andy Shevchenko wrote:
> 
> > Allow interrupts to be MSI if supported by hardware.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: new patch
> >  drivers/mfd/intel_quark_i2c_gpio.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> > index 52728a963c17..16ce9cb3aa2f 100644
> > --- a/drivers/mfd/intel_quark_i2c_gpio.c
> > +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> > @@ -169,8 +169,8 @@ static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
> >  	res[INTEL_QUARK_IORES_MEM].end =
> >  		pci_resource_end(pdev, MFD_I2C_BAR);
> >  
> > -	res[INTEL_QUARK_IORES_IRQ].start = pdev->irq;
> > -	res[INTEL_QUARK_IORES_IRQ].end = pdev->irq;
> > +	res[INTEL_QUARK_IORES_IRQ].start = pci_irq_vector(pdev, 0);
> > +	res[INTEL_QUARK_IORES_IRQ].end = pci_irq_vector(pdev, 0);
> >  
> >  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> >  	if (!pdata)
> > @@ -217,7 +217,7 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
> >  	pdata->properties->idx		= 0;
> >  	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
> >  	pdata->properties->gpio_base	= INTEL_QUARK_MFD_GPIO_BASE;
> > -	pdata->properties->irq[0]	= pdev->irq;
> > +	pdata->properties->irq[0]	= pci_irq_vector(pdev, 0);
> >  
> >  	cell->platform_data = pdata;
> >  	cell->pdata_size = sizeof(*pdata);
> > @@ -245,22 +245,30 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
> >  	if (ret)
> >  		return ret;
> >  
> > +	pci_set_master(pdev);
> > +
> > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> 
> Is there any way these magic number can be defined or sizeof()'ed?

Grep for it in the kernel, it's rarely defined.

The semantic is min-max range and having two defines (*) here for these seems
to me as an utter overkill.

Of course, if you insist I may do it.

*) since value is the same, we might have one definition, but it will be even
   more confusion to have it as a min and max at the same time.

-- 
With Best Regards,
Andy Shevchenko


