Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF4430BC4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344513AbhJQTiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJQTiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:38:00 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559AAC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 12:35:50 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id e10so1929861uab.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXHVDiTbb4QynJ05tIsEVJc9fCfxfVbBBopuJhEZiI4=;
        b=WOxsiY+XC5QmnU3cQSqx+ubIjAjRnEFI4fWBsMqnPBIxkCbsg8DB9OLxK4bMX+DgHO
         yQ/TfgSr5ZhSTq+iNzSxvvBdauOWoUL3kCbbHd8eZso6IoQL3EpeN4bRLwrzKB7Bma7M
         i9skuymzP+u5dMo04C1JWLfWWytA3sRzsaMS1T2KzNJMi2AIBpehYKVhaiu1dbM1kGYx
         bm1iJd40ENzTkSpIZ4bGwEXNOSnTOIW7PlDHZDvOVXhhVk44jX/EfW7Ed8TkMhJDIx1C
         D3VavvuE2UaT1W1B6zA8RJPaMkJ2QtDLVbWZ4PmRfFklipF+Uo3/6MRCwPgfJ/bfhy/T
         SFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXHVDiTbb4QynJ05tIsEVJc9fCfxfVbBBopuJhEZiI4=;
        b=4WSLO3nWD3aIB4LIYls8fBfwdIVKBoL5oQiGyq076IGLSaqf8QK8xJTBjxky+hOC7g
         asb/IcyaPV/U/fe1nDisj22zsg0DH1nYKYKw5m+YMm0lO1w4oT1PRrMp5RFRIjISY/Zz
         8hJkBlmExsoyeiLTZnsLRSdDvCjFajPyuZ+z013BS2si8w7Cb1btzeE7Fx9wTJ89Mf4V
         ywhuFDYx3ykFU4yH1G6dgZoVGMfIPkFsdV+PKbWAgicEsTauFy8mcd4BuxfcDoyQf56B
         n6WP0yO64N/MjY7ZS3CMImlWH5RK8GW1U0cRbMJuv+uLrRcjzUw45GS2O1teayPyzazN
         JQnA==
X-Gm-Message-State: AOAM531j+aSbJmw5u+ZjfGt09M0fwP+ePWcXZembvvr6WQNQTZgY/tn1
        buIjelS3UFVlNWaYXmw5utml1Gt9DU+BMZ21LjhPrw==
X-Google-Smtp-Source: ABdhPJzoVvbPeRB9+ETNsDM6qu+uPWrlpgh1qA0dj/BQuaQ/dyR38S2IE+ZFRFEpV2Deld6Kv3zukvke0xXh7Z79CTE=
X-Received: by 2002:a67:ee88:: with SMTP id n8mr24421989vsp.58.1634499349260;
 Sun, 17 Oct 2021 12:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <878rzw77i3.fsf@disp2133> <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org> <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
 <20210930130640.wudkpmn3cmah2cjz@example.org> <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
 <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133> <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk>
 <87mtnavszx.fsf_-_@disp2133> <20211015230922.7s7ab37k2sioa5vg@example.org> <87zgr8vpop.fsf@disp2133>
In-Reply-To: <87zgr8vpop.fsf@disp2133>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 17 Oct 2021 13:35:37 -0600
Message-ID: <CAOUHufbbPMzMLaPH8o+PKG64RQaO7=09nv1hBnQY8SRAW+Jd-g@mail.gmail.com>
Subject: Re: [CFT][PATCH] ucounts: Fix signal ucount refcounting
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 11:35 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Alexey Gladkov <legion@kernel.org> writes:
>
> > On Fri, Oct 15, 2021 at 05:10:58PM -0500, Eric W. Biederman wrote:
> >>
> >> In commit fda31c50292a ("signal: avoid double atomic counter
> >> increments for user accounting") Linus made a clever optimization to
> >> how rlimits and the struct user_struct.  Unfortunately that
> >> optimization does not work in the obvious way when moved to nested
> >> rlimits.  The problem is that the last decrement of the per user
> >> namespace per user sigpending counter might also be the last decrement
> >> of the sigpending counter in the parent user namespace as well.  Which
> >> means that simply freeing the leaf ucount in __free_sigqueue is not
> >> enough.
> >>
> >> Maintain the optimization and handle the tricky cases by introducing
> >> inc_rlimit_get_ucounts and dec_rlimit_put_ucounts.
> >>
> >> By moving the entire optimization into functions that perform all of
> >> the work it becomes possible to ensure that every level is handled
> >> properly.
> >>
> >> I wish we had a single user across all of the threads whose rlimit
> >> could be charged so we did not need this complexity.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> ---
> >>
> >> With a lot of help from Alex who found a way I could reproduce this
> >> I believe I have found the issue.
> >>
> >> Could people who are seeing this issue test and verify this solves the
> >> problem for them?
> >>
> >>  include/linux/user_namespace.h |  2 ++
> >>  kernel/signal.c                | 25 +++++----------------
> >>  kernel/ucount.c                | 41 ++++++++++++++++++++++++++++++++++
> >>  3 files changed, 49 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> >> index eb70cabe6e7f..33a4240e6a6f 100644
> >> --- a/include/linux/user_namespace.h
> >> +++ b/include/linux/user_namespace.h
> >> @@ -127,6 +127,8 @@ static inline long get_ucounts_value(struct ucounts *ucounts, enum ucount_type t
> >>
> >>  long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
> >>  bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
> >> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
> >> +void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
> >>  bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
> >>
> >>  static inline void set_rlimit_ucount_max(struct user_namespace *ns,
> >> diff --git a/kernel/signal.c b/kernel/signal.c
> >> index a3229add4455..762de58c6e76 100644
> >> --- a/kernel/signal.c
> >> +++ b/kernel/signal.c
> >> @@ -425,22 +425,10 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
> >>       */
> >>      rcu_read_lock();
> >>      ucounts = task_ucounts(t);
> >> -    sigpending = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
> >> -    switch (sigpending) {
> >> -    case 1:
> >> -            if (likely(get_ucounts(ucounts)))
> >> -                    break;
> >> -            fallthrough;
> >> -    case LONG_MAX:
> >> -            /*
> >> -             * we need to decrease the ucount in the userns tree on any
> >> -             * failure to avoid counts leaking.
> >> -             */
> >> -            dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
> >> -            rcu_read_unlock();
> >> -            return NULL;
> >> -    }
> >> +    sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
> >>      rcu_read_unlock();
> >> +    if (sigpending == LONG_MAX)
> >> +            return NULL;
> >>
> >>      if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
> >>              q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
> >> @@ -449,8 +437,7 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
> >>      }
> >>
> >>      if (unlikely(q == NULL)) {
> >> -            if (dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1))
> >> -                    put_ucounts(ucounts);
> >> +            dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
> >>      } else {
> >>              INIT_LIST_HEAD(&q->list);
> >>              q->flags = sigqueue_flags;
> >> @@ -463,8 +450,8 @@ static void __sigqueue_free(struct sigqueue *q)
> >>  {
> >>      if (q->flags & SIGQUEUE_PREALLOC)
> >>              return;
> >> -    if (q->ucounts && dec_rlimit_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING, 1)) {
> >> -            put_ucounts(q->ucounts);
> >> +    if (q->ucounts) {
> >> +            dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
> >>              q->ucounts = NULL;
> >>      }
> >>      kmem_cache_free(sigqueue_cachep, q);
> >> diff --git a/kernel/ucount.c b/kernel/ucount.c
> >> index 3b7e176cf7a2..687d77aa66bb 100644
> >> --- a/kernel/ucount.c
> >> +++ b/kernel/ucount.c
> >> @@ -285,6 +285,47 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
> >>      return (new == 0);
> >>  }
> >>
> >> +static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
> >> +                            struct ucounts *last, enum ucount_type type)
> >> +{
> >> +    struct ucounts *iter;
> >> +    for (iter = ucounts; iter != last; iter = iter->ns->ucounts) {
> >> +            long dec = atomic_long_add_return(-1, &iter->ucount[type]);
> >> +            WARN_ON_ONCE(dec < 0);
> >> +            if (dec == 0)
> >> +                    put_ucounts(iter);
> >> +    }
> >> +}
> >> +
> >> +void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type)
> >> +{
> >> +    do_dec_rlimit_put_ucounts(ucounts, NULL, type);
> >> +}
> >> +
> >> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
> >> +{
> >> +    struct ucounts *iter;
> >> +    long dec, ret = 0;
> >> +
> >> +    for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> >> +            long max = READ_ONCE(iter->ns->ucount_max[type]);
> >> +            long new = atomic_long_add_return(1, &iter->ucount[type]);
> >> +            if (new < 0 || new > max)
> >> +                    goto unwind;
> >> +            else if (iter == ucounts)
> >> +                    ret = new;
> >> +            if ((new == 1) && (get_ucounts(iter) != iter))
> >
> > get_ucounts can do put_ucounts. Are you sure it's correct to use
> > get_ucounts here?
>
> My only concern would be if we could not run inc_rlimit_get_ucounts
> would not be safe to call under rcu_read_lock().  I don't see anything
> in get_ucounts or put_ucounts that would not be safe under
> rcu_read_lock().
>
> For get_ucounts we do need to test to see if it fails.  Either by
> testing for NULL or testing to see if it does not return the expected
> ucount.
>
> Does that make sense or do you have another concern?
>
>
> >> +                    goto dec_unwind;
> >> +    }
> >> +    return ret;
> >> +dec_unwind:
> >> +    dec = atomic_long_add_return(1, &iter->ucount[type]);
> >
> > Should be -1 ?
>
> Yes it should.  I will fix and resend.

Or just atomic_long_dec_return().

> >> +    WARN_ON_ONCE(dec < 0);
> >> +unwind:
> >> +    do_dec_rlimit_put_ucounts(ucounts, iter, type);
> >> +    return LONG_MAX;
> >> +}
> >> +
> >>  bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max)
> >>  {
> >>      struct ucounts *iter;
> >> --
> >> 2.20.1
> >>
>
> Eric
