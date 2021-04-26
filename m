Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44136BB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhDZWWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhDZWWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:22:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5514CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:21:48 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o5so58220079qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2pNks8HV2kJ9hKufcy9typRfEosuYn08UUoOVGQ5N4=;
        b=T1G8dftJOBSSxoKQsjOmzrB22bKfkVdMMs9g3GTsQqZlKt2bTWjJvhxAn3jZPv2iP/
         kGBG4qrFtMR+AHHhEQ3uxxwMwqI7sOJ/Yt+Ol7pOwr7WRz3ffk6xpNAD+0Qti1afUVQD
         B6vKTUpbeXK2J0iM6LPsLRhn1g2j0RWU7DvVlXApQkuO4RgiQWWZOoiv9vaRGq6cQ4aO
         yXlHlBgsqx729odurZB5jYgG6D1/svUuBfYddPrSG7NMoW8FmtCX9lImnE91HT8H0dOi
         6kN29spj3R8rRFBJ8Gv/mleyvx/nkfVr5U/l5iB5hxmnaHYzaQ0BSV5JwWtVq2Ya9Vkb
         UESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2pNks8HV2kJ9hKufcy9typRfEosuYn08UUoOVGQ5N4=;
        b=fCXkJDqWebcvhSTZ7U2b40bIS1ZgIdyavfNhQ9dCobldw+Cg8zwy9Ca0Hpy3DWyQIp
         I2f8HG13iAu2gwxjMpk9ZiYsgkkZf9GhHf3jBa+QlqeT4Q0/02CT6UCZyiqEl3Vqkfcx
         B8HzOme91ayS5tdloaIjLJ1xQdBkfBBEhKpnCp3A6yyhO4MPvBL66wULcEqY2jaRUYHR
         SLa7n59n+V2Hpn3URTy2uevx8KXfh4gIPbk+Lkc9bcNPz+q1NABTymA6VCETGa9Q1OMz
         Ad4sI5xJkl2/GZb2XvK6smS5xO+JFnKrpMl1UrSDcT0zL1rcZ5vGCTapugykHE5fWuis
         5vQA==
X-Gm-Message-State: AOAM532BoV4GKeyZy3ne8Luprf0NwyCGSJIs4/32b1ZZCIr5Fpu93MsM
        TIyLhNBp21aW5DHi3KAqv93J0pXss4Cr7yDkoirBIg==
X-Google-Smtp-Source: ABdhPJz+jlfvWhZEzMzs/HdRsSs4G3DHb0viZ8sjHzcdzL0xRTA17IFGlm75fgYsw6BIiMStxeq+zWrx/X++Ya3UKfY=
X-Received: by 2002:a37:a6d2:: with SMTP id p201mr19602860qke.146.1619475707058;
 Mon, 26 Apr 2021 15:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com> <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net>
In-Reply-To: <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 26 Apr 2021 15:21:36 -0700
Message-ID: <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f732642e3e09..1a81e9cc9e5d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -290,6 +290,10 @@ static void sched_core_assert_empty(void)
>  static void __sched_core_enable(void)
>  {
>         static_branch_enable(&__sched_core_enabled);
> +       /*
> +        * Ensure raw_spin_rq_*lock*() have completed before flipping.
> +        */
> +       synchronize_sched();

synchronize_rcu()

>         __sched_core_flip(true);
>         sched_core_assert_empty();
>  }
> @@ -449,16 +453,22 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>  {
>         raw_spinlock_t *lock;
>
> +       preempt_disable();
>         if (sched_core_disabled()) {
>                 raw_spin_lock_nested(&rq->__lock, subclass);
> +               /* preempt *MUST* still be disabled here */
> +               preempt_enable_no_resched();
>                 return;
>         }

This approach looks good to me. I'm guessing you went this route
instead of doing the re-check after locking in order to optimize the
disabled case?

Recommend a comment that the preempt_disable() here pairs with the
synchronize_rcu() in __sched_core_enable().

>
>         for (;;) {
>                 lock = __rq_lockp(rq);
>                 raw_spin_lock_nested(lock, subclass);
> -               if (likely(lock == __rq_lockp(rq)))
> +               if (likely(lock == __rq_lockp(rq))) {
> +                       /* preempt *MUST* still be disabled here */
> +                       preempt_enable_no_resched();
>                         return;
> +               }
>                 raw_spin_unlock(lock);
>         }
>  }
