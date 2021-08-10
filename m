Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C4D3D8381
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhG0W7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:59:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:15912 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232576AbhG0W7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:59:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212265954"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="212265954"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:59:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="634559551"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.69.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:59:09 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v13 2/4] fpga: m10bmc-sec: expose max10 flash update count
Date:   Tue, 27 Jul 2021 15:58:57 -0700
Message-Id: <20210727225859.153572-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727225859.153572-1-russell.h.weight@intel.com>
References: <20210727225859.153572-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the MAX10 BMC Secure Update driver to provide a
sysfs file to expose the flash update count for the FPGA
user image.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v13:
  - Updated ABI documentation date and kernel version
v12:
  - Updated Date and KernelVersion fields in ABI documentation
v11:
  - No change
v10:
  - Changed the path expression in the sysfs documentation to
    replace the n3000 reference with something more generic to
    accomodate other devices that use the same driver.
v9:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v8:
  - Previously patch 3/6, otherwise no change
v7:
  - Updated Date and KernelVersion in ABI documentation
v6:
  - Changed flash_count_show() parameter list to achieve
    reverse-christmas tree format.
  - Added WARN_ON() call for (FLASH_COUNT_SIZE / stride) to ensure
    that the proper count is passed to regmap_bulk_read().
v5:
  - Renamed sysfs node user_flash_count to flash_count and updated the
    sysfs documentation accordingly.
v4:
  - Moved the sysfs file for displaying the flash count from the
    FPGA Security Manager class driver to here. The
    m10bmc_user_flash_count() function is removed and the
    functionality is moved into a user_flash_count_show()
    function.
  - Added ABI documentation for the new sysfs entry
v3:
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
    driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
v2:
  - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
  - Minor code cleanup per review comments
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
---
 .../testing/sysfs-driver-intel-m10-bmc-secure |  8 ++++
 drivers/fpga/intel-m10-bmc-secure.c           | 37 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
index 363403ce992d..22dc43de1f4f 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
@@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
 		"hash not programmed".  This file is only visible if the
 		underlying device supports it.
 		Format: "0x%x".
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/flash_count
+Date:		Aug 2021
+KernelVersion:	5.15
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns number of times the secure update
+		staging area has been flashed.
+		Format: "%u".
diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 3dd53978d69f..771409b192ba 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 struct m10bmc_sec {
 	struct device *dev;
@@ -79,7 +80,43 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
 
+#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
+
+static ssize_t flash_count_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	unsigned int stride, num_bits;
+	u8 *flash_buf;
+	int cnt, ret;
+
+	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	num_bits = FLASH_COUNT_SIZE * 8;
+
+	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
+	if (!flash_buf)
+		return -ENOMEM;
+
+	WARN_ON(FLASH_COUNT_SIZE % stride);
+	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
+			       flash_buf, FLASH_COUNT_SIZE / stride);
+	if (ret) {
+		dev_err(sec->dev,
+			"failed to read flash count: %x cnt %x: %d\n",
+			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
+		goto exit_free;
+	}
+	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
+
+exit_free:
+	kfree(flash_buf);
+
+	return ret ? : sysfs_emit(buf, "%u\n", cnt);
+}
+static DEVICE_ATTR_RO(flash_count);
+
 static struct attribute *m10bmc_security_attrs[] = {
+	&dev_attr_flash_count.attr,
 	&dev_attr_bmc_root_entry_hash.attr,
 	&dev_attr_sr_root_entry_hash.attr,
 	&dev_attr_pr_root_entry_hash.attr,
-- 
2.25.1

