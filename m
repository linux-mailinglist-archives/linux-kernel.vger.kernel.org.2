Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34936C0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhD0I1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:27:44 -0400
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:21985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230325AbhD0I1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:27:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlfqb3/6b8ZlOwDnvK8KdqGAxN2MieBp35mpWQkfDokR10TXkRy8qzrgOeCdgVyDi2YgKSEzQvOGWyqf3vLd3evUBg2bQ1LkwHOLHpb+hDNvArAIZIYL4VWHfnna1I50UAvpo9Nl/6hqRCILxRN3b9x640LxNR88pR4Q/tfFWNngXPshLVuNwjw7CzF6osIypAFD414aU5qSQMODjBnVdFgkFtkhr1zluMnCh/ojhLNskr50RTcB9g7rUOhdLfxms372HXhIAueX+oCPJbF+acekN5kDgbUAbXmNFbf1/WC/+XPAqMuiY41u4jj8g31gY9gHSnUKvSTv4ibNBaztRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SnCIBDpkalgVVVF+P5DhCWVkYmPO42eKylJiRGYr0U=;
 b=aYcjMH0jPm0UWAzpKmIUYjOssG4f5fmEPCH/BJC40wWLvf8uXHmuMTsff1ULBSTA6tUzbv01+Hhd/yB+eYfPpwmuaEJizD2Z00M5FVGXvDQ5VRbXEaO0u2CTCKJHdCh5cfv+PYmPZ+y7b2dIbzUYNPdImBTLZ1tmRLhdiaJaoWo9pBf2qr/jsxWwwv0RW0/d7u/Cd0HaCW8Bg2ilPStIGMBZza9iwD3Sm6BY249lI6JSPmqEIJZHYoBmqmZcwF4MvZjpMyLQ0jUgNI4lZBTnTsU9CALpJc5UYooku27FjhbWUo8pcQF69li4rczHXZOcNbwxC1J3kCYUITVSWaGvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SnCIBDpkalgVVVF+P5DhCWVkYmPO42eKylJiRGYr0U=;
 b=XZw53vpaP1ZWqKnz1FwyC1C8mRsTUwBs15lA2SJ6bFgif4rF7Ch1R14g++qoRBZyHnDbcCJvvGQhPMaPJAfkTLyOBNhzY4JPZeGUVg6qTIpI0cqL9bmXlSBOkemJnnZAlidFtnfvoS1k8Uvalo0FrL0oOsvdTDJgULfu8fPZxfa28x17wTTR/2RegiKtaoUS2090/yQANpI87oGZD1qHL9xH/yXaaP5Gw2YGdPFa7OQNRDv4ue18aNYFEwNZs15/HO4Qs1m5fq9NQF6gjZSnNYKHBpxdG7mL2jitFCUc/AfxezSoJULgFla5UxJWOkj8taOhjzQ9TBQ5BSwPY9Jr+Q==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 08:26:52 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 08:26:52 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH 3/4] nvmem: snvs_lpgpr: use cell stride for regmap size calculation
Date:   Tue, 27 Apr 2021 11:26:33 +0300
Message-Id: <282a5a3d5d9f143d22cb5ef84fc43891ffdb03e5.1619511801.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619511801.git.nandor.han@vaisala.com>
References: <cover.1619511801.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR05CA0162.eurprd05.prod.outlook.com
 (2603:10a6:7:28::49) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR05CA0162.eurprd05.prod.outlook.com (2603:10a6:7:28::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Tue, 27 Apr 2021 08:26:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b06a7404-06bc-4176-58a3-08d9095635cd
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB23155F40C44F8B48ECD48D9485419@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXtqO8Vp9oXS/Cxi1Ag6idXA4qPjTOQOdq7ummXqTVZcRHqCrPDf69NoK1sPtaKJt3whSccBhv1YhDQ/BZNU3h8pzG8zOPeyCN5npr5bbotx29sZ3BtrUq1LTJEsUceI4LUgzn31hxCUeFieMw1Novvz+IJjT6tqf0hukYVOLUKHaVXDynatDLffbQYYqNDhmUWyolZjD98mIkKJaiI7ihUCLkT+iXCb5A4vxlWu2El6HY26tuJFcXCYA6hXj/Gj5nvclxk24/VGW100B6rRRevD7iw1dZ6pLIGrGwvJiNan2Gi8gLayBs8mE7uTvbdu/S2b0EUnl0W+lLzeAUoOt6L8fLH8jbYyVns6fKwvNKU30MNPcysj55qrO007wtPceyLfSrbO0qfAQa0VXSN0dXH1WLEmLAjotjV8D4ocaLKGVodizRdTYfezPQ7wVj4Kr1BdEPkPDDXGaPoyYcmprd9LG2l0XkLauxYgFOxhBc7cjniUwbKQ45xvbPR62n/Zq+3xj+F2BQq9Vbgy13ZY5qyr2YWm0FHQ3z/R4OIv7mvHkdTxOuD9c4LeWlPapYvPoIhaAzi9HuWF/QU2MgrtWHGBkOH/ITWbN+uQCUHu89B+llz1HDtuu3c4pstH1HwJbHm4b1LCjzDRBR2/dX/fAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39850400004)(346002)(136003)(66556008)(66476007)(5660300002)(44832011)(478600001)(26005)(6486002)(107886003)(16526019)(186003)(6666004)(2616005)(316002)(36756003)(956004)(2906002)(4326008)(83380400001)(38350700002)(38100700002)(8676002)(8936002)(52116002)(66946007)(86362001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CN1qPEZAEkldweGQEz0Tf2kUJGntBnsEWJRvwGbi+Gff7/Fl7s/rQF71Bf5v?=
 =?us-ascii?Q?TLYCQJZXZglTX1HmMZ4yHpwpouJ7SvgsdAwJwfmQyByL/kvFLf79JgENwJm3?=
 =?us-ascii?Q?bGMXx+RStxJrcCzCx4W//5eZsJ3i7af6LA3MPqy1bZygEOA1YFL7jBq9t5/f?=
 =?us-ascii?Q?l4sxbyv6Jbd/i9j9nWqF1vF3m4CMisJpzyGaUyxbVD/gJ/NlWgRMhjx2D8Xm?=
 =?us-ascii?Q?QMgGSXSpysLJIbnPQdXU0cDk0FR1ctztYkWkBvzYylMb2mTbwakKx/yPsZA/?=
 =?us-ascii?Q?B24yn9dga4wVpMGYLvm+jf63KCwdkLPxlQexJnf9hY+qKvF5Guxvh4XkqKvs?=
 =?us-ascii?Q?9AWadejd+rsOREHH/9O1pb+gnD4nQaHkls0lft+38ZYcLvVFk/mTCr4fFrai?=
 =?us-ascii?Q?RMeOxA1E6zqFR+t7fmg4/WkOHRbdmUBAjQ56QYwAey2kodUedYDLiN4L53Ev?=
 =?us-ascii?Q?rQPzZAD0jTqAENnM78orTt9yrKTtI0t2HuZwVqYsrKPFkNoVu3IxX5tOWGxw?=
 =?us-ascii?Q?iXGi87ehf825ESvPoj3KRVXh38dzSjbDAZAn//lVnh5phxr5OznFzyUvdhm7?=
 =?us-ascii?Q?C0hI65fzUIacYlnEfx30GLZKFUxvhoBmb0q2y4l972+mH/a4MPVPlE+2me+W?=
 =?us-ascii?Q?MeULnVWxNqvuV3y+M0iN6JIosgP8/xL5v1vydGhwNCSp8a9V/53PeTbtoVIg?=
 =?us-ascii?Q?WxYblXyn6ddCTKZPGwrMSyUoIjpSPVxRfgv2ImpRFMj49bKuD12m8oYXOEY2?=
 =?us-ascii?Q?D0LLo2MdvqtP7EX3HnczTzadsA+njytLrAcynBxYYSgKZ81vKwdErXuCir9x?=
 =?us-ascii?Q?3hgy7tjffVRxFFZF4HZBuHl3dc3kpDpuSnlLdf9SmKIo6M2rWe3NIZZEJFYi?=
 =?us-ascii?Q?Pu3VeD3p8ItzmDF4Rck1AOaixpGiG4kKp3nA95gSlTUUU3X0qXEADZJRy2hL?=
 =?us-ascii?Q?qFGi2Xfsj4UqHwCHcKP5+FPlv2LjYUn+u2W+PKLWS6bVStt2WO12TCNznPGH?=
 =?us-ascii?Q?2MnMpeo65xlgyOus33H4oCO+jz9fbtEp/m9NEdhSmQNyM2HNfhNxXarVkLd0?=
 =?us-ascii?Q?88vs/oVtRTlNffcxNQUv3mIz3falcWnimnAOrYIWIUwARUY4CBFhbQh+LrwG?=
 =?us-ascii?Q?yUdxZ6Eajeyvs8G4TLkp8zTlaBmrFiH7uqRaWaiIetxWP6W+kn2Wq6wrSHYM?=
 =?us-ascii?Q?mW1r/k/VcuG2+0fK0rTwO/ats5U8YXCRJlbRydgkVyClCdPse6IH884hUb0q?=
 =?us-ascii?Q?3Ou885eHYMqfd9q/nOiWe3LCT0lqToZgV/FOgFpBylyfzWZMYcw2ZHS/TQDC?=
 =?us-ascii?Q?vb07CMhvVqCbgjYKocrUZ3ch?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06a7404-06bc-4176-58a3-08d9095635cd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 08:26:52.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAI/1h5oQGlXvu8QF4RWBt2/ZSJ6ZzYraaP93qw02EAI2QExqUxzu5fwKY5nT6tb48YWX+RDRbH2UayEyrnrkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a hard-coded value for calculating the number of registers to read
makes future changes more challenging.

Change the calculation to use the NVMEM cell stride instead of a hard
coded value. This will allow specifying different NVMEM cell sizes.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---
 drivers/nvmem/snvs_lpgpr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index 4692aa985bd6..35457421314a 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -72,7 +72,7 @@ static int snvs_lpgpr_write(void *context, unsigned int offset, void *val,
 		return -EPERM;
 
 	return regmap_bulk_write(priv->regmap, dcfg->offset + offset, val,
-				bytes / 4);
+				 bytes / priv->cfg.stride);
 }
 
 static int snvs_lpgpr_read(void *context, unsigned int offset, void *val,
@@ -81,8 +81,8 @@ static int snvs_lpgpr_read(void *context, unsigned int offset, void *val,
 	struct snvs_lpgpr_priv *priv = context;
 	const struct snvs_lpgpr_cfg *dcfg = priv->dcfg;
 
-	return regmap_bulk_read(priv->regmap, dcfg->offset + offset,
-			       val, bytes / 4);
+	return regmap_bulk_read(priv->regmap, dcfg->offset + offset, val,
+				bytes / priv->cfg.stride);
 }
 
 static int snvs_lpgpr_probe(struct platform_device *pdev)
-- 
2.26.3

