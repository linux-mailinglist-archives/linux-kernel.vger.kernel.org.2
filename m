Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307E930C468
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhBBPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:50:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2483 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbhBBPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:48:36 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVTdP4plgz67jmx;
        Tue,  2 Feb 2021 23:44:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 16:47:54 +0100
Received: from [10.47.3.41] (10.47.3.41) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 15:47:53 +0000
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <28c56995-501a-880b-e6dd-ac76b8290c2c@huawei.com>
Date:   Tue, 2 Feb 2021 15:46:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4848792ce8c9ed7490e2205281a3cbda@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.3.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2021 14:48, Marc Zyngier wrote:
>>>
>>> Not sure. I also now notice an error for the SAS PCI driver on D06 
>>> when nr_cpus < 16, which means number of MSI vectors allocated < 32, 
>>> so looks the same problem. There we try to allocate 16 + max(nr cpus, 
>>> 16) MSI.
>>>
>>> Anyway, let me have a look today to see what is going wrong.
>>>
>> Could this be the problem:
>>
>> nr_cpus=11
>>
>> In alloc path, we have:
>>     its_alloc_device_irq(nvecs=27 = 16+11)
>>       bitmap_find_free_region(order = 5);
>> In free path, we have:
>>     its_irq_domain_free(nvecs = 1) and free each 27 vecs
>>       bitmap_release_region(order = 0)
>>
>> So we allocate 32 bits, but only free 27. And 2nd alloc for 32 fails.

[ ... ]

>>
>>
>> But I'm not sure that we have any requirement for those map bits to be
>> consecutive.
> 
> We can't really do that. All the events must be contiguous,
> and there is also a lot of assumptions in the ITS driver that
> LPI allocations is also contiguous.
> 
> But there is also the fact that for Multi-MSI, we *must*
> allocate 32 vectors. Any driver could assume that if we have
> allocated 17 vectors, then there is another 15 available.
> 
> My question still stand: how was this working with the previous
> behaviour?

Because previously in this scenario we would allocate 32 bits and free 
32 bits in the map; but now we allocate 32 bits, yet only free 27 - so 
leak 5 bits. And this comes from how irq_domain_free_irqs_hierarchy() 
now frees per-interrupt, instead of all irqs per domain.

Before:
  In free path, we have:
      its_irq_domain_free(nvecs = 27)
        bitmap_release_region(count order = 5 == 32bits)

Current:
  In free path, we have:
      its_irq_domain_free(nvecs = 1) for free each 27 vecs
        bitmap_release_region(count order = 0 == 1bit)

Cheers,
John
