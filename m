Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE12355051
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhDFJtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:49:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2763 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbhDFJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:49:06 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF2fJ52jgz685hn;
        Tue,  6 Apr 2021 17:43:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 11:48:57 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:48:55 +0100
Subject: Re: PCI MSI issue with reinserting a driver
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>
References: <cc224272-15db-968b-46a0-95951e11b23f@huawei.com>
 <87o8h3lj0n.wl-maz@kernel.org>
 <a80b9be0-c455-c852-ddac-3f514a15e896@huawei.com>
 <8a54fdd0-950b-f801-e83d-750aef73ab3c@huawei.com>
 <4848792ce8c9ed7490e2205281a3cbda@kernel.org>
 <28c56995-501a-880b-e6dd-ac76b8290c2c@huawei.com>
 <3d3d0155e66429968cb4f6b4feeae4b3@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <87547f6c-2f50-7a91-c629-bbfe7c22a49b@huawei.com>
Date:   Tue, 6 Apr 2021 10:46:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3d3d0155e66429968cb4f6b4feeae4b3@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.166.136]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 17:23, Marc Zyngier wrote:
> On 2021-02-02 15:46, John Garry wrote:
>> On 02/02/2021 14:48, Marc Zyngier wrote:
>>>>>
>>>>> Not sure. I also now notice an error for the SAS PCI driver on D06 
>>>>> when nr_cpus < 16, which means number of MSI vectors allocated < 
>>>>> 32, so looks the same problem. There we try to allocate 16 + max(nr 
>>>>> cpus, 16) MSI.
>>>>>
>>>>> Anyway, let me have a look today to see what is going wrong.
>>>>>
>>>> Could this be the problem:
>>>>
>>>> nr_cpus=11
>>>>
>>>> In alloc path, we have:
>>>>     its_alloc_device_irq(nvecs=27 = 16+11)
>>>>       bitmap_find_free_region(order = 5);
>>>> In free path, we have:
>>>>     its_irq_domain_free(nvecs = 1) and free each 27 vecs
>>>>       bitmap_release_region(order = 0)
>>>>
>>>> So we allocate 32 bits, but only free 27. And 2nd alloc for 32 fails.
>>
>> [ ... ]
>>
>>>>

Hi Marc,

Just a friendly reminder on this issue. Let me know if anything required 
some our side.

Cheers,
John

>>>>
>>>> But I'm not sure that we have any requirement for those map bits to be
>>>> consecutive.
>>>
>>> We can't really do that. All the events must be contiguous,
>>> and there is also a lot of assumptions in the ITS driver that
>>> LPI allocations is also contiguous.
>>>
>>> But there is also the fact that for Multi-MSI, we *must*
>>> allocate 32 vectors. Any driver could assume that if we have
>>> allocated 17 vectors, then there is another 15 available.
>>>
>>> My question still stand: how was this working with the previous
>>> behaviour?
>>
>> Because previously in this scenario we would allocate 32 bits and free
>> 32 bits in the map; but now we allocate 32 bits, yet only free 27 - so
>> leak 5 bits. And this comes from how irq_domain_free_irqs_hierarchy()
>> now frees per-interrupt, instead of all irqs per domain.
>>
>> Before:
>>  In free path, we have:
>>      its_irq_domain_free(nvecs = 27)
>>        bitmap_release_region(count order = 5 == 32bits)
>>
>> Current:
>>  In free path, we have:
>>      its_irq_domain_free(nvecs = 1) for free each 27 vecs
>>        bitmap_release_region(count order = 0 == 1bit)
> 
> Right. I was focusing on the patch and blindly ignored the explanation
> at the top of the email. Apologies for that.
> 
> I'm not overly keen on handling this in the ITS though, and I'd rather
> we try and do it in the generic code. How about this (compile tested
> only)?
> 
> Thanks,
> 
>          M.
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 6aacd342cd14..cfccad83c2df 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1399,8 +1399,19 @@ static void irq_domain_free_irqs_hierarchy(struct 
> irq_domain *domain,
>           return;
> 
>       for (i = 0; i < nr_irqs; i++) {
> -        if (irq_domain_get_irq_data(domain, irq_base + i))
> -            domain->ops->free(domain, irq_base + i, 1);
> +        int n ;
> +
> +        /* Find the largest possible span of IRQs to free in one go */
> +        for (n = 0;
> +             ((i + n) < nr_irqs &&
> +              irq_domain_get_irq_data(domain, irq_base + i + n));
> +             n++);
> +
> +        if (!n)
> +            continue;
> +
> +        domain->ops->free(domain, irq_base + i, n);
> +        i += n;
>       }
>   }
> 
> 

