Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BA439D389
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 05:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGDlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 23:41:23 -0400
Received: from phobos.denx.de ([85.214.62.61]:58892 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGDlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:41:21 -0400
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C818082CE6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 05:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623037169;
        bh=sPsxdd4sNWfTxYnFzyV3FO1IE4IKDOoYxqRwZQDSfzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JbowvwmqZmafMnmKUnhKtkHNQwUSub5swHK0c2I6s1yLQjcu5sROwMX7u5+sSlRqc
         +eUsn/fKhGlElIJmD0+OGc1tIRULkJfEOgKtyaBI/wcehHxTlhQ1KTjsaQaYMDl/M5
         6m/lQDeu4RsTaRSIcx1Y3hOi/8zuKCYGrIh8n5F1n7CrtPpwKERriimZX7qe4QCWAj
         jIzzoutYg/H+eJXecgwJV+6ATcJSabfZ5dHbZaQciMhtz4ciUtWH1fxK7EvzACEHu4
         6zLCL/mWGTL2JhxjNSNQHXvg7wtHI9tx/ilw81WFFBqOzuJcQFBnnCciipRmqUKKhj
         A0RUjOL4Ffd7Q==
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id D385D181B63;
        Mon,  7 Jun 2021 05:39:12 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id CAC931A8BB0; Mon,  7 Jun 2021 05:39:12 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-mtd@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>,
        kernel test robot <lkp@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mtd: devices: add support for microchip 48l640 EERAM
Date:   Mon,  7 Jun 2021 05:39:09 +0200
Message-Id: <20210607033909.1424605-3-hs@denx.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607033909.1424605-1-hs@denx.de>
References: <20210607033909.1424605-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip 48l640 is a 8KByte EERAM connected via SPI.

Signed-off-by: Heiko Schocher <hs@denx.de>
Tested-by: Fabio Estevam <festevam@denx.de>
Reported-by: kernel test robot <lkp@intel.com>

---
I tried to use drivers/mtd/devices/mchp23k256.c but this
driver does not use any status register and there seems
slight differences in registers (no write enable register
for example), so I decided to make a new driver.

This driver sets the continuous mode bit in Status register,
which states you can write continuous ... but after writting
32 bytes the chip goes into an undefined state, so driver now
writes data in 32 byte chunks.

I also tried to use regmap, but it leads in a lot of more code,
and as this chip has only spi interface it makes no sense, or?

Tested  this driver on board imx8mp-phyboard-pollux-rdk
board, which is already in mainline.

Made some tbot tests, which write at random offset random
length bytes with dd and and random content. Reread the data
after a reboot and compare with the written data. Works fine.

(no changes since v3)

Changes in v3:
drop dev_dbg() in mchp48l640_read() as not really needed to
fix warning which kernel test robot found for
config: arc-allyesconfig (attached as .config)
compiler: arceb-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
add Reported-by: kernel test robot <lkp@intel.com>
add Fabio to cc

Changes in v2:
- fix build warnings
- add Fabios Tested-by

 drivers/mtd/devices/Kconfig      |   6 +
 drivers/mtd/devices/Makefile     |   1 +
 drivers/mtd/devices/mchp48l640.c | 373 +++++++++++++++++++++++++++++++
 3 files changed, 380 insertions(+)
 create mode 100644 drivers/mtd/devices/mchp48l640.c

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 0f4c2d823de84..79cb981ececc9 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -89,6 +89,12 @@ config MTD_MCHP23K256
 	  platform data, or a device tree description if you want to
 	  specify device partitioning
 
+config MTD_MCHP48L640
+	tristate "Microchip 48L640 EERAM"
+	depends on SPI_MASTER
+	help
+	  This enables access to Microchip 48L640 EERAM chips, using SPI.
+
 config MTD_SPEAR_SMI
 	tristate "SPEAR MTD NOR Support through SMI controller"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
index 991c8d12c0160..0362cf6bdc67f 100644
--- a/drivers/mtd/devices/Makefile
+++ b/drivers/mtd/devices/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MTD_LART)		+= lart.o
 obj-$(CONFIG_MTD_BLOCK2MTD)	+= block2mtd.o
 obj-$(CONFIG_MTD_DATAFLASH)	+= mtd_dataflash.o
 obj-$(CONFIG_MTD_MCHP23K256)	+= mchp23k256.o
+obj-$(CONFIG_MTD_MCHP48L640)	+= mchp48l640.o
 obj-$(CONFIG_MTD_SPEAR_SMI)	+= spear_smi.o
 obj-$(CONFIG_MTD_SST25L)	+= sst25l.o
 obj-$(CONFIG_MTD_BCM47XXSFLASH)	+= bcm47xxsflash.o
diff --git a/drivers/mtd/devices/mchp48l640.c b/drivers/mtd/devices/mchp48l640.c
new file mode 100644
index 0000000000000..efc2003bd13a4
--- /dev/null
+++ b/drivers/mtd/devices/mchp48l640.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Microchip 48L640 64 Kb SPI Serial EERAM
+ *
+ * Copyright Heiko Schocher <hs@denx.de>
+ *
+ * datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/20006055B.pdf
+ *
+ * we set continuous mode but reading/writing more bytes than
+ * pagesize seems to bring chip into state where readden values
+ * are wrong ... no idea why.
+ *
+ */
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/sizes.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/of_device.h>
+
+struct mchp48_caps {
+	unsigned int size;
+	unsigned int page_size;
+};
+
+struct mchp48l640_flash {
+	struct spi_device	*spi;
+	struct mutex		lock;
+	struct mtd_info		mtd;
+	const struct mchp48_caps	*caps;
+};
+
+#define MCHP48L640_CMD_WREN		0x06
+#define MCHP48L640_CMD_WRDI		0x04
+#define MCHP48L640_CMD_WRITE		0x02
+#define MCHP48L640_CMD_READ		0x03
+#define MCHP48L640_CMD_WRSR		0x01
+#define MCHP48L640_CMD_RDSR		0x05
+
+#define MCHP48L640_STATUS_RDY		0x01
+#define MCHP48L640_STATUS_WEL		0x02
+#define MCHP48L640_STATUS_BP0		0x04
+#define MCHP48L640_STATUS_BP1		0x08
+#define MCHP48L640_STATUS_SWM		0x10
+#define MCHP48L640_STATUS_PRO		0x20
+#define MCHP48L640_STATUS_ASE		0x40
+
+#define MCHP48L640_TIMEOUT		100
+
+#define MAX_CMD_SIZE			0x10
+
+#define to_mchp48l640_flash(x) container_of(x, struct mchp48l640_flash, mtd)
+
+static int mchp48l640_mkcmd(struct mchp48l640_flash *flash, u8 cmd, loff_t addr, char *buf)
+{
+	buf[0] = cmd;
+	buf[1] = addr >> 8;
+	buf[2] = addr;
+
+	return 3;
+}
+
+static int mchp48l640_read_status(struct mchp48l640_flash *flash, int *status)
+{
+	unsigned char cmd[2];
+	int ret;
+
+	cmd[0] = MCHP48L640_CMD_RDSR;
+	cmd[1] = 0x00;
+	mutex_lock(&flash->lock);
+	ret = spi_write_then_read(flash->spi, &cmd[0], 1, &cmd[1], 1);
+	mutex_unlock(&flash->lock);
+	if (!ret)
+		*status = cmd[1];
+	dev_dbg(&flash->spi->dev, "read status ret: %d status: %x", ret, *status);
+
+	return ret;
+}
+
+static int mchp48l640_waitforbit(struct mchp48l640_flash *flash, int bit, bool set)
+{
+	int ret, status;
+	unsigned long deadline;
+
+	deadline = jiffies + msecs_to_jiffies(MCHP48L640_TIMEOUT);
+	do {
+		ret = mchp48l640_read_status(flash, &status);
+		dev_dbg(&flash->spi->dev, "read status ret: %d bit: %x %sset status: %x",
+			ret, bit, (set ? "" : "not"), status);
+		if (ret)
+			return ret;
+
+		if (set) {
+			if ((status & bit) == bit)
+				return 0;
+		} else {
+			if ((status & bit) == 0)
+				return 0;
+		}
+
+		usleep_range(1000, 2000);
+	} while (!time_after_eq(jiffies, deadline));
+
+	dev_err(&flash->spi->dev, "Timeout waiting for bit %x %s set in status register.",
+		bit, (set ? "" : "not"));
+	return -ETIMEDOUT;
+}
+
+static int mchp48l640_write_prepare(struct mchp48l640_flash *flash, bool enable)
+{
+	unsigned char cmd[2];
+	int ret;
+
+	if (enable)
+		cmd[0] = MCHP48L640_CMD_WREN;
+	else
+		cmd[0] = MCHP48L640_CMD_WRDI;
+
+	mutex_lock(&flash->lock);
+	ret = spi_write(flash->spi, cmd, 1);
+	mutex_unlock(&flash->lock);
+
+	if (ret)
+		dev_err(&flash->spi->dev, "write %sable failed ret: %d",
+			(enable ? "en" : "dis"), ret);
+
+	dev_dbg(&flash->spi->dev, "write %sable success ret: %d",
+		(enable ? "en" : "dis"), ret);
+	if (enable)
+		return mchp48l640_waitforbit(flash, MCHP48L640_STATUS_WEL, true);
+
+	return ret;
+}
+
+static int mchp48l640_set_mode(struct mchp48l640_flash *flash)
+{
+	unsigned char cmd[2];
+	int ret;
+
+	ret = mchp48l640_write_prepare(flash, true);
+	if (ret)
+		return ret;
+
+	cmd[0] = MCHP48L640_CMD_WRSR;
+	cmd[1] = MCHP48L640_STATUS_PRO;
+
+	mutex_lock(&flash->lock);
+	ret = spi_write(flash->spi, cmd, 2);
+	mutex_unlock(&flash->lock);
+	if (ret)
+		dev_err(&flash->spi->dev, "Could not set continuous mode ret: %d", ret);
+
+	return mchp48l640_waitforbit(flash, MCHP48L640_STATUS_PRO, true);
+}
+
+static int mchp48l640_wait_rdy(struct mchp48l640_flash *flash)
+{
+	return mchp48l640_waitforbit(flash, MCHP48L640_STATUS_RDY, false);
+};
+
+static int mchp48l640_write_page(struct mtd_info *mtd, loff_t to, size_t len,
+			    size_t *retlen, const unsigned char *buf)
+{
+	struct mchp48l640_flash *flash = to_mchp48l640_flash(mtd);
+	unsigned char *cmd;
+	int ret;
+	int cmdlen;
+
+	cmd = kmalloc((3 + len), GFP_KERNEL | GFP_DMA);
+	if (!cmd)
+		return -ENOMEM;
+
+	ret = mchp48l640_wait_rdy(flash);
+	if (ret)
+		goto fail;
+
+	ret = mchp48l640_write_prepare(flash, true);
+	if (ret)
+		goto fail;
+
+	mutex_lock(&flash->lock);
+	cmdlen = mchp48l640_mkcmd(flash, MCHP48L640_CMD_WRITE, to, cmd);
+	memcpy(&cmd[cmdlen], buf, len);
+	ret = spi_write(flash->spi, cmd, cmdlen + len);
+	mutex_unlock(&flash->lock);
+	if (!ret)
+		*retlen += len;
+	else
+		goto fail;
+
+	ret = mchp48l640_waitforbit(flash, MCHP48L640_STATUS_WEL, false);
+	if (ret)
+		goto fail;
+
+	kfree(cmd);
+	return 0;
+fail:
+	kfree(cmd);
+	dev_err(&flash->spi->dev, "write fail with: %d", ret);
+	return ret;
+};
+
+static int mchp48l640_write(struct mtd_info *mtd, loff_t to, size_t len,
+			    size_t *retlen, const unsigned char *buf)
+{
+	struct mchp48l640_flash *flash = to_mchp48l640_flash(mtd);
+	int ret;
+	size_t wlen = 0;
+	loff_t woff = to;
+	size_t ws;
+	size_t page_sz = flash->caps->page_size;
+
+	/*
+	 * we set PRO bit (page rollover), but writing length > page size
+	 * does result in total chaos, so write in 32 byte chunks.
+	 */
+	while (wlen < len) {
+		ws = min((len - wlen), page_sz);
+		ret = mchp48l640_write_page(mtd, woff, ws, retlen, &buf[wlen]);
+		if (ret)
+			return ret;
+		wlen += ws;
+		woff += ws;
+	}
+
+	return ret;
+}
+
+static int mchp48l640_read_page(struct mtd_info *mtd, loff_t from, size_t len,
+			   size_t *retlen, unsigned char *buf)
+{
+	struct mchp48l640_flash *flash = to_mchp48l640_flash(mtd);
+	unsigned char *cmd;
+	int ret;
+	int cmdlen;
+
+	cmd = kmalloc((3 + len), GFP_KERNEL | GFP_DMA);
+	if (!cmd)
+		return -ENOMEM;
+
+	ret = mchp48l640_wait_rdy(flash);
+	if (ret)
+		goto fail;
+
+	mutex_lock(&flash->lock);
+	cmdlen = mchp48l640_mkcmd(flash, MCHP48L640_CMD_READ, from, cmd);
+	ret = spi_write_then_read(flash->spi, cmd, cmdlen, buf, len);
+	mutex_unlock(&flash->lock);
+	if (!ret)
+		*retlen += len;
+
+	return ret;
+
+fail:
+	kfree(cmd);
+	dev_err(&flash->spi->dev, "read fail with: %d", ret);
+	return ret;
+}
+
+static int mchp48l640_read(struct mtd_info *mtd, loff_t from, size_t len,
+			   size_t *retlen, unsigned char *buf)
+{
+	struct mchp48l640_flash *flash = to_mchp48l640_flash(mtd);
+	int ret;
+	size_t wlen = 0;
+	loff_t woff = from;
+	size_t ws;
+	size_t page_sz = flash->caps->page_size;
+
+	/*
+	 * we set PRO bit (page rollover), but if read length > page size
+	 * does result in total chaos in result ...
+	 */
+	while (wlen < len) {
+		ws = min((len - wlen), page_sz);
+		ret = mchp48l640_read_page(mtd, woff, ws, retlen, &buf[wlen]);
+		if (ret)
+			return ret;
+		wlen += ws;
+		woff += ws;
+	}
+
+	return ret;
+};
+
+static const struct mchp48_caps mchp48l640_caps = {
+	.size = SZ_8K,
+	.page_size = 32,
+};
+
+static int mchp48l640_probe(struct spi_device *spi)
+{
+	struct mchp48l640_flash *flash;
+	struct flash_platform_data *data;
+	int err;
+	int status;
+
+	flash = devm_kzalloc(&spi->dev, sizeof(*flash), GFP_KERNEL);
+	if (!flash)
+		return -ENOMEM;
+
+	flash->spi = spi;
+	mutex_init(&flash->lock);
+	spi_set_drvdata(spi, flash);
+
+	err = mchp48l640_read_status(flash, &status);
+	if (err)
+		return err;
+
+	err = mchp48l640_set_mode(flash);
+	if (err)
+		return err;
+
+	data = dev_get_platdata(&spi->dev);
+
+	flash->caps = of_device_get_match_data(&spi->dev);
+	if (!flash->caps)
+		flash->caps = &mchp48l640_caps;
+
+	mtd_set_of_node(&flash->mtd, spi->dev.of_node);
+	flash->mtd.dev.parent	= &spi->dev;
+	flash->mtd.type		= MTD_RAM;
+	flash->mtd.flags	= MTD_CAP_RAM;
+	flash->mtd.writesize	= flash->caps->page_size;
+	flash->mtd.size		= flash->caps->size;
+	flash->mtd._read	= mchp48l640_read;
+	flash->mtd._write	= mchp48l640_write;
+
+	err = mtd_device_register(&flash->mtd, data ? data->parts : NULL,
+				  data ? data->nr_parts : 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int mchp48l640_remove(struct spi_device *spi)
+{
+	struct mchp48l640_flash *flash = spi_get_drvdata(spi);
+
+	return mtd_device_unregister(&flash->mtd);
+}
+
+static const struct of_device_id mchp48l640_of_table[] = {
+	{
+		.compatible = "microchip,48l640",
+		.data = &mchp48l640_caps,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mchp48l640_of_table);
+
+static struct spi_driver mchp48l640_driver = {
+	.driver = {
+		.name	= "mchp48l640",
+		.of_match_table = of_match_ptr(mchp48l640_of_table),
+	},
+	.probe		= mchp48l640_probe,
+	.remove		= mchp48l640_remove,
+};
+
+module_spi_driver(mchp48l640_driver);
+
+MODULE_DESCRIPTION("MTD SPI driver for Microchip 48l640 EERAM chips");
+MODULE_AUTHOR("Heiko Schocher <hs@denx.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:mchp48l640");
-- 
2.31.1

