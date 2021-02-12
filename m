Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3950731A7CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhBLWfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:35:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:39916 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232084AbhBLW1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:27:02 -0500
IronPort-SDR: IEHWuGbWUd83EqrBukBhmdxhHyUm2KbZvqoUhNAlBtX+c/tTS+yYVuvniw1CNc78zGGKCnKlch
 neLpRMhYtlDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="161628121"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="161628121"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:23:09 -0800
IronPort-SDR: woSa1OPp3NZgOSnvnub/WYaPqgYjW5Sx/nmQ2PZ6EShCMhhK0ZurTQonGtpCDRPNqNW1a2PbLD
 k+J2QHNDZROg==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="416125112"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:23:08 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id A2A916369;
        Fri, 12 Feb 2021 14:23:07 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 9B7B73636F2; Fri, 12 Feb 2021 14:23:07 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v6 03/34] mailbox: vpu-ipc-mailbox: Add support for Intel VPU IPC mailbox
Date:   Fri, 12 Feb 2021 14:22:33 -0800
Message-Id: <20210212222304.110194-4-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212222304.110194-1-mgross@linux.intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add mailbox controller enabling inter-processor communication (IPC)
between the CPU (aka, the Application Processor - AP) and the VPU on
Intel Movidius SoCs like Keem Bay.

The controller uses HW FIFOs to enable such communication. Specifically,
there are two FIFOs, one for the CPU and one for VPU. Each FIFO can hold
128 entries (messages) of 32-bit each (but only 26 bits are actually
usable, since the 6 least-significant bits are reserved for the overflow
detection mechanism, more info below).

When the Linux kernel on the AP needs to send messages to the VPU
firmware, it writes them to the VPU FIFO; similarly, when the VPU
firmware needs to send messages to the AP, it writes them to the CPU
FIFO.

It's important to note that the AP is not the only one that can write to
the VPU FIFO: other components within the SoC can write to it too. Each
of these components (including the AP) has a unique 6-bit processor ID
associated to it. The VPU HW FIFO expects the last 6 bits of each 32-bit
FIFO entry to contain the processor ID of the sender.

Therefore, sending a message from the AP to the VPU works as follows:

1. The message must be a 32-bit value with the last 6-bit set to 0 (in
   practice, the message is meant to be a 32-bit address value, aligned
   to 64 bytes; but this is not really relevant for this mailbox
   controller).

2. The AP adds its processor ID to the 32-bit message being sent:
   M = m | AP_ProcID

3. The sender writes the message (M) to the TIM_IPC_FIFO register of the
   VPU FIFO.

4. The HW atomically checks if the FIFO is full and if not it writes it
   to the actual FIFO; if the FIFO is full, the HW reads the ProcID
   from M and then sets the corresponding bit of TIM_IPC_FIFO_OF_FLAG0,
   to signal that the write failed, because the FIFO was full.

5. The AP reads the TIM_IPC_FIFO_OF_FLAG0 register and checks if the
   bit corresponding to its ProcID has been set (in order to know if the
   TX succeeded or failed); if the bit is set, the AP clears it.

Note: as briefly mentioned above, the 32-bit value is meant to be a 32-
bit physical address (64-byte aligned). This address points to a
predefined struct (i.e., the IPC packet) in shared memory. However,
since this struct is not HW dependent (it's just the struct the VPU
firmware expects and in theory it could change if a different VPU FW is
used), it's not defined here, but in the Keem Bay IPC driver, which is
the mailbox client for this controller.

The AP is notified of pending messages in the CPU FIFO by means of the
'FIFO-not-empty' interrupt, which is generated by the CPU FIFO while not
empty. This interrupt is cleared automatically once all messages have
been read from the FIFO (i.e., the FIFO has been emptied).

The hardware doesn't provide an TX done IRQ (i.e., an IRQ that allows
the VPU firmware to notify the AP that the message put into the VPU FIFO
has been received); however the AP can ensure that the message has been
successfully put into the VPU FIFO (and therefore transmitted) by
checking the VPU FIFO status register (TIM_IPC_FIFO_OF_FLAG0) to ensure
that writing the message didn't cause the FIFO to overflow (as described
above).

Therefore, the mailbox controller is configured as capable of tx_done
IRQs and a tasklet is used to simulate the tx_done IRQ. The tasklet is
activated by send_data() right after the message has been put into the
VPU FIFO and the VPU FIFO status registers has been checked. If an
overflow is reported by the status register, the tasklet passes -EBUSY
to mbox_chan_txdone(), to notify the mailbox client of the failed TX.

The client should therefore register a tx_done() callback to properly
handle failed transmissions.

Note: the 'txdone_poll' mechanism cannot be used because it doesn't
provide a way to report a failed transmission.

Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
---
 MAINTAINERS                       |   1 +
 drivers/mailbox/Kconfig           |  11 ++
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/vpu-ipc-mailbox.c | 297 ++++++++++++++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 drivers/mailbox/vpu-ipc-mailbox.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 68e6af3e5650..a88f5eb35e39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9184,6 +9184,7 @@ M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 M:	Mark Gross <mgross@linux.intel.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
+F:	drivers/mailbox/vpu-ipc-mailbox.c
 
 INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy)
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index f4abe3529acd..cb50b541a5c6 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -29,6 +29,17 @@ config IMX_MBOX
 	help
 	  Mailbox implementation for i.MX Messaging Unit (MU).
 
+config INTEL_VPU_IPC_MBOX
+	tristate "Intel VPU IPC Mailbox"
+	depends on HAS_IOMEM
+	depends on OF || COMPILE_TEST
+	help
+	  Mailbox implementation for enabling inter-processor communication
+	  between application processors and Intel VPUs.
+
+	  Say Y or M here if you are building for an SoC equipped with an Intel
+	  VPU. If M is selected, the module will be called vpu-ipc-mailbox.
+
 config PLATFORM_MHU
 	tristate "Platform MHU Mailbox"
 	depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 7194fa92c787..68768bb2ee43 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -56,3 +56,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
+
+obj-$(CONFIG_INTEL_VPU_IPC_MBOX)	+= vpu-ipc-mailbox.o
diff --git a/drivers/mailbox/vpu-ipc-mailbox.c b/drivers/mailbox/vpu-ipc-mailbox.c
new file mode 100644
index 000000000000..ad161a7bbabb
--- /dev/null
+++ b/drivers/mailbox/vpu-ipc-mailbox.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel VPU IPC mailbox driver.
+ *
+ * Copyright (c) 2020-2021 Intel Corporation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+/*
+ * The IPC FIFO registers (offsets to the base address defined in device tree).
+ */
+
+/*
+ * TIM_IPC_FIFO - Write a 32-bit entry to FIFO.
+ *
+ * The entry to be put in the FIFO must be written to this register.
+ *
+ * NOTE: the 6 least-significant bits are reserved for the writing processor
+ * to include its processor ID, 0 <= x <= 62, so it can determine if the entry
+ * was written correctly by checking the appropriate bit of register
+ * TIM_IPC_FIFO_OF_FLAG[n].
+ *
+ * Internally, the hardware increments FIFO write pointer and fill level.
+ *
+ */
+#define IPC_FIFO		0x00
+
+/* The last 6 bits of an IPC entry are reserved. */
+#define IPC_FIFO_ENTRY_RSVD_MASK	0x3f
+
+/*
+ * IPC_FIFO_ATM - Read from FIFO using ATM mode.
+ *
+ * If FIFO is empty, reading from this registers returns 0xFFFFFFFF, otherwise
+ * returns the value from the FIFO with the 6 least-significant bits set to 0.
+ *
+ * Internally, the hardware increments FIFO read pointer and decrements fill
+ * level.
+ */
+#define IPC_FIFO_ATM		0x04
+#define IPC_FIFO_EMPTY		0xFFFFFFFF
+
+/*
+ * TIM_IPC_FIFO_OF_FLAG[n] - IPC FIFO overflow status for processor IDs 0-62.
+ *
+ * Read:
+ *
+ * A processor can check that its writes to the IPC FIFO were successful by
+ * reading the value of TIM_IPC_FIFO_OF_FLAG0 or TIM_IPC_FIFO_OF_FLAG1
+ * (depending on its processor ID).
+ *
+ * Bit x, 0 <= x <= 31, of TIM_IPC_FIFO_OF_FLAG0 is set high if a write
+ * to TIM_IPC_FIFO by processor ID x failed because the FIFO was full.
+ *
+ * Bit x, 0 <= x <= 30, of TIM_IPC_FIFO_OF_FLAG1 is set high if a write
+ * to TIM_IPC_FIFO by processor ID x+32 failed because the FIFO was
+ * full.
+ *
+ * Processors are identified by the 6 least-significant bits of words
+ * written to TIM_IPC_FIFO, i.e. x = TIM_IPC_FIFO[5:0].
+ * Processor ID = 0x3F is reserved to indicate a read of an empty FIFO
+ * has occurred.
+ *
+ * Write:
+ *
+ * Writing 1 to bit position x of TIM_IPC_FIFO_OF_FLAG0 clears the
+ * overflow flag corresponding to processor ID x.  Writing 1 to bit
+ * position x of TIM_IPC_FIFO_OF_FLAG1 clears the overflow flag
+ * corresponding to processor ID x+32.
+ *
+ * Writing 0 to any bit position has not effect.
+ */
+#define IPC_FIFO_OF_FLAG0	0x10
+#define IPC_FIFO_OF_FLAG1	0x14
+
+/* The processor ID of the CPU. */
+#define IPC_FIFO_ID_CPU		0
+
+/**
+ * struct vpu_ipc_mbox - Intel VPU IPC mailbox controller.
+ * @mbox:		Mailbox controller.
+ * @mbox_chan:		The only channel supported by this controller.
+ * @dev:		The device associated with this controller.
+ * @cpu_fifo_base:	Base address of CPU FIFO registers.
+ * @vpu_fifo_base:	Base address of VPU FIFO registers.
+ * @txdone_tasklet:	Tasklet calling mbox_chan_txdone(). It's activated by
+ *			the send_data() function, after the VPU FIFO has been
+ *			written; a tasklet is used because send_data() cannot
+ *			call mbox_chan_txdone() directly.
+ * @txdone_result:	The result of the last TX. It's set by the send_data()
+ *			function before activating the txdone_tasklet.
+ */
+struct vpu_ipc_mbox {
+	struct mbox_controller	mbox;
+	struct mbox_chan	mbox_chan;
+	void __iomem		*cpu_fifo_base;
+	void __iomem		*vpu_fifo_base;
+	struct tasklet_struct	txdone_tasklet;
+	int			txdone_result;
+};
+
+/* The IRQ handler servicing 'FIFO-not-empty' IRQs coming from the CPU FIFO. */
+static irqreturn_t vpu_ipc_mailbox_irq_handler(int irq, void *data)
+{
+	struct vpu_ipc_mbox *vpu_ipc_mbox = data;
+	u32 entry;
+
+	/* Extract and process one entry from CPU FIFO. */
+	entry = ioread32(vpu_ipc_mbox->cpu_fifo_base + IPC_FIFO_ATM);
+	if (unlikely(entry == IPC_FIFO_EMPTY))
+		return IRQ_NONE;
+
+	/* Notify mailbox client of new data. */
+	mbox_chan_received_data(&vpu_ipc_mbox->mbox_chan, (void *)&entry);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * The function implementing the txdone_tasklet.
+ *
+ * It calls mbox_chan_txdone() passing as arguments the only channel we have
+ * and the result of the last TX (as stored in the vpu_ipc_mbox struct).
+ */
+static void txdone_tasklet_func(unsigned long vpu_ipc_mbox_ptr)
+{
+	struct vpu_ipc_mbox *vpu_ipc_mbox = (void *)vpu_ipc_mbox_ptr;
+
+	/* Notify client that tx is completed and pass proper result code. */
+	mbox_chan_txdone(&vpu_ipc_mbox->mbox_chan, vpu_ipc_mbox->txdone_result);
+}
+
+/*
+ * Mailbox controller 'send_data()' function.
+ *
+ * This functions tries to put 'data' into the VPU FIFO. This is done by
+ * writing to the IPC_FIFO VPU register and then checking if we overflew the
+ * FIFO (by reading the IPC_FIFO_OF_FLAG0 VPU register).
+ *
+ * If we overflew the FIFO, the TX has failed and we notify the mailbox client
+ * by passing -EBUSY to mbox_chan_txdone()); otherwise the TX succeeded (we
+ * pass 0 to mbox_chan_txdone()). Note: mbox_chan_txdone() cannot be called
+ * directly (since that would case a deadlock), therefore a tasklet is used to
+ * defer the call.
+ *
+ * 'data' is meant to be a 32-bit unsigned integer with the least 6 significant
+ * bits set to 0.
+ */
+static int vpu_ipc_mailbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct vpu_ipc_mbox *vpu_ipc_mbox = chan->con_priv;
+	u32 entry, overflow;
+
+	entry = *((u32 *)data);
+
+	/* Ensure last 6-bits of entry are not used. */
+	if (unlikely(entry & IPC_FIFO_ENTRY_RSVD_MASK)) {
+		vpu_ipc_mbox->txdone_result = -EINVAL;
+		goto exit;
+	}
+
+	/* Add processor ID to entry. */
+	entry |= IPC_FIFO_ID_CPU & IPC_FIFO_ENTRY_RSVD_MASK;
+
+	/* Write entry to VPU FIFO. */
+	iowrite32(entry, vpu_ipc_mbox->vpu_fifo_base + IPC_FIFO);
+
+	/* Check if we overflew the VPU FIFO. */
+	overflow = ioread32(vpu_ipc_mbox->vpu_fifo_base + IPC_FIFO_OF_FLAG0) &
+		   BIT(IPC_FIFO_ID_CPU);
+	if (unlikely(overflow)) {
+		/* Reset overflow register. */
+		iowrite32(BIT(IPC_FIFO_ID_CPU),
+			  vpu_ipc_mbox->vpu_fifo_base + IPC_FIFO_OF_FLAG0);
+		vpu_ipc_mbox->txdone_result = -EBUSY;
+		goto exit;
+	}
+	vpu_ipc_mbox->txdone_result = 0;
+
+exit:
+	/* Schedule tasklet to call mbox_chan_txdone(). */
+	tasklet_schedule(&vpu_ipc_mbox->txdone_tasklet);
+
+	return 0;
+}
+
+/* The mailbox channel ops for this controller. */
+static const struct mbox_chan_ops vpu_ipc_mbox_chan_ops = {
+	.send_data = vpu_ipc_mailbox_send_data,
+};
+
+static int vpu_ipc_mailbox_probe(struct platform_device *pdev)
+{
+	struct vpu_ipc_mbox *vpu_ipc_mbox;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	int irq;
+	int rc;
+
+	vpu_ipc_mbox = devm_kzalloc(dev, sizeof(*vpu_ipc_mbox), GFP_KERNEL);
+	if (!vpu_ipc_mbox)
+		return -ENOMEM;
+
+	/* Map CPU FIFO registers. */
+	base = devm_platform_ioremap_resource_byname(pdev, "cpu_fifo");
+	if (IS_ERR(base)) {
+		dev_err(dev, "Failed to ioremap CPU FIFO registers\n");
+		return PTR_ERR(base);
+	}
+	vpu_ipc_mbox->cpu_fifo_base = base;
+
+	/* MAP VPU FIFO registers. */
+	base = devm_platform_ioremap_resource_byname(pdev, "vpu_fifo");
+	if (IS_ERR(base)) {
+		dev_err(dev, "Failed to ioremap VPU FIFO registers\n");
+		return PTR_ERR(base);
+	}
+	vpu_ipc_mbox->vpu_fifo_base = base;
+
+	/* Initialize mailbox channels. */
+	vpu_ipc_mbox->mbox_chan.con_priv = vpu_ipc_mbox;
+
+	/* Initialize mailbox controller. */
+	vpu_ipc_mbox->mbox.dev = dev;
+	vpu_ipc_mbox->mbox.ops = &vpu_ipc_mbox_chan_ops;
+	vpu_ipc_mbox->mbox.chans = &vpu_ipc_mbox->mbox_chan;
+	vpu_ipc_mbox->mbox.num_chans = 1;
+	/*
+	 * Set txdone_irq; we don't have a HW IRQ, but we use a txdone tasklet
+	 * to simulate it.
+	 */
+	vpu_ipc_mbox->mbox.txdone_irq = true;
+
+	/* Init TX done tasklet. */
+	tasklet_init(&vpu_ipc_mbox->txdone_tasklet, txdone_tasklet_func,
+		     (uintptr_t)vpu_ipc_mbox);
+
+	rc = devm_mbox_controller_register(dev, &vpu_ipc_mbox->mbox);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to register VPU IPC controller\n");
+		return rc;
+	}
+
+	/* Register interrupt handler for CPU FIFO. */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	rc = devm_request_irq(dev, irq, vpu_ipc_mailbox_irq_handler, 0,
+			      dev_name(dev), vpu_ipc_mbox);
+	if (rc)
+		return rc;
+
+	platform_set_drvdata(pdev, vpu_ipc_mbox);
+
+	return 0;
+}
+
+static int vpu_ipc_mailbox_remove(struct platform_device *pdev)
+{
+	struct vpu_ipc_mbox *vpu_ipc_mbox = platform_get_drvdata(pdev);
+
+	/*
+	 * Just kill the tasklet as iomem and irq have been requested with
+	 * devm_* functions and, therefore, are freed automatically.
+	 */
+	tasklet_kill(&vpu_ipc_mbox->txdone_tasklet);
+
+	return 0;
+}
+
+static const struct of_device_id vpu_ipc_mailbox_of_match[] = {
+	{
+		.compatible = "intel,vpu-ipc-mailbox",
+	},
+	{}
+};
+
+static struct platform_driver vpu_ipc_mailbox_driver = {
+	.driver = {
+			.name = "vpu-ipc-mailbox",
+			.of_match_table = vpu_ipc_mailbox_of_match,
+		},
+	.probe = vpu_ipc_mailbox_probe,
+	.remove = vpu_ipc_mailbox_remove,
+};
+module_platform_driver(vpu_ipc_mailbox_driver);
+
+MODULE_DESCRIPTION("Intel VPU IPC mailbox driver");
+MODULE_AUTHOR("Daniele Alessandrelli <daniele.alessandrelli@intel.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

