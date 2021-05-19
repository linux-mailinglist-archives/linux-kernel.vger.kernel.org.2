Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62E388B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbhESJxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:53:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4748 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346593AbhESJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:53:36 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlSk44PcYzpfN9;
        Wed, 19 May 2021 17:48:44 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:14 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:13 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Will Deacon" <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 2/9] drivers/perf: hisi: Remove redundant macro and functions
Date:   Wed, 19 May 2021 17:51:52 +0800
Message-ID: <1621417919-6632-3-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621417919-6632-1-git-send-email-liuqi115@huawei.com>
References: <1621417919-6632-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HISI_PMU_EVENT_ATTR and hisi_event_sysfs_show(), as we have
a general function for this.

Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 22 +++++-----
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 62 +++++++++++++--------------
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 34 +++++++--------
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |  6 +--
 drivers/perf/hisilicon/hisi_uncore_pmu.c      | 14 ------
 drivers/perf/hisilicon/hisi_uncore_pmu.h      |  2 -
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 10 ++---
 7 files changed, 67 insertions(+), 83 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 7c8a4bc..e3f4bb0 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -354,14 +354,14 @@ static const struct attribute_group hisi_ddrc_pmu_v2_format_group = {
 };
 
 static struct attribute *hisi_ddrc_pmu_v1_events_attr[] = {
-	HISI_PMU_EVENT_ATTR(flux_wr,		0x00),
-	HISI_PMU_EVENT_ATTR(flux_rd,		0x01),
-	HISI_PMU_EVENT_ATTR(flux_wcmd,		0x02),
-	HISI_PMU_EVENT_ATTR(flux_rcmd,		0x03),
-	HISI_PMU_EVENT_ATTR(pre_cmd,		0x04),
-	HISI_PMU_EVENT_ATTR(act_cmd,		0x05),
-	HISI_PMU_EVENT_ATTR(rnk_chg,		0x06),
-	HISI_PMU_EVENT_ATTR(rw_chg,		0x07),
+	PMU_EVENT_ATTR_ID(flux_wr,		0x00),
+	PMU_EVENT_ATTR_ID(flux_rd,		0x01),
+	PMU_EVENT_ATTR_ID(flux_wcmd,		0x02),
+	PMU_EVENT_ATTR_ID(flux_rcmd,		0x03),
+	PMU_EVENT_ATTR_ID(pre_cmd,		0x04),
+	PMU_EVENT_ATTR_ID(act_cmd,		0x05),
+	PMU_EVENT_ATTR_ID(rnk_chg,		0x06),
+	PMU_EVENT_ATTR_ID(rw_chg,		0x07),
 	NULL,
 };
 
@@ -371,9 +371,9 @@ static const struct attribute_group hisi_ddrc_pmu_v1_events_group = {
 };
 
 static struct attribute *hisi_ddrc_pmu_v2_events_attr[] = {
-	HISI_PMU_EVENT_ATTR(cycles,		0x00),
-	HISI_PMU_EVENT_ATTR(flux_wr,		0x83),
-	HISI_PMU_EVENT_ATTR(flux_rd,		0x84),
+	PMU_EVENT_ATTR_ID(cycles,		0x00),
+	PMU_EVENT_ATTR_ID(flux_wr,		0x83),
+	PMU_EVENT_ATTR_ID(flux_rd,		0x84),
 	NULL
 };
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 0316fab..13701b7 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -359,32 +359,32 @@ static const struct attribute_group hisi_hha_pmu_v2_format_group = {
 };
 
 static struct attribute *hisi_hha_pmu_v1_events_attr[] = {
-	HISI_PMU_EVENT_ATTR(rx_ops_num,		0x00),
-	HISI_PMU_EVENT_ATTR(rx_outer,		0x01),
-	HISI_PMU_EVENT_ATTR(rx_sccl,		0x02),
-	HISI_PMU_EVENT_ATTR(rx_ccix,		0x03),
-	HISI_PMU_EVENT_ATTR(rx_wbi,		0x04),
-	HISI_PMU_EVENT_ATTR(rx_wbip,		0x05),
-	HISI_PMU_EVENT_ATTR(rx_wtistash,	0x11),
-	HISI_PMU_EVENT_ATTR(rd_ddr_64b,		0x1c),
-	HISI_PMU_EVENT_ATTR(wr_ddr_64b,		0x1d),
-	HISI_PMU_EVENT_ATTR(rd_ddr_128b,	0x1e),
-	HISI_PMU_EVENT_ATTR(wr_ddr_128b,	0x1f),
-	HISI_PMU_EVENT_ATTR(spill_num,		0x20),
-	HISI_PMU_EVENT_ATTR(spill_success,	0x21),
-	HISI_PMU_EVENT_ATTR(bi_num,		0x23),
-	HISI_PMU_EVENT_ATTR(mediated_num,	0x32),
-	HISI_PMU_EVENT_ATTR(tx_snp_num,		0x33),
-	HISI_PMU_EVENT_ATTR(tx_snp_outer,	0x34),
-	HISI_PMU_EVENT_ATTR(tx_snp_ccix,	0x35),
-	HISI_PMU_EVENT_ATTR(rx_snprspdata,	0x38),
-	HISI_PMU_EVENT_ATTR(rx_snprsp_outer,	0x3c),
-	HISI_PMU_EVENT_ATTR(sdir-lookup,	0x40),
-	HISI_PMU_EVENT_ATTR(edir-lookup,	0x41),
-	HISI_PMU_EVENT_ATTR(sdir-hit,		0x42),
-	HISI_PMU_EVENT_ATTR(edir-hit,		0x43),
-	HISI_PMU_EVENT_ATTR(sdir-home-migrate,	0x4c),
-	HISI_PMU_EVENT_ATTR(edir-home-migrate,  0x4d),
+	PMU_EVENT_ATTR_ID(rx_ops_num,		0x00),
+	PMU_EVENT_ATTR_ID(rx_outer,		0x01),
+	PMU_EVENT_ATTR_ID(rx_sccl,		0x02),
+	PMU_EVENT_ATTR_ID(rx_ccix,		0x03),
+	PMU_EVENT_ATTR_ID(rx_wbi,		0x04),
+	PMU_EVENT_ATTR_ID(rx_wbip,		0x05),
+	PMU_EVENT_ATTR_ID(rx_wtistash,		0x11),
+	PMU_EVENT_ATTR_ID(rd_ddr_64b,		0x1c),
+	PMU_EVENT_ATTR_ID(wr_ddr_64b,		0x1d),
+	PMU_EVENT_ATTR_ID(rd_ddr_128b,		0x1e),
+	PMU_EVENT_ATTR_ID(wr_ddr_128b,		0x1f),
+	PMU_EVENT_ATTR_ID(spill_num,		0x20),
+	PMU_EVENT_ATTR_ID(spill_success,	0x21),
+	PMU_EVENT_ATTR_ID(bi_num,		0x23),
+	PMU_EVENT_ATTR_ID(mediated_num,		0x32),
+	PMU_EVENT_ATTR_ID(tx_snp_num,		0x33),
+	PMU_EVENT_ATTR_ID(tx_snp_outer,		0x34),
+	PMU_EVENT_ATTR_ID(tx_snp_ccix,		0x35),
+	PMU_EVENT_ATTR_ID(rx_snprspdata,	0x38),
+	PMU_EVENT_ATTR_ID(rx_snprsp_outer,	0x3c),
+	PMU_EVENT_ATTR_ID(sdir-lookup,		0x40),
+	PMU_EVENT_ATTR_ID(edir-lookup,		0x41),
+	PMU_EVENT_ATTR_ID(sdir-hit,		0x42),
+	PMU_EVENT_ATTR_ID(edir-hit,		0x43),
+	PMU_EVENT_ATTR_ID(sdir-home-migrate,	0x4c),
+	PMU_EVENT_ATTR_ID(edir-home-migrate,	0x4d),
 	NULL,
 };
 
@@ -394,11 +394,11 @@ static const struct attribute_group hisi_hha_pmu_v1_events_group = {
 };
 
 static struct attribute *hisi_hha_pmu_v2_events_attr[] = {
-	HISI_PMU_EVENT_ATTR(rx_ops_num,		0x00),
-	HISI_PMU_EVENT_ATTR(rx_outer,		0x01),
-	HISI_PMU_EVENT_ATTR(rx_sccl,		0x02),
-	HISI_PMU_EVENT_ATTR(hha_retry,		0x2e),
-	HISI_PMU_EVENT_ATTR(cycles,		0x55),
+	PMU_EVENT_ATTR_ID(rx_ops_num,		0x00),
+	PMU_EVENT_ATTR_ID(rx_outer,		0x01),
+	PMU_EVENT_ATTR_ID(rx_sccl,		0x02),
+	PMU_EVENT_ATTR_ID(hha_retry,		0x2e),
+	PMU_EVENT_ATTR_ID(cycles,		0x55),
 	NULL
 };
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index bf9f777..e96d1ee 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -407,19 +407,19 @@ static const struct attribute_group hisi_l3c_pmu_v2_format_group = {
 };
 
 static struct attribute *hisi_l3c_pmu_v1_events_attr[] = {
-	HISI_PMU_EVENT_ATTR(rd_cpipe,		0x00),
-	HISI_PMU_EVENT_ATTR(wr_cpipe,		0x01),
-	HISI_PMU_EVENT_ATTR(rd_hit_cpipe,	0x02),
-	HISI_PMU_EVENT_ATTR(wr_hit_cpipe,	0x03),
-	HISI_PMU_EVENT_ATTR(victim_num,		0x04),
-	HISI_PMU_EVENT_ATTR(rd_spipe,		0x20),
-	HISI_PMU_EVENT_ATTR(wr_spipe,		0x21),
-	HISI_PMU_EVENT_ATTR(rd_hit_spipe,	0x22),
-	HISI_PMU_EVENT_ATTR(wr_hit_spipe,	0x23),
-	HISI_PMU_EVENT_ATTR(back_invalid,	0x29),
-	HISI_PMU_EVENT_ATTR(retry_cpu,		0x40),
-	HISI_PMU_EVENT_ATTR(retry_ring,		0x41),
-	HISI_PMU_EVENT_ATTR(prefetch_drop,	0x42),
+	PMU_EVENT_ATTR_ID(rd_cpipe,		0x00),
+	PMU_EVENT_ATTR_ID(wr_cpipe,		0x01),
+	PMU_EVENT_ATTR_ID(rd_hit_cpipe,	0x02),
+	PMU_EVENT_ATTR_ID(wr_hit_cpipe,	0x03),
+	PMU_EVENT_ATTR_ID(victim_num,		0x04),
+	PMU_EVENT_ATTR_ID(rd_spipe,		0x20),
+	PMU_EVENT_ATTR_ID(wr_spipe,		0x21),
+	PMU_EVENT_ATTR_ID(rd_hit_spipe,	0x22),
+	PMU_EVENT_ATTR_ID(wr_hit_spipe,	0x23),
+	PMU_EVENT_ATTR_ID(back_invalid,	0x29),
+	PMU_EVENT_ATTR_ID(retry_cpu,		0x40),
+	PMU_EVENT_ATTR_ID(retry_ring,		0x41),
+	PMU_EVENT_ATTR_ID(prefetch_drop,	0x42),
 	NULL,
 };
 
@@ -429,10 +429,10 @@ static const struct attribute_group hisi_l3c_pmu_v1_events_group = {
 };
 
 static struct attribute *hisi_l3c_pmu_v2_events_attr[] = {
-	HISI_PMU_EVENT_ATTR(l3c_hit,		0x48),
-	HISI_PMU_EVENT_ATTR(cycles,		0x7f),
-	HISI_PMU_EVENT_ATTR(l3c_ref,		0xb8),
-	HISI_PMU_EVENT_ATTR(dat_access,		0xb9),
+	PMU_EVENT_ATTR_ID(l3c_hit,		0x48),
+	PMU_EVENT_ATTR_ID(cycles,		0x7f),
+	PMU_EVENT_ATTR_ID(l3c_ref,		0xb8),
+	PMU_EVENT_ATTR_ID(dat_access,		0xb9),
 	NULL
 };
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index 14f23eb..0eb68bc 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -303,9 +303,9 @@ static const struct attribute_group hisi_pa_pmu_v2_format_group = {
 };
 
 static struct attribute *hisi_pa_pmu_v2_events_attr[] = {
-	HISI_PMU_EVENT_ATTR(rx_req,		0x40),
-	HISI_PMU_EVENT_ATTR(tx_req,             0x5c),
-	HISI_PMU_EVENT_ATTR(cycle,		0x78),
+	PMU_EVENT_ATTR_ID(rx_req,		0x40),
+	PMU_EVENT_ATTR_ID(tx_req,             0x5c),
+	PMU_EVENT_ATTR_ID(cycle,		0x78),
 	NULL
 };
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 13c68b5..c0be073 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -38,20 +38,6 @@ ssize_t hisi_format_sysfs_show(struct device *dev,
 EXPORT_SYMBOL_GPL(hisi_format_sysfs_show);
 
 /*
- * PMU event attributes
- */
-ssize_t hisi_event_sysfs_show(struct device *dev,
-			      struct device_attribute *attr, char *page)
-{
-	struct dev_ext_attribute *eattr;
-
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-
-	return sysfs_emit(page, "config=0x%lx\n", (unsigned long)eattr->var);
-}
-EXPORT_SYMBOL_GPL(hisi_event_sysfs_show);
-
-/*
  * sysfs cpumask attributes. For uncore PMU, we only have a single CPU to show
  */
 ssize_t hisi_cpumask_sysfs_show(struct device *dev,
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index ea9d89b..6eb023f 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -34,8 +34,6 @@
 
 #define HISI_PMU_FORMAT_ATTR(_name, _config)		\
 	HISI_PMU_ATTR(_name, hisi_format_sysfs_show, (void *)_config)
-#define HISI_PMU_EVENT_ATTR(_name, _config)		\
-	HISI_PMU_ATTR(_name, hisi_event_sysfs_show, (unsigned long)_config)
 
 #define HISI_PMU_EVENT_ATTR_EXTRACTOR(name, config, hi, lo)        \
 	static inline u32 hisi_get_##name(struct perf_event *event)            \
diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index 46be312..31ee010 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -334,11 +334,11 @@ static const struct attribute_group hisi_sllc_pmu_v2_format_group = {
 };
 
 static struct attribute *hisi_sllc_pmu_v2_events_attr[] = {
-	HISI_PMU_EVENT_ATTR(rx_req,             0x30),
-	HISI_PMU_EVENT_ATTR(rx_data,            0x31),
-	HISI_PMU_EVENT_ATTR(tx_req,             0x34),
-	HISI_PMU_EVENT_ATTR(tx_data,            0x35),
-	HISI_PMU_EVENT_ATTR(cycles,             0x09),
+	PMU_EVENT_ATTR_ID(rx_req,             0x30),
+	PMU_EVENT_ATTR_ID(rx_data,            0x31),
+	PMU_EVENT_ATTR_ID(tx_req,             0x34),
+	PMU_EVENT_ATTR_ID(tx_data,            0x35),
+	PMU_EVENT_ATTR_ID(cycles,             0x09),
 	NULL
 };
 
-- 
2.7.4

