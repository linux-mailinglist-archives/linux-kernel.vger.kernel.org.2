Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F142A45B6D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhKXIsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:48:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:57877 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232817AbhKXIsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:48:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="298640206"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="298640206"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 00:41:24 -0800
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="509792101"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 00:41:20 -0800
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
        <8735nm9vkw.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CANpmjNP7-FdwLRg9HS=Sd_7nA483Qc3XLJt-h-NgV3jtwBRW7A@mail.gmail.com>
Date:   Wed, 24 Nov 2021 16:41:18 +0800
In-Reply-To: <CANpmjNP7-FdwLRg9HS=Sd_7nA483Qc3XLJt-h-NgV3jtwBRW7A@mail.gmail.com>
        (Marco Elver's message of "Wed, 24 Nov 2021 09:10:52 +0100")
Message-ID: <87v90i6j4h.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Wed, 24 Nov 2021 at 02:44, Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Marco Elver <elver@google.com> writes:
>>
>> > On Tue, 23 Nov 2021 at 08:44, Huang Ying <ying.huang@intel.com> wrote:
> [...]
>> >> --- a/mm/rmap.c
>> >> +++ b/mm/rmap.c
>> >> @@ -633,7 +633,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>> >>          * before the PTE is cleared.
>> >>          */
>> >>         barrier();
>> >> -       mm->tlb_flush_batched = true;
>> >> +       atomic_inc(&mm->tlb_flush_batched);
>> >
>> > The use of barrier() and atomic needs some clarification.
>>
>> There are some comments above barrier() to describe why it is needed.
>> For atomic, because the type of mm->tlb_flush_batched is atomic_t, do we
>> need extra clarification?
>
> Apologies, maybe I wasn't clear enough: the existing comment tells me
> the clearing of PTE should never happen after tlb_flush_batched is
> set, but only the compiler is considered. However, I become suspicious
> when I see barrier() paired with an atomic. barrier() is purely a
> compiler-barrier and does not prevent the CPU from reordering things.
> atomic_inc() does not return anything and is therefore unordered per
> Documentation/atomic_t.txt.
>
>> > Is there a
>> > requirement that the CPU also doesn't reorder anything after this
>> > atomic_inc() (which is unordered)? I.e. should this be
>> > atomic_inc_return_release() and remove barrier()?
>>
>> We don't have an atomic_xx_acquire() to pair with this.  So I guess we
>> don't need atomic_inc_return_release()?
>
> You have 2 things stronger than unordered: atomic_read() which result
> is used in a conditional branch, thus creating a control-dependency
> ordering later dependent writes; and the atomic_cmpxchg() is fully
> ordered.
>
> But before all that, I'd still want to understand what ordering
> requirements you have. The current comments say only the compiler
> needs taming, but does that mean we're fine with the CPU wildly
> reordering things?

Per my understanding, atomic_cmpxchg() is fully ordered, so we have
strong ordering in flush_tlb_batched_pending().  And we use xchg() in
ptep_get_and_clear() (at least for x86) which is called before
set_tlb_ubc_flush_pending().  So we have strong ordering there too.

So at least for x86, barrier() in set_tlb_ubc_flush_pending() appears
unnecessary.  Is it needed by other architectures?

Best Regards,
Huang, Ying

