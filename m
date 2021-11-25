Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE6D45DB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355293AbhKYNiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354941AbhKYNfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:35:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111BAC0613F2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 05:23:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z5so25735608edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 05:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpIP+jAf61pScMz1hi7v1s13jC+068HXbkGbFFQ7iMA=;
        b=rtRbUxiR0kvLJcrhQlI945f2tly/+y8Xwii1zYdn+0Bkbi3s5cy535MlUrhLXWqd33
         AO3nb0gYWbjX/yRv24K71f9qqWdKwIqg+afEiCzoDBG970aZ4WUQCARc8xYEhIFHpNuP
         CNsakBCWkTLOp5ipyKAZN1OulGihTvzbzQ6nIx7tSzUYB4Rk87FNUcpUDgWPSBtJt2bg
         SaEiOkcX0PFxBISNgF3C5vZdVUX4c3139xOPitIyoaOZKoNisjcb1Nq/cJYBg6Widf6L
         On5hlQKDBNl2rmPhW6IFkSizKKEgNU/RS2dUGAfbS2j/Aq/rHVzk43FvyaC0F+95jdrh
         aWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpIP+jAf61pScMz1hi7v1s13jC+068HXbkGbFFQ7iMA=;
        b=Wekea8namxzK2VNNszZUbq/6PEMU3YmWT4rG9YVr34QnOQycaXQIjac3MzHZ9Fn4XE
         6YAbRPUcgmhtHnKZNkeCFn8cdgh6r7J4ls+Yy78X5A7L99kZliDu0LyukEDajfHY4NOf
         ja+3sLb+n81+tKsVHYg043MQYrZGsraprjPPB/um2ovBGE6T3CiMU6WN9m3Z7Jl41Sw5
         mNzLH8ZAuqjEV1LDtQR+rJ0dwHyHR+pGF3m05fFAYtbVeJKuBzztZ/CEIgag/w7LIePL
         cEQL8aXmwcSjlsMOwXlLgYZxZS9sqfqCTr538Qs4cFKv88fGWWV1TJvTA7pxN/cJBAyb
         vqJQ==
X-Gm-Message-State: AOAM530rUCeWUECfW1IP57QiHX5TusKD/RfOLuIH8Jnl8KL/y5zHJ7MU
        ycnUO7Tsrh65VlhdECjMRP3CzY6mL4gmvT+2PAmiMg==
X-Google-Smtp-Source: ABdhPJzn8zIMSbqkneCiAlL/AaAkuV81ErwDYN2R+RnxXColjAriUp2VK3SMMpXfmCb8wXyBVoh8H4Copod3oNzyocc=
X-Received: by 2002:a17:907:16ac:: with SMTP id hc44mr30148164ejc.363.1637846602346;
 Thu, 25 Nov 2021 05:23:22 -0800 (PST)
MIME-Version: 1.0
References: <20211124154239.3191366-1-vincent.donnefort@arm.com>
 <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com> <8735nkcwov.mognet@arm.com>
In-Reply-To: <8735nkcwov.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Nov 2021 14:23:10 +0100
Message-ID: <CAKfTPtDPskVdEd-KQ_cwe-R_zVFPQOgdbk9x+3eD12pKs8fGFw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a task
To:     Valentin Schneider <Valentin.Schneider@arm.com>
Cc:     Vincent Donnefort <Vincent.Donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 at 12:16, Valentin Schneider
<Valentin.Schneider@arm.com> wrote:
>
> On 25/11/21 10:05, Vincent Guittot wrote:
> > On Wed, 24 Nov 2021 at 16:42, Vincent Donnefort
> > <vincent.donnefort@arm.com> wrote:
> >>
> >> select_idle_sibling() will return prev_cpu for the case where the task is
> >> woken up by a per-CPU kthread. However, the idle task has been recently
> >> modified and is now identified by is_per_cpu_kthread(), breaking the
> >> behaviour described above. Using !is_idle_task() ensures we do not
> >> spuriously trigger that select_idle_sibling() exit path.
> >>
> >> Fixes: 00b89fe0197f ("sched: Make the idle task quack like a per-CPU kthread")
> >> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 945d987246c5..8bf95b0e368d 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>          * pattern is IO completions.
> >>          */
> >>         if (is_per_cpu_kthread(current) &&
> >> +           !is_idle_task(current) &&
> >>             prev == smp_processor_id() &&
> >>             this_rq()->nr_running <= 1) {
> >>                 return prev;
> >
> > AFAICT, this can't be possible for a symmetric system because it would
> > have been already returned by other conditions.
> > Only an asymmetric system can face such a situation if the task
> > doesn't fit which is the subject of your other patch.
> > so this patch seems irrelevant outside the other one
> >
>
> I think you can still hit this on a symmetric system; let me try to
> reformulate my other email.
>
> If this (non-patched) condition evaluates to true, it means the previous
> condition
>
>   (available_idle_cpu(target) || sched_idle_cpu(target)) &&
>    asym_fits_capacity(task_util, target)
>
> evaluated to false, so for a symmetric system target sure isn't idle.
>
> prev == smp_processor_id() implies prev == target, IOW prev isn't
> idle. Now, consider:
>
>   p0.prev = CPU1
>   p1.prev = CPU1
>
>   CPU0                     CPU1
>   current = don't care     current = swapper/1
>
>   ttwu(p1)
>     ttwu_queue(p1, CPU1)
>     // or
>     ttwu_queue_wakelist(p1, CPU1)
>
>                           hrtimer_wakeup()
>                             wake_up_process()
>                               ttwu()
>                                 idle_cpu(CPU1)? no
>
>                                 is_per_cpu_kthread(current)? yes
>                                 prev == smp_processor_id()? yes
>                                 this_rq()->nr_running <= 1? yes
>                                 => self enqueue
>
>                           ...
>                           schedule_idle()
>
> This works if CPU0 does either a full enqueue (rq->nr_running == 1) or just
> a wakelist enqueue (rq->ttwu_pending > 0). If there was an idle CPU3
> around, we'd still be stacking p0 and p1 onto CPU1.
>
> IOW this opens a window between a remote ttwu() and the idle task invoking
> schedule_idle() where the idle task can stack more tasks onto its CPU.

Your use case above is out of the scope of this patch and has always
been there, even for other per cpu kthreads. In such case, the wake up
is not triggered by current (idle or another per cpu kthread) but by
an interrupt (hrtimer in your case). If we want to filter wakeup
generated by interrupt context while a per cpu kthread is running, it
would be better to fix all cases and test the running context like
this

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6397,7 +6397,8 @@ static int select_idle_sibling(struct
task_struct *p, int prev, int target)
         * essentially a sync wakeup. An obvious example of this
         * pattern is IO completions.
         */
-       if (is_per_cpu_kthread(current) &&
+       if (!in_interrupt() &&
+           is_per_cpu_kthread(current) &&
            prev == smp_processor_id() &&
            this_rq()->nr_running <= 1) {
                return prev;

>
> >
> >> --
> >> 2.25.1
> >>
