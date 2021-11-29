Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB2D460ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 07:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353355AbhK2GpH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 01:45:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:33397 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239677AbhK2GnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 01:43:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="222790278"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="222790278"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 22:39:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="511556524"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.50])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 22:39:46 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH -V2] mm/rmap: fix potential batched TLB flush race
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 29 Nov 2021 14:39:40 +0800
Message-ID: <87ilwbv51v.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <namit@vmware.com> writes:

>> On Nov 24, 2021, at 10:50 PM, Huang Ying <ying.huang@intel.com> wrote:
>> 
>> In theory, the following race is possible for batched TLB flushing.
>> 
>> CPU0                               CPU1
>> ----                               ----
>> shrink_page_list()
>>                                   unmap
>>                                     zap_pte_range()
>>                                       flush_tlb_batched_pending()
>>                                         flush_tlb_mm()
>>  try_to_unmap()
>>    set_tlb_ubc_flush_pending()
>>      mm->tlb_flush_batched = true
>>                                         mm->tlb_flush_batched = false
>> 
>> After the TLB is flushed on CPU1 via flush_tlb_mm() and before
>> mm->tlb_flush_batched is set to false, some PTE is unmapped on CPU0
>> and the TLB flushing is pended.  Then the pended TLB flushing will be
>> lost.  Although both set_tlb_ubc_flush_pending() and
>> flush_tlb_batched_pending() are called with PTL locked, different PTL
>> instances may be used.
>> 
>> Because the race window is really small, and the lost TLB flushing
>> will cause problem only if a TLB entry is inserted before the
>> unmapping in the race window, the race is only theoretical.  But the
>> fix is simple and cheap too.
>> 
>> Syzbot has reported this too as follows,
>> 
>> ==================================================================
>> BUG: KCSAN: data-race in flush_tlb_batched_pending / try_to_unmap_one
>> 
>> write to 0xffff8881072cfbbc of 1 bytes by task 17406 on cpu 1:
>> flush_tlb_batched_pending+0x5f/0x80 mm/rmap.c:691
>> madvise_free_pte_range+0xee/0x7d0 mm/madvise.c:594
>> walk_pmd_range mm/pagewalk.c:128 [inline]
>> walk_pud_range mm/pagewalk.c:205 [inline]
>> walk_p4d_range mm/pagewalk.c:240 [inline]
>> walk_pgd_range mm/pagewalk.c:277 [inline]
>> __walk_page_range+0x981/0x1160 mm/pagewalk.c:379
>> walk_page_range+0x131/0x300 mm/pagewalk.c:475
>> madvise_free_single_vma mm/madvise.c:734 [inline]
>> madvise_dontneed_free mm/madvise.c:822 [inline]
>> madvise_vma mm/madvise.c:996 [inline]
>> do_madvise+0xe4a/0x1140 mm/madvise.c:1202
>> __do_sys_madvise mm/madvise.c:1228 [inline]
>> __se_sys_madvise mm/madvise.c:1226 [inline]
>> __x64_sys_madvise+0x5d/0x70 mm/madvise.c:1226
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>> 
>> write to 0xffff8881072cfbbc of 1 bytes by task 71 on cpu 0:
>> set_tlb_ubc_flush_pending mm/rmap.c:636 [inline]
>> try_to_unmap_one+0x60e/0x1220 mm/rmap.c:1515
>> rmap_walk_anon+0x2fb/0x470 mm/rmap.c:2301
>> try_to_unmap+0xec/0x110
>> shrink_page_list+0xe91/0x2620 mm/vmscan.c:1719
>> shrink_inactive_list+0x3fb/0x730 mm/vmscan.c:2394
>> shrink_list mm/vmscan.c:2621 [inline]
>> shrink_lruvec+0x3c9/0x710 mm/vmscan.c:2940
>> shrink_node_memcgs+0x23e/0x410 mm/vmscan.c:3129
>> shrink_node+0x8f6/0x1190 mm/vmscan.c:3252
>> kswapd_shrink_node mm/vmscan.c:4022 [inline]
>> balance_pgdat+0x702/0xd30 mm/vmscan.c:4213
>> kswapd+0x200/0x340 mm/vmscan.c:4473
>> kthread+0x2c7/0x2e0 kernel/kthread.c:327
>> ret_from_fork+0x1f/0x30
>> 
>> value changed: 0x01 -> 0x00
>> 
>> Reported by Kernel Concurrency Sanitizer on:
>> CPU: 0 PID: 71 Comm: kswapd0 Not tainted 5.16.0-rc1-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> ==================================================================
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Reported-by: syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com
>> Cc: Nadav Amit <namit@vmware.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Marco Elver <elver@google.com>
>> ---
>> include/linux/mm_types.h |  2 +-
>> mm/rmap.c                | 30 +++++++++++++++++++++++-------
>> 2 files changed, 24 insertions(+), 8 deletions(-)
>> 
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index c3a6e6209600..789778067db9 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -632,7 +632,7 @@ struct mm_struct {
>> 		atomic_t tlb_flush_pending;
>> #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>> 		/* See flush_tlb_batched_pending() */
>> -		bool tlb_flush_batched;
>> +		atomic_t tlb_flush_batched;
>> #endif
>> 		struct uprobes_state uprobes_state;
>> #ifdef CONFIG_PREEMPT_RT
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 163ac4e6bcee..2e6b19be5a18 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -621,6 +621,18 @@ void try_to_unmap_flush_dirty(void)
>> 		try_to_unmap_flush();
>> }
>> 
>> +/* The upper 15 bit of mm->tlb_flush_batched records pending flushes */
>
> Why 15? I think it will be easier to swallow if it was 32-bit (which
> correspond to number of PIDs?)
> 
> What would happen on an overflow? If you regarded each pneding/flushed
> counter as a separate atomic, that would have been easier. But anyhow,
> a comment is necessary IMHO.

I want to pack the "pending" and "flush" generations into one atomic_t,
which is 32 bit.  Previously I thought 15-bit is large enough to make
overflow impossible in practice, but after more thought, I found that it
isn't large enough.  So I come up with some solution for overflow and I
will send a new version of patch to show my idea.

Why not 16 bit?  Just want to make it easier to read the code via
avoiding to deal with signed/unsigned.

>
>> +#define TLB_FLUSH_BATCH_PENDING_SHIFT	16
>> +#define TLB_FLUSH_BATCH_COUNT_MASK	0x7f
>
> 0x7f is not 15 bits the last time I checked.

Oops!  My fault!  I will correct this in the new version.

>> +#define TLB_FLUSH_BATCH_PENDING_ONE	(1 << TLB_FLUSH_BATCH_PENDING_SHIFT)
>> +
>> +#define TLB_FLUSH_BATCH_PENDING(cnt)					\
>> +	(((cnt) >> TLB_FLUSH_BATCH_PENDING_SHIFT) & TLB_FLUSH_BATCH_COUNT_MASK)
>> +#define TLB_FLUSH_BATCH_FLUSHED(cnt)					\
>> +	((cnt) & TLB_FLUSH_BATCH_COUNT_MASK)
>> +#define TLB_FLUSH_BATCH_PACK(pending, flushed)				\
>> +	(((pending) << TLB_FLUSH_BATCH_PENDING_SHIFT) | (flushed))
>
> I would have preferred, when possible to avoid such macros. It just makes
> reading the code harder.

Yes.  They are not elegant.  But it's not good to hard code raw numbers too.

>> +
>> static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>> {
>> 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
>> @@ -633,7 +645,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>> 	 * before the PTE is cleared.
>> 	 */
>> 	barrier();
>> -	mm->tlb_flush_batched = true;
>> +	atomic_add(TLB_FLUSH_BATCH_PENDING_ONE, &mm->tlb_flush_batched);
>
> Any reason to put the pending in the top bits instead of the low ones?
> It can at least simplify the code a bit.

In this patch, it is to avoid to make the overflowed bit of "pending"
goes into "flushed".  But I will change the algorithm in the new
version, so this isn't necessary any more.

> As for the barrier, I would
> change it for smp_mb__before_atomic() or smp_wmb(). You want the
> PTE changes and the counter updates to be ordered.

You suggest to convert barrier() to something stricter?  I think it
deserves a separate patch.

>> 
>> 	/*
>> 	 * If the PTE was dirty then it's best to assume it's writable. The
>> @@ -680,15 +692,19 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>>  */
>> void flush_tlb_batched_pending(struct mm_struct *mm)
>> {
>> -	if (data_race(mm->tlb_flush_batched)) {
>> -		flush_tlb_mm(mm);
>
> The previous smp_mb__before_atomic() or smp_wmb() should be matched
> with an smp_mb__before_atomic() or smp_rmb() here, I think.

atomic_cmpxchg() is fully ordered, so we don't need any more ordering
call here.

>> +	int batched = atomic_read(&mm->tlb_flush_batched);
>> +	int pending = TLB_FLUSH_BATCH_PENDING(batched);
>> +	int flushed = TLB_FLUSH_BATCH_FLUSHED(batched);
>
> I would prefer them being unsigned.

atomic_t is signed.  So I think that it may be better to use signed when
possible to avoid possible confusion.

>> 
>> +	if (pending != flushed) {
>> +		flush_tlb_mm(mm);
>> 		/*
>> -		 * Do not allow the compiler to re-order the clearing of
>> -		 * tlb_flush_batched before the tlb is flushed.
>> +		 * If the new TLB flushing is pended during flushing,
>> +		 * leave mm->tlb_flush_batched as is, to avoid to lose
>> +		 * flushing.
>> 		 */
>> -		barrier();
>> -		mm->tlb_flush_batched = false;
>> +		atomic_cmpxchg(&mm->tlb_flush_batched, batched,
>> +			       TLB_FLUSH_BATCH_PACK(pending, pending));
>> 	}
>
> Overall, I am not overly excited about the fact the the mm generation
> and this batching mechanism remain separated. This makes reasoning
> about TLB flushes harder and can lead to unnecessary flushes.
>
> I understand the complexity in changing the code to get there,
> and perhaps your approach is reasonable for now, if you at least
> manage to deal with overflows.
>
> Thanks for doing all of that, sorry for being negative. I guess I 
> suffer from NIH ("not invented here”).

Thanks for your review!

Best Regards,
Huang, Ying
