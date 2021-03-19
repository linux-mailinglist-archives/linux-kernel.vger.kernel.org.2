Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB634170C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhCSIBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:01:42 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:44750 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbhCSIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:01:09 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id A6E20E034C;
        Fri, 19 Mar 2021 16:01:05 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrey Ignatov <rdna@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] workqueue: watchdog: update wq_watchdog_touched for unbound lockup checking
Date:   Fri, 19 Mar 2021 16:00:36 +0800
Message-Id: <1616140838-24222-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHR9DSRodH00aGU4dVkpNSk1KT0tDTU1KSkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6MCo*KD8SVk00LRM2IzUv
        EB0aCz5VSlVKTUpNSk9LQ01NT0pIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFITkxMNwY+
X-HM-Tid: 0a78498091ee2c17kusna6e20e034c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When touch_softlockup_watchdog() is called, only wq_watchdog_touched_cpu 
updated, while the unbound worker_pool running on its core uses 
wq_watchdog_touched to determine whether locked up. This may be mischecked.

My suggestion is to update both when touch_softlockup_watchdog() is called, 
use wq_watchdog_touched_cpu to check bound, and use wq_watchdog_touched 
to check unbound worker_pool.

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

