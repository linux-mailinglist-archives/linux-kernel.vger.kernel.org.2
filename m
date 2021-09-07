Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916CA402B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbhIGO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:56:42 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48615 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344270AbhIGO4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:56:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id EBB0A580E9A;
        Tue,  7 Sep 2021 10:55:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 07 Sep 2021 10:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=EyfTuGE0XugR+
        IeHeZP4P0SsiQml/467dB/O4QGvyYM=; b=P8zBwco/bMGPtY6U9KkTLamMXXlLQ
        sM1xwrrJAdrtEqC3gs3JIK9ND8Ono/BNllCKmgp1JiBCd3Ej8YVrq8TmLp4Ovv04
        4g6SDeE34sodE8Ym31wMmabF9BKJl49z51IQHKh26he3q2hJy5boTYVI1kYNMOZf
        b4RfJlSB9aRQSChcwRRd+BAAqy52iNSoDsFfOHnJ4WB18pvVL/O+JALrrfXhXhA+
        2F4qivzwkh6+QrRNFvLeOBM60e+P0qri5FwqcNw/9V13GuUez9G9O5xz+zJJWRUK
        OKmQaE5a9XUqITi2IMBb8+33nBgj0OHWv7w4pNnABWVZtaTSYOLhUKjtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=EyfTuGE0XugR+IeHeZP4P0SsiQml/467dB/O4QGvyYM=; b=COGaex/7
        CHndftvur9SVvLymVJ96et5aXvEgZWjN8465uOZRh/4l24tfgAmT/asUhRBNz2r/
        iC5N/Xvz6xS5D+jeVBwxkoCLHGXHwll0rTkY0S1BlPqW6W0YxJXAqXVzt7dzzgXH
        IicTATMl2/MYrwbvLN6Z5f8yKM9xM7DGh+t1r3bOQB2sfuxvQfGYQ/QfXTNCOiY5
        DXop1L1RbW0tCIH1uPcGoM8SaGrzJaxMM0VkkWLdItt7GvE7kCQZDjwo5vKLCyrd
        LQRHZmCQkp24NXNHNqL4ELklen3dZ6JtIpPFNcQ8wtM5fH/owL+eNAdnOY2KlZiU
        eH+3t0ZyjCZ3wg==
X-ME-Sender: <xms:Xn03YQ-Yxzvln1LmAyWMdVVOVi0OmUr6T5eGpfL9ilpxIj3E6zh21A>
    <xme:Xn03YYtUYz5EWUPtaWuc8w5QUZZvdV7ihaZf-t9RFCOdy9wanUL_bSY1emUpPhKO8
    kSkyoh9b5SpY2a_RDY>
X-ME-Received: <xmr:Xn03YWA5xD8hETQo_SmlReAW_MdyGRtzIjme_2Y2D4HvtyD5QMP6IFvmAoG0uidXTr0L6t85hXJxFtbzbHUt1WJpmWsHIYwAPRYg1KkIQl521WCZOiY_fJ5U33679A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefhedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Xn03YQcafNt9sy2IN_mZ4SgIH0BF3yG3iqRmoDifacdqEhHKmn72XA>
    <xmx:Xn03YVMj8T9Hav667mGgYq9EgbQpZZpRxbyxsKBaFE8G6FV22dKnWw>
    <xmx:Xn03Yak40-rA5M0Bx0aWFmAwvn_p8yVb_n0I4IIHjD0w4Oi64iBhuQ>
    <xmx:Xn03YYrK9zpI2mqMz3K7P5bk1MY40HywFG4jsa0lLRscTZnoZfImgA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 10:55:25 -0400 (EDT)
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
Subject: [PATCH 3/3] mailbox: apple: Add driver for Apple mailboxes
Date:   Tue,  7 Sep 2021 16:55:01 +0200
Message-Id: <20210907145501.69161-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210907145501.69161-1-sven@svenpeter.dev>
References: <20210907145501.69161-1-sven@svenpeter.dev>
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
 MAINTAINERS                     |   2 +
 drivers/mailbox/Kconfig         |  12 +
 drivers/mailbox/Makefile        |   2 +
 drivers/mailbox/apple-mailbox.c | 432 ++++++++++++++++++++++++++++++++
 include/linux/apple-mailbox.h   |  18 ++
 5 files changed, 466 insertions(+)
 create mode 100644 drivers/mailbox/apple-mailbox.c
 create mode 100644 include/linux/apple-mailbox.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 47de27282c98..cf0500bbea5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1724,8 +1724,10 @@ F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
+F:	drivers/mailbox/apple-mailbox.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 F:	include/dt-bindings/pinctrl/apple.h
+F:	include/linux/apple-mailbox.h
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c9fc06c7e685..a2caff75047f 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -8,6 +8,18 @@ menuconfig MAILBOX
 
 if MAILBOX
 
+config APPLE_MBOX
+	tristate "Apple Mailbox driver"
+	depends on ARCH_APPLE || (ARM64 && COMPILE_TEST)
+	default ARCH_APPLE
+	help
+	  Apple SoCs have various co-processors that need to be started and
+	  initialized for certain peripherals to work (NVMe, display controller,
+	  etc.). This driver adds support for the mailbox controller used to
+	  communicate with those.
+
+	  Say Y here if you have a Apple SoC.
+
 config ARM_MHU
 	tristate "ARM MHU Mailbox"
 	depends on ARM_AMBA
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c2089f04887e..896554c7c169 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -58,3 +58,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
+
+obj-$(CONFIG_APPLE_MBOX)	+= apple-mailbox.o
diff --git a/drivers/mailbox/apple-mailbox.c b/drivers/mailbox/apple-mailbox.c
new file mode 100644
index 000000000000..d59642d9216a
--- /dev/null
+++ b/drivers/mailbox/apple-mailbox.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple mailbox driver
+ *
+ * Copyright (C) 2021 The Asahi Linux Contributors
+ *
+ * This driver adds support for two mailbox variants (called ASC and M3 by
+ * Apple) found in Apple SoCs such as the M1. It consists of two FIFOs used to
+ * exchange 64+32 bit messages between the main CPU and a co-processor.
+ * Various clients implement different IPC protocols based on these simple
+ * messages and shared memory buffers.
+ *
+ * Both the main CPU and the co-processor see the same set of registers but
+ * the first FIFO (A2I) is always used to transfer messages from the application
+ * processor (us) to the I/O processor and the second one (I2A) for the
+ * other direction.
+ */
+
+#include <linux/apple-mailbox.h>
+#include <linux/clk.h>
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
+#define APPLE_ASC_MBOX_CONTROL_FULL BIT(16)
+#define APPLE_ASC_MBOX_CONTROL_EMPTY BIT(17)
+
+#define APPLE_ASC_MBOX_A2I_CONTROL 0x110
+#define APPLE_ASC_MBOX_A2I_SEND0 0x800
+#define APPLE_ASC_MBOX_A2I_SEND1 0x808
+#define APPLE_ASC_MBOX_A2I_RECV0 0x810
+#define APPLE_ASC_MBOX_A2I_RECV1 0x818
+
+#define APPLE_ASC_MBOX_I2A_CONTROL 0x114
+#define APPLE_ASC_MBOX_I2A_SEND0 0x820
+#define APPLE_ASC_MBOX_I2A_SEND1 0x828
+#define APPLE_ASC_MBOX_I2A_RECV0 0x830
+#define APPLE_ASC_MBOX_I2A_RECV1 0x838
+
+#define APPLE_M3_MBOX_A2I_CONTROL 0x50
+#define APPLE_M3_MBOX_A2I_SEND0 0x60
+#define APPLE_M3_MBOX_A2I_SEND1 0x68
+#define APPLE_M3_MBOX_A2I_RECV0 0x70
+#define APPLE_M3_MBOX_A2I_RECV1 0x78
+
+#define APPLE_M3_MBOX_I2A_CONTROL 0x80
+#define APPLE_M3_MBOX_I2A_SEND0 0x90
+#define APPLE_M3_MBOX_I2A_SEND1 0x98
+#define APPLE_M3_MBOX_I2A_RECV0 0xa0
+#define APPLE_M3_MBOX_I2A_RECV1 0xa8
+
+#define APPLE_M3_MBOX_CONTROL_FULL BIT(16)
+#define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
+
+#define APPLE_M3_MBOX_IRQ_ENABLE 0x48
+#define APPLE_M3_MBOX_IRQ_ACK 0x4c
+#define APPLE_M3_MBOX_IRQ_A2I_EMPTY BIT(0)
+#define APPLE_M3_MBOX_IRQ_A2I_NOT_EMPTY BIT(1)
+#define APPLE_M3_MBOX_IRQ_I2A_EMPTY BIT(2)
+#define APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY BIT(3)
+
+#define APPLE_MBOX_MSG1_OUTCNT GENMASK(56, 52)
+#define APPLE_MBOX_MSG1_INCNT GENMASK(51, 48)
+#define APPLE_MBOX_MSG1_OUTPTR GENMASK(47, 44)
+#define APPLE_MBOX_MSG1_INPTR GENMASK(43, 40)
+#define APPLE_MBOX_MSG1_MSG GENMASK(31, 0)
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
+struct apple_mbox {
+	void __iomem *regs;
+	const struct apple_mbox_hw *hw;
+
+	int irq_recv_not_empty;
+	int irq_send_empty;
+
+	struct clk_bulk_data *clks;
+	int num_clks;
+
+	struct mbox_chan chan;
+
+	struct device *dev;
+	struct mbox_controller controller;
+};
+
+static bool apple_mbox_hw_can_send(struct apple_mbox *apple_mbox)
+{
+	u32 mbox_ctrl =
+		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
+
+	return !(mbox_ctrl & apple_mbox->hw->control_full);
+}
+
+static void apple_mbox_hw_send(struct apple_mbox *apple_mbox,
+			       struct apple_mbox_msg *msg)
+{
+	WARN_ON(!apple_mbox_hw_can_send(apple_mbox));
+
+	dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg->msg1);
+
+	/*
+	 * This message may be related to a shared memory buffer and we must
+	 * ensure all previous writes to normal memory are visible before
+	 * submitting it.
+	 */
+	dma_wmb();
+
+	writeq_relaxed(msg->msg0, apple_mbox->regs + apple_mbox->hw->a2i_send0);
+	writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg->msg1),
+		       apple_mbox->regs + apple_mbox->hw->a2i_send1);
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
+static void apple_mbox_hw_recv(struct apple_mbox *apple_mbox,
+			       struct apple_mbox_msg *msg)
+{
+	WARN_ON(!apple_mbox_hw_can_recv(apple_mbox));
+
+	msg->msg0 = readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv0);
+	msg->msg1 = FIELD_GET(
+		APPLE_MBOX_MSG1_MSG,
+		readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv1));
+
+	dev_dbg(apple_mbox->dev, "< RX %016llx %08x\n", msg->msg0, msg->msg1);
+
+	/*
+	 * This message may be related to a shared memory buffer and we must
+	 * ensure any following reads from normal memory only happen after
+	 * having read this message.
+	 */
+	dma_rmb();
+}
+
+static int apple_mbox_chan_send_data(struct mbox_chan *chan, void *data)
+{
+	struct apple_mbox *apple_mbox = chan->con_priv;
+	struct apple_mbox_msg *msg = data;
+
+	if (!apple_mbox_hw_can_send(apple_mbox)) {
+		dev_dbg(apple_mbox->dev, "FIFO full, waiting for IRQ\n");
+		return -EBUSY;
+	}
+
+	apple_mbox_hw_send(apple_mbox, msg);
+	return 0;
+}
+
+static irqreturn_t apple_mbox_send_empty_irq(int irq, void *data)
+{
+	struct apple_mbox *apple_mbox = data;
+
+	dev_dbg(apple_mbox->dev, "got FIFO empty IRQ\n");
+
+	/*
+	 * We don't need to acknowledge the interrupt at the mailbox level
+	 * here even if supported by the hardware. It will keep firing but that
+	 * doesn't matter since it's disabled at the main interrupt controller.
+	 * apple_mbox_chan_request_irq will acknowledge it before enabling
+	 * it at the main controller again.
+	 */
+	disable_irq_nosync(apple_mbox->irq_send_empty);
+	mbox_chan_txfifo_ready(&apple_mbox->chan);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
+{
+	struct apple_mbox *apple_mbox = data;
+	struct apple_mbox_msg msg;
+
+	while (apple_mbox_hw_can_recv(apple_mbox)) {
+		apple_mbox_hw_recv(apple_mbox, &msg);
+		mbox_chan_received_data(&apple_mbox->chan, (void *)&msg);
+	}
+
+	/*
+	 * The interrupt will keep firing even if there are no more messages
+	 * unless we also acknowledge it at the mailbox level here.
+	 * There's no race if a message comes in between the check in the while
+	 * loop above and the ack below: If a new messages arrives inbetween
+	 * those two the interrupt will just fire again immediately after the
+	 * ack since it's level sensitive.
+	 */
+	if (apple_mbox->hw->has_irq_controls)
+		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty,
+			       apple_mbox->regs + apple_mbox->hw->irq_ack);
+
+	return IRQ_HANDLED;
+}
+
+static struct mbox_chan *apple_mbox_of_xlate(struct mbox_controller *mbox,
+					     const struct of_phandle_args *spec)
+{
+	struct apple_mbox *apple_mbox = dev_get_drvdata(mbox->dev);
+
+	if (spec->args_count != 0)
+		return ERR_PTR(-EINVAL);
+	if (apple_mbox->chan.con_priv)
+		return ERR_PTR(-EBUSY);
+
+	apple_mbox->chan.con_priv = apple_mbox;
+	return &apple_mbox->chan;
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
+	if (apple_mbox->hw->has_irq_controls)
+		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty |
+				       apple_mbox->hw->irq_bit_send_empty,
+			       apple_mbox->regs + apple_mbox->hw->irq_enable);
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
+static void apple_mbox_chan_request_irq(struct mbox_chan *chan)
+{
+	struct apple_mbox *apple_mbox = chan->con_priv;
+
+	/*
+	 * The interrupt is level sensitive and will keep firing as long as the
+	 * FIFO is empty. It will also keep firing if the FIFO was empty
+	 * at any point in the past until it has been acknowledged at the
+	 * mailbox level. By acknowledging it here we can ensure that we will
+	 * only get the interrupt once the FIFO has been cleared again.
+	 * If the FIFO is already empty before the ack it will fire again
+	 * immediately after the ack.
+	 */
+	if (apple_mbox->hw->has_irq_controls)
+		writel_relaxed(apple_mbox->hw->irq_bit_send_empty,
+			       apple_mbox->regs + apple_mbox->hw->irq_ack);
+	enable_irq(apple_mbox->irq_send_empty);
+}
+
+static const struct mbox_chan_ops apple_mbox_ops = {
+	.send_data = apple_mbox_chan_send_data,
+	.request_irq = apple_mbox_chan_request_irq,
+	.startup = apple_mbox_chan_startup,
+	.shutdown = apple_mbox_chan_shutdown,
+};
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
+	ret = devm_clk_bulk_get_all(dev, &mbox->clks);
+	if (ret < 0)
+		return ret;
+	mbox->num_clks = ret;
+
+	ret = clk_bulk_prepare_enable(mbox->num_clks, mbox->clks);
+	if (ret)
+		return ret;
+
+	mbox->controller.dev = mbox->dev;
+	mbox->controller.num_chans = 1;
+	mbox->controller.chans = &mbox->chan;
+	mbox->controller.ops = &apple_mbox_ops;
+	mbox->controller.of_xlate = &apple_mbox_of_xlate;
+	mbox->controller.txdone_fifo = true;
+
+	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-recv", dev_name(dev));
+	if (!irqname) {
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+	ret = devm_request_irq(dev, mbox->irq_recv_not_empty,
+			       apple_mbox_recv_irq, IRQF_NO_AUTOEN, irqname,
+			       mbox);
+	if (ret)
+		goto err_clk_disable;
+
+	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-send", dev_name(dev));
+	if (!irqname) {
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+	ret = devm_request_irq(dev, mbox->irq_send_empty,
+			       apple_mbox_send_empty_irq, IRQF_NO_AUTOEN,
+			       irqname, mbox);
+	if (ret)
+		goto err_clk_disable;
+
+	ret = devm_mbox_controller_register(dev, &mbox->controller);
+	if (ret)
+		goto err_clk_disable;
+	return ret;
+
+err_clk_disable:
+	clk_bulk_disable_unprepare(mbox->num_clks, mbox->clks);
+	return ret;
+}
+
+static int apple_mbox_remove(struct platform_device *pdev)
+{
+	struct apple_mbox *apple_mbox = dev_get_drvdata(&pdev->dev);
+
+	clk_bulk_disable_unprepare(apple_mbox->num_clks, apple_mbox->clks);
+	return 0;
+}
+
+static struct platform_driver apple_mbox_driver = {
+	.driver = {
+		.name = "apple-mailbox",
+		.of_match_table = apple_mbox_of_match,
+	},
+	.probe = apple_mbox_probe,
+	.remove = apple_mbox_remove,
+};
+module_platform_driver(apple_mbox_driver);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Apple Mailbox driver");
diff --git a/include/linux/apple-mailbox.h b/include/linux/apple-mailbox.h
new file mode 100644
index 000000000000..c455e0f9c73b
--- /dev/null
+++ b/include/linux/apple-mailbox.h
@@ -0,0 +1,18 @@
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
+struct apple_mbox_msg {
+	u64 msg0;
+	u32 msg1;
+};
+
+#endif
-- 
2.25.1

