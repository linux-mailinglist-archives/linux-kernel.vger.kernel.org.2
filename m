Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6333CB354
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhGPHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:39:35 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:47173
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236258AbhGPHjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:39:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw1TggkVTQrB4chzA9NQLPwOZLmqLn/VxW/v5Y9FYW1MoR2bU8+3r0vtBNjt0Gh1YxiVIqJ/+Eg+NRAdxQ0qXwPOhTSWJPmv/y3WtIBRy1jNtNfKC5FJjVimDxN6HB6HMpH/vVGcBJCHU4g3SJhZCTbgEj8rnjSVqV+pJZIKAYISk41armm7gRgUvvr2xKw0s2sMMi1Ur23O717tcJ2ogC4Qb7fPwTcjkqjxppk/Mrg/T1weTYxv9e8ladWDY4hqYEvPdXQrQnBt8wz1EU6rXNbd9thPu4UbahmEA5dJh9tPq4CnzpWIl523QpjYMGHJAgzoVd6wifZLWWwu2BWqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex61z4+dS/EYPkf2zLPzijY3av/+xdkbW5k5C6OiFP8=;
 b=g5rybxWPiFrlfNKKrfmU8Q9N067/TvsSFyL2KJpLuqU2/vSPj8hi0gUDLp3HaEze6aJ0+ZjvJKIDRd0RxY3u3BHVPv0+qX3aeBBZi+zE3F5NUXyVTqCn0UBrQGSRj3Q75w5DqG/38ojd4glxiti6v420DMkBzyTsbiJF0YLPf1TVYhTd+ynimhq54ChzVsBNlj14WFAX7WjV//L2yHd+ZbMZDtYCPOeV0PyVWOGWqxX5nWod4o1KDWWdGqSFLGED5RkrjodTOfS/bgv3c7cSJNngAbN4bC4lvGQJgI3mRLySGfui200kOR9eTYXy8vF8Pvg8R3hveupLc5p9ttxGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex61z4+dS/EYPkf2zLPzijY3av/+xdkbW5k5C6OiFP8=;
 b=kXtCBC2Way6Iu0Qql8oAtIqHJnx9vs98X0hsFdHvM//Pum5cWloAB/ELFnxqab186tXFAB1WHGtKvSBOndpO7WPQKfw/G7Tvn7WElqMpifU6G0aEwIjhKh1MkFMmXRyu+JuTQ036YckjDHI2nhYTLQZXqS83TpL56xiHm7mmVkY=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4759.eurprd04.prod.outlook.com (2603:10a6:20b:9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 07:36:25 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 07:36:25 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com
Subject: [PATCH V2 5/5] i3c: master: svc: add runtime pm support
Date:   Fri, 16 Jul 2021 15:37:23 +0800
Message-Id: <20210716073723.3490180-6-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716073723.3490180-1-xiaoning.wang@nxp.com>
References: <20210716073723.3490180-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0005.apcprd02.prod.outlook.com (2603:1096:3:17::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 07:36:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4925ac8f-7575-45f8-a791-08d9482c6a30
X-MS-TrafficTypeDiagnostic: AM6PR04MB4759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB475960ABE95D4E4392F39A70F3119@AM6PR04MB4759.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFmcC7w9/cdg3jGsTY3qU+OaspeYAw1RsPX5gM5gkbh2mHHZUTLiEsdF9/SRV6g6o54yOU2zjaXX+0DVsM/XRIoTiUtP/KSbBqY34WFJX0Vazn8uB/wuoXPoUwL67a2RBOnQ7uk8tGp2WQiw9PbXnYnNWLNpVlpHj9fhAIzvsb6hwtzrL6U0QtTfkYaViNQDwF0PLH6zYEPq1hPo3hlECbuzxp2KrHHkZhNVFizVC8eW5T/XhEHpItSyOh4/CrUWB51klZ4whHVhfg1b1Lk9eKSiAQ6l0YJr120Aktyo17opWoJvt1NuEu+7uOyAO5wY1AUR72Y2jYaiTogOw7tQbhQtbkcn0lMu/d5R8bHBy0KfcfTK/wnOnNivLzuFY6U/Qpsaip1+dCbuy9fsmUqR3Zc1Hs6QqdO6KAdo/YWOtrJxaILzLotLyUdEaWJfCb71Q5FIrXfM/5a11PagQV+PZos0RJml5xXk69EyLS/XKUgEpGhfZyYo1MDLvd8Gkls0AyMwfD0BAHK8HHEV3hwkVSZw8GQMCPi1Lt2jslfv1nq7q/Sl7En810C6iAROssAF88A+qgVfDasF6ibe5+HGC8umGNnhrqs53TfPG86Q0i5CYM9Cr7VISOwcK9LnJuWWPqgqX9MqYmRnAYRDpVT1HLzZbab2mttlYMiUWA1icp1/Da85Fo1vdnnePPR08nj/vWUEELUFFsu0JoyeQ1DojA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(2906002)(478600001)(2616005)(26005)(956004)(38100700002)(83380400001)(38350700002)(6512007)(4326008)(86362001)(52116002)(66946007)(5660300002)(6506007)(36756003)(316002)(186003)(1076003)(8936002)(66556008)(66476007)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GPusDYmPlAHAeS+K7XZpMrvx/4OMAFVlKxTvlKeJHKeMeLloR1UWAMSSEIbr?=
 =?us-ascii?Q?KuQTSFGaJTaiZ23PUCBwuL3lUXIL8EBxBFs1Q4/X7pftAx73TPiEVtvrusKQ?=
 =?us-ascii?Q?uj5RvyyZoa/cz90SpkVJUfKDZ+TZiPcMeO746oCAOjgevJVijGuu/2Mxovih?=
 =?us-ascii?Q?oUQk6eguU5RMuRsdF2x287GhRctn1znz/NNXC+Fxn7TfW3YzhsK5V7iCs61D?=
 =?us-ascii?Q?tvEPYlkTdt5ij//ry5IZxXGFavugKbdLrCd7U4Ih+/OswKWfyW1V4SQpVQUg?=
 =?us-ascii?Q?2EGTwegfQsEEFs/qCdUutTo6+1dobF3DXmst6aBICojYIA8zO1SfVjXLJn7k?=
 =?us-ascii?Q?ioAmNol6B49T5Qap+YpCoApPzZWYrht44Ec1fJYt5Sxzg+zpP/nB3vZUd//H?=
 =?us-ascii?Q?b3VtzRjxS/Iw3ObPBSr//jzxLtZiM9bJAm2EX0LPorqUpCKb+ZgrH1v9+HsW?=
 =?us-ascii?Q?TD1SqzktchfUDJQWHu1pyqdbq43aCsiBf0HHGhHr63rn9C3cPwbTIuzKHt5G?=
 =?us-ascii?Q?IaWmPlnr5DJ2qV1tI+bOCP6JXTQt5c9y2jg9aND4pD3+cyRsDEJ456CRUtfI?=
 =?us-ascii?Q?znJdOMWsvFk0bzCCXNE+8hB59Mjk/DPBNJ/K0RAdwTaJ3rICIdV7rosd96qj?=
 =?us-ascii?Q?GiS5soMCYXSMxWMd/b88ZEuHyGwY+fZ9fBLg4phFRNAZYgA+9HTkSWw4Iwb7?=
 =?us-ascii?Q?avninu3Pq0A/yqXYQyOUBJm1bbrQ3nZwKJUmf4Nrlorgg+Q01DDBzzlATQyj?=
 =?us-ascii?Q?XJbwdW0T+1V+6NmHdSirAPJFjdXMCmIZynygduDRxjYRBi0Z56nVGK5Uc0nk?=
 =?us-ascii?Q?ZuJvG4nFkB8gnIQXpQWjCyLG2zL3S0DWzsXEULTwbEpIfzXA6SSWYlojwecT?=
 =?us-ascii?Q?hJlBZ1B87w6DwsRJiOuKBKDr3FSPKNv4cf5ZpaQFDHQyfPY1vZDmUBMWqbIe?=
 =?us-ascii?Q?mHiolxxSMPiQnJMoMtwpGIKnLJpF9eLH+h7kZYEKEVqiegZhb8QJSEHPXkvw?=
 =?us-ascii?Q?vqWvr7b8bBRSAuYa1+yuvcvUhSAu3m6bq2RXXVw5/y1191rxFV1NZVCyRiFo?=
 =?us-ascii?Q?R2dkuQIlupeCoSezOAckMhGd87NbeOIKyAF22nqjM7pZHKJLo7K0SHldNM8x?=
 =?us-ascii?Q?3xsVE6v4snc+kHxWcnYSyPvvUBDf9tFexB/GeN8rKoT5O/20sSJwJEdvc6pb?=
 =?us-ascii?Q?/LD6KHGdXrcDRBkEzAs0K2N5QvTbwkytqpNl5An3/8WI4BEDb3ZjMRQYrYl8?=
 =?us-ascii?Q?GUD1gNSsYYxacS2mqvKkGbbAD0RuFqPZn/cGw6/Dviu9rVZZDky4/7ZMad/G?=
 =?us-ascii?Q?/ck6yJFjqS9ZVQ7D5dqOeJya?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4925ac8f-7575-45f8-a791-08d9482c6a30
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 07:36:24.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gq0+dgXpdz8bRQ7PKz6n05FiiB0Xt+UTHA9iaJP0oh7GFI12xttxrDahL+1U/dhDf7j7XAhizo9WkQCqDBduvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4759
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime pm support to dynamically manage the clock.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2: New patch in V2.
---
 drivers/i3c/master/svc-i3c-master.c | 169 +++++++++++++++++++++++-----
 1 file changed, 142 insertions(+), 27 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5677b5b31a86..4c264750cfc6 100644
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
 
-	return i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
+	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
+
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
+	return ret;
 }
 
 static void svc_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
@@ -1405,19 +1465,30 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = clk_prepare_enable(master->fclk);
-	if (ret)
-		goto err_disable_pclk;
+	if (ret) {
+		clk_disable_unprepare(master->pclk);
+		return ret;
+	}
 
 	ret = clk_prepare_enable(master->sclk);
-	if (ret)
-		goto err_disable_fclk;
+	if (ret) {
+		clk_disable_unprepare(master->pclk);
+		clk_disable_unprepare(master->fclk);
+		return ret;
+	}
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	INIT_WORK(&master->hj_work, svc_i3c_master_hj_work);
 	INIT_WORK(&master->ibi_work, svc_i3c_master_ibi_work);
 	ret = devm_request_irq(dev, master->irq, svc_i3c_master_irq_handler,
 			       IRQF_NO_SUSPEND, "svc-i3c-irq", master);
 	if (ret)
-		goto err_disable_sclk;
+		goto rpm_disable;
 
 	master->free_slots = GENMASK(SVC_I3C_MAX_DEVS - 1, 0);
 
@@ -1431,7 +1502,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 					 GFP_KERNEL);
 	if (!master->ibi.slots) {
 		ret = -ENOMEM;
-		goto err_disable_sclk;
+		goto rpm_disable;
 	}
 
 	platform_set_drvdata(pdev, master);
@@ -1442,18 +1513,17 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &svc_i3c_master_ops, false);
 	if (ret)
-		goto err_disable_sclk;
+		goto rpm_disable;
 
-	return 0;
-
-err_disable_sclk:
-	clk_disable_unprepare(master->sclk);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
-err_disable_fclk:
-	clk_disable_unprepare(master->fclk);
+	return 0;
 
-err_disable_pclk:
-	clk_disable_unprepare(master->pclk);
+rpm_disable:
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
@@ -1467,13 +1537,57 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
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
@@ -1485,6 +1599,7 @@ static struct platform_driver svc_i3c_master = {
 	.driver = {
 		.name = "silvaco-i3c-master",
 		.of_match_table = svc_i3c_master_of_match_tbl,
+		.pm = &svc_i3c_pm_ops,
 	},
 };
 module_platform_driver(svc_i3c_master);
-- 
2.25.1

