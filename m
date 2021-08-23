Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49EB3F4981
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhHWLRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:17:50 -0400
Received: from foss.arm.com ([217.140.110.172]:51982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234865AbhHWLRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:17:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A447D1042;
        Mon, 23 Aug 2021 04:17:05 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDEE63F66F;
        Mon, 23 Aug 2021 04:17:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v3 0/2] sched/fair: nohz.next_balance vs newly-idle CPUs
Date:   Mon, 23 Aug 2021 12:16:58 +0100
Message-Id: <20210823111700.2842997-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This was caught up by our testing on an arm64 RB5 board - that's an 8 CPUs
DynamIQ SoC with 4 littles, 3 mediums and 1 big. It seems to rely more on NOHZ
balancing than our other boards being tested, which highlighted that not
including a newly-idle CPU into nohz.next_balance can cause issues (especially
when the other CPUs have had their balance_interval inflated by pinned tasks).

As suggested by Vincent, the approach here is to mimic what was done for
nohz.has_blocked, which gives us sane(ish) ordering guarantees.

Revisions
=========

v2 -> v3
++++++++

o Rebased against latest tip/sched/core: 234b8ab6476c ("sched: Introduce
  dl_task_check_affinity() to check proposed affinity")
  
o Kept NOHZ_NEXT_KICK in NOHZ_KICK_MASK, but changed nohz_balancer_kick() to
  issue kicks with NOHZ_STATS_KICK | NOHZ_BALANCE_KICK instead (Dietmar)
o Added missing NOHZ_STATS_KICK gate for nohz.next_blocked update (Vincent)

v1 -> v2
++++++++

o Ditched the extra cpumasks and went with a sibling of nohz.has_blocked
  (Vincent) 

Cheers,
Valentin

Valentin Schneider (2):
  sched/fair: Add NOHZ balancer flag for nohz.next_balance updates
  sched/fair: Trigger nohz.next_balance updates when a CPU goes
    NOHZ-idle

 kernel/sched/fair.c  | 39 +++++++++++++++++++++++++++------------
 kernel/sched/sched.h |  8 +++++++-
 2 files changed, 34 insertions(+), 13 deletions(-)

--
2.25.1

