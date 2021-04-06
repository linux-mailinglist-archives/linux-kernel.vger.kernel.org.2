Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9B355813
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345803AbhDFPfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhDFPdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:33:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25232C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:33:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d12so23420971lfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qgAQJ1wpHvLIvOj/hCuqnhy12lLUQbyhSNgCCd5h3Y=;
        b=jzshJrGKrplUDKSSByFY7XuW1UsMlTVE6ma7NTX5tuTgTvpw2TiC6iTTA2qh2nWNlW
         c9/njfJkvWjAHHoVNAg8pXjnsY1ARdkDZRD9WwRmnVbDjUeNH7Q+6ckWiueIILihfS2o
         hC/JI6lGYOq3MTYjFYTj+ZfQ4RJwunwbjiQsmCrfsCZBnPxEhBwDfTCINKy6UCMeNtCY
         yRPOKcRUe9Kgm61NL9NYfql33y1Iw/9znKSfduBMCWhwnfeRxEzW5zFQZZC7udGmRDUg
         y9FaAnsIxed9khEefMsU/ZZQZnLKWAVcm6lIXcfRhlBHXRXYntInw7oQb3gHdOHAEFni
         2GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qgAQJ1wpHvLIvOj/hCuqnhy12lLUQbyhSNgCCd5h3Y=;
        b=NzrfQTryj5JYPTlMB9vkOBAmT1CAWTCHSZq+/z3wgRs3VF+AvCEwGU1Z2VHtHbj5ie
         1GRGi/+Dd+dknVBD9aIrSsixgNqyglS+N4SXWZux7fIHAFRiuC1S0T0diRI7oLAb0PQa
         2xOB8zEDihDrj/axvZwbg6BAvBlVoVOSVhq/KfIB3iU5KdNjY4lZfKPrFDLM9VXNc28B
         fl4tLFiG+AdUBuLbSvA6aXDkvzgNcUT8RTCx9kKho+Lb0n5/2r5eb9H5htujHhxF55lN
         nxVEpdJoNiKdnA9fPcis+j9V8iZk5hJ3yiqabDHpXDqWRmtIaB1/YEcVQ8FwS4N/9Co/
         33ug==
X-Gm-Message-State: AOAM530BeeV+LiLzn6CqT83HhJyifl9rS5LdUFQCRoKZxbNeKOK9wpRj
        lDspzNTtW3BCK5nUmpufzFIhSqpU7mDlvCAeVFVlxxSeEnL6HQ==
X-Google-Smtp-Source: ABdhPJzKJhfjmRYHqQYrOlq/MLI0ShaxzU6HoTKlq/ijs2Y/zV+QWsp2fQ7mWJjplGeGkzzqOA55Jkal3wlLr8OLYDQ=
X-Received: by 2002:a19:dc0b:: with SMTP id t11mr22037434lfg.233.1617723223596;
 Tue, 06 Apr 2021 08:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210321150358.71ef52b1@imladris.surriel.com> <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com> <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com> <CAKfTPtC2Cnr=SoD9t+dLh01ux_bc8PAcHTXxxiBqbqykLphBNw@mail.gmail.com>
In-Reply-To: <CAKfTPtC2Cnr=SoD9t+dLh01ux_bc8PAcHTXxxiBqbqykLphBNw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Apr 2021 17:33:30 +0200
Message-ID: <CAKfTPtDMnR+SdW1SXRyRp=JHKoiNuHOwWCvW-0ywiXaQF2Op9g@mail.gmail.com>
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

On Tue, 6 Apr 2021 at 17:31, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Tue, 6 Apr 2021 at 17:26, Rik van Riel <riel@surriel.com> wrote:
> >
> > On Tue, 2021-04-06 at 17:10 +0200, Vincent Guittot wrote:
> > > On Fri, 26 Mar 2021 at 20:19, Rik van Riel <riel@surriel.com> wrote:
> > >
> > > > -static int select_idle_cpu(struct task_struct *p, struct
> > > > sched_domain *sd, int target)
> > > > +static int select_idle_cpu(struct task_struct *p, struct
> > > > sched_domain *sd, int prev, int target)
> > > >  {
> > > >         struct cpumask *cpus =
> > > > this_cpu_cpumask_var_ptr(select_idle_mask);
> > > >         int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > > > @@ -6136,23 +6163,32 @@ static int select_idle_cpu(struct
> > > > task_struct *p, struct sched_domain *sd, int t
> > > >
> > > >         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > > >
> > > > -       if (sched_feat(SIS_PROP) && !smt) {
> > > > -               u64 avg_cost, avg_idle, span_avg;
> > > > +       if (!smt) {
> > > > +               if (cpus_share_cache(prev, target)) {
> > >
> > > Have you checked the impact on no smt system ? would worth a static
> > > branch.
> > >
> > > Also, this doesn't need to be in select_idle_cpu() which aims to loop
> > > the sched_domain becaus you only compare  target and prev. So you can
> > > move this call to select_idle_smt() in select_idle_sibling()
> >
> > After Mel's rewrite, there no longer are calls to
> > select_idle_core() or select_idle_smt() in select_idle_sibling().
>
> select_idle_smt() had even disappeared that why it was not in
> select_idle_sibling
>
> >
> > Everything got folded into one single loop in select_idle_cpu()
>
> but this is done completely out of the loop so we don't need to
> complify the function with unrelated stuff


s/complify/complexify/

>
> >
> > I would be happy to pull the static branch out of select_idle_smt()
> > and place it into this if condition, though. You are right that
> > would save some overhead on non-smt systems.
> >
> > Peter, would you prefer a follow-up patch for that or a version 4
> > of the patch?
> >
> > --
> > All Rights Reversed.
