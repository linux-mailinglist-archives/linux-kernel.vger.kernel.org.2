Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999853A2DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFJOJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJOJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:09:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41E97613C0;
        Thu, 10 Jun 2021 14:07:55 +0000 (UTC)
Date:   Thu, 10 Jun 2021 15:07:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
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
Subject: Re: [PATCH v14 1/8] arm64: mte: Handle race when synchronising tags
Message-ID: <20210610140750.GA31534@arm.com>
References: <20210607110816.25762-1-steven.price@arm.com>
 <20210607110816.25762-2-steven.price@arm.com>
 <875yynz5wp.wl-maz@kernel.org>
 <e65943cb-9643-c973-9626-ebf56723ea14@arm.com>
 <874ke7z3ng.wl-maz@kernel.org>
 <20210609174117.GA18459@arm.com>
 <3e0757db-d93d-8554-4167-1c6853f3ae87@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e0757db-d93d-8554-4167-1c6853f3ae87@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 09:05:18AM +0100, Steven Price wrote:
> On 09/06/2021 18:41, Catalin Marinas wrote:
> > On Wed, Jun 09, 2021 at 12:19:31PM +0100, Marc Zyngier wrote:
> >> On Wed, 09 Jun 2021 11:51:34 +0100,
> >> Steven Price <steven.price@arm.com> wrote:
> >>> On 09/06/2021 11:30, Marc Zyngier wrote:
> >>>> On Mon, 07 Jun 2021 12:08:09 +0100,
> >>>> Steven Price <steven.price@arm.com> wrote:
> >>>>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> >>>>> index 125a10e413e9..a3583a7fd400 100644
> >>>>> --- a/arch/arm64/kernel/mte.c
> >>>>> +++ b/arch/arm64/kernel/mte.c
> >>>>> @@ -25,6 +25,7 @@
> >>>>>  u64 gcr_kernel_excl __ro_after_init;
> >>>>>  
> >>>>>  static bool report_fault_once = true;
> >>>>> +static DEFINE_SPINLOCK(tag_sync_lock);
> >>>>>  
> >>>>>  #ifdef CONFIG_KASAN_HW_TAGS
> >>>>>  /* Whether the MTE asynchronous mode is enabled. */
> >>>>> @@ -34,13 +35,22 @@ EXPORT_SYMBOL_GPL(mte_async_mode);
> >>>>>  
> >>>>>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
> >>>>>  {
> >>>>> +	unsigned long flags;
> >>>>>  	pte_t old_pte = READ_ONCE(*ptep);
> >>>>>  
> >>>>> +	spin_lock_irqsave(&tag_sync_lock, flags);
> >>>>
> >>>> having though a bit more about this after an offline discussion with
> >>>> Catalin: why can't this lock be made per mm? We can't really share
> >>>> tags across processes anyway, so this is limited to threads from the
> >>>> same process.
> >>>
> >>> Currently there's nothing stopping processes sharing tags (mmap(...,
> >>> PROT_MTE, MAP_SHARED)) - I agree making use of this is tricky and it
> >>> would have been nice if this had just been prevented from the
> >>> beginning.
> >>
> >> I don't think it should be prevented. I think it should be made clear
> >> that it is unreliable and that it will result in tag corruption.
> >>
> >>> Given the above, clearly the lock can't be per mm and robust.
> >>
> >> I don't think we need to make it robust. The architecture actively
> >> prevents sharing if the tags are also shared, just like we can't
> >> really expect the VMM to share tags with the guest.
[...]
> > So, AFAICT, MAP_SHARED between two different mms is the only problem
> > (both for stage 1 and stage 2), hence the big lock that Steven
> > introduced. I don't like the lock either but we couldn't come up with a
> > better solution.
[...]
> > Other suggestions are welcomed, including banning MAP_SHARED with
> > PROT_MTE.
> 
> The finer grained locking could also be done using a table of spin_locks
> and hashing the struct page pointer to choose a lock. This is what
> page_waitqueue() does - but unlike the existing mechanism we need
> spinlocks not wait queues.

That's an option indeed.

> >>> I guess we could have a per-mm lock and handle the race if user space
> >>> screws up with the outcome being lost tags (double clear).
> >>>
> >>> But it feels to me like it could come back to bite in the future since
> >>> VM_SHARED|VM_MTE will almost always work and I fear someone will start
> >>> using it since it's permitted by the kernel.
> >>
> >> I'm really worried that performance is going to suck even on a small
> >> system, and this global lock will be heavily contended, even without
> >> considering KVM.
> > 
> > I agree, as it currently stands, enabling MTE in the guest will always
> > serialise user_mem_abort() through a big lock shared by all VMs.
> 
> We only serialise in the case where PG_mte_tagged isn't set. Admittedly
> this is likely to be VM startup which I know tends to be an important
> use case. One other option there would be to provide a mechanism to the
> VMM to proactively clear the tags (e.g. a new VM_MTE_INIT flag which
> causes the PG_mte_tagged bit to be set but doesn't affect user space's
> PTEs).
> 
> The problem I've got is without real hardware to benchmark on it's
> impossible to know how big of a performance problem this is and
> therefore which of the available options (if any) is appropriate. Some
> like the "big hammer" of scrapping PG_mte_tagged could hit the
> performance of non-MTE paths - but equally might not have any affect and
> would simplify the code.

One reason to keep PG_mte_tagged around for normal user programs,
especially those not using MTE, is that it doesn't affect CoW. Page
copying in two separate loops (for data and tags) does affect
performance. Now, if there's no fork, you may not notice but in the
Android land with zygote, I think it will be quickly observed.

For KVM, I guess we could benchmark a dummy lock array without any MTE
hardware but I don't have a setup around where I can time multiple VMs
starting in parallel.

> My belief is that this series is now at the stage where it is
> functionally correct and it doesn't impact the performance when MTE
> isn't in use, so no impact to existing systems or MTE-enabled systems
> where user space/VMs are not using MTE.

I agree.

> We also have a number of ideas
> to investigate if/when we see performance problems with the MTE use
> cases. I'm not sure what else we can do until hardware for benchmarking
> is readily available.

My concern is that when we hit a bottleneck on that big lock (and I'm
pretty sure we will), do we have a good mitigation or we should rather
break the ABI now and disallow MAP_SHARED? The latter would need to be
done fairly soon as a fix, backported.

I think the possible workarounds are pretty good but maybe we should
also ask user-space people how important MAP_SHARED + PROT_MTE is. If
they don't use it, maybe we shouldn't bother with all this (well,
assuming there's no other race between different mms that we missed).

-- 
Catalin
