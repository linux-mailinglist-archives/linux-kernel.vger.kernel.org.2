Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7263B41E6D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 06:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351296AbhJAElJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 00:41:09 -0400
Received: from foss.arm.com ([217.140.110.172]:34596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhJAElH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 00:41:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBE9C106F;
        Thu, 30 Sep 2021 21:39:23 -0700 (PDT)
Received: from [10.163.74.5] (unknown [10.163.74.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B33F3F70D;
        Thu, 30 Sep 2021 21:39:19 -0700 (PDT)
Subject: Re: [PATCH v2 14/17] coresight: trbe: Make sure we have enough space
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-15-suzuki.poulose@arm.com>
 <60e75e7b-4a04-03d4-c861-88dd5fadef99@arm.com>
 <d3182ee5-2913-d005-778b-e46a50174180@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <79877977-16ec-7508-0870-d2f6ee8899e5@arm.com>
Date:   Fri, 1 Oct 2021 10:10:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d3182ee5-2913-d005-778b-e46a50174180@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/21 3:46 PM, Suzuki K Poulose wrote:
> On 22/09/2021 10:58, Anshuman Khandual wrote:
>>
>>
>> On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
>>> The TRBE driver makes sure that there is enough space for a meaningful
>>> run, otherwise pads the given space and restarts the offset calculation
>>> once. But there is no guarantee that we may find space or hit "no space".
>>
>> So what happens currently when it neither finds the required minimum buffer
>> space for a meaningful run nor does it hit the "no space" scenario ?
> 
> It tries once today and assumes that it will either hit :
> 
>  - No space
>    OR
>  - Enough space
> 
> which is reasonable, given the minimum space needed is a few bytes.
> But this may no longer be true with other erratum workaround.

Okay.

> 
>>
>>> Make sure that we repeat the step until, either :
>>>    - We have the minimum space
>>>     OR
>>>    - There is NO space at all.
>>>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-trbe.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>>> index 3373f4e2183b..02f9e00e2091 100644
>>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>>> @@ -451,10 +451,14 @@ static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
>>>        * If the head is too close to the limit and we don't
>>>        * have space for a meaningful run, we rather pad it
>>>        * and start fresh.
>>> +     *
>>> +     * We might have to do this more than once to make sure
>>> +     * we have enough required space.
>>
>> OR no space at all, as explained in the commit message.
>> Hence this comment needs an update.
>>
>>>        */
>>> -    if (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
>>> +    while (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
>>>           trbe_pad_buf(handle, limit - head);
>>>           limit = __trbe_normal_offset(handle);
>>> +        head = PERF_IDX2OFF(handle->head, buf);
>>
>> Should the loop be bound with a retry limit as well ?
> 
> No. We will eventually hit No-space as we keep on padding
> the buffer.

Got it.
