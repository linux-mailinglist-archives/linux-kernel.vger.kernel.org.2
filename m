Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85478392F90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhE0N2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbhE0N2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:28:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BFAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:27:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v8so75663lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTuXJyS12cv4LuTitjmTblp9RTdGyOUhTUwwFkRbaxo=;
        b=AJ+au7Zh1JItYixxt8CVmhgXABNB1TBRD96nwd7v6HIk1hbvij2qP1pFVm9dQW94jL
         Ad4wt4EC6yIDuNF2XfRni4y26vgHLi65VqXMa4kw441X2uCb4/6NedBIi3R6UE6Dr0YQ
         i+DlbxK8dr8MslOOX4NfU1BnxVFRhhBcsgOFWiEyfygr8sK/0z+mfC5EfF0XpIUfbawa
         Y0CpFg3fi7lYBHz33pW2EHxumsJmH0cpyQXLZzzKmHR6cTE+Z0LBDAaT7eiEurMfzb9v
         lyzhV+WJ7fs0QfPh61Ug1KgIY4TYCAC++mEeYY8riXoNo20IO1NSnkT32rBzwsgu1QJO
         Y/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTuXJyS12cv4LuTitjmTblp9RTdGyOUhTUwwFkRbaxo=;
        b=Clh/txCU/N0c0jxuZA6HvDCESlz42O1T04EavR7lzUqI8TGzrvGRiPxSb7oA4si2TI
         uZj7mDCYF3QMXQZvPp+n1ucZvgoXEb3x44c4eeYmP7rcGzSHL8REMr5DfRSxU7wFbdBW
         4WQqcpoCjLyzCazIaI/aC1+0qHYnig8BxHWW/bPstH8D+bWTKTy74K+XXKFGVjDOk2BB
         Yn3lC7rxDVabpNXUgj7wdaOrlwwM+C174gdU+N7mj8ibuOtQSSs8IXeKayiI1CMbf0AZ
         +JuQSwhBypnJWdkbe736CgO2KZmeztjrLJjApwVU0od5W1QYMXDlSj12j/LfSjJ4j/CZ
         hgJA==
X-Gm-Message-State: AOAM530HBWyPli/pgLYsrW92aSj/+5pMXujstp0tj65uHNATKPAKz4DJ
        JloaQKP0dG5A67MCE/a9s9rBz7NA2U4neLE1QcfmkQ==
X-Google-Smtp-Source: ABdhPJz/q09HNLnUEmeh/Q10Ks41whHmavWWgbWHeOXqKICOlbiy57jJjnrEK2Q7JVhJ63EqW3jDafbxmYM3u8/s+Q0=
X-Received: by 2002:a05:6512:2205:: with SMTP id h5mr2440251lfu.233.1622122032719;
 Thu, 27 May 2021 06:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-4-odin@uged.al>
In-Reply-To: <20210518125202.78658-4-odin@uged.al>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 May 2021 15:27:01 +0200
Message-ID: <CAKfTPtAi9XTyLGrCqU9A-SMoPVqd45N1Tcytqj1E6SMjb4ffxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: Fix ascii art by relpacing tabs
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 at 14:55, Odin Ugedal <odin@uged.al> wrote:
>
> When using something other than 8 spaces per tab, this ascii art
> makes not sense, and the reader might end up wondering what this
> advanced equation "is".

Documentation/process/coding-style.rst says to use 8 characters for
tab so we should not really consider other tab value

That being said the numerators and other parts of the equation use
spaces whereas denominators use tabs. so using space everywhere looks
good for me

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e7423d658389..c872e38ec32b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3142,7 +3142,7 @@ void reweight_task(struct task_struct *p, int prio)
>   *
>   *                     tg->weight * grq->load.weight
>   *   ge->load.weight = -----------------------------               (1)
> - *                       \Sum grq->load.weight
> + *                       \Sum grq->load.weight
>   *
>   * Now, because computing that sum is prohibitively expensive to compute (been
>   * there, done that) we approximate it with this average stuff. The average
> @@ -3156,7 +3156,7 @@ void reweight_task(struct task_struct *p, int prio)
>   *
>   *                     tg->weight * grq->avg.load_avg
>   *   ge->load.weight = ------------------------------              (3)
> - *                             tg->load_avg
> + *                             tg->load_avg
>   *
>   * Where: tg->load_avg ~= \Sum grq->avg.load_avg
>   *
> @@ -3172,7 +3172,7 @@ void reweight_task(struct task_struct *p, int prio)
>   *
>   *                     tg->weight * grq->load.weight
>   *   ge->load.weight = ----------------------------- = tg->weight   (4)
> - *                         grp->load.weight
> + *                         grp->load.weight
>   *
>   * That is, the sum collapses because all other CPUs are idle; the UP scenario.
>   *
> @@ -3191,7 +3191,7 @@ void reweight_task(struct task_struct *p, int prio)
>   *
>   *                     tg->weight * grq->load.weight
>   *   ge->load.weight = -----------------------------              (6)
> - *                             tg_load_avg'
> + *                             tg_load_avg'
>   *
>   * Where:
>   *
> --
> 2.31.1
>
