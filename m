Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628FF36A9B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 00:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhDYWqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 18:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231247AbhDYWqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 18:46:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A00A61158;
        Sun, 25 Apr 2021 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619390741;
        bh=5oEjuFRmhaDXEDp7tH2L9yJ2rWiNQecv0YUXxvXXbrc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=LeGP1yEMraKZZ6InOV3Z5fWHbzK1jsDuxlsiSoWDGTZNUjxGWWzoeW8Oq+9knZGit
         kYYWymkLyd/RlIrVr46yGHJ1KTSDm+tGdba+y3wxC5wBjSaR0zh26GvfxpovGC9F8+
         AxYCU8tq73S/vJclQ2gI663my8VsXexXNJ3yy6yf4kof7dgmZYh1odJWhCdPqo5a7n
         DSYA+3f2Iv+IimWIlg7h9qRcfkmclXF7gF7cj+yH/2fbVox7xGzWX3E1zvJf6+yqYK
         Kc8Jr3UoBb7VJE2gsYelQkHBPkhGUmq7pNTCYL4B8hKa7y6IJwMqGJwrdyM+31Y3Y6
         b79258KS+blnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9DA25C00EB; Sun, 25 Apr 2021 15:45:40 -0700 (PDT)
Date:   Sun, 25 Apr 2021 15:45:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [PATCH v10 clocksource 0/7] Do not mark clocks unstable due to
 delays for v5.13
Message-ID: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
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

6.	Forgive tsc_early pre-calibration drift.

7.	Reduce the clock-skew limit to 200us and the maximum permissible
	clock read delay to 50us.

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
 b/Documentation/admin-guide/kernel-parameters.txt |   16 +
 b/arch/x86/kernel/tsc.c                           |    3 
 b/include/linux/clocksource.h                     |    2 
 b/kernel/time/clocksource.c                       |   23 ++
 kernel/time/clocksource.c                         |  201 ++++++++++++++++++++--
 6 files changed, 263 insertions(+), 14 deletions(-)
