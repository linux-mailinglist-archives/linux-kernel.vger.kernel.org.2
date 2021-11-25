Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2F45D80E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbhKYKSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:18:03 -0500
Received: from foss.arm.com ([217.140.110.172]:48986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347793AbhKYKQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:16:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F8931042;
        Thu, 25 Nov 2021 02:12:51 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.59.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 29CEE3F5A1;
        Thu, 25 Nov 2021 02:12:50 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2] sched/fair: Fix per-CPU kthread and wakee stacking for asym CPU capacity
Date:   Thu, 25 Nov 2021 10:12:39 +0000
Message-Id: <20211125101239.3248857-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_sibling() has a special case for tasks woken up by a per-CPU
kthread. For this case, the chosen CPU is the previous one. This is an
issue for asymmetric CPU capacity systems where the wakee might not fit
that CPU anymore. Evaluate asym_fits_capacity() for prev_cpu before using
the exit path described above.

Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
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

