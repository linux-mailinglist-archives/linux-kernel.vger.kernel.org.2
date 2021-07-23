Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7994C3D3B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhGWNP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:15:28 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47081 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhGWNPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:15:25 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id CA45A1BF214;
        Fri, 23 Jul 2021 13:55:56 +0000 (UTC)
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
Subject: [PATCH 2/3] syscon: add support for "syscon-smc" compatible
Date:   Fri, 23 Jul 2021 15:52:38 +0200
Message-Id: <20210723135239.388325-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723135239.388325-1-clement.leger@bootlin.com>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System controllers can be placed under secure monitor control when running
under them. In order to keep existing code which accesses such system
controllers using a syscon, add support for "syscon-smc" compatible.

When enable, the syscon will handle this new compatible and look for an
"arm,smc-id" property to execute the appropriate SMC. A SMC regmap is then
created to forward register access to the secure monitor.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/mfd/syscon.c | 170 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 145 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 765c0210cb52..eb727b146315 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -40,7 +40,15 @@ static const struct regmap_config syscon_regmap_config = {
 	.reg_stride = 4,
 };
 
-static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
+static void syscon_add(struct syscon *syscon)
+{
+	spin_lock(&syscon_list_slock);
+	list_add_tail(&syscon->list, &syscon_list);
+	spin_unlock(&syscon_list_slock);
+}
+
+static struct syscon *of_syscon_register_mmio(struct device_node *np,
+					      bool check_clk)
 {
 	struct clk *clk;
 	struct syscon *syscon;
@@ -132,10 +140,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon->regmap = regmap;
 	syscon->np = np;
 
-	spin_lock(&syscon_list_slock);
-	list_add_tail(&syscon->list, &syscon_list);
-	spin_unlock(&syscon_list_slock);
-
 	return syscon;
 
 err_attach:
@@ -150,8 +154,49 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	return ERR_PTR(ret);
 }
 
+#ifdef CONFIG_REGMAP_SMCCC
+static struct syscon *of_syscon_register_smccc(struct device_node *np)
+{
+	struct syscon *syscon;
+	struct regmap *regmap;
+	u32 reg_io_width = 4, smc_id;
+	int ret;
+	struct regmap_config syscon_config = syscon_regmap_config;
+
+	ret = of_property_read_u32(np, "arm,smc-id", &smc_id);
+	if (ret)
+		return ERR_PTR(-ENODEV);
+
+	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return ERR_PTR(-ENOMEM);
+
+	of_property_read_u32(np, "reg-io-width", &reg_io_width);
+
+	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@smc%x", np, smc_id);
+	syscon_config.val_bits = reg_io_width * 8;
+
+	regmap = regmap_init_smccc(NULL, smc_id, &syscon_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto err_regmap;
+	}
+
+	syscon->regmap = regmap;
+	syscon->np = np;
+
+	return syscon;
+
+err_regmap:
+	kfree(syscon_config.name);
+	kfree(syscon);
+
+	return ERR_PTR(ret);
+}
+#endif
+
 static struct regmap *device_node_get_regmap(struct device_node *np,
-					     bool check_clk)
+					     bool check_clk, bool use_smccc)
 {
 	struct syscon *entry, *syscon = NULL;
 
@@ -165,8 +210,19 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 
 	spin_unlock(&syscon_list_slock);
 
-	if (!syscon)
-		syscon = of_syscon_register(np, check_clk);
+	if (!syscon) {
+		if (use_smccc)
+#ifdef CONFIG_REGMAP_SMCCC
+			syscon = of_syscon_register_smccc(np);
+#else
+			syscon = NULL;
+#endif
+		else
+			syscon = of_syscon_register_mmio(np, check_clk);
+
+		if (!IS_ERR(syscon))
+			syscon_add(syscon);
+	}
 
 	if (IS_ERR(syscon))
 		return ERR_CAST(syscon);
@@ -176,16 +232,19 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 
 struct regmap *device_node_to_regmap(struct device_node *np)
 {
-	return device_node_get_regmap(np, false);
+	return device_node_get_regmap(np, false, false);
 }
 EXPORT_SYMBOL_GPL(device_node_to_regmap);
 
 struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
-	if (!of_device_is_compatible(np, "syscon"))
-		return ERR_PTR(-EINVAL);
+	if (of_device_is_compatible(np, "syscon"))
+		return device_node_get_regmap(np, true, false);
+
+	if (of_device_is_compatible(np, "syscon-smc"))
+		return device_node_get_regmap(np, true, true);
 
-	return device_node_get_regmap(np, true);
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
 
@@ -273,19 +332,19 @@ struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_optional);
 
-static int syscon_probe(struct platform_device *pdev)
+struct syscon_driver_data {
+	int (*probe_func)(struct platform_device *pdev, struct device *dev,
+			  struct syscon *syscon);
+};
+
+static int syscon_probe_mmio(struct platform_device *pdev,
+			     struct device *dev,
+			     struct syscon *syscon)
 {
-	struct device *dev = &pdev->dev;
-	struct syscon_platform_data *pdata = dev_get_platdata(dev);
-	struct syscon *syscon;
 	struct regmap_config syscon_config = syscon_regmap_config;
 	struct resource *res;
 	void __iomem *base;
 
-	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
-	if (!syscon)
-		return -ENOMEM;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENOENT;
@@ -295,23 +354,84 @@ static int syscon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	syscon_config.max_register = resource_size(res) - 4;
-	if (pdata)
-		syscon_config.name = pdata->label;
+
 	syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);
 	if (IS_ERR(syscon->regmap)) {
 		dev_err(dev, "regmap init failed\n");
 		return PTR_ERR(syscon->regmap);
 	}
 
-	platform_set_drvdata(pdev, syscon);
+	dev_dbg(dev, "regmap_mmio %pR registered\n", res);
+
+	return 0;
+}
+
+static const struct syscon_driver_data syscon_mmio_data = {
+	.probe_func = &syscon_probe_mmio,
+};
+
+#ifdef CONFIG_REGMAP_SMCCC
+
+static int syscon_probe_smc(struct platform_device *pdev,
+			    struct device *dev,
+			    struct syscon *syscon)
+{
+	struct regmap_config syscon_config = syscon_regmap_config;
+	int smc_id, ret;
+
+	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &smc_id);
+	if (!ret)
+		return -ENODEV;
+
+	syscon->regmap = devm_regmap_init_smccc(dev, smc_id, &syscon_config);
+	if (IS_ERR(syscon->regmap)) {
+		dev_err(dev, "regmap init failed\n");
+		return PTR_ERR(syscon->regmap);
+	}
 
-	dev_dbg(dev, "regmap %pR registered\n", res);
+	dev_dbg(dev, "regmap_smccc %x registered\n", smc_id);
+
+	return 0;
+}
+
+static const struct syscon_driver_data syscon_smc_data = {
+	.probe_func = &syscon_probe_smc,
+};
+#endif
+
+static int syscon_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct syscon_platform_data *pdata = dev_get_platdata(dev);
+	struct regmap_config syscon_config = syscon_regmap_config;
+	struct syscon *syscon;
+	const struct syscon_driver_data *driver_data;
+
+	if (pdata)
+		syscon_config.name = pdata->label;
+
+	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return -ENOMEM;
+
+	driver_data = (const struct syscon_driver_data *)
+				platform_get_device_id(pdev)->driver_data;
+
+	ret = driver_data->probe_func(pdev, dev, syscon);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, syscon);
 
 	return 0;
 }
 
 static const struct platform_device_id syscon_ids[] = {
-	{ "syscon", },
+	{ .name = "syscon",	.driver_data = (kernel_ulong_t)&syscon_mmio_data},
+#ifdef CONFIG_REGMAP_SMCCC
+	{ .name = "syscon-smc",	.driver_data = (kernel_ulong_t)&syscon_smc_data},
+#endif
 	{ }
 };
 
-- 
2.32.0

