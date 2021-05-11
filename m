Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7151437B23C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEKXM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKXM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:12:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C22A611F0;
        Tue, 11 May 2021 23:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774709;
        bh=zBzw4r9l2+Rfjh0AnYkkAiHcc5UgED/szOpl52wzT2o=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=BReDHbu9I/esUgifJWngKvl+GdkQti1Ra02RLK6VYtjXP5Cz1Vi39rlf/4N/yD7I4
         YqBYSwGG40GLyveXVSFS4F5x4iTljQUUgwtuNY1WlFczspnBlBciPLw3oh/ROuWQFe
         NtXVpg2JZOVTzGqKoeakQ/3SP/5KMD15wrqYnBmDV2t8vRKf+2UOZ99rmDLjdHn5pT
         5/+hRQW9VUkLIGhZvz8RxMXkMqa8snemxo0Ro/c+tfODrt1sEXjkZ1EzT0+CYsa+Dn
         1t6zbIOYUoKH1mFK9n32Dsr7RU5lj6L1/lydzCHfDG1WR4aUAjykYNOBuwqL1372Hl
         9bFIn8cZWO+ZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3E89A5C0138; Tue, 11 May 2021 16:11:49 -0700 (PDT)
Date:   Tue, 11 May 2021 16:11:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/26] Torture-test updates for v5.14
Message-ID: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides torture-test updates:

1.	Fix remaining erroneous torture.sh instance of $*.

2.	Add "scenarios" option to kvm.sh --dryrun parameter.

3.	Make kvm-again.sh use "scenarios" rather than "batches" file.

4.	Allow CPU hotplug to be enabled.

5.	Allow CPU hotplug to be enabled.

6.	Add kvm-remote.sh script for distributed rcutorture test runs.

7.	Add acqrel, lock, and lock-irq.

8.	Abstract read-lock-held checks.

9.	Fix grace-period rate output.

10.	Abstract end-of-run summary.

11.	Make kvm.sh use abstracted kvm-end-run-stats.sh.

12.	Make the build machine control N in "make -jN".

13.	Make kvm-find-errors.sh account for kvm-remote.sh.

14.	Judge RCU priority boosting on grace periods, not callbacks.

15.	Correctly fetch number of CPUs for non-English languages,
	courtesy of Frederic Weisbecker.

16.	Set kvm.sh language to English.

17.	Delay-based false positives for RCU priority boosting tests.

18.	Consolidate rcu_torture_boost() timing and statistics.

19.	Make rcu_torture_boost_failed() check for GP end.

20.	Add BUSTED-BOOST to test RCU priority boosting tests.

21.	Forgive RCU boost failures when CPUs don't pass through QS.

22.	Don't count CPU-stalled time against priority boosting.

23.	Make kvm-remote.sh account for network failure in pathname checks.

24.	Don't cap remote runs by build-system number of CPUs.

25.	Move mem_dump_obj() tests into separate function.

26.	Don't penalize priority boosting when there is nothing to boost.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcu.h                                                 |    2 
 b/kernel/rcu/rcutorture.c                                          |   29 
 b/kernel/rcu/refscale.c                                            |  109 +++
 b/kernel/rcu/tree_stall.h                                          |   36 +
 b/tools/testing/selftests/rcutorture/bin/kvm-again.sh              |   22 
 b/tools/testing/selftests/rcutorture/bin/kvm-build.sh              |    6 
 b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh      |   40 +
 b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh        |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh        |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh             |  227 +++++++
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                    |   28 
 b/tools/testing/selftests/rcutorture/bin/torture.sh                |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST      |   17 
 b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot |    8 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE         |    2 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54       |    2 
 b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT    |    2 
 b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT      |    2 
 kernel/rcu/rcutorture.c                                            |  300 +++++-----
 kernel/rcu/tree_stall.h                                            |   27 
 tools/testing/selftests/rcutorture/bin/kvm-again.sh                |   11 
 tools/testing/selftests/rcutorture/bin/kvm-build.sh                |    2 
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh               |   30 -
 tools/testing/selftests/rcutorture/bin/kvm.sh                      |   33 -
 24 files changed, 726 insertions(+), 215 deletions(-)
