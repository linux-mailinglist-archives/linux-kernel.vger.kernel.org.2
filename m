Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B83C57EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378039AbhGLIkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351957AbhGLHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:52:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A825C0613A0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:49:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b26so9199086lfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ScKdEQQgXWUGntY7GVtanlrkqbGfbI/rF53jsisCmA=;
        b=OdXj0AwsrtusFt6w2u4HIkbt/t4/js8ff3dycRpTRLngiTWilM9MhQNa0g4vmuIkiA
         W3qKCJAv72Va6blw/OJHSTXTCqVxU/y5ft//FWsAXErdN01d/225z7g6FMlaaoLfOKvZ
         7yPXdZqRpsAp/zV11vRio12iuho8Fc0lrVPUhMH25r9das7L187qUZfPKTueRISk0JZW
         sncmrHbTbHxLMMSyzzSjiHBlqVZoLSPvpYr5AlJzyRmKUT5vcpVs3YzisNH7LY1fi+vr
         bysKO1gBAd1wGM6FnCBV+0Jm8YHGor2ZLWg7teuoxCB6B6eqSMgFCYzmsgqyBhuM9CbK
         MBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ScKdEQQgXWUGntY7GVtanlrkqbGfbI/rF53jsisCmA=;
        b=b2VScNTBMQhiCP3Y61MXYmWCRU7ZaN6Vz/piWdp6B02TTAXLnJJiE2LkFGqHBdyM/U
         TfpDJks82/3Wb4onJtuuYjzxsCCl4HM2qlO17tp4xeeI9lQmjv+WWhIEPIOm8QCLAqnU
         PoydOgoMGx4dpTct5Eg47T6HwesPJ4XsZ2zAjCp/deorDmVK1ZRVOs9LWTZi1QMROAbw
         ldorzecWC4OqMfMcyg+EF68LeN+FyVFm3MnIyBZb2nErw0byF+YFZBdoAPdAex6EH7dg
         NwIEbj0Sj1V3fOZXcx6rZ1xGdVygjTUmSmwy16QGGp12jdjQzPGae2JI8xUVXKVYNgDY
         1iPw==
X-Gm-Message-State: AOAM5307eF5GPRE2osufsJAqDrlScg0QVl8ftDIKRtElR09AhEuglS1E
        TQYjk0kA8utNsWknbwdhjsoNSRoXEwt6BJ/CLE8=
X-Google-Smtp-Source: ABdhPJzq8EM4FCSAFP+5cswTKWPKeS4XaGwfi7zamhlgOW8kblDOL0OSOv7yIAskvKhhLVB0rT3fDxt+4iVzsdYupTs=
X-Received: by 2002:ac2:46cb:: with SMTP id p11mr9065170lfo.587.1626076148893;
 Mon, 12 Jul 2021 00:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210711141430.896595-1-sxwjean@me.com> <20210711141430.896595-2-sxwjean@me.com>
 <0e48f59d-a8fd-936c-c57f-976632f9cead@redhat.com>
In-Reply-To: <0e48f59d-a8fd-936c-c57f-976632f9cead@redhat.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 12 Jul 2021 15:48:42 +0800
Message-ID: <CAEVVKH8q2Dyhv2B7DBXmncnaEUBgFy9UgmDwGepWjuA9SdWjwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/3] locking/lockdep: Unify the return values of check_wait_context()
To:     Waiman Long <llong@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 11:19 PM Waiman Long <llong@redhat.com> wrote:
>
> On 7/11/21 10:14 AM, Xiongwei Song wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > Unity the return values of check_wait_context() as check_prev_add(),
> "Unify"?
Sorry. Will improve the description.

> > check_irq_usage(), etc. 1 means no bug, 0 means there is a bug.
> >
> > The return values of print_lock_invalid_wait_context() are unnecessary,
> > remove them.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   kernel/locking/lockdep.c | 20 ++++++++++----------
> >   1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index bf1c00c881e4..8b50da42f2c6 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -4635,16 +4635,16 @@ static inline short task_wait_context(struct task_struct *curr)
> >       return LD_WAIT_MAX;
> >   }
> >
> > -static int
> > +static void
> >   print_lock_invalid_wait_context(struct task_struct *curr,
> >                               struct held_lock *hlock)
> >   {
> >       short curr_inner;
> >
> >       if (!debug_locks_off())
> > -             return 0;
> > +             return;
> >       if (debug_locks_silent)
> > -             return 0;
> > +             return;
> >
> >       pr_warn("\n");
> >       pr_warn("=============================\n");
> > @@ -4664,8 +4664,6 @@ print_lock_invalid_wait_context(struct task_struct *curr,
> >
> >       pr_warn("stack backtrace:\n");
> >       dump_stack();
> > -
> > -     return 0;
> >   }
> >
> >   /*
> > @@ -4691,7 +4689,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
> >       int depth;
> >
> >       if (!next_inner || next->trylock)
> > -             return 0;
> > +             return 1;
> >
> >       if (!next_outer)
> >               next_outer = next_inner;
> > @@ -4723,10 +4721,12 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
> >               }
> >       }
> >
> > -     if (next_outer > curr_inner)
> > -             return print_lock_invalid_wait_context(curr, next);
> > +     if (next_outer > curr_inner) {
> > +             print_lock_invalid_wait_context(curr, next);
> > +             return 0;
> > +     }
> >
> > -     return 0;
> > +     return 1;
> >   }
> >
> >   #else /* CONFIG_PROVE_LOCKING */
> > @@ -4962,7 +4962,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
> >   #endif
> >       hlock->pin_count = pin_count;
> >
> > -     if (check_wait_context(curr, hlock))
> > +     if (!check_wait_context(curr, hlock))
> >               return 0;
> >
> >       /* Initialize the lock usage bit */
>
> There is also another check_wait_context() in the "#else
> CONFIG_PROVE_LOCKING" path that needs to be kept in sync.
Oops, my fault.

For clarity,
> maybe you should state the meaning of the return value in the comment
> above the function.
Good point. Thanks.

Regards,
Xiongwei
>
> Cheers,
> Longman
>
> check_wait_context
>
