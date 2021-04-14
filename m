Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9719735EBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhDNEfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhDNEe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:34:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90D62611F2;
        Wed, 14 Apr 2021 04:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618374875;
        bh=f3YnIORksW8+J+Vt2XfZOI06xZ+OvPLAHyfAqfnEuqg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=aBm4s8t93rr6Vrztky/y09f0VrJfOO3xQbllY35FMWnrjirAbWzE8oVgkacuSYHBJ
         6d8+EywN0MnBtwZan4UZHqI3adC0gWkGW++ofVXzxjzvXWTeQCSPP332L22XkSIB4c
         V7EgY9zB2w1qTqVXTPfedJN9E0RgLoqoTNgmTp5TWgQp4oJlnWsllDwiyrUtbBzelF
         ORdLnNXbR8z08MB9Fejm+qG2f0u2i6lxiop2utINI+yM0o0hhvHH5aArWPlaMiwTek
         RUTzS2ecNWreXMJ9PSekkOlfK2US5k2+jXbfmfIuefiDYVKQ0Cc5/Ol7hEqETESrZm
         xU1o2dGZ4jCPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5098E5C23F6; Tue, 13 Apr 2021 21:34:35 -0700 (PDT)
Date:   Tue, 13 Apr 2021 21:34:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: [PATCH v8 clocksource] Do not mark clocks unstable due to delays for
 v5.13
Message-ID: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
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

 Documentation/admin-guide/kernel-parameters.txt   |   26 +++
 b/Documentation/admin-guide/kernel-parameters.txt |   22 ++
 b/arch/x86/kernel/kvmclock.c                      |    2 
 b/arch/x86/kernel/tsc.c                           |    3 
 b/include/linux/clocksource.h                     |    2 
 b/kernel/time/clocksource.c                       |   27 +++
 kernel/time/clocksource.c                         |  171 +++++++++++++++++++++-
 7 files changed, 243 insertions(+), 10 deletions(-)
