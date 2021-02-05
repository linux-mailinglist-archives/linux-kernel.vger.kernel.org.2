Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D36C310E7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhBEPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhBEPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:36:20 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C6FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:18:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id v15so8580536ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETEu8SRiv768wD9x6Q9hbqdexnK90s+WagGrWdw7ytU=;
        b=aelE/Iy+SRzQrWieFDYZWj/zHe0/VVqulpFVQOh+3ux64+/1nLCa4N7eRQ1mphTG4A
         SF1+eQ3ixfZD8ZtF6AZda6qa9YGHvCC0qY+X9SPEFkepvuQl2L8BU7PILJazNDXWvlu9
         AEHo81g6BtQ9EzRcRBs7K+Ecq5fY+nBzwZMNeg1CsygWvSAtGmqdYlz1axQ4PW2HWjwm
         oXIHhuXWBuuZDwAcQkuJ710ljsIDO2Cvx/2pyObed2RjGIdU21GmZ3/ahTnUE16Sqv5Y
         lz1wtKVxkcDrZOJBEbtrnCqc0tUHJFPNeBd0S0FetWIpkgtCcWXjLKN6LoIbZuC2O5ZF
         Xxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETEu8SRiv768wD9x6Q9hbqdexnK90s+WagGrWdw7ytU=;
        b=e4WryDDGvZeMVsGfSH/Fmq1fhTQ10NYcoOXUSDRmfUdjO8U4WxsyoB9WGWmyddnpp8
         H+vRG5YdeEqjMiIGPZP1aFVebkQbKgOsiaP8OXjL2Q+56yai8rcrn7gft2r8ZjpJ/WM5
         x6QBRwxwB9sxMHad+Y2tN26F/aGxMGpQq3yd7PXTEbSFzbFg0piz7DCS2173BnCH9ie9
         bIgSxxouLvHfoOWmRtFNRNfTBNMEdHMeQKIAhD0uwGEKff8/aWSRWysoqcptd5NYRg7j
         nllASvJHSMIHwMtIFiYrFcQW4Na8j3PeXrpdKaSvCSVol22Yg7WMw2OjIRSp74pyUkQe
         pjwA==
X-Gm-Message-State: AOAM530yiGrObluHnW7+AdNy6h9zs1g1yQmzJ3lMLoDlzQLSyoFG9eDI
        CfXReXwDjHlkgjJvSi1pORXJ0Omfq8LuN/YP1VW7rQ==
X-Google-Smtp-Source: ABdhPJxDRyraTwtaDDnundRg/onC1U8GmWnJalwGu/B9LrGnq3Op722U17r6gpw0qIDEQnid6L2KkJ1BJxEhZIUBMOQ=
X-Received: by 2002:a2e:b354:: with SMTP id q20mr3202243lja.445.1612545480076;
 Fri, 05 Feb 2021 09:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-4-valentin.schneider@arm.com> <CAKfTPtADn0X8=ENfvG5dhzM1KbTD+JCCoOm-i8=bVkh0ZBM2Xg@mail.gmail.com>
 <jhjv9b61md0.mognet@arm.com>
In-Reply-To: <jhjv9b61md0.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Feb 2021 18:17:48 +0100
Message-ID: <CAKfTPtB_aJE0uDmARvKGe8_oX0Goaada_C5HKy7aaTbFGLxU-A@mail.gmail.com>
Subject: Re: [PATCH 3/8] sched/fair: Tweak misfit-related capacity checks
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 at 18:00, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 05/02/21 15:31, Vincent Guittot wrote:
> > On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> During load-balance, groups classified as group_misfit_task are filtered
> >> out if they do not pass
> >>
> >>   group_smaller_max_cpu_capacity(<candidate group>, <local group>);
> >
> > group_smaller_max_cpu_capacity and  group_smaller_max_cpu_capacity are
> > removed in the next patch. Merge this and the next and directly remove
> > them
> >
>
> OK.
>
> >> @@ -8253,7 +8260,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
> >>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> >>  {
> >>         return rq->misfit_task_load &&
> >> -               (rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
> >> +               (capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity_orig) ||
> >
> > Why do you add a margin here whereas there was no margin before ?
> >
>
> Comparing capacities without any sort of filter can lead to ping-ponging
> tasks around (capacity values very easily fluctuate by +/- 1, if not more).

max_cpu_capacity reflects the max of the cpu_capacity_orig values
don't aim to change and can be considered as static values.
It would be better to fix this rounding problem (if any) in
topology_get_cpu_scale instead of computing a margin every time it's
used

> I'm guilty of doing two things at once here: replace existing users, and
> convert callsites that should be existing users. I can split the conversion
> in a separate patch.
