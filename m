Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0269640405D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352332AbhIHU5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 16:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhIHU5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:57:21 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7220AC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 13:56:13 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id y16so440843ybm.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLU6g2s6H+McVemxtCFKBzh3Cbqjw4HVZJVWcfwOoOk=;
        b=BpTeuYY6SB4xffTZslMJHB3c2g38zWEo43Cw/8ZX+rXLLKd3EzxpG5o0dpesz3O9nT
         HwB4N8eHO5odV2AxPyfmVCNyNkZ5DAv+j8GdGIJQm2SAZbFA8YhBbJnt8ibL2wmqPVRb
         tKxdatgzDvHhwWgWwm5wjIhSf2upPe3J3ok2fjc7L+fFM/MoREHsHucCAXefE5uUtaX9
         ec/Wei/r5nGKffDgsuB9DmUgWV67IqQ0oeCpgkeylDAZPvlhG1BcxQmzGjleCWKStP0L
         smpTHfrTDl/2Tk+By1lh4ieCowj35LrJR4mv3BXLiowQKLHRKzmaQ49zo1W4iugmK2v7
         sdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLU6g2s6H+McVemxtCFKBzh3Cbqjw4HVZJVWcfwOoOk=;
        b=GjJShIFlFf5pnOJkI9E1KPRoJtnrqwkgzLKB6xO2cR8OWbpi7bNBTd48KC8j5sbGE8
         wQLukOvchF68Sp3AantNw9QP18pkBhKlxj4tzyOXsh3PF2f6lGYaoK40AxmvdgA+Krxz
         MLhBnni6vlOYJbPTAFChVaja0hGSXPFsJmKO3V2XBOf3ZelSR0ade4wQdGpng2ygS6uD
         7e0odLNAWuhQZwg1MQgIFfTgwtdkZVu7Wnhc0aa6IKX3hKhxsbemnZyGFEeregn42VM8
         5/w+OUQCvceYxtPdBGI1bF0y7vWeH3DAEuBqbxUGMbMylW4++6LcblIBk2gez52TYpJU
         Corw==
X-Gm-Message-State: AOAM533BT+GmIcAFCaeuETMNlIcJzKye6M8uj9Vv+xdT6d3xjBzHPfcA
        Vv8cK/OQGPNOBgyblxgmUzEmqewAfjRplaj0/z3ZCQ==
X-Google-Smtp-Source: ABdhPJy/e80Tc88U8Mj2iMmoMwyCRAn2a5YgOzfg49rO5h/prnJ1yBfM59I3VQOOgL6BwQ4cX2JLiLwGWP/BBzoREjs=
X-Received: by 2002:a25:9201:: with SMTP id b1mr291189ybo.354.1631134572425;
 Wed, 08 Sep 2021 13:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210908203946.1261798-1-daniel.m.jordan@oracle.com>
In-Reply-To: <20210908203946.1261798-1-daniel.m.jordan@oracle.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 8 Sep 2021 13:56:01 -0700
Message-ID: <CABk29Nv3_nu_5QqHriTw1PXVywSvwF1Ds0+JWos3avLbn+OVQA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix se_is_idle() for !FAIR_GROUP_SCHED
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 1:40 PM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> se_is_idle() unconditionally returns 0 for !FAIR_GROUP_SCHED.
>
> Check whether the task is SCHED_IDLE instead so buddies aren't set for
> such tasks, as was the behavior before 304000390f88.
>
> Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Thanks!

Reviewed-by: Josh Don <joshdon@google.com>

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff69f245b939..8b22665bc18e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -497,7 +497,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
>
>  static int se_is_idle(struct sched_entity *se)
>  {
> -       return 0;
> +       return task_has_idle_policy(task_of(se));
>  }
>
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
> base-commit: ac08b1c68d1b1ed3cebb218fc3ea2c07484eb07d
> --
> 2.32.0
>
