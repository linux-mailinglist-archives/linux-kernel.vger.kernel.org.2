Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2185036E2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 03:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhD2B34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 21:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhD2B3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 21:29:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F0A16143F;
        Thu, 29 Apr 2021 01:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619659749;
        bh=tNCESXlhd++WxhEWc6QflZmAdrfeUGVNp1w9+e4M3A4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=XDLBU9xYjeygx5pXxmPNICPEidBcweOU4SidAtkLeaXGKWnx7EJSYCgZpyg4g2x88
         JP4rabtNi4zYi36PjQOc02yjqF/nxXoHdgXKcFMcoD+f+bap6gQrewJ5xjImgd3AVI
         vGsBMu/JjrtVvcuQkYQrlxXsfUkHPYuuorAP4WsJTMiX2gxhaOHhAIgZ8iQ74VkUvJ
         GVEZbigPRutQPcuKeJchtHI5ltDae67cH1PSCcnEoXh9LN+bRSnTl6Z+x83YugLgA7
         OCPjdL9RNs/xHxG+f1WWfFZ+thKgPPaj/8UsAtK7ciBMHXln9s1lyaVrwO1AJaW/9X
         ZOA1zhMOvWXhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3EB1C5C0530; Wed, 28 Apr 2021 18:29:09 -0700 (PDT)
Date:   Wed, 28 Apr 2021 18:29:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [PATCH V11 clocksource 0/6] Do not mark clocks unstable due to
 delays for v5.13
Message-ID: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
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
This series also provides delay injection, which may be enabled via
kernel boot parameters to test the checking for delays.

Note that "sufficient delay" can be provided by SMIs, NMIs, and of course
vCPU preemption.

1.	Provide module parameters to inject delays in watchdog.

2.	Retry clock read if long delays detected.

3.	Check per-CPU clock synchronization when marked unstable.

4.	Provide a module parameter to fuzz per-CPU clock checking.

5.	Limit number of CPUs checked for clock synchronization.

6.	Reduce clocksource-skew threshold for TSC.

Changes since v10, based on feedback from Thomas Gleixner, Peter Zijlstra,
Feng Tang, Andi Kleen, Luming Yu, Xing Zhengju, and the indefatigible
kernel test robot:

o	Automatically compute the uncertainty margin for clocksource, and
	also allow them to be specified manually before that clocksource
	is registered.

o	For the automatically computed uncertainty margins, bound them
	below by 100 microseconds (2 * WATCHDOG_MAX_SKEW).

o	For the manually specified uncertainty margins, splat (but
	continue) if they are less than 100 microseconds (again 2 *
	WATCHDOG_MAX_SKEW).  The purpose of splatting is to discourage
	production use of this clock-skew-inducing debugging technique.

o	Manually set the uncertainty margin for clocksource_jiffies
	(and thus refined_jiffies) to TICK_NSEC to compensate for the
	very low frequency of these clocks.

o	Manually set the uncertainty margin for clocksource_tsc_early
	to 32 milliseconds.

o	Apply numerous "Link:" fields to all patches.

o	Add some acks and CCs.

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

 Documentation/admin-guide/kernel-parameters.txt   |   32 +++
 arch/x86/kernel/tsc.c                             |    1 
 b/Documentation/admin-guide/kernel-parameters.txt |   21 ++
 b/arch/x86/kernel/tsc.c                           |    3 
 b/include/linux/clocksource.h                     |    2 
 b/kernel/time/clocksource.c                       |   23 ++
 b/kernel/time/jiffies.c                           |   15 -
 include/linux/clocksource.h                       |    3 
 kernel/time/clocksource.c                         |  227 ++++++++++++++++++++--
 9 files changed, 304 insertions(+), 23 deletions(-)
