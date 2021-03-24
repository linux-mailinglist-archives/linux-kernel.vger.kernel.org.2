Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB4A34777A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhCXLfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:35:11 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:33158 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhCXLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:34:27 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.229])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 9C665E03B9;
        Wed, 24 Mar 2021 19:34:21 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Wang Qing <wangqing@vivo.com>, Petr Mladek <pmladek@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] workqueue/watchdog: Make unbound workqueues aware of
Date:   Wed, 24 Mar 2021 19:34:02 +0800
Message-Id: <1616585643-26720-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSUtNTUNCSRkdQk4ZVkpNSk1OQ05NTUpCQkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6Nio5Qj8VHj8ZKBA#FEMi
        EBkwCTZVSlVKTUpNTkNOTU1JSExJVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUJZV1kIAVlBT09NQzcG
X-HM-Tid: 0a7864039de32c17kusn9c665e03b9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two workqueue-specific watchdog timestamps:

    + @wq_watchdog_touched_cpu (per-CPU) updated by
      touch_softlockup_watchdog()

    + @wq_watchdog_touched (global) updated by
      touch_all_softlockup_watchdogs()

watchdog_timer_fn() checks only the global @wq_watchdog_touched for
unbound workqueues. As a result, unbound workqueues are not aware
of touch_softlockup_watchdog(). The watchdog might report a stall
even when the unbound workqueues are blocked by a known slow code.

Solution:
touch_softlockup_watchdog() must touch also the global @wq_watchdog_touched 
timestamp.

The global timestamp can not longer be used for bound workqueues
because it is updated on all CPUs. Instead, bound workqueues
have to check only @wq_watchdog_touched_cpu and these timestamp
has to be updated for all CPUs in touch_all_softlockup_watchdogs().

Beware:
The change might cause the opposite problem. An unbound workqueue
might get blocked on CPU A because of a real softlockup. The workqueue
watchdog would miss it when the timestamp got touched on CPU B.

It is acceptable because softlockups are detected by softlockup
watchdog. The workqueue watchdog is there to detect stalls where
a work never finishes, for example, because of dependencies of works
queued into the same workqueue.

V3:
- Modify the commit message clearly according to Petr's suggestion.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/watchdog.c  |  5 +++--
 kernel/workqueue.c | 17 ++++++-----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7110906..107bc38
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -278,9 +278,10 @@ void touch_all_softlockup_watchdogs(void)
 	 * update as well, the only side effect might be a cycle delay for
 	 * the softlockup check.
 	 */
-	for_each_cpu(cpu, &watchdog_allowed_mask)
+	for_each_cpu(cpu, &watchdog_allowed_mask) {
 		per_cpu(watchdog_touch_ts, cpu) = SOFTLOCKUP_RESET;
-	wq_watchdog_touch(-1);
+		wq_watchdog_touch(cpu);
+	}
 }
 
 void touch_softlockup_watchdog_sync(void)
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da..be08295
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5787,22 +5787,17 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 			continue;
 
 		/* get the latest of pool and touched timestamps */
+		if (pool->cpu >= 0)
+			touched = READ_ONCE(per_cpu(wq_watchdog_touched_cpu, pool->cpu));
+		else
+			touched = READ_ONCE(wq_watchdog_touched);
 		pool_ts = READ_ONCE(pool->watchdog_ts);
-		touched = READ_ONCE(wq_watchdog_touched);
 
 		if (time_after(pool_ts, touched))
 			ts = pool_ts;
 		else
 			ts = touched;
 
-		if (pool->cpu >= 0) {
-			unsigned long cpu_touched =
-				READ_ONCE(per_cpu(wq_watchdog_touched_cpu,
-						  pool->cpu));
-			if (time_after(cpu_touched, ts))
-				ts = cpu_touched;
-		}
-
 		/* did we stall? */
 		if (time_after(jiffies, ts + thresh)) {
 			lockup_detected = true;
@@ -5826,8 +5821,8 @@ notrace void wq_watchdog_touch(int cpu)
 {
 	if (cpu >= 0)
 		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
-	else
-		wq_watchdog_touched = jiffies;
+
+	wq_watchdog_touched = jiffies;
 }
 
 static void wq_watchdog_set_thresh(unsigned long thresh)
-- 
2.7.4

