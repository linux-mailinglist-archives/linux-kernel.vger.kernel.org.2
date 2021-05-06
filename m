Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA09375848
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhEFQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:16:33 -0400
Received: from foss.arm.com ([217.140.110.172]:37330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235246AbhEFQQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:16:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3582331B;
        Thu,  6 May 2021 09:15:34 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292B43F718;
        Thu,  6 May 2021 09:15:27 -0700 (PDT)
Subject: Re: [PATCH v11 2/6] arm64: kvm: Introduce MTE VM feature
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
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
References: <20210416154309.22129-1-steven.price@arm.com>
 <20210416154309.22129-3-steven.price@arm.com> <20210428170705.GB4022@arm.com>
 <c3293d47-a5f2-ea4a-6730-f5cae26d8a7e@arm.com> <YJGHApOCXl811VK3@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <329286e8-a8f3-ea1a-1802-58813255a4a5@arm.com>
Date:   Thu, 6 May 2021 17:15:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJGHApOCXl811VK3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2021 18:40, Catalin Marinas wrote:
> On Thu, Apr 29, 2021 at 05:06:41PM +0100, Steven Price wrote:
>> On 28/04/2021 18:07, Catalin Marinas wrote:
>>> I probably asked already but is the only way to map a standard RAM page
>>> (not device) in stage 2 via the fault handler? One case I had in mind
>>> was something like get_user_pages() but it looks like that one doesn't
>>> call set_pte_at_notify(). There are a few other places where
>>> set_pte_at_notify() is called and these may happen before we got a
>>> chance to fault on stage 2, effectively populating the entry (IIUC). If
>>> that's an issue, we could move the above loop and check closer to the
>>> actual pte setting like kvm_pgtable_stage2_map().
>>
>> The only call sites of kvm_pgtable_stage2_map() are in mmu.c:
>>
>>   * kvm_phys_addr_ioremap() - maps as device in stage 2
>>
>>   * user_mem_abort() - handled above
>>
>>   * kvm_set_spte_handler() - ultimately called from the .change_pte()
>> callback of the MMU notifier
>>
>> So the last one is potentially a problem. It's called via the MMU notifiers
>> in the case of set_pte_at_notify(). The users of that are:
>>
>>   * uprobe_write_opcode(): Allocates a new page and performs a
>> copy_highpage() to copy the data to the new page (which with MTE includes
>> the tags and will copy across the PG_mte_tagged flag).
>>
>>   * write_protect_page() (KSM): Changes the permissions on the PTE but it's
>> still the same page, so nothing to do regarding MTE.
> 
> My concern here is that the VMM had a stage 1 pte but we haven't yet
> faulted in at stage 2 via user_mem_abort(), so we don't have any stage 2
> pte set. write_protect_page() comes in and sets the new stage 2 pte via
> the callback. I couldn't find any check in kvm_pgtable_stage2_map() for
> the old pte, so it will set the new stage 2 pte regardless. A subsequent
> guest read would no longer fault at stage 2.
> 
>>   * replace_page() (KSM): If the page has MTE tags then the MTE version of
>> memcmp_pages() will return false, so the only caller
>> (try_to_merge_one_page()) will never call this on a page with tags.
>>
>>   * wp_page_copy(): This one is more interesting - if we go down the
>> cow_user_page() path with an old page then everything is safe (tags are
>> copied over). The is_zero_pfn() case worries me a bit - a new page is
>> allocated, but I can't instantly see anything to zero out the tags (and set
>> PG_mte_tagged).
> 
> True, I think tag zeroing happens only if we map it as PROT_MTE in the
> VMM.
> 
>>   * migrate_vma_insert_page(): I think migration should be safe as the tags
>> should be copied.
>>
>> So wp_page_copy() looks suspicious.
>>
>> kvm_pgtable_stage2_map() looks like it could be a good place for the checks,
>> it looks like it should work and is probably a more obvious place for the
>> checks.
> 
> That would be my preference. It also matches the stage 1 set_pte_at().
> 
>>> While the set_pte_at() race on the page flags is somewhat clearer, we
>>> may still have a race here with the VMM's set_pte_at() if the page is
>>> mapped as tagged. KVM has its own mmu_lock but it wouldn't be held when
>>> handling the VMM page tables (well, not always, see below).
>>>
>>> gfn_to_pfn_prot() ends up calling get_user_pages*(). At least the slow
>>> path (hva_to_pfn_slow()) ends up with FOLL_TOUCH in gup and the VMM pte
>>> would be set, tags cleared (if PROT_MTE) before the stage 2 pte. I'm not
>>> sure whether get_user_page_fast_only() does the same.
>>>
>>> The race with an mprotect(PROT_MTE) in the VMM is fine I think as the
>>> KVM mmu notifier is invoked before set_pte_at() and racing with another
>>> user_mem_abort() is serialised by the KVM mmu_lock. The subsequent
>>> set_pte_at() would see the PG_mte_tagged set either by the current CPU
>>> or by the one it was racing with.
>>
>> Given the changes to set_pte_at() which means that tags are restored from
>> swap even if !PROT_MTE, the only race I can see remaining is the creation of
>> new PROT_MTE mappings. As you mention an attempt to change mappings in the
>> VMM memory space should involve a mmu notifier call which I think serialises
>> this. So the remaining issue is doing this in a separate address space.
>>
>> So I guess the potential problem is:
>>
>>   * allocate memory MAP_SHARED but !PROT_MTE
>>   * fork()
>>   * VM causes a fault in parent address space
>>   * child does a mprotect(PROT_MTE)
>>
>> With the last two potentially racing. Sadly I can't see a good way of
>> handling that.
> 
> Ah, the mmap lock doesn't help as they are different processes
> (mprotect() acquires it as a writer).
> 
> I wonder whether this is racy even in the absence of KVM. If both parent
> and child do an mprotect(PROT_MTE), one of them may be reading stale
> tags for a brief period.
> 
> Maybe we should revisit whether shared MTE pages are of any use, though
> it's an ABI change (not bad if no-one is relying on this). However...

Shared MTE pages are certainly hard to use correctly (e.g. see the 
discussions with the VMM accessing guest memory). But I guess that boat 
has sailed.

> Thinking about this, we have a similar problem with the PG_dcache_clean
> and two processes doing mprotect(PROT_EXEC). One of them could see the
> flag set and skip the I-cache maintenance while the other executes
> stale instructions. change_pte_range() could acquire the page lock if
> the page is VM_SHARED (my preferred core mm fix). It doesn't immediately
> solve the MTE/KVM case but we could at least take the page lock via
> user_mem_abort().

For PG_dcache_clean AFAICS the solution is actually simple: split the 
test and set parts. i.e..:

  if (!test_bit(PG_dcache_clean, &page->flags)) {
	sync_icache_aliases(page_address(page), page_size(page));
	set_bit(PG_dcache_clean, &page->flags);
  }

There isn't a problem with repeating the sync_icache_aliases() call in 
the case of a race. Or am I missing something?

> Or maybe we just document this behaviour as racy both for PROT_EXEC and
> PROT_MTE mappings and be done with this. The minor issue with PROT_MTE
> is the potential leaking of tags (it's harder to leak information
> through the I-cache).
> 

This is the real issue I see - the race in PROT_MTE case is either a 
data leak (syncing after setting the bit) or data loss (syncing before 
setting the bit).

But without serialising through a spinlock (in mte_sync_tags()) I 
haven't been able to come up with any way of closing the race. But with 
the change to set_pte_at() to call mte_sync_tags() even if the PTE isn't 
PROT_MTE that is likely to seriously hurt performance.

Steve
