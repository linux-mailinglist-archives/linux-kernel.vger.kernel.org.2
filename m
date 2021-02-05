Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3031146E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhBEWF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhBEO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:57:43 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D0C0617AA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:27:01 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t8so8404493ljk.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynxDYVPi5H1dR4wRWFtBqhxHAhdQT1a04o63peTIaaM=;
        b=YAi67F9U6c6htAnlyoN6tFU4wduGBfNlZzfU3yC/5iyl8hBcLXSIoUzqj2yvInpXnT
         BKRoPH+JleS0le4E5Agh8m2Jtlw6aKuGefKMhDM5Er5kQqFRanNA3b7S5KlbjzSpU1nQ
         yeTr7l4X8rL9MA0PaXXRagCH++FLemtMlx/UaYiyoblJY0hute5uPrxdPLSUubjP9k70
         ye7fi57oliwzf35tTQQrj52oIUVrvtE4n3Ng1WrSlo/OkoVzrOhs1fbl0DhlK0lmcdha
         aAxG33YvefGPQca9OZwlNAo6M49PK7KqTma5PlmEY9dsNoi0jfMjIW0so7le75KuIzNa
         x35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynxDYVPi5H1dR4wRWFtBqhxHAhdQT1a04o63peTIaaM=;
        b=JeDzJHDc8RHD4yY6sWZ6x+d4jBC7F4y2m2oLVOgIWpkqgOA5YFdtF1iEj6YBUi9CoE
         07trzJKi9vWjwEXcQpwi4V6VWzJWlMcLOOnNTNr4C4AVPKQuRZPaWylC98JT558sHQqo
         cowmTspU+QcSQHnWj4T09XJJfOe4V0+GL8h1H8tFEPUqU9YnKi6aUkpCCqG4xlcWtRv4
         JaVFvKj4EctMzmASnMz3tBl1r+8W/mg4Wiv9zfxPMia2bXSDCFbebufP1aFxgsR4Poun
         GEExdcmX8jqWMmPw+E20tD9usgTegAm45gl1V3MIsYlLAVl0gSfAqkchxilECA5++m6T
         nQhg==
X-Gm-Message-State: AOAM531DfUAh19gGSTJrd50R1MgR7WM8/CRB4lrQzCe+x4TMsu4PcCuV
        t7jiF6wmrthq/oA1axNSWGnQX021g5ENo01KtIYIShlk6l0=
X-Google-Smtp-Source: ABdhPJzycFnbkaty8Maun24Kain0zqFZDgyG+wTJpbPGbvV2f1PY5Nfi8nkAOadmoXhtTdI8mFn7wL4wfJdufUmKcLU=
X-Received: by 2002:a2e:7605:: with SMTP id r5mr2714028ljc.299.1612535659229;
 Fri, 05 Feb 2021 06:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-2-valentin.schneider@arm.com> <CAKfTPtDrKrkZBQuaFSGvRo=aQAdF0vugxWervQpWeza21XL=yw@mail.gmail.com>
 <jhjy2g21ufk.mognet@arm.com>
In-Reply-To: <jhjy2g21ufk.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Feb 2021 15:34:07 +0100
Message-ID: <CAKfTPtAYHG4COi8WTvm501AP9y48sOtjOqqDP+uOv4vLCNbbFw@mail.gmail.com>
Subject: Re: [PATCH 1/8] sched/fair: Clean up active balance nr_balance_failed trickery
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

On Fri, 5 Feb 2021 at 15:05, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 05/02/21 14:51, Vincent Guittot wrote:
> > On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> When triggering an active load balance, sd->nr_balance_failed is set to
> >> such a value that any further can_migrate_task() using said sd will ignore
> >> the output of task_hot().
> >>
> >> This behaviour makes sense, as active load balance intentionally preempts a
> >> rq's running task to migrate it right away, but this asynchronous write is
> >> a bit shoddy, as the stopper thread might run active_load_balance_cpu_stop
> >> before the sd->nr_balance_failed write either becomes visible to the
> >> stopper's CPU or even happens on the CPU that appended the stopper work.
> >>
> >> Add a struct lb_env flag to denote active balancing, and use it in
> >> can_migrate_task(). Remove the sd->nr_balance_failed write that served the
> >> same purpose.
> >>
> >> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> >> ---
> >>  kernel/sched/fair.c | 17 ++++++++++-------
> >>  1 file changed, 10 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 197a51473e0c..0f6a4e58ce3c 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7423,6 +7423,7 @@ enum migration_type {
> >>  #define LBF_SOME_PINNED        0x08
> >>  #define LBF_NOHZ_STATS 0x10
> >>  #define LBF_NOHZ_AGAIN 0x20
> >> +#define LBF_ACTIVE_LB  0x40
> >>
> >>  struct lb_env {
> >>         struct sched_domain     *sd;
> >> @@ -7608,10 +7609,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
> >>
> >>         /*
> >>          * Aggressive migration if:
> >> -        * 1) destination numa is preferred
> >> -        * 2) task is cache cold, or
> >> -        * 3) too many balance attempts have failed.
> >> +        * 1) active balance
> >> +        * 2) destination numa is preferred
> >> +        * 3) task is cache cold, or
> >> +        * 4) too many balance attempts have failed.
> >>          */
> >> +       if (env->flags & LBF_ACTIVE_LB)
> >> +               return 1;
> >> +
> >
> > This changes the behavior for numa system because it skips
> > migrate_degrades_locality() which can return 1 and prevent active
> > migration whatever nr_balance_failed
> >
> > Is that intentional ?
> >
>
> If I read this right, the result of migrate_degrades_locality() is
> (currently) ignored if
>
>   env->sd->nr_balance_failed > env->sd->cache_nice_tries

You're right, I have misread the || condition

>
> While on the load_balance() side, we have:
>
>   /* We've kicked active balancing, force task migration. */
>   sd->nr_balance_failed = sd->cache_nice_tries+1;
>
> So we should currently be ignoring migrate_degrades_locality() in the
> active balance case - what I wrote in the changelog for task_hot() still
> applies to migrate_degrades_locality().
