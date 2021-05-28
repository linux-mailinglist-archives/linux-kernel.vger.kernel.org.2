Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E005C39419E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhE1LDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:03:14 -0400
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:25731
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236706AbhE1LC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:02:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc6G/9L/OL5qHN7ppPhL0mxs8Tt4qhJu45PVYd+QZWIA7ZdBlqFAOHzl5xJi7ICZL3biCRiTzf3sJ64riD8PkWxclXz/TO2elVTaLmWzd7vEBq+dXymQwD0M8aH+cCQO7NF692pHbQjkRjfyMJPAfPxKDOS+wqXc2dFXhOjdymqZQ7wPhkhiBumnFt2xcwJJcyd4+WrAEXXgywCze5apJIBHZQcoZUhgJ34IyYUhULS+rmIIAizVcG6rBsqup+ylaf70BsqzCDqZeH7lyYr/rViEqfMim5Wy9ZYVvX/mBMkcqSnl/xfwkg0DOJyp92tKpI7W6bV7+3X0K+NEb6fm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG4RHISMd9d8I8UpdoMuJoddBpLFg3FBP2zAwIT8hXc=;
 b=aY/+TVWs6Z5C40xnnzP0pLg0ANG1W9pODir597DdjKeOdIK0I4eubkAcj0/ZVwBlpAvASYfBCJK9r8HWj2+c7l+yfTaNogzjYxJTWrWo5sj5bxELMF2UXy0dRoHWd8IV/Bqk40VSSyH1OOCbWS78Xr/Ib9an8RWL1JrdwTgasyFXx92Xqh8DZJvmaBSoeyj2EnLWK28wYP1V1f/bNCc123itUFFIrZ4p3kZ5xNAVtF15BcvUavs4Ccv34j0A63E9HvgJEXXoD3Rbftitr9Bjn8WKahfc+g1rNceR4WhpLZxwSyaLo2siKEHAL2I7U6no0jTb0SQD6HItdiP8fGHUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG4RHISMd9d8I8UpdoMuJoddBpLFg3FBP2zAwIT8hXc=;
 b=T6k46WbZtzaO6i7us2/7GblAUnsd+Z+GJG1mKHiHoGJYe+6kGrETjqzPelwRQvwJz1wty3wAaUmZZsP6SSrVYcXsp4k6hUCRdOpoBHbJuD0cCyGFGr6w5qtCZCvdQgqydMdJ2+UPJklGVic5ONVExzgtqBxU84qnkYaLKlWvSzg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 11:01:18 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 11:01:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] clk: gate: support regmap
Date:   Fri, 28 May 2021 19:34:03 +0800
Message-Id: <20210528113403.5374-4-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0158.apcprd06.prod.outlook.com (2603:1096:1:1e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 11:01:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1209f343-7984-4d1a-b5d3-08d921c7eb7e
X-MS-TrafficTypeDiagnostic: DBBPR04MB7515:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7515A679C816013E51A8661DC9229@DBBPR04MB7515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2NOdlB5i8bz27dilRK7VG8+I1zr5BlR0uGc54gSySJ2e5uslK05BLiW6ot0VnJ++YCNOnUGMcGT4PtXxgI9Ev1QFjc40iPRPldUjv2LKT6F6jGaJYxNawjrFZVQDhKwZ+nrAkCcPjef57RVWI3oSwQGMlOmqjt+PBpM2SFwFwSjlAAIVsZVTqKFd0z0z/Ko+jPVR9o9MWqGXtwy+XWO2OAXRnRj4dkmLgHVZxRp4WFMI2YF+5lDHxeTmAARGXxXinA+YGpbO18Qjrbslmu3AQdxfK1mKtTpbaOaZER5KvH2lhuHD5Z/xWH2M7qf/jIAkTChoQbS/EW7WPKn4/pOKKA6FZaWslQvalx6MP+5nytBBG3umvgJN61AE+OdaYzVD+l8t46YHMv/X/2ixgyknSu5kcOWLV6MkAfFxDHvvXwUTaRT8u+JMG3fSJeZqGmn936qNTqF7uFABSFggOBaxOg4prp5T5bugUISg0NVK8Btn9+6w5nQOhrdx2Rp9o1RcF3cyEECpu91QzZvoooUvl3EQZTeJc39x08DWdhNEe4ldFNhYGYz3+8MvQhc0eFCUJ00hOrPszCzBYD/8U26PN5w//6VZ3ppxFaHV4cbCziVsyonNvWMDnkZTvxDVIeH3zFYTPAY16eCyDi3kGe5KvlOd4JAHXX+981fF/HDsZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(376002)(396003)(366004)(52116002)(6506007)(38100700002)(38350700002)(26005)(86362001)(83380400001)(2906002)(1076003)(8936002)(66476007)(2616005)(956004)(16526019)(186003)(4326008)(6666004)(66556008)(66946007)(6486002)(8676002)(5660300002)(316002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hWM+7EiGUlcZmVePSJMK3f8tJgXn8dN+DUc75h0ZdHVpzmpwxIUbUA7f6Z1/?=
 =?us-ascii?Q?71VGqkEagGRb4SFRA7+o2RHY1lL0ja5fMg/KYAyCCkqPAIcO3srA99FwZ5/9?=
 =?us-ascii?Q?o5ERNJo0WtZmzAHMrPn+R9ZxyQWTAJUvvEdbA7ij1vGchFXuWQz27gg2oXYI?=
 =?us-ascii?Q?k3uIcda7LENA+Cjdv2/b1Zq4tXtl/LcmFEQ0Areni9i4vY78mwf5gvN3Nxq4?=
 =?us-ascii?Q?fahoCd358wBY5nVoSxqjd/Hw1yI+cqhu7XcZWE6XaIKi+ZJbO+3pjIdSiz51?=
 =?us-ascii?Q?L/v/zzYo7KqOxnQEdaFXul2OsdB9peQ8ZbC8lAscBNmT8jaEEUXvRGNPk2DX?=
 =?us-ascii?Q?GXm6EuKEO+bCYEkYP0oenNQL/SQso9/FLFaOEYE4mJU7re4ib/hbUk9zvoTl?=
 =?us-ascii?Q?dWO6GcRGB4aY5E7ERfrb+qNngY030UCcP/bJzgIiqRQ1GIGzbR9j8U+9aAlv?=
 =?us-ascii?Q?cBwlwaDzRIf8Xk7kd7arTNOB6YoZuRbefdhyzG4hqM2qb+omSC6lTwILGW9O?=
 =?us-ascii?Q?XnTnkTJnPFPyr1TO9vhhHGWy/9zOoP2CQr6I1FbVSsPs447v8+MzzvD+hyZk?=
 =?us-ascii?Q?IKNmpgy2TxgOzExaNMCQSM3R2Xrd5dNODOVKUiVueTmj12ARUR6IRfEF6Y6M?=
 =?us-ascii?Q?Gmml2widUMQh757eWCtXtYUjXX4cVIqXRJNkKCFb5ZoSk7350lOmAd6tWrUJ?=
 =?us-ascii?Q?UOZeeuyaPRB53HdGgt+eKbyiL0u95VqVkjIbBuIsFNsDUahetxmdcRm0WWUy?=
 =?us-ascii?Q?TDygovd8tw9yNoW6WxoR5seaipJzWqpXUsI7KCatZBXt18WUGwOTkwfB0UkV?=
 =?us-ascii?Q?CDBDHgroqyZjB72x5KIxHzo1hGrHPxYuxKezpNaZG0gnQllHLoWb3O96OZeU?=
 =?us-ascii?Q?jPSSAWEE7HEuvYhFWsZfyF2+fO5lwlyFMHoEFQEwzOh5UxdZHt+Gwhe85t4/?=
 =?us-ascii?Q?elFsBGuH0XRMgXUOnJ08hwQoGQ0kHioVlM3OO49s7a2I6Q/zjT8NvIOywifV?=
 =?us-ascii?Q?CPztTaz6tWUQj06mT5/DktcEBgVCejExnAkF0p2qM7lJMfOPXbWW992kG4AE?=
 =?us-ascii?Q?IUzcU4GoZ9SiBrac0+uZUaEs2iYQU1c8oVqQAoXUzPMoIkx5brSoYvsJ5X9d?=
 =?us-ascii?Q?DMaLU70zONkRi4MtkbQqnu04rQQHxet72NVRRBAyUpa9GBorKZ3yfrS8Suoe?=
 =?us-ascii?Q?k8WYGx9n2QK1ibNws9pDI6Ap6chDMbAJKLtAyiNsHoE3nVrs9/aD7RjCpCS0?=
 =?us-ascii?Q?6skJmSor8aNIvCGoBXUhBBcHJuAw9V99kCpNCIPXERm7AbJ+NjcYUsnwr7vC?=
 =?us-ascii?Q?4xPWLLAnA4Er2JQUX6ANZ36wtK8M7xIQePFQYZsjM7gaKg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1209f343-7984-4d1a-b5d3-08d921c7eb7e
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 11:01:18.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbuRNHhfSvpZ0jmlovz9nefN5mTRG+5QYKsTO74YRp7tM0aqsNWwtO4LpAIVew2Pn00hr1Lvm1MSY4xTymcMHQ==
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
 drivers/clk/clk-gate.c       | 26 +++++++++++++++++++++++---
 include/linux/clk-provider.h |  3 +++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 070dc47e95a1..1acaa2f5a969 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/err.h>
@@ -25,18 +26,37 @@
 
 static inline u32 clk_gate_readl(struct clk_gate *gate)
 {
-	if (gate->flags & CLK_GATE_BIG_ENDIAN)
+	int ret;
+	u32 val;
+
+	if (gate->flags & CLK_GATE_BIG_ENDIAN) {
 		return ioread32be(gate->reg);
+	} else if (gate->flags & CLK_GATE_REGMAP) {
+		ret = regmap_read(gate->regmap, gate->reg_off, &val);
+		if (ret < 0) {
+			pr_warn("%s: failed %x, %d\n", __func__, gate->reg_off, ret);
+			return ret;
+		} else {
+			return val;
+		}
+	}
 
 	return readl(gate->reg);
 }
 
 static inline void clk_gate_writel(struct clk_gate *gate, u32 val)
 {
-	if (gate->flags & CLK_GATE_BIG_ENDIAN)
+	int ret;
+
+	if (gate->flags & CLK_GATE_BIG_ENDIAN) {
 		iowrite32be(val, gate->reg);
-	else
+	} else if (gate->flags & CLK_GATE_REGMAP) {
+		ret = regmap_write(gate->regmap, gate->reg_off, val);
+		if (ret < 0)
+			pr_warn("%s: %x: %d\n", __func__, gate->reg_off, ret);
+	} else {
 		writel(val, gate->reg);
+	}
 }
 
 /*
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3902f883cdaf..0a4c01a023cc 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -474,6 +474,8 @@ struct clk_gate {
 	u8		bit_idx;
 	u8		flags;
 	spinlock_t	*lock;
+	struct regmap	*regmap;
+	u32		reg_off;
 };
 
 #define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
@@ -481,6 +483,7 @@ struct clk_gate {
 #define CLK_GATE_SET_TO_DISABLE		BIT(0)
 #define CLK_GATE_HIWORD_MASK		BIT(1)
 #define CLK_GATE_BIG_ENDIAN		BIT(2)
+#define CLK_GATE_REGMAP			BIT(3)
 
 extern const struct clk_ops clk_gate_ops;
 struct clk_hw *__clk_hw_register_gate(struct device *dev,
-- 
2.30.0

