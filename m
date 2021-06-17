Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D843AB4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhFQN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:26:39 -0400
Received: from foss.arm.com ([217.140.110.172]:53560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFQN0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:26:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0412F106F;
        Thu, 17 Jun 2021 06:24:29 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57AE23F719;
        Thu, 17 Jun 2021 06:24:26 -0700 (PDT)
Subject: Re: [PATCH v15 0/7] MTE support for KVM guest
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
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
References: <20210614090525.4338-1-steven.price@arm.com>
 <20210617121322.GC6314@arm.com> <87im2cd443.wl-maz@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <db4cf3c1-d5eb-f8cf-23ff-d52e3b6ae9b1@arm.com>
Date:   Thu, 17 Jun 2021 14:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87im2cd443.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 14:15, Marc Zyngier wrote:
> On Thu, 17 Jun 2021 13:13:22 +0100,
> Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> On Mon, Jun 14, 2021 at 10:05:18AM +0100, Steven Price wrote:
>>> I realise there are still open questions[1] around the performance of
>>> this series (the 'big lock', tag_sync_lock, introduced in the first
>>> patch). But there should be no impact on non-MTE workloads and until we
>>> get real MTE-enabled hardware it's hard to know whether there is a need
>>> for something more sophisticated or not. Peter Collingbourne's patch[3]
>>> to clear the tags at page allocation time should hide more of the impact
>>> for non-VM cases. So the remaining concern is around VM startup which
>>> could be effectively serialised through the lock.
>> [...]
>>> [1]: https://lore.kernel.org/r/874ke7z3ng.wl-maz%40kernel.org
>>
>> Start-up, VM resume, migration could be affected by this lock, basically
>> any time you fault a page into the guest. As you said, for now it should
>> be fine as long as the hardware doesn't support MTE or qemu doesn't
>> enable MTE in guests. But the problem won't go away.
> 
> Indeed. And I find it odd to say "it's not a problem, we don't have
> any HW available". By this token, why should we merge this work the
> first place, or any of the MTE work that has gone into the kernel over
> the past years?
> 
>> We have a partial solution with an array of locks to mitigate against
>> this but there's still the question of whether we should actually bother
>> for something that's unlikely to happen in practice: MAP_SHARED memory
>> in guests (ignoring the stage 1 case for now).
>>
>> If MAP_SHARED in guests is not a realistic use-case, we have the vma in
>> user_mem_abort() and if the VM_SHARED flag is set together with MTE
>> enabled for guests, we can reject the mapping.
> 
> That's a reasonable approach. I wonder whether we could do that right
> at the point where the memslot is associated with the VM, like this:
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index a36a2e3082d8..ebd3b3224386 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1376,6 +1376,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  		if (!vma)
>  			break;
>  
> +		if (kvm_has_mte(kvm) && vma->vm_flags & VM_SHARED)
> +			return -EINVAL;
> +
>  		/*
>  		 * Take the intersection of this VMA with the memory region
>  		 */
> 
> which takes the problem out of the fault path altogether? We document
> the restriction and move on. With that, we can use a non-locking
> version of mte_sync_page_tags().

Does this deal with the case where the VMAs are changed after the
memslot is created? While we can do the check here to give the VMM a
heads-up if it gets it wrong, I think we also need it in
user_mem_abort() to deal with a VMM which mmap()s over the VA of the
memslot. Or am I missing something?

But if everyone is happy with the restriction (just for KVM) of not
allowing MTE+VM_SHARED then that sounds like a good way forward.

Thanks,

Steve

>> We can discuss the stage 1 case separately from this series.
> 
> Works for me.
> 
> Thanks,
> 
> 	M.
> 

