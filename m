Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056F8356892
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346361AbhDGJ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhDGJ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:58:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958E7C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:57:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v140so9737960lfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzVk6mBE61MJw2r5FHmSZRvCYgvwVXp/mZjw884DOo4=;
        b=K/ahBBVqXGa7skVKcZZvX1P3cWOXCUejCM0xwFV0fYzhHOjlSVvI8D30uTEo8z+9Kw
         fqokx2nYkHaQ2AvW76EyGUB27UzLK0DCzfFn2PjWHMAbZpgDoOoRjUwQNwZqwP7xMdi5
         +TEyz46gG1OvtP66TT9UREYJRg2R6u3QZDxb+pG6LU10Q4znoI9vkVqnRw1clSdSH0gv
         oHY+UhlTVYRYSvovt86zeNTLxeJpS0vvWFVMNW+TfHX4XLBmA85Lzi7qUbtfbc9AUZqw
         YD2tR8YqDmCVUt0I8YBcKB71ANOAdfSQp7oY5h4oyFR2DjC6M6Nc9qGPlsnjAypVMlAE
         cqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzVk6mBE61MJw2r5FHmSZRvCYgvwVXp/mZjw884DOo4=;
        b=CfEuHJZPdC9aguJ2WTvMExsxLfutU5hHUx2FcyGqz3tPR6WPyhOCfWxbW7lLPRm4GK
         b6IkJSFpNU05bxlxGFckWzH1/FtqGh0kz4XuNolNdpLl4d7vQoq5BZNsx2LmIecagoV0
         SZq79tS3WXin9qCCLSJxXDIqMUtvwflrbtFwnZWwA3m2dujbJf5VcigqDw6jSCda7tnJ
         0DfMNdAemyA5wZQRgnc8s34jmRxHuBvnloHKFc4wkXldT803NXbXJXAjscLwfOnb3w5l
         YLmfUiLszp0eESsjR2itL0jjWkQGtPy2+QGGpGCA9/6hGYa0xZ8hNyMAix/WjY4lLRat
         z+Cw==
X-Gm-Message-State: AOAM5303Rt/4hQ86vi/MetxEKb82CQH67mQO0rrbT+nA6tyCe0h8cIU5
        kcAUahzgFZgy/d9oDIioD7oQS4cgY7I6iIPpdZVMqA==
X-Google-Smtp-Source: ABdhPJxaYtLqugOv8s0AaC29rg4OpugngrVdIOVuzEVFrREaHGm4kSSA/NuZbvlGWGFYfbv94nS3zhqxPfULMTTw0hA=
X-Received: by 2002:a05:6512:338a:: with SMTP id h10mr1991863lfg.277.1617789472032;
 Wed, 07 Apr 2021 02:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210321150358.71ef52b1@imladris.surriel.com> <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com> <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net> <20210407094217.GA2926@vingu-book>
 <YG2BXRm60IhpumD8@hirez.programming.kicks-ass.net>
In-Reply-To: <YG2BXRm60IhpumD8@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Apr 2021 11:57:40 +0200
Message-ID: <CAKfTPtB7bSkQttZoOPfvsHmN6yG6BrYTs0r0xBO4Xs-A+UhH6w@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but differently
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 at 11:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 07, 2021 at 11:42:17AM +0200, Vincent Guittot wrote:
> > I would really prefer to keep that out of select_idle_cpu which aims to merge in one
> > single loop the walk through sd_llc. In the case of select_idle_smt, this is done outside
> > the loop:
>
> Fair enough.
>
> > @@ -6317,11 +6339,21 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >               }
> >       }
> >
> > +     if (static_branch_likely(&sched_smt_present)) {
> > +             smt = test_idle_cores(target, false);
> > +             if (!smt && cpus_share_cache(prev, target)) {
> > +                     /* No idle core. Check if prev has an idle sibling. */
> > +                     i = select_idle_smt(p, sd, prev);
> > +                     if ((unsigned int)i < nr_cpumask_bits)
> > +                             return i;
> > +             }
> > +     }
> > +
> >       sd = rcu_dereference(per_cpu(sd_llc, target));
> >       if (!sd)
> >               return target;
>
> It needs to be here, otherwise you're using @sd uninitialized.

argh yes...

>
> > -     i = select_idle_cpu(p, sd, target);
> > +     i = select_idle_cpu(p, sd, smt, target);
> >       if ((unsigned)i < nr_cpumask_bits)
> >               return i;
>
> Let me have another poke at it.
