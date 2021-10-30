Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C35440968
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhJ3OK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:10:28 -0400
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:58192
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229877AbhJ3OK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwOpB8kymM0FUFwgAP8UDhG/FeRA+kIWEH9HXAxYPROOh7WT1FI7sk7smv0iwiVOMNLwka34/2UvmWckuK8R+x083TBhr3f1K6/Crfs3ys0Y4TwIExTnSQ9/JUyA0MwMzl+YafQ5A/0otUlSnEgs1/riov8xxHtxYP91bbucmJdMOdzuIi+qeD4ckIm2PbDwPQ5eI8Wzux/PFNaqPpLukgUHgZxrWQwBy/g6qMw4u7vA8aQ48lwBucP7hntqygQvhYhAAd8/G2UohzEuX6oaGBQMEpkNVnHPxWT9TDvMr7jKg60KYr1e4y9bI3iliGy0f+K+MTcjn07pSDs5diW7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTyEncDh0c6FyeH6ewDUvYCZYaHfTD7nRkocSGGyglA=;
 b=gEeo3/wjUYmoiVC99RrCgB6wIQ6p8CrkKNeweDGFNgZMK9rzYZ8Uhm9K5AM2ifKBfEluS6puLWzqzBqqy2110NZMFuNu1nq0yER4xWUgDtvyDJb3G+Po4YB0QVFBB4ZNhsKtHvzRDlNIPpBf6O//g36x8ifvt3I7E+ukVQm3W6yQTj7dmjeJW0XkZ/l9LAg1GaIaCU1h+VSPQQ7YrQKJu+tJcz48zcy6s91vRB0KzBo6qDvQX75Xuv7+mqy/iR1LpGKyot8Y8vR8dkAyOIzT86RCQW5f0IEKAsyNrX9ZZ0LNXRlKmsozuXDF3RN1Q+/b34PebJ9oacBD5iQ4cK7pNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTyEncDh0c6FyeH6ewDUvYCZYaHfTD7nRkocSGGyglA=;
 b=v088HzDWvm+zpNOnHObUq/Y0jcmzusN6KliDSwIJgL4IX82zAiCRpJX26YyzLkd7Yd/GjPisASVeDs3Km/LuAKrkryGD+uAISEwIyeiaMTGG5AgvCgXKdtG8ixvZcbkGERoYUhw55a2uwZPGdXSYOWTq0HvJOFaJVty1m/hGmJU=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none
 header.from=connect.ust.hk;
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB0985.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:e2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Sat, 30 Oct 2021 14:07:55 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.018; Sat, 30 Oct 2021
 14:07:55 +0000
From:   Chengfeng Ye <cyeaa@connect.ust.hk>
To:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chengfeng Ye <cyeaa@connect.ust.hk>
Subject: [PATCH] clk/mediatek: fix missing null-check for mt7622
Date:   Sat, 30 Oct 2021 07:07:40 -0700
Message-Id: <20211030140740.6947-1-cyeaa@connect.ust.hk>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:b7::8)
MIME-Version: 1.0
Received: from ubuntu.localdomain (175.159.124.155) by HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.0 via Frontend Transport; Sat, 30 Oct 2021 14:07:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5652177-7c59-4c66-8c5f-08d99baeab46
X-MS-TrafficTypeDiagnostic: TYYP286MB0985:
X-Microsoft-Antispam-PRVS: <TYYP286MB0985ED0B89A14E2B26F031FF8A889@TYYP286MB0985.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61qeMAe6YOOrXCJpQqWmBSC370NunEErWGUTrYztZnv2ZuoXYknAVvCPxcFX03ium/eId35OcUkL3mE5R0L6N0/QvZVwQYH2C8OxohnkG0oFDmeWk2j02jysCn103t3Gfe+R0Ln+UQs/0FaRf0VKxjJC3BDqFaZOCqIKK99TSvwM5QB86g/3iUqsyfavUuSuqMwB4APFp4zh5Ha/pvigm6x658V/Tl0q/6CnLQdXxWsjPk/aJC2OEpKpfVNwmNwbqGnWN8QdaoqHamysm9hEMUkWDo2MOWG7hVDGCC1+ct34l8Po5YCPOx0AgMEGAcZaS/8DtVxcM1nLkDS+HagWvVroVdnHTflDmd8/q/niiNhoIuZrRrpwknn/x878JFQmcmom1wLJ/A8KLFOBz2jdIIRLC0rARLi6Z41LEVQ07Z/Q3R3W6mZCsG3ZoDew2+vs0Dz9U88aPfSUX3oB4c+19dQRvwYYSlBwamiraUzvOQP2ZDoTKWWmZJm/hZGfezcMWb6hPK8EYWTxPOxEZRchncdlRrhFe+YXT9Zc0nPcw2ICHAfTEQ4RcSA9LYZA1Prd9J6LKAKiuesRqmj7suJ+pgnyW8MHgqx1ImqmpSTIB51ntLcsMOkyWrv1I5nPlRyUNKiH+SMkxj11w1fXDfgaBL05nkEkesZK7P8D6WODbYVkdaF8QOjADrTxDxp5zu+/4RDtPXD0p0GcBqLBNB0fUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(36756003)(316002)(2906002)(38350700002)(956004)(66946007)(5660300002)(26005)(86362001)(2616005)(38100700002)(6486002)(66556008)(66476007)(786003)(6512007)(8676002)(6506007)(107886003)(52116002)(508600001)(8936002)(6666004)(1076003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJX2fJf5sZRj8vwXm3WjPGc+WpIOKBc0GG5IRki83Hy9p0Mqq73DKi6fydAU?=
 =?us-ascii?Q?Kr5UMsNtSiBKxGnhD0yy9KZ+uGlQWvul01Z5gozWfNQlMN3oozzsY8ztWImU?=
 =?us-ascii?Q?cpDuCmu4few083nd9P4ZHQ9WnCanEI9mcUP5ZmwFHDqcUO5jb4Bcmn7/bbWK?=
 =?us-ascii?Q?uO/o0Md4mqW5C7ADJGTNlQAl9MF3V+jzgf3duhC0sOZ7lFrh+RrmMQru7o/y?=
 =?us-ascii?Q?2Xbeq74Q5qZCBb3b97/UkX0whqVVgvHxPGEqs3UWxOAAopV5ww2CqW7Ru3Fi?=
 =?us-ascii?Q?vsjXKRZCTbnFH71hSprVBup8PVKX6XP/QqSBjx8jWP1yJfVhKev2hatDP0Le?=
 =?us-ascii?Q?5PlQez9CqOEdgddVLZtD4ws4VH2jHef+BhSIy2i93qwutThJEMegmbQcuPGZ?=
 =?us-ascii?Q?smjhPUj7FbuEpEmFoDyKY4hrR1NPpFaDHi5FsVOgXxwnkx1JjjdGUNlMuHEU?=
 =?us-ascii?Q?pyLQxiqwpRyJTlpTFdQGCaTUW3rMWUqsivy6j6V1n1NBqDu+NhkcINi4GYHZ?=
 =?us-ascii?Q?0GFHHHWixSDGCbZdlLgtxirmdYddS0u45s8b76J49oIHT39csc/YtSF2SLC3?=
 =?us-ascii?Q?boQkpBG9ako1SXXoOISV1hRYapXypQbZOANTibw+YK3RsJnSFvJlUA7VoEhh?=
 =?us-ascii?Q?THsxj0pe+xERz2C67D20M5NwOTLUj/+m1jKVbCt/b6kIqIdjm5LMG00bRZfB?=
 =?us-ascii?Q?hH1jkxQaFDi/NRvvdJ0298wOhKrwmoRi1TeaHKGJHA1siNPCy/wd+XcCSyyQ?=
 =?us-ascii?Q?SlyI4KjnZz1Kmblwh/CP6DHUjpc+9cSpXaUcsCoo3dK7eHiPq2UxcNNtaL6Y?=
 =?us-ascii?Q?mA16F6m0ED/g9TZt6cm1mc+Dg1sO/pXidolH4RFhU/Fq60rLd+zMjfSEQJy+?=
 =?us-ascii?Q?2mwxhy7QxJgUb66vyrT4K/tOaO1lFsOSiTLy1v9bjG2kI0kn8GVu3bs0Phb7?=
 =?us-ascii?Q?gQ8R1z/+6qN6PmmIaAoZzXAN0uf81KLrqnn07wpQPnYKR3z9MlBTrn1DYqgJ?=
 =?us-ascii?Q?EVZLCUZnhOLncO9+RRUVeA3fdnjHLSFgBFICxkJ4kF30RY7EJIn9L578iV/A?=
 =?us-ascii?Q?se7zQAWzdOmZb5ovj3GNq+VK0KAyb4Wny6D1dbIvwl/Fpx81NTaJ1LZe/boV?=
 =?us-ascii?Q?7PcVyM1VoMp6KVfVcJ0nAOCrr1yQoBwKlUucyvSbe754FeYz+kiE9QrYoWBZ?=
 =?us-ascii?Q?o9dRdVQeXAE0tmCPJA0zG+Kswe4CC3tfEdBJDANtv0o/Z900vM7d8WkYouR/?=
 =?us-ascii?Q?gCVdZ+v5k2/qxOKJEbU7pVDgvnWkjFP5GsUWBLu6Mav3dMQFBqxhfs6p1pVg?=
 =?us-ascii?Q?NpuV22XnJmNq8UjFcKwAtHRIw157YISn2vRfMmG/ZGhBBfrshQJBBE/bS+rf?=
 =?us-ascii?Q?Xy8HMviiVOeOjKcm/JKi8PD//z0xBcURfcw7reIMYixLJCTEG47z1V6yLSTD?=
 =?us-ascii?Q?1y0BRFW1pWabSWHUJkOW34I9wxwPv30IxAsI7v7ZG9di0OCYjQVN3LB69QNE?=
 =?us-ascii?Q?kEMikfIwb6i/ezoVoAqIhpNP+TBWiGpXYVgu27IPBEy0OGYQ6eOLFXhNuVzo?=
 =?us-ascii?Q?IUCBhb2IKch36Br+rArO9Go+ruu32JcxrNTVaEs9NNYJjodI6AfYO3g+tP4Q?=
 =?us-ascii?Q?Qx2XTs/+ekq9mDQdPmQFCGc=3D?=
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-Network-Message-Id: b5652177-7c59-4c66-8c5f-08d99baeab46
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2021 14:07:55.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmW4GVBNT+t8HAOXrZiGB9zlIzYvDytHh8mbzVq+33Kr5pTIWfwtXQS1ELgEVHeykCf4a/AfUhjMyQtctB1CNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB0985
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return pointer of mtk_alloc_clk_data could
be null, adding null check for all the call sites.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
---
 drivers/clk/mediatek/clk-mt7622.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index ef5947e15c75..f16b3655ff76 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -620,6 +620,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
@@ -650,6 +652,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			       clk_data);
@@ -700,6 +704,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			       clk_data);
-- 
2.17.1

