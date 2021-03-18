Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF87340E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhCRTfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:35:22 -0400
Received: from foss.arm.com ([217.140.110.172]:47456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232973AbhCRTfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:35:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498A1ED1;
        Thu, 18 Mar 2021 12:35:11 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E293F70D;
        Thu, 18 Mar 2021 12:35:03 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     opendmb@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
Date:   Thu, 18 Mar 2021 19:34:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-18 19:22, Florian Fainelli wrote:
> 
> 
> On 3/18/2021 12:18 PM, Florian Fainelli wrote:
>> It may be useful to disable the SWIOTLB completely for testing or when a
>> platform is known not to have any DRAM addressing limitations what so
>> ever.

Isn't that what "swiotlb=noforce" is for? If you're confident that we've 
really ironed out *all* the awkward corners that used to blow up if 
various internal bits were left uninitialised, then it would make sense 
to just tweak the implementation of what we already have.

I wouldn't necessarily disagree with adding "off" as an additional alias 
for "noforce", though, since it does come across as a bit wacky for 
general use.

>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Christoph, in addition to this change, how would you feel if we
> qualified the swiotlb_init() in arch/arm/mm/init.c with a:
> 
> 
> if (memblock_end_of_DRAM() >= SZ_4G)
> 	swiotlb_init(1)

Modulo "swiotlb=force", of course ;)

Robin.

> right now this is made unconditional whenever ARM_LPAE is enabled which
> is the case for the platforms I maintain (ARCH_BRCMSTB) however we do
> not really need a SWIOTLB so long as the largest DRAM physical address
> does not exceed 4GB AFAICT.
> 
> Thanks!
> 
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 1 +
>>   include/linux/swiotlb.h                         | 1 +
>>   kernel/dma/swiotlb.c                            | 9 +++++++++
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 04545725f187..b0223e48921e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5278,6 +5278,7 @@
>>   			force -- force using of bounce buffers even if they
>>   			         wouldn't be automatically used by the kernel
>>   			noforce -- Never use bounce buffers (for debugging)
>> +			off -- Completely disable SWIOTLB
>>   
>>   	switches=	[HW,M68k]
>>   
>> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
>> index 5857a937c637..23f86243defe 100644
>> --- a/include/linux/swiotlb.h
>> +++ b/include/linux/swiotlb.h
>> @@ -15,6 +15,7 @@ enum swiotlb_force {
>>   	SWIOTLB_NORMAL,		/* Default - depending on HW DMA mask etc. */
>>   	SWIOTLB_FORCE,		/* swiotlb=force */
>>   	SWIOTLB_NO_FORCE,	/* swiotlb=noforce */
>> +	SWIOTLB_OFF,		/* swiotlb=off */
>>   };
>>   
>>   /*
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index c10e855a03bc..d7a4a789c7d3 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -126,6 +126,8 @@ setup_io_tlb_npages(char *str)
>>   	} else if (!strcmp(str, "noforce")) {
>>   		swiotlb_force = SWIOTLB_NO_FORCE;
>>   		io_tlb_nslabs = 1;
>> +	} else if (!strcmp(str, "off")) {
>> +		swiotlb_force = SWIOTLB_OFF;
>>   	}
>>   
>>   	return 0;
>> @@ -229,6 +231,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>>   	unsigned long i, bytes;
>>   	size_t alloc_size;
>>   
>> +	if (swiotlb_force == SWIOTLB_OFF)
>> +		return 0;
>> +
>>   	bytes = nslabs << IO_TLB_SHIFT;
>>   
>>   	io_tlb_nslabs = nslabs;
>> @@ -284,6 +289,9 @@ swiotlb_init(int verbose)
>>   	unsigned char *vstart;
>>   	unsigned long bytes;
>>   
>> +	if (swiotlb_force == SWIOTLB_OFF)
>> +		goto out;
>> +
>>   	if (!io_tlb_nslabs) {
>>   		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
>>   		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
>> @@ -302,6 +310,7 @@ swiotlb_init(int verbose)
>>   		io_tlb_start = 0;
>>   	}
>>   	pr_warn("Cannot allocate buffer");
>> +out:
>>   	no_iotlb_memory = true;
>>   }
>>   
>>
> 
