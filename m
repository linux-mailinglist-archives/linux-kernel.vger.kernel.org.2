Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3779E34B744
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 13:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC0Mon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 08:44:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15363 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0Moj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 08:44:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6z571qPPz90JD;
        Sat, 27 Mar 2021 20:42:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:44:32 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched,psi: fix typo in comment
Date:   Sat, 27 Mar 2021 20:46:10 +0800
Message-ID: <20210327124610.7276-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/exceution/execution/
s/possibe/possible/
s/manupulations/manipulations/

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 kernel/sched/psi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 967732c0766c..7c800be47c6f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -59,7 +59,7 @@
  * states, we would have to conclude a CPU SOME pressure number of
  * 100%, since *somebody* is waiting on a runqueue at all
  * times. However, that is clearly not the amount of contention the
- * workload is experiencing: only one out of 256 possible exceution
+ * workload is experiencing: only one out of 256 possible execution
  * threads will be contended at any given time, or about 0.4%.
  *
  * Conversely, consider a scenario of 4 tasks and 4 CPUs where at any
@@ -73,7 +73,7 @@
  * we have to base our calculation on the number of non-idle tasks in
  * conjunction with the number of available CPUs, which is the number
  * of potential execution threads. SOME becomes then the proportion of
- * delayed tasks to possibe threads, and FULL is the share of possible
+ * delayed tasks to possible threads, and FULL is the share of possible
  * threads that are unproductive due to delays:
  *
  *	threads = min(nr_nonidle_tasks, nr_cpus)
@@ -441,7 +441,8 @@ static void psi_avgs_work(struct work_struct *work)
 	mutex_unlock(&group->avgs_lock);
 }
 
-/* Trigger tracking window manupulations */
+/* Trigger tracking window manipulations */
+
 static void window_reset(struct psi_window *win, u64 now, u64 value,
 			 u64 prev_growth)
 {
-- 
2.25.1

