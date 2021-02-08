Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F3313DA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhBHSgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhBHQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:22:44 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3F3C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 08:22:03 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u25so23193374lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdxvUtXp4Dqblal4t1woOOfdpya8vhckK+KFXfo2gXU=;
        b=HIT5+1Q26PvRfVDEutrb9AqwApucsxmSbI4kwALzoYreCOhm/6moCbIhAuaLOzpFuS
         zNswZo5S2hyTzJ1Jc60ZjAEguHkds3u9AynesK00aUPsTa/WAMm6LJzSC7yesiMxmDKR
         VC7gfCFvp/bIaDaAOTdSYy9j5HNdWm9dtyraR+zGpID6nbu0XD7ahplJUeDMkgLD0PqL
         XgSw3iGajHJYQIdjF89Jk2SI0M2Zwa1h0vfg2biuI/T5w53vpbfWN/QLDJWGM+Sdgvkf
         jGAnCNfUSbWNVSDGUWJspPEM5lsmbVTuk5A5tJTYEFyYxsVSVnf54szJggy1yETVXkwa
         mh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdxvUtXp4Dqblal4t1woOOfdpya8vhckK+KFXfo2gXU=;
        b=YpYwupUhVyk7unhMwqOckbLi55lpBCHhdlagaIXcIyBwtAQE3ZoIriKhyCwEmsuolM
         BR5v6x+hEr1ouRbmtk+B/YbhJtO/ZL7/iyknCDu9E05yaEfATozYfJOW7hDkS9pf7cIm
         9uKR7wsYsMnc2mmydiQA9VrBIwbQ3lIcB6RLEReW0kCYb/lLqb2QvAOT6BUz72gRPOvg
         Upibe/2vQ3E+b2RY1NKPY/osZUSnk1AfdWJ21Snsyc8zyyOxC7bAXSi6CUjU5vBeHtEC
         GuftZrTJbL4lgdwaemZR/NZA5cBevfbJSsgww9nYwQt2lQrbKWtCL1vjOPYom76c/Fwe
         dOkw==
X-Gm-Message-State: AOAM531yO5k3peVIzBV46cxAecfm7gG+b9S6yJVyviJAYrToWTvJnbJB
        DAXegRMyPFOM29kFUFKWxR+GjG9GMPGt7DdhhOyNVw==
X-Google-Smtp-Source: ABdhPJxFK26SWm08SQ5mP8Ms278CGu34ExsH5M+WMpB9/2JwB75TGg06wM9r8eLLkeRz/QzWdcryxeUT4N2rrpSNMFs=
X-Received: by 2002:ac2:5e62:: with SMTP id a2mr3063991lfr.277.1612801322234;
 Mon, 08 Feb 2021 08:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-9-valentin.schneider@arm.com>
In-Reply-To: <20210128183141.28097-9-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 8 Feb 2021 17:21:50 +0100
Message-ID: <CAKfTPtDBPREA2oBXZ0=-396Dxh5WMYgNTF+=6d_+K-WVjq3Sag@mail.gmail.com>
Subject: Re: [PATCH 8/8] sched/fair: Relax task_hot() for misfit tasks
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

On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Misfit tasks can and will be preempted by the stopper to migrate them over
> to a higher-capacity CPU. However, when runnable but not current misfit
> tasks are scanned by the load balancer (i.e. detach_tasks()), the
> task_hot() ratelimiting logic may prevent us from enqueuing said task onto
> a higher-capacity CPU.
>
> Align detach_tasks() with the active-balance logic and let it pick a
> cache-hot misfit task when the destination CPU can provide a capacity
> uplift.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cba9f97d9beb..c2351b87824f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7484,6 +7484,17 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>         if (env->sd->flags & SD_SHARE_CPUCAPACITY)
>                 return 0;
>
> +       /*
> +        * On a (sane) asymmetric CPU capacity system, the increase in compute
> +        * capacity should offset any potential performance hit caused by a
> +        * migration.
> +        */
> +       if (sd_has_asym_cpucapacity(env->sd) &&
> +           env->idle != CPU_NOT_IDLE &&
> +           !task_fits_capacity(p, capacity_of(env->src_cpu)) &&
> +           cpu_capacity_greater(env->dst_cpu, env->src_cpu))

Why not using env->migration_type to directly detect that it's a
misfit task active migration ?

> +               return 0;
> +
>         /*
>          * Buddy candidates are cache hot:
>          */
> --
> 2.27.0
>
