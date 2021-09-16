Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916F540E8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbhIPSBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:01:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19990 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349562AbhIPSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:00:05 -0400
Received: from dggeme765-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H9PqH1PsQzbmX1;
        Fri, 17 Sep 2021 01:54:35 +0800 (CST)
Received: from DESKTOP-R64PNO0.china.huawei.com (10.67.102.35) by
 dggeme765-chm.china.huawei.com (10.3.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 17 Sep 2021 01:58:41 +0800
From:   Jinhui Guo <guojinhui@huawei.com>
To:     <akpm@linux-foundation.org>, <pmladek@suse.com>,
        <peterz@infradead.org>, <valentin.schneider@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <guojinhui@huawei.com>
Subject: [PATCH] [RFC] watchdog/softlockup: Fix softlockup_stop_all() hungtask bug
Date:   Fri, 17 Sep 2021 01:56:50 +0800
Message-ID: <20210916175650.1380-1-guojinhui@huawei.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.102.35]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme765-chm.china.huawei.com (10.3.19.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If NR_CPUS equal to 1, it would trigger hungtask, it can be
triggered by follow command:
	echo 0 > /proc/sys/kernel/watchdog
	echo 1 > /proc/sys/kernel/watchdog
The hungtask stack:
	__schedule
	schedule
	schedule_timeout
	__wait_for_common
	softlockup_stop_fn
	lockup_detector_reconfigure
	proc_watchdog_common
	proc_watchdog
	proc_sys_call_handler
	vfs_write
	ksys_write
The watchdog_allowed_mask is completely cleared when the
watchdog is disabled. But the macro for_each_cpu() assume
all masks are "1" when macro NR_CPUS equal to 1. It makes
watchdog_allowed_mask not work at all.

Fixes: be45bf5395e0 ("watchdog/softlockup: Fix cpu_stop_queue_work() double-queue bug")

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Jinhui Guo <guojinhui@huawei.com>
---
 include/linux/cpumask.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 5d4d07a9e1ed..1a35dbcc397d 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -175,10 +175,11 @@ static inline int cpumask_any_distribute(const struct cpumask *srcp)
 	return cpumask_first(srcp);
 }
 
+/* It should check cpumask in some special case, such as watchdog */
 #define for_each_cpu(cpu, mask)			\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
+	for ((cpu) = 0; (cpu) < 1 && test_bit(0, cpumask_bits(mask)); (cpu)++)
 #define for_each_cpu_not(cpu, mask)		\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
+	for ((cpu) = 0; (cpu) < 1 && !test_bit(0, cpumask_bits(mask)); (cpu)++)
 #define for_each_cpu_wrap(cpu, mask, start)	\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
 #define for_each_cpu_and(cpu, mask1, mask2)	\
-- 
2.12.3

