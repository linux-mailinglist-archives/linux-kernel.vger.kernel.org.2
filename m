Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1E30E0EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBCRZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231737AbhBCRYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:24:31 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B2064F6A;
        Wed,  3 Feb 2021 17:23:50 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l7Lsa-00BoUs-5g; Wed, 03 Feb 2021 17:23:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 03 Feb 2021 17:23:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI MSI issue with reinserting a driver
In-Reply-To: <28c56995-501a-880b-e6dd-ac76b8290c2c@huawei.com>
References: <cc224272-15db-968b-46a0-95951e11b23f@huawei.com>
 <87o8h3lj0n.wl-maz@kernel.org>
 <a80b9be0-c455-c852-ddac-3f514a15e896@huawei.com>
 <8a54fdd0-950b-f801-e83d-750aef73ab3c@huawei.com>
 <4848792ce8c9ed7490e2205281a3cbda@kernel.org>
 <28c56995-501a-880b-e6dd-ac76b8290c2c@huawei.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <3d3d0155e66429968cb4f6b4feeae4b3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, tglx@linutronix.de, wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-02 15:46, John Garry wrote:
> On 02/02/2021 14:48, Marc Zyngier wrote:
>>>> 
>>>> Not sure. I also now notice an error for the SAS PCI driver on D06 
>>>> when nr_cpus < 16, which means number of MSI vectors allocated < 32, 
>>>> so looks the same problem. There we try to allocate 16 + max(nr 
>>>> cpus, 16) MSI.
>>>> 
>>>> Anyway, let me have a look today to see what is going wrong.
>>>> 
>>> Could this be the problem:
>>> 
>>> nr_cpus=11
>>> 
>>> In alloc path, we have:
>>>     its_alloc_device_irq(nvecs=27 = 16+11)
>>>       bitmap_find_free_region(order = 5);
>>> In free path, we have:
>>>     its_irq_domain_free(nvecs = 1) and free each 27 vecs
>>>       bitmap_release_region(order = 0)
>>> 
>>> So we allocate 32 bits, but only free 27. And 2nd alloc for 32 fails.
> 
> [ ... ]
> 
>>> 
>>> 
>>> But I'm not sure that we have any requirement for those map bits to 
>>> be
>>> consecutive.
>> 
>> We can't really do that. All the events must be contiguous,
>> and there is also a lot of assumptions in the ITS driver that
>> LPI allocations is also contiguous.
>> 
>> But there is also the fact that for Multi-MSI, we *must*
>> allocate 32 vectors. Any driver could assume that if we have
>> allocated 17 vectors, then there is another 15 available.
>> 
>> My question still stand: how was this working with the previous
>> behaviour?
> 
> Because previously in this scenario we would allocate 32 bits and free
> 32 bits in the map; but now we allocate 32 bits, yet only free 27 - so
> leak 5 bits. And this comes from how irq_domain_free_irqs_hierarchy()
> now frees per-interrupt, instead of all irqs per domain.
> 
> Before:
>  In free path, we have:
>      its_irq_domain_free(nvecs = 27)
>        bitmap_release_region(count order = 5 == 32bits)
> 
> Current:
>  In free path, we have:
>      its_irq_domain_free(nvecs = 1) for free each 27 vecs
>        bitmap_release_region(count order = 0 == 1bit)

Right. I was focusing on the patch and blindly ignored the explanation
at the top of the email. Apologies for that.

I'm not overly keen on handling this in the ITS though, and I'd rather
we try and do it in the generic code. How about this (compile tested
only)?

Thanks,

         M.

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6aacd342cd14..cfccad83c2df 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1399,8 +1399,19 @@ static void irq_domain_free_irqs_hierarchy(struct 
irq_domain *domain,
  		return;

  	for (i = 0; i < nr_irqs; i++) {
-		if (irq_domain_get_irq_data(domain, irq_base + i))
-			domain->ops->free(domain, irq_base + i, 1);
+		int n ;
+
+		/* Find the largest possible span of IRQs to free in one go */
+		for (n = 0;
+		     ((i + n) < nr_irqs &&
+		      irq_domain_get_irq_data(domain, irq_base + i + n));
+		     n++);
+
+		if (!n)
+			continue;
+
+		domain->ops->free(domain, irq_base + i, n);
+		i += n;
  	}
  }


-- 
Jazz is not dead. It just smells funny...
