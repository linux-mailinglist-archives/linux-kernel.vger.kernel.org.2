Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D643EF635
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 01:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbhHQXlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 19:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbhHQXlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:41:44 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D8C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:41:10 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a126so1635955ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knpl+46Cr7F/GMqnnEG5MUMV687us2ycCYdc7oiiCkY=;
        b=J/U+aValtjtC7cziUESaHLVCLFeee4yR8OjFXpjfe0xQnGLyG9q4abMwkDE4vAvEyE
         i33AhQS0jye0glM7fgd11Qh8Fk5uCVykwLi+SGqIfQVzCVc1mVOwrUayk/eSFE6Fhxgv
         v4+Jrb9JrS/KuWwmu++1XmDU8YQMi5jyB3pkaUJzipQi6hEHtaKgzgc2l1Sqahks4Fno
         fV4q5qeQMZ4Y1qXpaPLIEDxKjIeCmWPMx8Mvq5BJj9q8f03oF7Udt6XdRoHfI0T2ds4j
         Yz5W3cj8GPArrvdRqkwvNC0tUcISbspEUh+BEqNvSAsCx8DLvjUzFPJdTXz+Cb7RtgiZ
         WLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knpl+46Cr7F/GMqnnEG5MUMV687us2ycCYdc7oiiCkY=;
        b=a5hbGdIgP3iUP62qqad0eiocdIkXYAHx46ZuEsWJNx/A30IzE3jnNKtTt/lP6Z5RCq
         VPERaG7KA6yr5M6Rbs1/A43tX1+7eLzJwHeKBRv6RotT6oek04Dsnane/rQpppMQdlMy
         6LbUiX5SZtNJTuNx+2zGchiYAuuqweKLdplXRmi47Wu+R4eFjLcQg1B4DP7aVBtvC2SW
         DKyHYHD7UkDtfyxcTMXTXbc3ldpnivIbKbFdPk/ewc8GihCd1bvDbQhrYDLOmwELceS6
         6CQkw002PDmvXs8Ut51Yz9jTekF2txWPXO3ZAcj/XRSW7MD2VOliA7RKK93XijhjyIke
         sHIQ==
X-Gm-Message-State: AOAM5337lrZ0X+t64mI+3bkwRlj+IGvsb6dkGEwHswVLD5FTCcul5jEo
        Ht1KYuog3AoGbIhcIi+GVeOZN8vyk8q6tdZkDDXCGQ==
X-Google-Smtp-Source: ABdhPJxGSyNLahp7hXApXYGKuWXjpwZsNwlcpyxa7A800TfB2wIX/qkewBaqMNMj3Axw84Gg/N1HFee/AGbG+Fjypmo=
X-Received: by 2002:a25:1506:: with SMTP id 6mr7466072ybv.153.1629243669454;
 Tue, 17 Aug 2021 16:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-3-joshdon@google.com>
 <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com> <YRpfdWwJL34PjgI1@hirez.programming.kicks-ass.net>
In-Reply-To: <YRpfdWwJL34PjgI1@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 17 Aug 2021 16:40:58 -0700
Message-ID: <CABk29NtpzK+qJYh6ZtKsdWGTB6UEZTGP=hgEo3hyPxQabsjsQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: adjust SCHED_IDLE interactions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 5:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Aug 11, 2021 at 03:31:49PM +0200, Vincent Guittot wrote:
> > On Fri, 30 Jul 2021 at 04:00, Josh Don <joshdon@google.com> wrote:
>
>
> > > @@ -4216,7 +4228,15 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> > >                 if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > >                         thresh >>= 1;
> > >
> > > -               vruntime -= thresh;
> > > +               /*
> > > +                * Don't give sleep credit to a SCHED_IDLE entity if we're
> > > +                * placing it onto a cfs_rq with non SCHED_IDLE entities.
> > > +                */
> > > +               if (!se_is_idle(se) ||
> > > +                   cfs_rq->h_nr_running == cfs_rq->idle_h_nr_running)
>
> I really dislike that second clause, either never do this for idle or
> always, but not sometimes when the planets are aligned just right.

Yep, switched this to always for idle entities.

>
> > Can't this condition above create unfairness between idle entities ?
> > idle thread 1 wake up while normal thread is running
> > normal thread thread sleeps immediately after
> > idle thread 2 wakes up just after and gets some credits compared to the 1st one.
>
> No. Strictly speaking cfs is unfair here. But it's a really tricky case.
>
> Consider a task that is running 50% competing against a task that's
> running 100%. What's fair in that situation, a 50/50 split, or a 25/75
> split? What if that 50% is 50% of a minute?
>
> What we do here is fudge the vruntime such that we end up with a 50/50
> split provided the period over which it blocks is less than a slice.
> After that it gradually converges to the 'expected' 25/75 split that
> results from strict runnable competition.
>
> By not letting idle tasks participate in this, we avoid idle tasks
> 'stealing' the !runnable time and they revert back to strict runnable
> competition only.

I like Vincent's suggestion to use a reduced threshold for idle
entities, that's been working pretty well. And it retains some
idle<->idle fairness when we have idle waking onto other idle threads.
