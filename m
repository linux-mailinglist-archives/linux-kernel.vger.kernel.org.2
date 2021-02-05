Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959C831127C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhBESrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:47:14 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6680 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhBESoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:44:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601da9d10002>; Fri, 05 Feb 2021 12:25:53 -0800
Received: from MacBook-Pro-10.local (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 20:25:52 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
 <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
 <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com>
 <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
 <YB1vIrgI9S/5CDxL@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <269689b7-3b6d-55dc-9044-fbf2984089ab@nvidia.com>
Date:   Fri, 5 Feb 2021 12:25:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YB1vIrgI9S/5CDxL@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612556753; bh=6fsyhZcd71U4H2BxWCOPPFCmqtBnPJFkdr9hQzt2OwU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=OO+F2OK+tpmFx4B/VUsgnC0WloZgjySN7FUoVutQthptowUQSevdw8lGwmgTA68aw
         kWrFVSqyiDu2SA8bza6156pP7QEFYuo3EYf1CCrf2dawuMGo+m2rRl2ofvA7MfJhq5
         7P5Ia7fpe93krO1EHPuqbkne0TZ5CpxVH4y/tyQIBlazynQpEPzWhPEoQv40Ff2f5Y
         q/4NRlUQoHv1E5pijY0WdHrSw349E8+BbXIccp19yXwmm4UVnIB8lV4i15QAb/EvVG
         lT+77f7URYq6SRqlot3r7MNMjnCkJW3TALXURELJPiDQoWH07/NKIhNb98q8gDF48X
         bUmsW9EOpPGsQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 8:15 AM, Minchan Kim wrote:
...
>> Yes, approximately. I was wondering if this would suffice at least as a baseline:
>>
>> cma_alloc_success   125
>> cma_alloc_failure   25
> 
> IMO, regardless of the my patch, it would be good to have such statistics
> in that CMA was born to replace carved out memory with dynamic allocation
> ideally for memory efficiency ideally so failure should regard critical
> so admin could notice it how the system is hurt.

Right. So CMA failures are useful for the admin to see, understood.

> 
> Anyway, it's not enough for me and orthgonal with my goal.
> 

OK. But...what *is* your goal, and why is this useless (that's what
orthogonal really means here) for your goal?

Also, would you be willing to try out something simple first,
such as providing indication that cma is active and it's overall success
rate, like this:

/proc/vmstat:

cma_alloc_success   125
cma_alloc_failure   25

...or is the only way to provide the more detailed items, complete with
per-CMA details, in a non-debugfs location?


>>
>> ...and then, to see if more is needed, some questions:
>>
>> a)  Do you know of an upper bound on how many cma areas there can be
>> (I think Matthew also asked that)?
> 
> There is no upper bound since it's configurable.
> 

OK, thanks,so that pretty much rules out putting per-cma details into
anything other than a directory or something like it.

>>
>> b) Is tracking the cma area really as valuable as other possibilities? We can put
>> "a few" to "several" items here, so really want to get your very favorite bits of
>> information in. If, for example, there can be *lots* of cma areas, then maybe tracking
> 
> At this moment, allocation/failure for each CMA area since they have
> particular own usecase, which makes me easy to keep which module will
> be affected. I think it is very useful per-CMA statistics as minimum
> code change so I want to enable it by default under CONFIG_CMA && CONFIG_SYSFS.
> 
>> by a range of allocation sizes is better...
> 
> I takes your suggestion something like this.
> 
> [alloc_range] could be order or range by interval
> 
> /sys/kernel/mm/cma/cma-A/[alloc_range]/success
> /sys/kernel/mm/cma/cma-A/[alloc_range]/fail
> ..
> ..
> /sys/kernel/mm/cma/cma-Z/[alloc_range]/success
> /sys/kernel/mm/cma/cma-Z/[alloc_range]/fail

Actually, I meant, "ranges instead of cma areas", like this:

/<path-to-cma-data/[alloc_range_1]/success
/<path-to-cma-data/[alloc_range_1]/fail
/<path-to-cma-data/[alloc_range_2]/success
/<path-to-cma-data/[alloc_range_2]/fail
...
/<path-to-cma-data/[alloc_range_max]/success
/<path-to-cma-data/[alloc_range_max]/fail

The idea is that knowing the allocation sizes that succeeded
and failed is maybe even more interesting and useful than
knowing the cma area that contains them.

> 
> I agree it would be also useful but I'd like to enable it under
> CONFIG_CMA_SYSFS_ALLOC_RANGE as separate patchset.
> 

I will stop harassing you very soon, just want to bottom out on
understanding the real goals first. :)

thanks,
-- 
John Hubbard
NVIDIA
