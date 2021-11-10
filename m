Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FE44C24A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhKJNpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhKJNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:45:23 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7457DC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:42:36 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id c3so2809724iob.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9i7u88nxI1XBqu3jYzX2JrdceQtSyBwNJT6G9SZhlY=;
        b=Qhx7Lyhvm+zRU1KsuMiRU/K7+wVtKexGEM6FqHCHpi2ug/HL0UZzdQNY0cbr91720k
         szZYTkUuZJ3zzq0sV690/b+UohoWPm0PS1XBkDSTAmatpJTvkOIK9Ee7l/9SfIjP+b5F
         MbJb/4YpfSpQclGpuiTDbSHLQqLXFwfYOeV67b1tSNIwgrLa53r3xYQ+byWgmOq34QHa
         6LC5H/e1BMUVr5oja4ZFEpcca9UmZ9azybGDfWLNG01I4zrP5ZoKLkPFK5qh+k13X9KM
         3pNLCFFopYWoR0AQ9GKAKHT0IFDA4sRQMZH0PU2OYVh9zLvwaEf68vkxvbIWsZLQW7tX
         geDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9i7u88nxI1XBqu3jYzX2JrdceQtSyBwNJT6G9SZhlY=;
        b=RcpcHODRetKxC9Zw926gsI9GGrjphHbgy+dH5me7oMw0SxfRFScwNGfG1BEwfKP2oX
         nJTlJ68BoqH5VNaTNm7n5WCUTx/BAxQEMrEXdjlFRNKB6LKO/UubBduWMSkr3rullz0O
         RJMyvaBqWxQdPL77mPOLLFp6TK7RLdSRoEjHKUaUh4ZqE37d//BsbJYHW2QkaoBD9kgv
         TQB3Ci3hbfVbPdEsXtPHjMBvU7QKYDitauJ4axVUiPSNp3ddb4w9f4sKimm+zcl4HeiN
         lar4hFZu/h6v5XKSLiu7NoJCQdCwmSx1cSTE19u9guYhKcgqUgGwFRvJc121pRxEt5Gm
         bVyA==
X-Gm-Message-State: AOAM531365xHjXb23jvPBFxfvPe9w+25ladcXgOUXqABL+6+mVjNxSCy
        GxM/JM5UQ1noRZRykA2ihTFA1uzTGgXa3AI2yzA3cM/BzUQ=
X-Google-Smtp-Source: ABdhPJx8k0gWxSHX2f9sM/iHyLVbZZnH8tCuIN3ZB89nv3YUII+HAv/a3VxYAYdcVzyV+qipzghbdpg2BB8CJFpazlM=
X-Received: by 2002:a05:6638:4087:: with SMTP id m7mr403703jam.112.1636551755951;
 Wed, 10 Nov 2021 05:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20211110114721.133808-1-alexs@kernel.org> <20211110124034.2574-1-sj@kernel.org>
In-Reply-To: <20211110124034.2574-1-sj@kernel.org>
From:   Alex Shi <seakeel@gmail.com>
Date:   Wed, 10 Nov 2021 21:41:59 +0800
Message-ID: <CAJy-Amky9AAap=mAzdae-92GFWzjzCXY20UOTA+L_kvWXMgPnw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/damon: remove damon_lock
To:     SeongJae Park <sj@kernel.org>
Cc:     Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 8:40 PM SeongJae Park <sj@kernel.org> wrote:
>
> Thank you for this patch, Alex!
>
> On Wed, 10 Nov 2021 19:47:21 +0800 alexs@kernel.org wrote:
>
> > From: Alex Shi <alexs@kernel.org>
> >
> > Variable nr_running_ctxs guards by damon_lock, but a lock for a int
> > variable seems a bit heavy, a atomic_t is enough.
>
> The lock is not only for protecting nr_running_ctxs, but also for avoiding
> different users concurrently executing damon_start(), because that could allow
> the users interfering others.

That's right. but it could be resolved by atomic too. like the following.
>
> >
> > Signed-off-by: Alex Shi <alexs@kernel.org>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  include/linux/damon.h |  1 -
> >  mm/damon/core.c       | 31 +++++--------------------------
> >  mm/damon/dbgfs.c      |  8 +++++---
> >  3 files changed, 10 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index b4d4be3cc987..e5dcc6336ef2 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -453,7 +453,6 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> >               unsigned long min_nr_reg, unsigned long max_nr_reg);
> >  int damon_set_schemes(struct damon_ctx *ctx,
> >                       struct damos **schemes, ssize_t nr_schemes);
> > -int damon_nr_running_ctxs(void);
> >
> >  int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
> >  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c381b3c525d0..e821e36d5c10 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [...]
> > @@ -437,19 +422,15 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
> >       int i;
> >       int err = 0;
> >
> > -     mutex_lock(&damon_lock);
> > -     if (nr_running_ctxs) {
> > -             mutex_unlock(&damon_lock);
> > +     if (atomic_read(&nr_running_ctxs))

if (atomic_inc_not_zero(&nr_running_ctxs))
> >               return -EBUSY;
> > -     }
> >
> >       for (i = 0; i < nr_ctxs; i++) {
> >               err = __damon_start(ctxs[i]);
> >               if (err)
> >                       break;
> > -             nr_running_ctxs++;
> > +             atomic_inc(&nr_running_ctxs);
> >       }
> > -     mutex_unlock(&damon_lock);
> >

 atomic_dec(&nr_running_ctxs);

Is it save the multiple ctxs issue?

Thanks

> >       return err;
> >  }
>
> This would let multiple concurrent threads seeing nr_running_ctxs of zero and
> therefore proceed together.
>
>
> Thanks,
> SJ
