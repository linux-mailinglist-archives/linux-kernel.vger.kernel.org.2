Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA483E402B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhHIGg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:36:56 -0400
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:41569
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233393AbhHIGgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:36:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRIsR7MJWNeQGHgo0xG+KTI5z4vSo6krIIqbnFsJgxvKwkO0a+3e5x+0WZ0oddVsJug1Q3AspYa6vbHOeVkuUuRfHJy70XBRLRnjC8idEdzZo3CkRlqwNGoilmjVI+/VEjp9OQjjIyFjeoo06pi8uHES6M8ntW35ZdiaORBxsrvQt2UAOpB+62jMRnZcuJWnkqJ5djab3Gfxp6mOQxzc+kUKTSkZeK//n44vQJLl6KN9QqfdI4z65FCr/VqHpwcTWVfH3UP5m1ZJwBMmeY5Pa3fGQGufXZaqj0N51bM/XFQqZs7gnKb8pSWuhGIFJ4lp5WwWWH9uVaBHJ40H98tqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBM1mJLaeYcdAo6vcGH9ZuMuWiCZNiewFB5dwliYi0k=;
 b=jHOsdhiJ1iFZY252C0vq8GN+f1+kro8xSsktFSHphG/f+t8Psfd+ZqqdSffmH9i6XXnVmpPQjYugpunYMiuAdvO7GSH8o8fq3jDodi7vrHfbPpcFvnyBVtpUyVnu7xn4VEtmr6BCvn4mwx7rp7LetYsNRbV6rMDFlheZ2WX+0LulXcMujL5+Fi3F3MPxsbcoXkfS7cVuN5lGwlCTjrZn+M4pIHDYerpfElSxtgxJ7kOB0hRARrzx2beP9fNZ0exYd9EgXBIx7BR+Tvrafd1tkOf5ObhrADaYJaD68+80URLQBGs6poVy0km3L/nQTNKTIO4/7UlvmC5tmX1GmiVMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBM1mJLaeYcdAo6vcGH9ZuMuWiCZNiewFB5dwliYi0k=;
 b=eHt337NtFF8yiS5uv3JLoSDIXEzHyBXJJcR2/DLqYuaBp4Wxp0g7naPzsS2lV9jYnvzJcFJBWilOW60tbxVpa9N1ey6ZsssqjbFzn/y8mqNwzrCEdDiexXjg4zsB2NFkVfYxfHR65j7b5EdtNMKDTyh6139+9C95XCRvZg5LcVk=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 06:36:22 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 06:36:22 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V4 6/8] i3c: master: svc: add runtime pm support
Date:   Mon,  9 Aug 2021 14:36:43 +0800
Message-Id: <20210809063645.2289988-7-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
References: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0103.apcprd02.prod.outlook.com (2603:1096:4:92::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:36:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ad67bd-a0fa-4e19-4780-08d95b0000ed
X-MS-TrafficTypeDiagnostic: AS8PR04MB7653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7653389CC8E6ECAC6ACDC319F3F69@AS8PR04MB7653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+4vtXGiuHuoDyilmkKkb3Qd5U1+UtTZjX6KHQAkE7VXqLKr7XFlWOQgIQgvu8UxsvM8F+InGPyx3qWHaqME/W4MzidkhTqWB+m4viqhkkShsr4wMVc4r76gWVcA6Nkb0yWt7YMM4mlZ7eo61GIehTYUFoJpz2s8ZPSrTYCoYIAY5QmGwfAFLwXnREmPDVZz25YouEeNaXIARnbHQ+3gQ/7lSkHfhBSUsuBltKmCxDepctQEhLz1XovIorE0P4p8ai3nBw7JpMFNcihwbtJRNT8mWliW/VErQtiQhAhW6PXSwEdxL5soP0Gp+VMLLhxGYp47ijzwlIitreJnOdNel+0sYiH3snVT6SrdwGekBearSNZ4FYCaden11IuVlPYP3CosHwTIQ9cNp6YYVqvAeUREzJvODjH+xOAzcbrgDrsiCDt+TtbUP8ONbH0ItzLC9qTwvIyGz1XOKTglVbUhU2Rgp1pu8mIvvOd6quPPMUEjD1VEKRldJ1D2p936WUv79PQvYFrM5t1p0hPNCX5H2U8dSMXjN7X4lyfg/vt1bu6DEGGj/afDcq9+b55Nee22xThvbcLxnhOjrilUXGZVOGcQDgEour3al0nWKKDyZXb9XBfUYImk0k3PbDDqZJhRNl4kg172zqpB7hykWJi1QY5MMjnpXta/TO7JyUZgkZ0fS3cgqlZWQPf4zMqKTeRI/RivuhLIaVDIyWc58YKqzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(38100700002)(38350700002)(478600001)(86362001)(36756003)(316002)(186003)(2906002)(8676002)(83380400001)(2616005)(956004)(6506007)(4326008)(26005)(52116002)(8936002)(6512007)(1076003)(5660300002)(6486002)(66476007)(66556008)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AaM0aPDqSngC4BicjVvYaylJFL3VUJdS4BYzOmMDE/5tj8jWuqpl/YW4Btx0?=
 =?us-ascii?Q?cJs+RVgK4DSPHDq0ESGPQfTxvRsy9VFh6uwZEsHU4ssIXSYcttRDVvbAMFi4?=
 =?us-ascii?Q?eQ6IOCl7Hz5xic7Hgfq7NX2MR1pJZFw2ALszjERoDWYKswzPoM8l7uUQo/PQ?=
 =?us-ascii?Q?qoXC3sWUsuBRO/Ib3qICVaTyUilSuPayiuu/VjTVed3aPwZNCBmC+cw8FKfO?=
 =?us-ascii?Q?bYNdHQSufg5RaQSvdqDiPMwo7pQizHmfZAdM9Z0mu1zCa9WcmlF6x+vsJrAZ?=
 =?us-ascii?Q?wbqB9VRvWIBdaoHR5/0k01xQciGwxsiAHkCMgH0IqzGshJNPTzIs5668bHV4?=
 =?us-ascii?Q?1GdoMPsNh2ULUN8Hcpx0CA+UQqENdf39Pr5egSvwRXjHMIPmwB6rYDAOKifw?=
 =?us-ascii?Q?1M/niWw8/FUn9um2SzAHNVncCZ5BvtaiEA6pXxYaP623UJX8G3azxVEZ4Ju8?=
 =?us-ascii?Q?f3oToxDf7bUM/JWB7nmR7usFWdvqJuWY6O2Wqr2biiyM9rqLc6DzlEyPyrVK?=
 =?us-ascii?Q?z6LYA9prOxc98Sz5yyP5U2icbU0iUHfRBwMAJiR2a7DjLooxzWKAV4LnQ+vY?=
 =?us-ascii?Q?ljcaklz5OCHoWFjs5AafnItyiGjhZ+gKXCwKx9XNtktYdTY2h6pKNFBS5c9Z?=
 =?us-ascii?Q?Mlu3Kp4wtjiAeRB5kokX+v0m4BOVbIkBgyN9Pja9JnODzpJP7+ePoL3I0mPl?=
 =?us-ascii?Q?b50yTzzf9hm3g3yB3XVLcUo9vsd+QjngNYvmze3i3lx948ePmRJs1lF9gjGX?=
 =?us-ascii?Q?p+bDYHq6E/KgLMv16bhk8Yp8zIBoJlqGULzCFQtkr0MjvQfQ7cxIJ2Bwjgkw?=
 =?us-ascii?Q?ixvY0r0Y1H4Zpm+LrzgBTWb/bbBOSmoMq8lVG1gMcl+urz2iaH3Vohcs+FXZ?=
 =?us-ascii?Q?w4kjzMM8x+eFRfRVLc7EaDiykrKJdUIyQ7QtGvRjeGA/1Qnx0W29KHMNMJrO?=
 =?us-ascii?Q?Beu3ZWHbsdQxCOf8JgwoeeKTREKtVIxEdHcxzrXkoEq5RQ83TG4KEn93uckN?=
 =?us-ascii?Q?ZzSNyHntE9W3csNvuB+g0Ebh/fgzVLMvxy38zmNbfcZeq4AQIYYbTaR/ggf9?=
 =?us-ascii?Q?i22g4gXgapdU8x66IJxy/GKbJgtWC41GqcS7IIGGVSjgiaXimULzy268LMF/?=
 =?us-ascii?Q?gRlf69v2jXcOGTtYUMRG3Oi18d+EecLeIp0OVQe1pboCK7XXEYiwKCmZx3OD?=
 =?us-ascii?Q?qZhpil8048AvgFqo8Q5wdEm6FaXKLV7VIpzx7b6GqsTZKjHObuAQH0YMBLGk?=
 =?us-ascii?Q?Yt2Hssqf25C2yPn5UhdG29YQzzrrNR/qonbzBgO3P+5zcuVbH8B4OuQdGy8n?=
 =?us-ascii?Q?Z2wdV2Lc78G0VhPO5D2OzQaH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ad67bd-a0fa-4e19-4780-08d95b0000ed
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:36:22.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jn285IcjGgOkI8/der/2O0vE0DLWOwsRhVsFPZ0cxeLCJxmlYHHc4N5ydzJYZHAx5wc6X3+BKUQrpFGiZpR9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime pm support to dynamically manage the clock.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V4:
 - error path emit_stop only used in svc_i3c_master_do_daa() for one time, so
   remove it. Or it needs another goto command at the end of the function to
   skip it and to go to rpm_out.
V3:
 - restore the error path of probe function
 - enable runtime pm just before i3c module reset
V2: New patch in V2.
---
 drivers/i3c/master/svc-i3c-master.c | 154 ++++++++++++++++++++++++----
 1 file changed, 135 insertions(+), 19 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 2a96b217cc78..5939e0936697 100644
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
@@ -480,10 +483,20 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
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
 
@@ -527,7 +540,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		odstop = 1;
 		break;
 	default:
-		return -EINVAL;
+		goto rpm_out;
 	}
 
 	reg = SVC_I3C_MCONFIG_MASTER_EN |
@@ -545,7 +558,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	/* Master core's registration */
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
-		return ret;
+		goto rpm_out;
 
 	info.dyn_addr = ret;
 
@@ -554,21 +567,35 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
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
@@ -867,31 +894,36 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
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
-	if (ret)
-		goto emit_stop;
+	if (ret) {
+		svc_i3c_master_emit_stop(master);
+		svc_i3c_master_clear_merrwarn(master);
+		goto rpm_out;
+	}
 
 	/* Register all devices who participated to the core */
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
-
-emit_stop:
-	svc_i3c_master_emit_stop(master);
-	svc_i3c_master_clear_merrwarn(master);
+rpm_out:
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 
 	return ret;
 }
@@ -1058,6 +1090,12 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	if (!xfer)
 		return;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return;
+	}
+
 	svc_i3c_master_clear_merrwarn(master);
 	svc_i3c_master_flush_fifo(master);
 
@@ -1072,6 +1110,9 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 			break;
 	}
 
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
 	xfer->ret = ret;
 	complete(&xfer->comp);
 
@@ -1348,6 +1389,14 @@ static void svc_i3c_master_free_ibi(struct i3c_dev_desc *dev)
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
@@ -1355,8 +1404,15 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
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
@@ -1455,16 +1511,31 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
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
 
@@ -1486,13 +1557,57 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
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
@@ -1504,6 +1619,7 @@ static struct platform_driver svc_i3c_master = {
 	.driver = {
 		.name = "silvaco-i3c-master",
 		.of_match_table = svc_i3c_master_of_match_tbl,
+		.pm = &svc_i3c_pm_ops,
 	},
 };
 module_platform_driver(svc_i3c_master);
-- 
2.25.1

