Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F69389BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhETDSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:18:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:58847 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhETDS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:18:28 -0400
IronPort-SDR: gp/ClnhbFk2QKuQLa7wphAcN4yNzYMuMNs6Y3hBm7+a29ys+BQFUvNz6CsUYEkjPASk2h1xc1s
 8TL4ptNOuIvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659655"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286659655"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 20:17:05 -0700
IronPort-SDR: BVBfQE3jansdoCpm/7agY8g5c+X340B4G8QDJ9ODQItCF+b9Za3foqRUJ4w09tUB39b1kKeVLE
 o2Kt070fsU/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395527299"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:17:03 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 09/11] iommu/vt-d: Expose latency monitor data through debugfs
Date:   Thu, 20 May 2021 11:15:29 +0800
Message-Id: <20210520031531.712333-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A debugfs interface /sys/kernel/debug/iommu/intel/dmar_perf_latency is
created to control and show counts of execution time ranges for various
types per DMAR. The interface may help debug any potential performance
issue.

By default, the interface is disabled.

Possible write value of /sys/kernel/debug/iommu/intel/dmar_perf_latency
  0 - disable sampling all latency data
  1 - enable sampling IOTLB invalidation latency data
  2 - enable sampling devTLB invalidation latency data
  3 - enable sampling intr entry cache invalidation latency data
  4 - enable sampling prq handling latency data

Read /sys/kernel/debug/iommu/intel/dmar_perf_latency gives a snapshot
of sampling result of all enabled monitors.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c | 111 ++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/Kconfig   |   1 +
 2 files changed, 112 insertions(+)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index efea7f02abd9..62e23ff3c987 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -16,6 +16,7 @@
 #include <asm/irq_remapping.h>
 
 #include "pasid.h"
+#include "perf.h"
 
 struct tbl_walk {
 	u16 bus;
@@ -31,6 +32,9 @@ struct iommu_regset {
 	const char *regs;
 };
 
+#define DEBUG_BUFFER_SIZE	1024
+static char debug_buf[DEBUG_BUFFER_SIZE];
+
 #define IOMMU_REGSET_ENTRY(_reg_)					\
 	{ DMAR_##_reg_##_REG, __stringify(_reg_) }
 
@@ -538,6 +542,111 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
 DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
 #endif
 
+static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
+			     struct dmar_drhd_unit *drhd)
+{
+	int ret;
+
+	seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
+		   iommu->name, drhd->reg_base_addr);
+
+	ret = dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
+	if (ret < 0)
+		seq_puts(m, "Failed to get latency snapshot");
+	else
+		seq_puts(m, debug_buf);
+	seq_puts(m, "\n");
+}
+
+static int latency_show(struct seq_file *m, void *v)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd)
+		latency_show_one(m, iommu, drhd);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int dmar_perf_latency_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, latency_show, NULL);
+}
+
+static ssize_t dmar_perf_latency_write(struct file *filp,
+				       const char __user *ubuf,
+				       size_t cnt, loff_t *ppos)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	int counting;
+	char buf[64];
+
+	if (cnt > 63)
+		cnt = 63;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+
+	if (kstrtoint(buf, 0, &counting))
+		return -EINVAL;
+
+	switch (counting) {
+	case 0:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd) {
+			dmar_latency_disable(iommu, DMAR_LATENCY_INV_IOTLB);
+			dmar_latency_disable(iommu, DMAR_LATENCY_INV_DEVTLB);
+			dmar_latency_disable(iommu, DMAR_LATENCY_INV_IEC);
+			dmar_latency_disable(iommu, DMAR_LATENCY_PRQ);
+		}
+		rcu_read_unlock();
+		break;
+	case 1:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd)
+			dmar_latency_enable(iommu, DMAR_LATENCY_INV_IOTLB);
+		rcu_read_unlock();
+		break;
+	case 2:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd)
+			dmar_latency_enable(iommu, DMAR_LATENCY_INV_DEVTLB);
+		rcu_read_unlock();
+		break;
+	case 3:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd)
+			dmar_latency_enable(iommu, DMAR_LATENCY_INV_IEC);
+		rcu_read_unlock();
+		break;
+	case 4:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd)
+			dmar_latency_enable(iommu, DMAR_LATENCY_PRQ);
+		rcu_read_unlock();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static const struct file_operations dmar_perf_latency_fops = {
+	.open		= dmar_perf_latency_open,
+	.write		= dmar_perf_latency_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 void __init intel_iommu_debugfs_init(void)
 {
 	struct dentry *intel_iommu_debug = debugfs_create_dir("intel",
@@ -556,4 +665,6 @@ void __init intel_iommu_debugfs_init(void)
 	debugfs_create_file("ir_translation_struct", 0444, intel_iommu_debug,
 			    NULL, &ir_translation_struct_fops);
 #endif
+	debugfs_create_file("dmar_perf_latency", 0644, intel_iommu_debug,
+			    NULL, &dmar_perf_latency_fops);
 }
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 59be5447b775..43ebd8af11c5 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -28,6 +28,7 @@ config INTEL_IOMMU
 config INTEL_IOMMU_DEBUGFS
 	bool "Export Intel IOMMU internals in Debugfs"
 	depends on INTEL_IOMMU && IOMMU_DEBUGFS
+	select DMAR_PERF
 	help
 	  !!!WARNING!!!
 
-- 
2.25.1

