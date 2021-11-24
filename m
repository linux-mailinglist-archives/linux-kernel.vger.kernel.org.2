Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866CD45C711
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353088AbhKXOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:21:08 -0500
Received: from foss.arm.com ([217.140.110.172]:39416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353344AbhKXOSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:18:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA6B3ED1;
        Wed, 24 Nov 2021 06:15:39 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.56.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 97F2B3F73B;
        Wed, 24 Nov 2021 06:15:38 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] sched/fair: Fix per-CPU kthread and wakee stacking for asym CPU capacity
Date:   Wed, 24 Nov 2021 14:14:35 +0000
Message-Id: <20211124141435.3125147-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A shortcut has been introduced in select_idle_sibling() to return prev_cpu
if the wakee is woken up by a per-CPU kthread. This is an issue for
asymmetric CPU capacity systems where the wakee might not fit prev_cpu
anymore. Evaluate asym_fits_capacity() for prev_cpu before using that
shortcut.

Fixes: 52262ee567ad ("sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6291876a9d32..b90dc6fd86ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6410,7 +6410,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (is_per_cpu_kthread(current) &&
 	    prev == smp_processor_id() &&
-	    this_rq()->nr_running <= 1) {
+	    this_rq()->nr_running <= 1 &&
+	    asym_fits_capacity(task_util, prev)) {
 		return prev;
 	}
 
-- 
2.25.1

