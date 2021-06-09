Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2724B3A20D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhFIXjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFIXjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:39:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5471B61182;
        Wed,  9 Jun 2021 23:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623281843;
        bh=s4lj4jaG7j9skEZ0/i486amDJv+SO4e2EY7hKMmEHEk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=R5yMbOkry1pAKFYQ3rE58shOJrKGwwFPv8B1hzzXeXNxGWEl2UnE3U0r8fOiX+L94
         z81oRb2mqvYq/erMTYzgOFgNvaIrYfyrFPaDV4vuwE8PeM0VGGj7uTucwIBBUUj29V
         tw5KwPMYwNUl6KW4zOGKf3lhGPB2yI0GFHARKkL+qjorXJhlHwjHoKRrzMWfYsdmS+
         JTM9FUWXU95iK58tLqfwqwWQ0Xm85aViXLmAO+426INBFqobagSVdZ5F1zG98Mnmgo
         ZqstscUX9S5VsoJQW/mb9PU2qTR1BRfYq2wLIN7Muur2/O1BOPg9Gfx+x3aDW2Pf9l
         NRPuBu5jig9cQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 175BA5C08D8; Wed,  9 Jun 2021 16:37:23 -0700 (PDT)
Date:   Wed, 9 Jun 2021 16:37:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        luming.yu@intel.com
Subject: [GIT PULL clocksource] Clocksource watchdog commits for v5.14
Message-ID: <20210609233723.GA1717240@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas,

This pull request contains changes to cause the clocksource watchdog to
reject measurement noise caused by delays between clocksource reads.
These have been posted a few times to LKML, most recently v15:

https://lore.kernel.org/lkml/20210527190042.GA438700@paulmck-ThinkPad-P17-Gen-1/

These have been acked by Feng Tang and reviewed by Luming Yu.  These have
also been subjected to subjected to the kbuild test robot and -next
testing, and are available in the git repository based on v5.13-rc1 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource

for you to fetch changes up to 023766fbdde49c75c13acd268bf9af810d624c59:

  clocksource: Print deviation in nanoseconds for unstable case (2021-06-04 13:20:31 -0700)

----------------------------------------------------------------
Feng Tang (1):
      clocksource: Print deviation in nanoseconds for unstable case

Paul E. McKenney (5):
      clocksource: Retry clock read if long delays detected
      clocksource: Check per-CPU clock synchronization when marked unstable
      clocksource: Limit number of CPUs checked for clock synchronization
      clocksource: Reduce clocksource-skew threshold for TSC
      clocksource: Provide kernel module to test clocksource watchdog

 Documentation/admin-guide/kernel-parameters.txt |  22 +++
 arch/x86/kernel/tsc.c                           |   4 +-
 include/linux/clocksource.h                     |   8 +-
 kernel/time/Makefile                            |   1 +
 kernel/time/clocksource-wdtest.c                | 202 +++++++++++++++++++++
 kernel/time/clocksource.c                       | 226 ++++++++++++++++++++++--
 kernel/time/jiffies.c                           |  15 +-
 lib/Kconfig.debug                               |  12 ++
 8 files changed, 468 insertions(+), 22 deletions(-)
 create mode 100644 kernel/time/clocksource-wdtest.c
