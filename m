Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FC5412FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhIUINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhIUINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:13:49 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:12:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b65so1049530qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8nUr+QDDJZCKOcpKCPWU28LUdFh51QC3wOAl+6MMVI=;
        b=PicYGeY0ITMj5Z+cj4ydO2URRrZ0fm9BybP/+CbfpoxwQW9CZZjDcf9Vy1XOcpzlwz
         wWMJWVY3PPlN6YV+Vxfee1OhIGMW7sAVnv/YGejV0xGuOrrQUGqqE22xpqagEmQ2r0J1
         l4wqlatB1ITTjgyLYheIXeW0Uo/WTkj/JXuGyJ4A7YZBncajhhVdS0KQPzCk26AS9Uxj
         LXEo2ZnaqhuHlEWgLs545i3L4Vczy6LuGjEGRa3xVEuN27z4m3vC4VWMKQv89bOva9Ve
         MA2wu4SXxGoNdOJ4vpRSk3f2mZWL9OBQliwVOpeM4zEGXE6Dj5yV0NUPpEiluLNzLXvZ
         Bv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8nUr+QDDJZCKOcpKCPWU28LUdFh51QC3wOAl+6MMVI=;
        b=gesD90VsWZITBT64IxPG24klVXTC0LAf3bg5TWBUNbaVnsETMvoGOAGOtAy6X81aoy
         2YsqdT4QJyUJLc+BD81xl9esrA1Zd8F0O7ksYTLdAV+mrP+DN1kkohM/LmjrrCbAanXR
         a/Y8AEmcOyJEpr1ZiyEngQEAJFfF6sTbWlOmpB08gxjMiKz1pASos/Zv5sU/76lTm8Eg
         DBL9jpmkHz7wwa0jsxab5caiFw8aAHsD2eqk+EMzZ9fQWbP6QUegYk545z6QRBxq1V42
         lJq/RnuMfqSfb+lvSnnMOePMlTvhVySjfAG4IIGzKML6aIAIfueGMCjS/iJMp5wPMK9+
         IQqQ==
X-Gm-Message-State: AOAM530cqIz45iCtlJ+dkIDH3Akv/6u6Oq73X1pkfPjbZBBfTElZiyBf
        EBGZdn2Zdbz3vom00TuAKukOchCyL4Bip89D8aViSg==
X-Google-Smtp-Source: ABdhPJxE0/GpkbAUwdbxFMPW81zlnu51++iYCGQquag9vlD3zJmlYgJpaFfS0XVhLSKva4irj0MXIpektmg0bFTRUH4=
X-Received: by 2002:a25:c753:: with SMTP id w80mr37395357ybe.245.1632211941000;
 Tue, 21 Sep 2021 01:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-2-mgorman@techsingularity.net> <CAKfTPtBTL+KTJdEWv=-6OF8mFvnWUQ1PWKufzhKOASzMcUbnww@mail.gmail.com>
 <20210921075309.GK3959@techsingularity.net>
In-Reply-To: <20210921075309.GK3959@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Sep 2021 10:12:10 +0200
Message-ID: <CAKfTPtBfYuprtTdeSTfkjt6V9J-mDZ=a7SUAo9g7Bwe=N3am0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Remove redundant lookup of rq in check_preempt_wakeup
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 09:53, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Sep 21, 2021 at 09:21:16AM +0200, Vincent Guittot wrote:
> > On Mon, 20 Sept 2021 at 16:26, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > The rq for curr is read during the function preamble, remove the
> > > redundant lookup.
> > >
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index ff69f245b939..038edfaaae9e 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7190,7 +7190,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> > >         if (cse_is_idle != pse_is_idle)
> > >                 return;
> > >
> > > -       update_curr(cfs_rq_of(se));
> > > +       update_curr(cfs_rq);
> >
> > se can have been modified by find_matching_se(&se, &pse)
> >
>
> I still expected the cfs_rq to be the same, particularly given that the
> context is about preempting the current task on a runqueue. Is that
> wrong?

As soon as the tasks don't belong to the same cgroup, se can be
modified and cfs_rq will not be the same

>
> --
> Mel Gorman
> SUSE Labs
