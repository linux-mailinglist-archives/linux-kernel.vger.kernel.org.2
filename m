Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15D744FDF6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 05:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhKOEjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 23:39:16 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:36846 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230315AbhKOEiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:38:23 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AEKxYuV018085;
        Sun, 14 Nov 2021 20:35:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=X4YHZV72m6FOnrksjUx/ENuWcRi3vDQ0qhgmEa6YCC0=;
 b=RSVUaJ8H2y6hZ3jGSj+cfAdLhaEPqj06wf80RsJoejxhpXG8B6E/V2TgiJWhtBncokhh
 XZzcdLdf6Oh339th5wIchrqOX26Hb9hBp3arJ8vwCoKo4xKO7IrAAdPzqZGsPlggkA0k
 7l21Evl01LqHHNjFyCvXSlDh5GwB4Jeu0dOSZFoBr565h7CwIuaqZZg7wZD6PpdtMaNk
 bODqhuuXekgpMxzhroDWSFru6Txi4yE6vv13mZJr6oQWbEAZ4J5qY6fh3epojlZur6Tb
 sLkOqs6G6P4eHdEgzKQzo2Apru06DLW1mSV/6bmJJFIXdHrge9Bixv1beDFiPojgIoXq gg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3cb9yq96vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 14 Nov 2021 20:35:18 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 14 Nov
 2021 20:35:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 14 Nov 2021 20:35:16 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 1EE553F7074;
        Sun, 14 Nov 2021 20:35:13 -0800 (PST)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbhushan2@marvell.com>, <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v7 1/2] drivers: perf: Add LLC-TAD perf counter support
Date:   Mon, 15 Nov 2021 10:05:05 +0530
Message-ID: <20211115043506.6679-2-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115043506.6679-1-bbudiredla@marvell.com>
References: <20211115043506.6679-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e1oAlmE2n3a0uwaN7vVfhSynp8Uy7X1b
X-Proofpoint-GUID: e1oAlmE2n3a0uwaN7vVfhSynp8Uy7X1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_03,2021-11-12_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds support for Last-level cache tag-and-data unit
(LLC-TAD) PMU that is featured in some of the Marvell's CN10K
infrastructure silicons.

The LLC is divided into 2N slices distributed across N Mesh tiles
in a single-socket configuration. The driver always configures the
same counter for all of the TADs. The user would end up effectively
reserving one of eight counters in every TAD to look across all TADs.
The occurrences of events are aggregated and presented to the user
at the end of an application run. The driver does not provide a way
for the user to partition TADs so that different TADs are used for
different applications.

The event counters are zeroed to start event counting to avoid any
rollover issues. TAD perf counters are 64-bit, so it's not currently
possible to overflow event counters at current mesh and core
frequencies.

To measure tad pmu events use perf tool stat command. For instance:

perf stat -e tad_dat_msh_in_dss,tad_req_msh_out_any <application>
perf stat -e tad_alloc_any,tad_hit_any,tad_tag_rd <application>

Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
 drivers/perf/Kconfig                 |   7 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/marvell_cn10k_tad_pmu.c | 429 +++++++++++++++++++++++++++
 3 files changed, 437 insertions(+)
 create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 77522e5efe11..53b8fa554343 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -137,6 +137,13 @@ config ARM_DMC620_PMU
 	  Support for PMU events monitoring on the ARM DMC-620 memory
 	  controller.
 
+config MARVELL_CN10K_TAD_PMU
+	tristate "Marvell CN10K LLC-TAD PMU"
+	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	help
+	  Provides support for Last-Level cache Tag-and-data Units (LLC-TAD)
+	  performance monitors on CN10K family silicons.
+
 source "drivers/perf/hisilicon/Kconfig"
 
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 5260b116c7da..2db5418d5b0a 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
 obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
+obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
new file mode 100644
index 000000000000..250dd4c52d70
--- /dev/null
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell CN10K LLC-TAD perf driver
+ *
+ * Copyright (C) 2021 Marvell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "tad_pmu: " fmt
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/cpuhotplug.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+#define TAD_PFC_OFFSET		0x0
+#define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
+#define TAD_PRF_OFFSET		0x100
+#define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
+#define TAD_PRF_CNTSEL_MASK	0xFF
+#define TAD_MAX_COUNTERS	8
+
+#define to_tad_pmu(p) (container_of(p, struct tad_pmu, pmu))
+
+struct tad_region {
+	void __iomem	*base;
+};
+
+struct tad_pmu {
+	struct pmu pmu;
+	struct tad_region *regions;
+	u32 region_cnt;
+	unsigned int cpu;
+	struct hlist_node node;
+	struct perf_event *events[TAD_MAX_COUNTERS];
+	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
+};
+
+static int tad_pmu_cpuhp_state;
+
+static void tad_pmu_event_counter_read(struct perf_event *event)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 counter_idx = hwc->idx;
+	u64 prev, new;
+	int i;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		for (i = 0, new = 0; i < tad_pmu->region_cnt; i++)
+			new += readq(tad_pmu->regions[i].base +
+				     TAD_PFC(counter_idx));
+	} while (local64_cmpxchg(&hwc->prev_count, prev, new) != prev);
+
+	local64_add(new - prev, &event->count);
+}
+
+static void tad_pmu_event_counter_stop(struct perf_event *event, int flags)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 counter_idx = hwc->idx;
+	int i;
+
+	/* TAD()_PFC() stop counting on the write
+	 * which sets TAD()_PRF()[CNTSEL] == 0
+	 */
+	for (i = 0; i < tad_pmu->region_cnt; i++) {
+		writeq_relaxed(0, tad_pmu->regions[i].base +
+			       TAD_PRF(counter_idx));
+	}
+
+	tad_pmu_event_counter_read(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 event_idx = event->attr.config;
+	u32 counter_idx = hwc->idx;
+	u64 reg_val;
+	int i;
+
+	hwc->state = 0;
+
+	/* Typically TAD_PFC() are zeroed to start counting */
+	for (i = 0; i < tad_pmu->region_cnt; i++)
+		writeq_relaxed(0, tad_pmu->regions[i].base +
+			       TAD_PFC(counter_idx));
+
+	/* TAD()_PFC() start counting on the write
+	 * which sets TAD()_PRF()[CNTSEL] != 0
+	 */
+	for (i = 0; i < tad_pmu->region_cnt; i++) {
+		reg_val = readq_relaxed(tad_pmu->regions[i].base +
+					TAD_PRF(counter_idx));
+		reg_val |= (event_idx & 0xFF);
+		writeq_relaxed(reg_val,	tad_pmu->regions[i].base +
+			       TAD_PRF(counter_idx));
+	}
+}
+
+static void tad_pmu_event_counter_del(struct perf_event *event, int flags)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	tad_pmu_event_counter_stop(event, flags | PERF_EF_UPDATE);
+	tad_pmu->events[idx] = NULL;
+	clear_bit(idx, tad_pmu->counters_map);
+}
+
+static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	/* Get a free counter for this event */
+	idx = find_first_zero_bit(tad_pmu->counters_map, TAD_MAX_COUNTERS);
+	if (idx == TAD_MAX_COUNTERS)
+		return -EAGAIN;
+
+	set_bit(idx, tad_pmu->counters_map);
+
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED;
+	tad_pmu->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		tad_pmu_event_counter_start(event, flags);
+
+	return 0;
+}
+
+static int tad_pmu_event_init(struct perf_event *event)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+
+	if (!event->attr.disabled)
+		return -EINVAL;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (event->state != PERF_EVENT_STATE_OFF)
+		return -EINVAL;
+
+	event->cpu = tad_pmu->cpu;
+	event->hw.idx = -1;
+	event->hw.config_base = event->attr.config;
+
+	return 0;
+}
+
+static ssize_t tad_pmu_event_show(struct device *dev,
+				struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define TAD_PMU_EVENT_ATTR(name, config)			\
+	PMU_EVENT_ATTR_ID(name, tad_pmu_event_show, config)
+
+static struct attribute *tad_pmu_event_attrs[] = {
+	TAD_PMU_EVENT_ATTR(tad_none, 0x0),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_in_any, 0x1),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_in_mn, 0x2),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_in_exlmn, 0x3),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_any, 0x4),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_mn, 0x5),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_exlmn, 0x6),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_dss, 0x7),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_retry_dss, 0x8),
+	TAD_PMU_EVENT_ATTR(tad_dat_msh_in_any, 0x9),
+	TAD_PMU_EVENT_ATTR(tad_dat_msh_in_dss, 0xa),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_any, 0xb),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_rd, 0xc),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_wr, 0xd),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_evict, 0xe),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_any, 0xf),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_retry_exlmn, 0x10),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_retry_mn, 0x11),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_exlmn, 0x12),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_mn, 0x13),
+	TAD_PMU_EVENT_ATTR(tad_snp_msh_out_any, 0x14),
+	TAD_PMU_EVENT_ATTR(tad_snp_msh_out_mn, 0x15),
+	TAD_PMU_EVENT_ATTR(tad_snp_msh_out_exlmn, 0x16),
+	TAD_PMU_EVENT_ATTR(tad_dat_msh_out_any, 0x17),
+	TAD_PMU_EVENT_ATTR(tad_dat_msh_out_fill, 0x18),
+	TAD_PMU_EVENT_ATTR(tad_dat_msh_out_dss, 0x19),
+	TAD_PMU_EVENT_ATTR(tad_alloc_dtg, 0x1a),
+	TAD_PMU_EVENT_ATTR(tad_alloc_ltg, 0x1b),
+	TAD_PMU_EVENT_ATTR(tad_alloc_any, 0x1c),
+	TAD_PMU_EVENT_ATTR(tad_hit_dtg, 0x1d),
+	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
+	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
+	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
+	TAD_PMU_EVENT_ATTR(tad_dat_rd, 0x21),
+	TAD_PMU_EVENT_ATTR(tad_dat_rd_byp, 0x22),
+	TAD_PMU_EVENT_ATTR(tad_ifb_occ, 0x23),
+	TAD_PMU_EVENT_ATTR(tad_req_occ, 0x24),
+	NULL
+};
+
+static const struct attribute_group tad_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = tad_pmu_event_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+
+static struct attribute *tad_pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL
+};
+
+static struct attribute_group tad_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = tad_pmu_format_attrs,
+};
+
+static ssize_t tad_pmu_cpumask_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tad_pmu->cpu));
+}
+
+static DEVICE_ATTR(cpumask, 0444, tad_pmu_cpumask_show, NULL);
+
+static struct attribute *tad_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static struct attribute_group tad_pmu_cpumask_attr_group = {
+	.attrs = tad_pmu_cpumask_attrs,
+};
+
+static const struct attribute_group *tad_pmu_attr_groups[] = {
+	&tad_pmu_events_attr_group,
+	&tad_pmu_format_attr_group,
+	&tad_pmu_cpumask_attr_group,
+	NULL
+};
+
+static int tad_pmu_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct tad_region *regions;
+	struct tad_pmu *tad_pmu;
+	struct resource *res;
+	u32 tad_pmu_page_size;
+	u32 tad_page_size;
+	u32 tad_cnt;
+	int i, ret;
+	char *name;
+
+	tad_pmu = devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
+	if (!tad_pmu)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, tad_pmu);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Mem resource not found\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(node, "marvell,tad-page-size",
+				   &tad_page_size);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "marvell,tad-pmu-page-size",
+				   &tad_pmu_page_size);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't find tad-pmu-page-size property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "marvell,tad-cnt", &tad_cnt);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't find tad-cnt property\n");
+		return ret;
+	}
+
+	regions = devm_kcalloc(&pdev->dev, tad_cnt,
+			       sizeof(*regions), GFP_KERNEL);
+	if (!regions)
+		return -ENOMEM;
+
+	/* ioremap the distributed TAD pmu regions */
+	for (i = 0; i < tad_cnt && res->start < res->end; i++) {
+		regions[i].base = devm_ioremap(&pdev->dev,
+					       res->start,
+					       tad_pmu_page_size);
+		if (IS_ERR(regions[i].base)) {
+			dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
+			return -ENOMEM;
+		}
+		res->start += tad_page_size;
+	}
+
+	tad_pmu->regions = regions;
+	tad_pmu->region_cnt = tad_cnt;
+
+	tad_pmu->pmu = (struct pmu) {
+
+		.module		= THIS_MODULE,
+		.attr_groups	= tad_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_INTERRUPT,
+		.task_ctx_nr	= perf_invalid_context,
+
+		.event_init	= tad_pmu_event_init,
+		.add		= tad_pmu_event_counter_add,
+		.del		= tad_pmu_event_counter_del,
+		.start		= tad_pmu_event_counter_start,
+		.stop		= tad_pmu_event_counter_stop,
+		.read		= tad_pmu_event_counter_read,
+	};
+
+	tad_pmu->cpu = raw_smp_processor_id();
+
+	/* Register pmu instance for cpu hotplug */
+	ret = cpuhp_state_add_instance_nocalls(tad_pmu_cpuhp_state,
+					       &tad_pmu->node);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
+		return ret;
+	}
+
+	name = "tad";
+	ret = perf_pmu_register(&tad_pmu->pmu, name, -1);
+	if (ret)
+		cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
+						    &tad_pmu->node);
+
+	return ret;
+}
+
+static int tad_pmu_remove(struct platform_device *pdev)
+{
+	struct tad_pmu *pmu = platform_get_drvdata(pdev);
+
+	cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
+						&pmu->node);
+	perf_pmu_unregister(&pmu->pmu);
+
+	return 0;
+}
+
+static const struct of_device_id tad_pmu_of_match[] = {
+	{ .compatible = "marvell,cn10k-tad-pmu", },
+	{},
+};
+
+static struct platform_driver tad_pmu_driver = {
+	.driver         = {
+		.name   = "cn10k_tad_pmu",
+		.of_match_table = of_match_ptr(tad_pmu_of_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe          = tad_pmu_probe,
+	.remove         = tad_pmu_remove,
+};
+
+static int tad_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct tad_pmu *pmu = hlist_entry_safe(node, struct tad_pmu, node);
+	unsigned int target;
+
+	if (cpu != pmu->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+	pmu->cpu = target;
+
+	return 0;
+}
+
+static int __init tad_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/cn10k/tadpmu:online",
+				      NULL,
+				      tad_pmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+	tad_pmu_cpuhp_state = ret;
+	return platform_driver_register(&tad_pmu_driver);
+}
+
+static void __exit tad_pmu_exit(void)
+{
+	platform_driver_unregister(&tad_pmu_driver);
+	cpuhp_remove_multi_state(tad_pmu_cpuhp_state);
+}
+
+module_init(tad_pmu_init);
+module_exit(tad_pmu_exit);
+
+MODULE_DESCRIPTION("Marvell CN10K LLC-TAD Perf driver");
+MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

