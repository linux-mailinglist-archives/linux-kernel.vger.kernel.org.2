Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86646363AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhDSEw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhDSEwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:52:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E80D961078;
        Mon, 19 Apr 2021 04:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618807916;
        bh=fmIRWNC1qpVwLC7qncFDGW7uX2F2qWBvSljbuHIYyNc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=b3CDwOfEKG8yRQ8zkfVJVCez4kDSKl/m3WztFyrSF6+136vTwJ+hH9OIp5Bqe7E+x
         bgARSYlPSgKCdaZcQ4dgx+dDN+UoWOPBmZwqoSb0rBUFn4FCs3p9wDDMKIXhfRX6HB
         4Weo1HHcX94uVIKv3/EWqC0aGlRnDxvbarv3FrRhZxaYkAKCH07Xi+78N9I7okaI+J
         w1ZEQIikNpNVyx7P1w/B3QbEiM2CyVt878DdCJSb5dFu+q9ZAMNEg0Mx5cW3MkLxxI
         Abvo5qnv2+F0Z9zAOaQ9bZulYyr/0fxA0l1u57zen0cv8ZIMhlbo7OvNc9tUj7SeO6
         Kvs+fHBbVEPNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AE8795C00F0; Sun, 18 Apr 2021 21:51:55 -0700 (PDT)
Date:   Sun, 18 Apr 2021 21:51:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: [PATCH v9 clocksource 0/6] Do not mark clocks unstable due to delays
 for v5.13
Message-ID: <20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1>
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

6.	Reduce the clock-skew limit to 200us and the maximum permissible
	clock read delay to 50us.

Changes since v8, based on Thomas Gleixner feedback:

o	Reduced clock-skew threshold to 200us and delay limit to 50us.

o	Split out a cs_watchdog_read() function.

o	Removed the pointless CLOCK_SOURCE_VERIFY_PERCPU from kvm_clock.

o	Initialized cs_nsec_max and cs_nsec_min to avoid firsttime checks.

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

 Documentation/admin-guide/kernel-parameters.txt   |   32 +++
 b/Documentation/admin-guide/kernel-parameters.txt |   16 +
 b/arch/x86/kernel/tsc.c                           |    3 
 b/include/linux/clocksource.h                     |    2 
 b/kernel/time/clocksource.c                       |   23 ++
 kernel/time/clocksource.c                         |  201 ++++++++++++++++++++--
 6 files changed, 263 insertions(+), 14 deletions(-)
