Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33468429A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 02:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhJLAO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 20:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhJLAO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:14:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAE7C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 17:12:55 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id n65so42715192ybb.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Xa7WZvDaaI+8DWcjuNvPs4flE1gI9QC13fmDzSq2tU=;
        b=Feibu0llNNPqA/JWC/XofUsvREaq7pXBCsp8qRnUM/dt6vMZL2ImS9k9Mt4fKu+Yu3
         xlDI2P48zmC0OKuGTDY7+lM7WW7QWIR/rnNMip/DXUQ8oilsQvmZRuSK38Em+PNP4FrP
         Lp4ajVBHY9elc6+aplbIa+IZ6FnjfISFFcWLzF4AcgT9b7s7P1gq9Wscs7/kObw37Duu
         rfb3PYOx4Y/U2HArdr6/2+pSgX77SJfa41nvfHcy2qWUmgkDp2PVeQgwXEb5wq27mUjR
         Up9gWsjG2qAKxZ2YW3SSOjY13nqFPfDr5FtlkS6jCGwBr+L8D+Bq7GkH7MQzdDhKTW1f
         +5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Xa7WZvDaaI+8DWcjuNvPs4flE1gI9QC13fmDzSq2tU=;
        b=ep9e0h0HqX0nQSUQdxFkVwPP5KmafvjSagO/y7kpUBXSn0vxFEgPVt4go/UTX2awkQ
         gjBmY73uVJE+08tMuT8xaKtZItTpoOJQaF27xz36acEKlFg2+lC83fPOG1m5mdy7ZPZF
         Ma7xrkVAsmz/xk7arv+nqNP7CCG/WGfRcstILSAPOrxicwrJVbnFwo7MMwQd2+SyuS/h
         amARKeBJHkUmJcbQJVMsGQVeaWHCYPkQUkmm+f3iSDc7U7Xu6nT5A2nqAxBarT+fHjbN
         5Zzablh9Dgej3qctZcHVPtofBpFDOEu3Jz+KaTGQM9DNIIqkw65gn8X62kZMb08DJUDT
         PlAA==
X-Gm-Message-State: AOAM5308lwThHHNK5kH3WSS5ajl9hdti8JlyGK3J1dLnJNj+5jinGveR
        GYcObTu84u7TYxgAz0psDhKa5V12DnrsOg3pL6Zk/Q==
X-Google-Smtp-Source: ABdhPJwf0vVo3cqcG7ldVcs7h2QPlNnInE5RAG+nWnZGrJmuEvFxYSliDKR3wp5F30vmeVOmIhGLyrszKk69yKwQDN8=
X-Received: by 2002:a25:1145:: with SMTP id 66mr25527463ybr.354.1633997574590;
 Mon, 11 Oct 2021 17:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000825.1364224-1-joshdon@google.com> <20211009155435.GW174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211009155435.GW174703@worktop.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 11 Oct 2021 17:12:43 -0700
Message-ID: <CABk29Nu6F4__ryF5p0En--Ze6CCev1Jy81W=LkTYaacf-YLkFg@mail.gmail.com>
Subject: Re: [PATCH] sched/core: forced idle accounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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

On Sat, Oct 9, 2021 at 8:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 07, 2021 at 05:08:25PM -0700, Josh Don wrote:
> > Adds accounting for "forced idle" time, which is time where a cookie'd
> > task forces its SMT sibling to idle, despite the presence of runnable
> > tasks.
> >
> > Forced idle time is one means to measure the cost of enabling core
> > scheduling (ie. the capacity lost due to the need to force idle).
>
> It seems an excessive amount of code for what it says to do.

I think I can cut some of that down by simplifying the SMT>2 case :)

>
> > +     smt_count = cpumask_weight(smt_mask);
>
> That's a fairly expensive operation to find a number that's going the be
> to same over and over and over...

Per Tao's suggestion, the nr_running and nr_forced_idle can be
computed and cached in pick(). Then there won't be any extra overhead
here, other than a potential division when SMT>2.

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
> Now the comment sayeth:
>
> > +     /*
> > +      * For larger SMT configurations, we need to scale the charged
> > +      * forced idle amount since there can be more than one forced idle
> > +      * sibling and more than one running cookied task.
> > +      */
>
> But why?

We scale by the number of cpus actually forced idle, since we don't
want to falsely over or under charge forced idle time (defined
strictly as time where we have a runnable task but idle the cpu). The
more important scaling here though is the division over the number of
running entities. This is done so that the aggregate amount of forced
idle over some group of threads makes sense. Ie if we have a cpu with
SMT8, and a group of 7 threads sharing a cookie, we don't want to
accrue 7 units of forced idle time per unit time while the 8th SMT is
forced idle.

> > +     }
> > +
> > +     for_each_cpu(i, smt_mask) {
> > +             rq_i = cpu_rq(i);
> > +             p = rq_i->core_pick ?: rq_i->curr;
> > +
> > +             if (!p->core_cookie)
> > +                     continue;
> > +
> > +             p->core_forceidle_sum += delta;
> > +
> > +             /* Optimize for common case. */
> > +             if (smt_count == 2)
> > +                     break;
> > +     }
> > +}
