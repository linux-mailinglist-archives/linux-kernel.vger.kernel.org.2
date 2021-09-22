Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B092D41458D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhIVJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:53:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9755 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhIVJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:53:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HDtpS09vnzWMFp;
        Wed, 22 Sep 2021 17:50:56 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 17:52:05 +0800
Received: from DESKTOP-R64PNO0.china.huawei.com (10.67.102.35) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 17:52:05 +0800
From:   Jinhui Guo <guojinhui@huawei.com>
To:     <akpm@linux-foundation.org>, <pmladek@suse.com>,
        <peterz@infradead.org>, <valentin.schneider@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <guojinhui@huawei.com>
Subject: [PATCH] watchdog/softlockup: Fix softlockup_stop_all() hungtask bug
Date:   Wed, 22 Sep 2021 17:52:02 +0800
Message-ID: <20210922095202.1655-1-guojinhui@huawei.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.102.35]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600005.china.huawei.com (7.193.23.191)
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

Cc: Petr Mladek <pmladek@suse.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jinhui Guo <guojinhui@huawei.com>
---
 arch/x86/include/asm/smp.h | 5 +++++
 include/linux/cpumask.h    | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 630ff08532be..f5d3ca5696b3 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -21,7 +21,12 @@ DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
 
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
+#ifdef CONFIG_SMP
 	return per_cpu(cpu_llc_shared_map, cpu);
+#else
+	/* cpu_llc_shared_map is not defined while !CONFIG_SMP */
+	return cpu_all_mask;
+#endif
 }
 
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
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

