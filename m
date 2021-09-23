Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF22415C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbhIWLCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:02:54 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:54915
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240442AbhIWLCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:02:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkpBt5dEHqPJ18Lf86/C4fo9ttCf70Lg7d1TlhFJTcL4QfctYA8I7PaGmsOgc8J8zxXpYTiZVISx4bofkV/mxeHxEP7makEUhWzqTkUVNFPeb0Kkl5gpRj8SeFQOMwhyc5GIZ5f0rPTplBqQz11Y45F+HWWKQ/M1MkhplAa2BNXsSoStIffA6yye3rxb6WWWKtBVP5TvUCoXvNius5l/mCEeBYolJ8Vls79ldPvIWh/lrHnG2FSeLE8tMw4njmeWPdqOKByZzoLAXr42/G4UlNajluVbHWC+KM3RpZBzk/zeueZ6TlxYFrOf9B83FPj0Eo596KizIgflixq768AYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ueuWPSIKuJFJwaGclxCSNB6T64FLl3aDoSY+8oR2i94=;
 b=ZUioluyMCq7mBcAGDA7rH+yhA6Ya6FkGditA/pgxmyBBfQNCATcr+Wc1RT1L5wT+J9QhP+zNuW/QYsKmiIhKcL2AwIzHBhAJLS3+uQYGV46qo9fyAy0GND8vLodyUGr17bLfRPYrFMhSqQTeZCWYjDJMYO4oIklKRMZg29/xy5+bzZbQfx02DfNnIgcTaqEfF48/aal62nazduU1EmxlKPcgIUaeYlmeRqGeLId3XI1sF2sFHZnHbbU8nPTex9Yp+j5deDuZWa7b9ZQTMOIyDGCbL/tfOy0flRlGttPu0rlPgAutMmKVR3hdfMgl/X3cNIK6MxUz0FfkB7fhWlOYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueuWPSIKuJFJwaGclxCSNB6T64FLl3aDoSY+8oR2i94=;
 b=Qk60MOwu081bhEsNDyTIDMiafCUHBg1C1nI1RwNjM6eYlnwkuMxzVG6e8VQgwP+rMWKzFgjnbSU1177XaVCtlIx3YHAcp5/BccnPuOHfMWpPLk+aH1tsAScTpntp/V6MPyGNTwqtl/kSktwKt9QsxEfxpjbNcZ9l25OR+02O+Gk=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 11:01:12 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 11:01:12 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, a.fatoum@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 2/6] nvmem: core: parse nvmem cell-type from device tree
Date:   Thu, 23 Sep 2021 19:01:05 +0800
Message-Id: <20210923110109.29785-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 11:01:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c42168d9-3eb7-41b5-751d-08d97e817477
X-MS-TrafficTypeDiagnostic: DBBPR04MB7836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB78364CF0D100C614F16BF076E6A39@DBBPR04MB7836.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8IgAL2v1YjYfPjQq0WsHu1HNURvroXdRCb4wUhsg/SMWuI9q60vZmTinxs0jFuJXLIe48cu9J2sNOuNmGtGzjQ2mIVe5bPGaPcAoEzML7QYahmkZXX9qoOaq1ZM470hlv7KK7WIdzvX6LgMuHpI9nmSHP8wkziAiY8w4lkZTWUWBjYppbQ0goevLRuEBIoChWYUolG2fGV4ANcnS+RVf3q7RIlT1IP31aNOZtsX/Ym8DoUlBKqVs2WdtmTVDi6Za293oYurJcrTQUa3fQgkPDNcmxLG7LT0c9PUxPRq5wamRIruIX3JvCZglfwYx9VkYuyscAB4aDQt+kRgnEKs/Acgy+nu8W/PPfANGQKAtLvrDBqEgzVZa2+BPzfSL2LBZLa0geSxH2k+ULKADimGE2sWxhUEleX8v21LMyDpm2AU9KOPSLb0glHBdDS5/dLxPf4JRQiFTxIjUGoNm8EUo9LDeecvhW/4Tx4BkKodg8YwMizESpq3qOFSiPtQILTO9yPAAY1OOznO3joHd5+1A4CfSNo9Z+eKPKTcWEjKh6/3axAfpRt8bIn8SdQ0b33W7LxXKRfTXg4b5rKPcdg9eHLMjcLzpAF2TeaycNSVAYvn1M3O7vEbjS1DRS8yne8/jxE0JGY2YM/RifQcaZLneOkrdwqnJlHKfk2vlhY33YJDeklTuN4FQm69Qnrazelx24PuDfitKUW+57TzHDzoHtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(36756003)(8936002)(86362001)(186003)(66946007)(2906002)(6512007)(38100700002)(38350700002)(4744005)(26005)(8676002)(66476007)(6666004)(6506007)(5660300002)(66556008)(508600001)(2616005)(316002)(956004)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ihjtFCgvVgiezLG8BuiCqSbt79kwhCIAYTl4GSZ6S8IMuWy1oKWVMn9er2R9?=
 =?us-ascii?Q?5dzSgUrB3Q/Iz6/IZxdQePBkyP3+gwGpFHf3tIEXKgqIzH97IPHszC752y8o?=
 =?us-ascii?Q?GedynYETYyJoVpwG5soq+O5hfxFREApfkExXOc1CMc6JsZgjayUN5jOQQD2j?=
 =?us-ascii?Q?19gHL/aeE3HNN3xDDI7asMKg0lvZ8xOzh066HzGCslDcwHEaptw6DYYZZmWs?=
 =?us-ascii?Q?oFUZyZeOgCAm/SMAanoNlgi7I11LcrkGPDhUf9Jm6jN9yMvn7fKkOOo25COB?=
 =?us-ascii?Q?5XIfLsNDfnkK+TGhZw5vzxND9K5Mkd6NrCaQCY31x2wzsW325jcP7cdxk2y+?=
 =?us-ascii?Q?x0vXjkPZ7SWNzY3cmQ6EtuKzU3FU2wBhyF+S9slNAQp9PBZGZMKGkP0TzZFg?=
 =?us-ascii?Q?jwW2lRtBx8AxQaOmof2mvnVOCnjRa8N94+JUBum7iiYuyTqSxfO7GPxiUqeT?=
 =?us-ascii?Q?IZQikTu8ME3NUVcgEOlHqYkFxamhpXtcuQTTOZ7ubj8p4LaGhOj9cxRjntCJ?=
 =?us-ascii?Q?QxNHLpxwfFds0wRbSnIC0WUZD9gqYfzpwIEFrgfslXZQu8vkagCSWfvKQe1Z?=
 =?us-ascii?Q?yJBJCRL539A5/Wx/EQEwZt4sUolTY33h5isDDNoi5NURXy5VjZ4EBujBGq+Y?=
 =?us-ascii?Q?5Eg5+D8o7/TLiADlYmintgSSGg3vusCc/UockyTpBlvivwJbaF/uRM4nFiEQ?=
 =?us-ascii?Q?ec5qY5T7HN5tLFDS8uVjjF3Jecb4ADbsU/FJ92dxedf5n26NiAMCdLWURjJu?=
 =?us-ascii?Q?V2jF621b4Eg/LbBynXBuT0/z65IPL4jQ7OzeQOtbNkbckjNN4oE9HRpBzRLB?=
 =?us-ascii?Q?wfhFQDo4g9vrqBAk8O4gBFvTZRhbaGZ2NdIncIAmZBsVWjKTv0i3r9yuK2ek?=
 =?us-ascii?Q?DdtuGpvda8RbI/HZpzEKFnwfdCEW2q7jCt01v//fSUm3BV+oJ8Opo3MnUR9E?=
 =?us-ascii?Q?DrvXP5V/T/8CmSBMXXKDEiSVUyfh0IVmFXjPfXeJVKrXxy2C14cZpQ+KeDbz?=
 =?us-ascii?Q?KknjcOVSVKUkGQ/CkQyx3GSUt44fzH5ER8DGy1gNTEO3b31yvoNkj8JauNYN?=
 =?us-ascii?Q?J7Z6+iP9RdXnQrffqxJqT99wfXj3mVRtAE841GIdn76BORwTy6sIGL4m8jBE?=
 =?us-ascii?Q?f1KAxgkQY2HX2vyEmDZAeXLXWL8BM1o9+mkOE6g2WjpCHoqjvZo5ilX21xDy?=
 =?us-ascii?Q?RN4pi5+adZAsH3KfVnlkouOulQGHuqy2lAVYcVJa0mEYS5QseIw9dMvROfu4?=
 =?us-ascii?Q?I14x/6l28EYD9RlC+p4jMCIFqgzatRDcaOCAIg2+n39xDteitBQvkDXs+x4H?=
 =?us-ascii?Q?4aU6AKy7TmsuNdpB168wNDeh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42168d9-3eb7-41b5-751d-08d97e817477
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:01:12.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mSn8qqRTTGA5w7zaWfjedjZO/ta5l3TYJeVNSEp/5nYKS+AglLLX5JJIJyKyR8ZGUx/vFc2Grj7UorHHI+Eew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

get nvmem cell-type from device tree

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/nvmem/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3d87fadaa160..23c08dbaf45e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -52,6 +52,7 @@ struct nvmem_cell {
 	int			bytes;
 	int			bit_offset;
 	int			nbits;
+	u32			type;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -726,6 +727,8 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			return -EINVAL;
 		}
 
+		of_property_read_u32(child, "cell-type", &cell->type);
+
 		cell->np = of_node_get(child);
 		nvmem_cell_add(cell);
 	}
-- 
2.17.1

