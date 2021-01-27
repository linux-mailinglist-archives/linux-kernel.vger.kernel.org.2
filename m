Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040513063CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344343AbhA0TJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344219AbhA0TJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:09:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54DB460C40;
        Wed, 27 Jan 2021 19:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611774505;
        bh=QHElB4IuotiErmzHTV5vRkEYIOojN5IuXr8TRyo2Q4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/SNcC0d2VQewFT23zeyeov4Wkk6WZbQIZqEYgO7BELy65sXvNE2lcekHtUSwGgBH
         dv/FkQCxQ6duyE9p9mKrLUzHh7kD6vs+B3klpttvJhqPNGKwJEHlfC+a8F3WvHC/Fq
         ClDQkfNmgXPHROJf4ow6XW+fjUPmDJQSBHUmoTFrZuOFwHKERybH8A9/1J7t7I1Hyr
         Pi0M3lYYT773ttbrYIg27EJGHiGsBa//7FybUoQaOJQKmENBkXp1u/HT4Ihst+IvDG
         fnt9ckNchCMVT6MazQ862qekbJyQ1BVr+fdAG2F1s3sYdeCrHtrdLYBqYDnnPS7SYE
         loXcUrJjBRbjg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l4qAx-003n4r-1r; Wed, 27 Jan 2021 20:08:23 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mayulong <mayulong1@huawei.com>, Wang Hai <wanghai38@huawei.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/7] staging: hikey9xx: spmi driver: convert to regmap
Date:   Wed, 27 Jan 2021 20:08:16 +0100
Message-Id: <655e2416f2260a3edbf614613f7acf5558554b1c.1611773727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611773727.git.mchehab+huawei@kernel.org>
References: <cover.1611773727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of doing its own SPMI I/O implementation, use the
already-existing regmap one.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 115 ++++++------------
 .../staging/hikey9xx/hi6421v600-regulator.c   |  26 ++--
 include/linux/mfd/hi6421-spmi-pmic.h          |   7 +-
 3 files changed, 52 insertions(+), 96 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 69570876f93e..3d612bd46231 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -41,81 +41,22 @@ static const struct mfd_cell hi6421v600_devs[] = {
 	{ .name = "hi6421v600-regulator", },
 };
 
-/*
- * The PMIC register is only 8-bit.
- * Hisilicon SoC use hardware to map PMIC register into SoC mapping.
- * At here, we are accessing SoC register with 32-bit.
- */
-int hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg)
+static irqreturn_t hi6421_spmi_irq_handler(int irq, void *priv)
 {
-	struct spmi_device *pdev;
-	u8 read_value = 0;
-	u32 ret;
-
-	pdev = to_spmi_device(pmic->dev);
-	if (!pdev) {
-		pr_err("%s: pdev get failed!\n", __func__);
-		return -ENODEV;
-	}
-
-	ret = spmi_ext_register_readl(pdev, reg, &read_value, 1);
-	if (ret) {
-		pr_err("%s: spmi_ext_register_readl failed!\n", __func__);
-		return ret;
-	}
-	return read_value;
-}
-EXPORT_SYMBOL(hi6421_spmi_pmic_read);
-
-int hi6421_spmi_pmic_write(struct hi6421_spmi_pmic *pmic, int reg, u32 val)
-{
-	struct spmi_device *pdev;
-	u32 ret;
-
-	pdev = to_spmi_device(pmic->dev);
-	if (!pdev) {
-		pr_err("%s: pdev get failed!\n", __func__);
-		return -ENODEV;
-	}
-
-	ret = spmi_ext_register_writel(pdev, reg, (unsigned char *)&val, 1);
-	if (ret)
-		pr_err("%s: spmi_ext_register_writel failed!\n", __func__);
-
-	return ret;
-}
-EXPORT_SYMBOL(hi6421_spmi_pmic_write);
-
-int hi6421_spmi_pmic_rmw(struct hi6421_spmi_pmic *pmic, int reg,
-			 u32 mask, u32 bits)
-{
-	unsigned long flags;
-	u32 data;
-	int ret;
-
-	spin_lock_irqsave(&pmic->lock, flags);
-	data = hi6421_spmi_pmic_read(pmic, reg) & ~mask;
-	data |= mask & bits;
-	ret = hi6421_spmi_pmic_write(pmic, reg, data);
-	spin_unlock_irqrestore(&pmic->lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(hi6421_spmi_pmic_rmw);
-
-static irqreturn_t hi6421_spmi_irq_handler(int irq, void *data)
-{
-	struct hi6421_spmi_pmic *pmic = (struct hi6421_spmi_pmic *)data;
+	struct hi6421_spmi_pmic *pmic = (struct hi6421_spmi_pmic *)priv;
 	unsigned long pending;
+	unsigned int data;
 	int i, offset;
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
-		pending = hi6421_spmi_pmic_read(pmic, (i + SOC_PMIC_IRQ0_ADDR));
-		pending &= HISI_MASK_FIELD;
-		if (pending != 0)
-			pr_debug("pending[%d]=0x%lx\n\r", i, pending);
+		regmap_read(pmic->map, offset, &data);
+		data &= HISI_MASK_FIELD;
+		if (data != 0)
+			pr_debug("data[%d]=0x%d\n\r", i, data);
+		regmap_write(pmic->map, i + SOC_PMIC_IRQ0_ADDR, data);
 
-		hi6421_spmi_pmic_write(pmic, (i + SOC_PMIC_IRQ0_ADDR), pending);
+		/* for_each_set_bit() macro requires unsigned long */
+		pending = data;
 
 		/* solve powerkey order */
 		if ((i == HISI_IRQ_KEY_NUM) &&
@@ -137,16 +78,18 @@ static irqreturn_t hi6421_spmi_irq_handler(int irq, void *data)
 static void hi6421_spmi_irq_mask(struct irq_data *d)
 {
 	struct hi6421_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
-	u32 data, offset;
 	unsigned long flags;
+	unsigned int data;
+	u32 offset;
 
 	offset = (irqd_to_hwirq(d) >> 3);
 	offset += SOC_PMIC_IRQ_MASK_0_ADDR;
 
 	spin_lock_irqsave(&pmic->lock, flags);
-	data = hi6421_spmi_pmic_read(pmic, offset);
+
+	regmap_read(pmic->map, offset, &data);
 	data |= (1 << (irqd_to_hwirq(d) & 0x07));
-	hi6421_spmi_pmic_write(pmic, offset, data);
+	regmap_write(pmic->map, offset, data);
 	spin_unlock_irqrestore(&pmic->lock, flags);
 }
 
@@ -160,9 +103,9 @@ static void hi6421_spmi_irq_unmask(struct irq_data *d)
 	offset += SOC_PMIC_IRQ_MASK_0_ADDR;
 
 	spin_lock_irqsave(&pmic->lock, flags);
-	data = hi6421_spmi_pmic_read(pmic, offset);
+	regmap_read(pmic->map, offset, &data);
 	data &= ~(1 << (irqd_to_hwirq(d) & 0x07));
-	hi6421_spmi_pmic_write(pmic, offset, data);
+	regmap_write(pmic->map, offset, data);
 	spin_unlock_irqrestore(&pmic->lock, flags);
 }
 
@@ -194,27 +137,36 @@ static const struct irq_domain_ops hi6421_spmi_domain_ops = {
 
 static void hi6421_spmi_pmic_irq_prc(struct hi6421_spmi_pmic *pmic)
 {
-	int i, pending;
+	int i;
+	unsigned int pending;
 
 	for (i = 0 ; i < HISI_IRQ_ARRAY; i++)
-		hi6421_spmi_pmic_write(pmic, SOC_PMIC_IRQ_MASK_0_ADDR + i,
+		regmap_write(pmic->map, SOC_PMIC_IRQ_MASK_0_ADDR + i,
 				       HISI_MASK_STATE);
 
 	for (i = 0 ; i < HISI_IRQ_ARRAY; i++) {
-		pending = hi6421_spmi_pmic_read(pmic, SOC_PMIC_IRQ0_ADDR + i);
+		regmap_read(pmic->map, SOC_PMIC_IRQ0_ADDR + i, &pending);
 
 		pr_debug("PMU IRQ address value:irq[0x%x] = 0x%x\n",
 			 SOC_PMIC_IRQ0_ADDR + i, pending);
-		hi6421_spmi_pmic_write(pmic, SOC_PMIC_IRQ0_ADDR + i,
-				       HISI_MASK_STATE);
+		regmap_write(pmic->map, SOC_PMIC_IRQ0_ADDR + i,
+			     HISI_MASK_STATE);
 	}
 }
 
+static const struct regmap_config spmi_regmap_config = {
+	.reg_bits		= 16,
+	.val_bits		= 8,
+	.max_register		= 0xffff,
+	.fast_io		= true
+};
+
 static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct hi6421_spmi_pmic *pmic;
+	struct regmap *map;
 	unsigned int virq;
 	int ret, i;
 
@@ -222,9 +174,14 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 	if (!pmic)
 		return -ENOMEM;
 
+	map = devm_regmap_init_spmi_ext(pdev, &spmi_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
 	spin_lock_init(&pmic->lock);
 
 	pmic->dev = dev;
+	pmic->map = map;
 
 	pmic->gpio = of_get_gpio(np, 0);
 	if (pmic->gpio < 0)
diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 382a0b21643e..9e319fa11137 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/spmi.h>
 
@@ -100,7 +101,7 @@ static int hi6421_spmi_regulator_is_enabled(struct regulator_dev *rdev)
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
 
-	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->enable_reg);
+	regmap_read(pmic->map, rdev->desc->enable_reg, &reg_val);
 
 	return ((reg_val & rdev->desc->enable_mask) != 0);
 }
@@ -114,9 +115,9 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&sreg->enable_mutex);
 
-	ret = hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
-				   rdev->desc->enable_mask,
-				   rdev->desc->enable_mask);
+	ret = regmap_update_bits(pmic->map, rdev->desc->enable_reg,
+				 rdev->desc->enable_mask,
+			         rdev->desc->enable_mask);
 
 	/* Avoid powering up multiple devices at the same time */
 	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 60);
@@ -131,8 +132,8 @@ static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
-	return hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
-				    rdev->desc->enable_mask, 0);
+	return regmap_update_bits(pmic->map, rdev->desc->enable_reg,
+				  rdev->desc->enable_mask, 0);
 }
 
 static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
@@ -141,7 +142,7 @@ static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
 
-	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->vsel_reg);
+	regmap_read(pmic->map, rdev->desc->vsel_reg, &reg_val);
 
 	return (reg_val & rdev->desc->vsel_mask) >> (ffs(rdev->desc->vsel_mask) - 1);
 }
@@ -159,8 +160,8 @@ static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	reg_val = selector << (ffs(rdev->desc->vsel_mask) - 1);
 
 	/* set voltage selector */
-	return hi6421_spmi_pmic_rmw(pmic, rdev->desc->vsel_reg,
-				    rdev->desc->vsel_mask, reg_val);
+	return regmap_update_bits(pmic->map, rdev->desc->vsel_reg,
+				  rdev->desc->vsel_mask, reg_val);
 }
 
 static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
@@ -169,7 +170,7 @@ static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
 
-	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->enable_reg);
+	regmap_read(pmic->map, rdev->desc->enable_reg, &reg_val);
 
 	if (reg_val & sreg->eco_mode_mask)
 		return REGULATOR_MODE_IDLE;
@@ -195,8 +196,8 @@ static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 		return -EINVAL;
 	}
 
-	return hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
-				    sreg->eco_mode_mask, val);
+	return regmap_update_bits(pmic->map, rdev->desc->enable_reg,
+				  sreg->eco_mode_mask, val);
 }
 
 static unsigned int
@@ -304,6 +305,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 
 		config.dev = pdev->dev.parent;
 		config.driver_data = sreg;
+		config.regmap = pmic->map;
 
 		rdev = devm_regulator_register(dev, &info->desc, &config);
 		if (IS_ERR(rdev)) {
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index 0c2214612c4e..c5a4eac1fdc0 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -12,6 +12,7 @@
 #define	__HISI_PMIC_H
 
 #include <linux/irqdomain.h>
+#include <linux/regmap.h>
 
 #define HISI_ECO_MODE_ENABLE		(1)
 #define HISI_ECO_MODE_DISABLE		(0)
@@ -25,13 +26,9 @@ struct hi6421_spmi_pmic {
 	int					irq;
 	int					gpio;
 	unsigned int				*irqs;
+	struct regmap				*map;
 };
 
-int hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg);
-int hi6421_spmi_pmic_write(struct hi6421_spmi_pmic *pmic, int reg, u32 val);
-int hi6421_spmi_pmic_rmw(struct hi6421_spmi_pmic *pmic, int reg,
-			 u32 mask, u32 bits);
-
 enum hi6421_spmi_pmic_irq_list {
 	OTMP = 0,
 	VBUS_CONNECT,
-- 
2.29.2

