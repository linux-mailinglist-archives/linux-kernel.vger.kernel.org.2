Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64839419C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhE1LDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:03:04 -0400
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:25731
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236687AbhE1LCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:02:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXOg35OreDN2YMxVn5mPKa2un6OY0ZFw4jav7hI6pl/YVpsJp6r6t+s5AcgoH5r1EScvcW5TExS6ei6RqZNpNw/zUgyNCiVzB5g4jMYPYBbyMmOrqB1LVf4lKLM1pmtvTEM9z8o+aa8yFZKGtxxLd+cHCb6Ee2IVPjSqwRAXrfjf80dYy9467LfbaewVlo834uPXML8qq9SOuAmTgnLJmUCt71RZ9N5xZT6fji0So6S7xMFhThJ9x0DCWIlTtU7m6fomibwPzpW0NT5547mCm/BxJmDSq4A37WoI48HmpJ72Aa0cseZQOKAhR1t2PJVlS/N4z6C5th7I+OFtZGPK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z2SQXkgBc5fTMJwrLqnoN/cVuxBR8AzI1NHhM1Zcqs=;
 b=WUII9cMdjGZwxDL8z0+PAm+l0GWVAHf1Qa4DOYMgANq8m988/+cCdHCfbAuwrhZARCugGE7qNlBz3m3/iXXxMwS0t6FEJaTJceRGvzkBJ8yEkxB1/3CieWGbjztdVtoutpyIaidrBRzd7/KyawwCyB5bH7b9pd/zczL+Bv3lCxIB8W15V5AE79xX0Js3xtilbR1RKxlB54LpFvE7GCXOHgV5rFkzvylycWnQyEDxhe0dCj22ZFeUqYrnoVGanrfVy7TY0aoTkmBC0Rk026Ck8QGaIsegMdChDNFu47sjgb+/wFU9SbZ6qOmN/Onshn2mB1Jc/emU7VJSFHLeK9PA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z2SQXkgBc5fTMJwrLqnoN/cVuxBR8AzI1NHhM1Zcqs=;
 b=hLTnqpdW5XybEfKx499nF53SHY8uGN1G9uZdHs8LJQ9uGANdXT/s7hYSHOFfOzZ42qZWJW6C9KZudaendM0GUI+NzpvmkNQ/rYXjYLdVXTECnnfYyinTTTqpRv8ftj1b7uAMK0DJXt6JB0dsgMxNfil2Atcx47WLNxKPBJ4YpjQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 11:01:15 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 11:01:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] clk: fractional-divider: support regmap
Date:   Fri, 28 May 2021 19:34:02 +0800
Message-Id: <20210528113403.5374-3-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0158.apcprd06.prod.outlook.com (2603:1096:1:1e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 11:01:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10468c9c-3cfd-43bd-63b6-08d921c7e9c6
X-MS-TrafficTypeDiagnostic: DBBPR04MB7515:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB751520D565E999313DA97741C9229@DBBPR04MB7515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBOI86ncsA31EqqNPNbmZc7UFUoWCIJvsqjidETW0RoqvtTzUqZACeo1qqHaoCsKjG4qtdF0Dk4zvYEsMKJGH/wVngFD1Q1D9Ornd3Vn7Gvtr2UwBgKaSf5uSj81A+c0ZdDZY+JbP8KlWJahbIp+XP3RBPjg0tC1CML6NXdhIDb1IwSsbU+3FTNeDIablAKPQOb6dL69VHD9MhCcxlQlL2ib19vKtAp8c8qnRTjXAJ3Y6cPEsN2JaUvD0s4xZ+1ZQszmN/cCVh+yEcYLPZNp2yDG+HQMGZrfb5V3G/wRscbta3hDxIGW1PhdDRiJUbC1AGf/h5ZavVOTg53k2LPIwcB/1XjFnk1YfHctFRZhYItXiE6N2R3xOwvlM6kkqCpGgASTkVQlFNBhRJDz/acPPiDlKOfJFLdT0lgSIfvrs6J5tOmfJojEhQJP7rcFDQ9jyN7dHzvT2+LkOTavePP74cGB3la1XFxuP0N6F8Bs41XI5ZWMkwAwrktNx3eI8krJcYYHB8VbD1vBVvNk1sBuwHBx9uy8souIUKMBgCns9YXbGvSZwfMFQEt/rVt+/U1vNDIwtOSOvVKGm3w7vvBB3VnGiwHnhe7v/dmlvS1Dv2+/qmhbBsmRvorxP8HegyXJYlIOzvqT+9swTdocuO69xL8KVGkdIxV5v9y9DFK7ks0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(376002)(396003)(366004)(52116002)(6506007)(38100700002)(38350700002)(26005)(86362001)(83380400001)(2906002)(1076003)(8936002)(66476007)(2616005)(956004)(16526019)(186003)(4326008)(6666004)(66556008)(66946007)(6486002)(8676002)(5660300002)(316002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uG4CStC/ufoy5Kp2DivrqAWO4gxkR7W1L4PHJ5OKvo3vwVCLzg2wzbMjh2YZ?=
 =?us-ascii?Q?daCpXm8X32x8bCwpUqGAgFD9JEd3njnxiLVxD5XhWsllQ2ZHZQPNNAy6moc3?=
 =?us-ascii?Q?YZ3FHXS2Qqv5/m7BKQm3uEagv+jjVBxXdVHXdNB7gwGqebYsvEV5U7p6WRSr?=
 =?us-ascii?Q?pEi3o2umF3pUqV/BRdwcnpSRHZAB7L7/Ha/IHoihUJeNQWjP51F0RhYyLnge?=
 =?us-ascii?Q?sU1QO0II6M+J34EArlkrJttXRnRcLp4GVX1/DZMQ1uZ82aHHq8bqXyuDK1bT?=
 =?us-ascii?Q?kGOVgITgV4TrSdxZjqj+/u+TLc8eSgQZoUctOdcon5AbwPMUIwLlBcV2imIK?=
 =?us-ascii?Q?0pGMhBZRpxzaIpRWlwzl8+qhF8zBXWuq0/rvyuPBifSKzrn2tFg0O6KjX2oI?=
 =?us-ascii?Q?jwplFCFQAY0P3Z+WfzJ9PQdpgyA9RuvgS5O6+7M9wqEOlioG+8ObRPeQPhd5?=
 =?us-ascii?Q?Ilr0RSrb2gCLgHM4iaH8oQlJb29JnTyVSVBfznFuXLAfQyyvJ95H2oWE5p16?=
 =?us-ascii?Q?p+uuPb/oOVL8FeSZKX7fbMp3PXURRTOaUXxfAHiWUEb2666UppC1hGAb9wVA?=
 =?us-ascii?Q?6xucG+nsruYtQePCrEVMF551jhYJ0uSVNE7YGu7IMe9RxbaCoya5RXQ7r3Xo?=
 =?us-ascii?Q?+Tik5rDdZ4r8W3+msr6fWwAyrEO3PSGm/4D+0wquSBTycBsDPEvuAS8Wh5K+?=
 =?us-ascii?Q?Ld4AfNBrvQwgVeWVgyGo33utGw7cltHIJNEsUSSVcceY3guwOcdBJf3um9eL?=
 =?us-ascii?Q?WEWXY0ENDTokQAjbGg108FU6P9sVpvZhE32f1vhwdBRy2AmBjbN6frfZwCqG?=
 =?us-ascii?Q?o9A6A9kmbPOPIt7mj2WZNktQgd1xvkxW5t+D46xyl9JxEX8oyGIkzu+Rm+nC?=
 =?us-ascii?Q?rT3JHUhjFWC1dUHAHTt5GIOYSBS+om/YYiHmtUS6HrsCNNgvFAXWgNWF8G9P?=
 =?us-ascii?Q?sT0+1V/hR2F9Mqxbw65xaRXjGaAzM4jHplGHdjqCSwfYwseIOCS+S2BysMNL?=
 =?us-ascii?Q?ahezC6wOci5xdT/n3lyXV/tbZz3byjCbldNBPX+4T8Rv1qpZ8bm7YBzvSdE5?=
 =?us-ascii?Q?mfDpS9xUNXLzpUyMwvrdpR8CXy+qRS7ZFMWleVlxYrqCuHdiNZcUgiA5pgzg?=
 =?us-ascii?Q?+ysUOqjvgmYaVPtRwxNjN4PjUTqQLUAkq37YwiQ/Pn5UHQ44gbYwKYe+tr2o?=
 =?us-ascii?Q?lc/U8j1dcfNUBqJmTYBG/I6jPvkxfo/pjL4qNPvAC6XxpLCzL4YBQiQ3E4L2?=
 =?us-ascii?Q?7zAO/mqdjMdbtkXSTfoP/iK9g9mRiQS9MBl/3+BtNCx9BeHCBSNDYz/NdZ5W?=
 =?us-ascii?Q?Uhr4xZZrpFtG67saH+1497r0EMZTfEw3bzJlS2Fw5WE6Vw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10468c9c-3cfd-43bd-63b6-08d921c7e9c6
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 11:01:15.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peCL8F1SbSHlR4Edx1YbpH0kX1DTtT3onfWCIV4J5NS2YXMPGnjpQvH2Nlw7BGuadKBZQmtqQQNtTi9MRdFqGg==
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
 drivers/clk/clk-fractional-divider.c | 26 +++++++++++++++++++++++---
 include/linux/clk-provider.h         |  5 +++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index b1e556f20911..f2df5d278214 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -11,23 +11,43 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/rational.h>
 
 static inline u32 clk_fd_readl(struct clk_fractional_divider *fd)
 {
-	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN)
+	int ret;
+	u32 val;
+
+	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN) {
 		return ioread32be(fd->reg);
+	} else if (fd->flags & CLK_FRAC_DIVIDER_REGMAP) {
+		ret = regmap_read(fd->regmap, fd->reg_off, &val);
+		if (ret < 0) {
+			pr_warn("%s: failed %x, %d\n", __func__, fd->reg_off, ret);
+			return ret;
+		} else {
+			return val;
+		}
+	}
 
 	return readl(fd->reg);
 }
 
 static inline void clk_fd_writel(struct clk_fractional_divider *fd, u32 val)
 {
-	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN)
+	int ret;
+
+	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN) {
 		iowrite32be(val, fd->reg);
-	else
+	} else if (fd->flags & CLK_FRAC_DIVIDER_REGMAP) {
+		ret = regmap_write(fd->regmap, fd->reg_off, val);
+		if (ret < 0)
+			pr_warn("%s: failed %x, %d\n", __func__, fd->reg_off, ret);
+	} else {
 		writel(val, fd->reg);
+	}
 }
 
 static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 6bd9288b953d..3902f883cdaf 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -990,6 +990,8 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
  * @nshift:	shift to the denominator bit field
  * @nwidth:	width of the denominator bit field
  * @lock:	register lock
+ * @regmap:	register regmap
+ * @reg_off:	register offset
  *
  * Clock with adjustable fractional divider affecting its output frequency.
  *
@@ -1012,6 +1014,8 @@ struct clk_fractional_divider {
 	u8		nwidth;
 	u32		nmask;
 	u8		flags;
+	struct regmap	*regmap;
+	u32		reg_off;
 	void		(*approximation)(struct clk_hw *hw,
 				unsigned long rate, unsigned long *parent_rate,
 				unsigned long *m, unsigned long *n);
@@ -1022,6 +1026,7 @@ struct clk_fractional_divider {
 
 #define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
 #define CLK_FRAC_DIVIDER_BIG_ENDIAN		BIT(1)
+#define CLK_FRAC_DIVIDER_REGMAP			BIT(2)
 
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
-- 
2.30.0

