Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26AA444E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhKDFcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:32:00 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:40325 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230119AbhKDFb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:31:58 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 01:31:55 EDT
IronPort-SDR: Y5C8CloPBPL1Bx+wTdZJzgL8KtfrnpeXUgNGr50k//zzKEbp5i2MjaNnWCxtwt5+p83p3XI+S8
 0ZdbjCXFGzS21t8qDHNLnJLrKNS1qfGrvS07AFs9RifeYH4oXIpxJPTlBQ+k3CRh4HsJw10Xkz
 Vym/IRt3HU47cnUy1mUTB5tYZbPiNUKfPL327Z0+xQTCGL60SqeI7i/h1UdPZAYSAVaP68Ip7I
 929W3BLvE/Rrc+43vulg3A5LJaJOgcQ5B+MPhA/6jKboZ+azoR4wvguuQ4+Zmm1seuihQv8e1I
 TPm56wAy+ZGJ/oXb0WFtvCKk
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="51357896"
X-IronPort-AV: E=Sophos;i="5.87,207,1631545200"; 
   d="scan'208";a="51357896"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2021 14:22:12 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C735D1FB055
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:11 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id EB42ED9989
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:10 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 9DA5F400C07D4;
        Thu,  4 Nov 2021 14:22:10 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [RFC PATCH v2 2/5] driver: hwpf: Add support for A64FX to hardware prefetch driver
Date:   Thu,  4 Nov 2021 14:21:19 +0900
Message-Id: <20211104052122.553868-3-tarumizu.kohei@fujitsu.com>
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
"enable", "dist", "available_dist" and "strong".

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 drivers/hwpf/fujitsu_hwpf.c | 460 ++++++++++++++++++++++++++++++++++++
 1 file changed, 460 insertions(+)
 create mode 100644 drivers/hwpf/fujitsu_hwpf.c

diff --git a/drivers/hwpf/fujitsu_hwpf.c b/drivers/hwpf/fujitsu_hwpf.c
new file mode 100644
index 000000000..70bd53cd0
--- /dev/null
+++ b/drivers/hwpf/fujitsu_hwpf.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 FUJITSU LIMITED
+ *
+ * Fujitsu A64FX Hardware Prefetch support
+ */
+
+#include <asm/cputype.h>
+#include <linux/bitfield.h>
+#include <linux/hwpf.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#define IMP_PF_STREAM_DETECT_CTRL_EL0	sys_reg(3, 3, 11, 4, 0)
+#define HWPF_V_FIELD			BIT_ULL(63)
+#define HWPF_L1PF_DIS_FIELD		BIT_ULL(59)
+#define HWPF_L2PF_DIS_FIELD		BIT_ULL(58)
+#define HWPF_L1W_FIELD			BIT_ULL(55)
+#define HWPF_L2W_FIELD			BIT_ULL(54)
+#define HWPF_L1_DIST_FIELD		GENMASK_ULL(27, 24)
+#define HWPF_L2_DIST_FIELD		GENMASK_ULL(19, 16)
+
+enum cache_level {
+	CACHE_LEVEL_L1 = 0,
+	CACHE_LEVEL_L2,
+	CACHE_LEVEL_NOCACHE,
+};
+
+struct parse_info {
+	enum cache_level level;
+	int val;
+	int ret;
+};
+
+/* The original register value when module_init is called */
+static DEFINE_PER_CPU(u64, orig_reg_pcpu);
+#define per_cpu_orig_reg(cpu)  (per_cpu(orig_reg_pcpu, cpu))
+
+static unsigned int cache_leaves;
+
+static int min_dist_l1;
+static int min_dist_l2;
+
+static int default_v;
+
+static enum cache_level get_cache_level(unsigned int level)
+{
+	if (level >= cache_leaves)
+		return CACHE_LEVEL_NOCACHE;
+
+	return level;
+}
+
+static void _get_enable(void *info)
+{
+	u64 reg;
+	struct parse_info *pinfo = info;
+
+	pinfo->ret = -EINVAL;
+	reg = read_sysreg_s(IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	switch (pinfo->level) {
+	case CACHE_LEVEL_L1:
+		pinfo->val = FIELD_GET(HWPF_L1PF_DIS_FIELD, reg);
+		break;
+	case CACHE_LEVEL_L2:
+		pinfo->val = FIELD_GET(HWPF_L2PF_DIS_FIELD, reg);
+		break;
+	default:
+		return;
+	}
+
+	pinfo->ret = 0;
+}
+
+static void _set_enable(void *info)
+{
+	u64 reg;
+	struct parse_info *pinfo = info;
+
+	pinfo->ret = -EINVAL;
+	reg = read_sysreg_s(IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	switch (pinfo->level) {
+	case CACHE_LEVEL_L1:
+		if (!FIELD_FIT(HWPF_L1PF_DIS_FIELD, pinfo->val))
+			return;
+		reg &= ~HWPF_L1PF_DIS_FIELD;
+		reg |= FIELD_PREP(HWPF_L1PF_DIS_FIELD, pinfo->val);
+		break;
+	case CACHE_LEVEL_L2:
+		if (!FIELD_FIT(HWPF_L2PF_DIS_FIELD, pinfo->val))
+			return;
+		reg &= ~HWPF_L2PF_DIS_FIELD;
+		reg |= FIELD_PREP(HWPF_L2PF_DIS_FIELD, pinfo->val);
+		break;
+	default:
+		return;
+	}
+
+	write_sysreg_s(reg, IMP_PF_STREAM_DETECT_CTRL_EL0);
+	pinfo->ret = 0;
+}
+
+static void _get_dist(void *info)
+{
+	u64 reg;
+	struct parse_info *pinfo = info;
+
+	pinfo->ret = -EINVAL;
+	reg = read_sysreg_s(IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	switch (pinfo->level) {
+	case CACHE_LEVEL_L1:
+		pinfo->val = FIELD_GET(HWPF_L1_DIST_FIELD, reg);
+		pinfo->val = pinfo->val * min_dist_l1;
+		break;
+	case CACHE_LEVEL_L2:
+		pinfo->val = FIELD_GET(HWPF_L2_DIST_FIELD, reg);
+		pinfo->val = pinfo->val * min_dist_l2;
+		break;
+	default:
+		return;
+	}
+
+	if (pinfo->val == 0)
+		pinfo->val = DIST_AUTO_VALUE;
+
+	pinfo->ret = 0;
+}
+
+static void _set_dist(void *info)
+{
+	u64 reg;
+	struct parse_info *pinfo = info;
+
+	pinfo->ret = -EINVAL;
+	reg = read_sysreg_s(IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	if (pinfo->val == DIST_AUTO_VALUE)
+		pinfo->val = 0;
+
+	switch (pinfo->level) {
+	case CACHE_LEVEL_L1:
+		pinfo->val = roundup(pinfo->val, min_dist_l1) / min_dist_l1;
+		if (!FIELD_FIT(HWPF_L1_DIST_FIELD, pinfo->val))
+			return;
+		reg &= ~HWPF_L1_DIST_FIELD;
+		reg |= FIELD_PREP(HWPF_L1_DIST_FIELD, pinfo->val);
+		break;
+	case CACHE_LEVEL_L2:
+		pinfo->val = roundup(pinfo->val, min_dist_l2) / min_dist_l2;
+		if (!FIELD_FIT(HWPF_L2_DIST_FIELD, pinfo->val))
+			return;
+		reg &= ~HWPF_L2_DIST_FIELD;
+		reg |= FIELD_PREP(HWPF_L2_DIST_FIELD, pinfo->val);
+		break;
+	default:
+		return;
+	}
+
+	write_sysreg_s(reg, IMP_PF_STREAM_DETECT_CTRL_EL0);
+	pinfo->ret = 0;
+}
+
+static void _get_strong(void *info)
+{
+	u64 reg;
+	struct parse_info *pinfo = info;
+
+	pinfo->ret = -EINVAL;
+	reg = read_sysreg_s(IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	switch (pinfo->level) {
+	case CACHE_LEVEL_L1:
+		pinfo->val = FIELD_GET(HWPF_L1W_FIELD, reg);
+		break;
+	case CACHE_LEVEL_L2:
+		pinfo->val = FIELD_GET(HWPF_L2W_FIELD, reg);
+		break;
+	default:
+		return;
+	}
+
+	pinfo->ret = 0;
+}
+
+static void _set_strong(void *info)
+{
+	u64 reg;
+	struct parse_info *pinfo = info;
+
+	pinfo->ret = -EINVAL;
+	reg = read_sysreg_s(IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	switch (pinfo->level) {
+	case CACHE_LEVEL_L1:
+		if (!FIELD_FIT(HWPF_L1W_FIELD, pinfo->val))
+			return;
+		reg &= ~HWPF_L1W_FIELD;
+		reg |= FIELD_PREP(HWPF_L1W_FIELD, pinfo->val);
+		break;
+	case CACHE_LEVEL_L2:
+		if (!FIELD_FIT(HWPF_L2W_FIELD, pinfo->val))
+			return;
+		reg &= ~HWPF_L2W_FIELD;
+		reg |= FIELD_PREP(HWPF_L2W_FIELD, pinfo->val);
+		break;
+	default:
+		return;
+	}
+
+	write_sysreg_s(reg, IMP_PF_STREAM_DETECT_CTRL_EL0);
+	pinfo->ret = 0;
+}
+
+#define DEFINE_SMP_CALL_ATTR_FUNCTION(name)				\
+static int get_##name(unsigned int cpu, unsigned int level)		\
+{									\
+	struct parse_info info = {					\
+		.level = get_cache_level(level),			\
+	};								\
+									\
+	if (info.level == CACHE_LEVEL_NOCACHE)				\
+		return -EINVAL;						\
+									\
+	smp_call_function_single(cpu, _get_##name, &info, true);	\
+	if (info.ret < 0)						\
+		return info.ret;					\
+									\
+	return info.val;						\
+}									\
+									\
+static int set_##name(unsigned int cpu, unsigned int level, int val)	\
+{									\
+	struct parse_info info = {					\
+		.level = get_cache_level(level),			\
+		.val = val,						\
+	};								\
+									\
+	if (info.level == CACHE_LEVEL_NOCACHE)				\
+		return -EINVAL;						\
+									\
+	smp_call_function_single(cpu, _set_##name, &info, true);	\
+	if (info.ret < 0)						\
+		return info.ret;					\
+									\
+	return info.ret;						\
+}
+
+DEFINE_SMP_CALL_ATTR_FUNCTION(enable);
+DEFINE_SMP_CALL_ATTR_FUNCTION(dist);
+DEFINE_SMP_CALL_ATTR_FUNCTION(strong);
+
+/*
+ * Initialize IMP_PF_STREAM_DETECT_CTRL_EL0 v[63] field to validate
+ * the register, and save the original register value.
+ */
+static int init_hwpf_register(unsigned int cpu)
+{
+	u64 reg;
+
+	reg = read_sysreg_s(IMP_PF_STREAM_DETECT_CTRL_EL0);
+	per_cpu_orig_reg(cpu) = reg;
+
+	reg &= ~HWPF_V_FIELD;
+	reg |= FIELD_PREP(HWPF_V_FIELD, default_v);
+
+	write_sysreg_s(reg, IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	return 0;
+}
+
+static void restore_hwpf_register(unsigned int cpu)
+{
+	write_sysreg_s(per_cpu_orig_reg(cpu), IMP_PF_STREAM_DETECT_CTRL_EL0);
+}
+
+struct hwpf_driver fujitsu_hwpf_driver = {
+	.get_enable		= get_enable,
+	.get_dist		= get_dist,
+	.get_strong		= get_strong,
+	.set_enable		= set_enable,
+	.set_dist		= set_dist,
+	.set_strong		= set_strong,
+	.cpuhp_online		= init_hwpf_register,
+	.cpuhp_prepare_down	= restore_hwpf_register,
+};
+
+static unsigned int l1_dist_table[] = {
+	DIST_AUTO_VALUE,
+	256,
+	512,
+	768,
+	1024,
+	1280,
+	1536,
+	1792,
+	2048,
+	2304,
+	2560,
+	2816,
+	3072,
+	3328,
+	3584,
+	3840,
+};
+
+static unsigned int l2_dist_table[] = {
+	DIST_AUTO_VALUE,
+	1024,
+	2048,
+	3072,
+	4096,
+	5120,
+	6144,
+	7168,
+	8192,
+	9216,
+	10240,
+	11264,
+	12288,
+	13312,
+	14336,
+	15360,
+};
+
+static int __init alloc_dist_table(unsigned int level)
+{
+	struct dist_table *dist_table;
+	enum cache_level cache_level;
+
+	cache_level = get_cache_level(level);
+	if (cache_level == CACHE_LEVEL_NOCACHE)
+		return -EINVAL;
+
+	dist_table = kzalloc(sizeof(*dist_table), GFP_KERNEL);
+	if (!dist_table)
+		return -ENOMEM;
+
+	switch (cache_level) {
+	case CACHE_LEVEL_L1:
+		dist_table->table_size = ARRAY_SIZE(l1_dist_table);
+		dist_table->available_dist = l1_dist_table;
+		break;
+	case CACHE_LEVEL_L2:
+		dist_table->table_size = ARRAY_SIZE(l2_dist_table);
+		dist_table->available_dist = l2_dist_table;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dist_table->level = cache_level;
+	list_add(&dist_table->entry, &fujitsu_hwpf_driver.dist_list);
+
+	return 0;
+}
+
+static void free_dist_table(void)
+{
+	struct dist_table *table, *tmp;
+
+	list_for_each_entry_safe(table, tmp, &fujitsu_hwpf_driver.dist_list,
+				 entry) {
+		list_del(&table->entry);
+		kfree(table);
+	}
+}
+
+static int __init init_dist_table(void)
+{
+	unsigned int level;
+	int ret;
+
+	INIT_LIST_HEAD(&fujitsu_hwpf_driver.dist_list);
+
+	for (level = 0; level < cache_leaves; level++) {
+		ret = alloc_dist_table(level);
+		if (ret < 0) {
+			free_dist_table();
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int __init get_cpu_type(void)
+{
+	if (read_cpuid_implementor() != ARM_CPU_IMP_FUJITSU)
+		return -1;
+
+	return read_cpuid_part_number();
+}
+
+static int __init setup_hwpf_driver_params(void)
+{
+	int type, ret;
+
+	type = get_cpu_type();
+	if (type < 0)
+		return -ENODEV;
+
+	switch (type) {
+	case FUJITSU_CPU_PART_A64FX:
+		cache_leaves = 2;
+		min_dist_l1 = 256;
+		min_dist_l2 = 1024;
+		default_v = 1;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	fujitsu_hwpf_driver.cache_leaves = cache_leaves;
+
+	ret = init_dist_table();
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void __exit cleanup_hwpf_driver_params(void)
+{
+	free_dist_table();
+}
+
+static int __init hwpf_init(void)
+{
+	int ret;
+
+	if (!has_vhe() || !is_kernel_in_hyp_mode())
+		return -EINVAL;
+
+	ret = setup_hwpf_driver_params();
+	if (ret < 0)
+		return ret;
+
+	ret = hwpf_register_driver(&fujitsu_hwpf_driver);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void __exit hwpf_exit(void)
+{
+	hwpf_unregister_driver(&fujitsu_hwpf_driver);
+
+	cleanup_hwpf_driver_params();
+}
+
+module_init(hwpf_init);
+module_exit(hwpf_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("FUJITSU LIMITED");
+MODULE_DESCRIPTION("FUJITSU Hardware Prefetch Driver");
-- 
2.27.0

