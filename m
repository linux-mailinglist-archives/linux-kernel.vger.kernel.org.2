Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F99444E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKDFY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:24:56 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225]:11301 "EHLO
        esa10.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhKDFYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:24:54 -0400
IronPort-SDR: Fji3GYZqc9h6c0372jSs3Dqb0Ampui6ePachyORSG0IqASTvW7xJBelF0tPzADHbPIAFnw7liD
 rpk3LgUmBjXFZlUmNBhuUT6ukvnKZfRcDBP1qNUXZp5hfAbsYm6HaBL8Xx4VjTCsNwFEV2dtZn
 oS7BAqebir3Dgk6PjwtKQphOhfXTPchIJwB4F0nMlaujcbbuMadDklu1LntaIO7tdenIKN4LX+
 Pp6y0s49Rf/dBFpy7nzEWFyGVIcTfqE1CYkmeOe4U8jDvfBUm+kFayXZxo1RouCBdbuOMVe2On
 klGnAXBko/3VVUTqe/MLey70
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="39169051"
X-IronPort-AV: E=Sophos;i="5.87,207,1631545200"; 
   d="scan'208";a="39169051"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2021 14:22:14 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C7AAD13E0A6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:13 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id EF096C9CED
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:12 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id B570E400C07D4;
        Thu,  4 Nov 2021 14:22:12 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [RFC PATCH v2 3/5] driver: hwpf: Add support for Intel to hardware prefetch driver
Date:   Thu,  4 Nov 2021 14:21:20 +0900
Message-Id: <20211104052122.553868-4-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds module init/exit code, and creates sysfs attribute files for
"enable". It works on only INTEL_FAM6_BROADWELL_X.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 drivers/hwpf/intel_hwpf.c | 219 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 drivers/hwpf/intel_hwpf.c

diff --git a/drivers/hwpf/intel_hwpf.c b/drivers/hwpf/intel_hwpf.c
new file mode 100644
index 000000000..391a58200
--- /dev/null
+++ b/drivers/hwpf/intel_hwpf.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0.
+/*
+ * Copyright 2021 FUJITSU LIMITED
+ *
+ * Intel Hardware Prefetch support
+ */
+
+#include <linux/bitfield.h>
+#include <linux/hwpf.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/intel-family.h>
+#include <asm/msr.h>
+
+enum cache_level {
+	CACHE_LEVEL_L1 = 0,
+	CACHE_LEVEL_L2,
+	CACHE_LEVEL_NOCACHE,
+};
+
+/*
+ * Classify the register specification of MSR_MISC_FEATURE_CONTROL depending on
+ * the target model.
+ *
+ * Note: This enum type is added for future extension. Currently, this driver
+ * supports only one TYPE. However, the register has several different
+ * specifications. For example, XEON_PHI series (06_57H, 06_85H) has different
+ * specification for each bits as follow:
+ * [0]    DCU Hardware Prefetcher Disable (R/W)
+ * [1]    L2 Hardware Prefetcher Disable (R/W)
+ * [63:2] Reserved
+ */
+enum register_type {
+	/*
+	 * The register specification for each bits of REGISTER_TYPE_BROADWELL
+	 * is as follow:
+	 * [0]    L2 Hardware Prefetcher Disable (R/W)
+	 * [1]    L2 Adjacent Cache Line Prefetcher Disable (R/W)
+	 * [2]    DCU Hardware Prefetcher Disable (R/W)
+	 * [3]    DCU IP Prefetcher Disable (R/W)
+	 * [63:4] Reserved
+	 */
+	REGISTER_TYPE_BROADWELL,
+	REGISTER_TYPE_NONE, /* Hardware prefetch is not supported */
+};
+
+#define TYPE_BROADWELL_L1_FIELD		GENMASK_ULL(3, 2)
+#define TYPE_BROADWELL_L2_FIELD		GENMASK_ULL(1, 0)
+
+static enum register_type hwpf_rtype;
+
+static unsigned int cache_leaves;
+
+static enum cache_level get_cache_level(unsigned int level)
+{
+	if (level >= cache_leaves)
+		return CACHE_LEVEL_NOCACHE;
+
+	return level;
+}
+
+/*
+ * Return: 0 if enabled, 1 if disabled, negative errno if an error occurs.
+ * If any bit in TYPE_XXX_FIELD is set to 1, it is considered disabled.
+ */
+static int get_enable(unsigned int cpu, unsigned int level)
+{
+	u64 reg;
+	int ret, val;
+	enum cache_level clevel;
+
+	clevel = get_cache_level(level);
+	if (clevel == CACHE_LEVEL_NOCACHE)
+		return -EINVAL;
+
+	ret = rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &reg);
+	if (ret)
+		return ret;
+
+	switch (hwpf_rtype) {
+	case REGISTER_TYPE_BROADWELL:
+		switch (clevel) {
+		case CACHE_LEVEL_L1:
+			val = FIELD_GET(TYPE_BROADWELL_L1_FIELD, reg);
+			break;
+		case CACHE_LEVEL_L2:
+			val = FIELD_GET(TYPE_BROADWELL_L2_FIELD, reg);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (val > 0)
+		return 1;
+	else if (val == 0)
+		return 0;
+	else
+		return -EINVAL;
+}
+
+static int set_enable(unsigned int cpu, unsigned int level, int val)
+{
+	int ret;
+	u64 reg;
+	enum cache_level clevel;
+
+	clevel = get_cache_level(level);
+	if (clevel == CACHE_LEVEL_NOCACHE)
+		return -EINVAL;
+
+	ret = rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &reg);
+	if (ret)
+		return ret;
+
+	switch (hwpf_rtype) {
+	case REGISTER_TYPE_BROADWELL:
+		if (val == 1)
+			val = 0x3;
+		else if (val == 0)
+			val = 0x0;
+		else
+			return -EINVAL;
+
+		switch (clevel) {
+		case CACHE_LEVEL_L1:
+			reg &= ~TYPE_BROADWELL_L1_FIELD;
+			reg |= FIELD_PREP(TYPE_BROADWELL_L1_FIELD, val);
+			break;
+		case CACHE_LEVEL_L2:
+			reg &= ~TYPE_BROADWELL_L2_FIELD;
+			reg |= FIELD_PREP(TYPE_BROADWELL_L2_FIELD, val);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ret = wrmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, reg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+
+struct hwpf_driver intel_hwpf_driver = {
+	.get_enable		= get_enable,
+	.set_enable		= set_enable,
+};
+
+enum register_type __init get_register_type(void)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return REGISTER_TYPE_NONE;
+
+	switch (boot_cpu_data.x86_model) {
+	/*
+	 * Note: In addition to BROADWELL, NEHALEM and others have same register
+	 * specifications as REGISTER_TYPE_BROADWELL. If you want to add support
+	 * for these processor, add the target model case here.
+	 */
+	case INTEL_FAM6_BROADWELL_X:
+		return REGISTER_TYPE_BROADWELL;
+	default:
+		return REGISTER_TYPE_NONE;
+	}
+}
+
+static int __init setup_hwpf_driver_params(void)
+{
+	hwpf_rtype = get_register_type();
+
+	switch (hwpf_rtype) {
+	case REGISTER_TYPE_BROADWELL:
+		cache_leaves = 2;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	intel_hwpf_driver.cache_leaves = cache_leaves;
+
+	return 0;
+}
+
+static int __init hwpf_init(void)
+{
+	int ret;
+
+	ret = setup_hwpf_driver_params();
+	if (ret < 0)
+		return ret;
+
+	ret = hwpf_register_driver(&intel_hwpf_driver);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void __exit hwpf_exit(void)
+{
+	hwpf_unregister_driver(&intel_hwpf_driver);
+}
+
+module_init(hwpf_init);
+module_exit(hwpf_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("FUJITSU LIMITED");
+MODULE_DESCRIPTION("Intel Hardware Prefetch Driver");
-- 
2.27.0

