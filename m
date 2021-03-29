Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B42634CCB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhC2JGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:06:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15374 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbhC2Iwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:52:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F85rJ0M9Lz93Vk;
        Mon, 29 Mar 2021 16:50:24 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.192) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 16:52:17 +0800
From:   Jingyi Wang <wangjingyi11@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <maz@kernel.org>, <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <wangjingyi11@huawei.com>,
        <yuzenghui@huawei.com>, <zhukeqian1@huawei.com>
Subject: [RFC PATCH 3/3] arm/arm64: Use gic_ipi_send_single() to inject single IPI
Date:   Mon, 29 Mar 2021 16:52:10 +0800
Message-ID: <20210329085210.11524-4-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20210329085210.11524-1-wangjingyi11@huawei.com>
References: <20210329085210.11524-1-wangjingyi11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.192]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, arm use gic_ipi_send_mask() to inject single IPI, which
make the procedure a little complex. We use gic_ipi_send_single()
instead as some other archs.

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
---
 arch/arm/kernel/smp.c   | 16 +++++++++++++---
 arch/arm64/kernel/smp.c | 16 +++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 74679240a9d8..369ce529cdd8 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -534,6 +534,8 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
+static void smp_cross_call_single(const struct cpumask *target, int cpu,
+				  unsigned int ipinr);
 
 void show_ipi_list(struct seq_file *p, int prec)
 {
@@ -564,14 +566,15 @@ void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
+	smp_cross_call_single(cpumask_of(cpu), cpu, IPI_CALL_FUNC);
 }
 
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
+	int cpu = smp_processor_id();
 	if (arch_irq_work_has_interrupt())
-		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+		smp_cross_call(cpumask_of(cpu), cpu, IPI_IRQ_WORK);
 }
 #endif
 
@@ -707,6 +710,13 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
+static void smp_cross_call_single(const struct cpumask *target, int cpu,
+				  unsigned int ipinr)
+{
+	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+	__ipi_send_single(ipi_desc[ipinr], cpu);
+}
+
 static void ipi_setup(int cpu)
 {
 	int i;
@@ -744,7 +754,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 
 void smp_send_reschedule(int cpu)
 {
-	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
+	smp_cross_call_single(cpumask_of(cpu), cpu, IPI_RESCHEDULE);
 }
 
 void smp_send_stop(void)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 357590beaabb..d290b6dc5a6e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -801,6 +801,8 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
+static void smp_cross_call_single(const struct cpumask *target, int cpu,
+				  unsigned int ipinr);
 
 unsigned long irq_err_count;
 
@@ -827,7 +829,7 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
+	smp_cross_call_single(cpumask_of(cpu), cpu, IPI_CALL_FUNC);
 }
 
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
@@ -840,7 +842,8 @@ void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
-	smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+	int cpu = smp_processor_id();
+	smp_cross_call_single(cpumask_of(cpu), cpu, IPI_IRQ_WORK);
 }
 #endif
 
@@ -957,6 +960,13 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
+static void smp_cross_call_single(const struct cpumask *target, int cpu,
+				  unsigned int ipinr)
+{
+	trace_ipi_raise(target, ipi_types[ipinr]);
+	__ipi_send_single(ipi_desc[ipinr], cpu);
+}
+
 static void ipi_setup(int cpu)
 {
 	int i;
@@ -1007,7 +1017,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 
 void smp_send_reschedule(int cpu)
 {
-	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
+	smp_cross_call_single(cpumask_of(cpu), cpu, IPI_RESCHEDULE);
 }
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-- 
2.19.1

