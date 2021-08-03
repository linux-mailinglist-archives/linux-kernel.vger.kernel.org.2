Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47D3DF8B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhHCX6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhHCX6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:58:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807E2C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:58:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x90so1232392ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHZZMg7dTux+Z0i/Dg0mZ8wPTSufzEow/lzNd5aKgII=;
        b=lS2pf2FOoLcPkgGCvkEtLEM/9DG+hPeghG4h6jEBSwLmzkQxo8ZgFV54B/DlgES3r2
         fzV2D2xQIDQ+eP75tWnFBP5WTldUf3AbkjCY232SzSLMs+NyOdqewL85RyHoajBn/WM0
         6/upOJ02QzwdX02hXwihrkqpmNsaoYPE2/T9DE7wW9Vs7OLM2/Nm5V4YVuvEpfi6uKHT
         TIw5tm0hpi9OH5fn8kYSlAknobo8CoAKADVoDJ3+q7Q4bIScSKI+SmUfRBkWLQkfGSlN
         LeREEIhMWgheTZCZhyXoOatI1yHCm3S5NqTKwsTjxHR2XvZRh5aKY9kdUWG007PORGCL
         P18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHZZMg7dTux+Z0i/Dg0mZ8wPTSufzEow/lzNd5aKgII=;
        b=X/FSvwByBCn4/0rahGBP9aPoD+Q9LVyG5ZPEgDjCZ3WOcBN29qAd8e4BPMHd4ewEQ2
         scuayAYkBAbRlRrfLT6NE78NtaQzYALdKG9zmGy0tyxaLdr1BDht9Cl1ww63IMcWe00r
         M1J9fj72ZFzYZoikTkDuRGV23I7wKS6dq6IYSU4tgKyNnr0rRmDCiauJ07e+W9867KJG
         Gatdf9URpNRdcZqYUy/1xW7r2wCQqOS/RZJIfCs4tVx508kxmEvuitrUuoFiVCcCdh4S
         PNrj09OO9iAiF84y0EuEoJ2/hUUmv/2cvRhLPwxsITwz/te34FDMDkTVaAx6reXBwgCc
         iEmw==
X-Gm-Message-State: AOAM531FBQdM18uITrrRKqIfQJJzqTh1vtze+j9Q90iEME8I+nKr9VP0
        W9gJRDWT7Co0yVE9foWpBZGHbe2okw+BCQrVgKoEQA==
X-Google-Smtp-Source: ABdhPJzW6Sl9104AQe1TikPz2V06k4GI9p6VRrI44rLorYi/V7/mB7jZJtwj8TH2QusD972PA3jytgSSHTeBJVOrZ2g=
X-Received: by 2002:a05:6402:40d4:: with SMTP id z20mr21700623edb.89.1628035079883;
 Tue, 03 Aug 2021 16:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210731175341.3458608-1-lrizzo@google.com> <20210803160803.GG543798@ziepe.ca>
 <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com>
 <20210803230725.ao3i2emejyyor36n@revolver> <20210803233542.GH543798@ziepe.ca>
In-Reply-To: <20210803233542.GH543798@ziepe.ca>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Wed, 4 Aug 2021 01:57:48 +0200
Message-ID: <CAMOZA0Lk_aLSyu8MyY-xxfPafF-U9Zwo85H=qh=yMqPNcZdT=w@mail.gmail.com>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Jann Horn <jannh@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 1:35 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Aug 03, 2021 at 11:07:35PM +0000, Liam Howlett wrote:
> > * Luigi Rizzo <lrizzo@google.com> [210803 17:49]:
> > > On Tue, Aug 3, 2021 at 6:08 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Sat, Jul 31, 2021 at 10:53:41AM -0700, Luigi Rizzo wrote:
> > > > > find_vma() and variants need protection when used.
> > > > > This patch adds mmap_assert_lock() calls in the functions.
> > > > >
> > > > > To make sure the invariant is satisfied, we also need to add a
> > > > > mmap_read_loc() around the get_user_pages_remote() call in
> > > > > get_arg_page(). The lock is not strictly necessary because the mm
> > > > > has been newly created, but the extra cost is limited because
> > > > > the same mutex was also acquired shortly before in __bprm_mm_init(),
> > > > > so it is hot and uncontended.
> > > > >
> > > > > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> > > > >  fs/exec.c | 2 ++
> > > > >  mm/mmap.c | 2 ++
> > > > >  2 files changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > > index 38f63451b928..ac7603e985b4 100644
> > > > > +++ b/fs/exec.c
> > > > > @@ -217,8 +217,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
> > > > >        * We are doing an exec().  'current' is the process
> > > > >        * doing the exec and bprm->mm is the new process's mm.
> > > > >        */
> > > > > +     mmap_read_lock(bprm->mm);
> > > > >       ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
> > > > >                       &page, NULL, NULL);
> > > > > +     mmap_read_unlock(bprm->mm);
> > > > >       if (ret <= 0)
> > > > >               return NULL;
> > > >
> > > > Wasn't Jann Horn working on something like this too?
> > > >
> > > > https://lore.kernel.org/linux-mm/20201016225713.1971256-1-jannh@google.com/
> > > >
> > > > IIRC it was very tricky here, are you sure it is OK to obtain this lock
> > > > here?
> > >
> > > I cannot comment on Jann's patch series but no other thread knows
> > > about this mm at this point in the code so the lock is definitely
> > > safe to acquire (shortly before there was also a write lock acquired
> > > on the same mm, in the same conditions).
> >
> > If there is no other code that knows about this mm, then does one need
> > the lock at all?  Is this just to satisfy the new check you added?
> >
> > If you want to make this change, I would suggest writing it in a way to
> > ensure the call to expand_downwards() in the same function also holds
> > the lock.  I believe this is technically required as well?  What do you
> > think?
>
> This is essentially what Jann was doing. Since the mm is newly created
> we can create it write locked and then we can add proper locking tests
> to many of the functions called along this path.
>
> Adding useless locks around each troublesome callsite just seems
> really confusing to me.

Uhm... by that reasoning, even creating the mm locked (and unlocking
at the end) is equally unnecessary.

My goal was to add asserts and invariants that are easy
to understand and get right, rather than optimize a path
that does not appear to be critical.

Adding one read lock pair around the one function we annotate
is easy to understand and clearly a leaf lock.

Having alloc_bprm return a locked object is a bit unconventional,
and also passing it to other methods raises the question of whether
they take other lock possibly causing lock order reversals
in the future.

cheers
luigi
