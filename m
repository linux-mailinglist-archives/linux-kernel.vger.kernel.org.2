Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E330BE66
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBBMlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:41:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2477 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhBBMk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:40:57 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVPRW1j8rz67jx4;
        Tue,  2 Feb 2021 20:35:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 2 Feb 2021 13:40:12 +0100
Received: from [10.47.3.41] (10.47.3.41) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 12:40:12 +0000
Subject: Re: PCI MSI issue with reinserting a driver
From:   John Garry <john.garry@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cc224272-15db-968b-46a0-95951e11b23f@huawei.com>
 <87o8h3lj0n.wl-maz@kernel.org>
 <a80b9be0-c455-c852-ddac-3f514a15e896@huawei.com>
Message-ID: <8a54fdd0-950b-f801-e83d-750aef73ab3c@huawei.com>
Date:   Tue, 2 Feb 2021 12:38:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a80b9be0-c455-c852-ddac-3f514a15e896@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Here's my suspicion: two of the interrupts are mapped in the low-level
>> domain (the ITS, I'd expect in your case), but they have never been
>> mapped at the higher level.
>>
>> On teardown, we only get rid of the 30 that were actually mapped, and
>> leave the last two dangling in the ITS domain, and thus the ITS device
>> resources are never freed. On reload, we request another 32
>> interrupts, which can't be satisfied for this device.
>>
>> Assuming I got it right, the question is: why weren't these interrupts
>> mapped in the PCI domain the first place. And if I got it wrong, I'm
>> even more curious!
> 
> Not sure. I also now notice an error for the SAS PCI driver on D06 when 
> nr_cpus < 16, which means number of MSI vectors allocated < 32, so looks 
> the same problem. There we try to allocate 16 + max(nr cpus, 16) MSI.
> 
> Anyway, let me have a look today to see what is going wrong.
> 
Could this be the problem:

nr_cpus=11

In alloc path, we have:
	its_alloc_device_irq(nvecs=27 = 16+11)
	  bitmap_find_free_region(order = 5);
In free path, we have:
	its_irq_domain_free(nvecs = 1) and free each 27 vecs
	  bitmap_release_region(order = 0)

So we allocate 32 bits, but only free 27. And 2nd alloc for 32 fails.

FWIW, this hack seems to fix it:

---->8-----

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index ac5412b284e6..458ea0ebea2b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c

@@ -3533,34 +3534,39 @@ static int its_irq_domain_alloc(struct 
irq_domain *domain, unsigned int virq,
  	struct its_device *its_dev = info->scratchpad[0].ptr;
  	struct its_node *its = its_dev->its;
  	struct irq_data *irqd;
-	irq_hw_number_t hwirq;
+	irq_hw_number_t hwirq[nr_irqs]; //vla :(
  	int err;
  	int i;

-	err = its_alloc_device_irq(its_dev, nr_irqs, &hwirq);
+	for (i = 0; i < nr_irqs; i++) {
+		err = its_alloc_device_irq(its_dev, 1, &hwirq[i]);
+		if (err) //tidy
+			return err;
+	}
+	
-	if (err)
-		return err;

  	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
  	if (err)
  		return err;

  	for (i = 0; i < nr_irqs; i++) {
-		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
+		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq[i]);
  		if (err)
  			return err;

  		irq_domain_set_hwirq_and_chip(domain, virq + i,
-					      hwirq + i, &its_irq_chip, its_dev);
+					      hwirq[i], &its_irq_chip, its_dev);
  		irqd = irq_get_irq_data(virq + i);
  		irqd_set_single_target(irqd);
  		irqd_set_affinity_on_activate(irqd);
  		pr_debug("ID:%d pID:%d vID:%d\n",
-			 (int)(hwirq + i - its_dev->event_map.lpi_base),
-			 (int)(hwirq + i), virq + i);
+			 (int)(hwirq[i] - its_dev->event_map.lpi_base),
+			 (int)(hwirq[i]), virq + i);
  	}
----8<-----


But I'm not sure that we have any requirement for those map bits to be 
consecutive.

Thanks,
John
