Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C7A340627
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCRMyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:54:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:14571 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhCRMxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:53:45 -0400
IronPort-SDR: ZKZ4HQWw6aI6VuoweXJBLis+xsUypN3yObxhF4Q4zbhOwREklVfuGK5hcjq6Z1d14yS4WrcuzO
 3nJSitqrPA0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="176798384"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="176798384"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 05:53:44 -0700
IronPort-SDR: REme8/ZrUHCGiLvCO6NgICXEijnEmBLm+3mrXPLMq7pRrUYYHzPW72PLKZzRaA9SGUQ25LmP3I
 1nDZcQCDJcZA==
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="450470828"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 05:53:43 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lMs9k-00DZQO-TJ; Thu, 18 Mar 2021 14:53:40 +0200
Date:   Thu, 18 Mar 2021 14:53:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 1/5] mfd: intel_quark_i2c_gpio: revert "Constify
 static struct resources"
Message-ID: <YFNNVHZeKIMHco+a@smile.fi.intel.com>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
 <YD6nF1oJVMeCzn6R@rikard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD6nF1oJVMeCzn6R@rikard>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:59:03PM +0100, Rikard Falkeborn wrote:
> On Tue, Mar 02, 2021 at 03:56:16PM +0200, Andy Shevchenko wrote:
> > The structures are used as place holders, so they are modified at run-time.
> > Obviously they may not be constants.
> > 
> >   BUG: unable to handle page fault for address: d0643220
> >   ...
> >   CPU: 0 PID: 110 Comm: modprobe Not tainted 5.11.0+ #1
> >   Hardware name: Intel Corp. QUARK/GalileoGen2, BIOS 0x01000200 01/01/2014
> >   EIP: intel_quark_mfd_probe+0x93/0x1c0 [intel_quark_i2c_gpio]
> > 
> > This partially reverts the commit c4a164f41554d2899bed94bdcc499263f41787b4.
> > 
> > While at it, add a comment to avoid similar changes in the future.
> > 
> > Fixes: c4a164f41554 ("mfd: Constify static struct resources")
> > Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/intel_quark_i2c_gpio.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> > index 55a9e017edee..124c0ee84169 100644
> > --- a/drivers/mfd/intel_quark_i2c_gpio.c
> > +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> > @@ -72,7 +72,8 @@ static const struct dmi_system_id dmi_platform_info[] = {
> >  	{}
> >  };
> >  
> > -static const struct resource intel_quark_i2c_res[] = {
> > +/* This is used as a place holder and will be modified at run-time */
> > +static struct resource intel_quark_i2c_res[] = {
> >  	[INTEL_QUARK_IORES_MEM] = {
> >  		.flags = IORESOURCE_MEM,
> >  	},
> > @@ -85,7 +86,8 @@ static struct mfd_cell_acpi_match intel_quark_acpi_match_i2c = {
> >  	.adr = MFD_ACPI_MATCH_I2C,
> >  };
> >  
> > -static const struct resource intel_quark_gpio_res[] = {
> > +/* This is used as a place holder and will be modified at run-time */
> > +static struct resource intel_quark_gpio_res[] = {
> >  	[INTEL_QUARK_IORES_MEM] = {
> >  		.flags = IORESOURCE_MEM,
> >  	},
> > -- 
> > 2.30.1
> > 
> 
> Sorry about that :(
> 
> Reviewed-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Thanks for review!

Lee, this series has a critical bug fix, should I do something or you is going
to apply this soon?

-- 
With Best Regards,
Andy Shevchenko


