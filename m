Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE813E0393
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhHDOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbhHDOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:43:04 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C742C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 07:42:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l4so2867375ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epkSZNOyyPNAWPQz+jmngcd1GrS/+wWE4RVIUtrB7vM=;
        b=S4cBM6DpryzJ0dCWjdd4PwjY0cPQgQET23yLihuRJ9AyMfKWHeL+VbFZt+9zkGmt0m
         WzzcB1kb8eF6do2K5Jir9StwEMXk7WITNQiTl4gEmrSYkI0BotdknWsfgKJj+1fJnJf2
         neWVuI/A9qzqPOzZ7YT8RH8kB7+bKNwjt1bYT8Gn5zRvNl2k6TrPgzmUhhtoxTj2Oyzv
         X2Xj1eY0ZFkNxWN9X1RMtU4dJUREUpEmbVVU9kRJHCIAkvA5dSEVYHfoUL5bC9kM650F
         0y8JejK6927mdMM2YZkEHTnnyERfsexGghvgU24BYpVhaCR1Mk6bwWvnmAqhMGOaEnho
         /QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epkSZNOyyPNAWPQz+jmngcd1GrS/+wWE4RVIUtrB7vM=;
        b=Ldwxi+jqpdcVb87osteLp4wUlPSlAfqrjkq7mJY3gBIx0E3qjL1QVxbcogm0pY9NMh
         GVJrTXOupC0g2JoWvsX0S9iXIgqBbkfc9IzVn6mYqxfvqQ8UxIFCSDHy354qGbytrQRi
         H9Zx1U2ARQNlDJp8FNcljX0PIoxIgcUqOJLhJY+E9ZHUihCNhdhzUo2VyPOQx/yg6Fi8
         VAlvD6lEZmPVIBcldSE7Pp9LuG5dElqo9HDL3PytXpbkJBfDME7QXx9ZJVfKQZcrJ62M
         wQZuvpxdMv+BAzLx/hJqsoLM57YwLuEt0gvm1LwP+E7KovslyPwMwFDq8yzTOrFNRAZM
         pbAA==
X-Gm-Message-State: AOAM531fET8q+wYXHK86Sm0eB9uogf4tLkX56G/6LZ9ECg9PBM4E+l8t
        Tvl48luIt9RU3bGseNgudzPVFMWKtPZErPjTRRBTKg==
X-Google-Smtp-Source: ABdhPJyoi1uyaThbAN9PmOfRK/CqCAX1nXZFV8Reju/RQckBL2bo3ds1H0EXbeX+qhFdou5j8BYdO8qJXAHX//s4qr8=
X-Received: by 2002:a2e:a817:: with SMTP id l23mr18320916ljq.86.1628088169741;
 Wed, 04 Aug 2021 07:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210731175341.3458608-1-lrizzo@google.com> <20210803160803.GG543798@ziepe.ca>
 <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com> <20210803230725.ao3i2emejyyor36n@revolver>
In-Reply-To: <20210803230725.ao3i2emejyyor36n@revolver>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 4 Aug 2021 16:42:23 +0200
Message-ID: <CAG48ez2TEP0hsRjLACVmRppMEk6Z9aREcGL498EKhdBBXSRsoA@mail.gmail.com>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Luigi Rizzo <lrizzo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 1:07 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> * Luigi Rizzo <lrizzo@google.com> [210803 17:49]:
> > On Tue, Aug 3, 2021 at 6:08 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Sat, Jul 31, 2021 at 10:53:41AM -0700, Luigi Rizzo wrote:
> > > > find_vma() and variants need protection when used.
> > > > This patch adds mmap_assert_lock() calls in the functions.
> > > >
> > > > To make sure the invariant is satisfied, we also need to add a
> > > > mmap_read_loc() around the get_user_pages_remote() call in
> > > > get_arg_page(). The lock is not strictly necessary because the mm
> > > > has been newly created, but the extra cost is limited because
> > > > the same mutex was also acquired shortly before in __bprm_mm_init(),
> > > > so it is hot and uncontended.
> > > >
> > > > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> > > >  fs/exec.c | 2 ++
> > > >  mm/mmap.c | 2 ++
> > > >  2 files changed, 4 insertions(+)
> > > >
> > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > index 38f63451b928..ac7603e985b4 100644
> > > > +++ b/fs/exec.c
> > > > @@ -217,8 +217,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
> > > >        * We are doing an exec().  'current' is the process
> > > >        * doing the exec and bprm->mm is the new process's mm.
> > > >        */
> > > > +     mmap_read_lock(bprm->mm);
> > > >       ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
> > > >                       &page, NULL, NULL);
> > > > +     mmap_read_unlock(bprm->mm);
> > > >       if (ret <= 0)
> > > >               return NULL;
> > >
> > > Wasn't Jann Horn working on something like this too?
> > >
> > > https://lore.kernel.org/linux-mm/20201016225713.1971256-1-jannh@google.com/
> > >
> > > IIRC it was very tricky here, are you sure it is OK to obtain this lock
> > > here?
> >
> > I cannot comment on Jann's patch series but no other thread knows
> > about this mm at this point in the code so the lock is definitely
> > safe to acquire (shortly before there was also a write lock acquired
> > on the same mm, in the same conditions).
>
> If there is no other code that knows about this mm, then does one need
> the lock at all?  Is this just to satisfy the new check you added?
>
> If you want to make this change, I would suggest writing it in a way to
> ensure the call to expand_downwards() in the same function also holds
> the lock.  I believe this is technically required as well?  What do you
> think?

The call to expand_downwards() takes a VMA pointer as argument, and
the mmap lock is the only thing that normally prevents concurrent
freeing of VMA structs. Taking a lock there would be of limited utility - either
the lock is not necessary because nobody else can access the MM, or
the lock is insufficient because someone could have freed the VMA
pointer before the lock was taken. So I think that taking a lock
around the expand_downwards() call would just be obfuscating things,
unless you specifically want to prevent concurrent *reads* while
concurrent *writes* are impossible.

Since I haven't sent a new version of my old series for almost a year,
I think it'd be fine to take Luigi's patch for now, and undo it at a
later point when/if we want to actually use proper locking here
because we're worried about concurrent access to the MM.
