Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA16374E03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 05:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhEFDot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 23:44:49 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:29969
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231336AbhEFDor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 23:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqo7UUEVyVg3FTrL8h9/Lj9ucFEYUFt8LTQAZdlraBNBLSZI+TGaDBgsXsltYoM4y91dbgZHIOPKV8V/JMKhu8itl6mcs4US0KZXIteSlyb+sjks5kqflKpWKF3fab7zSLktVzsLt2NnC08vDloc8v2QJSQordALWOSQwDIhntDvwPRMs+XG3LwIMLlJDR8o/wCy8nxNMEBb6PoC0w76FcDHFtRWPMXO59Dth7TQjxo4iOOXjjAZ02Oq4QfY8h5rgt6jHsY6uqaaV4W/Eq63Lee6StmkRqh29zRi367MJTVJjKJANSlR0b0Yf8t5731w15hqXMs6q/flBhowMPTpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+F9ydPzZQL7+HYXXydKkW6iHvplYGD6tVCXh+5X5vM=;
 b=Rrcx2EdOkj3rh6+UyBqTgcZWIxchaUyYVe363PzrRX1rDWdY2+FTxfzFdFdLn6ykxt7/vP0mxBbmDriq0UxvPIDr10kQrWe/hqTY8o/Z8VHdztox5HRff0i7oGRredpvCBrMHpZ0STqloRwd8HKV+V/v9SXjGADgkrTXwWfnMPVEV0C7rUtOV2trzZRD0SWb4DHvYvFgpJ0XmKiBP3EUK0H8GQeuA1ryeiQMt/oYGsnnEmi7DrK6vA2JMARiMwkLfWr7eXRywy8uE2/+v/8Ax57ZM0RYAelBVJe/SPo8JAD00i62Gw4PMas9pnXEDbw0yhaMlGusGpg7GmNqUO0Qfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+F9ydPzZQL7+HYXXydKkW6iHvplYGD6tVCXh+5X5vM=;
 b=X/psBsOcvcH0JqcxxUQAEhQxDXYRUx+VvqfiEv0gzJLfczJhjWw8gKnNfJhezVzN5qkTJgNqP4H2DKd0e9UfoUdYN4Iz0o8hfXi/nq2ch/KTFc6CH9gOPkeVFyTu+LVsMY3k6nXEL7RPuSGzqZ7v8ezbSWTfUgZh0rJPWf+5XbU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (10.172.251.142) by
 DBBPR04MB7979.eurprd04.prod.outlook.com (20.182.191.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Thu, 6 May 2021 03:43:47 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 03:43:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/4] dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
Date:   Thu,  6 May 2021 12:15:52 +0800
Message-Id: <20210506041555.10719-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506041555.10719-1-peng.fan@oss.nxp.com>
References: <20210506041555.10719-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0115.apcprd06.prod.outlook.com
 (2603:1096:1:1d::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0115.apcprd06.prod.outlook.com (2603:1096:1:1d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 03:43:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87abb1ec-8ad2-41b0-5c42-08d910412759
X-MS-TrafficTypeDiagnostic: DBBPR04MB7979:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7979D20766136C35AD804917C9589@DBBPR04MB7979.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/+IIFLwtg7R6YDc4BPfMq+iVP902GcuZ2rmHc2IA5rkIjQUppaGUfzswd2P8GYWvtGOrHFMytrv0zuIeRT0kpli7Vmq56Jhn+DbxNAXTsemdizdyrGtELmlNgTZ/x9Dq5bJ/AsJJx1IC3BZnxIqmMvjNVmwXlX9O7nc2mMP3P75jYOtb3Ae6VOsa7PqEs/oJ8ZfvR+ea+T0mj1Bn9dQmBARogX1W0t5WP5FqIKU0QMsYk6R7I6waKcm8X6e4Wnss+S1a7ck8DamzbQb24QiHNaHjmF89LTXSoS1saJEFuImGZs4TyDomYD5ZEoAfDs2u9tVcyn9jzvNf3k8Nmm1nrEzsRixRwH2CgotX4dC7CbwzPqeE3vrQW4Z9x3aH2BLc+AmbRxNwWH5ZA/I2Xc0ZuIlCybFI8iDh0PnQtgdzNCop6M6BBsD+EONUuqKmxGwIbJ39Wfpuo5SzxmT+wcyPZemJ9/j0l6GSpbae2lIXdlPYQaoQuQwhYwGeQbw5zexRdgz5Kpp8PwrvyCF/kjvBfhAr6ZJ+zFyA4sVBarQVEl1LbMzv0oZeG/oUKa3RWeNZPPzQDIg9R6B7A4+zQucYEa311t6frooo4hj9cD74mXwDvDaJXU75kb4lxqO4lwPlJ4IcSz2mT1i3i01Corwhm1HuTqxVwuf/Y0PrFA41wE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39850400004)(4326008)(2906002)(316002)(8676002)(6512007)(956004)(2616005)(5660300002)(6506007)(6666004)(66946007)(8936002)(66476007)(66556008)(52116002)(7416002)(478600001)(26005)(186003)(4744005)(16526019)(1076003)(6486002)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W1qZZ3b84FKIr8o/NAqfX1udilz3bGc1jqSsXtig3M7+dST8n7BDJwTj9gOV?=
 =?us-ascii?Q?BVGYuoKU5USRnt5dfZeb3Em8uM5FYKAuIj2ys9+YEjf2bSPqUWLZ2Da3b6kh?=
 =?us-ascii?Q?sT1RFa70FScLWNjOn+9F3PzRxvEpPah1C/qqFK6Ex6PlhrqgMtjjoDK0fz33?=
 =?us-ascii?Q?0B3Fy8maguRNQZ+EOLoSErb1+Wc0IRHm1VbT4FnOdjUCIkOU2KWiMT3ZvsyY?=
 =?us-ascii?Q?BQp4WkGTvljrveAcmijPTMPv1Bh497og7bjVvtN2nPA72knN6asbFfANkbEG?=
 =?us-ascii?Q?+QPhjuhaP49HgT2mHtr5zkGiaO7uguh84EiUyqWE1UmPNbVPhrWaKf1CdT0s?=
 =?us-ascii?Q?eLq7Pui7Eyma+/eSZPghkFzuZ6MPS2juNTfoIw7POW2hHXl/HAmkR5aQyahO?=
 =?us-ascii?Q?145nBJQuWISbQxCLZS0SF4vtqnmfzV2bo56k2udt6+ZEahe3xFUDBrniVD1w?=
 =?us-ascii?Q?9eOvGkKXMQ0k81f1TLj4t4iVPz/DLUUIwvJHE/+0+X7SfOUOpHKt3zRds0Pj?=
 =?us-ascii?Q?0gSx3JMKR9LZc0kPYB+Bd2n5usBEy5fTyfXqtF/ePaQ+0Dnj+8X0ZHMZype4?=
 =?us-ascii?Q?KgVHyKWxxHbghxE1cUG9IzLyX4efZSHmTfhX40LvariT8Hw+vH6x5L6x7pXx?=
 =?us-ascii?Q?GMxOI42lBRtn4VMoKTwFgJ9ykz3K4NwMnDiQ9cb9tsjV4tcPVrAnFrNrK5cJ?=
 =?us-ascii?Q?d2ItRltHdpaZ67Gds2RQkbycbVSN2oGt2pWlHCmfBKh6tCXLCkxJ4QGmZiNd?=
 =?us-ascii?Q?Wqhn7A9JLCmARkzACVODyClAX/ranUlv5wJBfTJIv5HmIlXLOmhDFeneJYr8?=
 =?us-ascii?Q?fy1XrsQ0fYET67tZ084qaCvz4tKqX/K0hfdZ+aRzVJZ8gO0vGJvgTmgmg7Xf?=
 =?us-ascii?Q?FzcFo1FPlwEqiURQwoQlAPNo5qH0WTZNz/KdSG7UuwPpTivoEvvQo/RShoqj?=
 =?us-ascii?Q?mAcKYWoAJkq2vgc8SSZSBGrlLB4gOlyymnewVly6STLpTzQz5iJWz3AYojcP?=
 =?us-ascii?Q?nqG8ktAv2E4bDe981IX/noaDOHwuGZSoXmShC4++0mOazRlk7EJLDVBlbm1z?=
 =?us-ascii?Q?3IW8tCB9R5h7762HbQE9NEK2h2PLomnlHZAto/noSdeVeuzgGdmnc+NZyrJ0?=
 =?us-ascii?Q?7Ad48GnlN8KmbTE2d9XmJ0KmTwhMr1YA4EPUgQ5CXpVqz6kTMCy+Aty/xv+t?=
 =?us-ascii?Q?hE3iZQxqlzrTIqvWxil+K0lxgAy1hTPfC2ZrHRB6YXDG5jgmW4ackc3M/H9R?=
 =?us-ascii?Q?j2NK3pzYQHkuRHKqRzEyw75Wwxnu8qmK2etmUNHdqOIPI40sIr6AgBHzO5YA?=
 =?us-ascii?Q?03LvwC0hNym0bXNLEbWcwxTlVvD4d5MzmOqt3gKwzuy4sw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87abb1ec-8ad2-41b0-5c42-08d910412759
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 03:43:47.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeZR0YNlFCxHf3zmhlHRtlnjxqBPMYcJD+dA7e7yZV5Ma1SEHqfg5YMaV9p2WKRKvNXqEhni82wZgLERvRUw4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Adding the defines for i.MX8MM BLK-CTL power domains.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/power/imx8mm-power.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
index fc9c2e16aadc..510e383d1953 100644
--- a/include/dt-bindings/power/imx8mm-power.h
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -19,4 +19,15 @@
 #define IMX8MM_POWER_DOMAIN_DISPMIX	10
 #define IMX8MM_POWER_DOMAIN_MIPI	11
 
+#define IMX8MM_BLK_CTL_G2_PD		0
+#define IMX8MM_BLK_CTL_G1_PD		1
+#define IMX8MM_BLK_CTL_H1_PD		2
+#define IMX8MM_BLK_CTL_MAX_PD		3
+
+#define IMX8MM_BLK_CTL_DISPMIX_CSI_BRIDGE	0
+#define IMX8MM_BLK_CTL_DISPMIX_LCDIF		1
+#define IMX8MM_BLK_CTL_DISPMIX_MIPI_DSI		2
+#define IMX8MM_BLK_CTL_DISPMIX_MIPI_CSI		3
+#define IMX8MM_BLK_CTL_DISPMIX_MAX_PD		4
+
 #endif
-- 
2.30.0

