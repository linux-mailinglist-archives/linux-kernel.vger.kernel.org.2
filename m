Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B912344C2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhKJOIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhKJOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:08:19 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F188C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:05:32 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id l19so2650443ilk.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxsHJ9CPfPUXafzj9ILVaXG40uWQldX+BLsmuREKlD4=;
        b=cuqigSB+PmaVWANqh1ufUsvsBtPR/cakZYg4Ryv9pwlpNqe4tYir/pOlmGJg88ZWdU
         zf2vvk/iMUr/pO3p+0qtPTCZ4KXIQZy0yXGEBjZPlvhYnAIaZMpTcrpy8PHYD6cd60fm
         ljfrRWpr4JQ7PBbojIUqnHII8G7TJwDTDNYoZjOdMADobSQsRrouY316//LV5/EKcFqT
         zO2KO4gSfiE6W/TtOzYZFkuJpT384gKWRBadqlnpPbsF68MaP6n+p6bQgKuS79XYyDnq
         vD2I3CK4D5wpxyPFjP9J0VGi2WHJw8efqKU/60vDclIRse/gTRDylXPK6FDc0RrxpJj0
         33/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxsHJ9CPfPUXafzj9ILVaXG40uWQldX+BLsmuREKlD4=;
        b=RKUPTDZwGXQHAL5YSN5dEnoiuutKQ2zx6pLw/OzABt/z+iR6FfNjv/WE0riK//KVTZ
         ZUE2uvNsBQkDAQ0LoW+hoaDAivhn3pud+pPNJMosPiJ/bhh5DW43VObXyaOVzY9Sm4Ua
         6IRjHgYmcFLBhSrry1rJb6+Ee+dZyVq7clN1ClTsiNsN5W3tEyHQEwDPGmALH33eesVh
         xeT+yOXQeoQ558LESSdiu0ZJu5CDpaEGD6dClxKFqWd+snLws12Vm/ql7S/zQuV61ANn
         RDRtYJpDRIawxh5dr2r0elg55LlMbcaU0pQS4QRTNcE9ITYQGKBK0IJi96QaCGKNtKZj
         V+tg==
X-Gm-Message-State: AOAM533rDf91g7vJW5KbWsFgw5iUBB6T1OB8DQYHpSX2Jrg3pZOaxSZx
        NxCPTupSzpc0mEslZtL8hOSzJXfQTjQKxlCTlBc=
X-Google-Smtp-Source: ABdhPJzVsSv84CIGT2mAEgaWm5q4XR8tlsSi7poFT7n5oQwCMTb33vjzXe1WtbxpCgSehBxV5qRgXuYp2aPgZwZSGJw=
X-Received: by 2002:a05:6e02:1ca3:: with SMTP id x3mr77970ill.103.1636553131798;
 Wed, 10 Nov 2021 06:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20211110114721.133808-1-alexs@kernel.org> <20211110124034.2574-1-sj@kernel.org>
 <CAJy-Amky9AAap=mAzdae-92GFWzjzCXY20UOTA+L_kvWXMgPnw@mail.gmail.com>
In-Reply-To: <CAJy-Amky9AAap=mAzdae-92GFWzjzCXY20UOTA+L_kvWXMgPnw@mail.gmail.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Wed, 10 Nov 2021 22:04:55 +0800
Message-ID: <CAJy-AmmOMGEhTLgeUepFCXxBFpEPriAFtj_qKhOxHjq7i6T5mQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/damon: remove damon_lock
To:     SeongJae Park <sj@kernel.org>
Cc:     Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 9:41 PM Alex Shi <seakeel@gmail.com> wrote:
>
> On Wed, Nov 10, 2021 at 8:40 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Thank you for this patch, Alex!
> >
> > On Wed, 10 Nov 2021 19:47:21 +0800 alexs@kernel.org wrote:
> >
> > > From: Alex Shi <alexs@kernel.org>
> > >
> > > Variable nr_running_ctxs guards by damon_lock, but a lock for a int
> > > variable seems a bit heavy, a atomic_t is enough.
> >
> > The lock is not only for protecting nr_running_ctxs, but also for avoiding
> > different users concurrently executing damon_start(), because that could allow
> > the users interfering others.
>
> That's right. but it could be resolved by atomic too. like the following.
> >
> > >
> > > Signed-off-by: Alex Shi <alexs@kernel.org>
> > > Cc: SeongJae Park <sj@kernel.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  include/linux/damon.h |  1 -
> > >  mm/damon/core.c       | 31 +++++--------------------------
> > >  mm/damon/dbgfs.c      |  8 +++++---
> > >  3 files changed, 10 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > index b4d4be3cc987..e5dcc6336ef2 100644
> > > --- a/include/linux/damon.h
> > > +++ b/include/linux/damon.h
> > > @@ -453,7 +453,6 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> > >               unsigned long min_nr_reg, unsigned long max_nr_reg);
> > >  int damon_set_schemes(struct damon_ctx *ctx,
> > >                       struct damos **schemes, ssize_t nr_schemes);
> > > -int damon_nr_running_ctxs(void);
> > >
> > >  int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
> > >  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index c381b3c525d0..e821e36d5c10 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > [...]
> > > @@ -437,19 +422,15 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
> > >       int i;
> > >       int err = 0;
> > >
> > > -     mutex_lock(&damon_lock);
> > > -     if (nr_running_ctxs) {
> > > -             mutex_unlock(&damon_lock);
> > > +     if (atomic_read(&nr_running_ctxs))
>
> if (atomic_inc_not_zero(&nr_running_ctxs))

Ops, my fault. The following should be right?

Thanks

int a = 0;
if (!atomic_try_cmpxchg(&nr_running_ctxs, &a, 1))
> > >               return -EBUSY;
> > > -     }
> > >
> > >       for (i = 0; i < nr_ctxs; i++) {
> > >               err = __damon_start(ctxs[i]);
> > >               if (err)
> > >                       break;
> > > -             nr_running_ctxs++;
> > > +             atomic_inc(&nr_running_ctxs);
> > >       }
> > > -     mutex_unlock(&damon_lock);
> > >
>
>  atomic_dec(&nr_running_ctxs);
>
> Is it save the multiple ctxs issue?
>
> Thanks
>
> > >       return err;
> > >  }
> >
> > This would let multiple concurrent threads seeing nr_running_ctxs of zero and
> > therefore proceed together.
> >
> >
> > Thanks,
> > SJ
