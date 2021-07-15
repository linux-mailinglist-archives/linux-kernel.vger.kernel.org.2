Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46323CA047
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhGOOKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:10:42 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:61237
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238427AbhGOOKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfq90ohNP5bRNLhcBbNOs4qDjjo015QctJi0ZovpjQ8VXD4dwpc6Q23FokSeL5ZjVbfy/6fUI+y6V6w3oPTcC9xPRd2fSPpwBHvvjkHoxGbNu7mxPvghS0CuP7lyB8rOzhhl8ek4p0+4sm+WuVXOGlqKUyn/2fa1toAlrX052z7Np+c0etw9KcaYLxCO4VHEXoipav5+Y1vUMQABrnwsWqP09/9eyaoPzbTsecnanTSe+/7KP1IgvMFzYMvDqKWr9IYTUL+ReDx08psCSedhs5HqDcPwvRrjdbm7kufw1uvVdoI4d11gtO5NQ3CG0MM0Ks5qg8cL5cEP2D1D8Cq3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ckB27pAIoFBsijyLiaaTpmgmJda/5SksQQcoStuVmY=;
 b=LR6HETEdiIuAfx4JEWB/h0mkceNNHW9ya+5YlLNJOCJb+9Mazr0yiI209zlvjRmwf5JahjZuhoZP4C25FbVmOGPltXu+NT/2RdIPzTkaurSvsfJLguCyPnHZQ7IYo9ujMOEPZCtsxp7sq8rIqex1tNa9XvAJAc0M0djPMtyTvWYjCd6Hb8UqF4RLrrfbnoKvvV3KTnhKnjaKHzLxDi9X4YUe3aBhVEihB3hOkcEeb+9TVcxsyHRZxt+DSl0c8nS8dbDWVsKogeKz4iCpJNYrd4kb00YeyMHwxYbc7g5WxZt7xz8nRwm3eylqf/EX/W4x8IRlM1Xpt7nrUkM8z4SJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ckB27pAIoFBsijyLiaaTpmgmJda/5SksQQcoStuVmY=;
 b=ZyzGzSCm9e8ZsVW/ddfZJyc3SUEm9ilxb02bTuPS6H1uXAGTKlwtAJbkrfQRKNoEOLp/7z90E7VKMjMSWyqJu/uoOpIJ4UrsaNx9F0tHn+uTLvk0H9eVKZJ7wYNPZUlgSIXOWHkC++E/VpFqvy+XCJhZ4XmSC0ZyMK6Qp56nSHY=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 14:07:31 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:07:31 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 5/8] bus: fsl-mc: pause the MC firmware before IOMMU setup
Date:   Thu, 15 Jul 2021 17:07:15 +0300
Message-Id: <20210715140718.8513-5-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Thu, 15 Jul 2021 14:07:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aec2d1c7-6fc7-4509-b992-08d94799e2d8
X-MS-TrafficTypeDiagnostic: VI1PR04MB6813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6813D3F9D530EEB62D49BBCBEC129@VI1PR04MB6813.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIeGtMETruFVweGCiEcPTJ0CNbznTau3OpyPMjgT9Nr7HQWtkHgGRX+eSWi9PUwKaT667D4EAYhpnuqGABR19aXWq1FxsUbEoyGKjB/w9wBToA04YtJ6Ch0HOzqia0cLV9lyWynK0pF/pwx+5KTHWx7xXgAkRCQ5jylhnFKATXPKA+Pysxcl/aGO6DDb5QvZKNmKsn5VTNy47jRCCqNF1Y2ty4GVXaOImzjfSImj5E1P2PBKHXF4/AuyoGVCODjRkw5fxd6sg6xZnOjzKM6rmg3EkxKhN3RVurrqs61nnOObPejUqBbkp4Lu7cHOnf1irRQ+mHL7tjDQkOovdJH5Shz78d8mxcVTUgkO4iyWRtnFPo+aCfDF2Wc9ZJkC9dRX8csoW2c8tl9DZAdLdnxonuiT050XLChCeMftqGpRkto/JuXa6rHERCYrbpqKwGXBll27zVV8jZaO8O2HNzLnFkZ2cd0ASS9Gu69Cl+HKbrU0rWYSnjOyJhyLMMIgYb9+J77caEG56ofXPLlX17KtjTl6mhNV2MoEOshFZKubBmUlaZZMv2ZEm9cSeeMRGYrr+ET7UAN9C+4oHJz5gsnYXJbzwOmLECnbRvCN8dpuFckgZ8jA8TBn+vZUa7IlTaZR2JFUt9p0fNQ5Ge6aptKB3dLEtHm+N1fEx8d7Oc5ZE6c3ku+rPgN2eftPY5jOlQ31Ynp+chvTq+E4fKFCbe0IOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(8676002)(6512007)(6486002)(478600001)(36756003)(2616005)(316002)(38350700002)(4326008)(38100700002)(956004)(8936002)(52116002)(9686003)(1076003)(5660300002)(6666004)(26005)(86362001)(2906002)(66556008)(66946007)(83380400001)(66476007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?39SnENSkCvowqRgFJhy82PS1g/fsJSIwTErgTdhnhGv2YzCPbMgceLWGmTor?=
 =?us-ascii?Q?4ks5DSHHKfQ4bG5zOnKddVBegcfNfUrLz6VwmZippkjzoU53NEKhllxqlWDO?=
 =?us-ascii?Q?ye3nGuDN0rKkzXp2zqiu730wyxsV44pY6N3yEzI/U6W5qnRwhaZpsK0dQ4Da?=
 =?us-ascii?Q?bAu0HFvnZZo62fizIT+wNRLPlrHPLrzqyNE/x8jdWScoNf0EFV+C5TFq9mMU?=
 =?us-ascii?Q?CrH+es7SiWAl4TdVXKo0SCMzQ28yRkwZpkZjq0ioM+VPNby7VxomVlV3BUis?=
 =?us-ascii?Q?1gu/5Ma860v+Jz9jbTD0GNxbcS2EiSEsrt4nqxzz+e7ypT4gdKCP7Ge6IhIy?=
 =?us-ascii?Q?/1VmwM3F4BhAQI/3vAZDR5cIwctZ7nB9g2WOtseV7sQCaDKt2TB/mjdvE773?=
 =?us-ascii?Q?/qUdZIAQtf3bFi5g8wKHROi1EA/AvOwMtulQ5fQZGiLpR9l+OUhHmMuMu2IE?=
 =?us-ascii?Q?ssqJcT67/ct8IwOatmxLMHFWxQPBTIlgdibuUI2DzJoEPOinbxObfYXTxVF7?=
 =?us-ascii?Q?m08x7iCVZQQqPYYeLZAZn4Lxrh5QDe5TMsOresPQC23IsKIMrjx9EV6NgtBm?=
 =?us-ascii?Q?FI5LOHAgBmO72SnzZq2FiUpnmShA0FQ21pOD0Aoz4tI6Qyk3apeHIJ4jKJRa?=
 =?us-ascii?Q?02c6bThSvJgzsYJXnF6lCGuN4nJ+5Ab5+z4kpF0R2ZW8AmZPnSac8KQOglmS?=
 =?us-ascii?Q?7QP13r5+t20yDVIvZCe/b6zQLYeBfm/b3t604przWpkQgojEJ9iAmA0fpBno?=
 =?us-ascii?Q?bML3nwLcrBJ9B0wxCHmOT7H/IvedZMA1+iOi0cQ4URoJwnL37x3bld21w7SM?=
 =?us-ascii?Q?qsvETVVRQ2eDqT0jJBLwrAHE5QZMDCB0StJcrkt8K7rtNSdOE87jbJOV5ZqJ?=
 =?us-ascii?Q?uhTmzrO+T6fC2o6WFycDsZq7sjg1xZxpNzYoMByEWQeWIGqOSlEJgTRdJyOh?=
 =?us-ascii?Q?/x42r6W4b3da4/A+NnCbiGLjmy+drGKLy5JRReCicDBxQVPUm1Q7G3G75kqt?=
 =?us-ascii?Q?5/hExhyCct3sTnk5ZwrWpxYf4j6WeLqqPSGYzWunjgWDc8y1VBoAPjJVumu6?=
 =?us-ascii?Q?Xwqc+dPUfSyyt9O8soKl8n7/mgS+WUmh6VAjA28PRvRu1sP/zC7lb4aAH4nc?=
 =?us-ascii?Q?RdzPqYRWLk8ovQjf4MgFtNs776XoQSPLdilJS2YLWlYqRPd8vaVnFZ8tqDfC?=
 =?us-ascii?Q?K4tKf0XPAyaFRLwOvSMNGHg0k9FEVfr6IJCONJkOw2ogTcJ9l23JCBA3XTF3?=
 =?us-ascii?Q?TNSGGVOwIJcirrQwM2yiSQQ4e2m1F7SKef37CYMqxNAHNbx12o8akFSOyMD+?=
 =?us-ascii?Q?Z13fA/5ZZfnjerqr4EbSJWGw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec2d1c7-6fc7-4509-b992-08d94799e2d8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 14:07:31.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoJ5PRbxpyx/HwVA7UYhaoIHns1rVfUHt4n1QKAuenkcBZ0oeGZr60HOy4683UTwAUDgVJGKGFjHP8gZmhxFuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a bus notifier to pause the MC firmware as soon as its device
gets discovered. This is needed as the firmware is live thus, as soon
as the SMMU gets probed and enabled, it will crash the firmware due to
SMMU context faults. The firmware will be resumed at probe time, after
the required IOMMU setup was completed.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 44 ++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index efff48b3efa5..41861ca5c8f1 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -896,6 +896,8 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_add);
 
+static struct notifier_block fsl_mc_nb;
+
 /**
  * fsl_mc_device_remove - Remove an fsl-mc device from being visible to
  * Linux
@@ -1203,6 +1205,8 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
 	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
 	mc->root_mc_bus_dev->mc_io = NULL;
 
+	bus_unregister_notifier(&fsl_mc_bus_type, &fsl_mc_nb);
+
 	return 0;
 }
 
@@ -1236,6 +1240,44 @@ static struct platform_driver fsl_mc_bus_driver = {
 	.shutdown = fsl_mc_bus_shutdown,
 };
 
+static int fsl_mc_bus_notifier(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct resource *res;
+	void __iomem *fsl_mc_regs;
+
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return 0;
+
+	if (!of_match_device(fsl_mc_bus_match_table, dev) &&
+	    !acpi_match_device(fsl_mc_bus_acpi_match_table, dev))
+		return 0;
+
+	res = platform_get_resource(to_platform_device(dev), IORESOURCE_MEM, 1);
+	if (!res)
+		return 0;
+
+	fsl_mc_regs = ioremap(res->start, resource_size(res));
+	if (!fsl_mc_regs)
+		return 0;
+
+	/*
+	 * Make sure that the MC firmware is paused before the IOMMU setup for
+	 * it is done or otherwise the firmware will crash right after the SMMU
+	 * gets probed and enabled.
+	 */
+	writel(readl(fsl_mc_regs + FSL_MC_GCR1) | (GCR1_P1_STOP | GCR1_P2_STOP),
+	       fsl_mc_regs + FSL_MC_GCR1);
+	iounmap(fsl_mc_regs);
+
+	return 0;
+}
+
+static struct notifier_block fsl_mc_nb = {
+	.notifier_call = fsl_mc_bus_notifier,
+};
+
 static int __init fsl_mc_bus_driver_init(void)
 {
 	int error;
@@ -1260,7 +1302,7 @@ static int __init fsl_mc_bus_driver_init(void)
 	if (error < 0)
 		goto error_cleanup_dprc_driver;
 
-	return 0;
+	return bus_register_notifier(&platform_bus_type, &fsl_mc_nb);
 
 error_cleanup_dprc_driver:
 	dprc_driver_exit();
-- 
2.17.1

