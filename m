Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB636118B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhDOR7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:59:22 -0400
Received: from foss.arm.com ([217.140.110.172]:51796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232759AbhDOR7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:59:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98E5E106F;
        Thu, 15 Apr 2021 10:58:57 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 125DC3FA45;
        Thu, 15 Apr 2021 10:58:55 -0700 (PDT)
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
Subject: [PATCH 0/2] sched/fair: (The return of) misfit task load-balance tweaks
Date:   Thu, 15 Apr 2021 18:58:44 +0100
Message-Id: <20210415175846.494385-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is the misfit-specific bits I tore out of [1] and that I've been further
chewing on.

o Patch 1 pays attention to group vs CPU capacity checks. It's removing some
  safeguard we had against downmigrations, so it had to grow fatter to
  compensate for it.
o Patch 2 aligns running and non-running misfit task cache hotness
  considerations

This is based on top of today's tip/sched/core at:

  e0ccd4a3b01 ("rseq: Optimise rseq_get_rseq_cs() and clear_rseq_cs()")
  
Revisions
=========

v3 -> part 2 v1
---------------

o Removed sg_lb_stats->group_has_misfit_task (Vincent)
o Shoved misfit specific update_sg_lb_stats() work into its own function
  (Vincent)

o Added migrate_degrades_capacity()
o Made task_hot() tweak depend on
  src_grp_type == group_has_spare
  rather than
  idle != CPU_NOT_IDLE

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

[1]: http://lore.kernel.org/r/20210311120527.167870-1-valentin.schneider@arm.com
[2]: http://lore.kernel.org/r/20210217120854.1280-1-clingutla@codeaurora.org


Cheers,
Valentin

Valentin Schneider (2):
  sched/fair: Filter out locally-unsolvable misfit imbalances
  sched/fair: Relax task_hot() for misfit tasks

 kernel/sched/fair.c | 99 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 18 deletions(-)

--
2.25.1

