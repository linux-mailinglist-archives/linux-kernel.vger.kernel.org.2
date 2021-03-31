Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBA334F99C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhCaHPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:15:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:65017 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233892AbhCaHO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:14:56 -0400
IronPort-SDR: KS0xBOFzH+pr6CZc7oCqFlYal7O9PXQSdXBmG8YoeD2lAsbOTydxfEaV34NR77ri+kv59T7Tqa
 TVGpU2h4D9Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="253270282"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="253270282"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 00:14:52 -0700
IronPort-SDR: gdJLmvmkHe87YVYUpkYSQ4mVAWC3BXIynJWFAbF1fxQMGr6uNS0Ond/QCvITOwNp6LweeHfUnr
 3kbKKuIDFYcw==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="418534086"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 00:14:49 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tamar Mashiah <tamar.mashiah@intel.com>,
        Joe Perches <joe@perches.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v2] mtd: intel-spi: add is_protected and is_bios_locked knobs
Date:   Wed, 31 Mar 2021 10:14:39 +0300
Message-Id: <20210331071439.83103-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tamar Mashiah <tamar.mashiah@intel.com>

The manufacturing access to the PCH/SOC SPI device is traditionally
performed via user space driver accessing registers via /dev/mem
but due to security concerns /dev/mem access is being much restricted,
hence the reason for utilizing dedicated Intel PCH/SOC SPI controller
driver, which is already implemented in the Linux kernel.

Intel PCH/SOC SPI controller protects the flash storage via two
mechanisms one is the via region protection registers and second
via BIOS lock.

The device always boots with bios lock set, but during manufacturing
the bios lock has to be lifted in order to enable the write access.
So we add sysfs file (spi_bios_lock) to be able to do it on demand.
The bios lock is automatically attempted to be lifted by the driver
during initialization, this part is dropped.

Second, also the region protection status is exposed via sysfs file
as the manufacturing will need the both files in order to validate
that the device is properly sealed.

Cc: Joe Perches <joe@perches.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Tamar Mashiah <tamar.mashiah@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
V2: Add a newline to the string format in sysfs_emit() (Joe Perches <joe@perches.com>)

 .../ABI/testing/sysfs-devices-intel-spi       | 16 ++++
 MAINTAINERS                                   |  1 +
 drivers/mfd/lpc_ich.c                         | 37 ++++++-
 .../mtd/spi-nor/controllers/intel-spi-pci.c   | 38 ++++++--
 drivers/mtd/spi-nor/controllers/intel-spi.c   | 96 ++++++++++++++++---
 include/linux/platform_data/x86/intel-spi.h   |  6 +-
 6 files changed, 167 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-intel-spi

diff --git a/Documentation/ABI/testing/sysfs-devices-intel-spi b/Documentation/ABI/testing/sysfs-devices-intel-spi
new file mode 100644
index 000000000000..515c36f8b5cf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-intel-spi
@@ -0,0 +1,16 @@
+What:		/sys/devices/.../is_protected
+Date:		April 2021
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:
+		The /sys/devices/.../is_protected attribute allows the user
+		space to check if the intel spi controller is write protected
+		from the host.
+
+What:		/sys/devices/.../bios_lock
+Date:		April 2021
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:
+		The /sys/devices/.../bios_lock attribute allows the user
+		space to check if the intel spi controller is locked by bios
+		for writes. It is possible to unlock the bios lock by writing
+		"unlock" to the file.
diff --git a/MAINTAINERS b/MAINTAINERS
index ba561e5bc6f0..37c934f34ed7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11571,6 +11571,7 @@ Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
+F:	Documentation/ABI/testing/sysfs-devices-intel-spi
 F:	Documentation/devicetree/bindings/mtd/
 F:	drivers/mtd/
 F:	include/linux/mtd/
diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 3bbb29a7e7a5..eceaf11bec93 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -1083,12 +1083,39 @@ static int lpc_ich_init_wdt(struct pci_dev *dev)
 	return ret;
 }
 
+static int lcp_ich_bios_unlock(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u32 bcr = 0;
+
+	pci_read_config_dword(pdev, BCR, &bcr);
+	if (!(bcr & BCR_WPD)) {
+		bcr |= BCR_WPD;
+		pci_write_config_dword(pdev, BCR, bcr);
+		pci_read_config_dword(pdev, BCR, &bcr);
+	}
+
+	if (!(bcr & BCR_WPD))
+		return -EIO;
+
+	return 0;
+}
+
+static bool lcp_ich_is_bios_locked(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u32 bcr = 0;
+
+	pci_read_config_dword(pdev, BCR, &bcr);
+	return !(bcr & BCR_WPD);
+}
+
 static int lpc_ich_init_spi(struct pci_dev *dev)
 {
 	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
 	struct resource *res = &intel_spi_res[0];
 	struct intel_spi_boardinfo *info;
-	u32 spi_base, rcba, bcr;
+	u32 spi_base, rcba;
 
 	info = devm_kzalloc(&dev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -1112,8 +1139,8 @@ static int lpc_ich_init_spi(struct pci_dev *dev)
 			res->start = spi_base + SPIBASE_LPT;
 			res->end = res->start + SPIBASE_LPT_SZ - 1;
 
-			pci_read_config_dword(dev, BCR, &bcr);
-			info->writeable = !!(bcr & BCR_WPD);
+			info->is_bios_locked = lcp_ich_is_bios_locked;
+			info->bios_unlock = lcp_ich_bios_unlock;
 		}
 		break;
 
@@ -1134,8 +1161,8 @@ static int lpc_ich_init_spi(struct pci_dev *dev)
 			res->start = spi_base & 0xfffffff0;
 			res->end = res->start + SPIBASE_APL_SZ - 1;
 
-			pci_bus_read_config_dword(bus, spi, BCR, &bcr);
-			info->writeable = !!(bcr & BCR_WPD);
+			info->is_bios_locked = lcp_ich_is_bios_locked;
+			info->bios_unlock = lcp_ich_bios_unlock;
 		}
 
 		pci_bus_write_config_byte(bus, p2sb, 0xe1, 0x1);
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index 825610a2e9dc..f83f352f874d 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -24,12 +24,38 @@ static const struct intel_spi_boardinfo cnl_info = {
 	.type = INTEL_SPI_CNL,
 };
 
+static int intel_spi_pci_bios_unlock(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u32 bcr = 0;
+
+	pci_read_config_dword(pdev, BCR, &bcr);
+	if (!(bcr & BCR_WPD)) {
+		bcr |= BCR_WPD;
+		pci_write_config_dword(pdev, BCR, bcr);
+		pci_read_config_dword(pdev, BCR, &bcr);
+	}
+
+	if (!(bcr & BCR_WPD))
+		return -EIO;
+
+	return 0;
+}
+
+static bool intel_spi_pci_is_bios_locked(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u32 bcr = 0;
+
+	pci_read_config_dword(pdev, BCR, &bcr);
+	return !(bcr & BCR_WPD);
+}
+
 static int intel_spi_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	struct intel_spi_boardinfo *info;
 	struct intel_spi *ispi;
-	u32 bcr;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -41,14 +67,8 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	/* Try to make the chip read/write */
-	pci_read_config_dword(pdev, BCR, &bcr);
-	if (!(bcr & BCR_WPD)) {
-		bcr |= BCR_WPD;
-		pci_write_config_dword(pdev, BCR, bcr);
-		pci_read_config_dword(pdev, BCR, &bcr);
-	}
-	info->writeable = !!(bcr & BCR_WPD);
+	info->is_bios_locked = intel_spi_pci_is_bios_locked;
+	info->bios_unlock = intel_spi_pci_bios_unlock;
 
 	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
 	if (IS_ERR(ispi))
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index a413892ff449..bbe0639de702 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -131,7 +131,8 @@
  * @sregs: Start of software sequencer registers
  * @nregions: Maximum number of regions
  * @pr_num: Maximum number of protected range registers
- * @writeable: Is the chip writeable
+ * @is_protected: Whether the regions are write protected
+ * @is_bios_locked: Whether the spi is locked by BIOS
  * @locked: Is SPI setting locked
  * @swseq_reg: Use SW sequencer in register reads/writes
  * @swseq_erase: Use SW sequencer in erase operation
@@ -149,7 +150,8 @@ struct intel_spi {
 	void __iomem *sregs;
 	size_t nregions;
 	size_t pr_num;
-	bool writeable;
+	bool is_protected;
+	bool is_bios_locked;
 	bool locked;
 	bool swseq_reg;
 	bool swseq_erase;
@@ -326,7 +328,7 @@ static int intel_spi_init(struct intel_spi *ispi)
 				val = readl(ispi->base + BYT_BCR);
 			}
 
-			ispi->writeable = !!(val & BYT_BCR_WPD);
+			ispi->is_bios_locked = !(val & BYT_BCR_WPD);
 		}
 
 		break;
@@ -862,6 +864,7 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 	int i;
 
 	memset(part, 0, sizeof(*part));
+	ispi->is_protected = false;
 
 	/* Start from the mandatory descriptor region */
 	part->size = 4096;
@@ -886,7 +889,7 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 		 * whole partition read-only to be on the safe side.
 		 */
 		if (intel_spi_is_protected(ispi, base, limit))
-			ispi->writeable = false;
+			ispi->is_protected = true;
 
 		end = (limit << 12) + 4096;
 		if (end > part->size)
@@ -894,6 +897,60 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 	}
 }
 
+static ssize_t intel_spi_is_protected_show(struct device *dev,
+					   struct device_attribute *attr, char *buf)
+{
+	struct intel_spi *ispi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", ispi->is_protected);
+}
+static DEVICE_ATTR_ADMIN_RO(intel_spi_is_protected);
+
+static ssize_t intel_spi_bios_lock_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	struct intel_spi *ispi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", ispi->is_bios_locked);
+}
+
+static ssize_t intel_spi_bios_lock_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct intel_spi *ispi = dev_get_drvdata(dev);
+	struct mtd_info *child, *master = mtd_get_master(&ispi->nor.mtd);
+	int err;
+
+	if (!ispi->info->is_bios_locked)
+		return -EOPNOTSUPP;
+
+	if (strcmp(buf, "unlock") != 0)
+		return -EINVAL;
+
+	if (ispi->info->is_bios_locked(dev)) {
+		err = ispi->info->bios_unlock(dev);
+		if (err)
+			return err;
+	}
+
+	ispi->is_bios_locked = false;
+
+	if (ispi->is_protected || !writeable)
+		return -EPERM;
+
+	/* Device is now writable */
+	ispi->nor.mtd.flags |= MTD_WRITEABLE;
+
+	mutex_lock(&master->master.partitions_lock);
+	list_for_each_entry(child, &ispi->nor.mtd.partitions, part.node)
+		child->flags |= MTD_WRITEABLE;
+	mutex_unlock(&master->master.partitions_lock);
+
+	return len;
+}
+static DEVICE_ATTR_ADMIN_RW(intel_spi_bios_lock);
+
 static const struct spi_nor_controller_ops intel_spi_controller_ops = {
 	.read_reg = intel_spi_read_reg,
 	.write_reg = intel_spi_write_reg,
@@ -902,6 +959,15 @@ static const struct spi_nor_controller_ops intel_spi_controller_ops = {
 	.erase = intel_spi_erase,
 };
 
+int intel_spi_remove(struct intel_spi *ispi)
+{
+	device_remove_file(ispi->dev, &dev_attr_intel_spi_is_protected);
+	device_remove_file(ispi->dev, &dev_attr_intel_spi_bios_lock);
+
+	return mtd_device_unregister(&ispi->nor.mtd);
+}
+EXPORT_SYMBOL_GPL(intel_spi_remove);
+
 struct intel_spi *intel_spi_probe(struct device *dev,
 	struct resource *mem, const struct intel_spi_boardinfo *info)
 {
@@ -927,7 +993,9 @@ struct intel_spi *intel_spi_probe(struct device *dev,
 
 	ispi->dev = dev;
 	ispi->info = info;
-	ispi->writeable = info->writeable;
+	ispi->is_bios_locked = info->is_bios_locked(dev);
+	dev_dbg(ispi->dev, "is_bios_locked: %d writeable: %d\n",
+		ispi->is_bios_locked, writeable);
 
 	ret = intel_spi_init(ispi);
 	if (ret)
@@ -946,22 +1014,28 @@ struct intel_spi *intel_spi_probe(struct device *dev,
 	intel_spi_fill_partition(ispi, &part);
 
 	/* Prevent writes if not explicitly enabled */
-	if (!ispi->writeable || !writeable)
+	if (ispi->is_protected || ispi->is_bios_locked || !writeable)
 		ispi->nor.mtd.flags &= ~MTD_WRITEABLE;
 
 	ret = mtd_device_register(&ispi->nor.mtd, &part, 1);
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = device_create_file(ispi->dev, &dev_attr_intel_spi_is_protected);
+	if (ret)
+		goto err;
+	ret = device_create_file(ispi->dev, &dev_attr_intel_spi_bios_lock);
+	if (ret)
+		goto err;
+
 	return ispi;
+
+err:
+	intel_spi_remove(ispi);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(intel_spi_probe);
 
-int intel_spi_remove(struct intel_spi *ispi)
-{
-	return mtd_device_unregister(&ispi->nor.mtd);
-}
-EXPORT_SYMBOL_GPL(intel_spi_remove);
 
 MODULE_DESCRIPTION("Intel PCH/PCU SPI flash core driver");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
diff --git a/include/linux/platform_data/x86/intel-spi.h b/include/linux/platform_data/x86/intel-spi.h
index 7f53a5c6f35e..335dbb40620f 100644
--- a/include/linux/platform_data/x86/intel-spi.h
+++ b/include/linux/platform_data/x86/intel-spi.h
@@ -19,11 +19,13 @@ enum intel_spi_type {
 /**
  * struct intel_spi_boardinfo - Board specific data for Intel SPI driver
  * @type: Type which this controller is compatible with
- * @writeable: The chip is writeable
+ * @is_bios_locked: report if the device is locked by BIOS
+ * @bios_unlock: handler to unlock the bios
  */
 struct intel_spi_boardinfo {
 	enum intel_spi_type type;
-	bool writeable;
+	bool (*is_bios_locked)(struct device *dev);
+	int (*bios_unlock)(struct device *dev);
 };
 
 #endif /* INTEL_SPI_PDATA_H */
-- 
2.26.3

