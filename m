Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6084043C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 04:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348873AbhIIC4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 22:56:08 -0400
Received: from foss.arm.com ([217.140.110.172]:55484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhIIC4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 22:56:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623E131B;
        Wed,  8 Sep 2021 19:54:57 -0700 (PDT)
Received: from [10.163.72.152] (unknown [10.163.72.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D5C73F73D;
        Wed,  8 Sep 2021 19:54:53 -0700 (PDT)
Subject: Re: [PATCH 01/10] coresight: trbe: Add infrastructure for Errata
 handling
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-2-suzuki.poulose@arm.com>
 <4c23e288-14bd-f4a5-2f92-6e3ad46324fa@arm.com>
 <919ef281-6ef2-8557-c8a3-e4eea452694f@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7f2a3e36-bc98-f611-e137-710f27e1f932@arm.com>
Date:   Thu, 9 Sep 2021 08:25:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <919ef281-6ef2-8557-c8a3-e4eea452694f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/21 2:34 PM, Suzuki K Poulose wrote:
> On 02/08/2021 07:43, Anshuman Khandual wrote:
>>
>>
>> On 7/28/21 7:22 PM, Suzuki K Poulose wrote:
>>> Add a minimal infrastructure to keep track of the errata
>>> affecting the given TRBE instance. Given that we have
>>> heterogeneous CPUs, we have to manage the list per-TRBE
>>> instance to be able to apply the work around as needed.
>>>
>>> We rely on the arm64 errata framework for the actual
>>> description and the discovery of a given erratum, to
>>> keep the Erratum work around at a central place and
>>> benefit from the code and the advertisement from the
>>> kernel. We use a local mapping of the erratum to
>>> avoid bloating up the individual TRBE structures.
>>
>> I guess there is no other way around apart from each TRBE instance
>> tracking applicable erratas locally per CPU, even though it sounds
>> bit redundant.
>>
>>> i.e, each arm64 TRBE erratum bit is assigned a new number
>>> within the driver to track. Each trbe instance updates
>>> the list of affected erratum at probe time on the CPU.
>>> This makes sure that we can easily access the list of
>>> errata on a given TRBE instance without much overhead.
>>
>> It also ensures that the generic errata framework is queried just
>> once during individual CPU probe.
>>
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-trbe.c | 48 ++++++++++++++++++++
>>>   1 file changed, 48 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>>> index b8586c170889..0368bf405e35 100644
>>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>>> @@ -16,6 +16,8 @@
>>>   #define pr_fmt(fmt) DRVNAME ": " fmt
>>>     #include <asm/barrier.h>
>>> +#include <asm/cputype.h>
>>> +
>>>   #include "coresight-self-hosted-trace.h"
>>>   #include "coresight-trbe.h"
>>>   @@ -65,6 +67,35 @@ struct trbe_buf {
>>>       struct trbe_cpudata *cpudata;
>>>   };
>>>   +/*
>>> + * TRBE erratum list
>>> + *
>>> + * We rely on the corresponding cpucaps to be defined for a given
>>> + * TRBE erratum. We map the given cpucap into a TRBE internal number
>>> + * to make the tracking of the errata lean.
>>> + *
>>> + * This helps in :
>>> + *   - Not duplicating the detection logic
>>> + *   - Streamlined detection of erratum across the system
>>> + *
>>> + * Since the erratum work arounds could be applied individually
>>> + * per TRBE instance, we keep track of the list of errata that
>>> + * affects the given instance of the TRBE.
>>> + */
>>> +#define TRBE_ERRATA_MAX            0
>>> +
>>> +static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
>>> +};
>>
>> This needs to be tighten up. There should be build time guard rails in
>> arm64 errata cpucaps, so that only TRBE specific ones could be assigned
>> here as trbe_errata_cpucaps[].
> 
> I don't get your point. The actual arm64 erratum caps are not linear
> and as such we don't have to force it. This approach gives us a hand
> picked exact list of errata that apply to the TRBE driver by mapping
> it linearly here. The only reason why we have that TRBE_ERRATA_MAX,
> is such that we can track it per TRBE instance and ...

If the arm64 erratum caps are not linear, then it might be difficult or
probably even irrelevant to enforce such errata guard rails. But what I
originally thought was, if arm64 erratums applicable to TRBE are linear
in nature, then its range could have been validated while picking each
of them for trbe_errata_cpucaps[]. But if the arm64 range is not linear
for TRBE, then there might be some non-TRBE erratums scattered inside.

> 
>>
>>> +
>>> +/*
>>> + * struct trbe_cpudata: TRBE instance specific data
>>> + * @trbe_flag        - TRBE dirty/access flag support
>>> + * @tbre_align        - Actual TRBE alignment required for TRBPTR_EL1.
>>> + * @cpu            - CPU this TRBE belongs to.
>>> + * @mode        - Mode of current operation. (perf/disabled)
>>> + * @drvdata        - TRBE specific drvdata
>>> + * @errata        - Bit map for the errata on this TRBE.
>>> + */
>>>   struct trbe_cpudata {
>>>       bool trbe_flag;
>>>       u64 trbe_align;
>>> @@ -72,6 +103,7 @@ struct trbe_cpudata {
>>>       enum cs_mode mode;
>>>       struct trbe_buf *buf;
>>>       struct trbe_drvdata *drvdata;
>>> +    DECLARE_BITMAP(errata, TRBE_ERRATA_MAX);
>>>   };
>>>     struct trbe_drvdata {
>>> @@ -84,6 +116,21 @@ struct trbe_drvdata {
>>>       struct platform_device *pdev;
>>>   };
>>>   +static void trbe_check_errata(struct trbe_cpudata *cpudata)
>>> +{
>>> +    int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(trbe_errata_cpucaps); i++) {
>>
>> BUILD_BUG_ON() - if trbe_errata_cpucaps[i] is not inside TRBE specific
>> errata cpucap range ?
> 
> ... also run these detection tests.

As discussed earlier, if no such range could be figured out, this would
not be necessary as well.

> 
>>
>>> +        if (this_cpu_has_cap(trbe_errata_cpucaps[i]))
>>> +            set_bit(i, cpudata->errata);
>>> +    }
>>> +}
>>> +
>>> +static inline bool trbe_has_erratum(int i, struct trbe_cpudata *cpudata)
>>
>> Switch the argument positions here ? 'int i' should be the second one.
>>
> 
> ok.
> 
>>> +{
>>> +    return (i < TRBE_ERRATA_MAX) && test_bit(i, cpudata->errata);
>>> +}
>>> +
>>>   static int trbe_alloc_node(struct perf_event *event)
>>>   {
>>>       if (event->cpu == -1)
>>> @@ -925,6 +972,7 @@ static void arm_trbe_probe_cpu(void *info)
>>>           goto cpu_clear;
>>>       }
>>>   +    trbe_check_errata(cpudata);
>>
>> This should be called right at the end before arm_trbe_probe_cpu() exits
>> on the success path. Errata should not be evaluated if TRBE on the CPU
>> wont be used for some reason i.e cpumask_clear_cpu() path.
> 
> ok
> 
>>
>>>       cpudata->trbe_align = 1ULL << get_trbe_address_align(trbidr);
>>>       if (cpudata->trbe_align > SZ_2K) {
>>>           pr_err("Unsupported alignment on cpu %d\n", cpu);
>>>
>>
>> This patch should be moved after [PATCH 5/10] i.e just before adding the
>> first TRBE errata.
>>
> 
> I will take a look.
> 
> Thanks for the review
> 
> Suzuki
> 
> 
