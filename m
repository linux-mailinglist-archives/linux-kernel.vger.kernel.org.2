Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C56346009
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCWNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhCWNpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:45:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E37C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:45:10 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f26so25680757ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0UisNNbKbH6zzHCd8e8U+xHlLwMetDgdknX46c/dSs=;
        b=Nrzj1L7LOc078mFYMTtGNGLlJQdveIC2drIRxtWTtJC9IlAUaf/C5dTOSFswcG1S1l
         r8P6pW3bhUiwYJIYfdiXlayJUn7VqAdvlNVedSJxdK7fT/pLDHdBNktbXdNFrun0cz9Z
         TthKlCwPDlGhdn3B/kChAr65LQvEXYf4QejpC7PZVWOoE6K7tTXHIi4GxFJDv/0cVcZL
         MnNxpDLDqLZ4cvYY8xw0LEDYB6eFsqiJIlqPFSBrMO1OM13YkcDrNYw/0JvW1pMrhcrv
         NwLkq7ANNiT8ZzUisXxG2Bxoem9luljDoZtNFqKz/CLO10bpXt0t7Ph3jcY/8Ifugiru
         zgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0UisNNbKbH6zzHCd8e8U+xHlLwMetDgdknX46c/dSs=;
        b=OIkh+1Lnzl5In4HC8IPnc0FKB1k+y7B8QfGKrIBO7UGRmmlnKNv5qjMW6KTJzEQnNM
         CzEZmzIs+zP1aYOb71fMK/P9st2l9Vl33ANVXcbDppqdJavUwaJRW1+FYJAtCRDScXaN
         DyYptL/dDOmVohf3LrgN8kdgeGMf40GFrHRLg5N4cbkhz6xwkR3uqPuE8pTHM5dQ/+Vp
         xQMZu8s5zxyq5I7OLzLiDK9h2DcT51FG/GJqlC/pTWx1cVN3cBsOzwn8A04idZHhkHK+
         xDymFf+Ip+U0T6vKyyHmUM4m4wzi7EdZu9c2OiStr1yrbdI0wYNjyeU8NRZqoWvdF8eI
         IO7g==
X-Gm-Message-State: AOAM531n/0jymZw+mX+gfHW5Ut1oa3uMpHIOebd3XyxKujMmNODP/yDD
        l9fnFKO8b++pRdiVZn7Czhc+MS1jDD/ZTTUqS1gMjA==
X-Google-Smtp-Source: ABdhPJxLzsIFJqewS2UGeikJEOK5IUe7eAtO/0IDM3RG94kNNKWanslXjWKK5ZNWo7u8W2dGmzs7qcMwdGQF5wKqF/w=
X-Received: by 2002:a2e:5315:: with SMTP id h21mr3085264ljb.299.1616507109311;
 Tue, 23 Mar 2021 06:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <1614154549-116078-1-git-send-email-aubrey.li@intel.com> <74f65436-09f2-a4f0-345f-8887b11a51bf@linux.intel.com>
In-Reply-To: <74f65436-09f2-a4f0-345f-8887b11a51bf@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Mar 2021 14:44:57 +0100
Message-ID: <CAKfTPtCauiWo1yf90XnHK0HKZhS=dPVuJQ6C5gFSLF5_QA-OwA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: reduce long-tail newly idle balance cost
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aubrey Li <aubrey.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aurey,

On Tue, 16 Mar 2021 at 05:27, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2021/2/24 16:15, Aubrey Li wrote:
> > A long-tail load balance cost is observed on the newly idle path,
> > this is caused by a race window between the first nr_running check
> > of the busiest runqueue and its nr_running recheck in detach_tasks.
> >
> > Before the busiest runqueue is locked, the tasks on the busiest
> > runqueue could be pulled by other CPUs and nr_running of the busiest
> > runqueu becomes 1 or even 0 if the running task becomes idle, this
> > causes detach_tasks breaks with LBF_ALL_PINNED flag set, and triggers
> > load_balance redo at the same sched_domain level.
> >
> > In order to find the new busiest sched_group and CPU, load balance will
> > recompute and update the various load statistics, which eventually leads
> > to the long-tail load balance cost.
> >
> > This patch clears LBF_ALL_PINNED flag for this race condition, and hence
> > reduces the long-tail cost of newly idle balance.
>
> Ping...

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> >
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > ---
> >  kernel/sched/fair.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04a3ce2..5c67804 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7675,6 +7675,15 @@ static int detach_tasks(struct lb_env *env)
> >
> >       lockdep_assert_held(&env->src_rq->lock);
> >
> > +     /*
> > +      * Source run queue has been emptied by another CPU, clear
> > +      * LBF_ALL_PINNED flag as we will not test any task.
> > +      */
> > +     if (env->src_rq->nr_running <= 1) {
> > +             env->flags &= ~LBF_ALL_PINNED;
> > +             return 0;
> > +     }
> > +
> >       if (env->imbalance <= 0)
> >               return 0;
> >
> >
>
