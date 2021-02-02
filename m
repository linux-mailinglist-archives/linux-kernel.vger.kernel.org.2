Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC9C30C26E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhBBOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234807AbhBBOt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:49:28 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D79064D99;
        Tue,  2 Feb 2021 14:48:47 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l6wyy-00BWXD-Lo; Tue, 02 Feb 2021 14:48:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Feb 2021 14:48:44 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI MSI issue with reinserting a driver
In-Reply-To: <8a54fdd0-950b-f801-e83d-750aef73ab3c@huawei.com>
References: <cc224272-15db-968b-46a0-95951e11b23f@huawei.com>
 <87o8h3lj0n.wl-maz@kernel.org>
 <a80b9be0-c455-c852-ddac-3f514a15e896@huawei.com>
 <8a54fdd0-950b-f801-e83d-750aef73ab3c@huawei.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <4848792ce8c9ed7490e2205281a3cbda@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, tglx@linutronix.de, wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-02 12:38, John Garry wrote:
>>> Here's my suspicion: two of the interrupts are mapped in the 
>>> low-level
>>> domain (the ITS, I'd expect in your case), but they have never been
>>> mapped at the higher level.
>>> 
>>> On teardown, we only get rid of the 30 that were actually mapped, and
>>> leave the last two dangling in the ITS domain, and thus the ITS 
>>> device
>>> resources are never freed. On reload, we request another 32
>>> interrupts, which can't be satisfied for this device.
>>> 
>>> Assuming I got it right, the question is: why weren't these 
>>> interrupts
>>> mapped in the PCI domain the first place. And if I got it wrong, I'm
>>> even more curious!
>> 
>> Not sure. I also now notice an error for the SAS PCI driver on D06 
>> when nr_cpus < 16, which means number of MSI vectors allocated < 32, 
>> so looks the same problem. There we try to allocate 16 + max(nr cpus, 
>> 16) MSI.
>> 
>> Anyway, let me have a look today to see what is going wrong.
>> 
> Could this be the problem:
> 
> nr_cpus=11
> 
> In alloc path, we have:
> 	its_alloc_device_irq(nvecs=27 = 16+11)
> 	  bitmap_find_free_region(order = 5);
> In free path, we have:
> 	its_irq_domain_free(nvecs = 1) and free each 27 vecs
> 	  bitmap_release_region(order = 0)
> 
> So we allocate 32 bits, but only free 27. And 2nd alloc for 32 fails.
> 
> FWIW, this hack seems to fix it:
> 
> ---->8-----
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index ac5412b284e6..458ea0ebea2b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> 
> @@ -3533,34 +3534,39 @@ static int its_irq_domain_alloc(struct
> irq_domain *domain, unsigned int virq,
>  	struct its_device *its_dev = info->scratchpad[0].ptr;
>  	struct its_node *its = its_dev->its;
>  	struct irq_data *irqd;
> -	irq_hw_number_t hwirq;
> +	irq_hw_number_t hwirq[nr_irqs]; //vla :(
>  	int err;
>  	int i;
> 
> -	err = its_alloc_device_irq(its_dev, nr_irqs, &hwirq);
> +	for (i = 0; i < nr_irqs; i++) {
> +		err = its_alloc_device_irq(its_dev, 1, &hwirq[i]);
> +		if (err) //tidy
> +			return err;
> +	}
> +
> -	if (err)
> -		return err;
> 
>  	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
>  	if (err)
>  		return err;
> 
>  	for (i = 0; i < nr_irqs; i++) {
> -		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
> +		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq[i]);
>  		if (err)
>  			return err;
> 
>  		irq_domain_set_hwirq_and_chip(domain, virq + i,
> -					      hwirq + i, &its_irq_chip, its_dev);
> +					      hwirq[i], &its_irq_chip, its_dev);
>  		irqd = irq_get_irq_data(virq + i);
>  		irqd_set_single_target(irqd);
>  		irqd_set_affinity_on_activate(irqd);
>  		pr_debug("ID:%d pID:%d vID:%d\n",
> -			 (int)(hwirq + i - its_dev->event_map.lpi_base),
> -			 (int)(hwirq + i), virq + i);
> +			 (int)(hwirq[i] - its_dev->event_map.lpi_base),
> +			 (int)(hwirq[i]), virq + i);
>  	}
> ----8<-----
> 
> 
> But I'm not sure that we have any requirement for those map bits to be
> consecutive.

We can't really do that. All the events must be contiguous,
and there is also a lot of assumptions in the ITS driver that
LPI allocations is also contiguous.

But there is also the fact that for Multi-MSI, we *must*
allocate 32 vectors. Any driver could assume that if we have
allocated 17 vectors, then there is another 15 available.

My question still stand: how was this working with the previous
behaviour?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
