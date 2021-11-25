Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B7B45D6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351362AbhKYJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352096AbhKYJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:19:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51782C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 01:10:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so22605577edu.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 01:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QREKv3hn/IJBRvNLbivzYnjmr7KgAORbNEwo67/6o/Y=;
        b=dNQti9uaycysooIHqYIAHZFfdkQkHKGNL6yfGSeTLm+pzAl4FH+PwRB1uVHtI5HQqw
         Nh68Eez1Fwi3Lgi1c8wTIlBGii3ZFHKcVRhSEHxASX0d+ReAy0AkwBa7aw+KJgTSjpq9
         pOIIpHK2hkX7S96/xv6OsmHJ64MR+pButsK6qkLXYLJV2yXhqWxM2t0YEkhI+J/hk3n8
         EtcerbrbeIdvowr9AmvE2fwT9zQpEiA5Hssxf1CIXSh//D4s9w4eYQ0FkLgShBsfVvJR
         AX0HCrTOLqq9W9Fn2sH/8EaqjQzbXxQyASE74Sflspubj7kaYYF++6022gl+Ynbrbl3f
         vYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QREKv3hn/IJBRvNLbivzYnjmr7KgAORbNEwo67/6o/Y=;
        b=GxVSX85RDvFEO/MhdE0d9wnUYn0S39UqFNEmlnOLq+nTLxGrwk9ESJ1aZntfw8fScb
         2FB0c1YUouNtys71tE95lkTE2fUiVvw3dR3qpLbSWhqRcvFKvmjcKuV3M5PCL7Bd1tgE
         0V9ebwPvbTetBlUKntjhNbRtoeyMMtjnMtdHlmD3iOzS88r0qptdGLdt3D+QavoTN/n7
         Y6oBefwczRJ0MTvENyskPgmIVVF48wkF4uu+L3oU3mlfZlpZSqyDBUQQNRW9jWE1JnXR
         quUBWrsGLSPngXGpVo96TTkjoSaoxYxQWgxArShrax0GvRVwUw/3fJWLIt/34mu+zXir
         7amQ==
X-Gm-Message-State: AOAM5316bGJ5RPDAq0PAZgmOBI5Nn8Jd7tDMCBHZn/3VOUCjK3FPBxVl
        0Sfh9IZK830wT9bVNoyBxYs5BDPdl8l+rGy7Z/iqzQ==
X-Google-Smtp-Source: ABdhPJwbiRr1P7y46EDFnMHmb3SJpt8ElgqHMG/9TgDN3CvmV4A23IRiuJG2YC/o0F2mZ3hqzHdm0DtB9mQNCoMZSZ4=
X-Received: by 2002:a17:907:9723:: with SMTP id jg35mr31122541ejc.329.1637831413802;
 Thu, 25 Nov 2021 01:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20211124141435.3125147-1-vincent.donnefort@arm.com>
In-Reply-To: <20211124141435.3125147-1-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Nov 2021 10:10:01 +0100
Message-ID: <CAKfTPtCrFoH-Kh0FAX_mWyjUymeHjCEOmJutL9qBpMftRe4Bdg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix per-CPU kthread and wakee stacking for
 asym CPU capacity
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com, Valentin.Schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 15:15, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> A shortcut has been introduced in select_idle_sibling() to return prev_cpu
> if the wakee is woken up by a per-CPU kthread. This is an issue for
> asymmetric CPU capacity systems where the wakee might not fit prev_cpu
> anymore. Evaluate asym_fits_capacity() for prev_cpu before using that
> shortcut.
>
> Fixes: 52262ee567ad ("sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6291876a9d32..b90dc6fd86ca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6410,7 +6410,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>          */
>         if (is_per_cpu_kthread(current) &&
>             prev == smp_processor_id() &&
> -           this_rq()->nr_running <= 1) {
> +           this_rq()->nr_running <= 1 &&
> +           asym_fits_capacity(task_util, prev)) {

With this patch, i don't think that
20211124154239.3191366-1-vincent.donnefort@arm.com is needed anymore

>                 return prev;
>         }
>
> --
> 2.25.1
>
