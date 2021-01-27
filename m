Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649ED306380
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbhA0Soc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343657AbhA0SoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:44:21 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DDFC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:43:41 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o18so2162131qtp.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j4DvQa0v2TxYDISfg7tNAYOkhSYb7Kl44T3UmyZGMpg=;
        b=WL+teJDCOkVGzP3DyqOF39QDQoJ6PAeq7rHdeSBt1kvLMYzdqsrNd1oZUp/hnaOJsy
         qmU8V289ZxWs1tzp/SWE9OanJZV3Ux5rXcqUpnmwkHrRxUtGOjrBQFyp+HIujWDmGzM4
         tUO86kVEFQRoOpXcD6pCbtww63vlfV2z8W3y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4DvQa0v2TxYDISfg7tNAYOkhSYb7Kl44T3UmyZGMpg=;
        b=To9uI5DdMFHoYP3vCR2G+iTQcTXb6BgD25ts2hJb38V2phrik42Pd8W94/HNC+CpMC
         xB5Ybbng5J59Ecb1NMPiZOrxPDL6K4A7DGth+Hi7n9KKCms3FuwOI5/knit/ljH70c/m
         gGZnoeGVVOwjI6JrR3C9oXK7AhrDzLpQs4jPwXkt4mZ6uoOH7tA3zRVfVbzGK7Nt5gg1
         VPa/4CYZ9rsEPiVPfi6w7WfmND+r3+k3fH2c1yxDbGphIsRMTPe9Wd4W3sTb04SGB16v
         Cs6OKfHXnA5HqzRaXH9yT3GUYPHbFJJhvJjV8n6OeruieHZ2hbtNrsGufKkwhXw1R2vK
         go4Q==
X-Gm-Message-State: AOAM533MOesoSuB1PLKa0Pwm6Vb46lzR/cVzCP8b+s2MC63m5kNjKaI/
        a9d1JYTebE8AuXs4ivN4K96Yng==
X-Google-Smtp-Source: ABdhPJxergcQEV9g4jlgAPYUgKp1JFV8Nlj60TQK4McbmZjk5QeoJsZcIkW/0UCPaKK96Q+7/W/5Xw==
X-Received: by 2002:ac8:76cc:: with SMTP id q12mr11166553qtr.300.1611773020554;
        Wed, 27 Jan 2021 10:43:40 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d9sm1705128qko.84.2021.01.27.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 10:43:39 -0800 (PST)
Date:   Wed, 27 Jan 2021 13:43:39 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
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
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH] sched/fair: Rate limit calls to
 update_blocked_averages() for NOHZ
Message-ID: <YBG0W5PFGtGRCEuB@google.com>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Mon, Jan 25, 2021 at 03:42:41PM +0100, Vincent Guittot wrote:
> On Fri, 22 Jan 2021 at 20:10, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Fri, Jan 22, 2021 at 05:56:22PM +0100, Vincent Guittot wrote:
> > > On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > On an octacore ARM64 device running ChromeOS Linux kernel v5.4, I found
> > > > that there are a lot of calls to update_blocked_averages(). This causes
> > > > the schedule loop to slow down to taking upto 500 micro seconds at
> > > > times (due to newidle load balance). I have also seen this manifest in
> > > > the periodic balancer.
> > > >
> > > > Closer look shows that the problem is caused by the following
> > > > ingredients:
> > > > 1. If the system has a lot of inactive CGroups (thanks Dietmar for
> > > > suggesting to inspect /proc/sched_debug for this), this can make
> > > > __update_blocked_fair() take a long time.
> > >
> > > Inactive cgroups are removed from the list so they should not impact
> > > the duration
> >
> > I meant blocked CGroups. According to this code, a cfs_rq can be partially
> > decayed and not have any tasks running on it but its load needs to be
> > decayed, correct? That's what I meant by 'inactive'. I can reword it to
> > 'blocked'.
> 
> How many blocked cgroups have you got ?

I put a counter in for_each_leaf_cfs_rq_safe() { } to count how many times
this loop runs per new idle balance. When the problem happens I see this loop
run 35-40 times (for one single instance of newidle balance). So in total
there are at least these many cfs_rq load updates.

I also see that new idle balance can be called 200-500 times per second.

> >
> >                   * There can be a lot of idle CPU cgroups.  Don't let fully
> >                   * decayed cfs_rqs linger on the list.
> >                   */
> >                  if (cfs_rq_is_decayed(cfs_rq))
> >                          list_del_leaf_cfs_rq(cfs_rq);
> >
> > > > 2. The device has a lot of CPUs in a cluster which causes schedutil in a
> > > > shared frequency domain configuration to be slower than usual. (the load
> > >
> > > What do you mean exactly by it causes schedutil to be slower than usual ?
> >
> > sugov_next_freq_shared() is order number of CPUs in the a cluster. This
> > system is a 6+2 system with 6 CPUs in a cluster. schedutil shared policy
> > frequency update needs to go through utilization of other CPUs in the
> > cluster. I believe this could be adding to the problem but is not really
> > needed to optimize if we can rate limit the calls to update_blocked_averages
> > to begin with.
> 
> Qais mentioned half of the time being used by
> sugov_next_freq_shared(). Are there any frequency changes resulting in
> this call ?

I do not see a frequency update happening at the time of the problem. However
note that sugov_iowait_boost() does run even if frequency is not being
updated. IIRC, this function is also not that light weight and I am not sure
if it is a good idea to call this that often.

> > > > average updates also try to update the frequency in schedutil).
> > > >
> > > > 3. The CPU is running at a low frequency causing the scheduler/schedutil
> > > > code paths to take longer than when running at a high CPU frequency.
> > >
> > > Low frequency usually means low utilization so it should happen that much.
> >
> > It happens a lot as can be seen with schbench. It is super easy to reproduce.
> 
> Happening a lot in itself is not a problem if there is nothing else to
> do so it's not a argument in itself

It is a problem - it shows up in the preempt off critical section latency
tracer. Are you saying its Ok for preemption to be disabled on system for 500
micro seconds?  That hurts real-time applications (audio etc).

> So why is it a problem for you ? You are mentioning newly idle load
> balance so I assume that your root problem is the scheduling delay
> generated by the newly idle load balance which then calls
> update_blocked_averages

Yes, the new idle balance is when I see it happen quite often. I do see it
happen with other load balance as well, but it not that often as those LB
don't run as often as new idle balance.

> 
> rate limiting the call to update_blocked_averages() will only reduce
> the number of time it happens but it will not prevent it to happen.

Sure, but soft real-time issue can tolerate if the issue does not happen very
often. In this case though, it is frequent.

> IIUC, your real problem is that newidle_balance is running whereas a
> task is about to wake up on the cpu and we don't abort quickly during
> this load_balance

Yes.

> so we could also try to abort earlier in case of newly idle load balance

I think interrupts are disabled when the load balance runs, so there's no way
for say an audio interrupt to even run in order to wake up a task. How would
you know to abort the new idle load balance?

Could you elaborate more also on the drawback of the rate limiting patch we
posted? Do you see a side effect?

> > > > sometimes, which seems overkill.
> > > >
> > > > schbench shows a clear improvement with the change:
> > >
> > > Have you got more details about your test setup ?
> > > which platform ?
> > > which kernel ?
> >
> > I mentioned in the commit message it is a v5.4 kernel.
> 
> I was not sure if the tests results done with this kernel because we
> usually ask for results against mainline to make sure you are not
> facing a problem that has solved since v5.4 has been released

Ok, yes I have a userspace up and running only on 5.4 kernel unfortunately. I
was hoping that is recent enough for this debug.

thanks,

 - Joel

