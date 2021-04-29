Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85F136EC17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbhD2OIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:08:31 -0400
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:22880
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240515AbhD2OI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:08:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdEadv3ZdPCBeIpOnf8Vm/Aj+IXVvICAO0WuMuq1HmDPjnaALHyGHpT3UxMwQqJ9wPt6jqHsqmVVKA+ZYHh1eQ4Gu9LdY6RVh7r17GIOFYjO19zRds/N2Ec+G66gTqHNY6Sxu1q0Gcx216NmbY3ALj3XY1P88pAoneUw6tq5DLGLqXtm91Uva96Bi7RdgKweLx6zQ7g+Ilva/8ZW+nJ6Gl77+arbJSw+ROBvcorUTjTJpEcdQo96A9bE1x9jVTC6hy2keb1J89uAuRKe54Jj72jN2LoFt8LgxBG00Ey2SX/pAby9rCQ54xR8KIvXtLltj2YgMDfvlWWBi8ELhj4WRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SnCIBDpkalgVVVF+P5DhCWVkYmPO42eKylJiRGYr0U=;
 b=nneYZVmLa+UW8wQ/dznfGbQSKr1EbPE0ttDvtS5drHqrtAvHTs5yxUiMrygvIKHxghJr2pgA4lmwaxPshtD5aGOMcu0PcJdtndO7O0On25PwL5JsIk+/MWLVHDS2VdFMwubMbVxmS3JWVL8a17d6btOHSXOihTsaX4NAGqY5mb1Id9hu6bj3lG5SADsCT+sFPZclIyv7vd7FCuEg4ZJby7ZlFBJ+Cxye6mFv+RAt2NBgVn1LldwC2VBJqKQSfloQ3DM7JeIqLDOWIrWLbfO788llQVjuDX31mw9khtdzlOP53ubJZomtFNqpohuEqXdy9df25SfHVN93hk4Jr/UYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SnCIBDpkalgVVVF+P5DhCWVkYmPO42eKylJiRGYr0U=;
 b=ThE29bM7rhoYJrpF4vFPAUY2AQ70mQfEgKwdNG/twT8l+2rlzbeK8jC5fJ3JZgbeWzzO/ytjlC5scFu0nIwFlz1SD+I0XymZ9SWOvFpiQCacVb5Fjrut32EUwewV1BMVn38iBZpkEPDWdMgNt7aeOfEUCdk5dyJI4yIBzLwgrD26rdXfg00KrDCqxXaecdrVNDB5hauJY7w9qHgg1qlwIMaLy4Lo43V/49wgvhgodCR591pFsHQ34QjoQOW1uWBBT9Ju3s5jwOTocMPTaGUymB/tHMKdPC0YqggqA8FgJp4R6da2JEC3dDoBNcsd321RHBKKqLR3gXTQ/fNz0O33QA==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 14:07:35 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:07:35 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v3 3/4] nvmem: snvs_lpgpr: use cell stride for regmap size calculation
Date:   Thu, 29 Apr 2021 17:07:24 +0300
Message-Id: <4ba0f4fa67aa4286d6e8bff0920cf2e6439f65cd.1619704986.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619704986.git.nandor.han@vaisala.com>
References: <cover.1619704986.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [176.93.24.30]
X-ClientProxiedBy: HE1PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::26) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (176.93.24.30) by HE1PR0902CA0016.eurprd09.prod.outlook.com (2603:10a6:3:e5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 14:07:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 566d34cc-9aba-4dcc-4de3-08d90b182396
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2315DAEBC55B72A2D207AC71855F9@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i42dTBmc1/AeU+0u0dCFI0HisevwIJQmWjnAuwy8kKG2TPjodDna9dllhaaRSNqj1QDdlQ54TorV8Ow4DMCsqzRzM172Vpyo8fWpaa8aInRzAoi1RyKvmbnxt3yrCiJ0M2rTVL8SzJTYbxs1iG8svX367ovk6vr2Cxf/JDzjCVJ/iQdGyZCm4qaTKMN34wu9DE/7vrPvdk8ExCg04jjfe2NNkjgEcGKaH6g9ri+LQVbmvlJZZO8hMqswEI9WlxHE4ob2OXNylSf1SmTmuENoasQCZh3pi5yFMPzzRfpN5E3splEYwCHiaxqEDJ8uta7ki6i0ziuwrh52VjUX4en8vvKCRU/8i8hwUGty//B5rWL+dVPyxfIdw2NahAxEKpWYW/Ik6axBHhtcWOxK/9GoXu8OD42rObq1gBVIOrMRAm1/2H+Bu47EKQ7WWV0vSYlTWwvs8tBb9OExx9OjZOOBcvo6JGrTyWJZi9ljW8cDZhp+uOv1YaAm4vtuoAfQL0tgF6xLPbcbgSOWS0jfxI3OxXRB3U7I9j17GQVZJ25NTpMvJ3gaEMhin6UEBL/fntbRweY8Fs15KxC0d33t99RsGrCMEW4P/mhPSyz999Rk2fZ87790TlJKiEyYkSNhW61qKFjZpw9SxTVT0lihs7B73Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(83380400001)(86362001)(6486002)(36756003)(4326008)(2906002)(956004)(38350700002)(52116002)(38100700002)(8676002)(107886003)(44832011)(7696005)(2616005)(6666004)(16526019)(26005)(5660300002)(66476007)(316002)(66946007)(186003)(66556008)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SfbSNDPGLEFah41VbGPHrToJl2u+nt4rCeVUQo/TafJblnE5sifOozcGb73X?=
 =?us-ascii?Q?u8hlKWvDIP74ILYr4urfDOk/XQW1i4nWpP2ieqjZm8aY31pWHOs7KWhI9kQb?=
 =?us-ascii?Q?M9XQO8J7tyRHQvfrqcL89At+GG0C7UsZCmNKMwNX5jJJoT0LGDpLYMDN3y0x?=
 =?us-ascii?Q?t0tTAWTDinH8EgLtsAXDDpdEtTvezpjmu7imfOK02y2rb0RqMh/pQg9/ZUwr?=
 =?us-ascii?Q?/tTGJPwI5IbWKuxtE5To1/tRYLXhkOIALqISVpCqbcw9QFMaUw3pGOfqshWa?=
 =?us-ascii?Q?WpE+3dlo1H2fYAXodeUBSblgjvgFDoAQPPkLyflqrGFcGbJWGSqnqliU3uHH?=
 =?us-ascii?Q?TQe5nC/2jA6goZQC07eGPt7L72w6O6QFZwa1p/bK4JdxpTd9Mq8HIcZVoesx?=
 =?us-ascii?Q?BxeDjoJTNxgIfXB8HA+NSRX8HdVezPtgkUPlQsPIGzQfBe8C6A2HEoLk7gtl?=
 =?us-ascii?Q?aSlc36agETT7K65yRarxUhaADRf/y3UbvuUh/9w1wq9rEpIdg2K/iZ+1nEHR?=
 =?us-ascii?Q?BggpSKpFby9KDrp/drCZiYzoAfBsVMFCos3ExLuP01SCbiP3JoZM6b8zM+DQ?=
 =?us-ascii?Q?bhmWXHa/okNxeBjCS+GOVaXvc44ucWrrTYcIldHaelxIR17iMR3lRO7oyH3F?=
 =?us-ascii?Q?3PapCxhyzr3lR4Bp1vk2KxkhzUoxLNNFsTdFPZPwMMgUnS2luwpSGrum91vu?=
 =?us-ascii?Q?JFKfDrPqPCiLdzbnCUbB6fPgHhSDE1TsxUUKs+r1ofhmx/ERUPK5e/tWTlcm?=
 =?us-ascii?Q?tns/HJsMvhmCmTn6RkLyKggr2Mp/Xmuvk3Lvu9Axv/qPfcO7lYKZWWUvEevc?=
 =?us-ascii?Q?QviYQZJwT8sae2jlhhIwcLte4s24eC287p4opg+9fZxVbZs19Xh0oyVnwrDX?=
 =?us-ascii?Q?Y932njsFRnWjdB96QU4Jww2o5sBp9ujV0m5JbjO9cSyYlZjUD7yo26IkK1aQ?=
 =?us-ascii?Q?yeZtZfqnkjktHdFubL80Hg67dP1QDLaR7xL+dcR18qES/gx6Fs8HhHb5p/mv?=
 =?us-ascii?Q?6fg8XwCPPHV7dCRuNeO7foqdb4ZbJmqEoQ1Lt//GRlhQKO2rR4Qfnta6NTVh?=
 =?us-ascii?Q?KowmsvhYG/DMIawibSzTyxVxsUqW+gEvRAmDOYz07zNoNZh5k9EDNqwPskUs?=
 =?us-ascii?Q?ZnlOMQccUAeKDWdhM9dPInpHH9nqtqFyGAg8Wd5iFNa7N/cTjbJkxYqWGzaC?=
 =?us-ascii?Q?3LBNREPZC/U6IvCs+V1gk38lRKaGU2Q4Qs+y7xi7GJ99SUicJsiYy/2k5kMV?=
 =?us-ascii?Q?9QS6+CM7W23ahmrYQw6XyK991XiD4k8hORopfQG14t5Q4aj5T4uvk7cmsCRw?=
 =?us-ascii?Q?+UcyAAJDGpAsaVD0dHHGf3XV?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566d34cc-9aba-4dcc-4de3-08d90b182396
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:07:35.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovA+YRfWa3wTCtipU0oiZ9uLLDglZ70J+FwnmuQ4dXTOHvJtvA5NTD9SQSYoO+aCUJmdBrM04hnXKiA6nB7amA==
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

