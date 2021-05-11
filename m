Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB7F37AD71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhEKR5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhEKR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:57:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6594C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:56:36 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id p20so2248138ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEieUtF82cL+QRqYe/uJoshXeUJzCNwZD1aMuDjUEa8=;
        b=K0AP15ltFkL8ZDnZI9Icyd51/g6JgY11d8ECI5jXb6AT0Seua97+vUY/LncHtdeFal
         ruPemTK4YW3vDuSQqezNQNh9bpum/zvk3lMwd2CwetRAU8dWxEtaVoHUgo/wOxxM52Tv
         i0eubTVMvtqkaFsEVtU6pKUOWSI1WYW3ri3uV1FSG/RnuYBwC7s3/EpjLBk5pcgbSwPS
         rxbj2LWqxrh+b4M4QYZNS1mM6TO/EwcC3rv8v+09sZI6ThP3cEwp9JvTPRbitarz1akJ
         m/AYVjtOx3HhTeJH1HvrYENZ3uBLzR9OsQTP9GSVljS2fSUJ3PsPPrXsbjChrvJWHDuQ
         FOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEieUtF82cL+QRqYe/uJoshXeUJzCNwZD1aMuDjUEa8=;
        b=eZUSwlisJ8bNjFpV8Ez0SCluMhyBTu7/O33bHyebDVglnONc5PnxoWitus4yNKf8Wt
         +CoZoDqSp4fG4qe7Ubt9d16ZL8NTVTUmkWyNOmUCPjIDxI7ODYPlCTNY5ZRa10PzmNXR
         Sn+fy6FG71E8eXMBNIqctAJf3Tx8lHF5RvZChZZa0OdWvcd12vPUMij/pibGmvuZ9wWK
         EylAccPan73j3PSArQINQF9Wu7EDrAP9WVeiOffM9GRG3rgSlGLao43UHbeG3RwC6ShA
         s1USxKbjvE/Ia3WKtAGaZJcJsgfJr9rJSQ471nl2u4d7oGGcUkeS0lDXHWCULs90nvrA
         sRRA==
X-Gm-Message-State: AOAM533iUUXkE0KAztZ/udsRmlYDRGYTbwHwdmILRZqUxZRXDQjO1Iuz
        PDoPo2S9G4eA6JzS4Zso9hATtH4o/raiyx31WwWw5A==
X-Google-Smtp-Source: ABdhPJwtYhYYhXIAD/NLXVq0wePq45fVZGFPLSmGg4DjnyLzaP+TW/VAHCOb2F2LV5JKDLSFMcnVuIehkLvfXsmCdNY=
X-Received: by 2002:a2e:151e:: with SMTP id s30mr25241212ljd.445.1620755795356;
 Tue, 11 May 2021 10:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <YBG0W5PFGtGRCEuB@google.com> <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book> <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
 <20210324134437.GA17675@vingu-book> <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
 <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
 <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com> <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
 <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com> <CAKfTPtDJaTr_HR2t=9CQ-9x6keu-qzx6okci92AdW5cJG8J9zg@mail.gmail.com>
 <2d2294ce-f1d1-f827-754b-4541c1b43be8@linux.intel.com> <ade18978-cd67-6215-28f0-4857c66a99fb@linux.intel.com>
 <CAKfTPtA8nr-fgt4Nw6XqQyT_TEx4uL3nK-ba0xGfkONO+BPG3Q@mail.gmail.com> <577b0aae-0111-97aa-0c99-c2a2fcfb5e2e@linux.intel.com>
In-Reply-To: <577b0aae-0111-97aa-0c99-c2a2fcfb5e2e@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 11 May 2021 19:56:23 +0200
Message-ID: <CAKfTPtC2Lj1O7-CoZd51cUDaB6EWkYVO=jbe4yaHVQE-wASAEQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 19:25, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
> On 5/11/21 8:25 AM, Vincent Guittot wrote:
> > Hi Tim,
> >
> > Sometimes, we want to set this_rq->next_balance backward compared to
> > its current value. When a CPU is busy, the balance interval is
> > multiplied by busy_factor which is set to 16 by default. On SMT2 sched
> > domain level, it means that the interval will be 32ms when busy
> > instead of 2ms. But if a busy load balance happens just before
> > becoming idle, the this_rq->next_balance will be set 32ms later
> > whereas it should go down to 2ms as the CPU is now idle. And this
> > becomes even worse when you have 128 CPUs at die sched_domain level
> > because the idle CPU will have to wait 2048ms instead of the correct
> > 128ms interval.
> >
> >>
> >>  out:
> >>         /* Move the next balance forward */
> >> -       if (time_after(this_rq->next_balance, next_balance))
> >> +       if (time_after(next_balance, this_rq->next_balance))
> >
> > The current comparison is correct but next_balance should not be in the past.
>
> I understand then the intention is after the update,
> this_rq->next_balance should have a minimum value of jiffies+1. So
> we will need
>
>  out:
>         /* Move the next balance forward */
> +       this_rq->next_balance = max(jiffies+1, this_rq->next_balance);
>         if (time_after(this_rq->next_balance, next_balance))
>                 this_rq->next_balance = next_balance;
>
> as next_balance computed will be at least jiffies+1 after your fix to
> update_next_balance(). We still need to take care of the case when
> this_rq->next_balance <= jiffies.
>
> So combining with your suggestion on the fix to update_next_balance(),
> the fix will be
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1d75af1ecfb4..2dc471c1511c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9901,7 +9901,7 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
>
>         /* used by idle balance, so cpu_busy = 0 */
>         interval = get_sd_balance_interval(sd, 0);
> -       next = sd->last_balance + interval;
> +       next = max(jiffies+1, sd->last_balance + interval);
>
>         if (time_after(*next_balance, next))
>                 *next_balance = next;
> @@ -10681,6 +10681,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>
>  out:
>         /* Move the next balance forward */
> +       this_rq->next_balance = max(jiffies+1, this_rq->next_balance);
>         if (time_after(this_rq->next_balance, next_balance))
>                 this_rq->next_balance = next_balance;
>
>
> >
> > update_next_balance() is only used in newidle_balance() so we could
> > modify it to  have:
> >
> > next = max(jiffies+1, next = sd->last_balance + interval)
>
> Is the extra assignment "next = sd->last_balance + interval" needed?

No it's a typo mistake while copy pasting the line

> This seems more straight forward:
>
> next = max(jiffies+1, sd->last_balance + interval)
>
> I will try to get the benchmark folks to do another run with this change.
> Hopefully I'll get some bandwidth from them soon.
>
> Thanks.
>
> Tim
>
