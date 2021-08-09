Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8083E4028
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhHIGgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:36:40 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:22658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233349AbhHIGgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:36:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko9V+eOsa4AwFioe2xePTSAH0duGxmc+RHCgLAvfDTXCYL1rdGZHRRaNsUCWB3lNeA8cd5nvKtXA+Oqtcl/3gf4I/Oh8/lVzwjJQIEN/ZY2EEUvj/OqrPX/9aAzm0SuFAdzhu22OWEYTYMuSDGs2JonnvZRB62sK6yM18vZRGzma6l/OinUOUDDBqmlmAaWie2obi00OO2tHXIUsAq51V9XV19pI1vrmB7T+BD5IBT8bMAZ6uq2mDauDOO9ynPHVFlZiqlgnoCSeeXM2/YqysikR0CC/410FTf/7khRjTyWqS1RySpECKNxrzZaJICo9cUSuwDOJorjC4/7uV8VnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9uhZNoCwfQiYZwie3oxKfzqE7+jTXeli88o1fPWCOI=;
 b=RRNO1cnqtdguh1Hi/BocyT3U5/jn4fz7IFa2EQQZoX3Zr2cnsdFDC0yd+TnDqUx60iz1l1GyevDNIHVt8GE1kX/vmMoPk0zbEH+PiTrol5rBzkTbTfk+u6DS9qT5mmrl2M9V0vnCryA/fXUobTONU9MPnHZqZj9fkanxsqcWk5i4RGCuIhgMLlMiC8GUpNSErCO9LXMPOCssfj05ESCwfnW/fCSZ1qdsZiP7+YDE2qd0UEv4GyyK31X1qP/dRH6zKTDaGsaMPmAJfnTUNYU8EJIqGm7Af/yKyrlRGMYUlxQg4N200KqMYqJBZ1XNakalup3FUcDkJhBUY+s0+wMyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9uhZNoCwfQiYZwie3oxKfzqE7+jTXeli88o1fPWCOI=;
 b=dLdYeFA1cSvZ2nL5UPfwIyJb0DzN1IbeNfwhExacq3iBKzO9J0gzMaK3NlziBUOJVFwEXMf2chM9MeKpDeDveae0oC/ZtLVT0JHL/0+klT+fRyZw2vw4QFNBZE/Q+0PsNDv8SZRTWzbE53vOVNUQSw7xyyvmWMDiS0JkbgLS+j4=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 06:36:14 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 06:36:14 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V4 3/8] i3c: master: svc: separate err, fifo and disable interrupt of reset function
Date:   Mon,  9 Aug 2021 14:36:40 +0800
Message-Id: <20210809063645.2289988-4-xiaoning.wang@nxp.com>
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
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0103.apcprd02.prod.outlook.com (2603:1096:4:92::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:36:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 440e0560-2f19-427c-9b88-08d95afffbf1
X-MS-TrafficTypeDiagnostic: AS8PR04MB7653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7653E1C55C9CA22EE133D362F3F69@AS8PR04MB7653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12AxuInJIB3A3naLhHUGJLfqMFHVZ/LWNpzUZu3/6zAdx5j8i+vleUQQPa/DIx6T1kMLOWZ6sMSPMwYYtaeOGu2qIvt3GhXx3p/dlKTz4rlJWaDMMoB18hoLRH4xWxfO0AtR8Jjr64iPJEq6Yq+vG+JVgfx4ljbQnYAyS8x9fuQ8saFDa/3yLjPOO7DlrgmPdoNW0LlA5TCGGyb31u+8vhVPW+BAszIFInlX65l1Lg7jIcU3YkNGIS6LP0yLKvRHCqt/RyCbOL2mF1nKC/8FntJUSwE3lX1dBq3xCvB2dtRz46LD0VT+Obi2Hfplfx22WzzY/Gvam4/3U2IQWC6avmJoYImLeBkAaFh+ydip5Ucfp4ltUjyvFZuQFQ96gooVllK3V+vEKl4hVsAZqLlyVUjnveayiBwQFxXwS1xt1YhgciwyD/FcWCOhYZgCd8tj9JDjS8uWC0LdXlvZrm1EzDDRhS8GC8fLm+AEW3F5LR6r8uKWpWugSxKclkJJGFTu9P97j3MEl01zqz5ULXrIAyclvPX/qBAcs7tzk3vu+o+ODMY26U7FX3alwrFE5u0AQY1QdVCj6sYWeuWEpF5y66TejwSeqUwGaPMq52f5qoL9vSeAVZJol5rRD8I3YCYzwJBVdlzeZpKwbE8dApDEqygYMB8/e88/+lFfoTxWPhDeFwrqu+RWzQTDBkfkY2MeerAN4gGRyOKr1MDIIkwZEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(38100700002)(38350700002)(478600001)(86362001)(36756003)(316002)(186003)(2906002)(8676002)(83380400001)(2616005)(956004)(6506007)(4326008)(26005)(52116002)(8936002)(6512007)(1076003)(5660300002)(6486002)(66476007)(66556008)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tVIweuJWMQZt6vjT1kpGdtTLKes44l6YEKYgcxcvLyacK9Qb/BpcV9xcEptp?=
 =?us-ascii?Q?PR5f46VGCHSD5id8BkuM4zxMlHHtR7eqqhIbBwuC8fvahl6ApguPPs9UbwUC?=
 =?us-ascii?Q?SWIPSh/hzshvaGcApkSR48PTGTvQQ9VSwtjNOfDSVmJRyld616Bc6cusQTju?=
 =?us-ascii?Q?AA+5s3c+K00xFHVTk31BhHx2pnvkqT6dZEZ7aTTIJtiTNeGhM4kUvMYMd/Ys?=
 =?us-ascii?Q?nG5mYY0Kvwzr8vg1ut3xlFZDDx2v9du6Nvlt4v/MaiB3O5hw43Eez85uctRG?=
 =?us-ascii?Q?kdZCGZlP2ebsd0P4YmynEDdsnWlL21DUJMqzzxkVPTHF29m130uIjpFjnEuL?=
 =?us-ascii?Q?53fMxzjSaw+3FbaUEQhDL2guyF++aGkAJmtr/rM/xY/BZYnskBrTCWc10Oyh?=
 =?us-ascii?Q?kqQaqkd9Oo3MsBj7BRuI60dDfxU55tCL7EVYPLcyKrsmFT9xvIRDNZn4qwcx?=
 =?us-ascii?Q?TvzM+tQc8lONst47QnZ9hyRQjM9fzYXwRC/iWnS19wi4RcD6prHfx0eoQWqZ?=
 =?us-ascii?Q?1iGHZVU2l414u1ezzQ0s5Ts2vgcD1iDLjfAwed4P9JBno9iZgv/bDcNfBLFE?=
 =?us-ascii?Q?5Mpvswuw0ZdfWUKV507Ws8e1uehnuICVRAnaUS8YX28LXpCRg0m6BTrdZ5JM?=
 =?us-ascii?Q?336BxJSNY5g1SlqOWfE4jUQVxYUor5BDlofBKD8gHqVGd2Bf5fUK54eJ6a9a?=
 =?us-ascii?Q?pB22qkxbUA41CvUZvTbVD5BTbrxyL9ZkEvYhuIkDjwM8wP+A3pRSeLvDSl8r?=
 =?us-ascii?Q?yO+mGDFf1u5t51R/KeiJ/CLqGvpDczbiQCJOVRhk8BaPknbrK8Dg0lVc05NH?=
 =?us-ascii?Q?Ct7mYH94hloKs/UVg6l34HVBwHJ8bM3uNkgcmFZVfckgsVyVN+pVir9j8gfU?=
 =?us-ascii?Q?KEjInDlsw3bY71FUXKEKGj2ueuczeiXKjPzDdp9crO5CHa8o+O2XVxIl/Q/7?=
 =?us-ascii?Q?RM79CPYfBHmoRMsH9+TFtDbEkDxRKFeiIajULGcbgKAHD585wWlMyGp0MTvI?=
 =?us-ascii?Q?br4Pfk47XMdAsTH5XsSaOnqaVcuDHVxUfLaV+o/VeXkIudnbpvt3owC+azHg?=
 =?us-ascii?Q?OxBzIflcwkqUPtfhZ9AE9MFqfwM+gKVwlWLtWGJML+IC4HQlDHrhqQw5NpV/?=
 =?us-ascii?Q?x/BXepiws+b0LPorp7d4X7kI3uG+a1gEXbpotpdKUbIaX0NDOBUS6jgsxWTq?=
 =?us-ascii?Q?oa/UDCJ7mzY5BJnBI4+5AcHfW8l51XHfhtsFpIwwLuCnqVkLL0KTx9g5drV+?=
 =?us-ascii?Q?bGkKiD5KfNHxbocYG7H3y1m3LXAdb+C952w8/ql4AcxB/XcBzn+8hDY9LmbV?=
 =?us-ascii?Q?1l9ka86FS/796MHzdPiOhT6O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440e0560-2f19-427c-9b88-08d95afffbf1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:36:14.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5NIoiQvwJ+SY67lM15VnUdyggshZQ8MqdHI/I+ex4ztML5WU6t2aZS4qjAKkvwn/qNtOkuGt0BTSxUX/YIPJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes only need to reset err and fifo regs, so split the origin
reset function to three functions.
Put them at the top of the file, to let more functions can call them.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V4: New patch in this patchset
---
 drivers/i3c/master/svc-i3c-master.c | 59 +++++++++++++++++------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 47c02a60cf62..4e69c691253d 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -236,6 +236,40 @@ static void svc_i3c_master_disable_interrupts(struct svc_i3c_master *master)
 	writel(mask, master->regs + SVC_I3C_MINTCLR);
 }
 
+static void svc_i3c_master_clear_merrwarn(struct svc_i3c_master *master)
+{
+	/* Clear pending warnings */
+	writel(readl(master->regs + SVC_I3C_MERRWARN),
+	       master->regs + SVC_I3C_MERRWARN);
+}
+
+static void svc_i3c_master_flush_fifo(struct svc_i3c_master *master)
+{
+	/* Flush FIFOs */
+	writel(SVC_I3C_MDATACTRL_FLUSHTB | SVC_I3C_MDATACTRL_FLUSHRB,
+	       master->regs + SVC_I3C_MDATACTRL);
+}
+
+static void svc_i3c_master_reset_fifo_trigger(struct svc_i3c_master *master)
+{
+	u32 reg;
+
+	/* Set RX and TX tigger levels, flush FIFOs */
+	reg = SVC_I3C_MDATACTRL_FLUSHTB |
+	      SVC_I3C_MDATACTRL_FLUSHRB |
+	      SVC_I3C_MDATACTRL_UNLOCK_TRIG |
+	      SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL |
+	      SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY;
+	writel(reg, master->regs + SVC_I3C_MDATACTRL);
+}
+
+static void svc_i3c_master_reset(struct svc_i3c_master *master)
+{
+	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_reset_fifo_trigger(master);
+	svc_i3c_master_disable_interrupts(master);
+}
+
 static inline struct svc_i3c_master *
 to_svc_i3c_master(struct i3c_master_controller *master)
 {
@@ -279,12 +313,6 @@ static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
 	udelay(1);
 }
 
-static void svc_i3c_master_clear_merrwarn(struct svc_i3c_master *master)
-{
-	writel(readl(master->regs + SVC_I3C_MERRWARN),
-	       master->regs + SVC_I3C_MERRWARN);
-}
-
 static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 				     struct i3c_dev_desc *dev)
 {
@@ -1334,25 +1362,6 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.disable_ibi = svc_i3c_master_disable_ibi,
 };
 
-static void svc_i3c_master_reset(struct svc_i3c_master *master)
-{
-	u32 reg;
-
-	/* Clear pending warnings */
-	writel(readl(master->regs + SVC_I3C_MERRWARN),
-	       master->regs + SVC_I3C_MERRWARN);
-
-	/* Set RX and TX tigger levels, flush FIFOs */
-	reg = SVC_I3C_MDATACTRL_FLUSHTB |
-	      SVC_I3C_MDATACTRL_FLUSHRB |
-	      SVC_I3C_MDATACTRL_UNLOCK_TRIG |
-	      SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL |
-	      SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY;
-	writel(reg, master->regs + SVC_I3C_MDATACTRL);
-
-	svc_i3c_master_disable_interrupts(master);
-}
-
 static int svc_i3c_master_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.25.1

