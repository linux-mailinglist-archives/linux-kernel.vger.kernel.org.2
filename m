Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808EC3AE51D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFUImf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhFUIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:42:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB422C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:40:20 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p7so28676653lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZOZC4y6LJLMYWwUfjVy94blXO2ruM4JgRMTtUsqspo=;
        b=ilLY8JY1cFB8sq0AcwXBZhimU1+d3MyHPNrHiG/rITWrkqDapPJE/q2/5ZJ0V4OW9T
         w0KvtIo4fhybl6C6GBevBPiqQKkXN84FbNluquJi8c/bpftLSotbsSC4Rmxh9sbglkr6
         E/LwYJaHmyw+7EQLMD6QiGZErdoSmxx36yIq5/1t7M7f7e42ULoDUz21Lt/WqM+fQPlv
         WOsogudam7sR+ExLq01kMpL1E3znqCzkkdnn/seFRZWWMs1ImME8QDpnRucMGjGqKNwi
         T42+HOJpkCyJA30zXs0xGlq6x5zeG2DyFOXWn1Qz8tdN6IpW0FvecR3atnPR1e4ytJRI
         PWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZOZC4y6LJLMYWwUfjVy94blXO2ruM4JgRMTtUsqspo=;
        b=l7rm5WdXNG0dH6QXKMxifpHsIVyBy8seCrgBnckJ+RxU9i8af74dXKtqKkCjaRRqxw
         D7diQuvK98Eov2zbQC1NKL3xWDxHjsPQ4BSll8GsU8z8G3d657jyTNeoy6FgtASSk2sk
         n0f3K1wuKEe+hOHvfBTCszQwFaFpWPAcNZgQuXs1ho3H1zlbpdsB8bKFbgd2stM8tvwJ
         EIo7pSkqe1E2U3lzhbDnpJ68L+rFve7j/eV6aG2e0AwMwuFdmRzMtpY5oWn55wXEPx2+
         rupzBv+2uSc012QqVGOw1GyV09x9mupWQ88Jo8izVOO+3Ngaco6j862fyOmM8kkeSZ3J
         BAMw==
X-Gm-Message-State: AOAM531mWT6VT+a8ywzV0UhXEJCaZQPND7pj4RpQToLsOdLfD4jGXee4
        YxI61aEozo0YSL7LcCbXrJ3saZLbeHewDW5u6WT+hg==
X-Google-Smtp-Source: ABdhPJzTwFhN3pPxE0cIo//uyg/2alA6O0eB2vni/UO7onq31DH4aZWG9wGCL2B7oAm/aQ/QRNAhGCimdgiCtCmlWn8=
X-Received: by 2002:a05:6512:242:: with SMTP id b2mr5941874lfo.277.1624264819068;
 Mon, 21 Jun 2021 01:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <1624023139-66147-1-git-send-email-vincent.donnefort@arm.com> <1624023139-66147-2-git-send-email-vincent.donnefort@arm.com>
In-Reply-To: <1624023139-66147-2-git-send-email-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jun 2021 10:40:08 +0200
Message-ID: <CAKfTPtA+myH9qGsN+khvfqUUMB4AK3+3d_x6xiYxV_p6hwYzgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/rt: Fix Deadline utilization tracking during
 policy change
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 at 15:32, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> DL keeps track of the utilization on a per-rq basis with the structure
> avg_dl. This utilization is updated during task_tick_dl(),
> put_prev_task_dl() and set_next_task_dl(). However, when the current
> running task changes its policy, set_next_task_dl() which would usually
> take care of updating the utilization when the rq starts running DL
> tasks, will not see a such change, leaving the avg_dl structure outdated.
> When that very same task will be dequeued later, put_prev_task_dl() will
> then update the utilization, based on a wrong last_update_time, leading a
> huge spike in the DL utilization signal.
>
> The signal would eventually recover from this issue after few ms. Even
> if no DL tasks are run, avg_dl is also updated in
> __update_blocked_others(). But as the CPU capacity depends partly on the
> avg_dl, this issue has nonetheless a significant impact on the scheduler.
>
> Fix this issue by ensuring a load update when a running task changes
> its policy to DL.
>
> Fixes: 3727e0e ("sched/dl: Add dl_rq utilization tracking")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3829c5a..915227a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2497,6 +2497,8 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
>                         check_preempt_curr_dl(rq, p, 0);
>                 else
>                         resched_curr(rq);
> +       } else {
> +               update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
>         }
>  }
>
> --
> 2.7.4
>
