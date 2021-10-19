Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EE1433C55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhJSQfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:35:52 -0400
Received: from foss.arm.com ([217.140.110.172]:51652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234503AbhJSQfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:35:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2508011FB;
        Tue, 19 Oct 2021 09:33:26 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACA483F694;
        Tue, 19 Oct 2021 09:33:24 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 08/15] coresight: trbe: Allow driver to choose a different alignment
Date:   Tue, 19 Oct 2021 17:31:46 +0100
Message-Id: <20211019163153.3692640-9-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211019163153.3692640-1-suzuki.poulose@arm.com>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TRBE hardware mandates a minimum alignment for the TRBPTR_EL1,
advertised via the TRBIDR_EL1. This is used by the driver to
align the buffer write head. This patch allows the driver to
choose a different alignment from that of the hardware, by
decoupling the alignment tracking. This will be useful for
working around errata.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index ae0bde9630f6..cdbb134892f6 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -67,8 +67,18 @@ struct trbe_buf {
 	struct trbe_cpudata *cpudata;
 };
 
+/*
+ * struct trbe_cpudata: TRBE instance specific data
+ * @trbe_flag		- TRBE dirty/access flag support
+ * @trbe_hw_align	- Actual TRBE alignment required for TRBPTR_EL1.
+ * @trbe_align		- Software alignment used for the TRBPTR_EL1.
+ * @cpu			- CPU this TRBE belongs to.
+ * @mode		- Mode of current operation. (perf/disabled)
+ * @drvdata		- TRBE specific drvdata
+ */
 struct trbe_cpudata {
 	bool trbe_flag;
+	u64 trbe_hw_align;
 	u64 trbe_align;
 	int cpu;
 	enum cs_mode mode;
@@ -875,7 +885,7 @@ static ssize_t align_show(struct device *dev, struct device_attribute *attr, cha
 {
 	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%llx\n", cpudata->trbe_align);
+	return sprintf(buf, "%llx\n", cpudata->trbe_hw_align);
 }
 static DEVICE_ATTR_RO(align);
 
@@ -967,11 +977,13 @@ static void arm_trbe_probe_cpu(void *info)
 		goto cpu_clear;
 	}
 
-	cpudata->trbe_align = 1ULL << get_trbe_address_align(trbidr);
-	if (cpudata->trbe_align > SZ_2K) {
+	cpudata->trbe_hw_align = 1ULL << get_trbe_address_align(trbidr);
+	if (cpudata->trbe_hw_align > SZ_2K) {
 		pr_err("Unsupported alignment on cpu %d\n", cpu);
 		goto cpu_clear;
 	}
+
+	cpudata->trbe_align = cpudata->trbe_hw_align;
 	cpudata->trbe_flag = get_trbe_flag_update(trbidr);
 	cpudata->cpu = cpu;
 	cpudata->drvdata = drvdata;
-- 
2.25.4

