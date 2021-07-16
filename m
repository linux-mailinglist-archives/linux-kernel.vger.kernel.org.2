Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069DB3CB4BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbhGPIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:55:24 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:49924
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238678AbhGPIzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:55:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0aUzAsSywrEtudwqMUk8pY8WJcwimyZHdwpeHBU4ElgwWD7uP/QtF8K2ct6S+7LPIg7inqLCneGEddUjqycXgNGCUlwiw8vjHqyWiu1mU+yMzAOYtZnZoSZ+Lk+KdRCzvZJuQhns/1jwx2XCeYgU04E8EnkCm+HsV+8NOMK2F+Q6qt/BYNartWJzSk2/WnuY1vGdNXjoTYwCjt8Zj82sIRzUJswGZDf2nHNdV+E1c3M4Bw56M99h750i+SY/ZKNpvrFuxORCj+JJzpmjkxcwgxxkY877ET8wSq0tbvPTy0+3NwTrfivJDnXCdQ+nSQqR0L9j/3b1PXq4uLXFNu6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsHrpi+ics9IrRRVC6OXyhj3wizkpq2mDQPicBq6U08=;
 b=HHXZyTRSqI5ODqkJES7SZ4+P5q+yRu6Z8pa1sZblW9xU4GOrsU/QSjoJc1yTRjiQN4J006ptRctAqEVi6jrGdfDFlKejFGy0/JakUgMbjoCYx+MFso/3G5jUKZVYcEzYey6JlVIMOQkiiBNpDbkx8PQWMxBL+r4EqAOGGabNx+0bsjFteKFb8lGB3Ndbtm0oOrfo0rxfi+1A6e82YpWDRowDrnqNQMNOZQJLztjBvkx78wWGo0wQnz2LsNqDKPurQjnRfrOYutXIVioNAc64H65KtJA43nJD3IDjeQcoRW0XFpd8dxfev8p0tqugqNw29/LQGCRieRuhJBLRpmTteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsHrpi+ics9IrRRVC6OXyhj3wizkpq2mDQPicBq6U08=;
 b=Et6iuQpCvp0wGDO9boACMUgGyfsAFWyEOE4x9XtxuAUpzUtm301rAxrGxA1Jp5rGBcd4isg3rRfGrfIGMZnAVq+RQUUMkMbR8qF8BYVMGKGGr00pFtxBeDRLn9oYqIpIkpNlUKkIxWgXqCKzE2jggmoh3nQneRYACJI6bXOnVjo=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 08:52:18 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 08:52:18 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com
Subject: [PATCH V3 5/5] i3c: master: svc: add runtime pm support
Date:   Fri, 16 Jul 2021 16:53:17 +0800
Message-Id: <20210716085317.3572224-6-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716085317.3572224-1-xiaoning.wang@nxp.com>
References: <20210716085317.3572224-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 08:52:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa1e2e4-89e2-4bbd-66e9-08d948370441
X-MS-TrafficTypeDiagnostic: AM7PR04MB7142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB714201E46550C853C86A27A2F3119@AM7PR04MB7142.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9q2eJNJ+s7beg+aMEXeBskNYrlE+TGUpaARQBCuaplgUZP9eBWP0xtSnaiZvRZqZs4pc4r+WbmvEymSmyupORwiZD69SGXF+3YIQ2UhSC/ZtyGG/0N+I//Vmt0/Bn5Aw1PKXKi71LRJnLMeSwlZZAb5lgVmtjbZcRzmKSBpPPSHf16Y/7RM7nG4qb9HzFAxAEA9TNj90n6oyrY31YLIKTxzzOYO7KSR6lz/EVOFKN4IgnnYQl7O+ZpE6tgI6/EQlWm0gHinX70vKJVrZDktL2zIimeFkwKrocedDdH+KDq8SWhKUzC3TD9NeLLFLVAfc8E8j3tTqHfFBbl4O6ZgtPArMZZ6OdBNChxRu2nxkbzTeTsDexV7jYi3N1eTjMBG/LWf3bpLQCOvl3dLC572VQ2Xz++W4CGkJAHGzZvguIN2eocrZ/DLLC172NiKuGD8YqdYUopkaLvGjvQpymk1dOj7MjwlRplOahTn1zXP28jAqEigTonDmP6NZrFulityx5Kou0SO7rBGKOaCmnabe4v/ncf6MDIrRgGgKVb/SLJLuPtTqHyLqjfVfT3kKDXmm+kD0N8iXOnqv5syg2+LmMhYD1VRZODrU8avjvMKTQZwF/iG4oUd4YtmpTxdYDCjP5cGDBmJNTSIvnFr9j4m/e6j1smHhWe7qOfdUTSecefk6AhIcCu/XaIEBwZhteaQpOsJRxD89DMPJ09niTSvsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(366004)(376002)(36756003)(478600001)(5660300002)(8936002)(316002)(66556008)(66476007)(8676002)(4326008)(86362001)(6512007)(1076003)(66946007)(26005)(2616005)(956004)(6506007)(52116002)(2906002)(6486002)(186003)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EvoGSVP2MwUFbmmR7+gD1YBrxaqs4AHP6QygYV8XKBMHsuRh+y22PcbZhi6?=
 =?us-ascii?Q?wm8GMhJuH4vb3lMakCCZdhZo+mXH4OeTuQmaPltorS2vM69ZyKRQeGKZV5LH?=
 =?us-ascii?Q?gSiiF3yPZJWAXUi3Cu7YCygz4PrkSVAnetT6jNcgVtcng8iE9MAJyH7gGbzv?=
 =?us-ascii?Q?jlNt4YaFVJITEw0hYurIZ4jpS/zmP1Z10YVTQWsdltVEf18ulsZyoRz/9DBG?=
 =?us-ascii?Q?NUOMCLTc9KGuYy2MebJvO+nzuqZU7xBN4l4g8Z9U7lXx8NQeSXBOttl1JRK3?=
 =?us-ascii?Q?odaQAqzdEIh9Xpkvchd+gKTDeTx4wEtyBuxEwy6dDUoUpxPO9J5veB3i65vr?=
 =?us-ascii?Q?LiEmTuDgNPkqnkYsDsG+9uWFJ4SYjMPTCd7J81hJkABj/OUJIwovt/Aa7yJs?=
 =?us-ascii?Q?i7Y0XWOLkkTvsEls1RcrBhx3JQbIj+i6w0rN7Gzw9AFqt1dqE7kX+v7TZ+91?=
 =?us-ascii?Q?s9oGoCfHzyk2znPSlA8vmH9yhOuY90FXl2qTimvpLaW/X74iT3sG52fvC1+i?=
 =?us-ascii?Q?SPm8c5ultvXfsKCCGLKAwP6+mr1CWzVmEwf8mvdjCg8RAOZOJZLT3auqWL+C?=
 =?us-ascii?Q?Q4f2rDJK4vU9f0LWXJ4SBjyPq+6al6OKjG3xRAv8eg+8kWWtBe9CuG2jBO6p?=
 =?us-ascii?Q?DrsacjScNSyS5v4cRFxkubh72YOaONh2KCxNQdc80876jIbb64mmvaDwgbwB?=
 =?us-ascii?Q?fMt2s89wBsZEU7oODMeS/d2pYo0eEtuGWinR4RTUb8G8bwZmWt2RzBIJ3sCr?=
 =?us-ascii?Q?HJWKN94Sbh7WTs9ZEWIbBHRC1S3fLOHH4zNfkEEbcmTjP216kb05/upfRClU?=
 =?us-ascii?Q?lhTe8eRmmZKtJS2OofRmyEUsCPxQuvCtJb4ABWUgSnJzfEG7x4ffns4RRWg8?=
 =?us-ascii?Q?2vdyhBO77iUE/RWZzxV6dzs0HTwlu2OdBZTIW8Pm2ZgKDu4LCi2wW4+UHpEy?=
 =?us-ascii?Q?r9Pu/AS0XR9xtqRkfdPjfN/VHUvf4TySefp25xaPuK7Q1FHIghXLMfCksefJ?=
 =?us-ascii?Q?OmsgtJU3H2HlXd8Tg3GRkGCqDQAFGnOsFg620/oDQ8M9QNfXVYZMmJnvpqwp?=
 =?us-ascii?Q?AsUSmQ2bcLlwmVxFHeFZk7TyGRRgT0KSzBn7Wgfhacrlge3riHLf5w2UcD31?=
 =?us-ascii?Q?4SpEpZcZ8pHECIRl+dkHIaLvp8rRdiwaORjvr4B2+7wgzolP2j15Htl2qDvT?=
 =?us-ascii?Q?zZtCdl1T6aVLz2SFiG+xYXRm8IgW7tY4FhbiRcrDe6YSJxMrteuWHfYmSmXZ?=
 =?us-ascii?Q?8pBKsJMg533UymzwB+kom2lv1Taq0u+o30i/n11hHaaps4M07uzw2Dvgp0D/?=
 =?us-ascii?Q?1W2KqMV0px3KKvCc/5a6WuTR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa1e2e4-89e2-4bbd-66e9-08d948370441
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 08:52:18.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCFaDZJ26uxamisHDqDbcDRHU1ycklTs72MizG5eOYbj3YswZIVvxFXcYVKGyfSI09KkhjSuSbg6W5KPmdKkSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime pm support to dynamically manage the clock.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2: New patch in V2.
V3:
 - restore the error path of probe function
 - enable runtime pm just before i3c module reset
---
 drivers/i3c/master/svc-i3c-master.c | 146 +++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5677b5b31a86..3121ffd82745 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -17,7 +17,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 /* Master Mode Registers */
 #define SVC_I3C_MCONFIG      0x000
@@ -119,6 +121,7 @@
 #define   SVC_MDYNADDR_ADDR(x) FIELD_PREP(GENMASK(7, 1), (x))
 
 #define SVC_I3C_MAX_DEVS 32
+#define SVC_I3C_PM_TIMEOUT_MS 1000
 
 /* This parameter depends on the implementation and may be tuned */
 #define SVC_I3C_FIFO_SIZE 16
@@ -452,10 +455,18 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return ret;
+	}
+
 	/* Timings derivation */
 	fclk_rate = clk_get_rate(master->fclk);
-	if (!fclk_rate)
-		return -EINVAL;
+	if (!fclk_rate) {
+		ret = -EINVAL;
+		goto rpm_out;
+	}
 
 	fclk_period_ns = DIV_ROUND_UP(1000000000, fclk_rate);
 
@@ -499,7 +510,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		odstop = 1;
 		break;
 	default:
-		return -EINVAL;
+		goto rpm_out;
 	}
 
 	reg = SVC_I3C_MCONFIG_MASTER_EN |
@@ -517,7 +528,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	/* Master core's registration */
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
-		return ret;
+		goto rpm_out;
 
 	info.dyn_addr = ret;
 
@@ -526,21 +537,35 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	ret = i3c_master_set_info(&master->base, &info);
 	if (ret)
-		return ret;
+		goto rpm_out;
 
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
 
-	return 0;
+rpm_out:
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
+	return ret;
 }
 
 static void svc_i3c_master_bus_cleanup(struct i3c_master_controller *m)
 {
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return;
+	}
 
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Disable master */
 	writel(0, master->regs + SVC_I3C_MCONFIG);
+
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 }
 
 static int svc_i3c_master_reserve_slot(struct svc_i3c_master *master)
@@ -839,6 +864,12 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	unsigned int dev_nb;
 	int ret, i;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return ret;
+	}
+
 	spin_lock_irqsave(&master->xferqueue.lock, flags);
 	ret = svc_i3c_master_do_daa_locked(master, addrs, &dev_nb);
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
@@ -849,22 +880,24 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	for (i = 0; i < dev_nb; i++) {
 		ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
 		if (ret)
-			return ret;
+			goto rpm_out;
 	}
 
 	/* Configure IBI auto-rules */
 	ret = svc_i3c_update_ibirules(master);
-	if (ret) {
+	if (ret)
 		dev_err(master->dev, "Cannot handle such a list of devices");
-		return ret;
-	}
 
-	return 0;
+	goto rpm_out;
 
 emit_stop:
 	svc_i3c_master_emit_stop(master);
 	svc_i3c_master_clear_merrwarn(master);
 
+rpm_out:
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
 	return ret;
 }
 
@@ -936,6 +969,12 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	u32 reg;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return ret;
+	}
+
 	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
 	       xfer_type |
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
@@ -966,12 +1005,18 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (!continued)
 		svc_i3c_master_emit_stop(master);
 
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
 	return 0;
 
 emit_stop:
 	svc_i3c_master_emit_stop(master);
 	svc_i3c_master_clear_merrwarn(master);
 
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
 	return ret;
 }
 
@@ -1310,6 +1355,14 @@ static void svc_i3c_master_free_ibi(struct i3c_dev_desc *dev)
 static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return ret;
+	}
 
 	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
 }
@@ -1317,8 +1370,15 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	int ret;
+
+	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
+
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 
-	return i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
+	return ret;
 }
 
 static void svc_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
@@ -1436,16 +1496,31 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, master);
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	svc_i3c_master_reset(master);
 
 	/* Register the master */
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &svc_i3c_master_ops, false);
 	if (ret)
-		goto err_disable_sclk;
+		goto rpm_disable;
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
+rpm_disable:
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 err_disable_sclk:
 	clk_disable_unprepare(master->sclk);
 
@@ -1467,13 +1542,57 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
+{
+	struct svc_i3c_master *master = dev_get_drvdata(dev);
+
 	clk_disable_unprepare(master->pclk);
 	clk_disable_unprepare(master->fclk);
 	clk_disable_unprepare(master->sclk);
+	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
 }
 
+static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
+{
+	struct svc_i3c_master *master = dev_get_drvdata(dev);
+	int ret = 0;
+
+	pinctrl_pm_select_default_state(dev);
+	ret = clk_prepare_enable(master->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(master->fclk);
+	if (ret) {
+		clk_disable_unprepare(master->pclk);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(master->sclk);
+	if (ret) {
+		clk_disable_unprepare(master->pclk);
+		clk_disable_unprepare(master->fclk);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops svc_i3c_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(svc_i3c_runtime_suspend,
+			   svc_i3c_runtime_resume, NULL)
+};
+
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "silvaco,i3c-master" },
 	{ /* sentinel */ },
@@ -1485,6 +1604,7 @@ static struct platform_driver svc_i3c_master = {
 	.driver = {
 		.name = "silvaco-i3c-master",
 		.of_match_table = svc_i3c_master_of_match_tbl,
+		.pm = &svc_i3c_pm_ops,
 	},
 };
 module_platform_driver(svc_i3c_master);
-- 
2.25.1

