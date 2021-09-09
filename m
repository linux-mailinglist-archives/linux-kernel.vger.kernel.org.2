Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F184046A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhIIIAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhIIIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:00:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8E9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:58:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u1-20020a25ab01000000b0059949024617so1381394ybi.17
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i+uiXYfpgsrYOnIAkX12w45jtrWt5rc7VXN0y0x67lk=;
        b=lKFtkC1hUMc/dNvJ6L4MxEL+gdcqk2pZRq6SyaUatRyJg6pWoLGc3X0zJNrury2oYT
         aTyUqhK60VPGJQw7Ckfx1ZI/NPnCTXerMaghQW95fpaT6EnKTCE2f6ERfQQjE/87lA1l
         L2vnDNxlK+y0j3Lz0Hey6AQrdSlILd2pupAzFDqeu0+WiD+fj3sPJnqfPheDWznLS9Gi
         GRXYBrkNj5aUfCboItria7NA9WIl4naUlnBjGddu5d1wVIB1jiigGWNHP0y/rJrACuMI
         ULlGL6RO1auLByUi47y4GhWtm3ZLkxbXe2UwIi4+xN1j2zUepVIpDumPXge5/E0T2P8f
         +/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i+uiXYfpgsrYOnIAkX12w45jtrWt5rc7VXN0y0x67lk=;
        b=NJBLrOSRFX3ObyS5vpRPUkOAnig2YadAOp5VSwkcSIbNkgm3QyYisl1JB9Kmm+2the
         Uvp7PJ6rUd0+Xkm2uD7EtuB3slGir3/z1nkXc9WJST7RFrrpehUz/egUnfTBMCcIzg6W
         57XOFjwpJ014RSnt4N7gfxCYzNYvZG4NZGJiwRHL7nEOe7hQ6Qhm5oJnmIiatO3W0gW9
         R85RZbm6gWVJlNg9lk0IkNjDpbqf9+TV91Yd0vt8qN01UC4UH/PROomFWc5FaXPNuORm
         CbyjifrQFmmF3KuV2MJN57wUWwrKZ0mKllrmYF2qlxTgunMsPECysGDy5unGEMNuJKcz
         fi3Q==
X-Gm-Message-State: AOAM533EkdWHqDpjUOBaeawZsa8PDlzTw5PnCx7ZUcsBw512u+JFyy9I
        +XDn1+slXQuWen9OGI076Ydxv567XK843aa1XEzjQOTvrMPfjgXS0VZvtqFN/PLT1JAMCuPkjS4
        2JNeLmRmw/4kQg3p6+5DxcOPsU9pn+IdgDRBiUi4tmCr0sIRPhsUZzkDD652jxPa4jcCP+HGJ
X-Google-Smtp-Source: ABdhPJx84YGfJdsYvVlCDMJWjePU30GvnzMbJFfDnlWmt2QiZBfEHm/ZQIRrjEQFqoo+6sJ48cOrwonlRHrA
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a25:d68e:: with SMTP id
 n136mr2292151ybg.271.1631174335303; Thu, 09 Sep 2021 00:58:55 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:54 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-8-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 07/13] perf/core: add idle hooks
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new set of hooks to connect perf_events with the
idle task. On some PMU models, it may be necessary to flush or stop
the PMU when going to low power. Upon return from low power, the opposite
action, i.e., re-enable the PMU, may be necessary. The patch adds
perf_pmu_register_lopwr_cb() to register a callback on entry or return
from low power. The callback is invoked with a boolean arg. If true,
then this is an entry. If false, this is a return.

The callback is invoked from the idle code with interrupts already
disabled.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 include/linux/perf_event.h |  8 ++++++
 kernel/events/core.c       | 58 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/idle.c        | 15 +++++++++-
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d510ad750ed..32ffc009b2ec 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -300,6 +300,7 @@ struct pmu {
 	/* number of address filters this PMU can do */
 	unsigned int			nr_addr_filters;
 
+	struct list_head		lopwr_entry;
 	/*
 	 * Fully disable/enable this PMU, can be used to protect from the PMI
 	 * as well as for lazy/batch writing of the MSRs.
@@ -430,6 +431,8 @@ struct pmu {
 	void (*sched_task)		(struct perf_event_context *ctx,
 					bool sched_in);
 
+	void (*lopwr_cb)		(bool lopwr_in);
+
 	/*
 	 * Kmem cache of PMU specific data
 	 */
@@ -1429,6 +1432,11 @@ extern void perf_event_task_tick(void);
 extern int perf_event_account_interrupt(struct perf_event *event);
 extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
+extern void perf_lopwr_cb(bool lopwr_in);
+extern void perf_lopwr_active_inc(void);
+extern void perf_lopwr_active_dec(void);
+extern void perf_register_lopwr_cb(struct pmu *pmu, void (*lowpwr_cb)(bool));
+
 #else /* !CONFIG_PERF_EVENTS: */
 static inline void *
 perf_aux_output_begin(struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1cb1f9b8392e..f739fd92e74b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3521,6 +3521,64 @@ void perf_sched_cb_inc(struct pmu *pmu)
 	this_cpu_inc(perf_sched_cb_usages);
 }
 
+/*
+ * The perf_lopwr_cb() is invoked from the idle task. As such it
+ * cannot grab a mutex that may end up sleeping. The idle task cannot
+ * sleep by construction. Therefore we create a spinlock and a new
+ * list of PMUs to invoke on idle. The list is protected by a spinlock
+ * Normally we would use the pmus_lock and iterate over each PMUs. But
+ * mutex is not possible and we need to iterate only over the PMU which
+ * do require a idle callback.
+ */
+static DEFINE_SPINLOCK(lopwr_cb_lock);
+static LIST_HEAD(lopwr_cb_pmus);
+static DEFINE_PER_CPU(int, lopwr_nr_active);
+
+void perf_lopwr_active_inc(void)
+{
+	__this_cpu_inc(lopwr_nr_active);
+}
+
+void perf_lopwr_active_dec(void)
+{
+	__this_cpu_dec(lopwr_nr_active);
+}
+
+/*
+ * lopwr_in = true means going to low power state
+ * lopwr_in = false means returning from low power state
+ */
+void perf_lopwr_cb(bool lopwr_in)
+{
+	struct pmu *pmu;
+	unsigned long flags;
+
+	if (!__this_cpu_read(lopwr_nr_active))
+		return;
+
+	spin_lock_irqsave(&lopwr_cb_lock, flags);
+
+	list_for_each_entry(pmu, &lopwr_cb_pmus, lopwr_entry) {
+		if (pmu->lopwr_cb)
+			pmu->lopwr_cb(lopwr_in);
+	}
+
+	spin_unlock_irqrestore(&lopwr_cb_lock, flags);
+}
+EXPORT_SYMBOL_GPL(perf_lopwr_cb);
+
+void perf_register_lopwr_cb(struct pmu *pmu, void (*func)(bool))
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lopwr_cb_lock, flags);
+
+	pmu->lopwr_cb   = func;
+	list_add_tail(&pmu->lopwr_entry, &lopwr_cb_pmus);
+
+	spin_unlock_irqrestore(&lopwr_cb_lock, flags);
+}
+
 /*
  * This function provides the context switch callback to the lower code
  * layer. It is invoked ONLY when the context switch callback is enabled.
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 912b47aa99d8..14ce130aee1b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -179,6 +179,7 @@ static void cpuidle_idle_call(void)
 	 */
 	if (need_resched()) {
 		local_irq_enable();
+		perf_lopwr_cb(false);
 		return;
 	}
 
@@ -191,7 +192,14 @@ static void cpuidle_idle_call(void)
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
 
+		if (!cpu_idle_force_poll)
+			perf_lopwr_cb(true);
+
 		default_idle_call();
+
+		if (!cpu_idle_force_poll)
+			perf_lopwr_cb(false);
+
 		goto exit_idle;
 	}
 
@@ -249,8 +257,10 @@ static void cpuidle_idle_call(void)
 	/*
 	 * It is up to the idle functions to reenable local interrupts
 	 */
-	if (WARN_ON_ONCE(irqs_disabled()))
+	if (WARN_ON_ONCE(irqs_disabled())) {
 		local_irq_enable();
+		perf_lopwr_cb(false);
+	}
 }
 
 /*
@@ -279,9 +289,12 @@ static void do_idle(void)
 	__current_set_polling();
 	tick_nohz_idle_enter();
 
+
 	while (!need_resched()) {
 		rmb();
 
+		perf_lopwr_cb(true);
+
 		local_irq_disable();
 
 		if (cpu_is_offline(cpu)) {
-- 
2.33.0.153.gba50c8fa24-goog

