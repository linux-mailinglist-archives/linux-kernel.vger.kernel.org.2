Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09145B6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhKXIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbhKXIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:53:19 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:50:10 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id o4so3901917oia.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMhR1ewFe9Zq+4nwASM51W9QtAUxF6d/M/r40CrqRYE=;
        b=ZAv2GLdlNXcFIZR9wSCcLXdfGNT8pzMt1fjwZVa7oZWrUGE78jw9BxgHx6v6b2QDWF
         x79O6ORKV4EaE6CNOuu8eWrOTc9No3f8nQKEmY81VUBCOJTUkhJzsJtgukBLIFNKK1SD
         e9PvL37mNw1uMTWHfaS11uu4O96hKWo0uTbF4bELP2Ki3/hFAYvxjEixm3rFNfpnUQGL
         RdJotnrClSH64EyM5gMD5yf5V5M+Zw8rAtQiULdGMwEJsbzQkZQ49Fba0a1PfXgrXToY
         3pThY1+mX0kV3kcZa/7BTkFGZZ6d71Jp8Eq/KtYjlmsd/8Bya1pLmSrSO/jehRUUSyTD
         Dhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMhR1ewFe9Zq+4nwASM51W9QtAUxF6d/M/r40CrqRYE=;
        b=qfrmYqncQ/dGYgIJt6p4yt5Y6rl4t0iEYQVasyRrSRtYZVZR2WoUXMfIHiwbCdhA1i
         B2YTFEcVZgnbKVKj23oJ1brYVZpHdoXMv26mPko4xlt6vqWZQ1zhXbpteTifZ5XdSsWK
         mFQXtP7Djf83aBTVQpmk7Vv35dDe5dABLoFBCa1mojNtGrUYoHDPJc3GwnMI9d/CgqEK
         7euVn7a/4gjCL7CitryFsPXYAjFtF68KVLVqwQOb5t8yK1U4W9zAECaOTxUqnx++sXlH
         oop0JoHg97B/h5dmpY3tD0PhVGlhPInmo3UTPVA8edBkUopIqh5qQUr5X1f+2xf8EYqF
         e0rg==
X-Gm-Message-State: AOAM533CBYsLjI8Uba606o5zMgTYFkO7JAr7vaP2ZTiI0Km8MZyDJr/Q
        Bdfe9Q9gQpSd1+48kyTaEljrKZ4Pgbx9l7uDjN3yKQ==
X-Google-Smtp-Source: ABdhPJx4pIxNjY2VyzhhRpa+E5XN4oTCL7BLPXAggYif6f0Y7VFolS6Yuajx7PsQc042ho92++New+Br60Ty0BVmYp4=
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr4264838oib.7.1637743809956;
 Wed, 24 Nov 2021 00:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20211123074344.1877731-1-ying.huang@intel.com>
 <CANpmjNPGkQ2VWmHjt==yWVr5webCHuRQtXau95jvPjR4Z3gxDw@mail.gmail.com>
 <8735nm9vkw.fsf@yhuang6-desk2.ccr.corp.intel.com> <CANpmjNP7-FdwLRg9HS=Sd_7nA483Qc3XLJt-h-NgV3jtwBRW7A@mail.gmail.com>
 <87v90i6j4h.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v90i6j4h.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 24 Nov 2021 09:49:57 +0100
Message-ID: <CANpmjNOiOp4bx7_=gGLHm24dA3LXUXaiveH9VL2thi=cODNtBA@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: fix potential batched TLB flush race
To:     "Huang, Ying" <ying.huang@intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 09:41, Huang, Ying <ying.huang@intel.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > On Wed, 24 Nov 2021 at 02:44, Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Marco Elver <elver@google.com> writes:
> >>
> >> > On Tue, 23 Nov 2021 at 08:44, Huang Ying <ying.huang@intel.com> wrote:
> > [...]
> >> >> --- a/mm/rmap.c
> >> >> +++ b/mm/rmap.c
> >> >> @@ -633,7 +633,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
> >> >>          * before the PTE is cleared.
> >> >>          */
> >> >>         barrier();
> >> >> -       mm->tlb_flush_batched = true;
> >> >> +       atomic_inc(&mm->tlb_flush_batched);
> >> >
> >> > The use of barrier() and atomic needs some clarification.
> >>
> >> There are some comments above barrier() to describe why it is needed.
> >> For atomic, because the type of mm->tlb_flush_batched is atomic_t, do we
> >> need extra clarification?
> >
> > Apologies, maybe I wasn't clear enough: the existing comment tells me
> > the clearing of PTE should never happen after tlb_flush_batched is
> > set, but only the compiler is considered. However, I become suspicious
> > when I see barrier() paired with an atomic. barrier() is purely a
> > compiler-barrier and does not prevent the CPU from reordering things.
> > atomic_inc() does not return anything and is therefore unordered per
> > Documentation/atomic_t.txt.
> >
> >> > Is there a
> >> > requirement that the CPU also doesn't reorder anything after this
> >> > atomic_inc() (which is unordered)? I.e. should this be
> >> > atomic_inc_return_release() and remove barrier()?
> >>
> >> We don't have an atomic_xx_acquire() to pair with this.  So I guess we
> >> don't need atomic_inc_return_release()?
> >
> > You have 2 things stronger than unordered: atomic_read() which result
> > is used in a conditional branch, thus creating a control-dependency
> > ordering later dependent writes; and the atomic_cmpxchg() is fully
> > ordered.
> >
> > But before all that, I'd still want to understand what ordering
> > requirements you have. The current comments say only the compiler
> > needs taming, but does that mean we're fine with the CPU wildly
> > reordering things?
>
> Per my understanding, atomic_cmpxchg() is fully ordered, so we have
> strong ordering in flush_tlb_batched_pending().  And we use xchg() in
> ptep_get_and_clear() (at least for x86) which is called before
> set_tlb_ubc_flush_pending().  So we have strong ordering there too.
>
> So at least for x86, barrier() in set_tlb_ubc_flush_pending() appears
> unnecessary.  Is it needed by other architectures?

Hmm, this is not arch/ code -- this code needs to be portable.
atomic_t accessors provide arch-independent guarantees. But do the
other operations here provide any guarantees? If they don't, then I
think we have to assume unordered.
