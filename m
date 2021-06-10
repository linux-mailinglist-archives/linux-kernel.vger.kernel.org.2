Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F953A3390
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFJSzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:55:53 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:44011 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhFJSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:55:52 -0400
Received: by mail-io1-f43.google.com with SMTP id k16so28122792ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mE0gTe15esTm8uzAeX186Q/3CLTOYL1HJBnOpbPIzr0=;
        b=S9Iqdgeqh8t1C8Z50ejxvD8eHea45oIWYxgTvFYgoVSf7p3ntvIBtkrWQg4lKFRl04
         00vDsljDyuqpSg6Y81UDZKHvZa/7eYBDmFZSQ1R4omYXtkgIdXGpWYOsKHpQthEArFgQ
         6NCCb9cCNyzCxvVv3YwIgT48JIxuqHWApbO7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mE0gTe15esTm8uzAeX186Q/3CLTOYL1HJBnOpbPIzr0=;
        b=dBeUDI56yuQmc8rHvE6K4Ky9TBwi8jVTS1h8N5EPnS2BkjSV1e4D86vQWbqh83d3gZ
         Gg8945UhDTRRpho8n2YFDJFbmYoKfOZRlTu0QGyCrFa3sJwBXGZzN7YHcHM7M2HBoveP
         /vV9IoJrc0mcZvD8hlpGx5Fmjxq/EanQ45aSVjASdIWuMTrEQ1RH8oll34O1LO4iXbnH
         jlLwu1PfTJma1HiYsT+U9CE/LJ3hdNFygpx4aA/HXE8Cvl/NjsiOdS7CLE0KyVJeHV+p
         q1xoytjRVmXPG+RyXsnad9U7Z7YGn2CEzHGVhfBUV44tne+n+T64G4seqlgXgRp//IlA
         XnKg==
X-Gm-Message-State: AOAM531Uz/us939Mzpyyi5pVkfWMoN0IkL4cB/21IMfjuYiNyzX/+ev6
        FrBw/oxVQIwnWvK+X8w1z4pkm0nUnejYCXg6ZDJcXw==
X-Google-Smtp-Source: ABdhPJxJ1OkXze4nM4wDjYN9dpHZqAUgK1XXZIGgU5T4RaYqtDZUDHXYSVrnZeMydEMMK7YjCQSCMhJH6U7hJX2anRs=
X-Received: by 2002:a5d:8254:: with SMTP id n20mr7832ioo.85.1623351162474;
 Thu, 10 Jun 2021 11:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTcO=hbmdq3nOx2RJfT2yPyoFnQx5niB38R2Lzpsp38bA@mail.gmail.com>
 <20210607191031.GA12489@e120325.cambridge.arm.com> <YL/AcZRAQ6Us4xd2@google.com>
 <20210610133005.GA30309@e120325.cambridge.arm.com>
In-Reply-To: <20210610133005.GA30309@e120325.cambridge.arm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 10 Jun 2021 14:52:31 -0400
Message-ID: <CAEXW_YTkEJ_3UBD2SHszm=mgKWXrxJSFNxzE7YWqQ88CKbtF8Q@mail.gmail.com>
Subject: Re: iowait boost is broken
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 9:30 AM Beata Michalska <beata.michalska@arm.com> wrote:
>
> On Tue, Jun 08, 2021 at 03:09:37PM -0400, Joel Fernandes wrote:
> > Hi Beata,
> >
> > On Mon, Jun 07, 2021 at 08:10:32PM +0100, Beata Michalska wrote:
> > > Hi Joel,
> > >
> > > Thanks for sending this out.
> >
> > Np, thanks for replying.
> >
> > > On Mon, Jun 07, 2021 at 12:19:01PM -0400, Joel Fernandes wrote:
> > > > Hi all,
> > > > Looks like iowait boost is completely broken upstream. Just
> > > > documenting my findings of iowait boost issues:
> > > >
> > > I wouldn't go as far to state that it is completely broken. Rather that
> > > the current sugov implementation for iowait boosting is not meeting
> > > the expectations and I believe this should be clarified first. More on those
> > > expectations below.
> > > > 1. If a CPU requests iowait boost in a cluster, another CPU can go
> > > > ahead and reset very quickly it since it thinks there's no new request
> > > > for the iowait boosting CPU
> > > So the 'boosting' value is being tracked per CPU, so each core in a cluster
> > > will have it's own variant of that. When calculating the shared freq for
> > > the cluster, sugov will use max utilization reported on each core, including
> > > I/O boost. Now, if there is no pending request for boosting on a given core
> > > at the time of calling sugov_iowait_apply, the current 'boost' will be
> > > reduced, but only this one and that will not affect boost values on remaining
> > > CPUs. It means that there was no task waking up on that particular CPU after
> > > waiting on I/O request. So I would say it's fine. Unless I am misunderstanding
> > > your case ?
> >
> > Yes, but consider the case where the I/O is slow on one CPU (call it X) so
> > say IO wait takes 2 milliseconds. Now another CPU (call it Y) is
> > continuiously making cpufreq requests much faster than that. Also consider
> > that the slow CPU X is doing back to back I/O request and has consecutive
> > I/O sleep time (no other sleep, just I/O sleep). What you'll see is the
> > CPU X's boost always stays at _MIN boost when it wakes up because Y reset it
> > to 0 in the meanwhile. So the boost never accumulates. Does that make sense?
> > I would say that the I/O CPU should have a 'doubling' of boost. Probably the
> > issue can be solved by making rate_limit_us longer than the iowait time. But
> > that seems like a hack and would likely cause other issues.
> >
> OK, I think I see your point now.
> So another issue to be added to the list.
> Not sure though twiddling with rate_limit_us would do any good. This can be
> already tweaked from sysfs but it touches on the freq transition delays so
> I wouldn't mess around with that just to tune I/O boosting.
> I'd still rather move the boosting outside of sugov - as much as possible at
> least.

How about something like so? At least a partial respite to that issue.
A concurrent cpufreq request has to wait till at least TICK_NSEC
before decaying a neighbor's boost, and the boost reset takes place
only after at least 2 ticks. Since we already start at a low boost of
min, I think being less aggressive there should be Ok. Completely
untested and purely a vacation-patch:

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4f09afd..72aaff4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -27,6 +27,7 @@ struct sugov_policy {
  struct list_head tunables_hook;

  raw_spinlock_t update_lock;
+ u64 last_update;
  u64 last_freq_update_time;
  s64 freq_update_delay_ns;
  unsigned int next_freq;
@@ -188,7 +189,7 @@ static bool sugov_iowait_reset(struct sugov_cpu
*sg_cpu, u64 time,
  s64 delta_ns = time - sg_cpu->last_update;

  /* Reset boost only if a tick has elapsed since last request */
- if (delta_ns <= TICK_NSEC)
+ if (delta_ns <= 2 * TICK_NSEC)
  return false;

  sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
@@ -215,6 +216,7 @@ static void sugov_iowait_boost(struct sugov_cpu
*sg_cpu, u64 time,
         unsigned int flags)
 {
  bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
+ struct sugov_policy *sg_policy = sg_cpu->sg_policy;

  /* Reset boost if the CPU appears to have been idle enough */
  if (sg_cpu->iowait_boost &&
@@ -260,6 +262,7 @@ static void sugov_iowait_boost(struct sugov_cpu
*sg_cpu, u64 time,
  */
 static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 {
+ struct sugov_policy *sg_policy = sg_cpu->sg_policy;
  unsigned long boost;

  /* No boost currently required */
@@ -270,7 +273,8 @@ static void sugov_iowait_apply(struct sugov_cpu
*sg_cpu, u64 time)
  if (sugov_iowait_reset(sg_cpu, time, false))
  return;

- if (!sg_cpu->iowait_boost_pending) {
+ if (!sg_cpu->iowait_boost_pending &&
+      time - sg_policy->last_update > TICK_NSEC) {
  /*
  * No boost pending; reduce the boost value.
  */
@@ -440,6 +444,7 @@ sugov_update_shared(struct update_util_data *hook,
u64 time, unsigned int flags)

  sugov_iowait_boost(sg_cpu, time, flags);
  sg_cpu->last_update = time;
+ sg_policy->last_update = time;

  ignore_dl_rate_limit(sg_cpu);

-- 
2.27.0
