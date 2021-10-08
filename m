Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69C54264F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhJHG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 02:59:14 -0400
Received: from m12-11.163.com ([220.181.12.11]:36042 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhJHG7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 02:59:13 -0400
X-Greylist: delayed 976 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Oct 2021 02:59:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=13Ltm
        HNKY0eCBew5yV8izaFB18GObiTDYAIbaPFtfkU=; b=nIdgUad/yvQs+LX3o4dha
        JtXUxtUhblMYyuuVljrQR0TbfIHWQj9vj52pupIaVbLVJn8P9HWCVinaITY0pHpy
        FmXCdFGZTL7hxGVchZmqzNMDfDdPo6eKaep7gzakzIU2RiS81sph6LXDT/ce6jVm
        d2jFIlEwSFO3v3i44wZfw8=
Received: from localhost.localdomain (unknown [81.71.100.192])
        by smtp7 (Coremail) with SMTP id C8CowABXS5On519h3yP90g--.13673S4;
        Fri, 08 Oct 2021 14:39:36 +0800 (CST)
From:   ultrachin@163.com
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     brookxu.cn@gmail.com, chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>
Subject: [PATCH] mm: Free per cpu pages async to shorten program exit time
Date:   Fri,  8 Oct 2021 14:39:33 +0800
Message-Id: <20211008063933.331989-1-ultrachin@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowABXS5On519h3yP90g--.13673S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWxAw13uF43XF17Gr43Awb_yoWrKF1rpa
        yvkw1Utr4kArZ7WanxJr1kZr13Kw4kWa47K3y3G3yrt3W3Kr1Fvryvyry3Zr4FgrWkuF43
        JFW3Kry7Ka1jvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4MKZUUUUU=
X-Originating-IP: [81.71.100.192]
X-CM-SenderInfo: xxow2thfkl0qqrwthudrp/1tbivwgmWFWBv6S4lQAAsr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chen xiaoguang <xiaoggchen@tencent.com>

The exit time is long when program allocated big memory and
the most time consuming part is free memory which takes 99.9%
of the total exit time. By using async free we can save 25% of
exit time.

Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
Signed-off-by: lu yihui <yihuilu@tencent.com>
---
 include/linux/mm.h |  1 +
 kernel/exit.c      |  2 ++
 mm/page_alloc.c    | 89 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 73a52aba448f..2add3b635eee 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -908,6 +908,7 @@ void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
 void copy_huge_page(struct page *dst, struct page *src);
+void kfreepcp_set_run(unsigned int cpu);
 
 /*
  * Compound pages have a destructor function.  Provide a
diff --git a/kernel/exit.c b/kernel/exit.c
index 91a43e57a32e..269eb81acbe9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -167,10 +167,12 @@ static void __exit_signal(struct task_struct *tsk)
 static void delayed_put_task_struct(struct rcu_head *rhp)
 {
 	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
+	unsigned int cpu = tsk->cpu;
 
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
 	put_task_struct(tsk);
+	kfreepcp_set_run(cpu);
 }
 
 void put_task_struct_rcu_user(struct task_struct *task)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..8a748ea9156b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -72,6 +72,7 @@
 #include <linux/padata.h>
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
+#include <linux/smpboot.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -147,6 +148,12 @@ DEFINE_PER_CPU(int, _numa_mem_);		/* Kernel "local memory" node */
 EXPORT_PER_CPU_SYMBOL(_numa_mem_);
 #endif
 
+struct freepcp_stat {
+	struct task_struct *thread;
+	bool should_run;
+};
+DEFINE_PER_CPU(struct freepcp_stat, kfreepcp);
+
 /* work_structs for global per-cpu drains */
 struct pcpu_drain {
 	struct zone *zone;
@@ -3361,6 +3368,81 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
 	return min(READ_ONCE(pcp->batch) << 2, high);
 }
 
+void kfreepcp_set_run(unsigned int cpu)
+{
+	struct task_struct *tsk;
+	struct freepcp_stat *stat = this_cpu_ptr(&kfreepcp);
+
+	tsk = stat->thread;
+	per_cpu(kfreepcp.should_run, cpu) = true;
+
+	if (tsk && !task_is_running(tsk))
+		wake_up_process(tsk);
+}
+EXPORT_SYMBOL_GPL(kfreepcp_set_run);
+
+static int kfreepcp_should_run(unsigned int cpu)
+{
+	struct freepcp_stat *stat = this_cpu_ptr(&kfreepcp);
+
+	return stat->should_run;
+}
+
+static void run_kfreepcp(unsigned int cpu)
+{
+	struct zone *zone;
+	struct per_cpu_pages *pcp;
+	unsigned long flags;
+	struct freepcp_stat *stat = this_cpu_ptr(&kfreepcp);
+	bool need_free_more = false;
+
+
+
+again:
+	need_free_more = false;
+	for_each_populated_zone(zone) {
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		if (pcp->count && pcp->high && pcp->count > pcp->high) {
+			unsigned long batch = READ_ONCE(pcp->batch);
+			int high;
+
+			high = nr_pcp_high(pcp, zone);
+			local_irq_save(flags);
+			free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch),
+					pcp);
+			local_irq_restore(flags);
+			if (pcp->count > pcp->high)
+				need_free_more = true;
+		}
+
+		cond_resched();
+	}
+	if (need_free_more)
+		goto again;
+
+	stat->should_run = false;
+}
+
+static struct smp_hotplug_thread freepcp_threads = {
+	.store                  = &kfreepcp.thread,
+	.thread_should_run      = kfreepcp_should_run,
+	.thread_fn              = run_kfreepcp,
+	.thread_comm            = "kfreepcp/%u",
+};
+
+static int __init freepcp_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(kfreepcp.should_run, cpu) = false;
+
+	BUG_ON(smpboot_register_percpu_thread(&freepcp_threads));
+
+	return 0;
+}
+late_initcall(freepcp_init);
+
 static void free_unref_page_commit(struct page *page, unsigned long pfn,
 				   int migratetype, unsigned int order)
 {
@@ -3375,11 +3457,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
 	list_add(&page->lru, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
 	high = nr_pcp_high(pcp, zone);
-	if (pcp->count >= high) {
-		int batch = READ_ONCE(pcp->batch);
-
-		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp);
-	}
+	if (pcp->count >= high)
+		this_cpu_ptr(&kfreepcp)->should_run = false;
 }
 
 /*
-- 
2.27.0

