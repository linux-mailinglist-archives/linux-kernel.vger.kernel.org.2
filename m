Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6786B44C310
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhKJOi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231969AbhKJOiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:38:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B7076112F;
        Wed, 10 Nov 2021 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636554937;
        bh=6/avLN0ytZ52L76U6lI/X1ZEvbgZ3/HFg27qqtTLmEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=NZQrfXwxS5lTnKpSIrxjxgu3N/GLEAWrc6vRgzMtOy+BYSVEb/GUiYyc0THQtX4RU
         8M1z/1q3MWcZy/VQjT/9cMly7IV/bfccEGSXMPK1uU257zEfaY0sv53xEqhZ1cG5G3
         kWnJQU1vjOVYr0bxkoWYeGYDHNE85NMCKEA/HXCJBsISExtoXhigNSZfC9tHvGz8cr
         ePddbZWoWsNZoVMkP5fXNvjUoWU2JJ9ADjZXI5GH+KhcX633mHuh56SExEeopk920U
         dj0zkAc3LeAWVnYNEdZuG+Zl7tr21NjwxqEf0aVSGtYHAKiQptZnM9gRhMsUZMWLZ2
         +nzTKcSL4S8Pg==
From:   SeongJae Park <sj@kernel.org>
To:     Alex Shi <seakeel@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon: remove damon_lock
Date:   Wed, 10 Nov 2021 14:35:35 +0000
Message-Id: <20211110143535.15809-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJy-AmmOMGEhTLgeUepFCXxBFpEPriAFtj_qKhOxHjq7i6T5mQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 22:04:55 +0800 Alex Shi <seakeel@gmail.com> wrote:

> On Wed, Nov 10, 2021 at 9:41 PM Alex Shi <seakeel@gmail.com> wrote:
> >
> > On Wed, Nov 10, 2021 at 8:40 PM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Thank you for this patch, Alex!
> > >
> > > On Wed, 10 Nov 2021 19:47:21 +0800 alexs@kernel.org wrote:
> > >
> > > > From: Alex Shi <alexs@kernel.org>
> > > >
> > > > Variable nr_running_ctxs guards by damon_lock, but a lock for a int
> > > > variable seems a bit heavy, a atomic_t is enough.
> > >
> > > The lock is not only for protecting nr_running_ctxs, but also for avoiding
> > > different users concurrently executing damon_start(), because that could allow
> > > the users interfering others.
> >
> > That's right. but it could be resolved by atomic too. like the following.

Sure.

> > >
> > > >
> > > > Signed-off-by: Alex Shi <alexs@kernel.org>
> > > > Cc: SeongJae Park <sj@kernel.org>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: linux-mm@kvack.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > ---
> > > >  include/linux/damon.h |  1 -
> > > >  mm/damon/core.c       | 31 +++++--------------------------
> > > >  mm/damon/dbgfs.c      |  8 +++++---
> > > >  3 files changed, 10 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > > index b4d4be3cc987..e5dcc6336ef2 100644
> > > > --- a/include/linux/damon.h
> > > > +++ b/include/linux/damon.h
> > > > @@ -453,7 +453,6 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> > > >               unsigned long min_nr_reg, unsigned long max_nr_reg);
> > > >  int damon_set_schemes(struct damon_ctx *ctx,
> > > >                       struct damos **schemes, ssize_t nr_schemes);
> > > > -int damon_nr_running_ctxs(void);
> > > >
> > > >  int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
> > > >  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > index c381b3c525d0..e821e36d5c10 100644
> > > > --- a/mm/damon/core.c
> > > > +++ b/mm/damon/core.c
> > > [...]
> > > > @@ -437,19 +422,15 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
> > > >       int i;
> > > >       int err = 0;
> > > >
> > > > -     mutex_lock(&damon_lock);
> > > > -     if (nr_running_ctxs) {
> > > > -             mutex_unlock(&damon_lock);
> > > > +     if (atomic_read(&nr_running_ctxs))
> >
> > if (atomic_inc_not_zero(&nr_running_ctxs))
> 
> Ops, my fault. The following should be right?
> 
> Thanks
> 
> int a = 0;
> if (!atomic_try_cmpxchg(&nr_running_ctxs, &a, 1))
> > > >               return -EBUSY;
> > > > -     }
> > > >
> > > >       for (i = 0; i < nr_ctxs; i++) {
> > > >               err = __damon_start(ctxs[i]);
> > > >               if (err)
> > > >                       break;
> > > > -             nr_running_ctxs++;
> > > > +             atomic_inc(&nr_running_ctxs);
> > > >       }
> > > > -     mutex_unlock(&damon_lock);
> > > >
> >
> >  atomic_dec(&nr_running_ctxs);
> >
> > Is it save the multiple ctxs issue?

Yes, it would effectively avoid the problem case.  However, I'm unsure how much
performance gain this change is providing, as apparently the lock is not being
used in performance critical parts.

I'm also unsure if this change is reducing the complexity of the code or not.
For an example, this change allows someone to show non-zero nr_running_ctxs
while no real kdamond is running, before __damon_start() is called, or when it
failed.  I think this would never be a real issue, but might make my poor brain
a little bit confused when debugging.

Also, we might add some more variables and code section that should be mutually
exclusive to concurrent DAMON users in future.

atomic_t is obviously enough for protecting a variable.  But, IMHO, it might
not necessarily be the best choice for non-performance-critical mutex sections.

Please feel free to let me know if I'm missing something.


Thanks,
SJ

> >
> > Thanks
> >
> > > >       return err;
> > > >  }
> > >
> > > This would let multiple concurrent threads seeing nr_running_ctxs of zero and
> > > therefore proceed together.
> > >
> > >
> > > Thanks,
> > > SJ
> 
