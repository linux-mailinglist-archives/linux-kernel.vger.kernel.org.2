Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD91361D82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbhDPJdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:33:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39475 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241819AbhDPJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:32:55 -0400
X-UUID: 843897e0e60c4507876e788386184074-20210416
X-UUID: 843897e0e60c4507876e788386184074-20210416
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <pk.chi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 756214644; Fri, 16 Apr 2021 17:32:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Apr 2021 17:32:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 17:32:23 +0800
From:   Po-Kai Chi <pk.chi@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
        Po-Kai Chi <pk.chi@mediatek.com>
Subject: [PATCH v2 2/4] memory: mediatek: add DRAM controller driver
Date:   Fri, 16 Apr 2021 17:32:16 +0800
Message-ID: <1618565538-6972-3-git-send-email-pk.chi@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
References: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8B39A48CE8725F2ACC41CD3F49C4A479180A104871411062A34BD98925B05ACE2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek DRAM controller (DRAMC) driver provides cross-platform features
as below:

1. provide APIs for low power feature queries
2. create sysfs to pass the DRAM information to user-space

Signed-off-by: Po-Kai Chi <pk.chi@mediatek.com>
---
 drivers/memory/Kconfig              |    1 +
 drivers/memory/Makefile             |    1 +
 drivers/memory/mediatek/Kconfig     |    9 +
 drivers/memory/mediatek/Makefile    |    3 +
 drivers/memory/mediatek/mtk-dramc.c |  711 +++++++++++++++++++++++++++++++++++
 include/memory/mediatek/dramc.h     |   18 +
 6 files changed, 743 insertions(+)
 create mode 100644 drivers/memory/mediatek/Kconfig
 create mode 100644 drivers/memory/mediatek/Makefile
 create mode 100644 drivers/memory/mediatek/mtk-dramc.c
 create mode 100644 include/memory/mediatek/dramc.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 72c0df1..056e906 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -225,6 +225,7 @@ config STM32_FMC2_EBI
 	  devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
 	  SOCs containing the FMC2 External Bus Interface.
 
+source "drivers/memory/mediatek/Kconfig"
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
 
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index bc7663e..cd4f8cf 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PL353_SMC)		+= pl353-smc.o
 obj-$(CONFIG_RENESAS_RPCIF)	+= renesas-rpc-if.o
 obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
 
+obj-$(CONFIG_MTK_DRAMC)		+= mediatek/
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
 obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
diff --git a/drivers/memory/mediatek/Kconfig b/drivers/memory/mediatek/Kconfig
new file mode 100644
index 0000000..a1618b0
--- /dev/null
+++ b/drivers/memory/mediatek/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config MTK_DRAMC
+	tristate "MediaTek DRAMC driver"
+	help
+	  This selects the MediaTek(R) DRAMC driver.
+	  Provide the API for DRAMC low power scenario, and the interface
+	  for reporting DRAM information, e.g. DRAM mode register (MR) for
+	  DRAM vendor ID, temperature, and density.
diff --git a/drivers/memory/mediatek/Makefile b/drivers/memory/mediatek/Makefile
new file mode 100644
index 0000000..632be48
--- /dev/null
+++ b/drivers/memory/mediatek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MTK_DRAMC)	+= mtk-dramc.o
diff --git a/drivers/memory/mediatek/mtk-dramc.c b/drivers/memory/mediatek/mtk-dramc.c
new file mode 100644
index 0000000..155b3b7
--- /dev/null
+++ b/drivers/memory/mediatek/mtk-dramc.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <memory/mediatek/dramc.h>
+
+#define DRAMC_DRV_NAME	"mtk-dramc"
+
+struct mr_info_t {
+	unsigned int mr_index;
+	unsigned int mr_value;
+};
+
+/*
+ * struct reg_ctrl_t - to describe the bits required in a register
+ * @offset: register address offset from a base
+ * @mask: bitmask of the target bits
+ * @shift: starting bit of the target bits
+ */
+struct reg_ctrl_t {
+	unsigned int offset;
+	unsigned int mask;
+	unsigned int shift;
+};
+
+struct fmeter_dev_t {
+	unsigned int crystal_freq;
+	unsigned int shu_of;
+	struct reg_ctrl_t shu_lv;
+	struct reg_ctrl_t pll_id;
+	struct reg_ctrl_t pll_md[2];
+	struct reg_ctrl_t sdmpcw[2];
+	struct reg_ctrl_t prediv[2];
+	struct reg_ctrl_t posdiv[2];
+	struct reg_ctrl_t ckdiv4[2];
+	struct reg_ctrl_t cldiv2[2];
+	struct reg_ctrl_t fbksel[2];
+	struct reg_ctrl_t dqopen[2];
+};
+
+struct mr4_dev_t {
+	struct reg_ctrl_t mr4_rg;
+};
+
+struct dramc_dev_t {
+	unsigned int dram_type;
+	unsigned int support_channel_cnt;
+	unsigned int channel_cnt;
+	unsigned int rank_cnt;
+	unsigned int mr_cnt;
+	unsigned int freq_cnt;
+	unsigned int *rank_size;
+	unsigned int *freq_step;
+	struct mr_info_t *mr_info_ptr;
+	void __iomem **dramc_chn_base_ao;
+	void __iomem **dramc_chn_base_nao;
+	void __iomem **ddrphy_chn_base_ao;
+	void *mr4_dev_ptr;
+	void *fmeter_dev_ptr;
+};
+
+enum DRAM_TYPE {
+	TYPE_NONE = 0,
+	TYPE_DDR1,
+	TYPE_LPDDR2,
+	TYPE_LPDDR3,
+	TYPE_PCDDR3,
+	TYPE_LPDDR4,
+	TYPE_LPDDR4X,
+	TYPE_LPDDR4P
+};
+
+static const struct fmeter_dev_t fmeter_v0_mt6779_t = {
+	.crystal_freq = 52,
+	.shu_of = 0x500,
+	.shu_lv = { .offset = 0x00e4, .mask = 0x00000006, .shift = 1 },
+	.pll_id = { .offset = 0x0510, .mask = 0x80000000, .shift = 31 },
+	.pll_md = {
+		{ .offset = 0x0d84, .mask = 0x00000100, .shift = 8 },
+		{ .offset = 0x0d84, .mask = 0x00000100, .shift = 8 },
+	},
+	.sdmpcw = {
+		{ .offset = 0x0d9c, .mask = 0xffff0000, .shift = 16 },
+		{ .offset = 0x0d94, .mask = 0xffff0000, .shift = 16 },
+	},
+	.prediv = {
+		{ .offset = 0x0da8, .mask = 0x000c0000, .shift = 18 },
+		{ .offset = 0x0da0, .mask = 0x000c0000, .shift = 18 },
+	},
+	.posdiv = {
+		{ .offset = 0x0da8, .mask = 0x00000007, .shift = 0 },
+		{ .offset = 0x0da0, .mask = 0x00000007, .shift = 0 },
+	},
+	.ckdiv4 = {
+		{ .offset = 0x0d18, .mask = 0x08000000, .shift = 27 },
+		{ .offset = 0x0d18, .mask = 0x08000000, .shift = 27 },
+	},
+	.cldiv2 = {
+		{ .offset = 0x0c38, .mask = 0x80000000, .shift = 31 },
+		{ .offset = 0x0c38, .mask = 0x80000000, .shift = 31 },
+	},
+};
+
+static const struct mr4_dev_t mr4_v1_mt6779_t = {
+	.mr4_rg = { .offset = 0x0090, .mask = 0x0000ffff, .shift = 0 },
+};
+
+struct mtk_dramc_compatible {
+	const struct fmeter_dev_t *fmeter;
+	const struct mr4_dev_t *mr4;
+};
+
+static const struct mtk_dramc_compatible mt6779_compat = {
+	.fmeter = &fmeter_v0_mt6779_t,
+	.mr4 = &mr4_v1_mt6779_t,
+};
+
+static const struct of_device_id mtk_dramc_of_ids[] = {
+	{ .compatible = "mediatek,mt6779-dramc", .data = &mt6779_compat },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mtk_dramc_of_ids);
+
+/*
+ * mtk_dramc_get_drvdata_by_ids - get the dramc driver data
+ *
+ * Return the dramc driver data
+ */
+static struct dramc_dev_t *mtk_dramc_get_drvdata_by_ids(void)
+{
+	struct device_node *np;
+	struct platform_device *dramc_pdev;
+
+	np = of_find_matching_node_and_match(NULL, mtk_dramc_of_ids, NULL);
+	dramc_pdev = of_find_device_by_node(np);
+
+	if (!dramc_pdev)
+		return NULL;
+
+	return (struct dramc_dev_t *)platform_get_drvdata(dramc_pdev);
+}
+
+static ssize_t mr_show(struct device_driver *driver, char *buf)
+{
+	struct dramc_dev_t *dramc_dev_ptr;
+	struct mr_info_t *mr_info_ptr;
+	unsigned int i;
+	ssize_t ret;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return 0;
+
+	mr_info_ptr = dramc_dev_ptr->mr_info_ptr;
+
+	for (ret = 0, i = 0; i < dramc_dev_ptr->mr_cnt; i++) {
+		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+				"mr%d: 0x%x\n",
+				mr_info_ptr[i].mr_index,
+				mr_info_ptr[i].mr_value);
+		if (ret >= PAGE_SIZE)
+			return strlen(buf);
+	}
+
+	return strlen(buf);
+}
+
+static ssize_t mr4_show(struct device_driver *driver, char *buf)
+{
+	struct dramc_dev_t *dramc_dev_ptr;
+	unsigned int i;
+	ssize_t ret;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return 0;
+
+	for (ret = 0, i = 0; i < dramc_dev_ptr->channel_cnt; i++) {
+		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+				"mr4: ch%d 0x%x\n",
+				i, mtk_dramc_get_mr4(i));
+		if (ret >= PAGE_SIZE)
+			return strlen(buf);
+	}
+
+	return strlen(buf);
+}
+
+static ssize_t dram_data_rate_show(struct device_driver *driver, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "DRAM data rate = %d\n",
+			mtk_dramc_get_data_rate());
+}
+
+static DRIVER_ATTR_RO(mr);
+static DRIVER_ATTR_RO(mr4);
+static DRIVER_ATTR_RO(dram_data_rate);
+
+static int dramc_probe(struct platform_device *pdev)
+{
+	struct device_node *dramc_node = pdev->dev.of_node;
+	struct dramc_dev_t *dramc_dev_ptr;
+	const struct mtk_dramc_compatible *dev_comp;
+	struct resource *res;
+	unsigned int i, size;
+	int ret;
+
+	pr_info("%s: module probe.\n", __func__);
+
+	dramc_dev_ptr = devm_kmalloc(&pdev->dev,
+				     sizeof(struct dramc_dev_t),
+				     GFP_KERNEL);
+
+	dev_comp =
+		(struct mtk_dramc_compatible *)
+			of_device_get_match_data(&pdev->dev);
+
+	if (!dramc_dev_ptr)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(dramc_node,
+				   "mediatek,dram-type",
+				   &dramc_dev_ptr->dram_type);
+	if (ret) {
+		pr_info("%s: get dram_type fail\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(dramc_node,
+				   "mediatek,support-channel-cnt",
+				   &dramc_dev_ptr->support_channel_cnt);
+	if (ret) {
+		pr_info("%s: get support_channel_cnt fail\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(dramc_node,
+				   "mediatek,channel-cnt",
+				   &dramc_dev_ptr->channel_cnt);
+	if (ret) {
+		pr_info("%s: get channel_cnt fail\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(dramc_node,
+				   "mediatek,rank-cnt",
+				   &dramc_dev_ptr->rank_cnt);
+	if (ret) {
+		pr_info("%s: get rank_cnt fail\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(dramc_node,
+				   "mediatek,mr-cnt",
+				   &dramc_dev_ptr->mr_cnt);
+	if (ret) {
+		pr_info("%s: get mr_cnt fail\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(dramc_node,
+				   "mediatek,freq-cnt",
+				   &dramc_dev_ptr->freq_cnt);
+	if (ret) {
+		pr_info("%s: get freq_cnt fail\n", __func__);
+		return -EINVAL;
+	}
+
+	dramc_dev_ptr->mr4_dev_ptr = (void *)dev_comp->mr4;
+
+	pr_info("%s: %s(%d),%s(%d),%s(%d),%s(%d),%s(%d),%s(%d),%s(%s)\n",
+		__func__,
+		"dram_type", dramc_dev_ptr->dram_type,
+		"support_channel_cnt", dramc_dev_ptr->support_channel_cnt,
+		"channel_cnt", dramc_dev_ptr->channel_cnt,
+		"rank_cnt", dramc_dev_ptr->rank_cnt,
+		"mr_cnt", dramc_dev_ptr->mr_cnt,
+		"freq_cnt", dramc_dev_ptr->freq_cnt,
+		"mr4", (dramc_dev_ptr->mr4_dev_ptr) ? "true" : "false");
+
+	size = sizeof(unsigned int) * dramc_dev_ptr->rank_cnt;
+	dramc_dev_ptr->rank_size = devm_kmalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!(dramc_dev_ptr->rank_size))
+		return -ENOMEM;
+	ret = of_property_read_u32_array(dramc_node,
+					 "mediatek,rank-size",
+					 dramc_dev_ptr->rank_size,
+					 dramc_dev_ptr->rank_cnt);
+	if (ret) {
+		pr_info("%s: get rank_size fail\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dramc_dev_ptr->mr_cnt) {
+		size = sizeof(struct mr_info_t) * dramc_dev_ptr->mr_cnt;
+		dramc_dev_ptr->mr_info_ptr = devm_kmalloc(&pdev->dev,
+							  size,
+							  GFP_KERNEL);
+		if (!(dramc_dev_ptr->mr_info_ptr))
+			return -ENOMEM;
+		ret =
+		    of_property_read_u32_array(dramc_node,
+					       "mediatek,mr",
+					       (unsigned int *)dramc_dev_ptr->mr_info_ptr,
+					       size >> 2);
+		if (ret) {
+			pr_info("%s: get mr_info fail\n", __func__);
+			return -EINVAL;
+		}
+		for (i = 0; i < dramc_dev_ptr->mr_cnt; i++)
+			pr_info("%s: mr%d(%x)\n", __func__,
+				dramc_dev_ptr->mr_info_ptr[i].mr_index,
+				dramc_dev_ptr->mr_info_ptr[i].mr_value);
+	}
+
+	if (dramc_dev_ptr->freq_cnt) {
+		size = sizeof(unsigned int) * dramc_dev_ptr->freq_cnt * 2;
+		dramc_dev_ptr->freq_step =
+			devm_kmalloc(&pdev->dev, size, GFP_KERNEL);
+		if (!(dramc_dev_ptr->freq_step))
+			return -ENOMEM;
+		ret = of_property_read_u32_array(dramc_node,
+						 "mediatek,freq-step",
+						 dramc_dev_ptr->freq_step,
+						 dramc_dev_ptr->freq_cnt * 2);
+		if (ret) {
+			pr_info("%s: get freq_step fail\n", __func__);
+			return -EINVAL;
+		}
+	}
+
+	size = sizeof(phys_addr_t) * dramc_dev_ptr->support_channel_cnt;
+	dramc_dev_ptr->dramc_chn_base_ao = devm_kmalloc(&pdev->dev,
+							size, GFP_KERNEL);
+	if (!(dramc_dev_ptr->dramc_chn_base_ao))
+		return -ENOMEM;
+	dramc_dev_ptr->dramc_chn_base_nao = devm_kmalloc(&pdev->dev,
+							 size, GFP_KERNEL);
+	if (!(dramc_dev_ptr->dramc_chn_base_nao))
+		return -ENOMEM;
+	dramc_dev_ptr->ddrphy_chn_base_ao = devm_kmalloc(&pdev->dev,
+							 size, GFP_KERNEL);
+	if (!(dramc_dev_ptr->ddrphy_chn_base_ao))
+		return -ENOMEM;
+
+	for (i = 0; i < dramc_dev_ptr->support_channel_cnt; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		dramc_dev_ptr->dramc_chn_base_ao[i] =
+			devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(dramc_dev_ptr->dramc_chn_base_ao[i])) {
+			pr_info("%s: unable to map ch%d DRAMC AO base\n",
+				__func__, i);
+			return -EINVAL;
+		}
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM,
+					    i + dramc_dev_ptr->support_channel_cnt);
+		dramc_dev_ptr->dramc_chn_base_nao[i] =
+			devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(dramc_dev_ptr->dramc_chn_base_nao[i])) {
+			pr_info("%s: unable to map ch%d DRAMC NAO base\n",
+				__func__, i);
+			return -EINVAL;
+		}
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM,
+					    i + dramc_dev_ptr->support_channel_cnt * 2);
+		dramc_dev_ptr->ddrphy_chn_base_ao[i] =
+			devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(dramc_dev_ptr->ddrphy_chn_base_ao[i])) {
+			pr_info("%s: unable to map ch%d DDRPHY AO base\n",
+				__func__, i);
+			return -EINVAL;
+		}
+	}
+
+	dramc_dev_ptr->fmeter_dev_ptr = (void *)dev_comp->fmeter;
+
+	ret = driver_create_file(pdev->dev.driver,
+				 &driver_attr_dram_data_rate);
+	if (ret) {
+		pr_info("%s: fail to create dram_data_rate sysfs\n", __func__);
+		return ret;
+	}
+
+	ret = driver_create_file(pdev->dev.driver,
+				 &driver_attr_mr);
+	if (ret) {
+		pr_info("%s: fail to create mr sysfs\n", __func__);
+		return ret;
+	}
+
+	if (dramc_dev_ptr->mr4_dev_ptr) {
+		ret = driver_create_file(pdev->dev.driver,
+					 &driver_attr_mr4);
+		if (ret) {
+			pr_info("%s: fail to create mr4 sysfs\n", __func__);
+			return ret;
+		}
+	}
+
+	platform_set_drvdata(pdev, dramc_dev_ptr);
+	pr_info("%s: DRAM data type = %d\n", __func__,
+		mtk_dramc_get_ddr_type());
+
+	pr_info("%s: DRAM data clock rate = %d\n", __func__,
+		mtk_dramc_get_data_rate());
+
+	return ret;
+}
+
+/*
+ * mtk_dramc_get_steps_freq - get the data clock rate of target DVFS step
+ * @step: the step index of DVFS
+ *
+ * Return the DRAM spec data clock rate (MHz)
+ */
+int mtk_dramc_get_steps_freq(unsigned int step)
+{
+	struct dramc_dev_t *dramc_dev_ptr;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return -ENODEV;
+
+	if (step < dramc_dev_ptr->freq_cnt)
+		return dramc_dev_ptr->freq_step[step * 2 + 1];
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(mtk_dramc_get_steps_freq);
+
+/*
+ * decode_freq - decode the spec data clock rate
+ * @vco_freq: real data clock rate
+ *
+ * Return the DRAM spec data clock rate (MHz)
+ */
+static unsigned int decode_freq(unsigned int vco_freq)
+{
+	int i;
+	struct dramc_dev_t *dramc_dev_ptr;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return 0;
+
+	for (i = 0; i < dramc_dev_ptr->freq_cnt * 2; i += 2)
+		if (vco_freq == dramc_dev_ptr->freq_step[i])
+			return dramc_dev_ptr->freq_step[i + 1];
+
+	return vco_freq;
+}
+
+static unsigned int fmeter_v0(struct dramc_dev_t *dramc_dev_ptr)
+{
+	struct fmeter_dev_t *fmeter_dev_ptr =
+		(struct fmeter_dev_t *)dramc_dev_ptr->fmeter_dev_ptr;
+	unsigned int shu_lv_val;
+	unsigned int pll_id_val;
+	unsigned int pll_md_val;
+	unsigned int sdmpcw_val;
+	unsigned int prediv_val;
+	unsigned int posdiv_val;
+	unsigned int ckdiv4_val;
+	unsigned int cldiv2_val;
+	unsigned int offset;
+	unsigned int vco_freq;
+
+	shu_lv_val = (readl(dramc_dev_ptr->dramc_chn_base_ao[0] +
+		fmeter_dev_ptr->shu_lv.offset) &
+		fmeter_dev_ptr->shu_lv.mask) >>
+		fmeter_dev_ptr->shu_lv.shift;
+
+	pll_id_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] +
+		fmeter_dev_ptr->pll_id.offset) &
+		fmeter_dev_ptr->pll_id.mask) >>
+		fmeter_dev_ptr->pll_id.shift;
+
+	offset = fmeter_dev_ptr->pll_md[pll_id_val].offset +
+		fmeter_dev_ptr->shu_of * shu_lv_val;
+	pll_md_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] + offset) &
+		fmeter_dev_ptr->pll_md[pll_id_val].mask) >>
+		fmeter_dev_ptr->pll_md[pll_id_val].shift;
+
+	offset = fmeter_dev_ptr->sdmpcw[pll_id_val].offset +
+		fmeter_dev_ptr->shu_of * shu_lv_val;
+	sdmpcw_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] + offset) &
+		fmeter_dev_ptr->sdmpcw[pll_id_val].mask) >>
+		fmeter_dev_ptr->sdmpcw[pll_id_val].shift;
+
+	offset = fmeter_dev_ptr->prediv[pll_id_val].offset +
+		fmeter_dev_ptr->shu_of * shu_lv_val;
+	prediv_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] + offset) &
+		fmeter_dev_ptr->prediv[pll_id_val].mask) >>
+		fmeter_dev_ptr->prediv[pll_id_val].shift;
+
+	offset = fmeter_dev_ptr->posdiv[pll_id_val].offset +
+		fmeter_dev_ptr->shu_of * shu_lv_val;
+	posdiv_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] + offset) &
+		fmeter_dev_ptr->posdiv[pll_id_val].mask) >>
+		fmeter_dev_ptr->posdiv[pll_id_val].shift;
+
+	offset = fmeter_dev_ptr->ckdiv4[pll_id_val].offset +
+		fmeter_dev_ptr->shu_of * shu_lv_val;
+	ckdiv4_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] + offset) &
+		fmeter_dev_ptr->ckdiv4[pll_id_val].mask) >>
+		fmeter_dev_ptr->ckdiv4[pll_id_val].shift;
+
+	offset = fmeter_dev_ptr->cldiv2[pll_id_val].offset +
+		fmeter_dev_ptr->shu_of * shu_lv_val;
+	cldiv2_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] + offset) &
+		fmeter_dev_ptr->cldiv2[pll_id_val].mask) >>
+		fmeter_dev_ptr->cldiv2[pll_id_val].shift;
+
+	vco_freq = ((fmeter_dev_ptr->crystal_freq >> prediv_val) *
+		(sdmpcw_val >> 8)) >>
+		posdiv_val >> ckdiv4_val >> pll_md_val >> cldiv2_val;
+
+	return decode_freq(vco_freq);
+}
+
+/*
+ * mtk_dramc_get_data_rate - calculate DRAM data rate
+ *
+ * Return DRAM data rate (MB/s)
+ */
+unsigned int mtk_dramc_get_data_rate(void)
+{
+	struct dramc_dev_t *dramc_dev_ptr;
+	struct fmeter_dev_t *fmeter_dev_ptr;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return 0;
+
+	fmeter_dev_ptr = (struct fmeter_dev_t *)dramc_dev_ptr->fmeter_dev_ptr;
+	if (!fmeter_dev_ptr)
+		return 0;
+
+	return fmeter_v0(dramc_dev_ptr);
+}
+EXPORT_SYMBOL(mtk_dramc_get_data_rate);
+
+static unsigned int mr4_v1(struct dramc_dev_t *dramc_dev_ptr, unsigned int ch)
+{
+	struct mr4_dev_t *mr4_dev_ptr =
+		(struct mr4_dev_t *)dramc_dev_ptr->mr4_dev_ptr;
+
+	return (readl(dramc_dev_ptr->dramc_chn_base_nao[ch] +
+		mr4_dev_ptr->mr4_rg.offset) & mr4_dev_ptr->mr4_rg.mask) >>
+		mr4_dev_ptr->mr4_rg.shift;
+}
+
+/*
+ * mtk_dramc_get_mr4 - get the DRAM MR4 value of specific DRAM channel
+ * @ch:	the channel index
+ *
+ * Return the MR4 value
+ */
+unsigned int mtk_dramc_get_mr4(unsigned int ch)
+{
+	struct dramc_dev_t *dramc_dev_ptr;
+	struct mr4_dev_t *mr4_dev_ptr;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return 0;
+
+	mr4_dev_ptr = (struct mr4_dev_t *)dramc_dev_ptr->mr4_dev_ptr;
+	if (!mr4_dev_ptr)
+		return 0;
+
+	if (ch >= dramc_dev_ptr->channel_cnt)
+		return 0;
+
+	return mr4_v1(dramc_dev_ptr, ch);
+}
+EXPORT_SYMBOL(mtk_dramc_get_mr4);
+
+/*
+ * mtk_dramc_get_ddr_type - get DRAM type
+ *
+ * Return the DRAM type
+ */
+unsigned int mtk_dramc_get_ddr_type(void)
+{
+	struct dramc_dev_t *dramc_dev_ptr;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return 0;
+
+	return dramc_dev_ptr->dram_type;
+}
+EXPORT_SYMBOL(mtk_dramc_get_ddr_type);
+
+/*
+ * mtk_dramc_get_channel_count - get DRAM channel count
+ *
+ * Return the DRAM channel count
+ */
+unsigned int mtk_dramc_get_channel_count(void)
+{
+	struct dramc_dev_t *dramc_dev_ptr;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return 0;
+
+	return dramc_dev_ptr->channel_cnt;
+}
+EXPORT_SYMBOL(mtk_dramc_get_channel_count);
+
+/*
+ * mtk_dramc_get_rank_count - get DRAM rank count
+ *
+ * Return the DRAM rank count
+ */
+unsigned int mtk_dramc_get_rank_count(void)
+{
+	struct dramc_dev_t *dramc_dev_ptr;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return 0;
+
+	return dramc_dev_ptr->rank_cnt;
+}
+EXPORT_SYMBOL(mtk_dramc_get_rank_count);
+
+/*
+ * mtk_dramc_get_rank_size - get size of DRAM rank
+ *
+ * Return the size of specific DRAM rank
+ */
+unsigned int mtk_dramc_get_rank_size(unsigned int rank)
+{
+	struct dramc_dev_t *dramc_dev_ptr;
+
+	dramc_dev_ptr = mtk_dramc_get_drvdata_by_ids();
+
+	if (!dramc_dev_ptr)
+		return 0;
+
+	if (rank < dramc_dev_ptr->rank_cnt)
+		return dramc_dev_ptr->rank_size[rank];
+	else
+		return 0;
+}
+EXPORT_SYMBOL(mtk_dramc_get_rank_size);
+
+static int dramc_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver dramc_drv = {
+	.probe = dramc_probe,
+	.remove = dramc_remove,
+	.driver = {
+		.name = DRAMC_DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = mtk_dramc_of_ids,
+	},
+};
+
+static int __init dramc_drv_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&dramc_drv);
+	if (ret) {
+		pr_info("%s: init fail, ret 0x%x\n", __func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void __exit dramc_drv_exit(void)
+{
+	platform_driver_unregister(&dramc_drv);
+}
+
+module_init(dramc_drv_init);
+module_exit(dramc_drv_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MediaTek DRAMC Driver");
+MODULE_AUTHOR("Po-Kai Chi <pk.chi@mediatek.com>");
diff --git a/include/memory/mediatek/dramc.h b/include/memory/mediatek/dramc.h
new file mode 100644
index 0000000..c8d200f
--- /dev/null
+++ b/include/memory/mediatek/dramc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef __DRAMC_H__
+#define __DRAMC_H__
+
+int mtk_dramc_get_steps_freq(unsigned int step);
+unsigned int mtk_dramc_get_ddr_type(void);
+unsigned int mtk_dramc_get_data_rate(void);
+unsigned int mtk_dramc_get_mr4(unsigned int ch);
+unsigned int mtk_dramc_get_channel_count(void);
+unsigned int mtk_dramc_get_rank_count(void);
+unsigned int mtk_dramc_get_rank_size(unsigned int rk);
+
+#endif /* __DRAMC_H__ */
+
-- 
1.7.9.5

