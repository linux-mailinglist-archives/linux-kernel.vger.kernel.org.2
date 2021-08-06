Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8103E2EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbhHFRoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhHFRo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1BD96115C;
        Fri,  6 Aug 2021 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628271851;
        bh=uSuJHg6HLpSIc2RgweeUEidWnwRjqdoYEFwHJKSZkF0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rFOe6DyQWR6aPGFt0DZnkUKqtant8N5X5tglQZwhMJyn0kxSzByqc7T8s5NC0W2ue
         6bULkEjc/9DTmB9ibbBT7q8kC5RYDihSOjBxTCbYLRSUwWDlvvBRONEWLc2T4DqcFd
         XR+VAeTVfXIHYmLi/W9pKw+qIPxzmBSWFxb6lOUgakcyouuz8V9OHQNZ/6Dv6Jnkdd
         +fFfNzzVAa5ZKCBoPYtn6rR+w4Gmxc06G/lYHVOxgb2QCpbzgKGBVWE8SnPiIOB1Ds
         iv4uuFZBChOh5vNE0pE1YDVa573PZ8u9RYwWWWFcPAwi7nT16loR/n0HlyvevXiMKD
         FiX7669EEUA0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AD7115C0546; Fri,  6 Aug 2021 10:44:11 -0700 (PDT)
Date:   Fri, 6 Aug 2021 10:44:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Juri Lelli <juri.lelli@redhat.com>, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Make rcu_normal_after_boot writable on RT
Message-ID: <20210806174411.GQ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210805080123.16320-1-juri.lelli@redhat.com>
 <20210805160337.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <20210806080455.wkhlebgt7howjcrk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806080455.wkhlebgt7howjcrk@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:04:55AM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-08-05 09:03:37 [-0700], Paul E. McKenney wrote:
> > Makes sense to me!
> > 
> > But would another of the -rt people be willing to give an Acked-by?
> > For example, maybe they would prefer this kernel boot parameter to be
> > exposed only if (!PREEMPT_RT || NO_HZ_FULL).  Or are there !NO_HZ_FULL
> > situations where rcu_normal_after_boot makes sense?
> 
> Julia crafted that "rcu_normal_after_boot = 1" for RT after we had more
> and more synchronize_rcu_expedited() users popping up. I would like to
> keep that part (default value) since it good to have for most users.
> 
> I don't mind removing CONFIG_PREEMPT_RT part here if there are legitimate
> use cases for using "rcu_normal_after_boot = 0".
> Paul suggested initially to restrict that option for PREEMPT_RT and I
> would follow here Paul's guidance to either remove it or restrict it to
> NO_HZ_FULL in RT's case (as suggested).

Given what I know now, I suggest the following:

o	Restrict the option to !PREEMPT_RT unless NO_HZ_FULL.
	Maybe "!defined(CONFIG_PREEMPT_RT) || defined(CONFIG_NO_HZ_FULL)".

	If there is some non-NO_HZ_FULL PREEMPT_RT configuration that
	tolerates expedited grace periods, this would need to change.

o	Change the permissions from "0" to "0444", if desired.	If you
	would rather not, I can do this in a follow-up patch.  (No idea
	why I let such an ugly serviceability issue through, but the
	previous pair of module_param() instances have the same problem.)

Anything I am missing?

							Thanx, Paul
