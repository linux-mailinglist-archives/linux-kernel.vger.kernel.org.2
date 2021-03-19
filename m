Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF6342902
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 00:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCSXCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 19:02:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9619 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhCSXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 19:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616194893; x=1647730893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WW4T5PmZJixjpQ7oYDcltpuHYHRByrMvxUXAAJYxp60=;
  b=l+wN4oFGrsa2SUaeqltv8Fq31TW0/EQ2nUVcRZilWG3nxPnanVwZI/rg
   QGNfkE7AypEGShNzKB+dCjYWNRJ6z7LyJYUbl8ODbfqEMWke5iiS2s0cG
   u7RR5VSVyabqABLSxReBkd6hgM62zmLea5DciDWrnkm32ZjGc5jOrcWNv
   RJOjhjkbWb+CKG/u8rTCd3Eme2JoXcaRnl68n4hYHW/12jfBTkFATAqaP
   q0BX8R9G6+d2u20I9286CTLLZTt3BnWEd7lRKVyqPCNMxdcinSYZ4ZDK/
   5xqRsGknXN9MwAqaQgUnhMK8ZVY3J+nH6syqDFezKX05HVgnmT9GoZTHS
   g==;
IronPort-SDR: fmbKcS2rUhfRUJwdr/7CMdKLZKOaS2YisPmqbVbKZIoaRc0F93BzKPukCGfnNSvp3O6aK7+51r
 A5gJpan16S+zBkBQEGkvZqnm1fAuWlmmfDzwqm6l2Jx5KwAUnaQd/PUfrnAbooz0SrVr/a/4FS
 cgonGxZE3HOnF7U4OQjWj/sZH6GXr+3FpDytueQZKrOxqc09EsXg+hab65U9lo0kLdswIL3lHW
 iIa/C24MlGgOBvvbPi1B0/oMpWWmKIWC+vZLsajrlFB8vpDdl/r+iuox6ApU0Y5uiyqg23+tyy
 Y8c=
X-IronPort-AV: E=Sophos;i="5.81,263,1610380800"; 
   d="scan'208";a="162584066"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2021 07:01:32 +0800
IronPort-SDR: 5zNW72sTCG0z0bhJKnLYkvznSuypIHXystsnmKr3YnOI8twVZAKNBIrz6/IazedVjy4OE2R0aV
 77tJx5pD4RngIsP8Qzt91kBAIeLKjV/9vxk6sWkKQ8x1Ljcaa3RzcnJkNSMhQBq2Rrx86Slzth
 Ijf1+Rpmm6PdNY7C+I3xWF6vbcUek2+LEt+lr++sSsGys7/yjeQEBkjjp1iZYNstigjuRgbawi
 rhrhhS2ubHWLqwpNjO7PUrtbBdxBA8HEhfkKWl8g0eI5FLC3ogiRJS8JN0gv5RKmNz4MCc8uTc
 yylLG4TTtPSNCVguprxP5bst
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 15:43:44 -0700
IronPort-SDR: Wzxg6dTWvlXDVFwHBFpFv7KYEUgDtJqCfCVCmnILYTkcJiQm/9Vf1LeMF+hJ3DjjQ8CHLwppie
 jnEEa1dDvXCdV/vX1/30mS9/uIvplw0MOKM4R+APESG4tqRg0o/hQNpHYZAAd2Sd2NI2dR3A/w
 87bF/JfGwekVw1IKBgj1dAXpT/9e2cwXtcD2AQIlZle8PAzmcIA+5BUSyI5OE2Tu8yINOh8NNC
 HHkoJ4a2gl9vGtxCC30B8yhPTBQ62DCuNUxa4Q43P8NbmQPYQ5SYcZnoP1vMwwVpWUUV3soh31
 ycY=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2021 16:01:32 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 4/6] RISC-V: Add a simple platform driver for RISC-V legacy perf
Date:   Fri, 19 Mar 2021 16:01:04 -0700
Message-Id: <20210319230106.2186694-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319230106.2186694-1-atish.patra@wdc.com>
References: <20210319230106.2186694-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old RISC-V perf implementation allowed counting of only
cycle/instruction counters using perf. Restore that feature by implementing
a simple platform driver under a separate config to provide backward
compatibility. Any existing software stack will continue to work as it is.
However, it provides an easy way out in future where we can remove the
legacy driver.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/perf/Kconfig            |  9 ++++
 drivers/perf/Makefile           |  3 ++
 drivers/perf/riscv_pmu.c        |  2 +
 drivers/perf/riscv_pmu_legacy.c | 88 +++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h  |  1 +
 5 files changed, 103 insertions(+)
 create mode 100644 drivers/perf/riscv_pmu_legacy.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index fc42ab613ea0..1546a487d970 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -64,6 +64,15 @@ config RISCV_PMU
 	  Say y if you want to use CPU performance monitors on RISCV-based
 	  systems.
 
+config RISCV_PMU_LEGACY
+	depends on RISCV_PMU
+	bool "RISC-V legacy PMU implementation"
+	default y
+	help
+	  Say y if you want to use the legacy CPU performance monitor
+	  implementation on RISC-V based systems. This only allows counting
+	  of cycle/instruction counter and will be removed in future.
+
 config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 76e5c50e24bb..e8aa666a9d28 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -11,6 +11,9 @@ obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
+ifeq ($(CONFIG_RISCV_PMU), y)
+obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
+endif
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index ce9d35069ac0..838dca2ffca8 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -350,6 +350,8 @@ static int riscv_pmu_device_probe(struct platform_device *pdev)
 	if (!pmu)
 		return -ENOMEM;
 
+	riscv_pmu_legacy_init(pmu);
+
 	cpuhp_setup_state(CPUHP_AP_PERF_RISCV_STARTING,
 			  "perf/riscv/pmu:starting",
 			  riscv_perf_starting_cpu, riscv_perf_dying_cpu);
diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
new file mode 100644
index 000000000000..d75353824f4a
--- /dev/null
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V performance counter support.
+ *
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ *
+ * This implementation is based on old RISC-V perf and ARM perf event code
+ * which are in turn based on sparc64 and x86 code.
+ */
+
+#include <linux/perf/riscv_pmu.h>
+
+#define RISCV_PMU_LEGACY_CYCLE		0
+#define RISCV_PMU_LEGACY_INSTRET	1
+#define RISCV_PMU_LEGACY_NUM_CTR	2
+
+static int pmu_legacy_get_ctr_idx(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	if (event->attr.type != PERF_TYPE_HARDWARE)
+		return -EOPNOTSUPP;
+	if (attr->config == PERF_COUNT_HW_CPU_CYCLES)
+		return RISCV_PMU_LEGACY_CYCLE;
+	else if (attr->config == PERF_COUNT_HW_INSTRUCTIONS)
+		return RISCV_PMU_LEGACY_INSTRET;
+	else
+		return -EOPNOTSUPP;
+}
+
+/* For legacy config & counter index are same */
+static int pmu_legacy_map_event(struct perf_event *event, u64 *config)
+{
+	return pmu_legacy_get_ctr_idx(event);
+}
+
+static u64 pmu_legacy_read_ctr(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	u64 val;
+
+	if (idx == RISCV_PMU_LEGACY_CYCLE) {
+		val = riscv_pmu_read_ctr_csr(CSR_CYCLE);
+		if (IS_ENABLED(CONFIG_32BIT))
+			val = (u64)riscv_pmu_read_ctr_csr(CSR_CYCLEH) << 32 | val;
+	} else if (idx == RISCV_PMU_LEGACY_INSTRET) {
+		val = riscv_pmu_read_ctr_csr(CSR_INSTRET);
+		if (IS_ENABLED(CONFIG_32BIT))
+			val = ((u64)riscv_pmu_read_ctr_csr(CSR_INSTRETH)) << 32 | val;
+	} else
+		return 0;
+
+	return val;
+}
+
+static void pmu_legacy_start_ctr(struct perf_event *event, u64 ival)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 initial_val = pmu_legacy_read_ctr(event);
+
+	/**
+	 * The legacy method doesn't really have a start/stop method.
+	 * It also can not update the counter with a initial value.
+	 * But we still need to set the prev_count so that read() can compute
+	 * the delta. Just use the current counter value to set the prev_count.
+	 */
+	local64_set(&hwc->prev_count, initial_val);
+}
+
+/**
+ * This is just a simple implementation to allow legacy implementations
+ * compatible with new RISC-V PMU driver framework.
+ * This driver only allows reading two counters i.e CYCLE & INSTRET.
+ * However, it can not start or stop the counter. Thus, it is not very useful
+ * will be removed in future.
+ */
+void riscv_pmu_legacy_init(struct riscv_pmu *pmu)
+{
+	pmu->num_counters = RISCV_PMU_LEGACY_NUM_CTR;
+	pmu->start_ctr = pmu_legacy_start_ctr;
+	pmu->stop_ctr = NULL;
+	pmu->map_event = pmu_legacy_map_event;
+	pmu->get_ctr_idx = pmu_legacy_get_ctr_idx;
+	pmu->get_ctr_width = NULL;
+	pmu->clear_ctr_idx = NULL;
+	pmu->read_ctr = pmu_legacy_read_ctr;
+}
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index be7d63d075ff..3a02b496609d 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -53,6 +53,7 @@ struct riscv_pmu {
 
 #define to_riscv_pmu(p) (container_of(p, struct riscv_pmu, pmu))
 unsigned long riscv_pmu_read_ctr_csr(unsigned long csr);
+void riscv_pmu_legacy_init(struct riscv_pmu *pmu);
 
 #endif /* CONFIG_RISCV_PMU */
 
-- 
2.25.1

