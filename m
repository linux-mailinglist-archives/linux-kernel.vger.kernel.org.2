Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059EE4328F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhJRVRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 17:17:48 -0400
Received: from foss.arm.com ([217.140.110.172]:42942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhJRVRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 17:17:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2D0AD6E;
        Mon, 18 Oct 2021 14:15:35 -0700 (PDT)
Received: from [10.57.25.70] (unknown [10.57.25.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 203773F73D;
        Mon, 18 Oct 2021 14:15:33 -0700 (PDT)
Subject: Re: [PATCH v5 10/15] coresight: trbe: Workaround TRBE errata
 overwrite in FILL mode
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-11-suzuki.poulose@arm.com>
 <20211018155154.GB3163131@p14s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d7072a9b-542d-08af-6e7c-64f81e0a1e17@arm.com>
Date:   Mon, 18 Oct 2021 22:15:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211018155154.GB3163131@p14s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2021 16:51, Mathieu Poirier wrote:
> On Thu, Oct 14, 2021 at 11:31:20PM +0100, Suzuki K Poulose wrote:
>> ARM Neoverse-N2 (#2139208) and Cortex-A710(##2119858) suffers from
>> an erratum, which when triggered, might cause the TRBE to overwrite
>> the trace data already collected in FILL mode, in the event of a WRAP.
>> i.e, the TRBE doesn't stop writing the data, instead wraps to the base
>> and could write upto 3 cache line size worth trace. Thus, this could
>> corrupt the trace at the "BASE" pointer.
>>
>> The workaround is to program the write pointer 256bytes from the
>> base, such that if the erratum is triggered, it doesn't overwrite
>> the trace data that was captured. This skipped region could be
>> padded with ignore packets at the end of the session, so that
>> the decoder sees a continuous buffer with some padding at the
>> beginning. The trace data written at the base is considered
>> lost as the limit could have been in the middle of the perf
>> ring buffer, and jumping to the "base" is not acceptable.
>> We set the flags already to indicate that some amount of trace
>> was lost during the FILL event IRQ. So this is fine.
>>
>> One important change with the work around is, we program the
>> TRBBASER_EL1 to current page where we are allowed to write.
>> Otherwise, it could overwrite a region that may be consumed
>> by the perf. Towards this, we always make sure that the
>> "handle->head" and thus the trbe_write is PAGE_SIZE aligned,
>> so that we can set the BASE to the PAGE base and move the
>> TRBPTR to the 256bytes offset.
>>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since v2:
>>   - Updated the ASCII art to include better description of
>>     all the steps in the work around
>> Change since v1:
>>   - Updated comment with ASCII art
>>   - Add _BYTES suffix for the space to skip for the work around.
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 169 +++++++++++++++++--
>>   1 file changed, 158 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 314e5e7374c7..b56b166b2dec 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -16,6 +16,7 @@
>>   #define pr_fmt(fmt) DRVNAME ": " fmt
>>   
>>   #include <asm/barrier.h>
>> +#include <asm/cpufeature.h>
> 
> Here too I get a checkpatch warning...
> 

That is a false alarm. I guess that warns for including
linux/cpufeature.h? It is a bit odd, we include this
for the arm64 cpucaps, not the generic linux feature
checks. (They are used for "loading modules" based
on "features" which are more like ELF HWCAPs).

As such I chose to ignore it.

Suzuki
