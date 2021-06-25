Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F163B4249
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhFYLQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhFYLQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:16:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6544661469;
        Fri, 25 Jun 2021 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624619641;
        bh=CeF7W3ZxfcmQOVYbFaxDuNkkKFqDV/crzaldiTiFwNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V2nuX61lH+7IUK4AWeskGiJMpx1dXiqViwnSs+t9XwMiBuX3dx8PdLlqMOtFGTlkN
         3sp/zadb/tEBJ45lsuycgZq9rVZXJfP0voWwQMLFwYBrreG5znr22SG3uKOdawJXj2
         3O6dxTlrUOzOpucTr3nEhu6yYekmNF3tpOB9v7uETt+A+HM9Op93rAx1+zwBTE/k/I
         lC0mphnxlZMTEZGPBTzxR1AkTBjDWtPRoQiVSziBciw+ta/DwIJMWJFVmKZxTNqmVS
         Mn0NeR5p8UtKmClyeY0GXr+FoQ0JAg2RDSZdkZHa3UaBQ5j/utRSznADCPoYtnxUas
         LbjRHpNjpx7qw==
Date:   Fri, 25 Jun 2021 13:13:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH RESEND v6 6/8] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <20210625131356.55ffd067@coco.lan>
In-Reply-To: <YNSRwIMr8+m9Sxk3@dell>
References: <cover.1624525118.git.mchehab+huawei@kernel.org>
        <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624525118.git.mchehab+huawei@kernel.org>
        <YNRrISOGujxcJAGR@dell>
        <20210624143605.153e1e34@coco.lan>
        <YNSRwIMr8+m9Sxk3@dell>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 24 Jun 2021 15:08:00 +0100
Lee Jones <lee.jones@linaro.org> escreveu:

> > > > +/*
> > > > + * The IRQs are mapped as:
> > > > + *
> > > > + *	======================  =============   ============	=====
> > > > + *	IRQ			MASK REGISTER	IRQ REGISTER	BIT
> > > > + *	======================  =============   ============	=====
> > > > + *	OTMP			0x0202		0x212		bit 0
> > > > + *	VBUS_CONNECT		0x0202		0x212		bit 1
> > > > + *	VBUS_DISCONNECT		0x0202		0x212		bit 2
> > > > + *	ALARMON_R		0x0202		0x212		bit 3
> > > > + *	HOLD_6S			0x0202		0x212		bit 4
> > > > + *	HOLD_1S			0x0202		0x212		bit 5
> > > > + *	POWERKEY_UP		0x0202		0x212		bit 6
> > > > + *	POWERKEY_DOWN		0x0202		0x212		bit 7
> > > > + *
> > > > + *	OCP_SCP_R		0x0203		0x213		bit 0
> > > > + *	COUL_R			0x0203		0x213		bit 1
> > > > + *	SIM0_HPD_R		0x0203		0x213		bit 2
> > > > + *	SIM0_HPD_F		0x0203		0x213		bit 3
> > > > + *	SIM1_HPD_R		0x0203		0x213		bit 4
> > > > + *	SIM1_HPD_F		0x0203		0x213		bit 5
> > > > + *	======================  =============   ============	=====
> > > > + *
> > > > + * Each mask register contains 8 bits. The ancillary macros below
> > > > + * convert a number from 0 to 14 into a register address and a bit mask
> > > > + */
> > > > +#define HISI_IRQ_MASK_REG(irq_data)	(SOC_PMIC_IRQ_MASK_0_ADDR + \
> > > > +					 (irqd_to_hwirq(irq_data) / BITS_PER_BYTE))
> > > > +#define HISI_IRQ_MASK_BIT(irq_data)	BIT(irqd_to_hwirq(irq_data) & (BITS_PER_BYTE - 1))
> > > > +#define HISI_8BITS_MASK			GENMASK(BITS_PER_BYTE - 1, 0)    
> > > 
> > > Are these lines up in real code?  Looks like they're not in the diff.  
> > 
> > Weird. The changes to use those are at patch 3/8. All the above
> > macros are used at the patch.  
> 
> Sorry, that made no sense - it's been a long few days!
> 
> I meant to say "do these (the tabs) line up?"

Yes, they line up (and aligned with the parenthesis, in the case of
HISI_IRQ_MASK_REG).

> > > > +static const struct mfd_cell hi6421v600_devs[] = {
> > > > +	{ .name = "hi6421v600-regulator", },
> > > > +};    
> > > 
> > > Where are the other devices?  
> > 
> > While this is a MFD device, as it has regulators, ADC and other
> > stuff, right now, only the regulator and the IRQs are implemented. 
> > 
> > The IRQs are at the core of this driver, while the regulator 
> > is at the separate regulator driver.  
> 
> The rule usually goes:
> 
>  Drivers don't qualify as MFDs until you register >1 device.

Do you mean that, in order for this to be accepted, should
I move the irq code to a separate driver?

> > > > +	for (i = 0; i < PMIC_IRQ_LIST_MAX; i++) {
> > > > +		virq = irq_create_mapping(ddata->domain, i);
> > > > +		if (!virq) {
> > > > +			dev_err(dev, "Failed to map H/W IRQ\n");
> > > > +			return -ENOSPC;    
> > > 
> > > -ENOSPC doesn't seem right here.
> > > 
> > > Can't find any other uses of it for irq_create_mapping() either.  
> > 
> > There are two drivers returning -ENOSPC:
> > 
> > 	arch/powerpc/platforms/pseries/msi.c
> > 	arch/powerpc/sysdev/mpic_u3msi.c  
> 
> I only looked in drivers/
> 
> > But others return -EIO, -EINVAL, -ENOMEM, -ENODEV, -ENXIO.
> > 
> > I think that -ENODEV would fit better here.  
> 
> I think -ENXIO is the most common, followed by -EINVAL.
> 
> This doesn't have anything to do with devices per say.

Ok. I'll change it to -ENXIO.

> > > > +static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
> > > > +{
> > > > +	struct hi6421_spmi_pmic *ddata = dev_get_drvdata(&pdev->dev);
> > > > +
> > > > +	free_irq(ddata->irq, ddata);    
> > > 
> > > No devm_* version?  
> > 
> > Are there a devm_* variant for gpio_to_irq()?  
> 
> Please refer to Dan's response.

Ok.

Thanks,
Mauro
