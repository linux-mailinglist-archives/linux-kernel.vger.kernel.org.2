Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1217E36C521
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhD0LdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:33:02 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:41244
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230270AbhD0LdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:33:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzWYBrR58vPeQj7Qc3lTlGD2hruYRvAtDePlNnhU4DOfo0iWL8DzBP3nWILfNwBsynQttkFvY4RpkjzwaaiJl+pGvJZrVaqxX92iEzLpot9PzyprIUnRhlPRSJ0PyEq/isStFZvBiz/7Augd+xM2SAFtJT8YkobTqDalIOqnF+yeq9bw6k5z9CaIFA2K7MwCXJ5WaAeGwJKYlDpKWv6WsMuEZG5b3CAQOsiKs5s8KZUJfG92Pk8JAiJV8ROeLtvO0uGwxmJ3WeLlYSu8OfgFXreajvYEJaETWTFE5GZqsDerQOooPC7WhmuC64MqXF843kRCR7MjjZveMJPfS1M9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnbuILpW78SfEm5WKi4kpGs5HR3foOs+tCuVSOrXOE8=;
 b=Vd3gHyzO0u4ad58lj7f90An6KQTyxtTHBZ3d3HQBqHEvL7CRoPfjQD+HqxQIrz3e8BtaxHkL03vWjLGLMSV1XNY0vv0pd6Q4edMOkJHp4bSa5KITelVD+ZrQqGIr1SnOeRJlYcP4id5ZnmjvmAWTslvN8+k5rQO/bSBm7awkEkOCpZqrAoVPx1QUQ8/qfw20Kz9rIDilmVRJuqGpIe5dC9J+ztyCIChTqHkuaUpf8QGOZ+JUp4zvx/TQVvhqXxtIs9pf1ss/zanmcGUJUPjNu0XVqLEl2vcPO6FH3zTuXEeMhw81bf1pjQI3KA9JgH/LrdNE116L4jgHEZOo9m6oLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnbuILpW78SfEm5WKi4kpGs5HR3foOs+tCuVSOrXOE8=;
 b=fj3adl7aNQYerK1Gm46lDyShsNUZqWt2Nl6F0P9IUvuBM5SmKoZJ4xwi28MEgExIyujuNu/sBZUziZlEuP35DgK/I3dQlr7+Gmr3JFIxfQrRR0mHVOMGpWJh13f1FBVSqQ4NZTsYe2xq5S/cUbiXQxGxQAjOXiE8VuqVNNoaf6A=
Received: from MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40)
 by CY4PR02MB3223.namprd02.prod.outlook.com (2603:10b6:910:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 11:32:16 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::7c) by MN2PR07CA0030.outlook.office365.com
 (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 11:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 11:32:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 04:32:01 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 04:32:01 -0700
Envelope-to: git@xilinx.com,
 maz@kernel.org,
 tglx@linutronix.de,
 valentin.schneider@arm.com,
 dianders@chromium.org,
 hdegoede@redhat.com,
 mkshah@codeaurora.org,
 thunder.leizhen@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 frowand.list@gmail.com,
 devicetree@vger.kernel.org
Received: from [10.140.6.2] (port=33778 helo=xhdanirudh40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anirudha.sarangi@xilinx.com>)
        id 1lbLwe-000328-1c; Tue, 27 Apr 2021 04:32:00 -0700
From:   Anirudha Sarangi <anirudha.sarangi@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, <git@xilinx.com>,
        Anirudha Sarangi <anirudha.sarangi@xilinx.com>
Subject: [PATCH 2/3] irqchip: Add support to remove irqchip driver modules.
Date:   Tue, 27 Apr 2021 17:01:35 +0530
Message-ID: <20210427113136.12469-3-anirudha.sarangi@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427113136.12469-1-anirudha.sarangi@xilinx.com>
References: <20210427113136.12469-1-anirudha.sarangi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50f855f2-7f83-4409-f368-08d909701c45
X-MS-TrafficTypeDiagnostic: CY4PR02MB3223:
X-Microsoft-Antispam-PRVS: <CY4PR02MB322374EE1F26CF51C567DCF8DA419@CY4PR02MB3223.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGK1bRbgnrrDlmQm2WDExJw6qhdp2/dPPcnWk+qaRL5FkeBFNlQO9ErTH4Fjemdh0Z9XbBedCBeNQb2mo2UHzttPq2gAmtVxdRq1cGKPrQLSC0k7A8Su7XyJNch7LCnh17hdNwZaBDht5VT1zef8w9iwJBgzIrrkPDwR8SdDOnQGtDiGhxV8CMieXiz2yWGMj4gPf6CFGBjPBbZ9x/aUWQF9niK88N7lG+Q/PH9ZsXXtGKqaVq7XLIzD3brHj8Dk79wkD/hmr18woqwo6OMRgB5I1rpXRamZd0zOUy2B9DSxGmrMHA9UZ36TnS337uT02bfALmVt4OYb1XfcISv9E2fvZ7xeRDc02J/O1++5aUftLlbUFF7+nhsYr50f5J4jTz/jaa9CezzXyJuYgGL3zY1l/EOJiN4xWCmLHyxykD9r8TbGcFgMaRzIyjLREyc4CmvYXxiFyzD5K0PEx/vnmRHHGZHUGXqYPY+5GQGWvWYhyHnCpMGdYm9curx/IuvGBfZm8GWfFaV4tVFTgkdT73AZTgN6PNavapIHdtIbzI7Dhzqi0SWbqzKCImXEuE/uNb7hdpHiWabWTLzDLyueTS757GcKs9DkPyhHVB2zXtfv4/AnKSPC4KQLE6oXzs7yIAKJAvPcNKEUsFXdRiaW1H7AHICjnV28DpHtv6VkS1c1bsRuJrB44NyjQllIWUVb
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39850400004)(46966006)(36840700001)(36860700001)(7636003)(7696005)(83380400001)(316002)(44832011)(36906005)(7416002)(1076003)(9786002)(36756003)(6916009)(6666004)(54906003)(47076005)(5660300002)(8676002)(26005)(426003)(4326008)(8936002)(2616005)(478600001)(70586007)(336012)(186003)(70206006)(2906002)(356005)(107886003)(82740400003)(82310400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 11:32:16.3521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f855f2-7f83-4409-f368-08d909701c45
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3223
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing irqchip implementation does not fully support use cases
where an irqchip driver has to be used as a module. In particular there
is no support to remove an irqchip driver module.
The use cases where an irqchip driver has to be loaded and then removed
as a module are really relevant in fpga world. A user can decide to
have a irqchip as part of a removable partial fpga region. In such cases
not only the corresponding irqchip driver has to be loaded as a module,
but must also be removed when the removable partial region is removed.

The existing implementation updates the existing framework to achieve
the above said goal.

Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
---
 drivers/irqchip/irqchip.c | 38 +++++++++++++++++++++++++++++++++++---
 include/linux/irq.h       | 13 +++++++++++++
 include/linux/of_irq.h    |  1 +
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 3570f0a588c4..8687131e7268 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -15,6 +15,11 @@
 #include <linux/irqchip.h>
 #include <linux/platform_device.h>
 
+struct platform_irqchip_instance {
+	of_irq_init_cb_t irq_init_cb;
+	of_irq_remove_cb_t irq_remove_cb;
+};
+
 /*
  * This special of_device_id is the sentinel at the end of the
  * of_device_id[] array of all irqchips. It is automatically placed at
@@ -34,11 +39,22 @@ void __init irqchip_init(void)
 
 int platform_irqchip_probe(struct platform_device *pdev)
 {
+	struct platform_irqchip_instance *irqchip;
+	const struct irqc_init_remove_funps *irqchip_funps;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *par_np = of_irq_find_parent(np);
-	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
 
-	if (!irq_init_cb)
+	irqchip = devm_kzalloc(&pdev->dev, sizeof(*irqchip), GFP_KERNEL);
+	if (!irqchip)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, irqchip);
+
+	irqchip_funps = of_device_get_match_data(&pdev->dev);
+	irqchip->irq_init_cb =	irqchip_funps->irqchip_initp;
+	irqchip->irq_remove_cb = irqchip_funps->irqchip_removep;
+
+	if (!irqchip->irq_init_cb)
 		return -EINVAL;
 
 	if (par_np == np)
@@ -55,6 +71,22 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY))
 		return -EPROBE_DEFER;
 
-	return irq_init_cb(np, par_np);
+	return irqchip->irq_init_cb(np, par_np);
 }
 EXPORT_SYMBOL_GPL(platform_irqchip_probe);
+
+int platform_irqchip_remove(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *par_np = of_irq_find_parent(np);
+	struct platform_irqchip_instance *irqchip = platform_get_drvdata(pdev);
+
+	if (!irqchip->irq_remove_cb)
+		return -EINVAL;
+
+	if (par_np == np)
+		par_np = NULL;
+
+	return irqchip->irq_remove_cb(np, par_np);
+}
+EXPORT_SYMBOL_GPL(platform_irqchip_remove);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 252fab8074de..d46d28f56bc0 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1098,6 +1098,19 @@ struct irq_domain_chip_generic {
 	struct irq_chip_generic	*gc[];
 };
 
+/**
+ * struct irqc_init_remove_funps - Stores function pointers for irqc init
+ * and remove APIs. Used when the irqchip driver is to be used as a module.
+ * @irqchip_initp:	Function pointer for init/entry point of a irqchip driver.
+ * @irqchip_removep:Function pointer for irqchip driver remove function.
+ */
+struct irqc_init_remove_funps {
+	int (*irqchip_initp)(struct device_node *irqc,
+			     struct device_node *parent);
+	int (*irqchip_removep)(struct device_node *irqc,
+			       struct device_node *parent);
+};
+
 /* Generic chip callback functions */
 void irq_gc_noop(struct irq_data *d);
 void irq_gc_mask_disable_reg(struct irq_data *d);
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index aaf219bd0354..4210ac64956f 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 
 typedef int (*of_irq_init_cb_t)(struct device_node *, struct device_node *);
+typedef int (*of_irq_remove_cb_t)(struct device_node *, struct device_node *);
 
 /*
  * Workarounds only applied to 32bit powermac machines
-- 
2.17.1

