Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A7F36DCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhD1QFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbhD1QFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:05:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4FAC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:04:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x20so69780284lfu.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQMhrNDQ91HHFwkfRkb2ldsdrJg3252GY4zRL5j9yro=;
        b=NEdNlukQqm2thGBQwcOGnx1iC6HkP7J0Op3rmQuHZvzbtRo5ViOCC6ZBhSuyGfPCxt
         yW6etHioQTzDlny+IsDTMh4BHzRnoIwwlAoq+Tj5UuViDzsZxJSV0FYQ6ZeKAIAEP2sF
         jptM78gnDuPtlZhKTsFGbq2ud9RrJLoy7kZWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQMhrNDQ91HHFwkfRkb2ldsdrJg3252GY4zRL5j9yro=;
        b=ml6rmMe9fN6DbPnP6QWZtgaabwrijXmkFyZYbubahvwFcO+icRmjm63PULaxI5mgyx
         xCtjWBYm7GBXIB3Xpur0Y+Pb6x40+91qdAiVh5x0h+9U2OknA0AhdUz+OhsJPaXlqLmn
         9o0JM1+a+dSgM6qsp2dm8uby8TaRnm7Jh/hFvJOl9qBNQt8O3yZV34v2Duig9gOLsN+p
         wA9ne51wZHFgndgJpvkOLJ0lF85LQdbwHEAidEwcNLpV2auPOnlAn+R0f+ksIyYb9EVY
         GxAWyC98G316Yi5vBdUEEeoolZ3PpGQu6dIfqX9v6Eswkfwf5DmX6GHvPhQiiQllvykh
         F6+A==
X-Gm-Message-State: AOAM533akz7MY5quSFRnyen/8nx0M10PKLFaMYWMA7+KyKtJIAk2n+0a
        cNlw21Wh+g/MQsOdyRPr0p6b16zwcz1BdA1M6XM5vw==
X-Google-Smtp-Source: ABdhPJzbDftaclm2hQckJ2OqtaNrC1Q5yc27nUsOYkXrFSZ2RQ6EsiQGEmG892PembOJME1MIremlibtr5WVfBnTgSQ=
X-Received: by 2002:a19:f00e:: with SMTP id p14mr21696716lfc.550.1619625890231;
 Wed, 28 Apr 2021 09:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com> <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
In-Reply-To: <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
From:   Don Hiatt <dhiatt@digitalocean.com>
Date:   Wed, 28 Apr 2021 09:04:38 -0700
Message-ID: <CAOY2WowNjhMx1M+mOTyhNuMQQijZ-Mu6J4nxE3zO+_E-oFMZdA@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 4:35 PM Josh Don <joshdon@google.com> wrote:
>
> On Tue, Apr 27, 2021 at 10:10 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
> > Hi Josh and Peter,
> >
> > I've been running into soft lookups and hard lockups when running a script
> > that just cycles setting the cookie of a group of processes over and over again.
> >
> > Unfortunately the only way I can reproduce this is by setting the cookies
> > on qemu. I've tried sysbench, stress-ng but those seem to work just fine.
> >
> > I'm running Peter's branch and even tried the suggested changes here but
> > still see the same behavior. I enabled panic on hard lockup and here below
> > is a snippet of the log.
> >
> > Is there anything you'd like me to try or have any debugging you'd like me to
> > do? I'd certainly like to get to the bottom of this.
>
> Hi Don,
>
> I tried to repro using qemu, but did not generate a lockup. Could you
> provide more details on what your script is doing (or better yet,
> share the script directly)? I would have expected you to potentially
> hit a lockup if you were cycling sched_core being enabled and
> disabled, but it sounds like you are just recreating the cookie for a
> process group over and over?
>
> Best,
> Josh

Hi Josh,

Sorry if I wasn't clear, but I'm running on bare metal (Peter's
5.12-rc8 repo) and have two qemu-system-x86_64 vms (1 with 8vcpu, the
other with 24 but it doesn't really matter). I then run a script [1]
that cycles setting the cookie for all the processes given the pid of
qemu-system-x86_64.

I also just found a lockup when I set the cookies for those two vms,
pinned them both to the same processor pair, and ran sysbench within
each vm to generate some load [2]. This is without cycling the
cookies, just setting once.

Thanks!

Don

----[1]---
This is a little test harness (I can provide the source but it is
based on your kselftests)
dhiatt@s2r5node34:~/do_coresched$ ./do_coresched -h
Usage for ./do_coresched
   -c Create sched cookie for <pid>
   -f Share sched cookie from <pid>
   -g Get sched cookie from <pid>
   -t Share sched cookie to <pid>
   -z Clear sched cookie from <pid>
   -p PID

Create: _prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, PIDTYPE_PID, 0)
Share: _prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, pid, PIDTYPE_PID, 0)
Get: prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
                    (unsigned long)&cookie);

--

dhiatt@s2r5node34:~/do_coresched$ cat set.sh
#!/bin/bash
# usage: set.sh pid

target=$1
echo target pid: $target
pids=`ps -eL | grep $target | awk '{print $2}' | sort -g`

echo "Setting cookies for $target"
./do_coresched -c -p $BASHPID. #
for i in $pids
do
./do_coresched -t -p $i
./do_coresched -g -p $i
done
---

---[2]---
[ 8911.926989] watchdog: BUG: soft lockup - CPU#53 stuck for 22s! [CPU
1/KVM:19539]
[ 8911.935727] NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
[ 8911.935791] NMI watchdog: Watchdog detected hard LOCKUP on cpu 7
[ 8911.935908] NMI watchdog: Watchdog detected hard LOCKUP on cpu 12
[ 8911.935967] NMI watchdog: Watchdog detected hard LOCKUP on cpu 13
[ 8911.936070] NMI watchdog: Watchdog detected hard LOCKUP on cpu 19
[ 8911.936145] NMI watchdog: Watchdog detected hard LOCKUP on cpu 21
[ 8911.936220] NMI watchdog: Watchdog detected hard LOCKUP on cpu 23
[ 8911.936361] NMI watchdog: Watchdog detected hard LOCKUP on cpu 31
[ 8911.936453] NMI watchdog: Watchdog detected hard LOCKUP on cpu 34
[ 8911.936567] NMI watchdog: Watchdog detected hard LOCKUP on cpu 42
[ 8911.936627] NMI watchdog: Watchdog detected hard LOCKUP on cpu 46
[ 8911.936712] NMI watchdog: Watchdog detected hard LOCKUP on cpu 49
[ 8911.936827] NMI watchdog: Watchdog detected hard LOCKUP on cpu 58
[ 8911.936887] NMI watchdog: Watchdog detected hard LOCKUP on cpu 60
[ 8911.936969] NMI watchdog: Watchdog detected hard LOCKUP on cpu 70
[ 8915.926847] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[ 8915.932904] rcu: 2-...!: (7 ticks this GP)
idle=38e/1/0x4000000000000000 softirq=181538/181540 fqs=1178
[ 8915.942617] rcu: 14-...!: (2 GPs behind)
idle=d0e/1/0x4000000000000000 softirq=44825/44825 fqs=1178
[ 8915.954034] rcu: rcu_sched kthread timer wakeup didn't happen for
12568 jiffies! g462469 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[ 8915.965775] rcu: Possible timer handling issue on cpu=6 timer-softirq=10747
[ 8915.973021] rcu: rcu_sched kthread starved for 12572 jiffies!
g462469 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=6
[ 8915.983681] rcu: Unless rcu_sched kthread gets sufficient CPU time,
OOM is now expected behavior.
[ 8915.992879] rcu: RCU grace-period kthread stack dump:
[ 8915.998211] rcu: Stack dump where RCU GP kthread last ran:
[ 8939.925995] watchdog: BUG: soft lockup - CPU#53 stuck for 22s! [CPU
1/KVM:19539]
[ 8939.935274] NMI watchdog: Watchdog detected hard LOCKUP on cpu 25
[ 8939.935351] NMI watchdog: Watchdog detected hard LOCKUP on cpu 27
[ 8939.935425] NMI watchdog: Watchdog detected hard LOCKUP on cpu 29
[ 8939.935653] NMI watchdog: Watchdog detected hard LOCKUP on cpu 44
[ 8939.935845] NMI watchdog: Watchdog detected hard LOCKUP on cpu 63
[ 8963.997140] watchdog: BUG: soft lockup - CPU#71 stuck for 22s!
[SchedulerRunner:4405]

-----
