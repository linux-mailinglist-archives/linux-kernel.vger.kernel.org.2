Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80EF38AD38
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbhETL6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:58:34 -0400
Received: from foss.arm.com ([217.140.110.172]:48846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242181AbhETL4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:56:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC8AC101E;
        Thu, 20 May 2021 04:55:29 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC54F3F73D;
        Thu, 20 May 2021 04:55:26 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v12 3/8] arm64: mte: Sync tags for pages where PTE is
 untagged
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
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-4-steven.price@arm.com> <20210519180610.GE21619@arm.com>
Message-ID: <3bac3a47-9f96-c7bf-e401-fdef60dcc9d8@arm.com>
Date:   Thu, 20 May 2021 12:55:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519180610.GE21619@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2021 19:06, Catalin Marinas wrote:
> On Mon, May 17, 2021 at 01:32:34PM +0100, Steven Price wrote:
>> A KVM guest could store tags in a page even if the VMM hasn't mapped
>> the page with PROT_MTE. So when restoring pages from swap we will
>> need to check to see if there are any saved tags even if !pte_tagged().
>>
>> However don't check pages for which pte_access_permitted() returns false
>> as these will not have been swapped out.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  arch/arm64/include/asm/pgtable.h |  9 +++++++--
>>  arch/arm64/kernel/mte.c          | 16 ++++++++++++++--
>>  2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 0b10204e72fc..275178a810c1 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -314,8 +314,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>>  	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
>>  		__sync_icache_dcache(pte);
>>  
>> -	if (system_supports_mte() &&
>> -	    pte_present(pte) && pte_tagged(pte) && !pte_special(pte))
>> +	/*
>> +	 * If the PTE would provide user space access to the tags associated
>> +	 * with it then ensure that the MTE tags are synchronised.  Exec-only
>> +	 * mappings don't expose tags (instruction fetches don't check tags).
>> +	 */
>> +	if (system_supports_mte() && pte_present(pte) &&
>> +	    pte_access_permitted(pte, false) && !pte_special(pte))
>>  		mte_sync_tags(ptep, pte);
> 
> Looking at the mte_sync_page_tags() logic, we bail out early if it's the
> old pte is not a swap one and the new pte is not tagged. So we only need
> to call mte_sync_tags() if it's a tagged new pte or the old one is swap.
> What about changing the set_pte_at() test to:
> 
> 	if (system_supports_mte() && pte_present(pte) && !pte_special(pte) &&
> 	    (pte_tagged(pte) || is_swap_pte(READ_ONCE(*ptep))))
> 		mte_sync_tags(ptep, pte);
> 
> We can even change mte_sync_tags() to take the old pte directly:
> 
> 	if (system_supports_mte() && pte_present(pte) && !pte_special(pte)) {
> 		pte_t old_pte = READ_ONCE(*ptep);
> 		if (pte_tagged(pte) || is_swap_pte(old_pte))
> 			mte_sync_tags(old_pte, pte);
> 	}
> 
> It would save a function call in most cases where the page is not
> tagged.
> 

Yes that looks like a good optimisation - although you've missed the
pte_access_permitted() part of the check ;) The problem I hit is one of
include dependencies:

is_swap_pte() is defined (as a static inline) in
include/linux/swapops.h. However the definition depends on
pte_none()/pte_present() which are defined in pgtable.h - so there's a
circular dependency.

Open coding is_swap_pte() in set_pte_at() works, but it's a bit ugly.
Any ideas on how to improve on the below?

	if (system_supports_mte() && pte_present(pte) &&
	    pte_access_permitted(pte, false) && !pte_special(pte)) {
		pte_t old_pte = READ_ONCE(*ptep);
		/*
		 * We only need to synchronise if the new PTE has tags enabled
		 * or if swapping in (in which case another mapping may have
		 * set tags in the past even if this PTE isn't tagged).
		 * (!pte_none() && !pte_present()) is an open coded version of
		 * is_swap_pte()
		 */
		if (pte_tagged(pte) || (!pte_none(pte) && !pte_present(pte)))
			mte_sync_tags(old_pte, pte);
	}

Steve
