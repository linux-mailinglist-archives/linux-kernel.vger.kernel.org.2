Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0D5307E12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhA1Sed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:34:33 -0500
Received: from foss.arm.com ([217.140.110.172]:37298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231404AbhA1Scx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:32:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBF3B13A1;
        Thu, 28 Jan 2021 10:32:05 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DA783F719;
        Thu, 28 Jan 2021 10:32:04 -0800 (PST)
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
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 0/8] sched/fair: misfit task load-balance tweaks
Date:   Thu, 28 Jan 2021 18:31:33 +0000
Message-Id: <20210128183141.28097-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Here is this year's series of misfit changes. On the menu:

o Patch 1 is an independent active balance cleanup
o Patch 2 adds some more sched_asym_cpucapacity static branches
o Patch 3 introduces yet another margin for capacity to capacity
  comparisons
o Patches 4-6 build on top of patch 3 and change capacity comparisons
  throughout misfit load balancing  
o Patches 7-8 fix some extra misfit issues I've been seeing on "real"
  workloads.

IMO the somewhat controversial bit is patch 3, because it attempts to solve
margin issues by... Adding another margin. This does solve issues on
existing platforms (e.g. Pixel4), but we'll be back to square one the day
some "clever" folks spin a platform with two different CPU capacities less than
5% apart.

This is based on top of today's tip/sched/core at:

  65bcf072e20e ("sched: Use task_current() instead of 'rq->curr == p'")

Cheers,
Valentin

Valentin Schneider (8):
  sched/fair: Clean up active balance nr_balance_failed trickery
  sched/fair: Add more sched_asym_cpucapacity static branch checks
  sched/fair: Tweak misfit-related capacity checks
  sched/fair: Use dst_cpu's capacity rather than group {min, max}
    capacity
  sched/fair: Make check_misfit_status() only compare dynamic capacities
  sched/fair: Filter out locally-unsolvable misfit imbalances
  sched/fair: Attempt misfit active balance when migration_type !=
    migrate_misfit
  sched/fair: Relax task_hot() for misfit tasks

 kernel/sched/fair.c  | 138 ++++++++++++++++++++++++++-----------------
 kernel/sched/sched.h |   6 ++
 2 files changed, 89 insertions(+), 55 deletions(-)

--
2.27.0

