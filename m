Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932FE311B2C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhBFExs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:53:48 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17834 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhBFD2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:28:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601dbf2f0002>; Fri, 05 Feb 2021 13:57:03 -0800
Received: from MacBook-Pro-10.local (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 21:57:03 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
 <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
 <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com>
 <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
 <YB1vIrgI9S/5CDxL@google.com>
 <269689b7-3b6d-55dc-9044-fbf2984089ab@nvidia.com>
 <YB24YXMJOjwokDb5@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e8f3a4f1-503a-e571-e054-4fc05a4c5ca3@nvidia.com>
Date:   Fri, 5 Feb 2021 13:57:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YB24YXMJOjwokDb5@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612562223; bh=oKolGBS1u2dclWOmYgPrpVeGGcq5+9aFix3dZDw1bGk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=WiHb1KkCmlGZI7ENz8fVz3w9/niPxxR7RAm7CISZUYzx+13FYRIma9Q7Y1Sy1603w
         E6cN3GSYcKpC5bl9SdyaA1ggtx7IMLFpOfMV0XAFqnniIPkdw+sVCHB8t3qwVyHss3
         loWXxBpc9UhAtNBAXQwzs/QTbIWzUgI7u3YcCmZ1BIEZ1NfpuMNqlj0Od+5rxWwDLW
         oU1qCaF9GSX2e7GaDsaEQgCMlkQJGKboMYNQ94WQ1+g56HTZkkQXjjbzbCOLXoEwYM
         mpItxBOXVI0WExrvHhvAS7tCsPGSmxTkr6LBln1gb2WFeNz89WlsklZU3DilAbErDw
         UF1vzzl8XP/Bw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 1:28 PM, Minchan Kim wrote:
> On Fri, Feb 05, 2021 at 12:25:52PM -0800, John Hubbard wrote:
>> On 2/5/21 8:15 AM, Minchan Kim wrote:
>> ...
>> OK. But...what *is* your goal, and why is this useless (that's what
>> orthogonal really means here) for your goal?
> 
> As I mentioned, the goal is to monitor the failure from each of CMA
> since they have each own purpose.
> 
> Let's have an example.
> 
> System has 5 CMA area and each CMA is associated with each
> user scenario. They have exclusive CMA area to avoid
> fragmentation problem.
> 
> CMA-1 depends on bluetooh
> CMA-2 depends on WIFI
> CMA-3 depends on sensor-A
> CMA-4 depends on sensor-B
> CMA-5 depends on sensor-C
> 

aha, finally. I had no idea that sort of use case was happening.

This would be good to put in the patch commit description.

> With this, we could catch which module was affected but with global failure,
> I couldn't find who was affected.
> 
>>
>> Also, would you be willing to try out something simple first,
>> such as providing indication that cma is active and it's overall success
>> rate, like this:
>>
>> /proc/vmstat:
>>
>> cma_alloc_success   125
>> cma_alloc_failure   25
>>
>> ...or is the only way to provide the more detailed items, complete with
>> per-CMA details, in a non-debugfs location?
>>
>>
>>>>
>>>> ...and then, to see if more is needed, some questions:
>>>>
>>>> a)  Do you know of an upper bound on how many cma areas there can be
>>>> (I think Matthew also asked that)?
>>>
>>> There is no upper bound since it's configurable.
>>>
>>
>> OK, thanks,so that pretty much rules out putting per-cma details into
>> anything other than a directory or something like it.
>>
>>>>
>>>> b) Is tracking the cma area really as valuable as other possibilities? We can put
>>>> "a few" to "several" items here, so really want to get your very favorite bits of
>>>> information in. If, for example, there can be *lots* of cma areas, then maybe tracking
>>>
>>> At this moment, allocation/failure for each CMA area since they have
>>> particular own usecase, which makes me easy to keep which module will
>>> be affected. I think it is very useful per-CMA statistics as minimum
>>> code change so I want to enable it by default under CONFIG_CMA && CONFIG_SYSFS.
>>>
>>>> by a range of allocation sizes is better...
>>>
>>> I takes your suggestion something like this.
>>>
>>> [alloc_range] could be order or range by interval
>>>
>>> /sys/kernel/mm/cma/cma-A/[alloc_range]/success
>>> /sys/kernel/mm/cma/cma-A/[alloc_range]/fail
>>> ..
>>> ..
>>> /sys/kernel/mm/cma/cma-Z/[alloc_range]/success
>>> /sys/kernel/mm/cma/cma-Z/[alloc_range]/fail
>>
>> Actually, I meant, "ranges instead of cma areas", like this:
>>
>> /<path-to-cma-data/[alloc_range_1]/success
>> /<path-to-cma-data/[alloc_range_1]/fail
>> /<path-to-cma-data/[alloc_range_2]/success
>> /<path-to-cma-data/[alloc_range_2]/fail
>> ...
>> /<path-to-cma-data/[alloc_range_max]/success
>> /<path-to-cma-data/[alloc_range_max]/fail
>>
>> The idea is that knowing the allocation sizes that succeeded
>> and failed is maybe even more interesting and useful than
>> knowing the cma area that contains them.
> 
> Understand your point but it would make hard to find who was
> affected by the failure. That's why I suggested to have your
> suggestion under additional config since per-cma metric with
> simple sucess/failure are enough.
> 
>>
>>>
>>> I agree it would be also useful but I'd like to enable it under
>>> CONFIG_CMA_SYSFS_ALLOC_RANGE as separate patchset.
>>>
>>
>> I will stop harassing you very soon, just want to bottom out on
>> understanding the real goals first. :)
>>
> 
> I hope my example makes the goal more clear for you.
> 

Yes it does. Based on the (rather surprising) use of cma-area-per-device,
it seems clear that you will need this, so I'll drop my objections to
putting it in sysfs.

I still think the "number of allocation failures" needs refining, probably
via a range-based thing, as we've discussed. But the number of pages
failed per cma looks OK now.



thanks,
-- 
John Hubbard
NVIDIA
