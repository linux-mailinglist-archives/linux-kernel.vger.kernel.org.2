Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD7357752
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhDGWGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:06:50 -0400
Received: from foss.arm.com ([217.140.110.172]:35740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhDGWGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:06:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1138F1063;
        Wed,  7 Apr 2021 15:06:38 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DA083F792;
        Wed,  7 Apr 2021 15:06:36 -0700 (PDT)
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
Subject: [PATCH v5 0/3] sched/fair: load-balance vs capacity margins
Date:   Wed,  7 Apr 2021 23:06:25 +0100
Message-Id: <20210407220628.3798191-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I split up the extra misfit patches from v3 as I'm still playing around with
those following Vincent's comments. In the meantime, I believe the first few
patches of the series can still be considered as standalone.

o Patch 1 prevents pcpu kworkers from causing group_imbalanced
o Patch 2 is an independent active balance cleanup
o Patch 3 introduces yet another margin for capacity to capacity
  comparisons

The "important" one is patch 3, as it solves misfit migration issues on newer
platforms.
  
This is based on top of today's tip/sched/core at:

  0a2b65c03e9b ("sched/topology: Remove redundant cpumask_and() in init_overlap_sched_group()")

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


The 0day bot reported [3] the first patch causes a ~14% regression on its
stress-ng.vm-segv testcase. I ran that testcase on: 

o Ampere eMAG (arm64, 32 cores)
o 2-socket Xeon E5-2690 (x86, 40 cores)

and found at worse a -0.3% regression and at best a 2% improvement - I'm
getting nowhere near -14%.
  
Revisions
=========

v4 -> v5
--------
o Collected Reviewed-by (Vincent, Dietmar)
o Fixed typo in patch 1 (Dietmar)
o Appended paragraph about using local group vs dst cpu in patch 3 (Dietmar)

v3 -> v4
--------
o Tore out the extra misfit patches

o Rewrote patch 1 changelog (Dietmar)
o Reused LBF_ACTIVE_BALANCE to ditch LBF_DST_PINNED active balance logic
  (Dietmar)
o Collected Tested-by (Lingutla)  

o Squashed capacity_greater() introduction and use (Vincent)
o Removed sched_asym_cpucapacity() static key proliferation (Vincent)

v2 -> v3
--------

o Rebased on top of latest tip/sched/core
o Added test results vs stress-ng.vm-segv

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
[3]: http://lore.kernel.org/r/20210223023004.GB25487@xsang-OptiPlex-9020

Cheers,
Valentin

Lingutla Chandrasekhar (1):
  sched/fair: Ignore percpu threads for imbalance pulls

Valentin Schneider (2):
  sched/fair: Clean up active balance nr_balance_failed trickery
  sched/fair: Introduce a CPU capacity comparison helper

 kernel/sched/fair.c | 68 +++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

--
2.25.1

