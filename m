Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5792430F126
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhBDKre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:47:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2494 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhBDKr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:47:28 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DWZrz0RChz67kVn;
        Thu,  4 Feb 2021 18:43:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 11:46:46 +0100
Received: from [10.210.168.183] (10.210.168.183) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 10:46:41 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: PCI MSI issue with reinserting a driver
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
References: <cc224272-15db-968b-46a0-95951e11b23f@huawei.com>
 <87o8h3lj0n.wl-maz@kernel.org>
 <a80b9be0-c455-c852-ddac-3f514a15e896@huawei.com>
 <8a54fdd0-950b-f801-e83d-750aef73ab3c@huawei.com>
 <4848792ce8c9ed7490e2205281a3cbda@kernel.org>
 <28c56995-501a-880b-e6dd-ac76b8290c2c@huawei.com>
 <3d3d0155e66429968cb4f6b4feeae4b3@kernel.org>
Message-ID: <fd88ce05-8aee-5b1f-5ab6-be88fa53d3aa@huawei.com>
Date:   Thu, 4 Feb 2021 10:45:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3d3d0155e66429968cb4f6b4feeae4b3@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.168.183]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 17:23, Marc Zyngier wrote:
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

Yeah, it was a distraction.

> 
> I'm not overly keen on handling this in the ITS though, and I'd rather
> we try and do it in the generic code. How about this (compile tested
> only)?
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

That fixed my problem.

For my benefit, if MSIs must be allocated in power of 2, could we check 
a flag for the dealloc method? Like, if MSI domain, then do as before 
4615fbc3788d. But I'm not sure on the specific scenario which that 
commit fixed. Or even whether you want specifics like that in core code.

Thanks,
John
