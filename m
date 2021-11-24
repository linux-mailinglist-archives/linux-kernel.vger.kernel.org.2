Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F72545B122
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 02:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhKXBaU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Nov 2021 20:30:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:39020 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhKXBaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:30:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="298584680"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="298584680"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 17:27:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="509638387"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 17:27:07 -0800
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
Subject: Re: [PATCH] mm/rmap: fix potential batched TLB flush race
References: <20211123074344.1877731-1-ying.huang@intel.com>
        <797F0409-0BF8-46E8-9165-9B6826365F2C@vmware.com>
Date:   Wed, 24 Nov 2021 09:27:05 +0800
In-Reply-To: <797F0409-0BF8-46E8-9165-9B6826365F2C@vmware.com> (Nadav Amit's
        message of "Tue, 23 Nov 2021 15:28:36 +0000")
Message-ID: <877dcy9wd2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <namit@vmware.com> writes:

>> On Nov 22, 2021, at 11:43 PM, Huang Ying <ying.huang@intel.com> wrote:
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
>> mm/rmap.c                | 15 ++++++++-------
>> 2 files changed, 9 insertions(+), 8 deletions(-)
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
>> index 163ac4e6bcee..60902c3cfb4a 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -633,7 +633,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>> 	 * before the PTE is cleared.
>> 	 */
>> 	barrier();
>> -	mm->tlb_flush_batched = true;
>> +	atomic_inc(&mm->tlb_flush_batched);
>> 
>> 	/*
>> 	 * If the PTE was dirty then it's best to assume it's writable. The
>> @@ -680,15 +680,16 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>>  */
>> void flush_tlb_batched_pending(struct mm_struct *mm)
>> {
>> -	if (data_race(mm->tlb_flush_batched)) {
>> -		flush_tlb_mm(mm);
>> +	int batched = atomic_read(&mm->tlb_flush_batched);
>> 
>> +	if (batched) {
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
>> +		atomic_cmpxchg(&mm->tlb_flush_batched, batched, 0);
>
> This does not seem to prevent a race completely.
>
>   CPU0		CPU1		CPU2
>
>   set_tlb_ubc_flush_pending()
>   [ tlb_flush_batched = 1 ]
>
> 				flush_tlb_batched_pending()
> 				[ batched = 1 ]
> 				 flush_tlb_mm()
> 				 ...
>   flush_tlb_batched_pending()
>   [ tlb_flush_batched = 0 ]
> 				
>
> 		ptep_get_and_clear()
> 		set_tlb_ubc_flush_pending()
> 		[ tlb_flush_batched = 1 ]
> 					
> 					
> 				 ...
> 				 atomic_cmpxchg()
> 				 [ succeeds ]
>
> At the end of this flow tlb_flush_batched is 0 although
> the TLB flush of CPU1’s newly added PTE was not done.
>
> If you go with your approach you need to have two atomic
> counters, one of the flushed “generation” and one of the
> pending “generation”.

Thanks for review.  You are right, the race cannot be eliminated with
this patch completely.  Maybe we can pack two counter into atomic_t to
implement the generation as above.

> Anyhow, I am just mentioning that I think a more fundamental
> solution is appropriate to take into account other flushes
> that might render flush_tlb_batched_pending() flush
> unnecessary.

Best Regards,
Huang, Ying
