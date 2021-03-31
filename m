Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D733E35036C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhCaP2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:28:47 -0400
Received: from foss.arm.com ([217.140.110.172]:45002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235512AbhCaP2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:28:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F3CDD6E;
        Wed, 31 Mar 2021 08:28:15 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB3793F792;
        Wed, 31 Mar 2021 08:28:13 -0700 (PDT)
Subject: Re: [PATCH v5 07/19] arm64: kvm: Enable access to TRBE support for
 host
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <20210323120647.454211-8-suzuki.poulose@arm.com>
 <87r1jxq7ax.wl-maz@kernel.org> <c87d9dd9-72b2-6730-e3d4-9aaa0370a639@arm.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <e10a33cd-45ea-3290-3556-5961c434d365@arm.com>
Date:   Wed, 31 Mar 2021 16:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <c87d9dd9-72b2-6730-e3d4-9aaa0370a639@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 3/30/21 12:12 PM, Suzuki K Poulose wrote:
> Hi Marc
>
> On 30/03/2021 11:12, Marc Zyngier wrote:
>> Hi Suzuki,
>>
>> [+ Alex]
>>
>> On Tue, 23 Mar 2021 12:06:35 +0000,
>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>> [..]
>>
>>>   #define MDCR_EL2_TTRF        (1 << 19)
>>>   #define MDCR_EL2_TPMS        (1 << 14)
>>>   #define MDCR_EL2_E2PB_MASK    (UL(0x3))
>>> diff --git a/arch/arm64/include/asm/kvm_host.h
>>> b/arch/arm64/include/asm/kvm_host.h
>>> index 3d10e6527f7d..80d0a1a82a4c 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -315,6 +315,8 @@ struct kvm_vcpu_arch {
>>>           struct kvm_guest_debug_arch regs;
>>>           /* Statistical profiling extension */
>>>           u64 pmscr_el1;
>>> +        /* Self-hosted trace */
>>> +        u64 trfcr_el1;
>>>       } host_debug_state;
>>>         /* VGIC state */
>>> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
>>> index 5eccbd62fec8..05d25e645b46 100644
>>> --- a/arch/arm64/kernel/hyp-stub.S
>>> +++ b/arch/arm64/kernel/hyp-stub.S
>>> @@ -115,9 +115,10 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>>>       mrs_s    x0, SYS_VBAR_EL12
>>>       msr    vbar_el1, x0
>>>   -    // Use EL2 translations for SPE and disable access from EL1
>>> +    // Use EL2 translations for SPE & TRBE and disable access from EL1
>>>       mrs    x0, mdcr_el2
>>>       bic    x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
>>> +    bic    x0, x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
>>>       msr    mdcr_el2, x0
>>>         // Transfer the MM state from EL1 to EL2
>>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>>> index dbc890511631..7b16f42d39f4 100644
>>> --- a/arch/arm64/kvm/debug.c
>>> +++ b/arch/arm64/kvm/debug.c
>>> @@ -89,7 +89,7 @@ void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)
>>>    *  - Debug ROM Address (MDCR_EL2_TDRA)
>>>    *  - OS related registers (MDCR_EL2_TDOSA)
>>>    *  - Statistical profiler (MDCR_EL2_TPMS/MDCR_EL2_E2PB)
>>> - *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
>>> + *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
>>
>> For the record, this is likely to conflict with [1], although that
>> patch still has some issues.
>
> Thanks for the heads up. I think that patch will also conflict with my fixes
> that is queued in kvmarm/fixes.

How should I proceed with the patch [1]? For the next iteration, should I rebase
it on top of kvmarm/fixes or on top of kvmarm/fixes + this series?

[1] https://lore.kernel.org/r/20210323180057.263356-1-alexandru.elisei@arm.com

Thanks,
Alex
