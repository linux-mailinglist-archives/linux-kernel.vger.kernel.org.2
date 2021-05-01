Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1837046F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 02:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhEAAcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 20:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhEAAcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:32:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B871A61409;
        Sat,  1 May 2021 00:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619829124;
        bh=7xDC2tPQYqv8y+HR9kueGyxrx78+uzWTPpB0xELv/zc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sEambGODQzrKeAdB1wdPC6mdJ9oS2+C/UVpcgIvU/WLrhfMP+qO99mRewkAH1csEa
         qNqC5UBOGZ3r5pDQV7Es93pJGg92HFLRlxYdSBtBNX0jQFgVTWD9IUV5oFE2k2D7P0
         v8vcgwK9Nv1iBHQn6tYZXWR+fV33zYwEI3m8tKruKa+4M5jUmAZxwx1aS7jcCDZAYc
         wNoYw78k+5KDq1244b9/6GokNRHyKSUfIu3NCuto1ARIjXYm2/+HQbQFjckQvGq4bJ
         JqnlKcjac1uow/0grsVFuVk0p3IeQCObKrk3NDFjkZYUJ5a+KErbvnN7JLjSJme0Kj
         8+yL8Rs4+jDfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 561AC5C0153; Fri, 30 Apr 2021 17:32:04 -0700 (PDT)
Date:   Fri, 30 Apr 2021 17:32:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [PATCH v12 clocksource 0/5] Do not mark clocks unstable due to
 delays for v5.13
Message-ID: <20210501003204.GA2447938@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

If there is a sufficient delay between reading the watchdog clock and the
clock under test, the clock under test will be marked unstable through no
fault of its own.  This series checks for this, doing limited retries
to get a good set of clock reads.  If the clock is marked unstable
and is marked as being per-CPU, cross-CPU synchronization is checked.
This series also provides a clocksource-watchdog-test kernel module that
tests this new ability of distinguishing delay-induced clock skew from
true clock skew.

Note that "sufficient delay" can be provided by SMIs, NMIs, and of course
vCPU preemption.

The patches in this series are as follows:

1.	Retry clock read if long delays detected.

2.	Check per-CPU clock synchronization when marked unstable.

3.	Limit number of CPUs checked for clock synchronization.

4.	Reduce clocksource-skew threshold for TSC.

5.	Provide kernel module to test clocksource watchdog.

Changes since v11, based on feedback from Thomas Gleixner:

o	Remove the fault-injection code from clocksource.c.

o	Create a kernel/time/clocksource-wdtest.c kernel module that
	creates its own clocksource structures and injects delays
	as part of their ->read() functions.

o	Make this kernel module splat upon error, for example, when
	a clocksource is not marked unstable but should have been.

o	Apply a couple more "Link:" fields to all patches.

Changes since v9:

o	Forgive tsc_early drift, based on feedback from Feng Tang; Xing,
	Zhengjun; and Thomas Gleixner.

o	Improve CPU selection for clock-synchronization checking.

Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/

Changes since v8, based on Thomas Gleixner feedback:

o	Reduced clock-skew threshold to 200us and delay limit to 50us.

o	Split out a cs_watchdog_read() function.

o	Removed the pointless CLOCK_SOURCE_VERIFY_PERCPU from kvm_clock.

o	Initialized cs_nsec_max and cs_nsec_min to avoid firsttime checks.

Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/

Changes since v7, based on Thomas Gleixner feedback:

o	Fix embarrassing git-format-patch operator error.

o	Merge pairwise clock-desynchronization checking into the checking
	of per-CPU clock synchronization when marked unstable.

o	Do selective per-CPU checking rather than blindly checking all
	CPUs.  Provide a clocksource.verify_n_cpus kernel boot parameter
	to control this behavior, with the value -1 choosing the old
	check-all-CPUs behavior.  The default is to randomly check 8 CPUs.

o	Fix the clock-desynchronization checking to avoid a potential
	use-after-free error for dynamically allocated clocksource
	structures.

o	Remove redundance "wdagain_nsec < 0" from clocksource_watchdog()
	clocksource skew checking.

o	Update commit logs and do code-style updates.

Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/

Changes since v5:

o	Rebased to v5.12-rc5.

Changes since v4:

o	Rebased to v5.12-rc1.

Changes since v3:

o	Rebased to v5.11.

o	Apply Randy Dunlap feedback.

Changes since v2:

o	Rebased to v5.11-rc6.

o	Updated Cc: list.

Changes since v1:

o	Applied feedback from Rik van Riel.

o	Rebased to v5.11-rc3.

o	Stripped "RFC" from the subject lines.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |   16 +
 arch/x86/kernel/tsc.c                             |    1 
 b/Documentation/admin-guide/kernel-parameters.txt |    6 
 b/arch/x86/kernel/tsc.c                           |    3 
 b/include/linux/clocksource.h                     |    2 
 b/kernel/time/Makefile                            |    1 
 b/kernel/time/clocksource-wdtest.c                |  202 ++++++++++++++++++++++
 b/kernel/time/clocksource.c                       |   52 +++++
 b/kernel/time/jiffies.c                           |   15 -
 b/lib/Kconfig.debug                               |   12 +
 include/linux/clocksource.h                       |    6 
 kernel/time/clocksource.c                         |  193 +++++++++++++++++++--
 12 files changed, 477 insertions(+), 32 deletions(-)
