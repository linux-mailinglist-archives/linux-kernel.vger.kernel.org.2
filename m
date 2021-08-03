Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFFA3DF713
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhHCVtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHCVtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:49:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05962C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 14:49:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f13so877158edq.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VW+IU9o1VXMz7OQGffphJNbpddNiraQMr89kP0rpdPo=;
        b=NU63CIV/+ui+ZJ4/JqDfg4zBRvhcoiKjbYIzyAplC0UYwS0h8jp6J7eOFkPhIa59gZ
         065oDiAe4+WzH2muwOzfUBmkzcHM4QUpkxXB9EpqoEbc5fQQJH+/p3v+tEpViDzzslYn
         nM7Pkc7azd/3UclwCVdXKqX50xHjIig3NwVOLptGy7W46ZalqyRHC+IL2kUtOKqLYT4G
         tt4uiPYkHXsUcegHPnZDr1qPIzsgn/i4fCHntopxW8ydifCZegsoOrz5EviF8fTyNLJi
         GfTvYkhfhRJj1e0EnT69nLYpxfzbGISVDltRF51HWAvrTHPVbJuRkxXcgrJd1oifUwVE
         4QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VW+IU9o1VXMz7OQGffphJNbpddNiraQMr89kP0rpdPo=;
        b=X80KUnN0BazQWTRZMZfha5Whob86OqLGkRSXhG421kjAB5ABh8UidLeNj9s5sVw26p
         mMQPpo4E84kPunxkmVuHa4ZLH5KzXHDkS9PwyGcN5E1lKIXmwZTzYPaoWL04OI4R2UMI
         fBdvEIiBFJ4Ff5gj9QaHs/eQxwhVNOHpFmM0u+FUsvRYmTlTJESnMH+F5Htfv5g2cioK
         dGQ3RIQW2kH6mZVWZPIyetpWr5ZN2ykWxYcNcj1PCbp26xIiWEu6eAp58qEfv2NUwKNp
         SL9yxT3c5KF1ZPBEueGKwXDcnpcoZZ6VAPx35bBXOh0qNpQAtPn3GTBWp1ImaGPitkmt
         icng==
X-Gm-Message-State: AOAM531P+L/VEIx90Bn8K/m6MAEHnuDyY29iZW3Ldodiyr6LFvdva5Ce
        Yw1K5J7Mg+U7GIBjPY+HlwfvI3olfAqXKzolSM6KCA==
X-Google-Smtp-Source: ABdhPJx5Jr5gF2XSfZ8PK1rDbz9Jq/BxnT+iIg5ZMO0kZ+25Fjhoa6eXpXCH1nCv7fR8ApawJvEGPjFW7T3g4JRqCeA=
X-Received: by 2002:a05:6402:40d4:: with SMTP id z20mr21098304edb.89.1628027337814;
 Tue, 03 Aug 2021 14:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210731175341.3458608-1-lrizzo@google.com> <20210803160803.GG543798@ziepe.ca>
In-Reply-To: <20210803160803.GG543798@ziepe.ca>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Tue, 3 Aug 2021 23:48:46 +0200
Message-ID: <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jann Horn <jannh@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 6:08 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Jul 31, 2021 at 10:53:41AM -0700, Luigi Rizzo wrote:
> > find_vma() and variants need protection when used.
> > This patch adds mmap_assert_lock() calls in the functions.
> >
> > To make sure the invariant is satisfied, we also need to add a
> > mmap_read_loc() around the get_user_pages_remote() call in
> > get_arg_page(). The lock is not strictly necessary because the mm
> > has been newly created, but the extra cost is limited because
> > the same mutex was also acquired shortly before in __bprm_mm_init(),
> > so it is hot and uncontended.
> >
> > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> >  fs/exec.c | 2 ++
> >  mm/mmap.c | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 38f63451b928..ac7603e985b4 100644
> > +++ b/fs/exec.c
> > @@ -217,8 +217,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
> >        * We are doing an exec().  'current' is the process
> >        * doing the exec and bprm->mm is the new process's mm.
> >        */
> > +     mmap_read_lock(bprm->mm);
> >       ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
> >                       &page, NULL, NULL);
> > +     mmap_read_unlock(bprm->mm);
> >       if (ret <= 0)
> >               return NULL;
>
> Wasn't Jann Horn working on something like this too?
>
> https://lore.kernel.org/linux-mm/20201016225713.1971256-1-jannh@google.com/
>
> IIRC it was very tricky here, are you sure it is OK to obtain this lock
> here?

I cannot comment on Jann's patch series but no other thread knows
about this mm at this point in the code so the lock is definitely
safe to acquire (shortly before there was also a write lock acquired
on the same mm, in the same conditions).

cheers
luigi

>
> I would much rather see Jann's complete solution be merged then
> hacking at the exec problem on the side..
>
> Jason
