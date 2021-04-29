Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD136E563
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhD2HCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:02:00 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:60161
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239416AbhD2HBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:01:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS19RF/JIGea46wxVz1SdrhZJph2D1EtcJH5yZAOQs4dZs4rOFQ23ZeBibYY2GSXRAAo1nL1N1bcR7rNncwg9/MW64DgneS3EwJ4vRClcgkMnHStsADOa1DDpMg6YgYY8ogw9ge93aGvWfNpEw+rljkiz4S5tEaTDTrtABs2mOTOLMInhoShPitAbSeuaAMcmWFIfQm52rqMpJTHZ+Nq3RbeDWyyTsTNYrbpNJq0S5pYOqp03vSBKgoioyOHUy0rVgrijhsP/eXGvVMBqssTDbJKpHggSURuLA+bRpoihtLqrLIjbMHs6nTsUNYGdC8GWhI1WKT0yzk7qr8/M9iGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScCgM6Xj3MfaNGdmWO+nsQf/c4MtEelA8j3CWroZwTk=;
 b=V1cRWc0d8ImI4Iz2JzIgQ1mqFv1I+QQd8lw1afg3o+kl6cLd6/OvKB0huJi68SRtCTnDy6tLpLVUdyy2JeRywZTV9C9vW0esHb4/UHG+7SRs+a54Ec+5FUJjHuMiSN4kXd++oK5R3WAVD/A3X5ga0tQyqqQXynx3xc5lw+5Inz+YvT4tA0j0YISOJRmPPbA0xdyTJpZbZ4b5nuFwUwARwe8zn/WudNDZctii15ZzXwl4IXtcsRwyahWRRDiKj3hLTPthsOVOj0/DzBUqoRzV59HHN7nru0zEBiL9nCr8NqQqC6vT9BaK4RbEfiytRgzryxZ8OCaE9dNKcaR4FTkCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScCgM6Xj3MfaNGdmWO+nsQf/c4MtEelA8j3CWroZwTk=;
 b=V5mlwA2XrvREJ/i9E+ED27elRnXvzIKGdpDSkwLKWhNUkrGI+pE4axtpWDJwZ/9ghKY/CJKKkAwFO5Om2kkam3yoNNpH11fUjEStGfiiJp4q9fM0typTNqa0+nZrHWh91EqRdaynl7D5YbURwtq7SXXiUmgU+89toytCmkd+0ME=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 07:00:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:00:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 13/16] soc: imx: gpcv2: correct pm_runtime_get_sync usage
Date:   Thu, 29 Apr 2021 15:30:47 +0800
Message-Id: <20210429073050.21039-14-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073050.21039-1-peng.fan@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 07:00:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615bb2b2-6687-4cd4-2a6f-08d90adc7367
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB54682FE48F8D99499F8E52B9C95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRVRVPHhcwGCdhBGX9LKXXBsTw67Ti6a/Eun1tfvgSuLI/ogJ4gqKRj07mbXX/rbj3PLfvgX9VqXpshYuumy9yHmO+mklPfRlgHbximGMSMjyuGfAy7DCOCRtthXF4ubvs+Q4PN9i/L+rn1IRMi9tnaJmEae4b2tXlQwI3wqjP+6nBPRGHXYxtyjkkBGIItX/OB3bQ89KAngkql0aguhX6VsYmhyTMH0NxyahkDa4Un8bLPT+xfiZPSMOMYMQ2qxPtaljLnRuDYDWGxm0phzP8MV9K6mVm1mbVkNjNF//irAeBR+QE2wjxvAGzgyb8sWu6MXy1dSYoqsCtf/YFWQilwWakYuPpgdURgo6kvVmb9oBRkxYHRxjzmOEQ/gwjg8uXVNinNVEwxZ2grzrQnU8DX6MQaNKwi/2uqSolMmkS5zvYLRzRIdBTq2mC2yAjtuTKrzJJ3IjgJV8UMgvGIcTHLrLCnZBKWocbylCZ4NobFYiHTKO2axNfMIcnA/85g8k7lwBR6jLwDUftbifuw77xI1sKkCpGRHm7Fsc95OOCB/03TC1Oi7ay6FezlLyWznS8XWEwpKjRP3AOvzOnehSBCUGcBVWs+TEqM9aspEFl3rhHKyLLSx7dlObbEkPXDcz6ceKaoM6X53zXom7d2B8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(4744005)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AlMN295AY+G7neEculDspmywES2brq4KqsUJMHPfb/0U3OiZwVxd5VzKRHNx?=
 =?us-ascii?Q?vs+O0D4Tib3jupFIsAGlhSPK+Dj93SEi19xfhewVREwkCSw67/XPW7ikfS/y?=
 =?us-ascii?Q?mA2GEieg70/58tud6fdorKlhqa8L78xzc5Spkq1iGKstCnCb/IyV+gfy0mU7?=
 =?us-ascii?Q?2tPoFTZt+tfm0n5SMQr244AjVHKuAJSimLvnvezlPzeBGgthV0QMxe5ucnG2?=
 =?us-ascii?Q?6ZmZY+eciaElAEd7elkqdD9sz21zC8+hYtpMEr/txhC9zpa7hSRK8L0PNqA2?=
 =?us-ascii?Q?7ZXhNcgy02v6smuTjAjvflh94MvzwAXBho1U7jWa95LQQqBHfMm0dcHC6uzH?=
 =?us-ascii?Q?8GnqS3DW9oruC5rzaOCmwrpUHSY2XZwszxcFJ1g/xW5eZwJtFznlSKCvO7kS?=
 =?us-ascii?Q?SKSsgvKg++8TxgUanZRhE6pXwVcSCEOOF3FfMgL1X3sOtOFEQJZNoYK2P5Qv?=
 =?us-ascii?Q?mly9esRkWw5p8nbYZijYvsRhdbc8VcQHJuh3cMLKouRjjOo1r/VMY1r7Qp3K?=
 =?us-ascii?Q?p7Rrs2TRo0XqL2qH8cSaQLbuSLHCBwP9bW8daRmhu9e89xyIWTk5rYACN6oy?=
 =?us-ascii?Q?ZzZV3izdX5kTQRFu1ToDpMD/vSaR7yrPsU5E/6e/UTzS0C7n6XAywXxGWngC?=
 =?us-ascii?Q?eum0IPJfWHfer74Dzh/7vD8b+kCMf1uc7Ydacw729vR7AHVGNQSgpdEzSo3a?=
 =?us-ascii?Q?QFC26jnmBDP+26MdoeAs8gxuRXwQDYUYhOaPZXTnmY1XlzdBSFco4kfjWqVT?=
 =?us-ascii?Q?WnGg74JEu/IQJ4lD+29xSuYqj80NxnJ+ST7ZckNo8lGUKBUk92BUubnvjxJ9?=
 =?us-ascii?Q?hTdOqemR8wYZ1EfoGrrLrIJBBMOQo3MipjOn0snRY/jCarswWXFaBhAPpgg7?=
 =?us-ascii?Q?xIHdxwH0yJGNkjJD1P4aGTHcNgY2iIRYvBvszPyXPTQy9anzFr5m/XH+X9yI?=
 =?us-ascii?Q?MgkkZjgW+nOpaFCG51XT2JOd/K9f4f1oqkCmAlKlageQS30ckYrlg81/NbyN?=
 =?us-ascii?Q?vohEB4Li/vhfvdbnu/aS/huRPu5ufbl4W3CLbJT2sRuwpcbFKAm2ahPr5/Cr?=
 =?us-ascii?Q?uIZZ7Deo7r8O2NknUZKLNh0/b5xTGwLXSC6rEb5CWxyrp0kWi87MMY4UhTJ3?=
 =?us-ascii?Q?iDUeZT9ULg0Ot1n0iXq41MG8EpSJUf8Awo8M7frkIMGQ0wy4Qq1Wt22feaM+?=
 =?us-ascii?Q?i5aj6ayfzRfEVlq3rhcpYLi0JExbY/pZSiqPhHpMgmOU+FU9peWYgX0F8BIg?=
 =?us-ascii?Q?sFBXkVPgQXlqlkIRlcBm/iGYDl/H2SnemJPyT2e8N8eb4QnMH+4WN3EpyCCp?=
 =?us-ascii?Q?nBVb6KsQdA6Orgp5tPEyVKce?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615bb2b2-6687-4cd4-2a6f-08d90adc7367
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:00:19.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4uHnv+aVGy4Bw0g+MLaHX/VO+yZ0aI9JnH5kwcigIWroM0O6lBs4mLOTOgYj33P7obK57I19SxU+zses8Dr7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When the return value is negative, there is error, otherwise it is
expected.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 42b9be05e1f2..d2ce47a5ebad 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -197,7 +197,7 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 	int ret;
 
 	ret = pm_runtime_get_sync(domain->dev);
-	if (ret) {
+	if (ret < 0) {
 		pm_runtime_put_noidle(domain->dev);
 		return ret;
 	}
-- 
2.30.0

