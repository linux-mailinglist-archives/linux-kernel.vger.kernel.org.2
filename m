Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3181C3B3DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFYHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhFYHsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:48:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A7956141E;
        Fri, 25 Jun 2021 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624607172;
        bh=TAvbM46w8sj6Nb5Tj9IwtULr6oGl5UdmiitGy5INBaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neSNpv8A4dk13Z4Nubt4XrXx8Q21ZRAB3CJUNXbbf63wlEUBnwsL2wkGeYJtxzlin
         Di1m2+kZYirLHd3RbOpedNEoIF0cRmMBff1Juw5b98mxhX4obSW4y6hqHwjci3798g
         9WxoIqzrb9EpKUXlxjxi/xDSUYqOyduU4ylm+fDgrfBAJYmWmM5BIMAg6UZQhjvfWb
         WTsCxFOlAoGdDJ03OZ9XSUEq4c3SkMYNQVwBYt9Q74VR1lOc28+z4u+WJ+WabQVA6K
         eEvKuGBEYg3IxKJEI8clQl6kWRLlY3q6lhVe4ze/pY46el2hsOD+5HJvsZcJVs4ZR4
         y7g9o8TuS6BFA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwgXS-004ae9-BO; Fri, 25 Jun 2021 09:46:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v8 02/12] spmi: hisi-spmi-controller: move driver from staging
Date:   Fri, 25 Jun 2021 09:45:54 +0200
Message-Id: <35b9f9169889c1f4d51eff8bf2035450c9e02576.1624606660.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624606660.git.mchehab+huawei@kernel.org>
References: <cover.1624606660.git.mchehab+huawei@kernel.org>
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
 .../spmi/hisilicon,hisi-spmi-controller.yaml  |  73 ++++
 MAINTAINERS                                   |   7 +
 drivers/spmi/Kconfig                          |   9 +
 drivers/spmi/Makefile                         |   1 +
 drivers/spmi/hisi-spmi-controller.c           | 367 ++++++++++++++++++
 drivers/staging/hikey9xx/Kconfig              |  11 -
 drivers/staging/hikey9xx/Makefile             |   1 -
 .../staging/hikey9xx/hisi-spmi-controller.c   | 367 ------------------
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  |   2 +-
 .../hisilicon,hisi-spmi-controller.yaml       |  73 ----
 10 files changed, 458 insertions(+), 453 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
 create mode 100644 drivers/spmi/hisi-spmi-controller.c
 delete mode 100644 drivers/staging/hikey9xx/hisi-spmi-controller.c
 delete mode 100644 drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml

diff --git a/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
new file mode 100644
index 000000000000..f882903769f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
@@ -0,0 +1,73 @@
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
+  ./Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml.
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
+  hisilicon,spmi-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      number of the Kirin 970 SPMI channel where the SPMI devices are connected.
+
+required:
+  - compatible
+  - reg
+  - hisilicon,spmi-channel
+
+patternProperties:
+  "@[0-9a-f]$":
+    type: object
+
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
+        hisilicon,spmi-channel = <2>;
+
+        pmic@0 {
+          reg = <0 0>;
+          /* pmic properties */
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e01424234eb..9a69e3810964 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8284,6 +8284,13 @@ S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/spi/spi-hisi-kunpeng.c
 
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
index 000000000000..5bd23262abd6
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
+	ret = of_property_read_u32(pdev->dev.of_node, "hisilicon,spmi-channel",
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
index 3ceda03f2864..9f53df9068fe 100644
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
index 42d486104525..e3108d7dd849 100644
--- a/drivers/staging/hikey9xx/Makefile
+++ b/drivers/staging/hikey9xx/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_SPMI_HISI3670)		+= hisi-spmi-controller.o
 obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
deleted file mode 100644
index 5bd23262abd6..000000000000
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
-	ret = of_property_read_u32(pdev->dev.of_node, "hisilicon,spmi-channel",
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
diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index 3b23ad56b31a..d57316c57d7b 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -17,7 +17,7 @@ description: |
   node.
 
   The SPMI controller part is provided by
-  drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml.
+  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 
 properties:
   $nodename:
diff --git a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
deleted file mode 100644
index f882903769f9..000000000000
--- a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
+++ /dev/null
@@ -1,73 +0,0 @@
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
-  ./Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml.
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
-  hisilicon,spmi-channel:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      number of the Kirin 970 SPMI channel where the SPMI devices are connected.
-
-required:
-  - compatible
-  - reg
-  - hisilicon,spmi-channel
-
-patternProperties:
-  "@[0-9a-f]$":
-    type: object
-
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
-        hisilicon,spmi-channel = <2>;
-
-        pmic@0 {
-          reg = <0 0>;
-          /* pmic properties */
-        };
-      };
-    };
-- 
2.31.1

