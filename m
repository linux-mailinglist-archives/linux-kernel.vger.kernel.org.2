Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E760425318
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbhJGMeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:34:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34868 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241222AbhJGMd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:33:59 -0400
X-UUID: d963edc9d5364ad49636f68155f4c689-20211007
X-UUID: d963edc9d5364ad49636f68155f4c689-20211007
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1390015297; Thu, 07 Oct 2021 20:32:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Oct 2021 20:32:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Oct 2021 20:32:02 +0800
From:   Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Subject: [PATCH] mailbox: mediatek: add support for dsp ipc
Date:   Thu, 7 Oct 2021 20:32:00 +0800
Message-ID: <20211007123200.16857-1-Allen-KH.Cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for Mediatek DSP IPC which allows applications
implement communication using mbox.

Two mailboxes used to send notification or short message
between processors with dsp

mbox0 is for ipc request.
mbox1 is for ipc reply.

Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
---
 drivers/mailbox/Kconfig            |  10 ++
 drivers/mailbox/Makefile           |   2 +
 drivers/mailbox/mtk-adsp-mailbox.c | 209 +++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/mailbox/mtk-adsp-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c9fc06c7e685..4435af555b63 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -236,6 +236,16 @@ config MTK_CMDQ_MBOX
 	  critical time limitation, such as updating display configuration
 	  during the vblank.
 
+config MTK_ADSP_IPC_MBOX
+	tristate "MediaTek ADSP Mailbox Support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  Say yes here to add support for ADSP IPC mailbox driver.
+	  This mailbox driver is used to send notification or short message
+	  between processors with dsp. It will place the
+	  message to the share buffer and will access the ADSP mailbox
+	  registers to kick dsp.
+
 config ZYNQMP_IPI_MBOX
 	bool "Xilinx ZynqMP IPI Mailbox"
 	depends on ARCH_ZYNQMP && OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c2089f04887e..479a9ae56d5e 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -51,6 +51,8 @@ obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
 
 obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
 
+obj-$(CONFIG_MTK_ADSP_IPC_MBOX)	+= mtk-adsp-mailbox.o
+
 obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
 
 obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
diff --git a/drivers/mailbox/mtk-adsp-mailbox.c b/drivers/mailbox/mtk-adsp-mailbox.c
new file mode 100644
index 000000000000..120e1be39118
--- /dev/null
+++ b/drivers/mailbox/mtk-adsp-mailbox.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Corporation. All rights reserved.
+ * Author: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
+ */
+
+#include <linux/firmware/mediatek/mtk-adsp-ipc.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+
+/* adsp mbox register offset */
+#define MTK_ADSP_MBOX_IN_CMD 0x00
+#define MTK_ADSP_MBOX_IN_CMD_CLR 0x04
+#define MTK_ADSP_MBOX_OUT_CMD 0x1c
+#define MTK_ADSP_MBOX_OUT_CMD_CLR 0x20
+#define MTK_ADSP_MBOX_IN_MSG0 0x08
+#define MTK_ADSP_MBOX_IN_MSG1 0x0C
+#define MTK_ADSP_MBOX_OUT_MSG0 0x24
+#define MTK_ADSP_MBOX_OUT_MSG1 0x28
+
+struct mtk_adsp_mbox_priv {
+	struct device *dev;
+	struct mbox_controller mbox;
+	phys_addr_t pa_mboxreg[MTK_ADSP_MBOX_NUM];
+	void __iomem *va_mboxreg[MTK_ADSP_MBOX_NUM];
+};
+
+static irqreturn_t mtk_adsp_ipc_irq_handler(int irq, void *data)
+{
+	struct mbox_chan *ch = (struct mbox_chan *)data;
+	struct adsp_mbox_ch_info *ch_info = ch->con_priv;
+	void __iomem *reg = ch_info->va_reg[ch_info->id];
+	u32 op = readl(reg + MTK_ADSP_MBOX_OUT_CMD);
+
+	writel(op, reg + MTK_ADSP_MBOX_OUT_CMD_CLR);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t mtk_adsp_ipc_handler(int irq, void *data)
+{
+	struct mbox_chan *ch = (struct mbox_chan *)data;
+	struct adsp_mbox_ch_info *ch_info = ch->con_priv;
+
+	mbox_chan_received_data(ch, ch_info);
+
+	return IRQ_HANDLED;
+}
+
+static struct mbox_chan *mtk_adsp_mbox_xlate(struct mbox_controller *mbox,
+					     const struct of_phandle_args *sp)
+{
+	return &mbox->chans[sp->args[0]];
+}
+
+static int mtk_adsp_mbox_startup(struct mbox_chan *chan)
+{
+	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
+	struct platform_device *pdev;
+	struct device *dev = chan->mbox->dev;
+	char *name;
+	int ret;
+	int irq;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	name = kasprintf(GFP_KERNEL, "irq_mbox%d", ch_info->id);
+	if (!name) {
+		dev_err(dev, "mtk adsp mbox startup mbox%d %s\n", ch_info->id, name);
+		return -ENOMEM;
+	}
+
+	irq = platform_get_irq_byname(pdev, name);
+	if (irq < 0) {
+		dev_err(dev, "Failed to get ipc irq\n");
+		ret = -ENODEV;
+		goto err_name_free;
+	}
+
+	ret = devm_request_threaded_irq(dev, irq,
+					mtk_adsp_ipc_irq_handler, mtk_adsp_ipc_handler,
+					IRQF_TRIGGER_NONE, name,
+					chan);
+	if (ret < 0)
+		dev_err(dev, "failed to request irq %d\n", irq);
+
+err_name_free:
+	kfree(name);
+	return ret;
+}
+
+static void mtk_adsp_mbox_shutdown(struct mbox_chan *chan)
+{
+	chan->con_priv = NULL;
+}
+
+static int mtk_adsp_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
+	void __iomem *reg = ch_info->va_reg[ch_info->id];
+
+	spin_lock(&ch_info->lock);
+	writel(ch_info->ipc_op_val, reg + MTK_ADSP_MBOX_IN_CMD);
+	spin_unlock(&ch_info->lock);
+
+	return 0;
+}
+
+static bool mtk_adsp_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
+	u32 id = ch_info->id;
+	void __iomem *reg = ch_info->va_reg[id];
+	u32 op = readl(reg + MTK_ADSP_MBOX_IN_CMD);
+
+	return (op == 0) ? true : false;
+}
+
+static const struct mbox_chan_ops adsp_mbox_chan_ops = {
+	.send_data	= mtk_adsp_mbox_send_data,
+	.startup	= mtk_adsp_mbox_startup,
+	.shutdown	= mtk_adsp_mbox_shutdown,
+	.last_tx_done	= mtk_adsp_mbox_last_tx_done,
+};
+
+static int mtk_adsp_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mbox_controller *mbox;
+	struct mtk_adsp_mbox_priv *priv;
+	struct resource *res;
+	char *name;
+	int ret;
+	int i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mbox = &priv->mbox;
+	mbox->dev = dev;
+	mbox->ops = &adsp_mbox_chan_ops;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = true;
+	mbox->of_xlate = mtk_adsp_mbox_xlate;
+	mbox->num_chans = MTK_ADSP_MBOX_NUM;
+	mbox->chans = devm_kcalloc(mbox->dev, mbox->num_chans,
+				   sizeof(*mbox->chans), GFP_KERNEL);
+	if (!mbox->chans)
+		return -ENOMEM;
+
+	for (i = 0; i < mbox->num_chans; i++) {
+		struct adsp_mbox_ch_info *ch_info;
+
+		name = kasprintf(GFP_KERNEL, "reg_mbox%d", i);
+		/* parse adsp mbox base */
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+		if (!res) {
+			dev_err(dev, "no MBOX resource %s\n", name);
+			return -ENXIO;
+		}
+
+		priv->pa_mboxreg[i] = (phys_addr_t)res->start;
+		priv->va_mboxreg[i] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(priv->va_mboxreg[i]))
+			return PTR_ERR(priv->va_mboxreg[i]);
+
+		/* set adsp mbox channel info */
+		ch_info = devm_kzalloc(mbox->dev, sizeof(*ch_info), GFP_KERNEL);
+		if (!ch_info)
+			return -ENOMEM;
+
+		spin_lock_init(&ch_info->lock);
+		ch_info->id = i;
+		ch_info->va_reg[i] = priv->va_mboxreg[i];
+		mbox->chans[i].con_priv = ch_info;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	ret = devm_mbox_controller_register(dev, &priv->mbox);
+	if (ret < 0)
+		dev_err(dev, "error: failed to register mailbox:%d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id mtk_adsp_mbox_of_match[] = {
+	{ .compatible = "mediatek,mt8195-adsp-mbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_adsp_mbox_of_match);
+
+static struct platform_driver mtk_adsp_ipc_mbox_driver = {
+	.probe		= mtk_adsp_mbox_probe,
+	.driver = {
+		.name	= "mtk_adsp_mbox",
+		.of_match_table = mtk_adsp_mbox_of_match,
+	},
+};
+module_platform_driver(mtk_adsp_ipc_mbox_driver);
+
+MODULE_AUTHOR("Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>");
+MODULE_DESCRIPTION("MTK ADSP mailbox IPC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

