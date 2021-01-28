Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6255530793A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhA1PLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhA1PKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:10:10 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A4DC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 07:09:29 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q129so5902560iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 07:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cro+x1uRkZd55MzkTQZaa4vbr4dvJkkY96WnSyu0LbA=;
        b=ms4Qn8RamvFsh8Wr+6pSiyeFwQFeXMw9ZL0JdVmnfaDXUsgvXzvSLMn+11djA9ibrt
         48Qco3M3Pu2Z5iGI2XZCv2HwouK/K+sNRetr0N32adCOV4si9Bs8XPAWx2sR/vQyCCE2
         MJK1PKDGUGZXLJMBB68EXfURb2GiIRZheXBe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cro+x1uRkZd55MzkTQZaa4vbr4dvJkkY96WnSyu0LbA=;
        b=m4Bi+Qd6YNHIJ9bw/keLHB7ByWnsXBjeUggrrgECTfbW7Kn5fY3p/b65P3UUqYX2Bp
         azg9l2TjKIG33HpL/unK/UjvoSUC2DjscVpBQXQYJIrLyA4qYV4uzKH6PcTiwQAXonoG
         kV09+0rdZD1Te+sX6M5ROeuLAkeCGDQSukaiN2LHzUe8mgts4SZ+tiIcOS7ni/Uhf+tp
         DuprRB57FTiYf7YTGBUgpw5hVbtdK6yTczKOJM4hkXJoDrzbig3PfVaC7/Jtp4lU2R5t
         i631+AFBw0p1a8VoNr15KkbD7tD2Y2hFXdHBDf8irwKLu9v6zcQi4xI+OYaLLojm+ZZb
         VnGA==
X-Gm-Message-State: AOAM532lTLmbMCnpz/l0SlMWrhry3sirxzjwxi0mh/AiX/8KXgRiQgXq
        9Ni6AgIvrDgAlA9nqtYeXS5QDw1Y2oXavI727AbGPA==
X-Google-Smtp-Source: ABdhPJyh8Tzf4YdPtAnwkpNnLIlKW0/piU/cnpVB9lIn7GHjnPRNNfuKjP1w4G2EDhkmroWDgdLPvLp0ghuT9eKEPBs=
X-Received: by 2002:a05:6602:8da:: with SMTP id h26mr45451ioz.154.1611846568352;
 Thu, 28 Jan 2021 07:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com> <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com> <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 28 Jan 2021 10:09:17 -0500
Message-ID: <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Thu, Jan 28, 2021 at 8:57 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> > On Mon, Jan 25, 2021 at 03:42:41PM +0100, Vincent Guittot wrote:
> > > On Fri, 22 Jan 2021 at 20:10, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > On Fri, Jan 22, 2021 at 05:56:22PM +0100, Vincent Guittot wrote:
> > > > > On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
> > > > > <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > On an octacore ARM64 device running ChromeOS Linux kernel v5.4, I found
> > > > > > that there are a lot of calls to update_blocked_averages(). This causes
> > > > > > the schedule loop to slow down to taking upto 500 micro seconds at
> > > > > > times (due to newidle load balance). I have also seen this manifest in
> > > > > > the periodic balancer.
> > > > > >
> > > > > > Closer look shows that the problem is caused by the following
> > > > > > ingredients:
> > > > > > 1. If the system has a lot of inactive CGroups (thanks Dietmar for
> > > > > > suggesting to inspect /proc/sched_debug for this), this can make
> > > > > > __update_blocked_fair() take a long time.
> > > > >
> > > > > Inactive cgroups are removed from the list so they should not impact
> > > > > the duration
> > > >
> > > > I meant blocked CGroups. According to this code, a cfs_rq can be partially
> > > > decayed and not have any tasks running on it but its load needs to be
> > > > decayed, correct? That's what I meant by 'inactive'. I can reword it to
> > > > 'blocked'.
> > >
> > > How many blocked cgroups have you got ?
> >
> > I put a counter in for_each_leaf_cfs_rq_safe() { } to count how many times
> > this loop runs per new idle balance. When the problem happens I see this loop
> > run 35-40 times (for one single instance of newidle balance). So in total
> > there are at least these many cfs_rq load updates.
>
> Do you mean that you have 35-40 cgroups ? Or the 35-40 includes all CPUs ?

All CPUs.

> > I also see that new idle balance can be called 200-500 times per second.
>
> This is not surprising because newidle_balance() is called every time
> the CPU is about to become idle

Sure.

> > > >
> > > >                   * There can be a lot of idle CPU cgroups.  Don't let fully
> > > >                   * decayed cfs_rqs linger on the list.
> > > >                   */
> > > >                  if (cfs_rq_is_decayed(cfs_rq))
> > > >                          list_del_leaf_cfs_rq(cfs_rq);
> > > >
> > > > > > 2. The device has a lot of CPUs in a cluster which causes schedutil in a
> > > > > > shared frequency domain configuration to be slower than usual. (the load
> > > > >
> > > > > What do you mean exactly by it causes schedutil to be slower than usual ?
> > > >
> > > > sugov_next_freq_shared() is order number of CPUs in the a cluster. This
> > > > system is a 6+2 system with 6 CPUs in a cluster. schedutil shared policy
> > > > frequency update needs to go through utilization of other CPUs in the
> > > > cluster. I believe this could be adding to the problem but is not really
> > > > needed to optimize if we can rate limit the calls to update_blocked_averages
> > > > to begin with.
> > >
> > > Qais mentioned half of the time being used by
> > > sugov_next_freq_shared(). Are there any frequency changes resulting in
> > > this call ?
> >
> > I do not see a frequency update happening at the time of the problem. However
> > note that sugov_iowait_boost() does run even if frequency is not being
> > updated. IIRC, this function is also not that light weight and I am not sure
> > if it is a good idea to call this that often.
>
> Scheduler can't make any assumption about how often schedutil/cpufreq
> wants to be called. Some are fast and straightforward and can be
> called very often to adjust frequency; Others can't handle much
> updates. The rate limit mechanism in schedutil and io-boost should be
> there for such purpose.

Sure, I know that's the intention.

> > > > > > average updates also try to update the frequency in schedutil).
> > > > > >
> > > > > > 3. The CPU is running at a low frequency causing the scheduler/schedutil
> > > > > > code paths to take longer than when running at a high CPU frequency.
> > > > >
> > > > > Low frequency usually means low utilization so it should happen that much.
> > > >
> > > > It happens a lot as can be seen with schbench. It is super easy to reproduce.
> > >
> > > Happening a lot in itself is not a problem if there is nothing else to
> > > do so it's not a argument in itself
> >
> > It is a problem - it shows up in the preempt off critical section latency
>
> But this point is not related to the point above which is about how
> often it happens.

It is related. A bad thing happening quite often is worse than a bad
thing happening infrequently. I agree it is not a root cause fix, but
it makes things "better".

> > tracer. Are you saying its Ok for preemption to be disabled on system for 500
> > micro seconds?  That hurts real-time applications (audio etc).
>
> So. Is your problem related to real-time applications (audio etc) ?

Yes it is. I don't have a reproducer and it could be the audio
buffering will hide the problem. But that doesn't mean that there is
no problem or that we cannot improve things. There will also likely be
power consumption improvement.

> > > So why is it a problem for you ? You are mentioning newly idle load
> > > balance so I assume that your root problem is the scheduling delay
> > > generated by the newly idle load balance which then calls
> > > update_blocked_averages
> >
> > Yes, the new idle balance is when I see it happen quite often. I do see it
> > happen with other load balance as well, but it not that often as those LB
> > don't run as often as new idle balance.
>
> The update of average blocked load has been added in newidle_balance
> to take advantage of the cpu becoming idle but it seems to create a
> long preempt off sequence. I 'm going to prepare a patch to move it
> out the schedule path.

Ok thanks, that would really help!

> > > rate limiting the call to update_blocked_averages() will only reduce
> > > the number of time it happens but it will not prevent it to happen.
> >
> > Sure, but soft real-time issue can tolerate if the issue does not happen very
> > often. In this case though, it is frequent.
>
> Could you provide details of the problem that you are facing ? It's
> not clear for me what happens in your case at the end. Have you got an
> audio glitch as an example?
>
> "Not often" doesn't really give any clue.

I believe from my side I have provided details. I shared output from a
function graph tracer and schbench micro benchmark clearly showing the
issue and improvements. Sorry, I don't have a real-world reproducer
for this.

> Also update_blocked_averages was supposed called in newlyidle_balance
> when the coming idle duration is expected to be long enough

No, we do not want the schedule loop to take half a millisecond.

> > > IIUC, your real problem is that newidle_balance is running whereas a
> > > task is about to wake up on the cpu and we don't abort quickly during
> > > this load_balance
> >
> > Yes.
> >
> > > so we could also try to abort earlier in case of newly idle load balance
> >
> > I think interrupts are disabled when the load balance runs, so there's no way
> > for say an audio interrupt to even run in order to wake up a task. How would
> > you know to abort the new idle load balance?
> >
> > Could you elaborate more also on the drawback of the rate limiting patch we
> > posted? Do you see a side effect?
>
> Your patch just tries to hide your problem and not to solve the root cause.

Agreed, the solution presented is a band aid and not a proper fix. It
was just intended to illustrate the problem and start a discussion. I
should have marked it RFC for sure.

thanks!

- Joel
