Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638783521A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhDAVcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:32:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:11444 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233588AbhDAVcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:32:02 -0400
IronPort-SDR: SdhVsglZmLjT5y++5Qu03IW2Qq48BJQ9y21B0m8PWGxMsN+6dx9AiRwxkT9YU/J1ZMHszjMbFX
 ymsGlqkyMKrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="191815248"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="191815248"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 14:32:02 -0700
IronPort-SDR: Vhgqonq0kjSVTlM4fimvnwkKKPbFiPqGvXyiuv7jIH2tsZ6zo/NxeF3BZ69b/5CnDCbT48RECi
 N0TSu5iS0PzA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="419374627"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 14:31:59 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] platform/x86: intel_pmc_core: export platform global_reset via sysfs.
Date:   Fri,  2 Apr 2021 00:31:44 +0300
Message-Id: <20210401213144.1009224-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tamar Mashiah <tamar.mashiah@intel.com>

During PCH manufacturing a global reset has to be induced in order
for configuration changes take affect upon following platform reset.
This setting was commonly done by accessing PMC registers via /dev/mem
but due to security concern /dev/mem access is much restricted, hence
the reason for exposing this setting via dedicated sysfs interface.
To prevent post manufacturing abuse the register is protected
by hardware locking.

The register in MMIO space is defined for Cannon Lake and newer PCHs.

Cc: David E Box <david.e.box@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Tamar Mashiah <tamar.mashiah@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 .../ABI/testing/sysfs-platform-intel-pmc      | 11 +++
 MAINTAINERS                                   |  1 +
 drivers/platform/x86/intel_pmc_core.c         | 95 +++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h         |  6 ++
 4 files changed, 113 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-pmc

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-pmc b/Documentation/ABI/testing/sysfs-platform-intel-pmc
new file mode 100644
index 000000000000..7ce00e77fbcd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-intel-pmc
@@ -0,0 +1,11 @@
+What:		/sys/devices/platform/<platform>/global_reset
+Date:		Apr 2021
+KernelVersion:	5.13
+Contact:	"Tomas Winkler" <tomas.winkler@intel.com>
+Description:
+		Display global reset setting bits for PMC.
+			* bit 31 - global reset is locked
+			* bit 20 - global reset is set
+		Writing bit 20 value to the global_reset will induce
+		a platform global reset upon consequent platform reset.
+		in case the register is not locked.
diff --git a/MAINTAINERS b/MAINTAINERS
index 04f68e0cda64..618676eba8c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9166,6 +9166,7 @@ M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
 M:	David E Box <david.e.box@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
 F:	drivers/platform/x86/intel_pmc_core*
 
 INTEL PMIC GPIO DRIVERS
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index ee2f757515b0..9f252d5f7ac5 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -401,6 +401,7 @@ static const struct pmc_reg_map cnp_reg_map = {
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
 	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
+	.etr3_offset = ETR3_OFFSET,
 };
 
 static const struct pmc_reg_map icl_reg_map = {
@@ -418,6 +419,7 @@ static const struct pmc_reg_map icl_reg_map = {
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
 	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
+	.etr3_offset = ETR3_OFFSET,
 };
 
 static const struct pmc_bit_map tgl_clocksource_status_map[] = {
@@ -585,6 +587,7 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.lpm_sts = tgl_lpm_maps,
 	.lpm_status_offset = TGL_LPM_STATUS_OFFSET,
 	.lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
+	.etr3_offset = ETR3_OFFSET,
 };
 
 static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
@@ -603,6 +606,97 @@ static inline u64 pmc_core_adjust_slp_s0_step(struct pmc_dev *pmcdev, u32 value)
 	return (u64)value * pmcdev->map->slp_s0_res_counter_step;
 }
 
+static int set_global_reset(struct pmc_dev *pmcdev)
+{
+	const struct pmc_reg_map *map = pmcdev->map;
+	u32 reg;
+	int err;
+
+	mutex_lock(&pmcdev->lock);
+
+	if (!map->etr3_offset) {
+		err = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
+	/* check if CF9 is locked */
+	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
+	if (reg & ETR3_CF9LOCK) {
+		err = -EACCES;
+		goto out_unlock;
+	}
+
+	/* write CF9 global reset bit */
+	reg |= ETR3_CF9GR;
+	pmc_core_reg_write(pmcdev, map->etr3_offset, reg);
+
+	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
+	if ((reg & ETR3_CF9GR) == 0) {
+		err = -EIO;
+		goto out_unlock;
+	}
+
+	err = 0;
+
+out_unlock:
+	mutex_unlock(&pmcdev->lock);
+	return err;
+}
+
+static ssize_t global_reset_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
+	const struct pmc_reg_map *map = pmcdev->map;
+	u32 reg;
+
+	if (!map->etr3_offset)
+		return -EOPNOTSUPP;
+
+	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
+	reg &= ETR3_CF9GR | ETR3_CF9LOCK;
+
+	return sysfs_emit(buf, "0x%08x", reg);
+}
+
+static ssize_t global_reset_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
+	int err;
+	u32 reg;
+
+	err = kstrtouint(buf, 16, &reg);
+	if (err)
+		return err;
+
+	/* allow only cf9 writes */
+	if (reg != ETR3_CF9GR)
+		return -EINVAL;
+
+	err = set_global_reset(pmcdev);
+	if (err)
+		return err;
+
+	return len;
+}
+static DEVICE_ATTR_RW(global_reset);
+
+static struct attribute *pmc_attrs[] = {
+	&dev_attr_global_reset.attr,
+	NULL
+};
+
+static const struct attribute_group pmc_attr_group = {
+	.attrs = pmc_attrs,
+};
+
+static const struct attribute_group *pmc_dev_groups[] = {
+	&pmc_attr_group,
+	NULL
+};
+
 static int pmc_core_dev_state_get(void *data, u64 *val)
 {
 	struct pmc_dev *pmcdev = data;
@@ -1364,6 +1458,7 @@ static struct platform_driver pmc_core_driver = {
 		.name = "intel_pmc_core",
 		.acpi_match_table = ACPI_PTR(pmc_core_acpi_ids),
 		.pm = &pmc_core_pm_ops,
+		.dev_groups = pmc_dev_groups,
 	},
 	.probe = pmc_core_probe,
 	.remove = pmc_core_remove,
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index f33cd2c34835..98ebdfe57138 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -200,6 +200,11 @@ enum ppfear_regs {
 #define TGL_LPM_STATUS_OFFSET			0x1C3C
 #define TGL_LPM_LIVE_STATUS_OFFSET		0x1C5C
 
+/* Extended Test Mode Register 3 (CNL and later) */
+#define ETR3_OFFSET				0x1048
+#define ETR3_CF9GR				BIT(20)
+#define ETR3_CF9LOCK				BIT(31)
+
 const char *tgl_lpm_modes[] = {
 	"S0i2.0",
 	"S0i2.1",
@@ -263,6 +268,7 @@ struct pmc_reg_map {
 	const u32 lpm_residency_offset;
 	const u32 lpm_status_offset;
 	const u32 lpm_live_status_offset;
+	const u32 etr3_offset;
 };
 
 /**
-- 
2.26.3

