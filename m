Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADBD3B4BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 02:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFZAib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 20:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhFZAia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 20:38:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42107C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:36:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id b13so7385166ybk.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsnHst7N3/quJKHzP/d1la28004TofPWgsJ8voYAUuo=;
        b=tR3jm640z4bTJkBenCHVQlLFHqZwV6aZ1ft8i1KKNkOjDC8Xl1xI+IexQ0kDNIfF/g
         b11PvFTklXM/+pjLhu9+fuH4UozmsodDm+4RL9qm9h925nKawRT24bUj586dKfBgEJsx
         3Yja/PNq/O3C1KPC2mtsBY7YsMmR2nH+PLCScbo0O/H1KdWUHJmQbsEilbp8VsZ2YfLT
         CHF5DrQ4qywo/+e2Sjtd+yO32lao3LRIU9r3vWxq2F6eTvkRceqnWWDpRqp49PcF5Sgc
         Dqfdmg0HbyA3hUbKXvndJdVBYvJ9mjsnjky+cY8QfU8nHgoVkI+5ApZXaS+sYU8Jsrai
         oszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsnHst7N3/quJKHzP/d1la28004TofPWgsJ8voYAUuo=;
        b=gJvMSjdw4I5KKgH8wrZ9viTMkeyBuC03OBBco4cc2Ek2+fv+CXxiQaT3Nn6l2HhvAS
         FlwhbZovpzXS2AVHyOEVFkMiGxr/gpDz5zo7VuOn4F8H/2La98bQHE7EW7ocZeuTjZcI
         mES+z2M2UlMZU1+h0xiRGs4zIZbydu1+uzy53mD755ILn7W846MdYQPM3uO5npW63xER
         ZS2ohnFcwKSHPRDByQGhUnYCY0DN3F2yeeprRrK6gdgcgYV6yqZACxJxvBHBUpMReyTr
         mPjp9Wr8Th2RZ8HPVmd89vKEw08VF7cXsDZgxXidXObDpNlz9cgPDPXGlRwTEDpX2Y4R
         xp6A==
X-Gm-Message-State: AOAM530a+CWSO+7eMyyXNoap82/tGiLeSvLlhoCvA0Fn/jIpqS3+3Ehn
        SGbsCV9KbLG6KTr16otjJ7+yVlFlaE3gyQ7zk3mRJw==
X-Google-Smtp-Source: ABdhPJxeztC6FW5dzTRh/mppGpZa1auZnz7CRAvSgOZGmrLEttgAWb6aPBSf8zA7P2S8H3z3AEqf8qhTdWh66MPtvL8=
X-Received: by 2002:a25:3bcb:: with SMTP id i194mr15205758yba.442.1624667768211;
 Fri, 25 Jun 2021 17:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210608231132.32012-1-joshdon@google.com> <YNWR5qgkAxzLtUKK@hirez.programming.kicks-ass.net>
In-Reply-To: <YNWR5qgkAxzLtUKK@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 25 Jun 2021 17:35:57 -0700
Message-ID: <CABk29Ns1mV030CRtidLh42-tc-xZ8=-MWQjZs5+myZVyZpDeuw@mail.gmail.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 1:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 08, 2021 at 04:11:32PM -0700, Josh Don wrote:
> > +static int se_is_idle(struct sched_entity *se)
> > +{
> > +     if (entity_is_task(se))
> > +             return task_has_idle_policy(task_of(se));
> > +     return cfs_rq_is_idle(group_cfs_rq(se));
> > +}
>
> I'm conflicted on this, on the one hand, since we want 'idle' to be a
> sched_entity propery, I'd say, make it a sched_entity field, OTOH,
> that's probably going to be a mess too :/
>
> Let me read more..

Yea, I see both arguments; a field probably wouldn't be that bad. In
any case, this seemed reasonable and avoids more touchpoints in
core.c, so *shrug*.
