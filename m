Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4692745D6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353470AbhKYJTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350557AbhKYJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:17:41 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB25C06179F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 01:06:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu18so14726089lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 01:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuyT5MhpI9ppmpKsteGxVu1Iy1mqd48VQXHzLfZb6M4=;
        b=vAjOj0nGlEZqAnvd6351mA9cpegF9uhcBDtIIOFBPleapVU4bNgpRX2Z65icC4MkXz
         +g2nQ8+gQq094c75bXsGYSp6NBcpOdPKXnfmsIjLGJxk8TmdX/pzpRGS0iBSpmyXC56b
         GrnUhcqXnh7aHCpsoH9Yy0668mZD5YfAQLbBDllZimyIs7WU4o0Ng7oPmXJAZx2b824G
         d9ChwV7S1PkqmD55eyzhsmtiypCAfmSteJJo8CDmXrOaFFVRpW2p3YOsGAQbBOpK06pr
         I6+queuRczPrixGXl0OpdkTMhvVIo62MlzRhLXIqXKyf79kKrqENCj13ukcyOO3GH0Yo
         R91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuyT5MhpI9ppmpKsteGxVu1Iy1mqd48VQXHzLfZb6M4=;
        b=HE9jO1ini1NHos4w+2a40snxTcznkU2aYKyqAu8jm39lWU3sfck313TelF31aFo/TK
         NExK+1VBdaChkxtmq2Saib//nAMoD8P0mELsj9gBtTsk3dse6sxR1vKYHjjVYN9LkNsX
         KptKDbcwIQ/IyCBDqUNrlYF+UFDinGb3SrmYjUf+3R5p0W/rRBr8tuXyfKWNd8v9VeJN
         SqrOxJNVVbuoSt2ty8n/grUR9GQD5hngZsaVpQZyVaUe5mdwLgA5qpqOclQ5Jxt/KoqK
         vLikaBKFigvXl0g0AFUV5fVQ89vy0PB7N1DGOH9ZDOV9MoVJJrjRsavvqFZDnM+8eD8p
         Si3g==
X-Gm-Message-State: AOAM530wdYu7ixTixSVQ+cOHv4kFyrj1MBhAiQYV0Bjvzs0JqOc2xzSJ
        88mWMzuz75Jm9SRwNzaHQvvyDVZVN4I6fUHh2fOjCg==
X-Google-Smtp-Source: ABdhPJzA46hOrwhv672eTlM7pDxAlQPYh+gPm3DTWxKGj0mnUYamyM625KyPYEZDr4XZPrEQhvGVRgrfYJFwgGz8M6U=
X-Received: by 2002:a19:fc08:: with SMTP id a8mr22846107lfi.645.1637831169319;
 Thu, 25 Nov 2021 01:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20211124154239.3191366-1-vincent.donnefort@arm.com>
In-Reply-To: <20211124154239.3191366-1-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Nov 2021 10:05:58 +0100
Message-ID: <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a task
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com, Valentin.Schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 16:42, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> select_idle_sibling() will return prev_cpu for the case where the task is
> woken up by a per-CPU kthread. However, the idle task has been recently
> modified and is now identified by is_per_cpu_kthread(), breaking the
> behaviour described above. Using !is_idle_task() ensures we do not
> spuriously trigger that select_idle_sibling() exit path.
>
> Fixes: 00b89fe0197f ("sched: Make the idle task quack like a per-CPU kthread")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 945d987246c5..8bf95b0e368d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>          * pattern is IO completions.
>          */
>         if (is_per_cpu_kthread(current) &&
> +           !is_idle_task(current) &&
>             prev == smp_processor_id() &&
>             this_rq()->nr_running <= 1) {
>                 return prev;

AFAICT, this can't be possible for a symmetric system because it would
have been already returned by other conditions.
Only an asymmetric system can face such a situation if the task
doesn't fit which is the subject of your other patch.
so this patch seems irrelevant outside the other one


> --
> 2.25.1
>
