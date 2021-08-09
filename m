Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A193E402A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhHIGgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:36:53 -0400
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:41569
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233365AbhHIGgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:36:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj8N5JjTtsN5cjomMtYjkbn6XZj0a1QHqrtKx2qAC28BeVKsS1lijlcN3ODP9VLttZV7cNoy58aIp/ehSSIYyNRbJ7d8kzn57SJCgzlrEW1QCWWjQUxIadKHqS634ax415fb/c/j7IM4I2jITSdXwujqi26tuCphRvJUL1XmRbA7qxuwZ9094eApLSkH1v5cMqAGO33FY2kKXzGHSwDgNnJ7n6helkRBFBh/vONSoEFitNTuql9q+WKD5uAepSNPZhQI05suB8fxiY5/RtHHrJgxAEEXfZjiUhP36yhv6f9jf044aNRuu1JsmkN2A0Z4F3B4oyaNV8tnBcUb7odWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XNe/ldvRxkAOeWzeT7LtFtWi01Tu//m9efW2csWohk=;
 b=SY3FxISKH99G1xjyH7yuHGt/PoUh25o6qJIQyZPWY+RahMGTBdsh2lZzrIjZQR/J1Ukp5nLRJuGTNxfE1x0MQ2fEAF2ujhCoqwpMy8Zj5XYaJamfeLF039vxu8bOQXBGf4j4I5XnJXNmcHAAp9srMigu0fZJ19w+TUAd/+kXzEYbBRsLURZZEDpZ2u+n/IwQQq7nr3BhMfHxD1AiYsseyx3FBYpBjWuibKq4sDixLLwYi3+5VzF4E/LlgoDlOAE9wMdct3qxWYaqVQaxZHvf/ku80PLt31UZJEujNPJJForZRGwyw7VSf7KdqxWEp6xoF82tIDCbKD7KuXLIlfd7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XNe/ldvRxkAOeWzeT7LtFtWi01Tu//m9efW2csWohk=;
 b=fu++xn0UHdTop/h5O530aHHV2b3YZ3BZdmfC6SbIUAm9YV6h8uFnQ12PxqujV9ZuPa6UnHV+IdWPeKntKKlve2ILK+xWq/FUNdL7GDu6/G+YlDPezw4vk4Aqc/wABnxWLtwJ8fFuw5oFAoTUuMLNo7Fgly5VfjGKUzCfGLl8MZ4=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 06:36:19 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 06:36:19 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V4 5/8] i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
Date:   Mon,  9 Aug 2021 14:36:42 +0800
Message-Id: <20210809063645.2289988-6-xiaoning.wang@nxp.com>
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
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0103.apcprd02.prod.outlook.com (2603:1096:4:92::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:36:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f6bd977-0951-4338-dbcc-08d95affff2b
X-MS-TrafficTypeDiagnostic: AS8PR04MB7653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7653D6EC6B2CADB1EDBBBE72F3F69@AS8PR04MB7653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +V5c5nNVxkQOKu+QbWOuaSzk7SRVOwIi34ggJE56mrPc4M0fKmo2q9IB8Zo0ZcR/49LcSzc7q7JPBo1vDerNWyoUdI8u4e1oAbf6DhuT5a1LbH9OHEA0JbN+kwyHSVu25Xd/O4ovTNuOV5prFXSIW9y3n60ZKVyxc49p0XGITrcqA1y7DjoMrIO125BHv73TNwW2bwp7y20d3y9MhXZyiPFystCmwzVWMdBGiw9UcSl9ADNVNLGOkPEhrKMwU/sMlVqSqB/mutCzfvfKPz5gSxf+/T1pSdxybkDlNomkJFp0dPxi+ZTWOmRk7GouCiEH5xpuYm8dfaps8m5+d65aw8Nfp/OFbmJpwT5wWCp6+faRYTNSqFasHqzeLfxFyVSREply9I5MdqW/WySowA6w+PoO6AmvPlr1PK1y1mSfAP6wgmAo7iImK1zIfl/Px2kVp05joROLy4qgxQ927gMrWrkg4xcz3nxsFf0VRaqDGtuVCSbzXsawIS59xfSb4h94cSju8VWGg2ghNnpDli426Rg9b0qpkRPXOzuo8H7JxJMJd6cS/xFXt36Sohv/L8Ct2O2IGa7REJXp09/q/SwnW9jEB4MtZN9sO2e/OhPCqt2DSGwmMFe9Y02XZmhurzKocWTTHgnBIulf2fpFQPEjJd81puWsmLQbe+wniJL62kb8yQN756Dz6+f5tqiyDtWV+nlAFnAOInMWVTGyUwTA/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(38100700002)(38350700002)(478600001)(86362001)(36756003)(316002)(186003)(2906002)(8676002)(83380400001)(2616005)(956004)(6506007)(4326008)(26005)(52116002)(8936002)(6512007)(1076003)(5660300002)(6486002)(66476007)(66556008)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GGuaQbqbcAbBWnhrokRpSr8+mfqI62cqmZo1PQcO6cgluhw/r+iGt/22+K9S?=
 =?us-ascii?Q?HPR25rnKy4SWqRp98KyX6NyMZIshxlEVby16qsmPoqcWfq5ZBQnkk0QISC4/?=
 =?us-ascii?Q?PkOOM42IiklzaXONkjXmruh7/F4NPrdviPt0zGiEzNFn2h+yZtDSlTHtBScA?=
 =?us-ascii?Q?A5LY/QEYcbLm8FJrbL7Ow0QOhN5ICKDDvRsiD3Qh5nsaQFbhQwRU/XcxzEV3?=
 =?us-ascii?Q?OTtVsFGgGCJ3gwwDAxfTIUGoQO9VBGG9pvz48S7DmPpnBbpfLhRwyuvcxd94?=
 =?us-ascii?Q?TszcX2X5VYg/ynAXHpqabR6uHo5o2iKVXoIRZ6th/+H1VzNjBnbpYlSSdM5B?=
 =?us-ascii?Q?v5DI1nsjllo66Yh5zWy72+JHFlO0nAF2RyL66tC2sflEnr+kCgt40zaDOKIz?=
 =?us-ascii?Q?MTfNGi30PxlSEVq5yRnW8kG5dFjmVbKDi1VGta6E+G7BTSJE51OG9Ap+OE2v?=
 =?us-ascii?Q?BLMblyZa7lfv1vgf3b2KdqnXzV9kslx0ooppZOny2dbo/DCZkLAKMqGmsbxB?=
 =?us-ascii?Q?Oy5i+TjclUC0grWSjunsAYhTyFX/ZG7IJxWAJj81V6O7pWNkq7t3JiHLujmy?=
 =?us-ascii?Q?JAlAl0v9h2xu8GLcgC00fiHdavF8g4FEU1ml82EeJcZDFxJpb+ARYrz5KfDI?=
 =?us-ascii?Q?KKsRAbythGnWWaFvH5WgvLq+QD9R8zjTpQTCIHefmNUj0ND2Fep6tpl7JD9R?=
 =?us-ascii?Q?naHDP77sOuIheP4Lmhn7AMo30TpS7Bu/UCgJwEXqy0y/8ly1uJGOM7Qmfg/N?=
 =?us-ascii?Q?j2Gc9FJK0EPZAuDaIFYy1KtEaXG+HITkSWd2yDDkUV1sQOZGpXVIJBZ1VBhA?=
 =?us-ascii?Q?umolgntQerK9M1BWLV64USZufI7H8slOTvoRCm4jHh8Z3UkLa3iDrXwzLfco?=
 =?us-ascii?Q?1aVTRR19eMGub8ZO6KnDeOBIILJOAoZ9f45cIAjtfymWqtec4Ec/fiQAetzO?=
 =?us-ascii?Q?Ce2tfd+zDJe5C60rf6NgYW4TWMUIf8G0zdBgXpjGRy4ih8l4sJs8xGQ5ANv+?=
 =?us-ascii?Q?hG01cOaiGnGdXfjilKUOqCMAayfxaJ+6lAVn18IRepaefykONwI3qEt79j3w?=
 =?us-ascii?Q?vcM13ICvuU4vTCQYNst9BMZXkBWqPat1hzLBUo9/uTYCKCf6L2C2UXcCYQZx?=
 =?us-ascii?Q?6ZKEPCH4oTq6hwgaDsNtiu6buSNyreNfnRcCNdIMshMRafFY69MPkg7zrTQ1?=
 =?us-ascii?Q?Bs6cYbhGKUNKx8ty2ygD3PgdtvjLoSmMtGOCikxP4aA4or6b/6dg1/ceSkxZ?=
 =?us-ascii?Q?BQh9+dc03mLLNmc4/ps4iYh5jFLYfJvhuSLECTNxHyJXwklY98JRWWOKpogD?=
 =?us-ascii?Q?VXez4KolVBnGarWxkLLyrcsF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6bd977-0951-4338-dbcc-08d95affff2b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:36:19.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJad/SbTMY4gNIrBPFjQ13FSUQLWVuAxXxiRMTshnmfxK0nudt+pTX76UXQYSTVgyrWPP7bv4YNXwPb4NcseTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using I2C/I3C mixed mode, need to set ODSTOP. Otherwise, the I2C
devices cannot see the stop signal. It may cause message sending errors.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V2/V3/V4: No change.
---
 drivers/i3c/master/svc-i3c-master.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e767f307db2d..2a96b217cc78 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -477,7 +477,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_device_info info = {};
 	unsigned long fclk_rate, fclk_period_ns;
 	unsigned int high_period_ns, od_low_period_ns;
-	u32 ppbaud, pplow, odhpp, odbaud, i2cbaud, reg;
+	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
 	int ret;
 
 	/* Timings derivation */
@@ -507,6 +507,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	switch (bus->mode) {
 	case I3C_BUS_MODE_PURE:
 		i2cbaud = 0;
+		odstop = 0;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
@@ -515,6 +516,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		 * between the high and low period does not really matter.
 		 */
 		i2cbaud = DIV_ROUND_UP(1000, od_low_period_ns) - 2;
+		odstop = 1;
 		break;
 	case I3C_BUS_MODE_MIXED_SLOW:
 		/*
@@ -522,6 +524,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		 * constraints as the FM+ mode.
 		 */
 		i2cbaud = DIV_ROUND_UP(2500, od_low_period_ns) - 2;
+		odstop = 1;
 		break;
 	default:
 		return -EINVAL;
@@ -530,7 +533,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	reg = SVC_I3C_MCONFIG_MASTER_EN |
 	      SVC_I3C_MCONFIG_DISTO(0) |
 	      SVC_I3C_MCONFIG_HKEEP(0) |
-	      SVC_I3C_MCONFIG_ODSTOP(0) |
+	      SVC_I3C_MCONFIG_ODSTOP(odstop) |
 	      SVC_I3C_MCONFIG_PPBAUD(ppbaud) |
 	      SVC_I3C_MCONFIG_PPLOW(pplow) |
 	      SVC_I3C_MCONFIG_ODBAUD(odbaud) |
-- 
2.25.1

