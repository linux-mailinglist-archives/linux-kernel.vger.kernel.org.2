Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE70C45B645
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbhKXIOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbhKXIOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:14:17 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB872C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:11:07 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bj13so3769322oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvKw+4uCRX/4uwCQX2Rv7jAK+B/Qoqzzykc5QUAQLGE=;
        b=jWE9M7hapRsKCj34BMPPK6ZIej0PWjaFxVdGp7OG3UrhmKqmNjCgRp/++nFG/Np438
         M4iMr/zjizeukPEsd3grqKJFMpzmOjPlaXAQStZ6k6XjTnemx//A9x3qLfiTRUo/cX2M
         8UB60oUW7+0p5iDXn17zH4WP9MzbqwaJ7IsZYJI0PhMOFGfJlWgk3MJZsPSwyqF9ON8e
         zLwLvDG3ClwOjIxP0k2CtK5TMfBX7GZAntdjrltd2ONMVHt9erLxkpuDoZkDHs6RFOWc
         wCGuA+xBwlj/9f7fxVJpeSoBMlH3WJvXvhaOU3pPS4OTvpXnR2g4hz1ZVVFId1qaYBZm
         MS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvKw+4uCRX/4uwCQX2Rv7jAK+B/Qoqzzykc5QUAQLGE=;
        b=IHk2I9uSBG9EEkvI2w6IfBBrQMMymbQeiGctEGebMYpjP0EA8uOYSqdYfXoYUUiN7Z
         nIPzShOf4nKJVjWw7EQE6fumskN9GYuI6bKoqZszRDlk/EMo4QCAkMeeU1TRv8svhvni
         ibYIm3+Ux8sSE//rVDpKdNacXveV3NtY6J9ZquqyTAtgAvYxaR454cTOKV1kymDNbSbm
         ESHQFFWWz4Tkhj3mD1xsECtgI162O2DYqTZ3Y8uzwa82beVmOFnb/Dv+eu9TZSC4xQz0
         pVlhW+DpQn/4AFM1Vp8q5DrplcdGYXMrjeZhi1uEqdSR1i5e5qeWRm0ETy6IYLmJ0jFL
         6G2A==
X-Gm-Message-State: AOAM531ZVd2NXOdrHZw/BZYlWuCveaHEpAUy3BiAkqgPOTWsMohdnOqT
        +Qa0OmcGQMwqTd82Da8xD+XCj4ihjbKcksfeNSWbgg==
X-Google-Smtp-Source: ABdhPJy16LKy2oR5ZI3qlmMzlo3Re+794b3SdRxsHeQqH1FxX1XuMRfE0WkEp8k2FcXUXzOltRgMsXY+7CvdPqCbvRI=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr3781817oil.65.1637741467089;
 Wed, 24 Nov 2021 00:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20211123074344.1877731-1-ying.huang@intel.com>
 <CANpmjNPGkQ2VWmHjt==yWVr5webCHuRQtXau95jvPjR4Z3gxDw@mail.gmail.com> <8735nm9vkw.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8735nm9vkw.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 24 Nov 2021 09:10:52 +0100
Message-ID: <CANpmjNP7-FdwLRg9HS=Sd_7nA483Qc3XLJt-h-NgV3jtwBRW7A@mail.gmail.com>
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
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 02:44, Huang, Ying <ying.huang@intel.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > On Tue, 23 Nov 2021 at 08:44, Huang Ying <ying.huang@intel.com> wrote:
[...]
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -633,7 +633,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
> >>          * before the PTE is cleared.
> >>          */
> >>         barrier();
> >> -       mm->tlb_flush_batched = true;
> >> +       atomic_inc(&mm->tlb_flush_batched);
> >
> > The use of barrier() and atomic needs some clarification.
>
> There are some comments above barrier() to describe why it is needed.
> For atomic, because the type of mm->tlb_flush_batched is atomic_t, do we
> need extra clarification?

Apologies, maybe I wasn't clear enough: the existing comment tells me
the clearing of PTE should never happen after tlb_flush_batched is
set, but only the compiler is considered. However, I become suspicious
when I see barrier() paired with an atomic. barrier() is purely a
compiler-barrier and does not prevent the CPU from reordering things.
atomic_inc() does not return anything and is therefore unordered per
Documentation/atomic_t.txt.

> > Is there a
> > requirement that the CPU also doesn't reorder anything after this
> > atomic_inc() (which is unordered)? I.e. should this be
> > atomic_inc_return_release() and remove barrier()?
>
> We don't have an atomic_xx_acquire() to pair with this.  So I guess we
> don't need atomic_inc_return_release()?

You have 2 things stronger than unordered: atomic_read() which result
is used in a conditional branch, thus creating a control-dependency
ordering later dependent writes; and the atomic_cmpxchg() is fully
ordered.

But before all that, I'd still want to understand what ordering
requirements you have. The current comments say only the compiler
needs taming, but does that mean we're fine with the CPU wildly
reordering things?

Thanks,
-- Marco
