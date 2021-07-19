Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D23CD415
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbhGSLFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230493AbhGSLFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:05:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C458960FEA;
        Mon, 19 Jul 2021 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626695142;
        bh=S8+v1EflFeObe21Jv7ugFHoCI+f6RQZQJ9Qn2ifRGRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BIKSc1YSuHsMx2jePR5Yhu2C571/bBbzJJ1oZ0djIqwhFiBZLgp6uylB+DoVXva+T
         ePwETH7RpoKczr4P113UY+YP8ay7J1/L9cJkhGpnR+fvCa0BZ8mzoLEAlKfGQSIB/n
         kIeMLKnOpbJPJ5hyim/+keqKG9SWbNi/FLbxqVZRUPWGWBbyOicyFnABycGFtd2c3d
         zZnuqHxQly/6dJ8uo6tSokfcWZ7M9YzHh/eOZQUTXoSo2Lc8ScV57AgS2wIXOdcUD7
         IKieO8BHVV2t2+SeZJHh1YcyphskENHxGewqGKhnbJ8FMknZZFeuw8jmEHFMSBfQfy
         PKkGmBlaThDkA==
Date:   Mon, 19 Jul 2021 13:45:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v14 7/9] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210719134537.0cab0827@coco.lan>
In-Reply-To: <YPVaCCu498lNY9a2@google.com>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
        <6c64fa6abae6c9fa78ace1bf240b33b47eccae52.1626515862.git.mchehab+huawei@kernel.org>
        <YPVaCCu498lNY9a2@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 19 Jul 2021 11:55:04 +0100
Lee Jones <lee.jones@linaro.org> escreveu:

> On Sat, 17 Jul 2021, Mauro Carvalho Chehab wrote:
> 
> > This driver is ready for mainstream. So, move it out of staging.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../mfd}/hisilicon,hi6421-spmi-pmic.yaml      |  0
> >  MAINTAINERS                                   |  7 +++++++
> >  drivers/mfd/Kconfig                           | 16 ++++++++++++++++
> >  drivers/mfd/Makefile                          |  1 +
> >  .../hikey9xx => mfd}/hi6421-spmi-pmic.c       |  0  
> 
> I *still* can't review this without firstly seeing it.

Thanks,
Mauro

[PATCH v14 7/9] mfd: hi6421-spmi-pmic: move driver from staging

This driver is ready for mainstream. So, move it out of staging.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
new file mode 100644
index 000000000000..b06131504d75
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/hisilicon,hi6421-spmi-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon 6421v600 SPMI PMIC
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description: |
+  HiSilicon 6421v600 should be connected inside a MIPI System Power Management
+  (SPMI) bus. It provides interrupts and power supply.
+
+  The GPIO and interrupt settings are represented as part of the top-level PMIC
+  node.
+
+  The SPMI controller part is provided by
+  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]"
+
+  compatible:
+    const: hisilicon,hi6421v600-spmi
+
+  reg:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  interrupts:
+    maxItems: 1
+    description: GPIO used for IRQs
+
+  regulators:
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^(ldo|LDO)[0-9]+$':
+        type: object
+
+        $ref: "/schemas/regulator/regulator.yaml#"
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    /* pmic properties */
+
+    pmic: pmic@0 {
+      compatible = "hisilicon,hi6421v600-spmi";
+      reg = <0 0>;
+
+      #interrupt-cells = <2>;
+      interrupt-controller;
+      interrupts = <&gpio28 0 0>;
+
+      regulators {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ldo3: LDO3 {
+          regulator-name = "ldo3";
+          regulator-min-microvolt = <1500000>;
+          regulator-max-microvolt = <2000000>;
+          regulator-boot-on;
+        };
+
+        ldo4: LDO4 {
+          regulator-name = "ldo4";
+          regulator-min-microvolt = <1725000>;
+          regulator-max-microvolt = <1900000>;
+          regulator-boot-on;
+        };
+
+        ldo9: LDO9 {
+          regulator-name = "ldo9";
+          regulator-min-microvolt = <1750000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-boot-on;
+        };
+
+        ldo15: LDO15 {
+          regulator-name = "ldo15";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <3000000>;
+          regulator-always-on;
+        };
+
+        ldo16: LDO16 {
+          regulator-name = "ldo16";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <3000000>;
+          regulator-boot-on;
+        };
+
+        ldo17: LDO17 {
+          regulator-name = "ldo17";
+          regulator-min-microvolt = <2500000>;
+          regulator-max-microvolt = <3300000>;
+        };
+
+        ldo33: LDO33 {
+          regulator-name = "ldo33";
+          regulator-min-microvolt = <2500000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-boot-on;
+        };
+
+        ldo34: LDO34 {
+          regulator-name = "ldo34";
+          regulator-min-microvolt = <2600000>;
+          regulator-max-microvolt = <3300000>;
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3b78a9..4529cf5ed430 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8432,6 +8432,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
 F:	drivers/spmi/hisi-spmi-controller.c
 
+HISILICON SPMI PMIC DRIVER FOR HIKEY 6421v600
+M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+F:	drivers/mfd/hi6421-spmi-pmic.c
+
 HISILICON STAGING DRIVERS FOR HIKEY 960/970
 M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 S:	Maintained
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..01bb42f0ca0b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -510,6 +510,22 @@ config MFD_HI6421_PMIC
 	  menus in order to enable them.
 	  We communicate with the Hi6421 via memory-mapped I/O.
 
+config MFD_HI6421_SPMI
+	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
+	depends on OF
+	depends on SPMI
+	select MFD_CORE
+	select REGMAP_SPMI
+	help
+	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
+	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
+	  etc.
+
+	  This driver includes core APIs _only_. You have to select
+	  individual components like voltage regulators under corresponding
+	  menus in order to enable them.
+	  We communicate with the Hi6421v600 via a SPMI bus.
+
 config MFD_HI655X_PMIC
 	tristate "HiSilicon Hi655X series PMU/Codec IC"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8116c19d5fd4..570b9ffb34d0 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -231,6 +231,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
+obj-$(CONFIG_MFD_HI6421_SPMI)	+= hi6421-spmi-pmic.o
 obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
 obj-$(CONFIG_MFD_RT4831)	+= rt4831.o
diff --git a/drivers/mfd/hi6421-spmi-pmic.c b/drivers/mfd/hi6421-spmi-pmic.c
new file mode 100644
index 000000000000..c9c0c3d7011f
--- /dev/null
+++ b/drivers/mfd/hi6421-spmi-pmic.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for regulators in HISI PMIC IC
+ *
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2011 Hisilicon.
+ * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
+ */
+
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spmi.h>
+
+static const struct mfd_cell hi6421v600_devs[] = {
+	{ .name = "hi6421v600-irq", },
+	{ .name = "hi6421v600-regulator", },
+};
+
+static const struct regmap_config regmap_config = {
+	.reg_bits	= 16,
+	.val_bits	= BITS_PER_BYTE,
+	.max_register	= 0xffff,
+	.fast_io	= true
+};
+
+static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_spmi_ext(sdev, &regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	dev_set_drvdata(&sdev->dev, regmap);
+
+	ret = devm_mfd_add_devices(&sdev->dev, PLATFORM_DEVID_NONE,
+				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
+				   NULL, 0, NULL);
+	if (ret < 0)
+		dev_err(dev, "Failed to add child devices: %d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id pmic_spmi_id_table[] = {
+	{ .compatible = "hisilicon,hi6421-spmi" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
+
+static struct spmi_driver hi6421_spmi_pmic_driver = {
+	.driver = {
+		.name	= "hi6421-spmi-pmic",
+		.of_match_table = pmic_spmi_id_table,
+	},
+	.probe	= hi6421_spmi_pmic_probe,
+};
+module_spmi_driver(hi6421_spmi_pmic_driver);
+
+MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index c8eaae6412bb..03ee99d98945 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -102,6 +102,4 @@ source "drivers/staging/qlge/Kconfig"
 
 source "drivers/staging/wfx/Kconfig"
 
-source "drivers/staging/hikey9xx/Kconfig"
-
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 818b6f964369..9a4c0e6f34d5 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -41,4 +41,3 @@ obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
 obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_WFX)		+= wfx/
-obj-y				+= hikey9xx/
diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
deleted file mode 100644
index 9f53df9068fe..000000000000
--- a/drivers/staging/hikey9xx/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-# to be placed at drivers/mfd
-config MFD_HI6421_SPMI
-	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
-	depends on HAS_IOMEM
-	depends on OF
-	depends on SPMI
-	select MFD_CORE
-	select REGMAP_SPMI
-	help
-	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
-	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
-	  etc.
-
-	  This driver includes core APIs _only_. You have to select
-	  individual components like voltage regulators under corresponding
-	  menus in order to enable them.
-	  We communicate with the Hi6421v600 via a SPMI bus.
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
deleted file mode 100644
index e3108d7dd849..000000000000
--- a/drivers/staging/hikey9xx/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
diff --git a/drivers/staging/hikey9xx/TODO b/drivers/staging/hikey9xx/TODO
deleted file mode 100644
index 65e7996a3066..000000000000
--- a/drivers/staging/hikey9xx/TODO
+++ /dev/null
@@ -1,5 +0,0 @@
-ToDo list:
-
-- Port other drivers needed by Hikey 960/970;
-- Test drivers on Hikey 960;
-- Validate device tree bindings.
diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
deleted file mode 100644
index c9c0c3d7011f..000000000000
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device driver for regulators in HISI PMIC IC
- *
- * Copyright (c) 2013 Linaro Ltd.
- * Copyright (c) 2011 Hisilicon.
- * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
- */
-
-#include <linux/mfd/core.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/slab.h>
-#include <linux/spmi.h>
-
-static const struct mfd_cell hi6421v600_devs[] = {
-	{ .name = "hi6421v600-irq", },
-	{ .name = "hi6421v600-regulator", },
-};
-
-static const struct regmap_config regmap_config = {
-	.reg_bits	= 16,
-	.val_bits	= BITS_PER_BYTE,
-	.max_register	= 0xffff,
-	.fast_io	= true
-};
-
-static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
-{
-	struct device *dev = &sdev->dev;
-	struct regmap *regmap;
-	int ret;
-
-	regmap = devm_regmap_init_spmi_ext(sdev, &regmap_config);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
-
-	dev_set_drvdata(&sdev->dev, regmap);
-
-	ret = devm_mfd_add_devices(&sdev->dev, PLATFORM_DEVID_NONE,
-				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
-				   NULL, 0, NULL);
-	if (ret < 0)
-		dev_err(dev, "Failed to add child devices: %d\n", ret);
-
-	return ret;
-}
-
-static const struct of_device_id pmic_spmi_id_table[] = {
-	{ .compatible = "hisilicon,hi6421-spmi" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
-
-static struct spmi_driver hi6421_spmi_pmic_driver = {
-	.driver = {
-		.name	= "hi6421-spmi-pmic",
-		.of_match_table = pmic_spmi_id_table,
-	},
-	.probe	= hi6421_spmi_pmic_probe,
-};
-module_spmi_driver(hi6421_spmi_pmic_driver);
-
-MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
deleted file mode 100644
index b06131504d75..000000000000
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ /dev/null
@@ -1,138 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/mfd/hisilicon,hi6421-spmi-pmic.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: HiSilicon 6421v600 SPMI PMIC
-
-maintainers:
-  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
-
-description: |
-  HiSilicon 6421v600 should be connected inside a MIPI System Power Management
-  (SPMI) bus. It provides interrupts and power supply.
-
-  The GPIO and interrupt settings are represented as part of the top-level PMIC
-  node.
-
-  The SPMI controller part is provided by
-  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
-
-properties:
-  $nodename:
-    pattern: "pmic@[0-9a-f]"
-
-  compatible:
-    const: hisilicon,hi6421v600-spmi
-
-  reg:
-    maxItems: 1
-
-  '#interrupt-cells':
-    const: 2
-
-  interrupt-controller: true
-
-  interrupts:
-    maxItems: 1
-    description: GPIO used for IRQs
-
-  regulators:
-    type: object
-
-    additionalProperties: false
-
-    properties:
-      '#address-cells':
-        const: 1
-
-      '#size-cells':
-        const: 0
-
-    patternProperties:
-      '^(ldo|LDO)[0-9]+$':
-        type: object
-
-        $ref: "/schemas/regulator/regulator.yaml#"
-
-        unevaluatedProperties: false
-
-required:
-  - compatible
-  - reg
-  - regulators
-
-additionalProperties: false
-
-examples:
-  - |
-    /* pmic properties */
-
-    pmic: pmic@0 {
-      compatible = "hisilicon,hi6421v600-spmi";
-      reg = <0 0>;
-
-      #interrupt-cells = <2>;
-      interrupt-controller;
-      interrupts = <&gpio28 0 0>;
-
-      regulators {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        ldo3: LDO3 {
-          regulator-name = "ldo3";
-          regulator-min-microvolt = <1500000>;
-          regulator-max-microvolt = <2000000>;
-          regulator-boot-on;
-        };
-
-        ldo4: LDO4 {
-          regulator-name = "ldo4";
-          regulator-min-microvolt = <1725000>;
-          regulator-max-microvolt = <1900000>;
-          regulator-boot-on;
-        };
-
-        ldo9: LDO9 {
-          regulator-name = "ldo9";
-          regulator-min-microvolt = <1750000>;
-          regulator-max-microvolt = <3300000>;
-          regulator-boot-on;
-        };
-
-        ldo15: LDO15 {
-          regulator-name = "ldo15";
-          regulator-min-microvolt = <1800000>;
-          regulator-max-microvolt = <3000000>;
-          regulator-always-on;
-        };
-
-        ldo16: LDO16 {
-          regulator-name = "ldo16";
-          regulator-min-microvolt = <1800000>;
-          regulator-max-microvolt = <3000000>;
-          regulator-boot-on;
-        };
-
-        ldo17: LDO17 {
-          regulator-name = "ldo17";
-          regulator-min-microvolt = <2500000>;
-          regulator-max-microvolt = <3300000>;
-        };
-
-        ldo33: LDO33 {
-          regulator-name = "ldo33";
-          regulator-min-microvolt = <2500000>;
-          regulator-max-microvolt = <3300000>;
-          regulator-boot-on;
-        };
-
-        ldo34: LDO34 {
-          regulator-name = "ldo34";
-          regulator-min-microvolt = <2600000>;
-          regulator-max-microvolt = <3300000>;
-        };
-      };
-    };
