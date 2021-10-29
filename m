Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0269F43FBEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 13:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhJ2L7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 07:59:45 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38244 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231544AbhJ2L7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:59:36 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19T9fgvm020160;
        Fri, 29 Oct 2021 04:57:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=iVT57O30vLF/xpZMya+3pypkjm091IZEG2h4OX2OztE=;
 b=QgOMgko2xlL7bz10IJnfUYY33mOC1mSKaHLyszKM/k6uZCYB+e1IAnUjs0VaErTNfINm
 iZLTY8TyVl8B774zNVIXikkrIBW2QJwKwIpas4PfLVX29X3yTubZC8HVNkmmdUjshiqx
 BXNsCP2wBWCoxU3tvYm8Qk8zN8QNDEpMEttKmzlP5pJLdNVRB3fp5RIe5Q/6Afk30fMy
 MblnAeQh0J5iu/u2e6jnicfZ8368dG9104bfpNHijb/xDS4As0wYokQNv3+FPenQOq4u
 HOehM3MV84ZXgSevTCik1rGMQ9zw6uUv1vxwjCWNP9DkfNMxVHTSKEzYlmDbtzblk9nP Ow== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3c06hujb62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 04:57:02 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 29 Oct
 2021 04:57:00 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 29 Oct 2021 04:56:57 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v6 3/4] perf/marvell: cn10k DDR perfmon event overflow handling
Date:   Fri, 29 Oct 2021 17:26:42 +0530
Message-ID: <20211029115643.32351-4-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029115643.32351-1-bbhushan2@marvell.com>
References: <20211029115643.32351-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Lc3NB7tNsGpTGSaot2sBlxtSVcjDdoK6
X-Proofpoint-ORIG-GUID: Lc3NB7tNsGpTGSaot2sBlxtSVcjDdoK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_02,2021-10-29_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CN10k DSS h/w perfmon does not support event overflow interrupt, so
periodic timer is being used. Each event counter is 48bit, which in worst
case scenario can increment at maximum 5.6 GT/s. At this rate it may take
many hours to overflow these counters. Therefore polling period for
overflow is set to 100 sec, which can be changed using sysfs parameter.

Two fixed event counters starts counting from zero on overflow, so
overflow condition is when new count less than previous count. While
eight programmable event counters freezes at maximum value. Also individual
counter cannot be restarted, so need to restart all eight counters.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v3->v6
 - No Change

v2->v3:
 - uintXX_t -> uXX

v1->v2:
 - No Change

 drivers/perf/marvell_cn10k_ddr_pmu.c | 111 +++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 9b6d5e716b94..21fccb9090c5 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -11,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/perf_event.h>
+#include <linux/hrtimer.h>
 
 /* Performance Counters Operating Mode Control Registers */
 #define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
@@ -127,6 +128,7 @@ struct cn10k_ddr_pmu {
 	struct	device *dev;
 	int active_events;
 	struct perf_event *events[DDRC_PERF_NUM_COUNTERS];
+	struct hrtimer hrtimer;
 };
 
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
@@ -251,6 +253,18 @@ static const struct attribute_group *cn10k_attr_groups[] = {
 	NULL,
 };
 
+/* Default poll timeout is 100 sec, which is very sufficient for
+ * 48 bit counter incremented max at 5.6 GT/s, which may take many
+ * hours to overflow.
+ */
+static unsigned long cn10k_ddr_pmu_poll_period_sec = 100;
+module_param_named(poll_period_sec, cn10k_ddr_pmu_poll_period_sec, ulong, 0644);
+
+static ktime_t cn10k_ddr_pmu_timer_period(void)
+{
+	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * USEC_PER_SEC);
+}
+
 static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
 {
 	switch (eventid) {
@@ -433,6 +447,10 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 	pmu->active_events++;
 	hwc->idx = counter;
 
+	if (pmu->active_events == 1)
+		hrtimer_start(&pmu->hrtimer, cn10k_ddr_pmu_timer_period(),
+			      HRTIMER_MODE_REL_PINNED);
+
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
 		/* Generic counters, configure event id */
 		reg_offset = DDRC_PERF_CFG(counter);
@@ -484,6 +502,10 @@ static void cn10k_ddr_perf_event_del(struct perf_event *event, int flags)
 	cn10k_ddr_perf_free_counter(pmu, counter);
 	pmu->active_events--;
 	hwc->idx = -1;
+
+	/* Cancel timer when no events to capture */
+	if (pmu->active_events == 0)
+		hrtimer_cancel(&pmu->hrtimer);
 }
 
 static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu)
@@ -502,6 +524,92 @@ static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
 		       DDRC_PERF_CNT_END_OP_CTRL);
 }
 
+static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
+{
+	struct hw_perf_event *hwc;
+	int i;
+
+	for (i = 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
+		if (pmu->events[i] == NULL)
+			continue;
+
+		cn10k_ddr_perf_event_update(pmu->events[i]);
+	}
+
+	/* Reset previous count as h/w counter are reset */
+	for (i = 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
+		if (pmu->events[i] == NULL)
+			continue;
+
+		hwc = &pmu->events[i]->hw;
+		local64_set(&hwc->prev_count, 0);
+	}
+}
+
+static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
+{
+	struct perf_event *event;
+	struct hw_perf_event *hwc;
+	u64 prev_count, new_count;
+	u64 value;
+	int i;
+
+	event = pmu->events[DDRC_PERF_READ_COUNTER_IDX];
+	if (event) {
+		hwc = &event->hw;
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
+
+		/* Overflow condition is when new count less than
+		 * previous count
+		 */
+		if (new_count < prev_count)
+			cn10k_ddr_perf_event_update(event);
+	}
+
+	event = pmu->events[DDRC_PERF_WRITE_COUNTER_IDX];
+	if (event) {
+		hwc = &event->hw;
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
+
+		/* Overflow condition is when new count less than
+		 * previous count
+		 */
+		if (new_count < prev_count)
+			cn10k_ddr_perf_event_update(event);
+	}
+
+	for (i = 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
+		if (pmu->events[i] == NULL)
+			continue;
+
+		value = cn10k_ddr_perf_read_counter(pmu, i);
+		if (value == DDRC_PERF_CNT_MAX_VALUE) {
+			pr_info("Counter-(%d) reached max value\n", i);
+			cn10k_ddr_perf_event_update_all(pmu);
+			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
+			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static enum hrtimer_restart cn10k_ddr_pmu_timer_handler(struct hrtimer *hrtimer)
+{
+	struct cn10k_ddr_pmu *pmu = container_of(hrtimer, struct cn10k_ddr_pmu,
+						 hrtimer);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cn10k_ddr_pmu_overflow_handler(pmu);
+	local_irq_restore(flags);
+
+	hrtimer_forward_now(hrtimer, cn10k_ddr_pmu_timer_period());
+	return HRTIMER_RESTART;
+}
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
 	struct cn10k_ddr_pmu *ddr_pmu;
@@ -550,6 +658,9 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 
+	hrtimer_init(&ddr_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ddr_pmu->hrtimer.function = cn10k_ddr_pmu_timer_handler;
+
 	ret = perf_pmu_register(&ddr_pmu->pmu, name, -1);
 	if (ret)
 		return ret;
-- 
2.17.1

