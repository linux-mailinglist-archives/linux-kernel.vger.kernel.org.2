Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0577339419B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhE1LC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:02:58 -0400
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:25731
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236672AbhE1LCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:02:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mICGJOHr3d/xeKkBvzAmXI7K7M7lAyJhCQr8c3J40oNXM7KpkzUUkoawbiQr012bYAoqCILtaAyEJIbWTNE+Gn6jDFMTH95fzSXK2JSsJXxpT922cuh/2b+KPQEzI2LsY9sI7B7qCLR6SBdVMxOnJTl02PQ6iQoFWKk0GG3zaXVMD37OMX81ZsN8UpZYzDg7jZPu5unPeI1Dym1pu3mSBA/VoQ7xcEg9VCSABFebbRMPjKNVDVooEbp0CXb+Vv531WSBOdigWjaHDRKYheqneRsC1IonzMDmQgxxVAJD7v/aCRV570HKPT6m61xgdfKXfo08R5ge5snnGLEsL3OMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehnDs1bKvjCnIAHP+ItHg3liG51qTsbsRbjUrdM7d6M=;
 b=BzkMwOUfGKiOq3hkKnjRLKSvHw4JxBz1JcnywmQC2g7pujWatHZ5GMshoy9FDEBDlt7qJUpSrZZGocd6YI4f8/T/5PID99ixgnOQpgX3s8Rb6R7E3fttg3PhXP6fyeB6dkzWQNE9BeUWpl0hfabAvBWeU5zHSkqgS98Y2htuRmi9k6Mnw/+NC3m4RHU4Vn4+9HJpWA1KfjX0256CyoTktQiHgq4bYpQQ/hrAeCSC+BuCADds4s//aQ8ZL/oP0lmcdUKrgqPvmL7R+TjGHdEv4vJhzt/UtFiLxPhiN3+NCK45WDTJbmYwkixwYzyFJB40i5xBOMQRc2Iz1GLGU+F4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehnDs1bKvjCnIAHP+ItHg3liG51qTsbsRbjUrdM7d6M=;
 b=XFZVqL1HAl0XOQ5cM8f42jYjOkj63YrKKKO5KmZ78JCJcV8+aW0HsVf599DFFv67ce5Lhy8QhIXJo0jvTivJ5LHtWrS2zBTSCe7bdYgd6sJwGjgBpJsQ02FXh0S2Fz4WH4l+uWYVZZ1yzfH5IHaqHY9X6v2+uEjxOTvLUIKot+8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 11:01:12 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 11:01:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] clk: mux: support regmap
Date:   Fri, 28 May 2021 19:34:01 +0800
Message-Id: <20210528113403.5374-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210528113403.5374-1-peng.fan@oss.nxp.com>
References: <20210528113403.5374-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0158.apcprd06.prod.outlook.com
 (2603:1096:1:1e::12) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0158.apcprd06.prod.outlook.com (2603:1096:1:1e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 11:01:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d3dc950-8f6c-4719-60cd-08d921c7e7f3
X-MS-TrafficTypeDiagnostic: DBBPR04MB7515:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB75155F76987308C91146AB76C9229@DBBPR04MB7515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAssaWqBvG5tHfhSZgeSPdNEvGzfakFpDvrnrdxRr3YmhRjW6PR7f/sssy7yT7lXoElBsmRfkAEA/NtzKNxVMgZ9nSAMElTpi3auLgnFQ18bHWQ1jZUGeaFkp4U4HTklLeWEbd34iQV49c8y3IaS+TfuBbddHATBfBl43lcpxdDFuZxzEqm63qugip8lzJDHZ7sEDJeaCGSy4GjyzxLpfAxkU8Yxwut5/LXgXr/yZyhic2Q/ig5LDzexXusRxwFrtH+jQ0IO0C6n/nxnGSp0dBMe91+zC1YbEvadmmGV3gu6UEqAOoVUWv+5vzgxy2zvE2FdguTRUGrwR5ZgmIBaUtySlaLWPeiu0SsIbVBBkCGX3O5OFKahahmwoBxhJ8Y8yRWyGs9VjRep5xtabJBqHQB7Ut7OutKYt5sfVyKsCQMe/qskOnufJEtFypn/inIj/ZQtGXBb/nIdWpQdunF1DrkThop+eXNsdsBkYOfEdK1dsF2K5ij90Gp0Mxyvgjr94vHyIyfL8P+oyftDy3QmQBQUAdIV3SdMp3fxwsR61rTClGZ8APpdPYIrDBMNVMbeRnPIvQGg1X/TyY4ta+D3/kPf1VuX/wr18DM8gGwYLZ2WWL+xJ1nGaxt0d4IIjmoxqJ8pWphmHWPkoDbE+Fob4rn9e49Spvm5BalLu0LCXCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(376002)(396003)(366004)(52116002)(6506007)(38100700002)(38350700002)(26005)(86362001)(83380400001)(2906002)(1076003)(8936002)(66476007)(2616005)(956004)(16526019)(186003)(4326008)(6666004)(66556008)(66946007)(6486002)(8676002)(5660300002)(316002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/ScGhPNRRidAiVibOTrq4UTklce72F7RY2b4Cv6Yu0e3WvgdORodw4T5W99+?=
 =?us-ascii?Q?B0DMdIcNvXEAJ68myhF7llputX/GH7zSEA+xNGDKglpjxx0WggGnitZQJQz7?=
 =?us-ascii?Q?jUou5UApC6mChIUefOG8luesfHCO0hJ6qwi1fvQZHNJsJhDnHHximjW4lNY4?=
 =?us-ascii?Q?VI9IecECIptoKbOB/4+4P/BZbrYtqxuAaRQUaRu5xOdUDwJpPsAhR+INegAT?=
 =?us-ascii?Q?nAi3vr2y5T9aN9jvZqkd/wrvh+qK2Hm35EFgkROaYgn875hAbhKpOqnzqVnw?=
 =?us-ascii?Q?C9LQFczFlD4/50LNKyNQOaFCl8ZUdGOgbtBiaHYuBPi6ZOGKMYNF7aPZkU32?=
 =?us-ascii?Q?gfT4Bd3Gq0vJTj9ZsXxHqPrLgwq6nkCmMgGFOt2zMHrHVxsS+YOucmymb0bv?=
 =?us-ascii?Q?jp1ZtuaWVX32k68AEbfSS+atex1qkqov7beU8posVpG5CVht/OCnc2Id9NF5?=
 =?us-ascii?Q?Y94qNFSFmJSBAYZqZWzBpFX+RsiSSqCNzMZij15Oeia4wwTQYRR1q37UCXLd?=
 =?us-ascii?Q?adPGo6Y+zSqdghJfwX5dIGaGULQ6AhuNgJM9oYOFQT/3RkCsBxSedIYtaW95?=
 =?us-ascii?Q?aev6/JTeRMT2sWGk/OQWvcDu13Aks46VBeXCgu+uxu1yKHEjkMVUD2mgciQ5?=
 =?us-ascii?Q?G/es1dI1UnLrFrZv77LtvRVrMUJfSomGpUWIVyCb86gTFiScLRWvuEnWAj5C?=
 =?us-ascii?Q?r8Z/Onnez8k+WDg6F/AFS/O+u9K/wM2UZ1g8sLPGAGKYbW5qViLJ9LgnRUPS?=
 =?us-ascii?Q?Z1P8AoY1twggKjQLNN2Iw1YH0aOwMOcohvbtJ9LpQjG+XxWFAe8Fs0AXrGt+?=
 =?us-ascii?Q?Eb2T41e0TPGoTgqxJxaT4cuTZTpGb+e8QLAuTmvSgKed/f0noL++56YUAXZQ?=
 =?us-ascii?Q?DYHwEyMzW+W62NStR1mS8orXs0QR0XrGkTTxRetvRu++a69Pg72JGvfFPJ8E?=
 =?us-ascii?Q?LybTZ8Mfqfcm2ag/f2k2fZltFEP9fKQTsPVKeH08A+n62WDQ0nR/fL04KcO4?=
 =?us-ascii?Q?63sdEzi/Ldw775T8Ep6ad9Tcrsz765ocoFFVPQcaEZldrX4Uz4G5dfxKT6Fi?=
 =?us-ascii?Q?Rxruoz5At55ggZOQHqhsAarEGWlLpiTuUV0thuvrfMYOV77hf7m+TmklwkDk?=
 =?us-ascii?Q?ptG/Van+F0jOkI8oFZhb6H0kjENAm3HgbmoXK5g4O4n0Lic6WR3vUDGc/fGX?=
 =?us-ascii?Q?gWsJh/Tn0DoIDMaa0S/0wNqt/8g2/7ndIfSuI87dNqkM2jSkqVjVHDDF8KMQ?=
 =?us-ascii?Q?ffCGvZRd1GrmE7JKSHzmBlPmD0OuAQy7d3gJDXnQuc96KBGcDqntXOYdqd55?=
 =?us-ascii?Q?+YDXTFrjMPDBoqY4/UHYbw2GhZaG6SM0yfAuvDujEl4gug=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3dc950-8f6c-4719-60cd-08d921c7e7f3
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 11:01:12.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+1TRMAVrLm5UbXKlVPIaW8Bysk3ewqT1JODPEko1we+8wm9s09PMrwf+SRfUKxUti3go2s+Y+wzsMvnFZdnPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To i.MX8ULP, a PCC register provides clk(mux, gate, divider) and peripheral
reset functionality, so we need make sure the access to the PCC register
be protected to avoid concurrent access from clk and reset subsystem.

So let's use regmap here.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-mux.c        | 26 +++++++++++++++++++++++---
 include/linux/clk-provider.h |  6 ++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 20582aae7a35..90facb6eafe6 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -10,6 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/err.h>
@@ -26,18 +27,37 @@
 
 static inline u32 clk_mux_readl(struct clk_mux *mux)
 {
-	if (mux->flags & CLK_MUX_BIG_ENDIAN)
+	int ret;
+	uint32_t val;
+
+	if (mux->flags & CLK_MUX_BIG_ENDIAN) {
 		return ioread32be(mux->reg);
+	} else if (mux->flags & CLK_MUX_REGMAP) {
+		ret = regmap_read(mux->regmap, mux->reg_off, &val);
+		if (ret < 0) {
+			pr_warn("%s: failed read %x, %d\n", __func__, mux->reg_off, ret);
+			return ret;
+		} else {
+			return val;
+		}
+	}
 
 	return readl(mux->reg);
 }
 
 static inline void clk_mux_writel(struct clk_mux *mux, u32 val)
 {
-	if (mux->flags & CLK_MUX_BIG_ENDIAN)
+	int ret;
+
+	if (mux->flags & CLK_MUX_BIG_ENDIAN) {
 		iowrite32be(val, mux->reg);
-	else
+	} else if (mux->flags & CLK_MUX_REGMAP) {
+		ret = regmap_write(mux->regmap, mux->reg_off, val);
+		if (ret < 0)
+			pr_warn("%s: failed write %x, %d\n", __func__, mux->reg_off, ret);
+	} else {
 		writel(val, mux->reg);
+	}
 }
 
 int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 162a2e5546a3..6bd9288b953d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -837,6 +837,8 @@ void clk_hw_unregister_divider(struct clk_hw *hw);
  * @mask:	mask of mutliplexer bit field
  * @flags:	hardware-specific flags
  * @lock:	register lock
+ * @regmap:	register controlling regmap
+ * @reg_off:	register offset
  *
  * Clock with multiple selectable parents.  Implements .get_parent, .set_parent
  * and .recalc_rate
@@ -855,6 +857,7 @@ void clk_hw_unregister_divider(struct clk_hw *hw);
  * CLK_MUX_BIG_ENDIAN - By default little endian register accesses are used for
  *	the mux register.  Setting this flag makes the register accesses big
  *	endian.
+ * CLK_MUX_REGMAP - Indicate the accessing method is using regmap API.
  */
 struct clk_mux {
 	struct clk_hw	hw;
@@ -864,6 +867,8 @@ struct clk_mux {
 	u8		shift;
 	u8		flags;
 	spinlock_t	*lock;
+	struct regmap	*regmap;
+	u32		reg_off;
 };
 
 #define to_clk_mux(_hw) container_of(_hw, struct clk_mux, hw)
@@ -874,6 +879,7 @@ struct clk_mux {
 #define CLK_MUX_READ_ONLY		BIT(3) /* mux can't be changed */
 #define CLK_MUX_ROUND_CLOSEST		BIT(4)
 #define CLK_MUX_BIG_ENDIAN		BIT(5)
+#define CLK_MUX_REGMAP			BIT(6)
 
 extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
-- 
2.30.0

