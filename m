Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CA43498EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhCYSGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230082AbhCYSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:05:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E6F561A38;
        Thu, 25 Mar 2021 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616695545;
        bh=BEZ2YygNX5joNsapdxkP5i9V2SA8PzxMiIhVK15nzgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3q2po4zviLdNYPNLG7Ip2GJoce12O4NqEHWPQwc/tBKVjuZWAxZn+6C10lLVmPws
         HKR8VPlKtahwVGMEYcDNzw8sGzHgmf6f9HSTEcpv0yh7+qkWOUAbxjHLLzw9/2lvko
         9xC4e7jD/xDV2+VGO4BFdZlbXesEFEav1kr52ltQuUUZUCtG0G6fwpYpHM/yQ/t8/M
         yyj/Aoqr8/XkY6mxJH8RGEboNONIfy49uwmTUR28qm5KRpIhDBgAxtSdWqYmFOh32i
         pCkNeV7J0XZjXItC0C/S0ITToM5JfN9bajVcV0aCnTHJ8E1qAPi1nOWOyfj6iB5Ly2
         KZGh+A50kiWdg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPUMX-001Mal-SV; Thu, 25 Mar 2021 19:05:41 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5 (RESEND) 3/7] spmi: hisi-spmi-controller: move driver from staging
Date:   Thu, 25 Mar 2021 19:05:35 +0100
Message-Id: <697f26c380dc2c22c07bedc63a0eab8c9325fccc.1616695231.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616695231.git.mchehab+huawei@kernel.org>
References: <cover.1616695231.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hisilicon 6421v600 SPMI driver is ready for mainstream.

So, move it from staging.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../spmi/hisilicon,hisi-spmi-controller.yaml  |  71 ++++
 MAINTAINERS                                   |   7 +
 drivers/spmi/Kconfig                          |   9 +
 drivers/spmi/Makefile                         |   1 +
 drivers/spmi/hisi-spmi-controller.c           | 367 ++++++++++++++++++
 drivers/staging/hikey9xx/Kconfig              |  11 -
 drivers/staging/hikey9xx/Makefile             |   1 -
 .../staging/hikey9xx/hisi-spmi-controller.c   | 367 ------------------
 .../hisilicon,hisi-spmi-controller.yaml       |  71 ----
 9 files changed, 455 insertions(+), 450 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
 create mode 100644 drivers/spmi/hisi-spmi-controller.c
 delete mode 100644 drivers/staging/hikey9xx/hisi-spmi-controller.c
 delete mode 100644 drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml

diff --git a/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
new file mode 100644
index 000000000000..6b755039a74c
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/hisilicon,hisi-spmi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon SPMI controller
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description: |
+  The HiSilicon SPMI BUS controller is found on some Kirin-based designs.
+  It is a MIPI System Power Management (SPMI) controller.
+
+  The PMIC part is provided by
+  drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
+
+allOf:
+  - $ref: spmi.yaml#
+
+properties:
+
+  $nodename:
+    pattern: "spmi@[0-9a-f]"
+
+  compatible:
+    const: hisilicon,kirin970-spmi-controller
+
+  reg:
+    maxItems: 1
+
+  spmi-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      number of the Kirin 970 SPMI channel where the SPMI devices are connected.
+
+required:
+  - compatible
+  - reg
+  - spmi-channel
+
+patternProperties:
+  "@[0-9a-f]$":
+    description: |
+      PMIC properties, which are specific to the used SPMI PMIC device(s).
+      When used in combination with HiSilicon 6421v600, the properties
+      are documented at
+      drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spmi: spmi@fff24000 {
+        compatible = "hisilicon,kirin970-spmi-controller";
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x0 0xfff24000 0x0 0x1000>;
+        spmi-channel = <2>;
+
+        pmic@0 {
+          reg = <0 0>;
+          /* pmic properties */
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a37489f5b070..2fdea49400c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8149,6 +8149,13 @@ F:	drivers/crypto/hisilicon/sec2/sec_crypto.c
 F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
 F:	drivers/crypto/hisilicon/sec2/sec_main.c
 
+HISILICON SPMI CONTROLLER DRIVER FOR HIKEY 970
+M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
+F:	drivers/spmi/hisi-spmi-controller.c
+
 HISILICON STAGING DRIVERS FOR HIKEY 960/970
 M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 S:	Maintained
diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index a53bad541f1a..2874b6c26028 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -11,6 +11,15 @@ menuconfig SPMI
 
 if SPMI
 
+config SPMI_HISI3670
+	tristate "Hisilicon 3670 SPMI Controller"
+	select IRQ_DOMAIN_HIERARCHY
+	depends on HAS_IOMEM
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
+	  processors.
+
 config SPMI_MSM_PMIC_ARB
 	tristate "Qualcomm MSM SPMI Controller (PMIC Arbiter)"
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 55a94cadeffe..6e092e6f290c 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -4,4 +4,5 @@
 #
 obj-$(CONFIG_SPMI)	+= spmi.o
 
+obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
 obj-$(CONFIG_SPMI_MSM_PMIC_ARB)	+= spmi-pmic-arb.o
diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
new file mode 100644
index 000000000000..0d42bc65f39b
--- /dev/null
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spmi.h>
+
+/*
+ * SPMI register addr
+ */
+#define SPMI_CHANNEL_OFFSET				0x0300
+#define SPMI_SLAVE_OFFSET				0x20
+
+#define SPMI_APB_SPMI_CMD_BASE_ADDR			0x0100
+
+#define SPMI_APB_SPMI_WDATA0_BASE_ADDR			0x0104
+#define SPMI_APB_SPMI_WDATA1_BASE_ADDR			0x0108
+#define SPMI_APB_SPMI_WDATA2_BASE_ADDR			0x010c
+#define SPMI_APB_SPMI_WDATA3_BASE_ADDR			0x0110
+
+#define SPMI_APB_SPMI_STATUS_BASE_ADDR			0x0200
+
+#define SPMI_APB_SPMI_RDATA0_BASE_ADDR			0x0204
+#define SPMI_APB_SPMI_RDATA1_BASE_ADDR			0x0208
+#define SPMI_APB_SPMI_RDATA2_BASE_ADDR			0x020c
+#define SPMI_APB_SPMI_RDATA3_BASE_ADDR			0x0210
+
+#define SPMI_PER_DATAREG_BYTE				4
+/*
+ * SPMI cmd register
+ */
+#define SPMI_APB_SPMI_CMD_EN				BIT(31)
+#define SPMI_APB_SPMI_CMD_TYPE_OFFSET			24
+#define SPMI_APB_SPMI_CMD_LENGTH_OFFSET			20
+#define SPMI_APB_SPMI_CMD_SLAVEID_OFFSET		16
+#define SPMI_APB_SPMI_CMD_ADDR_OFFSET			0
+
+/* Command Opcodes */
+
+enum spmi_controller_cmd_op_code {
+	SPMI_CMD_REG_ZERO_WRITE = 0,
+	SPMI_CMD_REG_WRITE = 1,
+	SPMI_CMD_REG_READ = 2,
+	SPMI_CMD_EXT_REG_WRITE = 3,
+	SPMI_CMD_EXT_REG_READ = 4,
+	SPMI_CMD_EXT_REG_WRITE_L = 5,
+	SPMI_CMD_EXT_REG_READ_L = 6,
+	SPMI_CMD_REG_RESET = 7,
+	SPMI_CMD_REG_SLEEP = 8,
+	SPMI_CMD_REG_SHUTDOWN = 9,
+	SPMI_CMD_REG_WAKEUP = 10,
+};
+
+/*
+ * SPMI status register
+ */
+#define SPMI_APB_TRANS_DONE			BIT(0)
+#define SPMI_APB_TRANS_FAIL			BIT(2)
+
+/* Command register fields */
+#define SPMI_CONTROLLER_CMD_MAX_BYTE_COUNT	16
+
+/* Maximum number of support PMIC peripherals */
+#define SPMI_CONTROLLER_TIMEOUT_US		1000
+#define SPMI_CONTROLLER_MAX_TRANS_BYTES		16
+
+struct spmi_controller_dev {
+	struct spmi_controller	*controller;
+	struct device		*dev;
+	void __iomem		*base;
+	spinlock_t		lock;
+	u32			channel;
+};
+
+static int spmi_controller_wait_for_done(struct device *dev,
+					 struct spmi_controller_dev *ctrl_dev,
+					 void __iomem *base, u8 sid, u16 addr)
+{
+	u32 timeout = SPMI_CONTROLLER_TIMEOUT_US;
+	u32 status, offset;
+
+	offset  = SPMI_APB_SPMI_STATUS_BASE_ADDR;
+	offset += SPMI_CHANNEL_OFFSET * ctrl_dev->channel + SPMI_SLAVE_OFFSET * sid;
+
+	do {
+		status = readl(base + offset);
+
+		if (status & SPMI_APB_TRANS_DONE) {
+			if (status & SPMI_APB_TRANS_FAIL) {
+				dev_err(dev, "%s: transaction failed (0x%x)\n",
+					__func__, status);
+				return -EIO;
+			}
+			dev_dbg(dev, "%s: status 0x%x\n", __func__, status);
+			return 0;
+		}
+		udelay(1);
+	} while (timeout--);
+
+	dev_err(dev, "%s: timeout, status 0x%x\n", __func__, status);
+	return -ETIMEDOUT;
+}
+
+static int spmi_read_cmd(struct spmi_controller *ctrl,
+			 u8 opc, u8 slave_id, u16 slave_addr, u8 *__buf, size_t bc)
+{
+	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
+	u32 chnl_ofst = SPMI_CHANNEL_OFFSET * spmi_controller->channel;
+	unsigned long flags;
+	u8 *buf = __buf;
+	u32 cmd, data;
+	int rc;
+	u8 op_code, i;
+
+	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
+		dev_err(&ctrl->dev,
+			"spmi_controller supports 1..%d bytes per trans, but:%zu requested\n",
+			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
+		return  -EINVAL;
+	}
+
+	switch (opc) {
+	case SPMI_CMD_READ:
+		op_code = SPMI_CMD_REG_READ;
+		break;
+	case SPMI_CMD_EXT_READ:
+		op_code = SPMI_CMD_EXT_REG_READ;
+		break;
+	case SPMI_CMD_EXT_READL:
+		op_code = SPMI_CMD_EXT_REG_READ_L;
+		break;
+	default:
+		dev_err(&ctrl->dev, "invalid read cmd 0x%x\n", opc);
+		return -EINVAL;
+	}
+
+	cmd = SPMI_APB_SPMI_CMD_EN |
+	     (op_code << SPMI_APB_SPMI_CMD_TYPE_OFFSET) |
+	     ((bc - 1) << SPMI_APB_SPMI_CMD_LENGTH_OFFSET) |
+	     ((slave_id & 0xf) << SPMI_APB_SPMI_CMD_SLAVEID_OFFSET) |  /* slvid */
+	     ((slave_addr & 0xffff)  << SPMI_APB_SPMI_CMD_ADDR_OFFSET); /* slave_addr */
+
+	spin_lock_irqsave(&spmi_controller->lock, flags);
+
+	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
+
+	rc = spmi_controller_wait_for_done(&ctrl->dev, spmi_controller,
+					   spmi_controller->base, slave_id, slave_addr);
+	if (rc)
+		goto done;
+
+	for (i = 0; bc > i * SPMI_PER_DATAREG_BYTE; i++) {
+		data = readl(spmi_controller->base + chnl_ofst +
+			     SPMI_SLAVE_OFFSET * slave_id +
+			     SPMI_APB_SPMI_RDATA0_BASE_ADDR +
+			     i * SPMI_PER_DATAREG_BYTE);
+		data = be32_to_cpu((__be32 __force)data);
+		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
+			memcpy(buf, &data, sizeof(data));
+			buf += sizeof(data);
+		} else {
+			memcpy(buf, &data, bc % SPMI_PER_DATAREG_BYTE);
+			buf += (bc % SPMI_PER_DATAREG_BYTE);
+		}
+	}
+
+done:
+	spin_unlock_irqrestore(&spmi_controller->lock, flags);
+	if (rc)
+		dev_err(&ctrl->dev,
+			"spmi read wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%zu\n",
+			opc, slave_id, slave_addr, bc + 1);
+	else
+		dev_dbg(&ctrl->dev, "%s: id:%d slave_addr:0x%x, read value: %*ph\n",
+			__func__, slave_id, slave_addr, (int)bc, __buf);
+
+	return rc;
+}
+
+static int spmi_write_cmd(struct spmi_controller *ctrl,
+			  u8 opc, u8 slave_id, u16 slave_addr, const u8 *__buf, size_t bc)
+{
+	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
+	u32 chnl_ofst = SPMI_CHANNEL_OFFSET * spmi_controller->channel;
+	const u8 *buf = __buf;
+	unsigned long flags;
+	u32 cmd, data;
+	int rc;
+	u8 op_code, i;
+
+	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
+		dev_err(&ctrl->dev,
+			"spmi_controller supports 1..%d bytes per trans, but:%zu requested\n",
+			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
+		return  -EINVAL;
+	}
+
+	switch (opc) {
+	case SPMI_CMD_WRITE:
+		op_code = SPMI_CMD_REG_WRITE;
+		break;
+	case SPMI_CMD_EXT_WRITE:
+		op_code = SPMI_CMD_EXT_REG_WRITE;
+		break;
+	case SPMI_CMD_EXT_WRITEL:
+		op_code = SPMI_CMD_EXT_REG_WRITE_L;
+		break;
+	default:
+		dev_err(&ctrl->dev, "invalid write cmd 0x%x\n", opc);
+		return -EINVAL;
+	}
+
+	cmd = SPMI_APB_SPMI_CMD_EN |
+	      (op_code << SPMI_APB_SPMI_CMD_TYPE_OFFSET) |
+	      ((bc - 1) << SPMI_APB_SPMI_CMD_LENGTH_OFFSET) |
+	      ((slave_id & 0xf) << SPMI_APB_SPMI_CMD_SLAVEID_OFFSET) |
+	      ((slave_addr & 0xffff)  << SPMI_APB_SPMI_CMD_ADDR_OFFSET);
+
+	/* Write data to FIFOs */
+	spin_lock_irqsave(&spmi_controller->lock, flags);
+
+	for (i = 0; bc > i * SPMI_PER_DATAREG_BYTE; i++) {
+		data = 0;
+		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
+			memcpy(&data, buf, sizeof(data));
+			buf += sizeof(data);
+		} else {
+			memcpy(&data, buf, bc % SPMI_PER_DATAREG_BYTE);
+			buf += (bc % SPMI_PER_DATAREG_BYTE);
+		}
+
+		writel((u32 __force)cpu_to_be32(data),
+		       spmi_controller->base + chnl_ofst +
+		       SPMI_APB_SPMI_WDATA0_BASE_ADDR +
+		       SPMI_PER_DATAREG_BYTE * i);
+	}
+
+	/* Start the transaction */
+	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
+
+	rc = spmi_controller_wait_for_done(&ctrl->dev, spmi_controller,
+					   spmi_controller->base, slave_id,
+					   slave_addr);
+	spin_unlock_irqrestore(&spmi_controller->lock, flags);
+
+	if (rc)
+		dev_err(&ctrl->dev, "spmi write wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%zu\n",
+			opc, slave_id, slave_addr, bc);
+	else
+		dev_dbg(&ctrl->dev, "%s: id:%d slave_addr:0x%x, wrote value: %*ph\n",
+			__func__, slave_id, slave_addr, (int)bc, __buf);
+
+	return rc;
+}
+
+static int spmi_controller_probe(struct platform_device *pdev)
+{
+	struct spmi_controller_dev *spmi_controller;
+	struct spmi_controller *ctrl;
+	struct resource *iores;
+	int ret;
+
+	ctrl = spmi_controller_alloc(&pdev->dev, sizeof(*spmi_controller));
+	if (!ctrl) {
+		dev_err(&pdev->dev, "can not allocate spmi_controller data\n");
+		return -ENOMEM;
+	}
+	spmi_controller = spmi_controller_get_drvdata(ctrl);
+	spmi_controller->controller = ctrl;
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iores) {
+		dev_err(&pdev->dev, "can not get resource!\n");
+		ret = -EINVAL;
+		goto err_put_controller;
+	}
+
+	spmi_controller->base = devm_ioremap(&pdev->dev, iores->start,
+					     resource_size(iores));
+	if (!spmi_controller->base) {
+		dev_err(&pdev->dev, "can not remap base addr!\n");
+		ret = -EADDRNOTAVAIL;
+		goto err_put_controller;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "spmi-channel",
+				   &spmi_controller->channel);
+	if (ret) {
+		dev_err(&pdev->dev, "can not get channel\n");
+		ret = -ENODEV;
+		goto err_put_controller;
+	}
+
+	platform_set_drvdata(pdev, spmi_controller);
+	dev_set_drvdata(&ctrl->dev, spmi_controller);
+
+	spin_lock_init(&spmi_controller->lock);
+
+	ctrl->nr = spmi_controller->channel;
+	ctrl->dev.parent = pdev->dev.parent;
+	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
+
+	/* Callbacks */
+	ctrl->read_cmd = spmi_read_cmd;
+	ctrl->write_cmd = spmi_write_cmd;
+
+	ret = spmi_controller_add(ctrl);
+	if (ret) {
+		dev_err(&pdev->dev, "spmi_controller_add failed with error %d!\n", ret);
+		goto err_put_controller;
+	}
+
+	return 0;
+
+err_put_controller:
+	spmi_controller_put(ctrl);
+	return ret;
+}
+
+static int spmi_del_controller(struct platform_device *pdev)
+{
+	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
+
+	spmi_controller_remove(ctrl);
+	spmi_controller_put(ctrl);
+	return 0;
+}
+
+static const struct of_device_id spmi_controller_match_table[] = {
+	{
+		.compatible = "hisilicon,kirin970-spmi-controller",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, spmi_controller_match_table);
+
+static struct platform_driver spmi_controller_driver = {
+	.probe		= spmi_controller_probe,
+	.remove		= spmi_del_controller,
+	.driver		= {
+		.name	= "hisi_spmi_controller",
+		.of_match_table = spmi_controller_match_table,
+	},
+};
+
+static int __init spmi_controller_init(void)
+{
+	return platform_driver_register(&spmi_controller_driver);
+}
+postcore_initcall(spmi_controller_init);
+
+static void __exit spmi_controller_exit(void)
+{
+	platform_driver_unregister(&spmi_controller_driver);
+}
+module_exit(spmi_controller_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("1.0");
+MODULE_ALIAS("platform:spmi_controller");
diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index 88bdf5655d20..49ce28ff55b2 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -1,16 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# to be placed at drivers/spmi
-config SPMI_HISI3670
-	tristate "Hisilicon 3670 SPMI Controller"
-	select IRQ_DOMAIN_HIERARCHY
-	depends on HAS_IOMEM
-	depends on SPMI
-	help
-	  If you say yes to this option, support will be included for the
-	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
-	  processors.
-
 # to be placed at drivers/mfd
 config MFD_HI6421_SPMI
 	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
index 9371dcc3d35b..347880fd378f 100644
--- a/drivers/staging/hikey9xx/Makefile
+++ b/drivers/staging/hikey9xx/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_SPMI_HISI3670)		+= hisi-spmi-controller.o
 obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
 obj-$(CONFIG_REGULATOR_HI6421V600)	+= hi6421v600-regulator.o
diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
deleted file mode 100644
index 0d42bc65f39b..000000000000
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ /dev/null
@@ -1,367 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include <linux/spmi.h>
-
-/*
- * SPMI register addr
- */
-#define SPMI_CHANNEL_OFFSET				0x0300
-#define SPMI_SLAVE_OFFSET				0x20
-
-#define SPMI_APB_SPMI_CMD_BASE_ADDR			0x0100
-
-#define SPMI_APB_SPMI_WDATA0_BASE_ADDR			0x0104
-#define SPMI_APB_SPMI_WDATA1_BASE_ADDR			0x0108
-#define SPMI_APB_SPMI_WDATA2_BASE_ADDR			0x010c
-#define SPMI_APB_SPMI_WDATA3_BASE_ADDR			0x0110
-
-#define SPMI_APB_SPMI_STATUS_BASE_ADDR			0x0200
-
-#define SPMI_APB_SPMI_RDATA0_BASE_ADDR			0x0204
-#define SPMI_APB_SPMI_RDATA1_BASE_ADDR			0x0208
-#define SPMI_APB_SPMI_RDATA2_BASE_ADDR			0x020c
-#define SPMI_APB_SPMI_RDATA3_BASE_ADDR			0x0210
-
-#define SPMI_PER_DATAREG_BYTE				4
-/*
- * SPMI cmd register
- */
-#define SPMI_APB_SPMI_CMD_EN				BIT(31)
-#define SPMI_APB_SPMI_CMD_TYPE_OFFSET			24
-#define SPMI_APB_SPMI_CMD_LENGTH_OFFSET			20
-#define SPMI_APB_SPMI_CMD_SLAVEID_OFFSET		16
-#define SPMI_APB_SPMI_CMD_ADDR_OFFSET			0
-
-/* Command Opcodes */
-
-enum spmi_controller_cmd_op_code {
-	SPMI_CMD_REG_ZERO_WRITE = 0,
-	SPMI_CMD_REG_WRITE = 1,
-	SPMI_CMD_REG_READ = 2,
-	SPMI_CMD_EXT_REG_WRITE = 3,
-	SPMI_CMD_EXT_REG_READ = 4,
-	SPMI_CMD_EXT_REG_WRITE_L = 5,
-	SPMI_CMD_EXT_REG_READ_L = 6,
-	SPMI_CMD_REG_RESET = 7,
-	SPMI_CMD_REG_SLEEP = 8,
-	SPMI_CMD_REG_SHUTDOWN = 9,
-	SPMI_CMD_REG_WAKEUP = 10,
-};
-
-/*
- * SPMI status register
- */
-#define SPMI_APB_TRANS_DONE			BIT(0)
-#define SPMI_APB_TRANS_FAIL			BIT(2)
-
-/* Command register fields */
-#define SPMI_CONTROLLER_CMD_MAX_BYTE_COUNT	16
-
-/* Maximum number of support PMIC peripherals */
-#define SPMI_CONTROLLER_TIMEOUT_US		1000
-#define SPMI_CONTROLLER_MAX_TRANS_BYTES		16
-
-struct spmi_controller_dev {
-	struct spmi_controller	*controller;
-	struct device		*dev;
-	void __iomem		*base;
-	spinlock_t		lock;
-	u32			channel;
-};
-
-static int spmi_controller_wait_for_done(struct device *dev,
-					 struct spmi_controller_dev *ctrl_dev,
-					 void __iomem *base, u8 sid, u16 addr)
-{
-	u32 timeout = SPMI_CONTROLLER_TIMEOUT_US;
-	u32 status, offset;
-
-	offset  = SPMI_APB_SPMI_STATUS_BASE_ADDR;
-	offset += SPMI_CHANNEL_OFFSET * ctrl_dev->channel + SPMI_SLAVE_OFFSET * sid;
-
-	do {
-		status = readl(base + offset);
-
-		if (status & SPMI_APB_TRANS_DONE) {
-			if (status & SPMI_APB_TRANS_FAIL) {
-				dev_err(dev, "%s: transaction failed (0x%x)\n",
-					__func__, status);
-				return -EIO;
-			}
-			dev_dbg(dev, "%s: status 0x%x\n", __func__, status);
-			return 0;
-		}
-		udelay(1);
-	} while (timeout--);
-
-	dev_err(dev, "%s: timeout, status 0x%x\n", __func__, status);
-	return -ETIMEDOUT;
-}
-
-static int spmi_read_cmd(struct spmi_controller *ctrl,
-			 u8 opc, u8 slave_id, u16 slave_addr, u8 *__buf, size_t bc)
-{
-	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
-	u32 chnl_ofst = SPMI_CHANNEL_OFFSET * spmi_controller->channel;
-	unsigned long flags;
-	u8 *buf = __buf;
-	u32 cmd, data;
-	int rc;
-	u8 op_code, i;
-
-	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
-		dev_err(&ctrl->dev,
-			"spmi_controller supports 1..%d bytes per trans, but:%zu requested\n",
-			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
-		return  -EINVAL;
-	}
-
-	switch (opc) {
-	case SPMI_CMD_READ:
-		op_code = SPMI_CMD_REG_READ;
-		break;
-	case SPMI_CMD_EXT_READ:
-		op_code = SPMI_CMD_EXT_REG_READ;
-		break;
-	case SPMI_CMD_EXT_READL:
-		op_code = SPMI_CMD_EXT_REG_READ_L;
-		break;
-	default:
-		dev_err(&ctrl->dev, "invalid read cmd 0x%x\n", opc);
-		return -EINVAL;
-	}
-
-	cmd = SPMI_APB_SPMI_CMD_EN |
-	     (op_code << SPMI_APB_SPMI_CMD_TYPE_OFFSET) |
-	     ((bc - 1) << SPMI_APB_SPMI_CMD_LENGTH_OFFSET) |
-	     ((slave_id & 0xf) << SPMI_APB_SPMI_CMD_SLAVEID_OFFSET) |  /* slvid */
-	     ((slave_addr & 0xffff)  << SPMI_APB_SPMI_CMD_ADDR_OFFSET); /* slave_addr */
-
-	spin_lock_irqsave(&spmi_controller->lock, flags);
-
-	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
-
-	rc = spmi_controller_wait_for_done(&ctrl->dev, spmi_controller,
-					   spmi_controller->base, slave_id, slave_addr);
-	if (rc)
-		goto done;
-
-	for (i = 0; bc > i * SPMI_PER_DATAREG_BYTE; i++) {
-		data = readl(spmi_controller->base + chnl_ofst +
-			     SPMI_SLAVE_OFFSET * slave_id +
-			     SPMI_APB_SPMI_RDATA0_BASE_ADDR +
-			     i * SPMI_PER_DATAREG_BYTE);
-		data = be32_to_cpu((__be32 __force)data);
-		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
-			memcpy(buf, &data, sizeof(data));
-			buf += sizeof(data);
-		} else {
-			memcpy(buf, &data, bc % SPMI_PER_DATAREG_BYTE);
-			buf += (bc % SPMI_PER_DATAREG_BYTE);
-		}
-	}
-
-done:
-	spin_unlock_irqrestore(&spmi_controller->lock, flags);
-	if (rc)
-		dev_err(&ctrl->dev,
-			"spmi read wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%zu\n",
-			opc, slave_id, slave_addr, bc + 1);
-	else
-		dev_dbg(&ctrl->dev, "%s: id:%d slave_addr:0x%x, read value: %*ph\n",
-			__func__, slave_id, slave_addr, (int)bc, __buf);
-
-	return rc;
-}
-
-static int spmi_write_cmd(struct spmi_controller *ctrl,
-			  u8 opc, u8 slave_id, u16 slave_addr, const u8 *__buf, size_t bc)
-{
-	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
-	u32 chnl_ofst = SPMI_CHANNEL_OFFSET * spmi_controller->channel;
-	const u8 *buf = __buf;
-	unsigned long flags;
-	u32 cmd, data;
-	int rc;
-	u8 op_code, i;
-
-	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
-		dev_err(&ctrl->dev,
-			"spmi_controller supports 1..%d bytes per trans, but:%zu requested\n",
-			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
-		return  -EINVAL;
-	}
-
-	switch (opc) {
-	case SPMI_CMD_WRITE:
-		op_code = SPMI_CMD_REG_WRITE;
-		break;
-	case SPMI_CMD_EXT_WRITE:
-		op_code = SPMI_CMD_EXT_REG_WRITE;
-		break;
-	case SPMI_CMD_EXT_WRITEL:
-		op_code = SPMI_CMD_EXT_REG_WRITE_L;
-		break;
-	default:
-		dev_err(&ctrl->dev, "invalid write cmd 0x%x\n", opc);
-		return -EINVAL;
-	}
-
-	cmd = SPMI_APB_SPMI_CMD_EN |
-	      (op_code << SPMI_APB_SPMI_CMD_TYPE_OFFSET) |
-	      ((bc - 1) << SPMI_APB_SPMI_CMD_LENGTH_OFFSET) |
-	      ((slave_id & 0xf) << SPMI_APB_SPMI_CMD_SLAVEID_OFFSET) |
-	      ((slave_addr & 0xffff)  << SPMI_APB_SPMI_CMD_ADDR_OFFSET);
-
-	/* Write data to FIFOs */
-	spin_lock_irqsave(&spmi_controller->lock, flags);
-
-	for (i = 0; bc > i * SPMI_PER_DATAREG_BYTE; i++) {
-		data = 0;
-		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
-			memcpy(&data, buf, sizeof(data));
-			buf += sizeof(data);
-		} else {
-			memcpy(&data, buf, bc % SPMI_PER_DATAREG_BYTE);
-			buf += (bc % SPMI_PER_DATAREG_BYTE);
-		}
-
-		writel((u32 __force)cpu_to_be32(data),
-		       spmi_controller->base + chnl_ofst +
-		       SPMI_APB_SPMI_WDATA0_BASE_ADDR +
-		       SPMI_PER_DATAREG_BYTE * i);
-	}
-
-	/* Start the transaction */
-	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
-
-	rc = spmi_controller_wait_for_done(&ctrl->dev, spmi_controller,
-					   spmi_controller->base, slave_id,
-					   slave_addr);
-	spin_unlock_irqrestore(&spmi_controller->lock, flags);
-
-	if (rc)
-		dev_err(&ctrl->dev, "spmi write wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%zu\n",
-			opc, slave_id, slave_addr, bc);
-	else
-		dev_dbg(&ctrl->dev, "%s: id:%d slave_addr:0x%x, wrote value: %*ph\n",
-			__func__, slave_id, slave_addr, (int)bc, __buf);
-
-	return rc;
-}
-
-static int spmi_controller_probe(struct platform_device *pdev)
-{
-	struct spmi_controller_dev *spmi_controller;
-	struct spmi_controller *ctrl;
-	struct resource *iores;
-	int ret;
-
-	ctrl = spmi_controller_alloc(&pdev->dev, sizeof(*spmi_controller));
-	if (!ctrl) {
-		dev_err(&pdev->dev, "can not allocate spmi_controller data\n");
-		return -ENOMEM;
-	}
-	spmi_controller = spmi_controller_get_drvdata(ctrl);
-	spmi_controller->controller = ctrl;
-
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores) {
-		dev_err(&pdev->dev, "can not get resource!\n");
-		ret = -EINVAL;
-		goto err_put_controller;
-	}
-
-	spmi_controller->base = devm_ioremap(&pdev->dev, iores->start,
-					     resource_size(iores));
-	if (!spmi_controller->base) {
-		dev_err(&pdev->dev, "can not remap base addr!\n");
-		ret = -EADDRNOTAVAIL;
-		goto err_put_controller;
-	}
-
-	ret = of_property_read_u32(pdev->dev.of_node, "spmi-channel",
-				   &spmi_controller->channel);
-	if (ret) {
-		dev_err(&pdev->dev, "can not get channel\n");
-		ret = -ENODEV;
-		goto err_put_controller;
-	}
-
-	platform_set_drvdata(pdev, spmi_controller);
-	dev_set_drvdata(&ctrl->dev, spmi_controller);
-
-	spin_lock_init(&spmi_controller->lock);
-
-	ctrl->nr = spmi_controller->channel;
-	ctrl->dev.parent = pdev->dev.parent;
-	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
-
-	/* Callbacks */
-	ctrl->read_cmd = spmi_read_cmd;
-	ctrl->write_cmd = spmi_write_cmd;
-
-	ret = spmi_controller_add(ctrl);
-	if (ret) {
-		dev_err(&pdev->dev, "spmi_controller_add failed with error %d!\n", ret);
-		goto err_put_controller;
-	}
-
-	return 0;
-
-err_put_controller:
-	spmi_controller_put(ctrl);
-	return ret;
-}
-
-static int spmi_del_controller(struct platform_device *pdev)
-{
-	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
-
-	spmi_controller_remove(ctrl);
-	spmi_controller_put(ctrl);
-	return 0;
-}
-
-static const struct of_device_id spmi_controller_match_table[] = {
-	{
-		.compatible = "hisilicon,kirin970-spmi-controller",
-	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, spmi_controller_match_table);
-
-static struct platform_driver spmi_controller_driver = {
-	.probe		= spmi_controller_probe,
-	.remove		= spmi_del_controller,
-	.driver		= {
-		.name	= "hisi_spmi_controller",
-		.of_match_table = spmi_controller_match_table,
-	},
-};
-
-static int __init spmi_controller_init(void)
-{
-	return platform_driver_register(&spmi_controller_driver);
-}
-postcore_initcall(spmi_controller_init);
-
-static void __exit spmi_controller_exit(void)
-{
-	platform_driver_unregister(&spmi_controller_driver);
-}
-module_exit(spmi_controller_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_VERSION("1.0");
-MODULE_ALIAS("platform:spmi_controller");
diff --git a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
deleted file mode 100644
index 6b755039a74c..000000000000
--- a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
+++ /dev/null
@@ -1,71 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/spmi/hisilicon,hisi-spmi-controller.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: HiSilicon SPMI controller
-
-maintainers:
-  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
-
-description: |
-  The HiSilicon SPMI BUS controller is found on some Kirin-based designs.
-  It is a MIPI System Power Management (SPMI) controller.
-
-  The PMIC part is provided by
-  drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
-
-allOf:
-  - $ref: spmi.yaml#
-
-properties:
-
-  $nodename:
-    pattern: "spmi@[0-9a-f]"
-
-  compatible:
-    const: hisilicon,kirin970-spmi-controller
-
-  reg:
-    maxItems: 1
-
-  spmi-channel:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      number of the Kirin 970 SPMI channel where the SPMI devices are connected.
-
-required:
-  - compatible
-  - reg
-  - spmi-channel
-
-patternProperties:
-  "@[0-9a-f]$":
-    description: |
-      PMIC properties, which are specific to the used SPMI PMIC device(s).
-      When used in combination with HiSilicon 6421v600, the properties
-      are documented at
-      drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    bus {
-      #address-cells = <2>;
-      #size-cells = <2>;
-
-      spmi: spmi@fff24000 {
-        compatible = "hisilicon,kirin970-spmi-controller";
-        #address-cells = <2>;
-        #size-cells = <0>;
-        reg = <0x0 0xfff24000 0x0 0x1000>;
-        spmi-channel = <2>;
-
-        pmic@0 {
-          reg = <0 0>;
-          /* pmic properties */
-        };
-      };
-    };
-- 
2.30.2

