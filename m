Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B352438F59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJYGYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:24:44 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51661 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhJYGYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:24:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6E6F05806AD;
        Mon, 25 Oct 2021 02:22:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 25 Oct 2021 02:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=C0LxjyvMyjTS4
        2kmASyV0LxewxdqJVQX9aZ28ukpBeg=; b=HmLRczG6PbinV4Ee3/CCfaFt4Qdl5
        BZltdLy4aNwtQWL4A3IFt6s0dzRmFYsb6gzzMdlm8wpQ1UkpTU1NxZIER97r48a6
        wlrM4HrA1d3JkVDtk7/+6E7JRQdVEW0rC8Z7kMemeo3sWGiaPdNQnLU8kPeqm1/I
        a8JsnTwzC2VGI5a21X2+0erChorH9Xp7tqsCJVDgCn156m/uvRt8VJFa912+vFCZ
        o8/nZbeAM88WDJ2dn3/Ebv+Ybsy4SxeDKRj90PU0M0npOXFZXm02z5MV0rbBAAZ+
        bCyxa2g+tiCuepDsBC1CDiIRxUwVjZ9+mBJEHaMwA9St5sRMtG35LcNEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=C0LxjyvMyjTS42kmASyV0LxewxdqJVQX9aZ28ukpBeg=; b=HwigbDwv
        ALxD/axgNMDScxFhRQpo30c/HW0tdcDOqbG3s76sA9sytfv1lERHAKze8vmB05vd
        h3x/tPBWd4utBQn+WE6hqM4ReTRWyGRMQ6SfsrzYryB8PZ6ymCYdOmsvyNWhyvoP
        /EqrfLeFPHhBwErK20SRVN6rmNyF8EfRrZdil/CHhtvw9ft8FyZU+EdSXjz3km0k
        4U8oo6XDXXb+OfzR8f8OplEFJyDVD6AZc36JRBGl/TW9IMYoN84t27TxjEEYk07h
        kepVQ44d4BfXj+hhvfjiEcnv/wkHTKtFOQnrmsfgklq7f4jxOptFbOOk+CZK05j3
        CU6o/Ff6zm6ifg==
X-ME-Sender: <xms:G012YVavkfC3UVqDOQy5SMd2sHGReTcCXLQ70lvZ7iTgZtnkZucO5w>
    <xme:G012YcYHzdD17FSyDYjZbQCJuIPL8zOf2KQWByYabxj2Y-vk87vvuSZlY04MLatKE
    0_Iq5mTuW6L5l9ox3U>
X-ME-Received: <xmr:G012YX-LMPKlotZpQGbDsJTb0IUzywYt0kG7Anlx5wTp5zhqoTDiOEIBzjfOv_VkYqYvsulEahvWxa2fhOivMaF7rNfArFxgxihtGddQeYN1CWlaN2rM_Fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefgedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:G012YTrr9rvNORpY6-7zMa7YlhgsCTLKBYa1Ki8tjsM19Xz_m-QqUg>
    <xmx:G012YQoINEFeNne3cJZcNAiMNWZyIRf8wxvRWVTUt5qvpRkl9KuORw>
    <xmx:G012YZQEfxh8557OouL9tUVkioyzDnsOJCDhKxgpFfame12OqO3Pmg>
    <xmx:G012YX1O5RqegAoIHLe1Y47IIjrMb9S5u_h-Ilv3SsY_yAoFiawijg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 02:22:17 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] mailbox: apple: Add driver for Apple mailboxes
Date:   Mon, 25 Oct 2021 08:22:04 +0200
Message-Id: <20211025062204.1517-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211025062204.1517-1-sven@svenpeter.dev>
References: <20211025062204.1517-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs such as the M1 come with various co-processors. Mailboxes
are used to communicate with those. This driver adds support for
two variants of those mailboxes.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/mailbox/Kconfig         |  12 +
 drivers/mailbox/Makefile        |   2 +
 drivers/mailbox/apple-mailbox.c | 384 ++++++++++++++++++++++++++++++++
 include/linux/apple-mailbox.h   |  19 ++
 4 files changed, 417 insertions(+)
 create mode 100644 drivers/mailbox/apple-mailbox.c
 create mode 100644 include/linux/apple-mailbox.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c9fc06c7e685..d9cd3606040e 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -8,6 +8,18 @@ menuconfig MAILBOX
 
 if MAILBOX
 
+config APPLE_MAILBOX
+	tristate "Apple Mailbox driver"
+	depends on ARCH_APPLE || (ARM64 && COMPILE_TEST)
+	default ARCH_APPLE
+	help
+	  Apple SoCs have various co-processors required for certain
+	  peripherals to work (NVMe, display controller, etc.). This
+	  driver adds support for the mailbox controller used to
+	  communicate with those.
+
+	  Say Y here if you have a Apple SoC.
+
 config ARM_MHU
 	tristate "ARM MHU Mailbox"
 	depends on ARM_AMBA
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c2089f04887e..338cc05e5431 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -58,3 +58,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
+
+obj-$(CONFIG_APPLE_MAILBOX)	+= apple-mailbox.o
diff --git a/drivers/mailbox/apple-mailbox.c b/drivers/mailbox/apple-mailbox.c
new file mode 100644
index 000000000000..72942002a54a
--- /dev/null
+++ b/drivers/mailbox/apple-mailbox.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple mailbox driver
+ *
+ * Copyright (C) 2021 The Asahi Linux Contributors
+ *
+ * This driver adds support for two mailbox variants (called ASC and M3 by
+ * Apple) found in Apple SoCs such as the M1. It consists of two FIFOs used to
+ * exchange 64+32 bit messages between the main CPU and a co-processor.
+ * Various coprocessors implement different IPC protocols based on these simple
+ * messages and shared memory buffers.
+ *
+ * Both the main CPU and the co-processor see the same set of registers but
+ * the first FIFO (A2I) is always used to transfer messages from the application
+ * processor (us) to the I/O processor and the second one (I2A) for the
+ * other direction.
+ */
+
+#include <linux/apple-mailbox.h>
+#include <linux/device.h>
+#include <linux/gfp.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#define APPLE_ASC_MBOX_CONTROL_FULL  BIT(16)
+#define APPLE_ASC_MBOX_CONTROL_EMPTY BIT(17)
+
+#define APPLE_ASC_MBOX_A2I_CONTROL 0x110
+#define APPLE_ASC_MBOX_A2I_SEND0   0x800
+#define APPLE_ASC_MBOX_A2I_SEND1   0x808
+#define APPLE_ASC_MBOX_A2I_RECV0   0x810
+#define APPLE_ASC_MBOX_A2I_RECV1   0x818
+
+#define APPLE_ASC_MBOX_I2A_CONTROL 0x114
+#define APPLE_ASC_MBOX_I2A_SEND0   0x820
+#define APPLE_ASC_MBOX_I2A_SEND1   0x828
+#define APPLE_ASC_MBOX_I2A_RECV0   0x830
+#define APPLE_ASC_MBOX_I2A_RECV1   0x838
+
+#define APPLE_M3_MBOX_CONTROL_FULL  BIT(16)
+#define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
+
+#define APPLE_M3_MBOX_A2I_CONTROL 0x50
+#define APPLE_M3_MBOX_A2I_SEND0	  0x60
+#define APPLE_M3_MBOX_A2I_SEND1	  0x68
+#define APPLE_M3_MBOX_A2I_RECV0	  0x70
+#define APPLE_M3_MBOX_A2I_RECV1	  0x78
+
+#define APPLE_M3_MBOX_I2A_CONTROL 0x80
+#define APPLE_M3_MBOX_I2A_SEND0	  0x90
+#define APPLE_M3_MBOX_I2A_SEND1	  0x98
+#define APPLE_M3_MBOX_I2A_RECV0	  0xa0
+#define APPLE_M3_MBOX_I2A_RECV1	  0xa8
+
+#define APPLE_M3_MBOX_IRQ_ENABLE	0x48
+#define APPLE_M3_MBOX_IRQ_ACK		0x4c
+#define APPLE_M3_MBOX_IRQ_A2I_EMPTY	BIT(0)
+#define APPLE_M3_MBOX_IRQ_A2I_NOT_EMPTY BIT(1)
+#define APPLE_M3_MBOX_IRQ_I2A_EMPTY	BIT(2)
+#define APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY BIT(3)
+
+#define APPLE_MBOX_MSG1_OUTCNT GENMASK(56, 52)
+#define APPLE_MBOX_MSG1_INCNT  GENMASK(51, 48)
+#define APPLE_MBOX_MSG1_OUTPTR GENMASK(47, 44)
+#define APPLE_MBOX_MSG1_INPTR  GENMASK(43, 40)
+#define APPLE_MBOX_MSG1_MSG    GENMASK(31, 0)
+
+struct apple_mbox_hw {
+	unsigned int control_full;
+	unsigned int control_empty;
+
+	unsigned int a2i_control;
+	unsigned int a2i_send0;
+	unsigned int a2i_send1;
+
+	unsigned int i2a_control;
+	unsigned int i2a_recv0;
+	unsigned int i2a_recv1;
+
+	bool has_irq_controls;
+	unsigned int irq_enable;
+	unsigned int irq_ack;
+	unsigned int irq_bit_recv_not_empty;
+	unsigned int irq_bit_send_empty;
+};
+
+struct apple_mbox {
+	void __iomem *regs;
+	const struct apple_mbox_hw *hw;
+
+	int irq_recv_not_empty;
+	int irq_send_empty;
+
+	struct mbox_chan chan;
+
+	struct device *dev;
+	struct mbox_controller controller;
+};
+
+static const struct of_device_id apple_mbox_of_match[];
+
+static bool apple_mbox_hw_can_send(struct apple_mbox *apple_mbox)
+{
+	u32 mbox_ctrl =
+		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
+
+	return !(mbox_ctrl & apple_mbox->hw->control_full);
+}
+
+static int apple_mbox_hw_send(struct apple_mbox *apple_mbox,
+			      struct apple_mbox_msg *msg)
+{
+	if (!apple_mbox_hw_can_send(apple_mbox))
+		return -EBUSY;
+
+	dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg->msg1);
+
+	writeq_relaxed(msg->msg0, apple_mbox->regs + apple_mbox->hw->a2i_send0);
+	writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg->msg1),
+		       apple_mbox->regs + apple_mbox->hw->a2i_send1);
+
+	return 0;
+}
+
+static bool apple_mbox_hw_can_recv(struct apple_mbox *apple_mbox)
+{
+	u32 mbox_ctrl =
+		readl_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_control);
+
+	return !(mbox_ctrl & apple_mbox->hw->control_empty);
+}
+
+static int apple_mbox_hw_recv(struct apple_mbox *apple_mbox,
+			      struct apple_mbox_msg *msg)
+{
+	if (!apple_mbox_hw_can_recv(apple_mbox))
+		return -ENOMSG;
+
+	msg->msg0 = readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv0);
+	msg->msg1 = FIELD_GET(
+		APPLE_MBOX_MSG1_MSG,
+		readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv1));
+
+	dev_dbg(apple_mbox->dev, "< RX %016llx %08x\n", msg->msg0, msg->msg1);
+
+	return 0;
+}
+
+static int apple_mbox_chan_send_data(struct mbox_chan *chan, void *data)
+{
+	struct apple_mbox *apple_mbox = chan->con_priv;
+	struct apple_mbox_msg *msg = data;
+	int ret;
+
+	ret = apple_mbox_hw_send(apple_mbox, msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * The interrupt is level triggered and will keep firing as long as the
+	 * FIFO is empty. It will also keep firing if the FIFO was empty
+	 * at any point in the past until it has been acknowledged at the
+	 * mailbox level. By acknowledging it here we can ensure that we will
+	 * only get the interrupt once the FIFO has been cleared again.
+	 * If the FIFO is already empty before the ack it will fire again
+	 * immediately after the ack.
+	 */
+	if (apple_mbox->hw->has_irq_controls) {
+		writel_relaxed(apple_mbox->hw->irq_bit_send_empty,
+			       apple_mbox->regs + apple_mbox->hw->irq_ack);
+	}
+	enable_irq(apple_mbox->irq_send_empty);
+
+	return 0;
+}
+
+static irqreturn_t apple_mbox_send_empty_irq(int irq, void *data)
+{
+	struct apple_mbox *apple_mbox = data;
+
+	/*
+	 * We don't need to acknowledge the interrupt at the mailbox level
+	 * here even if supported by the hardware. It will keep firing but that
+	 * doesn't matter since it's disabled at the main interrupt controller.
+	 * apple_mbox_chan_send_data will acknowledge it before enabling
+	 * it at the main controller again.
+	 */
+	disable_irq_nosync(apple_mbox->irq_send_empty);
+	mbox_chan_txdone(&apple_mbox->chan, 0);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
+{
+	struct apple_mbox *apple_mbox = data;
+	struct apple_mbox_msg msg;
+
+	while (apple_mbox_hw_recv(apple_mbox, &msg) == 0)
+		mbox_chan_received_data(&apple_mbox->chan, (void *)&msg);
+
+	/*
+	 * The interrupt will keep firing even if there are no more messages
+	 * unless we also acknowledge it at the mailbox level here.
+	 * There's no race if a message comes in between the check in the while
+	 * loop above and the ack below: If a new messages arrives inbetween
+	 * those two the interrupt will just fire again immediately after the
+	 * ack since it's level triggered.
+	 */
+	if (apple_mbox->hw->has_irq_controls) {
+		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty,
+			       apple_mbox->regs + apple_mbox->hw->irq_ack);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int apple_mbox_chan_startup(struct mbox_chan *chan)
+{
+	struct apple_mbox *apple_mbox = chan->con_priv;
+
+	/*
+	 * Only some variants of this mailbox HW provide interrupt control
+	 * at the mailbox level. We therefore need to handle enabling/disabling
+	 * interrupts at the main interrupt controller anyway for hardware that
+	 * doesn't. Just always keep the interrupts we care about enabled at
+	 * the mailbox level so that both hardware revisions behave almost
+	 * the same.
+	 */
+	if (apple_mbox->hw->has_irq_controls) {
+		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty |
+				       apple_mbox->hw->irq_bit_send_empty,
+			       apple_mbox->regs + apple_mbox->hw->irq_enable);
+	}
+
+	enable_irq(apple_mbox->irq_recv_not_empty);
+	return 0;
+}
+
+static void apple_mbox_chan_shutdown(struct mbox_chan *chan)
+{
+	struct apple_mbox *apple_mbox = chan->con_priv;
+
+	disable_irq(apple_mbox->irq_recv_not_empty);
+}
+
+static const struct mbox_chan_ops apple_mbox_ops = {
+	.send_data = apple_mbox_chan_send_data,
+	.startup = apple_mbox_chan_startup,
+	.shutdown = apple_mbox_chan_shutdown,
+};
+
+static struct mbox_chan *apple_mbox_of_xlate(struct mbox_controller *mbox,
+					     const struct of_phandle_args *args)
+{
+	if (args->args_count != 0)
+		return ERR_PTR(-EINVAL);
+
+	return &mbox->chans[0];
+}
+
+static int apple_mbox_probe(struct platform_device *pdev)
+{
+	int ret;
+	const struct of_device_id *match;
+	char *irqname;
+	struct apple_mbox *mbox;
+	struct device *dev = &pdev->dev;
+
+	match = of_match_node(apple_mbox_of_match, pdev->dev.of_node);
+	if (!match)
+		return -EINVAL;
+	if (!match->data)
+		return -EINVAL;
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, mbox);
+
+	mbox->dev = dev;
+	mbox->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mbox->regs))
+		return PTR_ERR(mbox->regs);
+
+	mbox->hw = match->data;
+	mbox->irq_recv_not_empty =
+		platform_get_irq_byname(pdev, "recv-not-empty");
+	if (mbox->irq_recv_not_empty < 0)
+		return -ENODEV;
+
+	mbox->irq_send_empty = platform_get_irq_byname(pdev, "send-empty");
+	if (mbox->irq_send_empty < 0)
+		return -ENODEV;
+
+	mbox->controller.dev = mbox->dev;
+	mbox->controller.num_chans = 1;
+	mbox->controller.chans = &mbox->chan;
+	mbox->controller.ops = &apple_mbox_ops;
+	mbox->controller.txdone_irq = true;
+	mbox->controller.of_xlate = apple_mbox_of_xlate;
+	mbox->chan.con_priv = mbox;
+
+	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-recv", dev_name(dev));
+	if (!irqname)
+		return -ENOMEM;
+
+	ret = devm_request_threaded_irq(dev, mbox->irq_recv_not_empty, NULL,
+					apple_mbox_recv_irq,
+					IRQF_NO_AUTOEN | IRQF_ONESHOT, irqname,
+					mbox);
+	if (ret)
+		return ret;
+
+	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-send", dev_name(dev));
+	if (!irqname)
+		return -ENOMEM;
+
+	ret = devm_request_irq(dev, mbox->irq_send_empty,
+			       apple_mbox_send_empty_irq, IRQF_NO_AUTOEN,
+			       irqname, mbox);
+	if (ret)
+		return ret;
+
+	return devm_mbox_controller_register(dev, &mbox->controller);
+}
+
+static const struct apple_mbox_hw apple_mbox_asc_hw = {
+	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
+	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
+
+	.a2i_control = APPLE_ASC_MBOX_A2I_CONTROL,
+	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
+	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
+
+	.i2a_control = APPLE_ASC_MBOX_I2A_CONTROL,
+	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
+	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
+
+	.has_irq_controls = false,
+};
+
+static const struct apple_mbox_hw apple_mbox_m3_hw = {
+	.control_full = APPLE_M3_MBOX_CONTROL_FULL,
+	.control_empty = APPLE_M3_MBOX_CONTROL_EMPTY,
+
+	.a2i_control = APPLE_M3_MBOX_A2I_CONTROL,
+	.a2i_send0 = APPLE_M3_MBOX_A2I_SEND0,
+	.a2i_send1 = APPLE_M3_MBOX_A2I_SEND1,
+
+	.i2a_control = APPLE_M3_MBOX_I2A_CONTROL,
+	.i2a_recv0 = APPLE_M3_MBOX_I2A_RECV0,
+	.i2a_recv1 = APPLE_M3_MBOX_I2A_RECV1,
+
+	.has_irq_controls = true,
+	.irq_enable = APPLE_M3_MBOX_IRQ_ENABLE,
+	.irq_ack = APPLE_M3_MBOX_IRQ_ACK,
+	.irq_bit_recv_not_empty = APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY,
+	.irq_bit_send_empty = APPLE_M3_MBOX_IRQ_A2I_EMPTY,
+};
+
+static const struct of_device_id apple_mbox_of_match[] = {
+	{ .compatible = "apple,t8103-asc-mailbox", .data = &apple_mbox_asc_hw },
+	{ .compatible = "apple,t8103-m3-mailbox", .data = &apple_mbox_m3_hw },
+	{}
+};
+MODULE_DEVICE_TABLE(of, apple_mbox_of_match);
+
+static struct platform_driver apple_mbox_driver = {
+	.driver = {
+		.name = "apple-mailbox",
+		.of_match_table = apple_mbox_of_match,
+	},
+	.probe = apple_mbox_probe,
+};
+module_platform_driver(apple_mbox_driver);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Apple Mailbox driver");
diff --git a/include/linux/apple-mailbox.h b/include/linux/apple-mailbox.h
new file mode 100644
index 000000000000..720fbb70294a
--- /dev/null
+++ b/include/linux/apple-mailbox.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Apple mailbox message format
+ *
+ * Copyright (C) 2021 The Asahi Linux Contributors
+ */
+
+#ifndef _LINUX_APPLE_MAILBOX_H_
+#define _LINUX_APPLE_MAILBOX_H_
+
+#include <linux/types.h>
+
+/* encodes a single 96bit message sent over the single channel */
+struct apple_mbox_msg {
+	u64 msg0;
+	u32 msg1;
+};
+
+#endif
-- 
2.25.1

