Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFBD43F515
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 04:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhJ2CwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 22:52:20 -0400
Received: from mail-eopbgr1310139.outbound.protection.outlook.com ([40.107.131.139]:31045
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231523AbhJ2CwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 22:52:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS5YJVHptpOwTfLoY1HOk41DsOWipbmI4Q6jH6w9DdyUcNLtPDEe673jN9vVkVrz5NXREvfhHuLXAFDlsoJHna30RFJ8Tbst8d+o3nG+eNMkQ0SimV++cDsGGgv/pT9TU1E4yGYiiYGFEYgX9+LEq8FbeV6UC9h39gaTdWgyUsOTrZ15vnf4dDQGZrq6azSj0qlRb3WMkO4XUD3tKgXv1z8zYt+bgw73II9cuPtmU0hPtTLLrNEoWpul0aFaICfCs9Igh0Wvx2TNSUIyiwfdyS1IEpaM1zQXlM0gvwlzSYteasFYUChdSfivYBH/Vy9UUDW+MB1vD/pM6D/G21eSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xekzi5Sqf3FJEaQEEsjraegXZkbC58QKU9VV2cBG1jo=;
 b=CGXZ7jfH8NyNC8mybFL+skjbyrHuIMjHv0m0WkBsoEBca5M4L83Zd+c/Xk/HIXWuIhWFuDesoVIB/BK5wJS04MptOCDkj3jGRN15fwUhzxOSpW2eZxbz17mAFh+FyFbx5P6we+LG6BjKRn4oAFwyIceV9GSEO4pXVhL9uxVF/Lb6ufxlCzZhl/xtZXTs8X1KpVBBL6pDYq2SbXKfcWBV8FSTWlt6xQj96pXUYZE/TTR+9JcjX4EHjEhlhMIeXiRsaDX6EZ4hbGY9ojbbTYGZ5Gj00kyi0vkfwbOmvJGh7UtsBFS6wHQTnbYcShUawBUgoRyCHEXOs/tqgs7MtQy9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xekzi5Sqf3FJEaQEEsjraegXZkbC58QKU9VV2cBG1jo=;
 b=JasDfWqNWI/w5ZvlXPCFPNzRQj3kyN3+X+YN+haaGGHxU8wqTPZQmcyp9O36TVfqGuU0hNadOmYQzl1dROfY57Pg4KtvqCAvPPGzAxlOyTxPQ9TcUV4STsVgU5cdVlimM+BDlu7a6pA1DjUG3fTPM+CiN99l78XVySRPVKFyG80=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3580.apcprd06.prod.outlook.com (2603:1096:4:9f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Fri, 29 Oct 2021 02:49:48 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 02:49:47 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] hwmon: (nct7802) Add of_node_put() before return
Date:   Thu, 28 Oct 2021 22:49:18 -0400
Message-Id: <20211029024918.5161-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK0PR01CA0060.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 02:49:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 109e3644-d00c-442f-5173-08d99a86c4e8
X-MS-TrafficTypeDiagnostic: SG2PR06MB3580:
X-Microsoft-Antispam-PRVS: <SG2PR06MB358091F04447E1BA98003366AB879@SG2PR06MB3580.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5NDcsMgt0x6JU8YOmmOO6bpwwr8TJIj3HVfbYf1//0TfGs/jRwIWiILKb3P/dcbrjaOU1aI09jCHHbhnE+LsDdMZFDBBwT+7M/+eoG6hQNRbm+JeZ7t0CnxrkdQcfppHn7rto192Rlfnc/Fp+jdGI8i/ZujzspMcNjiNLaIawKSr9dWpOwNCO6drkABwA65ZGFNeiFzs4pnHwhI/1f+eXW2SMTu5t6tPaetihh48osDbw7QMB5yl162SMrexcQqNwZUw8IXQIaIA/7U0OD85n2Cz4YBtljgdFIId0JNSHjH7I0LErqyDqXOTQrx4cj2CvdPjJZtbW6b94WHMfeJkRRHn62VaiUHaeNitbcnbHVZe42U7XbAxLozimoCO+oFPf+Gv2RuHuMl+mgp1sp/1fuj1l7uF85oNt/Iek3u8LU83D1LajGDFSoBb8q3qbczEFDS8ZA+JmdvefwmKfbFf+ld/oBohZVoPveNU/lVZ4fUtod3mVHU9omTISYMhdrHkOt/uVtSG1HitM6+MzZGNnnU8SvhLuFx7B3bA5DEJ3U+0aOLtLj2PDmv4qoKqQhQ07k9ccBGunSREDvY3k2AWesCgQDb3dXBc/ZEknSsGlehBVUJmifjraFdqiTKisDLBGyawtGWwx5I9Po0uwywPQWQs1GSznuM04+qEU3K2DGF6c6ez6PzpA4aT01l8bVrB71fTGqdrlqOdb57fYpGQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(508600001)(38100700002)(110136005)(6512007)(2906002)(8676002)(52116002)(4326008)(5660300002)(107886003)(6666004)(316002)(6506007)(956004)(2616005)(6486002)(36756003)(83380400001)(4744005)(26005)(1076003)(66476007)(8936002)(186003)(66946007)(86362001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5HMDGIGHkPFm5g2coFjOGsLNwqfcR/bRrEio90qo2nZ98x1qrPEh3OUdvSh6?=
 =?us-ascii?Q?ruS7QxuMbyQm7FrIVqgMxCGC8Vb6cMIvX45cFtEG7diI8QYMYWcwh5ojsKEh?=
 =?us-ascii?Q?c3p5Yt4GdCOPrPvHmAPSLYzfnb6RIfjN80cG0AOmE08dDhdink6JRSMXROTQ?=
 =?us-ascii?Q?ZOmsvBLTeP5CcDFF4JgGxtXjgmk1dherPQuDbTUySrXFlluwh7mNvMUz1rVI?=
 =?us-ascii?Q?txUpeIyAbp5/f3sMY3Qvijnj5Ufsh+klQl8RzTaxHzKuTaHr7gsuT6cpFvwB?=
 =?us-ascii?Q?HyIxhWaNobBn/pvP3JvW+mMkFKCpDg2aSAq8CqveY7Mxd7mlqkTyxTzyXu3S?=
 =?us-ascii?Q?pZoDDHCUgdbGSguZX0EdsAvH8o4WOJKFl6yYcDIz1IFKRVeJEyKJ8vntEkzZ?=
 =?us-ascii?Q?COEt14qGQ02C7j3ShQo7HSFXWFWnrM5qs1thKP6/mE/WPMdiRaW92vOQefMY?=
 =?us-ascii?Q?PrYEvhSq3VPQ83J+1hjZ/QpHcL+lZ3WienSE4MwLsKo0Prk+TpfnZ05CxFl0?=
 =?us-ascii?Q?any3wOoZehDKVebuP+3VS4ianRfHv+z92azwzn2v0lFhw+hB0zELTsTWtiNJ?=
 =?us-ascii?Q?No/gzZNdKZdnidgNCKpqYWh3WgGkqVzrsC9/cpwNM2Q47pio+U9Nz5yrMiiE?=
 =?us-ascii?Q?oR59o9n9IsJe3NkoONteRGmU/2WWkF+9H9nvCtYLHt3+5xOi54Nvb/HoCwz4?=
 =?us-ascii?Q?El+S1aLm/bfpQpCFBAKCNo5PC1WLoG/eW0sCggx93QNC3xkoW+L4C8c38cUY?=
 =?us-ascii?Q?04J+tY4/TyvHJSjMuhovYbLUn19fneyjkQ2Rleox0kKGfEdLGmmuFVDqEj/P?=
 =?us-ascii?Q?HVayZMe4CSDPdCDg0D85cIi8sto5vImyMy98kBJY3jIqBiaiqpLot3P2QwJW?=
 =?us-ascii?Q?a5/QWuQ+NmwJxI4EYs3LAade/jddSkwFIwDFAzxHrFZ2UVZ3ktJoumUg9DDA?=
 =?us-ascii?Q?7wWDXu9um45YRMiLIC3qb1NImuJqdLeGjz+dFoMJjR6S7ZLuNR4PgGeKokhF?=
 =?us-ascii?Q?vLpiKsfR9BhxhoxVTOQtksItrxTg5pQwcjGpwCYJdlHG/Cfhdzx2ig9JIb0j?=
 =?us-ascii?Q?jGuJmHMI4DDxrVIjpttUfB/nNzIVTyFvoyz/hP7pCkH45bnh3BODs1Twjenl?=
 =?us-ascii?Q?oDyZz5xA/x91XPZzpxAMax+bItMnImsafrJNCDoi4WKcDbl74v7QV1eRAl51?=
 =?us-ascii?Q?KdhaoxO/Ev0arivR6cvsZggp7rlPlmtXsX7mcKF2DegyeTStHV3k83+5ivS/?=
 =?us-ascii?Q?BDR4kg5Uucwxa0VDAa2SIs3XheONUEIQ2rvjdCiH83MP6/FUI4IkqZDdlE6i?=
 =?us-ascii?Q?YCZeQyoNFirPkxiTNUtIaWNhVSNSANLhKE9jK8Ycz+LxQsnx107DZRhFwRqs?=
 =?us-ascii?Q?csNaPuOukmu9ubd/pz64cQnzQULuENvbxgdG5yAGiiPvsmNPTKEf6GL257PU?=
 =?us-ascii?Q?M2p8O76N3DSs4byX6haLuD9u7RZmcLzBpoqVgqrQCn/JFaPx6r5Sw4O7DHrw?=
 =?us-ascii?Q?mVLiNjhq1Nhwu10iG9IPaQ4KLrDc4zlDjaERmhIb/UhyBVExigtWp4aKDrW7?=
 =?us-ascii?Q?C0yHv80UDtM2GtyxpIEc8sGSzUPl1l3TUcDIWeVik7HH7Kz34sdWfVJ6jxgB?=
 =?us-ascii?Q?lpIdHldR7Ktak977T56oIGk=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109e3644-d00c-442f-5173-08d99a86c4e8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 02:49:47.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYJcHBEq5iw9RrFX19WHfpZaxjd/geshyoYQHQexQjp4pB40OYmIJqSQeNFXsR0z9iwHR0o4YAfPPOBN4WY7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3580
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/hwmon/nct7802.c:1152:2-24: WARNING: Function
for_each_child_of_node should have of_node_put() before return.

Early exits from for_each_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/hwmon/nct7802.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index d56f78327619..d1eeef02b6dc 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -1152,8 +1152,10 @@ static int nct7802_configure_channels(struct device *dev,
 		for_each_child_of_node(dev->of_node, node) {
 			err = nct7802_get_channel_config(dev, node, &mode_mask,
 							 &mode_val);
-			if (err)
+			if (err) {
+				of_node_put(node);
 				return err;
+			}
 		}
 	}
 
-- 
2.20.1

