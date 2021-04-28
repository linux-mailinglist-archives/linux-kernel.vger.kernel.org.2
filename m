Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B90236D8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhD1Nvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:51:44 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:34482
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240053AbhD1Nvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:51:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD5cM3ZLzvD/jD4BeGH8PAa54p2chc9ZpmwiC/zp16sGuHFEBeO0LUcQh1gPwhI+b9uZu02q58LE8x34sfWkHNM4yCc8x0tUBTuPtW+YlphJzcoSf2TfWYn0n9USf8eXY5zWZPEe+fdVd6yGvGy7Jlc88mgQd/Kf/LeHxj7xE0mZPcENjTSAcLnFtzQ0dYpjJVNUyL6ZEnjM2g2k1h5h1gwJGCBKDHhYkJa/jn6dHx4ib0OCdTw0TpxyrzsQfJBcIFllQE8MMwCI+uvJ8ebmB0AXO1wdkwgC/k8KewII6lwmu7ZKFhf4O4lJgOOEFxV3w2BtJr+ltLcRyApES80cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SnCIBDpkalgVVVF+P5DhCWVkYmPO42eKylJiRGYr0U=;
 b=KXXKbNF7pBiDjj/Ja0cpcjly5ffVWkI1OnW9QpkdIFecQiViyfX1MA8VfiMHZU22Enzcib2jMLeTJdqMs6kILqZr5nx9obit4x9+aF5Mcu0DVjsjKFyFqrPSYNY7QmIwi7gtgqNd5wevlLckd5swS7EP1B30s5usoXqUq42i4niIDTsQKPEObX9plNvDaiV3OFUs7BncYOXzy24XJRLSvWecRjJB96CqR7CSlu1m3Fe6UVZFjoND37O7Y0YxFuGXZ62J9a10kzAojkkZxJYG2yg4Z9cZZ7cjCQjYVFfcHWY3k/E5fAiBS4bxFiotFEyo39eH5dGOVlVZmCqoU9O7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SnCIBDpkalgVVVF+P5DhCWVkYmPO42eKylJiRGYr0U=;
 b=Vy4G/mR9BFpYRQhPu51TBNdEvsIwpz+WJXXimwPMYGPp6WSuogi0YbR+DUk+SVqHOxGsJrhCfkTjN1X4dNVo7htQJt1+WR3dVNQvq1Bre0qjdzSz+Z0UqLV6qirbekg9woq2n9z9pk4mDJ2XlKrSNRy7f2LoG8fi4nyEEdgSixAJgTPFJydYA7o3AsYkgJXmdtifImzqzlT72zft0lmkCjgT2ElwId3yBYMtUNP9NCsElTwMgtOt3QDyCgWlL993BqohGyJHoflnJF9nWuwd5dvuzDSFJr3XJO4gxhIz6qCYLN5oukf7TJsWpbkLz+7FzfQ1NOldwTZ3th3zHTWuzw==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2361.eurprd06.prod.outlook.com (2603:10a6:3:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Wed, 28 Apr
 2021 13:50:51 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 13:50:51 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v2 3/4] nvmem: snvs_lpgpr: use cell stride for regmap size calculation
Date:   Wed, 28 Apr 2021 16:50:40 +0300
Message-Id: <58cbd9be039086307790910045b17f37d40a7a86.1619617498.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619617498.git.nandor.han@vaisala.com>
References: <cover.1619617498.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR0701CA0067.eurprd07.prod.outlook.com (2603:10a6:3:64::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend Transport; Wed, 28 Apr 2021 13:50:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 353ffcff-2ea9-4b09-e657-08d90a4ca283
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2361:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2361FD29BE60A33458CF896985409@HE1PR0601MB2361.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZtOZaqniWT28/V5mfL4bn5S+x+06EgD6K7eV4nYjG5EC7Tvw9PSCmDAVg3IObfvKOCQ8QDIpLTLOiZnXlYD49omTGRok5UVwoJP4bIj5WMEWKk1aRGUHC86WGjSx50058QntdPEujORdd2Rv3U283Dc+YnecPbwcRvh+AdbhHHslO99fMsXYqVEe3VYPXmHQ/dt9o5WYWUW/fTt5vAPBL57Jig02Vt7L2BvelkexXGbGlWm9tiIp5ADYBW2WVZ8DU9Kej3cNAjTy3oObm9h5R75RzCq/WqTXHp6R8+R2xCRPb1BC3o6wAQHNLMX5H/Oj2L4cDbDoWxIcdY0WqtOg6IrtIxcpRtitB1QWqfGaDhR3SsWBZgTC5MIvNUO/wRB590AeBuHoXaBgz8LWYKIKH2uF9bxmqCu2PAO6QqNawr8wko1A7IS6/OlElV3rFMRL3O0oR3sGr70AYKFIR3j9zMFsHvM4jDJs+VD0G3j7wBkY7DumWbZ/yMhj3brhARbBBK8HiWA7Agdko8TbA8eru1xUx/UwfI77vC3gpHeFlmerDa5FEljbylRq7aMmnUnmdAaiif7Ll/rLUtzzuOlKOkJ97f0DLqUD+5UOrvHV9ZfBnYw24sEEnzykUXYCxJNLlejKzCVRi4znpFVUSkIog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(5660300002)(2616005)(86362001)(6486002)(66556008)(26005)(2906002)(107886003)(66476007)(44832011)(8676002)(956004)(83380400001)(8936002)(4326008)(186003)(52116002)(316002)(38100700002)(66946007)(36756003)(7696005)(6666004)(16526019)(478600001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UvqTCP+3mYDzMmE8GCndjNSd3CAUyp1W9dnCTmDl77y+uaP2oarGJQItd5hs?=
 =?us-ascii?Q?5pZqmygiF5B5REmPnqU+NNQILL/C/NbbNFCIrhGLO8c1x47VYTrGTPAaWIfS?=
 =?us-ascii?Q?eh52r/1uY/iJgwL8xOVh7SZa/WesyRRxH7qT4RWs1g+L5Ygl1urwVGwJlZ9/?=
 =?us-ascii?Q?ebb9EEtSy/nKw13zCjXFu9IZu29eJXrzk1+D3f8XmKYe6gyAAO3dl8beVSXI?=
 =?us-ascii?Q?ZmO6WxWFJDz1KbrelbHYUfwx8Hl5M+2ad9mEL6xqtQdpCbzFKmJkDcVBpraU?=
 =?us-ascii?Q?SoFfdWbmyLKuVT+ToCtZvT5lowN48W/5MYdUMROwx6sCTAHL6W7ihCeLdtMc?=
 =?us-ascii?Q?r+87oKg0fy7cFPn7LY7EOzLjWqsGOdXc5aLiynkCnjlp1Qa2HWra1MyxkYpe?=
 =?us-ascii?Q?F7SXENUqx2qUrqoYMVkpyuujr4StDPn5JrQw2lZxqDFDjb9WU5Y3+kuuEBZB?=
 =?us-ascii?Q?I4pX+TDEcnM4EGMBZB9iXBfi+MUFeYjDtu36KQW2Pui497RTOgeqFSjJfxzi?=
 =?us-ascii?Q?ZObO4qP/GjHbGtbNfvI2EpOfT4dwpeo2Kmt/Q9nlf5+shl4EMx3eHHaTa3Iy?=
 =?us-ascii?Q?cgva6OM5aA4zHe7v8ilZpW2AJ8cc2I90g7g7w7h1uG49Ea0offljPCOeQ+11?=
 =?us-ascii?Q?kfK7uZppMW9/Q2c3+Lbeqr2ey7eGibuRiYmmyeyROUuM5yQCqTwtuPL5u7rw?=
 =?us-ascii?Q?h6MC83Mc2IF5/weGSwaGOJEvFra8qLmGOTk8Ya77ZMUEv7b1jVOaCn1nFdVX?=
 =?us-ascii?Q?QcThS+/KkORwf4Pza/IuCocfA9SM/4HkBqDmPGf5uUCEbA6E23/JNkrQjb3Q?=
 =?us-ascii?Q?/UTI/BSUxps/I2q8IgZQe38szXfS/pnkXNNyYrMIA31OUUCYs6okgtA/GIoo?=
 =?us-ascii?Q?0kjcEmoJZNlHKNGqQJJctCnmEfdKrOp0XogNAO/yQ3v4cra1dm1Uzq6zcCpA?=
 =?us-ascii?Q?+F+hhZcfom5CuRBiLBN0LxJJqydZlDCUZykNhBcJW5Jp0GiBBx42KT6wbtUb?=
 =?us-ascii?Q?BgunkjcjfzqRXvOr4hFUqzH2IAXyoyucnmGuvELwsfL2r63GB7Lq/oBkt38H?=
 =?us-ascii?Q?uZaww9Itq3TrPSgP/rUeaJk48PWnWKxnOu10qnqOKGM+J/2ZL5/zCMQWwoCE?=
 =?us-ascii?Q?2B16EeZSs+yN8xjKWtlitPq2/fFd7R0BT1VOTEiKmJtma0UTU/EWgkpTPAtP?=
 =?us-ascii?Q?RiCTFa9otpqWKJygNOinzIQ0aVRXRO0kPLwGNCr75Z7/VuZfPWzYjLQ3LN0q?=
 =?us-ascii?Q?1/cl7yzeGCyAvGy2EgnRaXxgH2uMvKyslrApVlenrZPpBnrxHVIkGo2LCDWH?=
 =?us-ascii?Q?EHOlPDsR2KmSyh3m7LYccf2j?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353ffcff-2ea9-4b09-e657-08d90a4ca283
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 13:50:51.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNbGF0xbJADIBpcFVPCwQjTPBPGqxFXs8BILLi6d6hsgwzztWVGbH067XQznJPaZPRjodXNsiTIMMepLB+zaFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2361
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

