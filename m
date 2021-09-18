Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2DD41026D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 02:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhIRAlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 20:41:01 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:61568 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhIRAk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 20:40:59 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 2F27819F4B5;
        Sat, 18 Sep 2021 02:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:
        Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w3Rieu5IYlMIj/IwowvMXnaVeIe1Chpa2pDG2pJ3QJY=; b=wrMP/VLOUSwkrHFJajtaYsPxSh
        oE3Y1zx8425w92NysFBEkIVWGmERVaT2eeRaD50scLDUadt+GjyqHkQsw+w0pmsVR+ga4+EWkvQNb
        KRIVT/cQi1NQppcF/pgMLcREsoi2S5yvLrXo2+lRgeF0dkId07wh0d+yB/2POiq3tynk=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mROOF-0007Xt-A4; Sat, 18 Sep 2021 02:39:35 +0200
Date:   Sat, 18 Sep 2021 02:39:35 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     guillaume@morinfr.org, linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210918003933.GA25868@bender.morinfr.org>
Reply-To: Guillaume Morin <guillaume@morinfr.org>
Mail-Followup-To: "Paul E. McKenney" <paulmck@kernel.org>,
        guillaume@morinfr.org, linux-kernel@vger.kernel.org
References: <20210917191555.GA2198@bender.morinfr.org>
 <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
 <20210917213404.GA14271@bender.morinfr.org>
 <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 15:07, Paul E. McKenney wrote:
> > I have a few kdumps from 5.4 and 5.10 kernels (that's how I was able to
> > observe that the gp thread was sleeping for a long time) and that
> > rcu_state.gp_flags & 1 == 1.
> > 
> > But this warning has happened a couple of dozen times on multiple
> > machines in the __fput path (different kind of HW as well). Removing
> > nohz_full from the command line makes the problem disappear.
> > 
> > Most machines have had fairly long uptime (30+ days) before showing the
> > warning, though it has happened on a couple occasions only after a few
> > hours.
> > 
> > That's pretty much all I have been able to gather so far, unfortunately.
> 
> What are these systems doing?  Running mostly in nohz_full usermode?
> Mostly idle?  Something else?

Running mostly in nohz_full usermode (non preempt), mostly busy but
it varies. I don't think I've seen this warning on a idle machine
though.

> If it happens again, could you please also capture the state of the
> various rcuo kthreads?  Of these, the rcuog kthreads start grace
> periods and the rcuoc kthreads invoke callbacks.

You mean the task state? Or something else I can dig up from a kdump?

This one was taken about 32:24s after the warning happened.
  
crash> ps -m | grep rcu
[0 00:00:26.697] [IN]  PID: 89     TASK: ffff93c940b60000  CPU: 0   COMMAND: "rcuog/12"
[0 00:00:30.443] [IN]  PID: 114    TASK: ffff93c940c623c0  CPU: 0   COMMAND: "rcuog/16"
[0 00:00:30.483] [IN]  PID: 20     TASK: ffff93c940920000  CPU: 0   COMMAND: "rcuog/1"
[0 00:00:30.490] [IN]  PID: 64     TASK: ffff93c940a9c780  CPU: 0   COMMAND: "rcuog/8"
[0 00:00:31.373] [IN]  PID: 39     TASK: ffff93c9409aa3c0  CPU: 0   COMMAND: "rcuog/4"
[0 00:32:24.007] [IN]  PID: 58     TASK: ffff93c940a6c780  CPU: 0   COMMAND: "rcuos/7"
[0 00:32:24.007] [ID]  PID: 12     TASK: ffff93c940854780  CPU: 0   COMMAND: "rcu_sched"
[0 00:32:24.080] [IN]  PID: 27     TASK: ffff93c94094a3c0  CPU: 0   COMMAND: "rcuos/2"
[0 00:32:24.090] [IN]  PID: 83     TASK: ffff93c940b38000  CPU: 0   COMMAND: "rcuos/11"
[0 00:32:24.200] [IN]  PID: 115    TASK: ffff93c940c64780  CPU: 0   COMMAND: "rcuos/16"
[0 00:32:24.250] [IN]  PID: 40     TASK: ffff93c9409ac780  CPU: 0   COMMAND: "rcuos/4"
[0 00:32:24.973] [IN]  PID: 65     TASK: ffff93c940ab0000  CPU: 0   COMMAND: "rcuos/8"
[0 00:32:24.973] [IN]  PID: 46     TASK: ffff93c9409d4780  CPU: 0   COMMAND: "rcuos/5"
[0 00:32:28.197] [IN]  PID: 77     TASK: ffff93c940b08000  CPU: 0   COMMAND: "rcuos/10"
[0 00:39:04.800] [IN]  PID: 52     TASK: ffff93c940a44780  CPU: 0   COMMAND: "rcuos/6"
[0 00:39:04.850] [IN]  PID: 33     TASK: ffff93c94097a3c0  CPU: 0   COMMAND: "rcuos/3"
[0 02:36:51.923] [IN]  PID: 102    TASK: ffff93c940bfa3c0  CPU: 0   COMMAND: "rcuos/14"
[0 04:21:46.806] [IN]  PID: 121    TASK: ffff93c940c8c780  CPU: 0   COMMAND: "rcuos/17"
[0 04:21:46.806] [IN]  PID: 108    TASK: ffff93c940c323c0  CPU: 0   COMMAND: "rcuos/15"
[0 04:25:49.033] [IN]  PID: 21     TASK: ffff93c9409223c0  CPU: 0   COMMAND: "rcuos/1"
[0 04:25:49.033] [IN]  PID: 96     TASK: ffff93c940bd23c0  CPU: 0   COMMAND: "rcuos/13"
[0 05:12:14.289] [IN]  PID: 71     TASK: ffff93c940ad8000  CPU: 0   COMMAND: "rcuos/9"
[0 05:12:17.849] [IN]  PID: 90     TASK: ffff93c940b623c0  CPU: 0   COMMAND: "rcuos/12"
[0 05:18:39.813] [IN]  PID: 10     TASK: ffff93c940850000  CPU: 0   COMMAND: "rcu_tasks_trace"
[0 05:18:39.813] [IN]  PID: 9      TASK: ffff93c940844780  CPU: 0   COMMAND: "rcu_tasks_rude_"
[0 05:18:39.813] [ID]  PID: 4      TASK: ffff93c940828000  CPU: 0   COMMAND: "rcu_par_gp"
[0 05:18:39.813] [ID]  PID: 3      TASK: ffff93c940804780  CPU: 0   COMMAND: "rcu_gp"

> OK, please see below.  This is a complete shot in the dark, but could
> potentially prevent the problem.  Or make it worse, which would at the
> very least speed up debugging.  It might needs a bit of adjustment to
> apply to the -stable kernels, but at first glance should apply cleanly.

I can adjust, that's not a problem. But to be clear you'd rather have me
apply this instead of the other patch I mentioned
(https://www.spinics.net/lists/rcu/msg05731.html) or you're okay with me
trying with both applied?
 
> Oh, and FYI I am having to manually paste your email address into the To:
> line in order to get this to go back to you.  Please check your email
> configuration.

Hmm I've adjusted the Reply-To. Let me know if it's better.

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>
