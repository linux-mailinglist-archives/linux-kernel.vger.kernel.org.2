Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B131032526F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhBYP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 10:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhBYP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:27:54 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA19FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:27:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id z11so9095955lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 07:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGakPrHLDhRp1IZ5yNuxKjxsCxOojXmjVTcLjn2/wBU=;
        b=Bod/aAcriDLiojeGtSwg2Gc/r1XHZpiz5eGQpctCiOiI0I+E4XK8XmNRMxHdaLUxOh
         xBw1ckRoK4Krgn9F4mv4rl1r3Yyfv1/16fzhN9GaIDcwOT2BlwBnKmAw75yQs5uKrBKA
         kXSuyKJWSUKw4D3IIeiodZfirkstO58Zhn2V3x52qG79dIBs24sDwd4k0Sg7BgBvDZ1d
         x3Giofx+VN54jQGO73hZtaKeOqm9gzN4rHutMPoqzhDPrK73xnyNMkrkN3d+Ca9ZaUdD
         5+vqxYjRHuIPFxpQxG9UX3dwBn6A6MmI3UG2lqCPnucpwBiONMkXQZajwvecIc/pxRat
         N/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGakPrHLDhRp1IZ5yNuxKjxsCxOojXmjVTcLjn2/wBU=;
        b=aISGcpBL1wlaC7UL6rsFJ9ocow34Yu1CDqqrfcEGjKux/i10Nl3QVq90S+be0A3IKR
         4NfPaXnPbmEWjxRXr9BjVOnGfLPIM0c+vymQxH+NH+m6LMgUsA3Dw8jh+loNNWGKgcHo
         ykXsTec5WjD+zr1MZfm8NsEuOdFA5neuLvbx21EZrPkmH4kDntl9Ap2cLUhw++g3h+u/
         yXRVaVhBqkApT+n9fH7Sp2S0o02hMU34jPJSMm67Y2/4Xpp4fghUzZ2XXw9cAvZRqZeP
         0tSmc0iDrHHHSq7SJFm4S2d4uX4R7qY7IqGkCDzSfQoj1l93O4p+8JFomnQQkPMV8XVK
         p45g==
X-Gm-Message-State: AOAM530SxZFP4jcAcMI9hwZVhwS4+cMDGQRpA51DrFBnahS3UiFjqjHg
        cg+u5PkFCwK/iEB70ygWMn8CdBQGo64WsgmDAYz7Zg==
X-Google-Smtp-Source: ABdhPJxA7fMFjF99NUMbe5aXX3/2PLByd8c3eSo/+SbCmmhGJ0tGeq7nzvJACDgYZFerUck50heUFBkCI4wPTN+edFQ=
X-Received: by 2002:a05:6512:3a86:: with SMTP id q6mr2351561lfu.286.1614266821184;
 Thu, 25 Feb 2021 07:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20210216163921.572228-1-vincent.donnefort@arm.com>
 <CAKfTPtDC1GYV_7zoUtZa5MNLdt0Lx=X_UgB=Q8UtsGf8=Kd3iQ@mail.gmail.com> <20210222092426.GA5716@e124901.cambridge.arm.com>
In-Reply-To: <20210222092426.GA5716@e124901.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Feb 2021 16:26:50 +0100
Message-ID: <CAKfTPtCsbAePDooasS_Wxx729QjD9h5fi=Noa7SNkALjZMLsVg@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Fix task util_est update filtering
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 at 10:24, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> On Fri, Feb 19, 2021 at 11:48:28AM +0100, Vincent Guittot wrote:
> > On Tue, 16 Feb 2021 at 17:39, <vincent.donnefort@arm.com> wrote:
> > >
> > > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > >
> > > Being called for each dequeue, util_est reduces the number of its updates
> > > by filtering out when the EWMA signal is different from the task util_avg
> > > by less than 1%. It is a problem for a sudden util_avg ramp-up. Due to the
> > > decay from a previous high util_avg, EWMA might now be close enough to
> > > the new util_avg. No update would then happen while it would leave
> > > ue.enqueued with an out-of-date value.
> > >
> > > Taking into consideration the two util_est members, EWMA and enqueued for
> > > the filtering, ensures, for both, an up-to-date value.
> > >
> > > This is for now an issue only for the trace probe that might return the
> > > stale value. Functional-wise, it isn't (yet) a problem, as the value is
> >
> > What do you mean by "it isn't (yet) a problem" ? How could this become
> > a problem ?
>
> I wrote "yet" as nothing prevents anyone from using the ue.enqueued signal.

Hmm.. you are not supposed to use it outside the helper functions so
this is irrelevant IMO which means that only the trace probe is
impacted

>
> >
> > > always accessed through max(enqueued, ewma).
> > >
> >
> > This adds more tests and or update of  struct avg.util_est. It would
> > be good to have an idea of the perf impact. Especially because this
> > only fixes a tracing problem
>
> I ran hackbench on the big cores of a SD845C board. After 100 iterations of
> 100 loops runs, the geometric mean of the hackbench test is 0.1% lower
> with this patch applied (2.0833s vs 2.0858s). The p-value, computed with
> the ks_2samp [1] is 0.37. We can't conclude that the two distributions are
> different. This patch, in this scenario seems completely harmless.

For such kind of change,  perf bench sched pipe is better to highlight
any perf regression. I have done a quick test and i haven't seen
noticeable difference

>
> Shall I include those results in the commit message?
>
> [1] https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.ks_2samp.html
>
> >
> >
> > > This problem has been observed using LISA's UtilConvergence:test_means on
> > > the sd845c board.
> > >
> > > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 794c2cb945f8..9008e0c42def 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3941,24 +3941,27 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
> > >         trace_sched_util_est_cfs_tp(cfs_rq);
> > >  }
> > >
> > > +#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
> > > +
> > >  /*
> > > - * Check if a (signed) value is within a specified (unsigned) margin,
> > > + * Check if a (signed) value is within the (unsigned) util_est margin,
> > >   * based on the observation that:
> > >   *
> > >   *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
> > >   *
> > > - * NOTE: this only works when value + maring < INT_MAX.
> > > + * NOTE: this only works when value + UTIL_EST_MARGIN < INT_MAX.
> > >   */
> > > -static inline bool within_margin(int value, int margin)
> > > +static inline bool util_est_within_margin(int value)
> > >  {
> > > -       return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> > > +       return ((unsigned int)(value + UTIL_EST_MARGIN - 1) <
> > > +               (2 * UTIL_EST_MARGIN - 1));
> > >  }
> > >
> > >  static inline void util_est_update(struct cfs_rq *cfs_rq,
> > >                                    struct task_struct *p,
> > >                                    bool task_sleep)
> > >  {
> > > -       long last_ewma_diff;
> > > +       long last_ewma_diff, last_enqueued_diff;
> > >         struct util_est ue;
> > >
> > >         if (!sched_feat(UTIL_EST))
> > > @@ -3979,6 +3982,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> > >         if (ue.enqueued & UTIL_AVG_UNCHANGED)
> > >                 return;
> > >
> > > +       last_enqueued_diff = ue.enqueued;
> > > +
> > >         /*
> > >          * Reset EWMA on utilization increases, the moving average is used only
> > >          * to smooth utilization decreases.
> > > @@ -3992,12 +3997,19 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> > >         }
> > >
> > >         /*
> > > -        * Skip update of task's estimated utilization when its EWMA is
> > > +        * Skip update of task's estimated utilization when its members are
> > >          * already ~1% close to its last activation value.
> > >          */
> > >         last_ewma_diff = ue.enqueued - ue.ewma;
> > > -       if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
> > > +       last_enqueued_diff -= ue.enqueued;
> > > +       if (util_est_within_margin(last_ewma_diff)) {
> > > +               if (!util_est_within_margin(last_enqueued_diff)) {
> > > +                       ue.ewma = ue.enqueued;

why do you set ewma directly with latest enqueued value ?

> > > +                       goto done;
> > > +               }
> > > +
> > >                 return;
> > > +       }
> > >
> > >         /*
> > >          * To avoid overestimation of actual task utilization, skip updates if
> > > --
> > > 2.25.1
> > >
