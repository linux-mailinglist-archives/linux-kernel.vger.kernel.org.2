Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDABE313B12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 18:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhBHRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 12:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhBHPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:30:09 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E2CC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 07:29:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b16so1836344lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCncr06HFR/a+c50zDJYOOKsupY7QedQ1/Znu9nx90I=;
        b=rb48P4AVmUWpoRDfnjOU9W9cbB0dSXJW6wNynZnvbBVY9L8mLew4SrLorwoRK4JTIe
         xD4xcQa8t0+9GqSuO9aYuz1iF/obqxZw2n1MiFDZa4b2ZROUdCadatFj6eM5nmbX28WT
         zIuBrM7k2VO8CnVAObKS7JMS9nkpAb+iHAcuaF4HXlJTVuv4Eekn+kXVVJrDVXgFEyqh
         YkfQd1O24YSAOMwgIIyINhaoSAgN6jFcGQ+ZQd57/+WcCwqsPqRDxDAqI7Oe1JnSTjFL
         Qjbf/0iVYdhAyc5sbYR9PIEswRBghE/yq3YPMzircnpQPDCry5BO9WJZUbL2PrNaeYkF
         2tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCncr06HFR/a+c50zDJYOOKsupY7QedQ1/Znu9nx90I=;
        b=WycuQDDFJblPYa8A1+3EiCxMML9lOUzUCbPaFUO02Ug1kmm2hmYn1LtT26l6lA40nE
         fqkQsNYc4Zzh3fSSZ6bNwSV81DRTDR3Eadxo0TtIz0GU/nAbpcelBf7ZLWdYlgiq5A/d
         orFs1Rn7c6e4Dt135p5SI6ebocjTqtV50D9I58AzJomqaeEFZxVCAvCgcvgTX5g2RsbZ
         FvPW/tZhLq+0IZVw1gXlBKP0MJbVdNh3I1KCt3FSTwhL5/kSnx2u3MVAhNNAEyOvaNHq
         hT3bGvJ0Hy+Ge76Q2YHqnUe6EHDnmClrUwPRXChQrnfX9LKdsNBW7xOwshp33li32OiU
         pxCw==
X-Gm-Message-State: AOAM531yDsQRL5oS1SmXESp7ArzIXUKpIW7m8me/n/UT9Gtrlm+oTlzM
        inLZ9PcGzpxsJb8d/PBDu5ILrxN60cQgxUAFe1Y9RZ9h2TpkAQ==
X-Google-Smtp-Source: ABdhPJwTwyGmBeQr/tVG5WDM+5H5Wq92fJ08FaXI2gPeQbzGYl/SXcnxl68K4JcwFTK62feKa3pFu4T0Eu0dGDL9LMw=
X-Received: by 2002:a2e:b355:: with SMTP id q21mr1498593lja.209.1612798162273;
 Mon, 08 Feb 2021 07:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-4-valentin.schneider@arm.com> <CAKfTPtADn0X8=ENfvG5dhzM1KbTD+JCCoOm-i8=bVkh0ZBM2Xg@mail.gmail.com>
 <jhjv9b61md0.mognet@arm.com> <CAKfTPtB_aJE0uDmARvKGe8_oX0Goaada_C5HKy7aaTbFGLxU-A@mail.gmail.com>
 <jhjsg6a1doz.mognet@arm.com>
In-Reply-To: <jhjsg6a1doz.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 8 Feb 2021 16:29:11 +0100
Message-ID: <CAKfTPtA0FXsz7_T+t4WfYjhwuGNeKzbJJJoZNkD6Gz6yDf_ebA@mail.gmail.com>
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

On Fri, 5 Feb 2021 at 21:07, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 05/02/21 18:17, Vincent Guittot wrote:
> > On Fri, 5 Feb 2021 at 18:00, Valentin Schneider
> >> >> @@ -8253,7 +8260,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
> >> >>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> >> >>  {
> >> >>         return rq->misfit_task_load &&
> >> >> -               (rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
> >> >> +               (capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity_orig) ||
> >> >
> >> > Why do you add a margin here whereas there was no margin before ?
> >> >
> >>
> >> Comparing capacities without any sort of filter can lead to ping-ponging
> >> tasks around (capacity values very easily fluctuate by +/- 1, if not more).
> >
> > max_cpu_capacity reflects the max of the cpu_capacity_orig values
> > don't aim to change and can be considered as static values.
> > It would be better to fix this rounding problem (if any) in
> > topology_get_cpu_scale instead of computing a margin every time it's
> > used
> >
>
> That's embarrassing, I was convinced we had something updating
> rd->max_cpu_capacity with actual rq->capacity values... But as you point
> out that's absolutely not the case, it's all based on rq->capacity_orig,
> which completely invalidates patch 5/8.
>
> Welp.
>
> Perhaps I can still keep 5/8 with something like
>
>   if (!rq->misfit_task_load)
>           return false;
>
>   do {
>           if (capacity_greater(group->sgc->max_capacity, rq->cpu_capacity))
>                   return true;
>
>           group = group->next;
>   } while (group != sd->groups);

I don't catch what you want to achieve with this  while loop compared
to the original condition which is :
trigger a load_balance :
- if there is CPU with higher original capacity
- or if the capacity of this cpu has significantly reduced because of
pressure and there is maybe others with more capacity even if it's one
with highest original capacity

>
>   return false;
>
> This works somewhat well for big.LITTLE, but for DynamIQ systems under a
> single L3 this ends up iterating over all the CPUs :/
