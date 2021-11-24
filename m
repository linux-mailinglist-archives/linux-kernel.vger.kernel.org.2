Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5878145B136
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 02:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhKXBrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 20:47:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:64720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234183AbhKXBrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:47:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="222402593"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="222402593"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 17:44:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="509641783"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 17:44:01 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com,
        Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] mm/rmap: fix potential batched TLB flush race
References: <20211123074344.1877731-1-ying.huang@intel.com>
        <CANpmjNPGkQ2VWmHjt==yWVr5webCHuRQtXau95jvPjR4Z3gxDw@mail.gmail.com>
Date:   Wed, 24 Nov 2021 09:43:59 +0800
In-Reply-To: <CANpmjNPGkQ2VWmHjt==yWVr5webCHuRQtXau95jvPjR4Z3gxDw@mail.gmail.com>
        (Marco Elver's message of "Tue, 23 Nov 2021 10:33:41 +0100")
Message-ID: <8735nm9vkw.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Tue, 23 Nov 2021 at 08:44, Huang Ying <ying.huang@intel.com> wrote:
>>
>> In theory, the following race is possible for batched TLB flushing.
>>
>> CPU0                               CPU1
>> ----                               ----
>> shrink_page_list()
>>                                    unmap
>>                                      zap_pte_range()
>>                                        flush_tlb_batched_pending()
>>                                          flush_tlb_mm()
>>   try_to_unmap()
>>     set_tlb_ubc_flush_pending()
>>       mm->tlb_flush_batched = true
>>                                          mm->tlb_flush_batched = false
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
>
> Thanks for fixing this!
>
>> Syzbot has reported this too as follows,
>>
>> ==================================================================
>> BUG: KCSAN: data-race in flush_tlb_batched_pending / try_to_unmap_one
> [...]
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index c3a6e6209600..789778067db9 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -632,7 +632,7 @@ struct mm_struct {
>>                 atomic_t tlb_flush_pending;
>>  #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>>                 /* See flush_tlb_batched_pending() */
>> -               bool tlb_flush_batched;
>> +               atomic_t tlb_flush_batched;
>>  #endif
>>                 struct uprobes_state uprobes_state;
>>  #ifdef CONFIG_PREEMPT_RT
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 163ac4e6bcee..60902c3cfb4a 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -633,7 +633,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>>          * before the PTE is cleared.
>>          */
>>         barrier();
>> -       mm->tlb_flush_batched = true;
>> +       atomic_inc(&mm->tlb_flush_batched);
>
> The use of barrier() and atomic needs some clarification.

There are some comments above barrier() to describe why it is needed.
For atomic, because the type of mm->tlb_flush_batched is atomic_t, do we
need extra clarification?

> Is there a
> requirement that the CPU also doesn't reorder anything after this
> atomic_inc() (which is unordered)? I.e. should this be
> atomic_inc_return_release() and remove barrier()?

We don't have an atomic_xx_acquire() to pair with this.  So I guess we
don't need atomic_inc_return_release()?

Best Regards,
Huang, Ying

>>         /*
>>          * If the PTE was dirty then it's best to assume it's writable. The
>> @@ -680,15 +680,16 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>>   */
>>  void flush_tlb_batched_pending(struct mm_struct *mm)
>>  {
>> -       if (data_race(mm->tlb_flush_batched)) {
>> -               flush_tlb_mm(mm);
>> +       int batched = atomic_read(&mm->tlb_flush_batched);
>>
>> +       if (batched) {
>> +               flush_tlb_mm(mm);
>>                 /*
>> -                * Do not allow the compiler to re-order the clearing of
>> -                * tlb_flush_batched before the tlb is flushed.
>> +                * If the new TLB flushing is pended during flushing,
>> +                * leave mm->tlb_flush_batched as is, to avoid to lose
>> +                * flushing.
>>                  */
>> -               barrier();
>> -               mm->tlb_flush_batched = false;
>> +               atomic_cmpxchg(&mm->tlb_flush_batched, batched, 0);
>>         }
>>  }
>>  #else
>> --
>> 2.30.2
>>
