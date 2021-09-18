Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50ED41034D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 06:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhIRECc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 00:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230199AbhIRECE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 00:02:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B0C760F43;
        Sat, 18 Sep 2021 04:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631937636;
        bh=9xCGGOqj1qspJEcHYe7wfFEPfcwvX77bnjlAKLEpoaI=;
        h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
        b=OZ8O2d6nIlFGM1HmZ+MnTs7xy5LA7ykCFbdGq775gkxgnLsg+o7JbT2eGZE4nhVSg
         6O+4jUjKX+pIto0oc0YyZ0WuAs9TAgsUFvL74tDC+l3Gp8IXVaM+c1Ma7kw22kFDew
         A8jRyo8CiZDvzIMzPRswAwnNgA1VHtF3faBdc3KXQ2/dqvmWvI28TO4BMV8zSfeOTI
         aqum1MfgmS8DJgZCic6WoUqg4Rs4AfHMUi/8rBRoO5JGN0U1qh2ozmH8O3lybE9Rvz
         zbIaHBh+KMzCXmSFx7CbjFbBSgTVFzymnHoZoOtQDjY/kBuBW9gv5An8egVY6JJAGQ
         Tcfde3qllePCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C346B5C0892; Fri, 17 Sep 2021 21:00:35 -0700 (PDT)
Date:   Fri, 17 Sep 2021 21:00:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     guillaume@morinfr.org, linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210917191555.GA2198@bender.morinfr.org>
 <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
 <20210917213404.GA14271@bender.morinfr.org>
 <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918003933.GA25868@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918003933.GA25868@bender.morinfr.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 02:39:35AM +0200, Guillaume Morin wrote:
> On 17 Sep 15:07, Paul E. McKenney wrote:
> > > I have a few kdumps from 5.4 and 5.10 kernels (that's how I was able to
> > > observe that the gp thread was sleeping for a long time) and that
> > > rcu_state.gp_flags & 1 == 1.
> > > 
> > > But this warning has happened a couple of dozen times on multiple
> > > machines in the __fput path (different kind of HW as well). Removing
> > > nohz_full from the command line makes the problem disappear.
> > > 
> > > Most machines have had fairly long uptime (30+ days) before showing the
> > > warning, though it has happened on a couple occasions only after a few
> > > hours.
> > > 
> > > That's pretty much all I have been able to gather so far, unfortunately.
> > 
> > What are these systems doing?  Running mostly in nohz_full usermode?
> > Mostly idle?  Something else?
> 
> Running mostly in nohz_full usermode (non preempt), mostly busy but
> it varies. I don't think I've seen this warning on a idle machine
> though.

OK, good to know.

> > If it happens again, could you please also capture the state of the
> > various rcuo kthreads?  Of these, the rcuog kthreads start grace
> > periods and the rcuoc kthreads invoke callbacks.
> 
> You mean the task state? Or something else I can dig up from a kdump?
> 
> This one was taken about 32:24s after the warning happened.
>   
> crash> ps -m | grep rcu
> [0 00:00:26.697] [IN]  PID: 89     TASK: ffff93c940b60000  CPU: 0   COMMAND: "rcuog/12"
> [0 00:00:30.443] [IN]  PID: 114    TASK: ffff93c940c623c0  CPU: 0   COMMAND: "rcuog/16"
> [0 00:00:30.483] [IN]  PID: 20     TASK: ffff93c940920000  CPU: 0   COMMAND: "rcuog/1"
> [0 00:00:30.490] [IN]  PID: 64     TASK: ffff93c940a9c780  CPU: 0   COMMAND: "rcuog/8"
> [0 00:00:31.373] [IN]  PID: 39     TASK: ffff93c9409aa3c0  CPU: 0   COMMAND: "rcuog/4"
> [0 00:32:24.007] [IN]  PID: 58     TASK: ffff93c940a6c780  CPU: 0   COMMAND: "rcuos/7"
> [0 00:32:24.007] [ID]  PID: 12     TASK: ffff93c940854780  CPU: 0   COMMAND: "rcu_sched"
> [0 00:32:24.080] [IN]  PID: 27     TASK: ffff93c94094a3c0  CPU: 0   COMMAND: "rcuos/2"
> [0 00:32:24.090] [IN]  PID: 83     TASK: ffff93c940b38000  CPU: 0   COMMAND: "rcuos/11"
> [0 00:32:24.200] [IN]  PID: 115    TASK: ffff93c940c64780  CPU: 0   COMMAND: "rcuos/16"
> [0 00:32:24.250] [IN]  PID: 40     TASK: ffff93c9409ac780  CPU: 0   COMMAND: "rcuos/4"
> [0 00:32:24.973] [IN]  PID: 65     TASK: ffff93c940ab0000  CPU: 0   COMMAND: "rcuos/8"
> [0 00:32:24.973] [IN]  PID: 46     TASK: ffff93c9409d4780  CPU: 0   COMMAND: "rcuos/5"
> [0 00:32:28.197] [IN]  PID: 77     TASK: ffff93c940b08000  CPU: 0   COMMAND: "rcuos/10"
> [0 00:39:04.800] [IN]  PID: 52     TASK: ffff93c940a44780  CPU: 0   COMMAND: "rcuos/6"
> [0 00:39:04.850] [IN]  PID: 33     TASK: ffff93c94097a3c0  CPU: 0   COMMAND: "rcuos/3"
> [0 02:36:51.923] [IN]  PID: 102    TASK: ffff93c940bfa3c0  CPU: 0   COMMAND: "rcuos/14"
> [0 04:21:46.806] [IN]  PID: 121    TASK: ffff93c940c8c780  CPU: 0   COMMAND: "rcuos/17"
> [0 04:21:46.806] [IN]  PID: 108    TASK: ffff93c940c323c0  CPU: 0   COMMAND: "rcuos/15"
> [0 04:25:49.033] [IN]  PID: 21     TASK: ffff93c9409223c0  CPU: 0   COMMAND: "rcuos/1"
> [0 04:25:49.033] [IN]  PID: 96     TASK: ffff93c940bd23c0  CPU: 0   COMMAND: "rcuos/13"
> [0 05:12:14.289] [IN]  PID: 71     TASK: ffff93c940ad8000  CPU: 0   COMMAND: "rcuos/9"
> [0 05:12:17.849] [IN]  PID: 90     TASK: ffff93c940b623c0  CPU: 0   COMMAND: "rcuos/12"
> [0 05:18:39.813] [IN]  PID: 10     TASK: ffff93c940850000  CPU: 0   COMMAND: "rcu_tasks_trace"
> [0 05:18:39.813] [IN]  PID: 9      TASK: ffff93c940844780  CPU: 0   COMMAND: "rcu_tasks_rude_"
> [0 05:18:39.813] [ID]  PID: 4      TASK: ffff93c940828000  CPU: 0   COMMAND: "rcu_par_gp"
> [0 05:18:39.813] [ID]  PID: 3      TASK: ffff93c940804780  CPU: 0   COMMAND: "rcu_gp"

That is them!  There are some flags that control their activities:

o	rcu_data structure's ->nocb_gp_sleep field (rcuog)
o	rcu_data structure's ->nocb_cb_sleep field (rcuoc)

> > OK, please see below.  This is a complete shot in the dark, but could
> > potentially prevent the problem.  Or make it worse, which would at the
> > very least speed up debugging.  It might needs a bit of adjustment to
> > apply to the -stable kernels, but at first glance should apply cleanly.
> 
> I can adjust, that's not a problem. But to be clear you'd rather have me
> apply this instead of the other patch I mentioned
> (https://www.spinics.net/lists/rcu/msg05731.html) or you're okay with me
> trying with both applied?

Trying both is fine.

> > Oh, and FYI I am having to manually paste your email address into the To:
> > line in order to get this to go back to you.  Please check your email
> > configuration.
> 
> Hmm I've adjusted the Reply-To. Let me know if it's better.

Much better.  Still a bit unusual in that it puts everything on the
To: line instead of using Cc: as well, but close enough.  Thank you!

							Thanx, Paul
