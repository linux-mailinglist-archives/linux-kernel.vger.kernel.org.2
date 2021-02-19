Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69BD31F99D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBSNDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:03:20 -0500
Received: from foss.arm.com ([217.140.110.172]:35824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhBSNDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:03:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B81C1FB;
        Fri, 19 Feb 2021 05:02:30 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEA863F73B;
        Fri, 19 Feb 2021 05:02:28 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH v2 0/7] sched/fair: misfit task load-balance tweaks
Date:   Fri, 19 Feb 2021 12:59:56 +0000
Message-Id: <20210219130003.2890-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Here is this year's series of misfit changes. On the menu:

o Patch 1 prevents pcpu kworkers from causing group_imbalanced
o Patch 2 is an independent active balance cleanup
o Patch 3 adds some more sched_asym_cpucapacity static branches
o Patch 4 introduces yet another margin for capacity to capacity
  comparisons
o Patches 5-6 build on top of patch 4 and change capacity comparisons
  throughout misfit load balancing  
o Patch 7 aligns running and non-running misfit task cache hotness
  considerations

IMO the somewhat controversial bit is patch 4, because it attempts to solve
margin issues by... Adding another margin. This does solve issues on
existing platforms (e.g. Pixel4), but we'll be back to square one the day
some "clever" folks spin a platform with two different CPU capacities less
than 5% apart.

This is based on top of today's tip/sched/core at:

  c5e6fc08feb2 ("sched,x86: Allow !PREEMPT_DYNAMIC")

Testing
=======

I ran my usual [1] misfit tests on
o TC2
o Juno
o HiKey960
o Dragonboard845C
o RB5

RB5 has a similar topology to Pixel4 and highlights the problem of having
two different CPU capacity values above 819 (in this case 871 and 1024):
without these patches, CPU hogs (i.e. misfit tasks) running on the "medium"
CPUs will never be upmigrated to a "big" via misfit balance. 
  
Revisions
=========

v1 -> v2
--------

o Collected Reviewed-by
o Minor comment and code cleanups

o Consolidated static key vs SD flag explanation (Dietmar)

  Note to Vincent: I didn't measure the impact of adding said static key to
  load_balance(); I do however believe it is a low hanging fruit. The
  wrapper keeps things neat and tidy, and is also helpful for documenting
  the intricacies of the static key status vs the presence of the SD flag
  in a CPU's sched_domain hierarchy.
  
o Removed v1 patch 4 - root_domain.max_cpu_capacity is absolutely not what
  I had convinced myself it was.
o Squashed capacity margin usage with removal of
  group_smaller_{min, max}_capacity() (Vincent)   
o Replaced v1 patch 7 with Lingutla's can_migrate_task() patch [2]
o Rewrote task_hot() modification changelog

Links
=====

[1]: https://lisa-linux-integrated-system-analysis.readthedocs.io/en/master/kernel_tests.html#lisa.tests.scheduler.misfit.StaggeredFinishes
[2]: http://lore.kernel.org/r/20210217120854.1280-1-clingutla@codeaurora.org
  
Cheers,
Valentin

Lingutla Chandrasekhar (1):
  sched/fair: Ignore percpu threads for imbalance pulls

Valentin Schneider (6):
  sched/fair: Clean up active balance nr_balance_failed trickery
  sched/fair: Add more sched_asym_cpucapacity static branch checks
  sched/fair: Introduce a CPU capacity comparison helper
  sched/fair: Employ capacity_greater() throughout load_balance()
  sched/fair: Filter out locally-unsolvable misfit imbalances
  sched/fair: Relax task_hot() for misfit tasks

 kernel/sched/fair.c  | 128 ++++++++++++++++++++++++-------------------
 kernel/sched/sched.h |  33 +++++++++++
 2 files changed, 105 insertions(+), 56 deletions(-)

--
2.27.0

