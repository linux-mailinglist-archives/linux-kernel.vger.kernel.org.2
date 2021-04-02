Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F66352DE2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhDBQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 12:45:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F5C061788;
        Fri,  2 Apr 2021 09:45:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so2626422wmj.1;
        Fri, 02 Apr 2021 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=925408bHy/+LQgNs14Jlis1++7uaZvDAVgRinaIEmNk=;
        b=KjcucBnMtSk+rZFVqm08mze8ga8DfH+yj08WE/cNN1gnK5sE1MliUaTjWkfdW4lTTV
         BvXD1Ls8JpRzFglG5GsM63DepfOxSMBIl3/MUGIoWucD/XQyjlagh/jgwrHv9HhacN2A
         46VY3qGbpkejT/FoXYVgxQEyJOF0ZW9TlTVUwyLjvVg1/pa91BIJ54/DvbYCCppfgkJc
         tLwQHoCQ+2cad2rYos7zvAePBTtm52cXfYx87DWXzND3psF2vbImxK8PDvtEARPOzHKK
         z5X5IeISTO3Z16oDrUIkcBwG6U/b8bAz0Z4j3S+YOnSFNIUklkQxu4yYAp0EyIvyRDlR
         pJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=925408bHy/+LQgNs14Jlis1++7uaZvDAVgRinaIEmNk=;
        b=jZuycD8Wyn66PVRMdAlJrjhxwf55T5od5XgK1y6z4lPaZ/SyZleumXkcjcDjppdnoA
         nApNjucgfg8QcPjzzn+zEtZnBgWHoQRYP80lFYa3v89yjKbbFCdomskKc2Wveat3bLxx
         jjZlsbTocJ6OJlWAP0ku/oIv0vjopIrcoxNDmx5orKbX6QEaGYQ/v6Hci+P2IbDJQGTG
         +UGbiE4n4qFjQeBW7rYweItCH7HlHtxPNMDKOc0igahbcXBUhzH3GiT33CipF84KT8ER
         B2eqCISX+skgRrhxguS7eJDlUiG9/v6fQX9/H1CmcYRbPiDpu4RTVdOELNqwV3mBNOAp
         fi+w==
X-Gm-Message-State: AOAM530IYnRT8zx6wmlVtgtuKSEtiDxvgN0l+v6uTlAC27ccLZkzSmRf
        UzS7jC6MMl8Q5SvyOnTwM8M=
X-Google-Smtp-Source: ABdhPJyO7Px3uvykmDmkXfhnIXwbIu58i9fP3qGTwqMG/eOo82EM2RJn7MGkt5/gfuCFpmRCpHOomw==
X-Received: by 2002:a05:600c:3546:: with SMTP id i6mr13354593wmq.104.1617381914988;
        Fri, 02 Apr 2021 09:45:14 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700dc0d270f04d57395.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:dc0d:270f:4d5:7395])
        by smtp.gmail.com with ESMTPSA id y10sm15027627wrl.19.2021.04.02.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 09:45:14 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        peng.fan@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 2/2] soc: imx: add Power Domain driver for i.MX8M(M|N|P)
Date:   Fri,  2 Apr 2021 18:45:06 +0200
Message-Id: <20210402164506.520121-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402164506.520121-1-adrien.grassein@gmail.com>
References: <20210402164506.520121-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code allowing to control the power domain of some
i.MX8 socs.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 MAINTAINERS                        |   2 +
 drivers/soc/imx/Kconfig            |   7 +
 drivers/soc/imx/Makefile           |   1 +
 drivers/soc/imx/imx8m_pm_domains.c | 233 +++++++++++++++++++++++++++++
 include/soc/imx/imx_sip.h          |  12 ++
 5 files changed, 255 insertions(+)
 create mode 100644 drivers/soc/imx/imx8m_pm_domains.c
 create mode 100644 include/soc/imx/imx_sip.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 97536afca0e1..06e1568d003b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13014,9 +13014,11 @@ NXP i.MX 8M(M|N|P) POWER DOMAIN DRIVER
 M:	Adrien Grassein <adrien.grassein@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/fsl,imx-power-domain.yaml
+F:	drivers/soc/imx/imx8m_pm_domains.c
 F:	include/dt-bindings/power/imx8mm-power.h
 F:	include/dt-bindings/power/imx8mn-power.h
 F:	include/dt-bindings/power/imx8mp-power.h
+F:	include/soc/imx/imx_sip.h
 
 NXP i.MX 8MQ DCSS DRIVER
 M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 05812f8ae734..02d93346fd4b 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -8,6 +8,13 @@ config IMX_GPCV2_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
 
+config IMX8M_PM_DOMAINS
+	bool "i.MX8M PM domains"
+	depends on ARCH_MXC || (COMPILE_TEST && OF)
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	default y if SOC_IMX8M
+
 config SOC_IMX8M
 	bool "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 078dc918f4f3..7387239aecec 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_IMX8M_PM_DOMAINS) += imx8m_pm_domains.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
diff --git a/drivers/soc/imx/imx8m_pm_domains.c b/drivers/soc/imx/imx8m_pm_domains.c
new file mode 100644
index 000000000000..3a039572b734
--- /dev/null
+++ b/drivers/soc/imx/imx8m_pm_domains.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regulator/consumer.h>
+
+#include <soc/imx/imx_sip.h>
+
+#define MAX_CLK_NUM	6
+#define to_imx8m_pm_domain(_genpd) container_of(_genpd, struct imx8m_pm_domain, pd)
+
+struct imx8m_pm_domain {
+	struct device *dev;
+	struct generic_pm_domain pd;
+	u32 domain_index;
+	struct clk *clk[MAX_CLK_NUM];
+	unsigned int num_clks;
+	struct regulator *reg;
+};
+
+enum imx8m_pm_domain_state {
+	PD_STATE_OFF,
+	PD_STATE_ON,
+};
+
+static DEFINE_MUTEX(gpc_pd_mutex);
+
+static int imx8m_pd_power_on(struct generic_pm_domain *genpd)
+{
+	struct imx8m_pm_domain *domain = to_imx8m_pm_domain(genpd);
+	struct arm_smccc_res res;
+	int index, ret = 0;
+
+	/* power on the external supply */
+	if (!IS_ERR(domain->reg)) {
+		ret = regulator_enable(domain->reg);
+		if (ret) {
+			dev_warn(domain->dev, "failed to power up the reg%d\n", ret);
+			return ret;
+		}
+	}
+
+	/* enable the necessary clks needed by the power domain */
+	if (domain->num_clks) {
+		for (index = 0; index < domain->num_clks; index++)
+			clk_prepare_enable(domain->clk[index]);
+	}
+
+	mutex_lock(&gpc_pd_mutex);
+	arm_smccc_smc(IMX_SIP_GPC, IMX_SIP_CONFIG_GPC_PM_DOMAIN, domain->domain_index,
+		      PD_STATE_ON, 0, 0, 0, 0, &res);
+	mutex_unlock(&gpc_pd_mutex);
+
+	return 0;
+}
+
+static int imx8m_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct imx8m_pm_domain *domain = to_imx8m_pm_domain(genpd);
+	struct arm_smccc_res res;
+	int index, ret = 0;
+
+	mutex_lock(&gpc_pd_mutex);
+	arm_smccc_smc(IMX_SIP_GPC, IMX_SIP_CONFIG_GPC_PM_DOMAIN, domain->domain_index,
+		      PD_STATE_OFF, 0, 0, 0, 0, &res);
+	mutex_unlock(&gpc_pd_mutex);
+
+	/* power off the external supply */
+	if (!IS_ERR(domain->reg)) {
+		ret = regulator_disable(domain->reg);
+		if (ret) {
+			dev_warn(domain->dev, "failed to power off the reg%d\n", ret);
+			return ret;
+		}
+	}
+
+	/* disable clks when power domain is off */
+	if (domain->num_clks) {
+		for (index = 0; index < domain->num_clks; index++)
+			clk_disable_unprepare(domain->clk[index]);
+	}
+
+	return ret;
+};
+
+static int imx8m_pd_get_clocks(struct imx8m_pm_domain *domain)
+{
+	int i, ret;
+
+	for (i = 0; ; i++) {
+		struct clk *clk = of_clk_get(domain->dev->of_node, i);
+
+		if (IS_ERR(clk))
+			break;
+		if (i >= MAX_CLK_NUM) {
+			dev_err(domain->dev, "more than %d clocks\n",
+				MAX_CLK_NUM);
+			ret = -EINVAL;
+			goto clk_err;
+		}
+		domain->clk[i] = clk;
+	}
+	domain->num_clks = i;
+
+	return 0;
+
+clk_err:
+	while (i--)
+		clk_put(domain->clk[i]);
+
+	return ret;
+}
+
+static void imx8m_pd_put_clocks(struct imx8m_pm_domain *domain)
+{
+	int i;
+
+	for (i = domain->num_clks - 1; i >= 0; i--)
+		clk_put(domain->clk[i]);
+}
+
+static const struct of_device_id imx8m_pm_domain_ids[] = {
+	{.compatible = "fsl,imx8mm-pm-domain"},
+	{.compatible = "fsl,imx8mn-pm-domain"},
+	{.compatible = "fsl,imx8mn-pm-domain"},
+	{},
+};
+
+static int imx8m_pm_domain_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct imx8m_pm_domain *domain;
+	struct of_phandle_args parent, child;
+	int ret;
+
+	domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return -ENOMEM;
+
+	child.np = np;
+	domain->dev = dev;
+
+	ret = of_property_read_string(np, "domain-name", &domain->pd.name);
+	if (ret) {
+		dev_err(dev, "failed to get the domain name\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "domain-index", &domain->domain_index);
+	if (ret) {
+		dev_err(dev, "failed to get the domain index\n");
+		return -EINVAL;
+	}
+
+	domain->reg = devm_regulator_get_optional(dev, "power");
+	if (IS_ERR(domain->reg)) {
+		if (PTR_ERR(domain->reg) != -ENODEV) {
+			if (PTR_ERR(domain->reg) != -EPROBE_DEFER)
+				dev_err(dev, "failed to get domain's regulator\n");
+			return PTR_ERR(domain->reg);
+		}
+	}
+
+	ret = imx8m_pd_get_clocks(domain);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get domain's clocks\n");
+		return ret;
+	}
+
+	domain->pd.power_off = imx8m_pd_power_off;
+	domain->pd.power_on = imx8m_pd_power_on;
+	if (of_property_read_bool(np, "fsl,active-wakeup"))
+		domain->pd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+	if (of_property_read_bool(np, "fsl,rpm-always-on"))
+		domain->pd.flags |= GENPD_FLAG_RPM_ALWAYS_ON;
+
+	pm_genpd_init(&domain->pd, NULL, !(domain->pd.flags & GENPD_FLAG_RPM_ALWAYS_ON));
+
+	ret = of_genpd_add_provider_simple(np, &domain->pd);
+	if (ret) {
+		dev_err(dev, "failed to add the domain provider\n");
+		pm_genpd_remove(&domain->pd);
+		imx8m_pd_put_clocks(domain);
+		return ret;
+	}
+
+	/* add it as subdomain if necessary */
+	if (!of_parse_phandle_with_args(np, "power-domains",
+					"#power-domain-cells",
+					0, &parent)) {
+		ret = of_genpd_add_subdomain(&parent, &child);
+		of_node_put(parent.np);
+
+		if (ret < 0) {
+			dev_dbg(dev, "failed to add the subdomain: %s: %d",
+				domain->pd.name, ret);
+			of_genpd_del_provider(np);
+			pm_genpd_remove(&domain->pd);
+			imx8m_pd_put_clocks(domain);
+			return driver_deferred_probe_check_state(dev);
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver imx8m_pm_domain_driver = {
+	.driver = {
+		.name	= "imx8m_pm_domain",
+		.owner	= THIS_MODULE,
+		.of_match_table = imx8m_pm_domain_ids,
+	},
+	.probe = imx8m_pm_domain_probe,
+};
+module_platform_driver(imx8m_pm_domain_driver);
+
+MODULE_AUTHOR("NXP");
+/* Just for mainstreaming */
+MODULE_AUTHOR("Adrien Grassein <adrien.grassein@gmail.com>");
+MODULE_DESCRIPTION("NXP i.MX8M power domain driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/soc/imx/imx_sip.h b/include/soc/imx/imx_sip.h
new file mode 100644
index 000000000000..6b96b33c870e
--- /dev/null
+++ b/include/soc/imx/imx_sip.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 NXP
+ */
+
+#ifndef __IMX_SIP_H__
+#define __IMX_SIP_H__
+
+#define IMX_SIP_GPC			0xC2000000
+#define IMX_SIP_CONFIG_GPC_PM_DOMAIN	0x03
+
+#endif /* __IMX_SIP_H__ */
-- 
2.25.1

