Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5575741E6F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 06:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351897AbhJAE5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 00:57:32 -0400
Received: from foss.arm.com ([217.140.110.172]:34824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241515AbhJAE5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 00:57:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C655106F;
        Thu, 30 Sep 2021 21:55:47 -0700 (PDT)
Received: from [10.163.74.5] (unknown [10.163.74.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ABD93F718;
        Thu, 30 Sep 2021 21:55:43 -0700 (PDT)
Subject: Re: [PATCH v2 16/17] coresight: trbe: Work around write to out of
 range
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-17-suzuki.poulose@arm.com>
 <6ecb0391-1525-8d65-93ba-b66424dadfd3@arm.com>
 <11de6dd1-e7eb-044c-a871-bfcca3e60884@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1436c9c3-ea39-363c-13c9-e2564b5eb1ea@arm.com>
Date:   Fri, 1 Oct 2021 10:26:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <11de6dd1-e7eb-044c-a871-bfcca3e60884@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/21 4:02 PM, Suzuki K Poulose wrote:
> On 23/09/2021 04:15, Anshuman Khandual wrote:
>>
>>
>> On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
>>> TRBE implementations affected by Arm erratum (2253138 or 2224489), could
>>> write to the next address after the TRBLIMITR.LIMIT, instead of wrapping
>>> to the TRBBASER. This implies that the TRBE could potentially corrupt :
>>>
>>>    - A page used by the rest of the kernel/user (if the LIMIT = end of
>>>      perf ring buffer)
>>>    - A page within the ring buffer, but outside the driver's range.
>>>      [head, head + size]. This may contain some trace data, may be
>>>      consumed by the userspace.
>>>
>>> We workaround this erratum by :
>>>    - Making sure that there is at least an extra PAGE space left in the
>>>      TRBE's range than we normally assign. This will be additional to other
>>>      restrictions (e.g, the TRBE alignment for working around
>>>      TRBE_WORKAROUND_OVERWRITE_IN_FILL_MODE, where there is a minimum of PAGE_SIZE.
>>>      Thus we would have 2 * PAGE_SIZE)
>>>
>>>    - Adjust the LIMIT to leave the last PAGE_SIZE out of the TRBE's allowed
>>>      range (i.e, TRBEBASER...TRBLIMITR.LIMIT), by :
>>>
>>>          TRBLIMITR.LIMIT -= PAGE_SIZE
>>>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-trbe.c | 59 +++++++++++++++++++-
>>>   1 file changed, 57 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>>> index 02f9e00e2091..ea907345354c 100644
>>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>>> @@ -86,7 +86,8 @@ struct trbe_buf {
>>>    * affects the given instance of the TRBE.
>>>    */
>>>   #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE    0
>>> -#define TRBE_ERRATA_MAX                1
>>> +#define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE    1
>>> +#define TRBE_ERRATA_MAX                2
>>>     /*
>>>    * Safe limit for the number of bytes that may be overwritten
>>> @@ -96,6 +97,7 @@ struct trbe_buf {
>>>     static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
>>>       [TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>>> +    [TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
>>>   };
>>>     /*
>>> @@ -279,7 +281,20 @@ trbe_handle_to_cpudata(struct perf_output_handle *handle)
>>>     static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
>>>   {
>>> -    return TRBE_TRACE_MIN_BUF_SIZE;
>>> +    u64 size = TRBE_TRACE_MIN_BUF_SIZE;
>>> +    struct trbe_cpudata *cpudata = trbe_handle_to_cpudata(handle);
>>> +
>>> +    /*
>>> +     * When the TRBE is affected by an erratum that could make it
>>> +     * write to the next "virtually addressed" page beyond the LIMIT.
>>
>> What if the next "virtually addressed" page is just blocked from future
>> usage in the kernel and never really gets mapped into a physical page ?
> 
> That is the case today for vmap(), the end of the vm_area has a guard
> page. But that implies when the erratum is triggered, the TRBE
> encounters a fault and we need to handle that in the driver. This works
> for "end" of the ring buffer. But not when the LIMIT is in the middle
> of the ring buffer.
> 
>> In that case it would be guaranteed that, a next "virtually addressed"
>> page would not even exist after the LIMIT pointer and hence the errata
>> would not be triggered. Something like there is a virtual mapping cliff
>> right after the LIMIT pointer from the MMU perspective.
>>
>> Although it might be bit tricky. Currently the entire ring buffer gets
>> mapped at once with vmap() in arm_trbe_alloc_buffer(). Just to achieve
>> the above solution, each computation of the LIMIT pointer needs to be
>> followed by a temporary unmapping of next virtual page from existing
>> vmap() buffer. Subsequently it could be mapped back as trbe_buf->pages
>> always contains all the physical pages from the perf ring buffer.
> 
> It is much easier to leave a page aside than to do this map, unmap
> dance, which might even change the VA address you get and thus it
> complicates the TRBE driver in general. I believe this is much
> simpler and we can reason about the code better. And all faults
> are still illegal for the driver, which helps us to detect any
> other issues in the TRBE.

Agreed, as I had mentioned earlier this would have been anyways bit
complicated. Not changing the virtual address for the entire buffer
and to treat each fault inside the driver as illegal, makes current
implementation much simpler and easier to reason about. So probably
discarding those properties might not be a good idea after all.
