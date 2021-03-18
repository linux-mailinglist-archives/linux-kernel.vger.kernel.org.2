Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365BD340EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhCRTyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:54:23 -0400
Received: from foss.arm.com ([217.140.110.172]:47794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhCRTxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:53:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8D4031B;
        Thu, 18 Mar 2021 12:53:46 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005C33F792;
        Thu, 18 Mar 2021 12:53:43 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, opendmb@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
 <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
 <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <16d1c66f-5451-2515-af73-a6b44d996e92@arm.com>
Date:   Thu, 18 Mar 2021 19:53:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-18 19:43, Florian Fainelli wrote:
> 
> 
> On 3/18/2021 12:34 PM, Robin Murphy wrote:
>> On 2021-03-18 19:22, Florian Fainelli wrote:
>>>
>>>
>>> On 3/18/2021 12:18 PM, Florian Fainelli wrote:
>>>> It may be useful to disable the SWIOTLB completely for testing or when a
>>>> platform is known not to have any DRAM addressing limitations what so
>>>> ever.
>>
>> Isn't that what "swiotlb=noforce" is for? If you're confident that we've
>> really ironed out *all* the awkward corners that used to blow up if
>> various internal bits were left uninitialised, then it would make sense
>> to just tweak the implementation of what we already have.
> 
> swiotlb=noforce does prevent dma_direct_map_page() from resorting to the
> swiotlb, however what I am also after is reclaiming these 64MB of
> default SWIOTLB bounce buffering memory because my systems run with
> large amounts of reserved memory into ZONE_MOVABLE and everything in
> ZONE_NORMAL is precious at that point.

It also forces io_tlb_nslabs to the minimum, so it should be claiming 
considerably less than 64MB. IIRC the original proposal *did* skip 
initialisation completely, but that turned up the aforementioned issues.

>> I wouldn't necessarily disagree with adding "off" as an additional alias
>> for "noforce", though, since it does come across as a bit wacky for
>> general use.
>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>
>>> Christoph, in addition to this change, how would you feel if we
>>> qualified the swiotlb_init() in arch/arm/mm/init.c with a:
>>>
>>>
>>> if (memblock_end_of_DRAM() >= SZ_4G)
>>>      swiotlb_init(1)
>>
>> Modulo "swiotlb=force", of course ;)
> 
> Indeed, we would need to handle that case as well. Does it sound
> reasonable to do that to you as well?

I wouldn't like it done to me personally, but for arm64, observe what 
mem_init() in arch/arm64/mm/init.c already does.

Robin.
