Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89E531ED6C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhBRRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:37:13 -0500
Received: from foss.arm.com ([217.140.110.172]:51976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhBROwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:52:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBED0ED1;
        Thu, 18 Feb 2021 06:51:14 -0800 (PST)
Received: from [10.57.42.30] (unknown [10.57.42.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7E9B3F73D;
        Thu, 18 Feb 2021 06:51:12 -0800 (PST)
Subject: Re: [PATCH v7 28/28] coresight: Add support for v8.4 SelfHosted
 tracing
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
 <20210110224850.1880240-29-suzuki.poulose@arm.com>
 <CAJ9a7ViwNA__+5f7-DehM6OtGer3DjdZfWsgHc9EOcr5-vQXgA@mail.gmail.com>
 <72f85de4-5b39-c963-78cf-2f8347e21268@arm.com>
 <CAJ9a7Vh-CkYQrxgTv-erb6MBXkXWkFg6xF5vEem4iQyOx9LYkw@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <94f5cf2a-6ccf-0a3a-1a28-6e6cdc49ef4b@arm.com>
Date:   Thu, 18 Feb 2021 14:51:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJ9a7Vh-CkYQrxgTv-erb6MBXkXWkFg6xF5vEem4iQyOx9LYkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike

On 2/12/21 5:30 PM, Mike Leach wrote:
> Hi Suzuki,
> 
> On Fri, 12 Feb 2021 at 15:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Hi Mike
>>
>> On 2/12/21 10:34 AM, Mike Leach wrote:
>>> Hi Mathieu, Suzuki,
>>>
>>> Sorry for the really late response on this patch, but I noticed a
>>> problem while doing a review of the ETE / TRBE set. (TRBE specs
>>> mention TRFCR_ELx, so I was confirming a couple of things).
>>>
>>> On Sun, 10 Jan 2021 at 22:49, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>
>>>> From: Jonathan Zhou <jonathan.zhouwen@huawei.com>
>>>>
>>>> v8.4 tracing extensions added support for trace filtering controlled
>>>> by TRFCR_ELx. This must be programmed to allow tracing at EL1/EL2 and
>>>> EL0. The timestamp used is the virtual time. Also enable CONTEXIDR_EL2
>>>> tracing if we are running the kernel at EL2.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
>>>> [ Move the trace filtering setup etm_init_arch_data() and
>>>>    clean ups]
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>    .../coresight/coresight-etm4x-core.c          | 25 +++++++++++++++++++
>>>>    1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> index 3d3165dd09d4..18c1a80abab8 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> @@ -859,6 +859,30 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>>>>           return false;
>>>>    }
>>>>
>>>> +static void cpu_enable_tracing(void)
>>>> +{
>>>> +       u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
>>>> +       u64 trfcr;
>>>> +
>>>> +       if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
>>>> +               return;
>>>> +
>>>> +       /*
>>>> +        * If the CPU supports v8.4 SelfHosted Tracing, enable
>>>> +        * tracing at the kernel EL and EL0, forcing to use the
>>>> +        * virtual time as the timestamp.
>>>> +        */
>>>> +       trfcr = (TRFCR_ELx_TS_VIRTUAL |
>>>> +                TRFCR_ELx_ExTRE |
>>>> +                TRFCR_ELx_E0TRE);
>>>> +
>>>> +       /* If we are running at EL2, allow tracing the CONTEXTIDR_EL2. */
>>>> +       if (is_kernel_in_hyp_mode())
>>>> +               trfcr |= TRFCR_EL2_CX;
>>>> +
>>>
>>> This is wrong - CX bit is present on TRFCR_EL2, not TRFCR_EL1.
>>
>> Why is this wrong ? We do this only when we are in EL2.
>>
> 
> Sorry  - must have been looking at an older version of the ARMARM when
> I looked for EL1 registers that are aliased to EL2.  So this does
> indeed work!
> 
>>> Moreover, TRFCR_EL2 has a separate enables for tracing at EL0 and EL2.
>>>
>>
>> True, that is for EL0&2 translation regimes. i.e, tracing EL0 with
>> the kernel running at EL2. But bits TRFCR_EL2.E2TRE == TRFCR_EL1.E1TRE
>> If notice, we name the bit TRFCR_ELx_ExTRE. And E0TRE == E0HTRE.
>>
>> So we do the following :
>>
>>     1) When kernel running at EL2:
>>       Enable tracing at EL2 and EL0 and context tracking
>>     2) When kernel running at EL1:
>>       Enable tracing at EL1 and EL0.
>>
>>
>>> Secondly - is this correct in principal?  Should the driver not be
>>> reading the access it is permitted by the kernel, rather than giving
>>> itself unfettered access to trace where it wants to.
>>
>> I dont follow the "access permitted by the kernel" here. What are we referrring to ?
>>
> 
> By that I mean that as I suggest below this should be controlled by
> what we could call the hypervisor, rather than a driver.
> 
>>> Surely TRFCR_ELx  levels should be chosen in KConfig  and then should
>>> be set up in kernel initialisation?
>>
>> I disagree with yet another Kconfig. This basic requirement for
>> enabling the trace collection. It is not something that we can optionally
>> use from the architecture. So we should transparently do the right
>> thing for making sure that we set up the system for something that
>> didn't require any other steps. Or in other words, if we add a Kconfig
>> option for TRFCR programming, if someone forgets to select it
>> when they upgraded the kernel they are in for a surprisingly long
>> debugging to find why the trace doesnt work.
>>
>> As for the TRFCR programming, we have two choices. etm4x driver
>> or generic boot up for the CPU. I preferred to do this in the
>> driver as we can enable it only if trace drivers are available.
>>
> 
> The point is that TRFCR are not part of the controlling registers for
> the ETE or any trace source device. The architecture manual seems to
> regard them as being controlled by the hypervisor, rather than the PE
> trace device. This implies that the control feature is designed to be
> independent from the trace generation features.
> 
> I thought they were there to allow virtualisation code to determine
> what gets traced and what is prohibited, and what view the trace sees
> of the clock. If you simple switch everything on from the driver and

Exactly.

> control the ELs traced from the ETE / ETM registers then what are they
> there for?

Yes. The hyp (KVM in this case) traps access to the ETE/ETM registers
by default and thus the EL1 can't trace itself. When we get to Virtualization
support, indeed we would need to use TRFCR in the Hyp to exclude the
host from being traced.

> 
> This solution could be a first pass at this to get trace working, but
> I think it will have to change in future.

Yes, that is something we have thought about. As added security, we could
infact, enable the respective ELs for each session.

This made me think a bit and find that we should not be advertising
the system register capability to the Guests. I will send out a patch
to fix that.

Cheers
Suzuki
