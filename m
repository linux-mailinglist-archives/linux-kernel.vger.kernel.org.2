Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A053B9D63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhGBIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:17:15 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47961 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGBIRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:17:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=zhaoyan.liao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UeSMohb_1625213646;
Received: from localhost.localdomain.localdomain(mailfrom:zhaoyan.liao@linux.alibaba.com fp:SMTPD_---0UeSMohb_1625213646)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Jul 2021 16:14:39 +0800
From:   "zhaoyan.liao" <zhaoyan.liao@linux.alibaba.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        dwmw@amazon.co.uk
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        songmuchun@bytedance.com, likunkun@bytedance.com,
        guancheng.rjk@alibaba-inc.com,
        "zhaoyan.liao" <zhaoyan.liao@linux.alibaba.com>
Subject: [PATCH] use 64bit timer for hpet
Date:   Fri,  2 Jul 2021 16:13:45 +0800
Message-Id: <1625213625-25745-1-git-send-email-zhaoyan.liao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "zhaoyan.liao" <zhaoyan.liao@linux.alibaba.com>

The kernel judges whether the tsc clock is accurate in the
clocksource_watchdog background thread function. The hpet clock source
is 32-bit, but tsc is 64-bit. Therefore, when the system is busy and the
clocksource_watchdog cannot be scheduled in time, the hpet clock may
overflow and cause the system to misjudge tsc as unreliable.
In this case, we recommend that the kernel adopts the 64-bit hpet clock
by default to keep the width of the two clock sources the same to reduce
misjudgment. Some CPU models may not support 64-bit hpet, but according
to the description of the CPU's register manual, it does not affect our
reading action.

Signed-off-by: zhaoyan.liao <zhaoyan.liao@linux.alibaba.com>
---
 arch/x86/kernel/hpet.c | 103 ++++++++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 7a50f0b..463e8dc 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -38,7 +38,7 @@ struct hpet_base {
 	struct hpet_channel		*channels;
 };
 
-#define HPET_MASK			CLOCKSOURCE_MASK(32)
+#define HPET_MASK			CLOCKSOURCE_MASK(64)
 
 #define HPET_MIN_CYCLES			128
 #define HPET_MIN_PROG_DELTA		(HPET_MIN_CYCLES + (HPET_MIN_CYCLES >> 1))
@@ -82,6 +82,16 @@ static inline void hpet_writel(unsigned int d, unsigned int a)
 	writel(d, hpet_virt_address + a);
 }
 
+inline unsigned long hpet_readq(unsigned int a)
+{
+	return readq(hpet_virt_address + a);
+}
+
+static inline void hpet_writeq(unsigned long d, unsigned int a)
+{
+	writeq(d, hpet_virt_address + a);
+}
+
 static inline void hpet_set_mapping(void)
 {
 	hpet_virt_address = ioremap(hpet_address, HPET_MMAP_SIZE);
@@ -253,8 +263,7 @@ static void hpet_stop_counter(void)
 
 static void hpet_reset_counter(void)
 {
-	hpet_writel(0, HPET_COUNTER);
-	hpet_writel(0, HPET_COUNTER + 4);
+	hpet_writeq(0, HPET_COUNTER);
 }
 
 static void hpet_start_counter(void)
@@ -295,19 +304,20 @@ static void hpet_enable_legacy_int(void)
 static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 {
 	unsigned int channel = clockevent_to_channel(evt)->num;
-	unsigned int cfg, cmp, now;
+	unsigned int cfg;
+	unsigned long cmp, now;
 	uint64_t delta;
 
 	hpet_stop_counter();
 	delta = ((uint64_t)(NSEC_PER_SEC / HZ)) * evt->mult;
 	delta >>= evt->shift;
-	now = hpet_readl(HPET_COUNTER);
-	cmp = now + (unsigned int)delta;
+	now = hpet_readq(HPET_COUNTER);
+	cmp = now + delta;
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
-	       HPET_TN_32BIT;
+	cfg &= ~HPET_TN_32BIT;
+	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL;
 	hpet_writel(cfg, HPET_Tn_CFG(channel));
-	hpet_writel(cmp, HPET_Tn_CMP(channel));
+	hpet_writeq(cmp, HPET_Tn_CMP(channel));
 	udelay(1);
 	/*
 	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
@@ -316,7 +326,7 @@ static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
 	 * Publication # 24674)
 	 */
-	hpet_writel((unsigned int)delta, HPET_Tn_CMP(channel));
+	hpet_writeq(delta, HPET_Tn_CMP(channel));
 	hpet_start_counter();
 	hpet_print_config();
 
@@ -329,8 +339,8 @@ static int hpet_clkevt_set_state_oneshot(struct clock_event_device *evt)
 	unsigned int cfg;
 
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
-	cfg &= ~HPET_TN_PERIODIC;
-	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
+	cfg &= ~(HPET_TN_PERIODIC|HPET_TN_32BIT);
+	cfg |= HPET_TN_ENABLE;
 	hpet_writel(cfg, HPET_Tn_CFG(channel));
 
 	return 0;
@@ -342,7 +352,7 @@ static int hpet_clkevt_set_state_shutdown(struct clock_event_device *evt)
 	unsigned int cfg;
 
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
-	cfg &= ~HPET_TN_ENABLE;
+	cfg &= ~(HPET_TN_PERIODIC|HPET_TN_32BIT);
 	hpet_writel(cfg, HPET_Tn_CFG(channel));
 
 	return 0;
@@ -359,12 +369,12 @@ static int hpet_clkevt_legacy_resume(struct clock_event_device *evt)
 hpet_clkevt_set_next_event(unsigned long delta, struct clock_event_device *evt)
 {
 	unsigned int channel = clockevent_to_channel(evt)->num;
-	u32 cnt;
-	s32 res;
+	u64 cnt;
+	s64 res;
 
-	cnt = hpet_readl(HPET_COUNTER);
-	cnt += (u32) delta;
-	hpet_writel(cnt, HPET_Tn_CMP(channel));
+	cnt = hpet_readq(HPET_COUNTER);
+	cnt += (u64) delta;
+	hpet_writeq(cnt, HPET_Tn_CMP(channel));
 
 	/*
 	 * HPETs are a complete disaster. The compare register is
@@ -388,7 +398,7 @@ static int hpet_clkevt_legacy_resume(struct clock_event_device *evt)
 	 * the event. The minimum programming delta for the generic
 	 * clockevents code is set to 1.5 * HPET_MIN_CYCLES.
 	 */
-	res = (s32)(cnt - hpet_readl(HPET_COUNTER));
+	res = (s64)(cnt - hpet_readq(HPET_COUNTER));
 
 	return res < HPET_MIN_CYCLES ? -ETIME : 0;
 }
@@ -671,9 +681,10 @@ static inline void hpet_select_clockevents(void) { }
 union hpet_lock {
 	struct {
 		arch_spinlock_t lock;
-		u32 value;
+		u32 reserved;
+		u64 value;
 	};
-	u64 lockval;
+	u64 lockval1, lockval2;
 };
 
 static union hpet_lock hpet __cacheline_aligned = {
@@ -685,25 +696,28 @@ static u64 read_hpet(struct clocksource *cs)
 	unsigned long flags;
 	union hpet_lock old, new;
 
-	BUILD_BUG_ON(sizeof(union hpet_lock) != 8);
+	BUILD_BUG_ON(sizeof(union hpet_lock) != 16);
 
 	/*
 	 * Read HPET directly if in NMI.
 	 */
 	if (in_nmi())
-		return (u64)hpet_readl(HPET_COUNTER);
+		return (u64)hpet_readq(HPET_COUNTER);
 
 	/*
 	 * Read the current state of the lock and HPET value atomically.
 	 */
-	old.lockval = READ_ONCE(hpet.lockval);
+	local_irq_save(flags);
+	old.lockval1 = READ_ONCE(hpet.lockval1);
+	old.lockval2 = READ_ONCE(hpet.lockval2);
+	local_irq_restore(flags);
 
 	if (arch_spin_is_locked(&old.lock))
 		goto contended;
 
 	local_irq_save(flags);
 	if (arch_spin_trylock(&hpet.lock)) {
-		new.value = hpet_readl(HPET_COUNTER);
+		new.value = hpet_readq(HPET_COUNTER);
 		/*
 		 * Use WRITE_ONCE() to prevent store tearing.
 		 */
@@ -729,7 +743,10 @@ static u64 read_hpet(struct clocksource *cs)
 	 */
 	do {
 		cpu_relax();
-		new.lockval = READ_ONCE(hpet.lockval);
+		local_irq_save(flags);
+		new.lockval1 = READ_ONCE(hpet.lockval1);
+		new.lockval2 = READ_ONCE(hpet.lockval2);
+		local_irq_restore(flags);
 	} while ((new.value == old.value) && arch_spin_is_locked(&new.lock));
 
 	return (u64)new.value;
@@ -740,7 +757,7 @@ static u64 read_hpet(struct clocksource *cs)
  */
 static u64 read_hpet(struct clocksource *cs)
 {
-	return (u64)hpet_readl(HPET_COUNTER);
+	return hpet_readq(HPET_COUNTER);
 }
 #endif
 
@@ -787,7 +804,7 @@ static bool __init hpet_counting(void)
 
 	hpet_restart_counter();
 
-	t1 = hpet_readl(HPET_COUNTER);
+	t1 = hpet_readq(HPET_COUNTER);
 	start = rdtsc();
 
 	/*
@@ -797,7 +814,7 @@ static bool __init hpet_counting(void)
 	 * 1 GHz == 200us
 	 */
 	do {
-		if (t1 != hpet_readl(HPET_COUNTER))
+		if (t1 != hpet_readq(HPET_COUNTER))
 			return true;
 		now = rdtsc();
 	} while ((now - start) < 200000UL);
@@ -881,11 +898,11 @@ int __init hpet_enable(void)
 		irq = (cfg & Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
 		hc->irq = irq;
 
-		cfg &= ~(HPET_TN_ENABLE | HPET_TN_LEVEL | HPET_TN_FSB);
+		cfg &= ~(HPET_TN_ENABLE | HPET_TN_32BIT | HPET_TN_LEVEL | HPET_TN_FSB);
 		hpet_writel(cfg, HPET_Tn_CFG(i));
 
 		cfg &= ~(HPET_TN_PERIODIC | HPET_TN_PERIODIC_CAP
-			 | HPET_TN_64BIT_CAP | HPET_TN_32BIT | HPET_TN_ROUTE
+			 | HPET_TN_64BIT_CAP | HPET_TN_ROUTE
 			 | HPET_TN_FSB | HPET_TN_FSB_CAP);
 		if (cfg)
 			pr_warn("Channel #%u config: Unknown bits %#x\n", i, cfg);
@@ -1028,9 +1045,9 @@ void hpet_disable(void)
 static int hpet_prev_update_sec;
 static struct rtc_time hpet_alarm_time;
 static unsigned long hpet_pie_count;
-static u32 hpet_t1_cmp;
-static u32 hpet_default_delta;
-static u32 hpet_pie_delta;
+static u64 hpet_t1_cmp;
+static u64 hpet_default_delta;
+static u64 hpet_pie_delta;
 static unsigned long hpet_pie_limit;
 
 static rtc_irq_handler irq_handler;
@@ -1081,8 +1098,8 @@ void hpet_unregister_irq_handler(rtc_irq_handler handler)
  */
 int hpet_rtc_timer_init(void)
 {
-	unsigned int cfg, cnt, delta;
-	unsigned long flags;
+	unsigned int cfg;
+	unsigned long cnt, delta, flags;
 
 	if (!is_hpet_enabled())
 		return 0;
@@ -1103,13 +1120,13 @@ int hpet_rtc_timer_init(void)
 
 	local_irq_save(flags);
 
-	cnt = delta + hpet_readl(HPET_COUNTER);
-	hpet_writel(cnt, HPET_T1_CMP);
+	cnt = delta + hpet_readq(HPET_COUNTER);
+	hpet_writeq(cnt, HPET_T1_CMP);
 	hpet_t1_cmp = cnt;
 
 	cfg = hpet_readl(HPET_T1_CFG);
-	cfg &= ~HPET_TN_PERIODIC;
-	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
+	cfg &= ~(HPET_TN_PERIODIC|HPET_TN_32BIT);
+	cfg |= HPET_TN_ENABLE;
 	hpet_writel(cfg, HPET_T1_CFG);
 
 	local_irq_restore(flags);
@@ -1207,7 +1224,7 @@ int hpet_rtc_dropped_irq(void)
 
 static void hpet_rtc_timer_reinit(void)
 {
-	unsigned int delta;
+	unsigned long delta;
 	int lost_ints = -1;
 
 	if (unlikely(!hpet_rtc_flags))
@@ -1224,9 +1241,9 @@ static void hpet_rtc_timer_reinit(void)
 	 */
 	do {
 		hpet_t1_cmp += delta;
-		hpet_writel(hpet_t1_cmp, HPET_T1_CMP);
+		hpet_writeq(hpet_t1_cmp, HPET_T1_CMP);
 		lost_ints++;
-	} while (!hpet_cnt_ahead(hpet_t1_cmp, hpet_readl(HPET_COUNTER)));
+	} while (!hpet_cnt_ahead(hpet_t1_cmp, hpet_readq(HPET_COUNTER)));
 
 	if (lost_ints) {
 		if (hpet_rtc_flags & RTC_PIE)
-- 
1.8.3.1

