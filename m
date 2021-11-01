Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB54412E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 06:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhKAFRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 01:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhKAFRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 01:17:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3A1C061714;
        Sun, 31 Oct 2021 22:15:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k2so707971pff.11;
        Sun, 31 Oct 2021 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NbgQ03z5taxoKiCTN4vWsSA2tMczKLR6AVFSs8KClzQ=;
        b=aUClzvFzICjhEYAqfjS4CpBkRKURQiQArcGYm53j4rJqskyDLTMqWL+b4Mfo51qxUb
         t/SC8ixvC6Z+knXouPip/9XUOkaZ0J7Eg8ynjrt/JB+z3XS75kKdNVrh7qDlKHx3zwxl
         YVZGO6uZGqjC0DCdcoR3TyQVngSxTurODUDMAiMAQP25DjJzqz76a9/sUWYwRccz2gt8
         OJs8HFeAL90PnGJEIqWcvPsQ9k5acUCWjIHvGzaFGY2tdzdk2FNbm0+tkfsWux9dFTNr
         ilb3tvWN/sNMcCneu0+mlbyTd4EG/coiCHNVmbDZPuIqbB8nhCFOoIEYrJnEYN44lK+p
         FZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NbgQ03z5taxoKiCTN4vWsSA2tMczKLR6AVFSs8KClzQ=;
        b=iMu7miDHgRjEDCQkYlgbZjoE5KXXBUHrCmrj8k+txOru/ukG4U2uYAbtYxyei1HPHM
         RSl6KP6wRv+Ldwtn/oSNA1jv4mRgzlFAGw5ym0xBZAT6v5IOehaTeK3bBuXJcakoV5zo
         jouJFqBY1VEZ56mTvVJ5zkqZh7RIxkc0THb1TtXlJETqy1J3S+7lyJXgXRTz6u5L3kNE
         v0WUHTZSnkC3KzaS1IlxdMPtwenLLbvsGrh6RrFm3ZHQZnV4Xd5YABJAwsqPAGK2lxjW
         d1wL5uRtx1/fRwXrDzJlCJWyonwmi99Uj55mswNd/ruU+oJ0KRasAj/C7lsvyqBQtgIP
         oL9A==
X-Gm-Message-State: AOAM533nvPskouSNJLiNs5491INvyyTgLiTy9V7DePLwoBwBCW3NwJZj
        C0NaXlVZeOBGLQIBqICbwYc=
X-Google-Smtp-Source: ABdhPJwuFdFtuhqIeVou0+WmGJypRxK+M43deZQ0RvlvWlz1NZRM/pDVErCXANnclygBeMe/L2Yr7Q==
X-Received: by 2002:a63:b252:: with SMTP id t18mr1174372pgo.19.1635743720478;
        Sun, 31 Oct 2021 22:15:20 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id k7sm3182090pgn.47.2021.10.31.22.15.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 22:15:20 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
X-Google-Original-From: Vincent Shih <vincent.shih@sunplus.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Vincent Shih <vincent.shih@sunplus.com>
Subject: [PATCH 1/2] nvmem: Add driver for Sunplus SP7021
Date:   Mon,  1 Nov 2021 13:15:11 +0800
Message-Id: <1635743712-25358-2-git-send-email-vincent.shih@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635743712-25358-1-git-send-email-vincent.shih@sunplus.com>
References: <1635743712-25358-1-git-send-email-vincent.shih@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for Sunplus SP7021

Signed-off-by: Vincent Shih <vincent.shih@sunplus.com>
---
 MAINTAINERS                    |   7 ++
 drivers/nvmem/Kconfig          |   9 ++
 drivers/nvmem/Makefile         |   1 +
 drivers/nvmem/sunplus-ocotp.c  | 207 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvmem/sunplus-ocotp.h  | 136 +++++++++++++++++++++++++++
 drivers/nvmem/sunplus-ocotp0.c |  54 +++++++++++
 6 files changed, 414 insertions(+)
 create mode 100644 drivers/nvmem/sunplus-ocotp.c
 create mode 100644 drivers/nvmem/sunplus-ocotp.h
 create mode 100644 drivers/nvmem/sunplus-ocotp0.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80eebc1..b7df2f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17947,6 +17947,13 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS OCOTP DRIVER
+M:	Vincent Shih <vincent.shih@sunplus.com>
+S:	Maintained
+F:	drivers/nvmem/sunplus-ocotp.c
+F:	drivers/nvmem/sunplus-ocotp.h
+F:	drivers/nvmem/sunplus-ocotp0.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index da41461..c969129 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -300,4 +300,13 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
+config NVMEM_SUNPLUS_OCOTP
+  tristate "Sunplus SoC OTP support"
+  depends on SOC_SP7021
+	depends on HAS_IOMEM
+	help
+	  This is a driver for the On-chip OTP controller (OCOTP) available on
+	  Sunplus SoCs, providing access to 128 bytes of one-time programmable
+	  eFuse0.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index dcbbde3..024e487 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
 nvmem-rmem-y			:= rmem.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y		:= brcm_nvram.o
+obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= sunplus-ocotp.o sunplus-ocotp0.o
diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
new file mode 100644
index 0000000..7e1bc64
--- /dev/null
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/of_device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+
+#include "sunplus-ocotp.h"
+
+enum base_type {
+	HB_GPIO,
+	OTPRX,
+	BASEMAX,
+};
+
+struct sp_otp_data_t {
+	struct device *dev;
+	void __iomem *base[BASEMAX];
+	struct clk *clk;
+	struct nvmem_config *config;
+};
+
+static int sp_otp_wait(void __iomem *_base)
+{
+	struct sp_otprx_reg *otprx_reg_ptr = (struct sp_otprx_reg *)(_base);
+	int timeout = OTP_READ_TIMEOUT;
+	unsigned int status;
+
+	do {
+		udelay(10);
+		if (timeout-- == 0)
+			return -ETIMEDOUT;
+
+		status = readl(&otprx_reg_ptr->otp_cmd_status);
+	} while ((status & OTP_READ_DONE) != OTP_READ_DONE);
+
+	return 0;
+}
+
+int sp_otp_read_real(struct sp_otp_data_t *_otp, int addr, char *value)
+{
+	struct sp_hb_gpio_reg *hb_gpio_reg_ptr;
+	struct sp_otprx_reg *otprx_reg_ptr;
+	unsigned int addr_data;
+	unsigned int byte_shift;
+	int ret = 0;
+
+	hb_gpio_reg_ptr = (struct sp_hb_gpio_reg *)(_otp->base[HB_GPIO]);
+	otprx_reg_ptr = (struct sp_otprx_reg *)(_otp->base[OTPRX]);
+
+	addr_data = addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
+	addr_data = addr_data / OTP_WORD_SIZE;
+
+	byte_shift = addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
+	byte_shift = byte_shift % OTP_WORD_SIZE;
+
+	addr = addr / (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
+	addr = addr * OTP_BIT_ADDR_OF_BANK;
+
+	writel(0x0, &otprx_reg_ptr->otp_cmd_status);
+	writel(addr, &otprx_reg_ptr->otp_addr);
+	writel(0x1E04, &otprx_reg_ptr->otp_cmd);
+
+	ret = sp_otp_wait(_otp->base[OTPRX]);
+	if (ret < 0)
+		return ret;
+
+	*value = (readl(&hb_gpio_reg_ptr->hb_gpio_rgst_bus32_9 +
+				addr_data) >> (8 * byte_shift)) & 0xFF;
+
+	return ret;
+}
+
+static int sp_ocotp_read(void *_c, unsigned int _off, void *_v, size_t _l)
+{
+	struct sp_otp_data_t *otp = _c;
+	unsigned int addr;
+	char *buf = _v;
+	char value[4];
+	int ret;
+
+	dev_dbg(otp->dev, "OTP read %u bytes at %u", _l, _off);
+
+	if ((_off >= QAC628_OTP_SIZE) || (_l == 0) || ((_off + _l) > QAC628_OTP_SIZE))
+		return -EINVAL;
+
+	ret = clk_enable(otp->clk);
+	if (ret)
+		return ret;
+
+	*buf = 0;
+	for (addr = _off; addr < (_off + _l); addr++) {
+		ret = sp_otp_read_real(otp, addr, value);
+		if (ret < 0) {
+			dev_err(otp->dev, "OTP read fail:%d at %d", ret, addr);
+			goto disable_clk;
+		}
+
+		*buf++ = *value;
+	}
+
+disable_clk:
+	clk_disable(otp->clk);
+	dev_dbg(otp->dev, "OTP read complete");
+
+	return ret;
+}
+
+static struct nvmem_config sp_ocotp_nvmem_config = {
+	.name = "sp-ocotp",
+	.read_only = true,
+	.word_size = 1,
+	.size = QAC628_OTP_SIZE,
+	.stride = 1,
+	.reg_read = sp_ocotp_read,
+	.owner = THIS_MODULE,
+};
+
+int sp_ocotp_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	const struct sp_otp_vX_t *sp_otp_vX = NULL;
+	struct device *dev = &(pdev->dev);
+	struct nvmem_device *nvmem;
+	struct sp_otp_data_t *otp;
+	struct resource *res;
+	int ret;
+
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (match && match->data) {
+		sp_otp_vX = match->data;
+		// may be used to choose the parameters
+	} else {
+		dev_err(dev, "OTP vX does not match");
+	}
+
+	otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
+	if (!otp)
+		return -ENOMEM;
+
+	otp->dev = dev;
+	otp->config = &sp_ocotp_nvmem_config;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gpio");
+	otp->base[HB_GPIO] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(otp->base[HB_GPIO]))
+		return PTR_ERR(otp->base[HB_GPIO]);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx");
+	otp->base[OTPRX] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(otp->base[OTPRX]))
+		return PTR_ERR(otp->base[OTPRX]);
+
+	otp->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(otp->clk))
+		return PTR_ERR(otp->clk);
+
+	ret = clk_prepare(otp->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to prepare clk: %d\n", ret);
+		return ret;
+	}
+	clk_enable(otp->clk);
+
+	sp_ocotp_nvmem_config.priv = otp;
+	sp_ocotp_nvmem_config.dev = dev;
+
+	// devm_* >= 4.15 kernel
+	// nvmem = devm_nvmem_register(dev, &sp_ocotp_nvmem_config);
+
+	nvmem = nvmem_register(&sp_ocotp_nvmem_config);
+
+	if (IS_ERR(nvmem)) {
+		dev_err(dev, "error registering nvmem config\n");
+		return PTR_ERR(nvmem);
+	}
+
+	platform_set_drvdata(pdev, nvmem);
+
+	dev_dbg(dev, "clk:%ld banks:%d x wpb:%d x wsize:%d = %d",
+		clk_get_rate(otp->clk),
+		QAC628_OTP_NUM_BANKS, OTP_WORDS_PER_BANK,
+		OTP_WORD_SIZE, QAC628_OTP_SIZE);
+
+	dev_info(dev, "by Sunplus (C) 2020");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sp_ocotp_probe);
+
+int sp_ocotp_remove(struct platform_device *pdev)
+{
+	// disable for devm_*
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	nvmem_unregister(nvmem);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sp_ocotp_remove);
+
diff --git a/drivers/nvmem/sunplus-ocotp.h b/drivers/nvmem/sunplus-ocotp.h
new file mode 100644
index 0000000..804d469
--- /dev/null
+++ b/drivers/nvmem/sunplus-ocotp.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SP_OCOTP_FW_H_
+#define __SP_OCOTP_FW_H_
+
+/**************************************************************************************************/
+/* OTP memory											  */
+/* Each bank contains 4 words (32 bits).							  */
+/* Bank 0 starts at offset 0 from the base.							  */
+/*												  */
+/**************************************************************************************************/
+#define OTP_WORDS_PER_BANK		4
+#define OTP_WORD_SIZE			sizeof(u32)
+#define OTP_BIT_ADDR_OF_BANK		(8 * OTP_WORD_SIZE * OTP_WORDS_PER_BANK)
+
+#define QAC628_OTP_NUM_BANKS            8
+#define QAC628_OTP_SIZE                 (QAC628_OTP_NUM_BANKS * OTP_WORDS_PER_BANK * OTP_WORD_SIZE)
+
+#define I143_OTP_NUM_BANKS		8
+#define I143_OTP_SIZE			(I143_OTP_NUM_BANKS * OTP_WORDS_PER_BANK * OTP_WORD_SIZE)
+
+#define QAK645_EFUSE0_NUM_BANKS		8
+#define QAK645_EFUSE0_SIZE		(QAK645_EFUSE0_NUM_BANKS * OTP_WORDS_PER_BANK * \
+										OTP_WORD_SIZE)
+
+#define QAK645_EFUSE1_NUM_BANKS		64
+#define QAK645_EFUSE1_SIZE		(QAK645_EFUSE1_NUM_BANKS * OTP_WORDS_PER_BANK * \
+										OTP_WORD_SIZE)
+
+#define QAK645_EFUSE2_NUM_BANKS		8
+#define QAK645_EFUSE2_SIZE		(QAK645_EFUSE2_NUM_BANKS * OTP_WORDS_PER_BANK * \
+										OTP_WORD_SIZE)
+
+#define OTP_READ_TIMEOUT                20000
+
+/* HB_GPIO register map */
+struct sp_hb_gpio_reg {
+	unsigned int hb_gpio_rgst_bus32_1;
+	unsigned int hb_gpio_rgst_bus32_2;
+	unsigned int hb_gpio_rgst_bus32_3;
+	unsigned int hb_gpio_rgst_bus32_4;
+	unsigned int hb_gpio_rgst_bus32_5;
+	unsigned int hb_gpio_rgst_bus32_6;
+	unsigned int hb_gpio_rgst_bus32_7;
+	unsigned int hb_gpio_rgst_bus32_8;
+	unsigned int hb_gpio_rgst_bus32_9;
+	unsigned int hb_gpio_rgst_bus32_10;
+	unsigned int hb_gpio_rgst_bus32_11;
+	unsigned int hb_gpio_rgst_bus32_12;
+};
+
+/* OTPRX register map */
+struct sp_otprx_reg {
+	unsigned int sw_trim;
+	unsigned int set_key;
+	unsigned int otp_rsv;
+	unsigned int otp_prog_ctl;
+	unsigned int otp_prog_addr;
+	unsigned int otp_prog_csv;
+	unsigned int otp_prog_strobe;
+	unsigned int otp_prog_load;
+	unsigned int otp_prog_pgenb;
+	unsigned int otp_prog_wr;
+	unsigned int otp_prog_reg25;
+	unsigned int otp_prog_state;
+	unsigned int otp_usb_phy_trim;
+	unsigned int otp_data2;
+	unsigned int otp_prog_ps;
+	unsigned int otp_rsv2;
+	unsigned int key_srst;
+	unsigned int otp_ctrl;
+	unsigned int otp_cmd;
+	unsigned int otp_cmd_status;
+	unsigned int otp_addr;
+	unsigned int otp_data;
+	unsigned int rtc_reset_record;
+	unsigned int rtc_battery_ctrl;
+	unsigned int rtc_trim_ctrl;
+	unsigned int rsv25;
+	unsigned int rsv26;
+	unsigned int rsv27;
+	unsigned int rsv28;
+	unsigned int rsv29;
+	unsigned int rsv30;
+	unsigned int rsv31;
+};
+
+// otp_prog_ctl
+#define PIO_MODE                        0x07
+
+// otp_prog_addr
+#define PROG_OTP_ADDR                   0x1FFF
+
+// otp_prog_pgenb
+#define PIO_PGENB                       0x01
+
+// otp_prog_wr
+#define PIO_WR                          0x01
+
+// otp_prog_reg25
+#define PROGRAM_OTP_DATA                0xFF00
+#define PROGRAM_OTP_DATA_SHIFT          8
+#define REG25_PD_MODE_SEL               0x10
+#define REG25_POWER_SOURCE_SEL          0x02
+#define OTP2REG_PD_N_P                  0x01
+
+// otp_prog_state
+#define OTPRSV_CMD3                     0xE0
+#define OTPRSV_CMD3_SHIFT               5
+#define TSMC_OTP_STATE                  0x1F
+
+// otp_ctrl
+#define PROG_OTP_PERIOD                 0xFFE0
+#define PROG_OTP_PERIOD_SHIFT           5
+#define OTP_EN_R                        0x01
+
+// otp_cmd
+#define OTP_RD_PERIOD                   0xFF00
+#define OTP_RD_PERIOD_SHIFT             8
+#define OTP_READ                        0x04
+
+// otp_cmd_status
+#define OTP_READ_DONE                   0x10
+
+// otp_addr
+#define RD_OTP_ADDRESS                  0x1FFF
+
+extern int sp_ocotp_probe(struct platform_device *pdev);
+extern int sp_ocotp_remove(struct platform_device *pdev);
+
+struct sp_otp_vX_t {
+	int size;
+};
+
+#endif /* __SP_OCOTP_FW_H_ */
+
diff --git a/drivers/nvmem/sunplus-ocotp0.c b/drivers/nvmem/sunplus-ocotp0.c
new file mode 100644
index 0000000..889ae0a
--- /dev/null
+++ b/drivers/nvmem/sunplus-ocotp0.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*												  */
+/* The OCOTP driver for Sunplus	SP7021								  */
+/*												  */
+/* Copyright (C) 2019 Sunplus Technology Inc., All rights reseerved.				  */
+/*												  */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+
+#include "sunplus-ocotp.h"
+
+static int efuse0_sunplus_platform_probe(struct platform_device *dev)
+{
+	return sp_ocotp_probe(dev);
+}
+
+const struct sp_otp_vX_t  sp_otp_v0 = {
+	.size = QAC628_OTP_SIZE,
+};
+
+static const struct of_device_id sp_ocotp0_dt_ids[] = {
+	{ .compatible = "sunplus,sp7021-ocotp", .data = &sp_otp_v0  },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sp_ocotp0_dt_ids);
+
+static struct platform_driver sp_otp0_driver = {
+	.probe     = efuse0_sunplus_platform_probe,
+	.remove    = sp_ocotp_remove,
+	.driver    = {
+		.name           = "sunplus,sp7021-ocotp",
+		.of_match_table = sp_ocotp0_dt_ids,
+	}
+};
+
+static int __init sp_otp0_drv_new(void)
+{
+	return platform_driver_register(&sp_otp0_driver);
+}
+subsys_initcall(sp_otp0_drv_new);
+
+static void __exit sp_otp0_drv_del(void)
+{
+	platform_driver_unregister(&sp_otp0_driver);
+}
+module_exit(sp_otp0_drv_del);
+
+MODULE_AUTHOR("Vincent Shih <vincent.shih@sunplus.com>");
+MODULE_DESCRIPTION("Sunplus On-Chip OTP (eFuse0) driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.7.4

