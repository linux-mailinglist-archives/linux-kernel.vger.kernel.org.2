Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440B330F5AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhBDO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:59:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236957AbhBDO44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:56:56 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BEA264D9F;
        Thu,  4 Feb 2021 14:56:15 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l7g3J-00C1uA-9o; Thu, 04 Feb 2021 14:56:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 04 Feb 2021 14:56:13 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v7 1/3] arm64: kvm: Save/restore MTE registers
In-Reply-To: <e294d3d3-20d6-717d-4274-c190f9cc5887@arm.com>
References: <20210115152811.8398-1-steven.price@arm.com>
 <20210115152811.8398-2-steven.price@arm.com>
 <a99f09a56cf33bfa18b55c251380ef22@kernel.org>
 <e294d3d3-20d6-717d-4274-c190f9cc5887@arm.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <bf1fe1204a075abbd294435944973f62@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave.Martin@arm.com, mark.rutland@arm.com, tglx@linutronix.de, qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org, Haibo.Xu@arm.com, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-04 14:33, Steven Price wrote:
> On 02/02/2021 15:36, Marc Zyngier wrote:
>> On 2021-01-15 15:28, Steven Price wrote:
>>> Define the new system registers that MTE introduces and context 
>>> switch
>>> them. The MTE feature is still hidden from the ID register as it 
>>> isn't
>>> supported in a VM yet.
>>> 
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>>  arch/arm64/include/asm/kvm_host.h          |  4 ++
>>>  arch/arm64/include/asm/kvm_mte.h           | 74 
>>> ++++++++++++++++++++++
>>>  arch/arm64/include/asm/sysreg.h            |  3 +-
>>>  arch/arm64/kernel/asm-offsets.c            |  3 +
>>>  arch/arm64/kvm/hyp/entry.S                 |  7 ++
>>>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h |  4 ++
>>>  arch/arm64/kvm/sys_regs.c                  | 14 ++--
>>>  7 files changed, 104 insertions(+), 5 deletions(-)
>>>  create mode 100644 arch/arm64/include/asm/kvm_mte.h
>>> 
>>> diff --git a/arch/arm64/include/asm/kvm_host.h
>>> b/arch/arm64/include/asm/kvm_host.h
>>> index 11beda85ee7e..51590a397e4b 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -148,6 +148,8 @@ enum vcpu_sysreg {
>>>      SCTLR_EL1,    /* System Control Register */
>>>      ACTLR_EL1,    /* Auxiliary Control Register */
>>>      CPACR_EL1,    /* Coprocessor Access Control */
>>> +    RGSR_EL1,    /* Random Allocation Tag Seed Register */
>>> +    GCR_EL1,    /* Tag Control Register */
>>>      ZCR_EL1,    /* SVE Control */
>>>      TTBR0_EL1,    /* Translation Table Base Register 0 */
>>>      TTBR1_EL1,    /* Translation Table Base Register 1 */
>>> @@ -164,6 +166,8 @@ enum vcpu_sysreg {
>>>      TPIDR_EL1,    /* Thread ID, Privileged */
>>>      AMAIR_EL1,    /* Aux Memory Attribute Indirection Register */
>>>      CNTKCTL_EL1,    /* Timer Control Register (EL1) */
>>> +    TFSRE0_EL1,    /* Tag Fault Status Register (EL0) */
>>> +    TFSR_EL1,    /* Tag Fault Stauts Register (EL1) */
>> 
>> s/Stauts/Status/
>> 
>> Is there any reason why the MTE registers aren't grouped together?
> 
> I has been under the impression this list is sorted by the encoding of
> the system registers, although double checking I've screwed up the
> order of TFSRE0_EL1/TFSR_EL1, and not all the other fields are sorted
> that way.

It grew organically, and was initially matching the original order
of the save/restore sequence. This order has long disappeared with
VHE, and this is essentially nothing more than a bag of indices
(although NV does bring some order back to deal with VNCR-backed
registers).

[...]

>>> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>>> b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>>> index cce43bfe158f..94d9736f0133 100644
>>> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>>> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>>> @@ -45,6 +45,8 @@ static inline void __sysreg_save_el1_state(struct
>>> kvm_cpu_context *ctxt)
>>>      ctxt_sys_reg(ctxt, CNTKCTL_EL1)    = 
>>> read_sysreg_el1(SYS_CNTKCTL);
>>>      ctxt_sys_reg(ctxt, PAR_EL1)    = read_sysreg_par();
>>>      ctxt_sys_reg(ctxt, TPIDR_EL1)    = read_sysreg(tpidr_el1);
>>> +    if (system_supports_mte())
>>> +        ctxt_sys_reg(ctxt, TFSR_EL1) = read_sysreg_el1(SYS_TFSR);
>> 
>> I already asked for it, and I'm going to ask for it again:
>> Most of the sysreg save/restore is guarded by a per-vcpu check
>> (HCR_EL2.ATA), while this one is unconditionally saved/restore
>> if the host is MTE capable. Why is that so?
> 
> Sorry, I thought your concern was for registers that affect the host
> (as they are obviously more performance critical as they are hit on
> every guest exit). Although I guess that's incorrect for nVHE which is
> what all the cool kids want now ;)

I think we want both correctness *and* performance, for both VHE
and nVHE. Things like EL0 registers should be able to be moved
to load/put on all implementations, and the correct switching
be done at the right spot only when required.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
