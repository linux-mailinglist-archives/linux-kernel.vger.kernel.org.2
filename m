Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC305429A52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 02:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhJLAQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 20:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhJLAQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:16:41 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE86FC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 17:14:40 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id n65so42721523ybb.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 17:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENwk9JEgz2hASvxdoAsgjgcUl2M7wlCV95vN1r9bfoY=;
        b=qp7HifvdbhtSoBNZrHOxPz3g/MDHOhlHgP6YBDMWBCJl6RN+Q5vXyIG7MtYoR6sX2H
         Rt971+DgVcNmdHbhe2d+PJWaWKWQGYOHg8ZiXsHu6SHZh0J3rLB5daWYaFPJIOy1bTjq
         NfFwYHPxQOOg4VMxegJxVzpm5MoGvWIueAc9vPp9K5h8DUjf68Q0yGHmiJYER4a0b30S
         CqEKxXvhKdBNbAhpGk+CByb8jH26k2AgOYVDLO85dqn6hSqjJjPzyyn7l/xt+mBsx3ps
         4Swl2mGBx3g5/5MoBECGr6Mjk2EBPlX7Ze2dIK2DVcvxXHQiLXvXCLp0ReGKE+P6xW8/
         ygvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENwk9JEgz2hASvxdoAsgjgcUl2M7wlCV95vN1r9bfoY=;
        b=uQRUbEfDP9ahnJVvuUaQjDXld2k2oRms/YJaq7fVEC0DInosm9+9I510VI2vAjsylR
         1VInjiFVrnj3Blsm8EXT/oij/buNc0QCvkoxaDZa50MT6lOa4grNZGoNh0h/LKBJ7sL2
         BfZQPKvDG9hrAlRxZGPCFN4lT43PrzhepRM0huGBFVW0FqnECLX/7yoEaaKcVnb6ovNa
         w9Pr8TULg1AGg8xkoLhTCJ1lmzrMEoLhu21uPWJGigvOcdAo25icQoVLPSvAhyXOTWsW
         Dq3rsbiCQ5d+r3jZqj+xrusOT7nwtlteZHPbNLkazt67jkga6hS2RJHxay4Q2mJ0Uy9b
         3jdw==
X-Gm-Message-State: AOAM533MN2Fus4hQ3JGo9kwB60+RdDI2Pp4zVCk2BuspeYo0KBY8XoGN
        w7exBdFUd3xdps4ufKXsYJpXFFcOFolPFzTJ7QA6KQ==
X-Google-Smtp-Source: ABdhPJz9tBBDp0oiCcVSM5zfAK9VtYOAXppecfvPYXPKxw+HVtBAf6+BrtYjNslmbhhb3UbCr+hcv2lRcGYb9oxkvbU=
X-Received: by 2002:a25:cf07:: with SMTP id f7mr25077060ybg.100.1633997679963;
 Mon, 11 Oct 2021 17:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000825.1364224-1-joshdon@google.com> <YWHbV8NFSEj2qtQo@geo.homenetwork>
In-Reply-To: <YWHbV8NFSEj2qtQo@geo.homenetwork>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 11 Oct 2021 17:14:29 -0700
Message-ID: <CABk29Nt5pcJpbx7mKUfqbf+yahBw3uz50QpBvOm7u3B6uA+AuA@mail.gmail.com>
Subject: Re: [PATCH] sched/core: forced idle accounting
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 11:11 AM Tao Zhou <tao.zhou@linux.dev> wrote:
[snip]
> > +     smt_count = cpumask_weight(smt_mask);
> > +     if (smt_count > 2) {
> > +             unsigned int nr_forced_idle = 0, nr_running = 0;
> > +
> > +             for_each_cpu(i, smt_mask) {
> > +                     rq_i = cpu_rq(i);
> > +                     p = rq_i->core_pick ?: rq_i->curr;
> > +
> > +                     if (p != rq_i->idle)
> > +                             nr_running++;
> > +                     else if (rq_i->nr_running)
> > +                             nr_forced_idle++;
> > +             }
> > +
> > +             if (WARN_ON_ONCE(!nr_running)) {
> > +                     /* can't be forced idle without a running task */
> > +             } else {
> > +                     delta *= nr_forced_idle;
> > +                     delta /= nr_running;
> > +             }
>
> Is it possible to use (smt_count - core_occupation) / core_occupation
> to evaluate this delta ?

Good point, we can use the pre-computed info here. This will help
simplify this logic.

Thanks,
Josh
