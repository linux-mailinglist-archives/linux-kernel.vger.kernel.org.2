Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865FD3D3B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhGWNPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:15:25 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33675 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhGWNPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:15:24 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 84BE51BF208;
        Fri, 23 Jul 2021 13:55:55 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] regmap: add regmap using ARM SMCCC
Date:   Fri, 23 Jul 2021 15:52:37 +0200
Message-Id: <20210723135239.388325-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723135239.388325-1-clement.leger@bootlin.com>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running under secure monitor control, some controllers can be placed in
secure world and their access is thus not possible from normal world. However,
these controllers frequently contain registers than are needed by the normal
world for a few specific operations.

This patch adds a regmap where registers are accessed using SMCs. The secure
monitor is then responsible to allow or deny access to the requested registers.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/base/regmap/Kconfig        |   7 +-
 drivers/base/regmap/Makefile       |   1 +
 drivers/base/regmap/regmap-smccc.c | 131 +++++++++++++++++++++++++++++
 include/linux/regmap.h             |  38 +++++++++
 4 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-smccc.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 159bac6c5046..6957a6b21ad9 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -4,7 +4,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_MDIO)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_MDIO || REGMAP_SMCCC)
 	select IRQ_DOMAIN if REGMAP_IRQ
 	select MDIO_BUS if REGMAP_MDIO
 	bool
@@ -65,3 +65,8 @@ config REGMAP_I3C
 config REGMAP_SPI_AVMM
 	tristate
 	depends on SPI
+
+config REGMAP_SMCCC
+	default y if HAVE_ARM_SMCCC_DISCOVERY
+	tristate
+	depends on HAVE_ARM_SMCCC_DISCOVERY
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 11facb32a027..3d92503a3b4e 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
 obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
 obj-$(CONFIG_REGMAP_SPI_AVMM) += regmap-spi-avmm.o
 obj-$(CONFIG_REGMAP_MDIO) += regmap-mdio.o
+obj-$(CONFIG_REGMAP_SMCCC) += regmap-smccc.o
diff --git a/drivers/base/regmap/regmap-smccc.c b/drivers/base/regmap/regmap-smccc.c
new file mode 100644
index 000000000000..a64d58f97d21
--- /dev/null
+++ b/drivers/base/regmap/regmap-smccc.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2021 Bootlin
+
+#include <linux/arm-smccc.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define REGMAP_SMC_READ		0
+#define REGMAP_SMC_WRITE	1
+
+struct regmap_smccc_ctx {
+	u32 regmap_smc_id;
+};
+
+static int regmap_smccc_reg_write(void *context, unsigned int reg,
+				  unsigned int val)
+{
+	struct regmap_smccc_ctx *ctx = context;
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ctx->regmap_smc_id, REGMAP_SMC_WRITE, reg, val,
+			     &res);
+
+	if (res.a0)
+		return -EACCES;
+
+	return 0;
+}
+
+static int regmap_smccc_reg_read(void *context, unsigned int reg,
+				 unsigned int *val)
+{
+	struct regmap_smccc_ctx *ctx = context;
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ctx->regmap_smc_id, REGMAP_SMC_READ, reg, &res);
+
+	if (res.a0)
+		return -EACCES;
+
+	*val = res.a1;
+
+	return 0;
+}
+
+static struct regmap_bus regmap_smccc = {
+	.reg_write = regmap_smccc_reg_write,
+	.reg_read = regmap_smccc_reg_read,
+};
+
+static int regmap_smccc_bits_is_supported(int val_bits)
+{
+	switch (val_bits) {
+	case 8:
+	case 16:
+	case 32:
+		return 0;
+	case 64:
+	/*
+	 * SMCs are using registers to pass information so if architecture is
+	 * not using 64 bits registers, we won't be able to pass information
+	 * transparently.
+	 */
+#if !defined(CONFIG_64BIT)
+		return -EINVAL;
+#else
+		return 0;
+#endif
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct regmap_smccc_ctx *smccc_regmap_init_ctx(
+					const struct regmap_config *config,
+					u32 regmap_smc_id)
+{
+	int ret;
+	struct regmap_smccc_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ret = regmap_smccc_bits_is_supported(config->val_bits);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ctx->regmap_smc_id = regmap_smc_id;
+
+	return ctx;
+}
+
+struct regmap *__regmap_init_smccc(struct device *dev, u32 regmap_smc_id,
+				   const struct regmap_config *config,
+				   struct lock_class_key *lock_key,
+				   const char *lock_name)
+{
+	struct regmap_smccc_ctx *ctx;
+
+	ctx = smccc_regmap_init_ctx(config, regmap_smc_id);
+	if (IS_ERR(ctx))
+		return ERR_CAST(ctx);
+
+	return __regmap_init(dev, &regmap_smccc, ctx, config, lock_key,
+			     lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_smccc);
+
+struct regmap *__devm_regmap_init_smccc(struct device *dev, u32 regmap_smc_id,
+					const struct regmap_config *config,
+					struct lock_class_key *lock_key,
+					const char *lock_name)
+{
+	struct regmap_smccc_ctx *ctx;
+
+	ctx = smccc_regmap_init_ctx(config, regmap_smc_id);
+	if (IS_ERR(ctx))
+		return ERR_CAST(ctx);
+
+	return __devm_regmap_init(dev, &regmap_smccc, ctx, config, lock_key,
+				  lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_smccc);
+
+MODULE_AUTHOR("Clément Léger <clement.leger@bootlin.com>");
+MODULE_DESCRIPTION("Regmap SMCCC Module");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f5f08dd0a116..08aa523403e8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -591,6 +591,11 @@ struct regmap *__regmap_init_spi_avmm(struct spi_device *spi,
 				      struct lock_class_key *lock_key,
 				      const char *lock_name);
 
+struct regmap *__regmap_init_smccc(struct device *dev, u32 regmap_smc_id,
+				   const struct regmap_config *config,
+				   struct lock_class_key *lock_key,
+				   const char *lock_name);
+
 struct regmap *__devm_regmap_init(struct device *dev,
 				  const struct regmap_bus *bus,
 				  void *bus_context,
@@ -655,6 +660,10 @@ struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
 					   const struct regmap_config *config,
 					   struct lock_class_key *lock_key,
 					   const char *lock_name);
+struct regmap *__devm_regmap_init_smccc(struct device *dev, u32 regmap_smc_id,
+					const struct regmap_config *config,
+					struct lock_class_key *lock_key,
+					const char *lock_name);
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
  * for each call. No-op if CONFIG_LOCKDEP is not set.
@@ -881,6 +890,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__regmap_init_spi_avmm, #config,		\
 				 spi, config)
 
+/**
+ * regmap_init_smccc() - Initialize register map for ARM SMCCC
+ *
+ * @dev: Device that will be interacted with
+ * @smc_id: SMC id to used for calls
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.
+ */
+#define regmap_init_smccc(dev, smc_id, config)			\
+	__regmap_lockdep_wrapper(__regmap_init_smccc, #config,	\
+				 dev, smc_id, config)
+
 /**
  * devm_regmap_init() - Initialise managed register map
  *
@@ -1110,6 +1133,21 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_spi_avmm, #config,	\
 				 spi, config)
 
+/**
+ * devm_regmap_init_smccc() - Initialize register map for ARM SMCCC
+ *
+ * @dev: Device that will be interacted with
+ * @smc_id: SMC id to used for calls
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The map will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_smccc(dev, smc_id, config)			\
+	__regmap_lockdep_wrapper(__devm_regmap_init_smccc, #config,	\
+				 dev, smc_id, config)
+
 int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
 void regmap_mmio_detach_clk(struct regmap *map);
 void regmap_exit(struct regmap *map);
-- 
2.32.0

