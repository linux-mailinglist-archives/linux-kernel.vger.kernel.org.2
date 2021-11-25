Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B089545D4E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347916AbhKYGqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:46:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:25346 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244527AbhKYGoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:44:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="234185198"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="234185198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 22:37:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="457738597"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.50])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 22:36:57 -0800
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
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mm/rmap: fix potential batched TLB flush race
In-Reply-To: <CANpmjNOiOp4bx7_=gGLHm24dA3LXUXaiveH9VL2thi=cODNtBA@mail.gmail.com>
        (Marco Elver's message of "Wed, 24 Nov 2021 09:49:57 +0100")
References: <20211123074344.1877731-1-ying.huang@intel.com>
        <CANpmjNPGkQ2VWmHjt==yWVr5webCHuRQtXau95jvPjR4Z3gxDw@mail.gmail.com>
        <8735nm9vkw.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CANpmjNP7-FdwLRg9HS=Sd_7nA483Qc3XLJt-h-NgV3jtwBRW7A@mail.gmail.com>
        <87v90i6j4h.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CANpmjNOiOp4bx7_=gGLHm24dA3LXUXaiveH9VL2thi=cODNtBA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Thu, 25 Nov 2021 14:36:49 +0800
Message-ID: <87pmqoaghq.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Wed, 24 Nov 2021 at 09:41, Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Marco Elver <elver@google.com> writes:
>>
>> > On Wed, 24 Nov 2021 at 02:44, Huang, Ying <ying.huang@intel.com> wrote:
>> >>
>> >> Marco Elver <elver@google.com> writes:
>> >>
>> >> > On Tue, 23 Nov 2021 at 08:44, Huang Ying <ying.huang@intel.com> wrote:
>> > [...]
>> >> >> --- a/mm/rmap.c
>> >> >> +++ b/mm/rmap.c
>> >> >> @@ -633,7 +633,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>> >> >>          * before the PTE is cleared.
>> >> >>          */
>> >> >>         barrier();
>> >> >> -       mm->tlb_flush_batched = true;
>> >> >> +       atomic_inc(&mm->tlb_flush_batched);
>> >> >
>> >> > The use of barrier() and atomic needs some clarification.
>> >>
>> >> There are some comments above barrier() to describe why it is needed.
>> >> For atomic, because the type of mm->tlb_flush_batched is atomic_t, do we
>> >> need extra clarification?
>> >
>> > Apologies, maybe I wasn't clear enough: the existing comment tells me
>> > the clearing of PTE should never happen after tlb_flush_batched is
>> > set, but only the compiler is considered. However, I become suspicious
>> > when I see barrier() paired with an atomic. barrier() is purely a
>> > compiler-barrier and does not prevent the CPU from reordering things.
>> > atomic_inc() does not return anything and is therefore unordered per
>> > Documentation/atomic_t.txt.
>> >
>> >> > Is there a
>> >> > requirement that the CPU also doesn't reorder anything after this
>> >> > atomic_inc() (which is unordered)? I.e. should this be
>> >> > atomic_inc_return_release() and remove barrier()?
>> >>
>> >> We don't have an atomic_xx_acquire() to pair with this.  So I guess we
>> >> don't need atomic_inc_return_release()?
>> >
>> > You have 2 things stronger than unordered: atomic_read() which result
>> > is used in a conditional branch, thus creating a control-dependency
>> > ordering later dependent writes; and the atomic_cmpxchg() is fully
>> > ordered.
>> >
>> > But before all that, I'd still want to understand what ordering
>> > requirements you have. The current comments say only the compiler
>> > needs taming, but does that mean we're fine with the CPU wildly
>> > reordering things?
>>
>> Per my understanding, atomic_cmpxchg() is fully ordered, so we have
>> strong ordering in flush_tlb_batched_pending().  And we use xchg() in
>> ptep_get_and_clear() (at least for x86) which is called before
>> set_tlb_ubc_flush_pending().  So we have strong ordering there too.
>>
>> So at least for x86, barrier() in set_tlb_ubc_flush_pending() appears
>> unnecessary.  Is it needed by other architectures?
>
> Hmm, this is not arch/ code -- this code needs to be portable.
> atomic_t accessors provide arch-independent guarantees. But do the
> other operations here provide any guarantees? If they don't, then I
> think we have to assume unordered.

Yes.  The analysis is for x86 only.  For other architectures, we need to
make sure the order of ptep_get_and_clear().

But anyway, that should be another patch.  This patch doesn't make the
original ordering weaker.

Best Regards,
Huang, Ying
