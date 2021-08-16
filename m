Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8705C3ED465
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhHPM5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhHPM5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:57:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B3BC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:57:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w20so34218041lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsZbwogPh/AZ096p40e3Illwraa2Wp4Sz1Xn9F07NkY=;
        b=F/HjoMoSBRQx7O3rJjSKgw+9Y0wXMncq0MMTz8S7BnxM2e9Iv7JPu+4npLw5JpteKf
         KQsqqlPXITDdg2/w0w7Y6Bi7vB7fo3bbfzquvYSBaqGCYfEhWhxojM8qiawaaakZqSSj
         GzdoV81BLgKbkGGQ3RiCYSUA3w1o82Lx5MG0gv1UPNoF+O8eAv8hIqwvi7VbEsjIOH0f
         8mqm53eq+dIs4EoOBnxfqkrPhPCGjERwEFsfoRuXDqeYXEsqLGAOCn0RlPrxqtqeKPH9
         74of8opK5oPhfvG1fbKsEle6YbzTAcYLvgGNBxjtKABVA7xGo8a/7T4Eyho0pMnXp5VE
         uHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsZbwogPh/AZ096p40e3Illwraa2Wp4Sz1Xn9F07NkY=;
        b=X2EUjuGomVv4vSp369VG/0AEq77fV/knTsMlCEDEcGLq8WDNDYQ+0797hHvCyn4OlA
         LDca5YqBeqKsnxF4Kd840PrRw7alYo2qG4D7Q2u0nS+jjBO5lQ/V82PbfkSTI44z6K1i
         F+n3QGFpRfL+Hp3sZ5NHXNGCpmaXmNMfhINWDUhEfLfOZ/+vhxH5/WacOq+3BMXnTUbD
         X3YL8F9eVwZTDyNIwNPg1f6OsVaWSjgZL8DGM1Jg6rh2sY9GvOSYF9Znhmm1ACHZWpoo
         gsUEgR+eyqBHv2Jro76CrjVc1SnFUSIQ14/nP4DKpAeh1xLXiUYG9iQCpxCynDmS2skm
         cWSA==
X-Gm-Message-State: AOAM533k8mNaxSgMx0l6RbNYQuOOgPm1gUqU4aMQTt0i6WOPZ7OBdll1
        Lrp0WA/6/A2zl7nrV7B9SOxUwy7Trnwuj/iYey0ffQ==
X-Google-Smtp-Source: ABdhPJyt2LM/X6WRHuXQbW9qfjxD4LEdZWv/ACuaKTruy1hSh5nQFOWqwmBEVDelJJo+RvYqJmMM1YTZbloW/jKfxkg=
X-Received: by 2002:a05:6512:3f89:: with SMTP id x9mr11835532lfa.233.1629118628129;
 Mon, 16 Aug 2021 05:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-3-joshdon@google.com>
 <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com> <YRpfdWwJL34PjgI1@hirez.programming.kicks-ass.net>
In-Reply-To: <YRpfdWwJL34PjgI1@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 16 Aug 2021 14:56:57 +0200
Message-ID: <CAKfTPtB5gjvF8Gx3BSkOJZ+VVUj_2+yJfSB9tVH8iuEby60kvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: adjust SCHED_IDLE interactions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
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

On Mon, 16 Aug 2021 at 14:52, Peter Zijlstra <peterz@infradead.org> wrote:
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

That was my point too

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
>
> > > +                       vruntime -= thresh;
> > > +               else
> > > +                       vruntime += 1;
> > >         }
> > >
> > >         /* ensure we never gain time by being placed backwards. */
> > > --
> > > 2.32.0.554.ge1b32706d8-goog
> > >
