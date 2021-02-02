Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B073C30BA1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhBBIkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:40:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2473 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhBBIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:39:49 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVJ3Y0dDhz67k18;
        Tue,  2 Feb 2021 16:32:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 09:39:07 +0100
Received: from [10.47.3.41] (10.47.3.41) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 08:39:06 +0000
Subject: Re: PCI MSI issue with reinserting a driver
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cc224272-15db-968b-46a0-95951e11b23f@huawei.com>
 <87o8h3lj0n.wl-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a80b9be0-c455-c852-ddac-3f514a15e896@huawei.com>
Date:   Tue, 2 Feb 2021 08:37:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87o8h3lj0n.wl-maz@kernel.org>
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

On 01/02/2021 18:50, Marc Zyngier wrote:

Hi Marc,

>> Just a heads-up, by chance I noticed that I can't re-insert a specific
>> driver on v5.11-rc6:
>>
>> [   64.356023] hisi_dma 0000:7b:00.0: Adding to iommu group 31
>> [   64.368627] hisi_dma 0000:7b:00.0: enabling device (0000 -> 0002)
>> [   64.384156] hisi_dma 0000:7b:00.0: Failed to allocate MSI vectors!
>> [   64.397180] hisi_dma: probe of 0000:7b:00.0 failed with error -28
>>
>> That's with CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
>>
>> Bisect tells me that this is the first bad commit:
>> 4615fbc3788d genirq/irqdomain: Don't try to free an interrupt that has
>> no mapping
>>
>> The relevant driver code is
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/hisi_dma.c#n547
>>
>> That driver only allocates 30 MSI, so maybe there's a problem with not
>> allocating (and freeing) all 32 MSI.
> Are they Multi-MSI (and not MSI-X)?

multi-msi

> 
>> I'll have a bit more of a look tomorrow.
> Here's my suspicion: two of the interrupts are mapped in the low-level
> domain (the ITS, I'd expect in your case), but they have never been
> mapped at the higher level.
> 
> On teardown, we only get rid of the 30 that were actually mapped, and
> leave the last two dangling in the ITS domain, and thus the ITS device
> resources are never freed. On reload, we request another 32
> interrupts, which can't be satisfied for this device.
> 
> Assuming I got it right, the question is: why weren't these interrupts
> mapped in the PCI domain the first place. And if I got it wrong, I'm
> even more curious!

Not sure. I also now notice an error for the SAS PCI driver on D06 when 
nr_cpus < 16, which means number of MSI vectors allocated < 32, so looks 
the same problem. There we try to allocate 16 + max(nr cpus, 16) MSI.

Anyway, let me have a look today to see what is going wrong.

cheers,
John
