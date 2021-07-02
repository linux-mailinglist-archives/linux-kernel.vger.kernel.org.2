Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C5A3BA5EC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhGBWQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhGBWQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:16:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED550C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 15:13:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bu19so20644848lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEZ8WS1/P9JTGSLCcSvWjs/G9krL0GBd8QeReo+j1Zk=;
        b=YkSDML8ETWqihRMIfeWD243ylc4Mo9Vok9hpERJMs7D+ji6L3jYQF7ApYt6d+LLDqB
         ra0TiWI801rOypgULgkh1CBvXidO8s4y3oUpaTdcuKcABrAIXMtEFcZjQoL8qH8pj/08
         rmqGADSlByI2KqZHR/WV8Gk1t96DAB95DYmrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEZ8WS1/P9JTGSLCcSvWjs/G9krL0GBd8QeReo+j1Zk=;
        b=pcG3ahwSoqUsd67ypxKYcEyhPRG3dDQYpN03PXZvriPOxc6Zpe9rVhAjrCxA9dbdW2
         LD3hWJc653j17YB62+vjm1ajYL4JuW8GlKPlkFC337oHu3g0oWH4dmwCKmYIdMHV6RD1
         daRD5b7e4NRTQ9I/2tt+PX0u/0mSHvDDCFGlHlhrYTG+YL2iCiEClp0cezF7vAcn42mK
         0VyiRNa4YjeM2K4GZ5Do7EC0F2gmI8pkgFAPZAmqO20z7ZaVqymynNuO8AHaYfYE79E4
         opLcENIp7bePdKYW/znsoWbvaHO1CkUKq1ZmzcRI3Y2RqRnwAeJciYwG+2Q3gxL/WbEJ
         VCAA==
X-Gm-Message-State: AOAM531GeL8YYZfFyYfQRyf9iJ+XlUyVfwqsb1y+E+otLSMcxxpcd7I1
        IjQt041G9FZRXARM8fxf+z2aObXv6GmAAYSmkHM=
X-Google-Smtp-Source: ABdhPJwRnKNUnz6v2btcw1iP2kE14i0zTEHKWo4NFS+iJyAR4EyigGVCxTckLiwfIDPvY6TcE6xP6Q==
X-Received: by 2002:ac2:4ac6:: with SMTP id m6mr1247869lfp.189.1625264016057;
        Fri, 02 Jul 2021 15:13:36 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id a2sm511988ljp.117.2021.07.02.15.13.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 15:13:35 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id u25so15249123ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 15:13:35 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr1182109ljj.411.1625264014789;
 Fri, 02 Jul 2021 15:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjQks3o_3=WewaXw++h+a318B3LTLSFER9Ee4n1pLCZLw@mail.gmail.com>
 <20210702175442.1603082-1-legion@kernel.org>
In-Reply-To: <20210702175442.1603082-1-legion@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 15:13:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfoVN6wiP5VHekckvqivRhpB+b1FnwyWEjz1SB2FN6HQ@mail.gmail.com>
Message-ID: <CAHk-=whfoVN6wiP5VHekckvqivRhpB+b1FnwyWEjz1SB2FN6HQ@mail.gmail.com>
Subject: Re: [PATCH] ucounts: Fix UCOUNT_RLIMIT_SIGPENDING counter leak
To:     Alexey Gladkov <legion@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 10:55 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> @@ -424,10 +424,10 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
>          * changes from/to zero.
>          */
>         rcu_read_lock();
> -       ucounts = task_ucounts(t);
> +       ucounts = ucounts_new = task_ucounts(t);
>         sigpending = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
>         if (sigpending == 1)
> -               ucounts = get_ucounts(ucounts);
> +               ucounts_new = get_ucounts(ucounts);
>         rcu_read_unlock();

I think this is still problematic.

If get_ucounts() fails, we can't just drop the RCU lock and (later)
use "ucounts" that we hold no reference to.

Or am I missing something? I'm not entirely sure about the lifetime of
that RCU protection, and I do note that "task_ucounts()" uses
"task_cred_xxx()", which already does
rcu_read_lock()/rcu_read_unlock() in the actual access.

So I'm thinking the code could/should be written something like this instead:

  diff --git a/kernel/signal.c b/kernel/signal.c
  index f6371dfa1f89..40781b197227 100644
  --- a/kernel/signal.c
  +++ b/kernel/signal.c
  @@ -422,22 +422,33 @@ __sigqueue_alloc(int sig, struct task_struct
*t, gfp_t gfp_flags,
         * NOTE! A pending signal will hold on to the user refcount,
         * and we get/put the refcount only when the sigpending count
         * changes from/to zero.
  +      *
  +      * And if the ucount rlimit overflowed, we do not get to use it at all.
         */
        rcu_read_lock();
        ucounts = task_ucounts(t);
        sigpending = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
  -     if (sigpending == 1)
  -             ucounts = get_ucounts(ucounts);
  +     switch (sigpending) {
  +     case 1:
  +             if (likely(get_ucounts(ucounts)))
  +                     break;
  +
  +             dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
  +             fallthrough;
  +     case LONG_MAX:
  +             rcu_read_unlock();
  +             return NULL;
  +     }
        rcu_read_unlock();

  -     if (override_rlimit || (sigpending < LONG_MAX && sigpending <=
task_rlimit(t, RLIMIT_SIGPENDING))) {
  +     if (override_rlimit || sigpending <= task_rlimit(t,
RLIMIT_SIGPENDING)) {
                q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
        } else {
                print_dropped_signal(sig);
        }

        if (unlikely(q == NULL)) {
  -             if (ucounts && dec_rlimit_ucounts(ucounts,
UCOUNT_RLIMIT_SIGPENDING, 1))
  +             if (dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1))
                        put_ucounts(ucounts);
        } else {
                INIT_LIST_HEAD(&q->list);

(and no, I'm not sure it's a good idea to make that use a "switch()" -
maybe the LONG_MAX case should be a "if (unlikely())" thing after the
rcu_read_ulock() instead?

Hmm?

The alternate thing is to say "No, Linus, you're a nincompoop and
wrong, that RCU protection is a non-issue because we hold a reference
to the task, and task_ucounts() will not change, so the RCU read lock
doesn't do anything".

Although then I would think the rcu_read_lock/rcu_read_unlock here is
entirely pointless.

               Linus
