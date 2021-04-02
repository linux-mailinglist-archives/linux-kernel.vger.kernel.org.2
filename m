Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F9E352FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhDBTgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:36:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B4C0613E6;
        Fri,  2 Apr 2021 12:36:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dm8so6387733edb.2;
        Fri, 02 Apr 2021 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xi+ZyJuMSLaDa1dKwITGdmUDXOKtDig9K+Jaf/axxfk=;
        b=tcfXhE6EL4zxR1dZRvSAuLtSWcX+tOCYimOzB6/Eb/iGOuK6e6O1dPHcuITeQ2FHzM
         H/JKxbFyTRwTb2QW4Ul6Bu+86bTNZQkomiw4+NFb3XwJD+96jjY4ulrr9JZ+FI6/kpBk
         LvfyRR4sE5dkevhMBE875Kr0YOTwIuG+RC9B5P+e0bbUc2ZZ6AcQCXTBcqVOwv2/fvKU
         QuA4pxAq2mNu3u+5mj/tZ71S/y6bm6Vq4LbCUfiJ0P8fSpyNiKYTfBg+H3EtJ+rmIO6x
         SiwIJyvXRRHhfiQeU+ehDeZDqgx8B71NSUyq+fbT7FgsGOqvmoCfO9tF2pdE8f6ggcZu
         qMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xi+ZyJuMSLaDa1dKwITGdmUDXOKtDig9K+Jaf/axxfk=;
        b=o5etxXQU2036WNPaj15FkP8Vc3i860LEVqojDsa3ZEDhwr/HqNVQz/E4219hkLiUmJ
         8rEFkfH/97xeHQGN7sJBuM6QoRPcah56Kbcx+L5cDpZPwo4MwheVAgYxiWRZmbMuESJw
         pGwKFGKKvw3xMvNwQXep6kn5lUJ2YA07YM1xjpoUte0c8bY3VLhHK7b/Wk2lEN1Zx9c7
         GW6t9jHMcKNCdvFJsxqpVgDyxUiSaSqv5POOLzIqlyJ2qHcx5kCFY9FTK5rSWSv3zQfa
         mzyt4BCMbiizViy+LYyFWhcyO9GXdUsOWb7g/OYB4P7BDzPloZrTq1MF5Gk6R+INMvwC
         /lFw==
X-Gm-Message-State: AOAM532/bjnZhxth+UOVdH1p9mgQeiAFLn7QJJ7E1R/7ekl9nJWu3lUb
        6ay9h0dEF0BX0fPbp3EQH9k=
X-Google-Smtp-Source: ABdhPJyjyvUkydVsh0G7xHKclDnoK9r6BF7X6k5qcAUwqSFMJdjGHxlj54UcTdFEVAHaWmzslcAtTw==
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr16979097edv.300.1617392170896;
        Fri, 02 Apr 2021 12:36:10 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id cw14sm6018205edb.8.2021.04.02.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 12:36:10 -0700 (PDT)
Date:   Fri, 2 Apr 2021 22:36:08 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] soc: actions: Add Actions Semi Owl socinfo driver
Message-ID: <20210402193608.GB2052516@BV030612LT>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <75ec4eff3e6113f4e72daa1b428c355b28005297.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210402181624.GC31906@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402181624.GC31906@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 11:46:24PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 30, 2021 at 04:48:18PM +0300, Cristian Ciocaltea wrote:
> > The driver provides information about the Action Semi Owl family of
> > SoCs (S500, S700 and S900) to user space via sysfs: machine, family,
> > soc_id, serial_number.
> > 
> > Note the serial number is currently provided only for the S500 SoC
> > variant.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  drivers/soc/actions/Kconfig                   |   8 +
> >  drivers/soc/actions/Makefile                  |   1 +
> >  drivers/soc/actions/owl-socinfo.c             | 152 ++++++++++++++++++
> >  include/linux/soc/actions/owl-serial-number.h |  20 +++
> >  4 files changed, 181 insertions(+)
> >  create mode 100644 drivers/soc/actions/owl-socinfo.c
> >  create mode 100644 include/linux/soc/actions/owl-serial-number.h
> > 
> > diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
> > index 1aca2058a40c..15faade9282d 100644
> > --- a/drivers/soc/actions/Kconfig
> > +++ b/drivers/soc/actions/Kconfig
> > @@ -14,4 +14,12 @@ config OWL_PM_DOMAINS
> >  	  power-gating on Actions Semiconductor S500, S700 and S900 SoCs.
> >  	  If unsure, say 'n'.
> >  
> > +config OWL_SOCINFO
> > +	bool "Actions Semi Owl SoC info driver"
> > +	default ARCH_ACTIONS
> > +	select SOC_BUS
> > +	help
> > +	  Say 'y' here to support the Action Semiconductor Owl socinfo
> 
> Actions Semi
> 
> > +	  driver, providing information about the SoC to user space.
> > +
> >  endif
> > diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
> > index 4db9e7b050e5..4b2591d3089f 100644
> > --- a/drivers/soc/actions/Makefile
> > +++ b/drivers/soc/actions/Makefile
> > @@ -2,3 +2,4 @@
> >  
> >  obj-$(CONFIG_OWL_PM_DOMAINS_HELPER) += owl-sps-helper.o
> >  obj-$(CONFIG_OWL_PM_DOMAINS) += owl-sps.o
> > +obj-$(CONFIG_OWL_SOCINFO) += owl-socinfo.o
> > diff --git a/drivers/soc/actions/owl-socinfo.c b/drivers/soc/actions/owl-socinfo.c
> > new file mode 100644
> > index 000000000000..f28eafac3792
> > --- /dev/null
> > +++ b/drivers/soc/actions/owl-socinfo.c
> > @@ -0,0 +1,152 @@
> 
> [...]
> 
> > + * Access SoC's serial number stored by the bootloader in DDR memory.
> > + */
> > +static int owl_socinfo_read_serial_rmem(struct device *dev)
> > +{
> > +	struct reserved_mem *rmem;
> > +	struct device_node *np;
> > +	int ret = 0;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "actions,owl-soc-serial");
> > +	if (!np)
> > +		return -ENXIO;
> > +
> > +	rmem = of_reserved_mem_lookup(np);
> 
> If you do this correctly, you could use "pdev->dev.of_node" here instead of
> using "of_find_compatible_node()" for getting np.

Right, as previously explained, my intention was to avoid binding the
driver on the serial number node in order to keep it generic enough.

> > +	if (!rmem) {
> > +		dev_err(dev, "failed to acquire reserved memory region\n");
> > +		ret = -EINVAL;
> > +		goto out_put;
> > +	}
> > +
> 
> [...]
> 
> > +static const struct of_device_id owl_socinfo_of_match[] = {
> > +	{ .compatible = "actions,s500-soc", .data = &s500_soc_info, },
> > +	{ .compatible = "actions,s700-soc", .data = &s700_soc_info, },
> > +	{ .compatible = "actions,s900-soc", .data = &s900_soc_info, },
> 
> Please don't add S700/S900 for now.

I assumed we can use the driver for S700/S900, even though the serial
number is not provided for them.

> > +	{ }
> > +};
> > +
> > +static struct platform_driver owl_socinfo_platform_driver = {
> > +	.probe = owl_socinfo_probe,
> > +	.driver = {
> > +		.name = "owl-socinfo",
> > +		.of_match_table = owl_socinfo_of_match,
> > +	},
> > +};
> > +
> > +static int __init owl_socinfo_init(void)
> > +{
> > +	return platform_driver_register(&owl_socinfo_platform_driver);
> > +}
> > +subsys_initcall(owl_socinfo_init);
> > diff --git a/include/linux/soc/actions/owl-serial-number.h b/include/linux/soc/actions/owl-serial-number.h
> > new file mode 100644
> > index 000000000000..f8595417668f
> > --- /dev/null
> > +++ b/include/linux/soc/actions/owl-serial-number.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (c) 2021 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > + */
> > +
> > +#ifndef __SOC_ACTIONS_OWL_SERIAL_NUMBER_H__
> > +#define __SOC_ACTIONS_OWL_SERIAL_NUMBER_H__
> > +
> > +#if IS_ENABLED(CONFIG_OWL_SOCINFO)
> > +u32 owl_get_soc_serial_low(void);
> > +u32 owl_get_soc_serial_high(void);
> 
> Where are these APIs used?

This will be used by the Ethernet MAC driver to generate a stable
address. Initially I used the global 'system_serial_{low,high}'
variables to pass this information outside the driver, but that is
not portable, i.e. only supported on ARM32, not ARM64.

Thanks for the review,
Cristi

> Thanks,
> Mani
> 
> > +#else
> > +static inline u32 owl_get_soc_serial_low(void)
> > +{ return 0; }
> > +
> > +static inline u32 owl_get_soc_serial_high(void)
> > +{ return 0; }
> > +#endif /* CONFIG_OWL_SOCINFO */
> > +
> > +#endif /* __SOC_ACTIONS_OWL_SERIAL_NUMBER_H__ */
> > -- 
> > 2.31.1
> > 
