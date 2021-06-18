Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3B3ACD52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhFROSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:18:35 -0400
Received: from fallback20.mail.ru ([185.5.136.252]:47700 "EHLO
        fallback20.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbhFROSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=Y7MRrxWCGCctjACHqcqGEuN43YHf2jLc2saeaVCBGa0=;
        b=cLNApFLaQymo/waPnTYcLvpXj+9LvymRpn5O5vVzPDDUolfxOeWIabtNjRpPULWcsNssMiOt8IoWsN6KruHApeWNa9Unj9TRLk0msyk/eiCCFWHVDe/yOQc/Ka+DTilswrEiDx3Dij0HJCNru26ehNV0u0VU12PjEEfH+Xuhkb8=;
Received: from [10.161.64.51] (port=56948 helo=smtp43.i.mail.ru)
        by fallback20.m.smailru.net with esmtp (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1luFID-00022i-69; Fri, 18 Jun 2021 17:16:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Y7MRrxWCGCctjACHqcqGEuN43YHf2jLc2saeaVCBGa0=;
        b=ZbiGsXCweoP8bQ5/7xKw6gJAyTH+WIIjJXZBFycFHb0BCjwObMiU/FmfqftiPakfKwbgIa93zyYIEZEnVrM+mOuEMXZ8JhRPNAFImzAasiP+mSj+lYdeL7Dkf5MpOJTYbrV7IUGjLWi74Vq03kOk8MqvDaT2rZZDANB/PpBbyHI=;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1luFIA-0002kG-9A; Fri, 18 Jun 2021 17:16:19 +0300
From:   Sergey Larin <cerg2010cerg2010@mail.ru>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sergey Larin <cerg2010cerg2010@mail.ru>
Subject: [PATCH 1/2] regulator: max8893: add regulator driver
Date:   Fri, 18 Jun 2021 17:16:06 +0300
Message-Id: <20210618141607.884-1-cerg2010cerg2010@mail.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD91C2C07775F13263A612E9F961DCF5576EBB1C736C2A4021700894C459B0CD1B9BB8A9759A6A2449C5AF599E7497CEDD26789E044FBA7F352036170912EE13762
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B865BA2AB0AE8E25EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063748744D4CD6EC491D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8DAF27F23BCCB2C640A0BFFBF4C9A1D976F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE78C9B9C945842D50B9FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18F04B652EEC242312D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B60CDF180582EB8FBA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC75EA4585E178ECDF3AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F790063748AEDA778F3616E5D81D268191BDAD3D698AB9A7B718F8C4D1B931868CE1C5781A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F06F6F51F7D3AE627156CCFE7AF13BCA4B5C8C57E37DE458BEDA766A37F9254B7
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A24209795067102C07E8F7B195E1C978319F67E0D6866C04F89BB839037DF3A6B5
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C128C1281A48FD13CFBC6AAE9520E2BC2DC7009268118D73D9C2B6934AE262D3EE7EAB7254005DCEDDD01B8980DE9A8611E0A4E2319210D9B64D260DF9561598F01A9E91200F654B0F7239ED45045D1418E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3480A9008907CB2FD0DAEC25F7CD02761353A6C67124487E618CE140CB5CBFBE8616F5178F7F3224FB1D7E09C32AA3244C289AA6E352CA16CE7A0A9F951C598E7CA90944CA99CF22E38D5DD81C2BAB7D1D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj0Roc5o5ut96wsJfFAVRJIA==
X-Mailru-Sender: 24CCEAA761B392C83D438B890C7CDC3CEC601B9FA304B0D5D0A6FC687B2167357962F9E9328436E1CAD91EC71FC00F3837D2A27E1A8065646C7A2150F6097340301919DCEDD5454186FA049C4F996C4B5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B410D8DD6B135161BAA345390BEDF84758DA0EE3EDD177796F68F3CF0E9FE49B696761BFB32D813BC3A5E4381656CCBEFA9AEB44E4A724CCA9F8A5A49CC0CDFE28
X-7FA49CB5: 0D63561A33F958A54FD6A6400BACFE1DC99CB439B6DBCC9EEA3F406FD1A349ACCACD7DF95DA8FC8BD5E8D9A59859A8B655AC6754D1393D37A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE77B6A9F97C9A1D64D9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3C8D8B8CB12567299117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF7F8A167F7B42CAD3BA3038C0950A5D36C8A9BA7A39EFB766EC990983EF5C032935872C767BF85DA227C277FBC8AE2E8BEF5FD6012EE047C975ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C128C1281A48FD13CDD6BC16DD2BCA7BC5763C9063DB2E70B9C2B6934AE262D3EE7EAB7254005DCEDDD01B8980DE9A861699F904B3F4130E343918A1A30D5E7FCCB5012B2E24CD356
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj0Roc5o5ut975AJ6Cvis7Tg==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C900579012F43D24554B06719AC17826602C377D7C7ECF079E1C56CCF71F689FD47EECAD91EC71FC00F3837D2A27E1A8065646C7A2150F6097340301919DCEDD5454186FA049C4F996C4B5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX8893 is a simple regulator which can be found on some of Sasmsung
phones.

Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
---
 drivers/regulator/Kconfig   |   7 ++
 drivers/regulator/Makefile  |   1 +
 drivers/regulator/max8893.c | 183 ++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 drivers/regulator/max8893.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index e2d43a8b3045..20d7e3a220d6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -578,6 +578,13 @@ config REGULATOR_MAX8660
 	  This driver controls a Maxim 8660/8661 voltage output
 	  regulator via I2C bus.
 
+config REGULATOR_MAX8893
+	tristate "Maxim 8893 voltage regulator"
+	depends on I2C
+	help
+	  This driver controls a Maxim 8893 voltage output
+	  regulator via I2C bus.
+
 config REGULATOR_MAX8907
 	tristate "Maxim 8907 voltage regulator"
 	depends on MFD_MAX8907 || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 59ce3359a84a..6cce511cac26 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
 obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
+obj-$(CONFIG_REGULATOR_MAX8893) += max8893.o
 obj-$(CONFIG_REGULATOR_MAX8907) += max8907-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8925) += max8925-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8952) += max8952.o
diff --git a/drivers/regulator/max8893.c b/drivers/regulator/max8893.c
new file mode 100644
index 000000000000..1519bf760da7
--- /dev/null
+++ b/drivers/regulator/max8893.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+static const struct regulator_ops max8893_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+};
+
+static const struct regulator_desc max8893_regulators[] = {
+	{
+		.name = "BUCK",
+		.supply_name = "in-buck",
+		.of_match = of_match_ptr("buck"),
+		.regulators_node = of_match_ptr("regulators"),
+		.n_voltages = 0x11,
+		.id = 6,
+		.ops = &max8893_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.min_uV = 800000,
+		.uV_step = 100000,
+		.vsel_reg = 0x4,
+		.vsel_mask = 0x1f,
+		.enable_reg = 0x0,
+		.enable_mask = BIT(7),
+	},
+	{
+		.name = "LDO1",
+		.supply_name = "in-ldo1",
+		.of_match = of_match_ptr("ldo1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.n_voltages = 0x12,
+		.id = 1,
+		.ops = &max8893_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.min_uV = 1600000,
+		.uV_step = 100000,
+		.vsel_reg = 0x5,
+		.vsel_mask = 0x1f,
+		.enable_reg = 0x0,
+		.enable_mask = BIT(5),
+	},
+	{
+		.name = "LDO2",
+		.supply_name = "in-ldo2",
+		.of_match = of_match_ptr("ldo2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.n_voltages = 0x16,
+		.id = 2,
+		.ops = &max8893_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.min_uV = 1200000,
+		.uV_step = 100000,
+		.vsel_reg = 0x6,
+		.vsel_mask = 0x1f,
+		.enable_reg = 0x0,
+		.enable_mask = BIT(4),
+	},
+	{
+		.name = "LDO3",
+		.supply_name = "in-ldo3",
+		.of_match = of_match_ptr("ldo3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.n_voltages = 0x12,
+		.id = 3,
+		.ops = &max8893_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.min_uV = 1600000,
+		.uV_step = 100000,
+		.vsel_reg = 0x7,
+		.vsel_mask = 0x1f,
+		.enable_reg = 0x0,
+		.enable_mask = BIT(3),
+	},
+	{
+		.name = "LDO4",
+		.supply_name = "in-ldo4",
+		.of_match = of_match_ptr("ldo4"),
+		.regulators_node = of_match_ptr("regulators"),
+		.n_voltages = 0x1a,
+		.id = 4,
+		.ops = &max8893_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.min_uV = 800000,
+		.uV_step = 100000,
+		.vsel_reg = 0x8,
+		.vsel_mask = 0x1f,
+		.enable_reg = 0x0,
+		.enable_mask = BIT(2),
+	},
+	{
+		.name = "LDO5",
+		.supply_name = "in-ldo5",
+		.of_match = of_match_ptr("ldo5"),
+		.regulators_node = of_match_ptr("regulators"),
+		.n_voltages = 0x1a,
+		.id = 5,
+		.ops = &max8893_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.min_uV = 800000,
+		.uV_step = 100000,
+		.vsel_reg = 0x9,
+		.vsel_mask = 0x1f,
+		.enable_reg = 0x0,
+		.enable_mask = BIT(1),
+	}
+};
+
+static const struct regmap_config max8893_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int max8893_probe_new(struct i2c_client *i2c)
+{
+	int id, ret;
+	struct regulator_config config = {.dev = &i2c->dev};
+	struct regmap *regmap = devm_regmap_init_i2c(i2c, &max8893_regmap);
+
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	for (id = 0; id < ARRAY_SIZE(max8893_regulators); id++) {
+		struct regulator_dev *rdev;
+		rdev = devm_regulator_register(&i2c->dev,
+					       &max8893_regulators[id],
+					       &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(&i2c->dev, "failed to register %s: %d\n",
+				max8893_regulators[id].name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id max8893_dt_match[] = {
+	{ .compatible = "maxim,max8893" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, max8893_dt_match);
+#endif
+
+static const struct i2c_device_id max8893_ids[] = {
+	{ "max8893", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, max8893_ids);
+
+static struct i2c_driver max8893_driver = {
+	.probe_new	= max8893_probe_new,
+	.driver		= {
+		.name	= "max8893",
+		.of_match_table = of_match_ptr(max8893_dt_match),
+	},
+	.id_table	= max8893_ids,
+};
+
+module_i2c_driver(max8893_driver);
+
+MODULE_DESCRIPTION("Maxim MAX8893 PMIC driver");
+MODULE_AUTHOR("Sergey Larin <cerg2010cerg2010@mail.ru>");
+MODULE_LICENSE("GPL");
-- 
2.32.0

