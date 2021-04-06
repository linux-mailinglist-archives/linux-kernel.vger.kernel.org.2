Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0DB3557D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbhDFPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDFPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:31:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD0C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:31:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o10so23432202lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lo6yW9gf4cOCRywsh41qN7XEQhUDVO76ta+HJNLSJfU=;
        b=hBQmYAj5sI27I3JSqvKLo53T3rY6DRbO3swIGWE2q+Iu+DsDKuwoAuZL5avOr3hoVx
         Iek7YvWtn/HM5JWL236dNEX1o+G3vk+IPBlrCnVd4Su0H9myAGKdXThlW+lP1cBB0Dp+
         Y2OA7UiuNkSep8KUOXncfgZPHSYWF9hxPrXOrcaUDFgQv7RcarMmCx43gPDK/yWQylQo
         hvQWOwGGQ5en440779eeeUQtph/RT5jyotZDDGUI0MAfbKt8L2IYNPmFSvt668UN3MQg
         +VTMIfZnFGM/6WL2SN20i8+PvyuYgNe5QbcGODpb31Smm1LHvfcvxu2ifDYfQ59o+bos
         zZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lo6yW9gf4cOCRywsh41qN7XEQhUDVO76ta+HJNLSJfU=;
        b=lTeQ1ru3QTZ0KokhJY9CxOrOKvp3i9CNUZsPOcUNzNpOEn8eAOI6veffieeSlpO3Jq
         Mj9rtea4xUX19pSYZJJvBkHOR61h2TpkxushVo2PezL/Kvn+vwV9fbnaoefYbqep5QbE
         D7URAYM1DBr+fMvjqk4N+fmN9bpXp9tDIYHisJB0pC7XLjMizJYhdR9pLqT/L2XyhfTp
         7IuSPVkgheAc39iz3mnhRtqs48ZoNczWlu+5WOm2XiqPvG/pEhT+TgrR0xuqNEXw2U8f
         77Qj+P44jryB06SP6IMd/+prAW5HaBHGMnke6ftLnmzWtr9D6bOIFi5d5HOMPhAC9Eoa
         nNRQ==
X-Gm-Message-State: AOAM530UPBVq8BhZExAGJK8MAfCexDUMtOSIVwliZ+4WNz96A3i5LJQ3
        4kUGpgGN1bzeFiXV7ae5UYg5hVmm1w1pBj6ZtKdK79ypFcAccA==
X-Google-Smtp-Source: ABdhPJwpQwujLGjOTXofESAonoQAgR1Gv63c+8HpbbL2FtBR9PULvo29nEutPHPq3+CGDwoaA/9yY/14Sx07zg5knmc=
X-Received: by 2002:a19:f812:: with SMTP id a18mr21436359lff.254.1617723075534;
 Tue, 06 Apr 2021 08:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210321150358.71ef52b1@imladris.surriel.com> <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com> <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
In-Reply-To: <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Apr 2021 17:31:03 +0200
Message-ID: <CAKfTPtC2Cnr=SoD9t+dLh01ux_bc8PAcHTXxxiBqbqykLphBNw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but differently
To:     Rik van Riel <riel@surriel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 at 17:26, Rik van Riel <riel@surriel.com> wrote:
>
> On Tue, 2021-04-06 at 17:10 +0200, Vincent Guittot wrote:
> > On Fri, 26 Mar 2021 at 20:19, Rik van Riel <riel@surriel.com> wrote:
> >
> > > -static int select_idle_cpu(struct task_struct *p, struct
> > > sched_domain *sd, int target)
> > > +static int select_idle_cpu(struct task_struct *p, struct
> > > sched_domain *sd, int prev, int target)
> > >  {
> > >         struct cpumask *cpus =
> > > this_cpu_cpumask_var_ptr(select_idle_mask);
> > >         int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > > @@ -6136,23 +6163,32 @@ static int select_idle_cpu(struct
> > > task_struct *p, struct sched_domain *sd, int t
> > >
> > >         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > >
> > > -       if (sched_feat(SIS_PROP) && !smt) {
> > > -               u64 avg_cost, avg_idle, span_avg;
> > > +       if (!smt) {
> > > +               if (cpus_share_cache(prev, target)) {
> >
> > Have you checked the impact on no smt system ? would worth a static
> > branch.
> >
> > Also, this doesn't need to be in select_idle_cpu() which aims to loop
> > the sched_domain becaus you only compare  target and prev. So you can
> > move this call to select_idle_smt() in select_idle_sibling()
>
> After Mel's rewrite, there no longer are calls to
> select_idle_core() or select_idle_smt() in select_idle_sibling().

select_idle_smt() had even disappeared that why it was not in
select_idle_sibling

>
> Everything got folded into one single loop in select_idle_cpu()

but this is done completely out of the loop so we don't need to
complify the function with unrelated stuff

>
> I would be happy to pull the static branch out of select_idle_smt()
> and place it into this if condition, though. You are right that
> would save some overhead on non-smt systems.
>
> Peter, would you prefer a follow-up patch for that or a version 4
> of the patch?
>
> --
> All Rights Reversed.
