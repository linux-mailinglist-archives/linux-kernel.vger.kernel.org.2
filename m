Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7A45C909
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345179AbhKXPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:46:08 -0500
Received: from foss.arm.com ([217.140.110.172]:40206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344869AbhKXPqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:46:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E87EED1;
        Wed, 24 Nov 2021 07:42:57 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.49.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CC8B3F73B;
        Wed, 24 Nov 2021 07:42:56 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a task
Date:   Wed, 24 Nov 2021 15:42:39 +0000
Message-Id: <20211124154239.3191366-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_sibling() will return prev_cpu for the case where the task is
woken up by a per-CPU kthread. However, the idle task has been recently
modified and is now identified by is_per_cpu_kthread(), breaking the
behaviour described above. Using !is_idle_task() ensures we do not
spuriously trigger that select_idle_sibling() exit path.

Fixes: 00b89fe0197f ("sched: Make the idle task quack like a per-CPU kthread")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 945d987246c5..8bf95b0e368d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * pattern is IO completions.
 	 */
 	if (is_per_cpu_kthread(current) &&
+	    !is_idle_task(current) &&
 	    prev == smp_processor_id() &&
 	    this_rq()->nr_running <= 1) {
 		return prev;
-- 
2.25.1

