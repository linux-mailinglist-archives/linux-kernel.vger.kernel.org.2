Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1FA36E569
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbhD2HC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:02:27 -0400
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:22887
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237128AbhD2HCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:02:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTt+S9AtCMEGKGBtKr6uQ56i22aQMw6+73SSK0DA95IEE12+M0Feg3Ray2NvzNiLa42nwQnFkTYEuyTjxIU7mOetYCuRkmtOg3aYraLliYsjr8VPYxbRRjH9tg75cBPj8KvnqTBaje1009Fdamo8ix9dYeVX4q4tbMtRY+wzwRAYrjQBMgdeU5oj7m91SZ+x9EwHNl2hj/cZZQ9WuwUtaQJ+rqGWyoTuP9PPnKLMXdUuYdrZr4kEUAYDLRoQ7k3AhHyqU3wRouXk/uGTxXqeaQC9/hXCPdxNVvXQ6P+Szq2ssuq5nK8tWMcQwIpFDblEBg/Sr+K5eTo7QdCJPXv7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+F9ydPzZQL7+HYXXydKkW6iHvplYGD6tVCXh+5X5vM=;
 b=mqz9v3nkVVZwylIt9nwfEQP/baH1epKowLcFFVNtxHLHall4TxHXFKx7NlHIOqqvk+j/yPEdHvws9Pbm7Sa96JfkiyfLWeS8nESlY+FQaNORLqFGZyOho5MPCr5XJJPRmQS+KO6fXiILDFWXd7GsO5KbHCAI5CZBBeA0ODCQRExJ46glrm3s0Nyci0tUjM1HClpw06Tl6lU18MRLedfIIpeJtSXq0MmuSv6FskbnmInn4dDr/e6qA7wkuclmexU/msG0vOdWkVgq6mgPmQDs914O1nMYnCna9lACINfjYQjE2yQmurgxmlFFiB3x2+XGchPAOR/iha+8BKd6oHMzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+F9ydPzZQL7+HYXXydKkW6iHvplYGD6tVCXh+5X5vM=;
 b=l0KkSon1O8yUFgRzn8M9+qUzDcLVFHqCVdFT1ORQqit12tKTT5q0KcoaQPU3s0MqQQtGNiiEqY91QSOacEWyTt22DtAahUIIi9XU2VV5d63nIpU4P9yXXhYsDUFUs7BZfH22JMQQwyGsyEzTjf6t6LpEFp9Qa1IEyd/pwkwIJMA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 07:01:33 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:01:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
Date:   Thu, 29 Apr 2021 15:33:28 +0800
Message-Id: <20210429073331.21204-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073331.21204-1-peng.fan@oss.nxp.com>
References: <20210429073331.21204-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend Transport; Thu, 29 Apr 2021 07:01:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae0a02e-669e-4a57-4106-08d90adc9f72
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7930AA38FB91556F15B4B24CC95F9@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJtkQ5iJYvfn5GS9iBPn1Vmj1PUqqfcmgcYGEwB+jYFwN0Jwj+dJKMadB/+baYzCK3bfSuXkevPogY8/a4rdQSV1PmUZWxtCZBpNPV+XbB7GvB/0tklzcn6N0qJQXNFlCetE3IiUEDTEUl3mlV+oEDs+a0K0OypwAAAi1mDTaK2XhtsUyPzNWGJmv5fcmt5om2b0x2b1VNc1KBnyzb+8GDWUm8xpPBIb3k+O0LJmWkw41Kn0wRnjGld885HBJc+ptwgF6IuZ5Sm9gbrFHhCw7D4kBc14Q1/HRFvRhZrFlvmSQ61XvMuMK045OYW1H/FlhDH3WtwcVnay4A6D62iycTHPPkw6FekijxOrJyoHygyEEcewO7LJsBex4Kd7A8Q1Y4CYQOAU+2CJaMiI01Tli0iP3dYSvPTG5ilCSCdSi7klp2DyD0UEYddiW1TH3Y1k03J+HJAM6tcnagqn16ZuMeRGf1EcFRawalFWj2bYQHvRGZXdZaWwDH7lT21CawrqL5Ycz4db3N2kx/S3+k4s48yzYJMWxJgzG2h86WAPyRvMT1zlGs+dWIR3iWeTB1u5jceiHehIMZdmLCLZMMmN3E5bE/Zu3UQybSM9v7GcGOPiWvzJ9U3xEehsYJ4fVU8SAvuw9n7xGRhnjJq1GPYZDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(2906002)(7416002)(26005)(52116002)(5660300002)(8676002)(66556008)(478600001)(66476007)(16526019)(186003)(316002)(6486002)(38350700002)(6506007)(2616005)(38100700002)(1076003)(86362001)(4326008)(4744005)(956004)(66946007)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s3obxb+pt79m35ZlMCMKVtD0TqJXbF3lGM8DFu1kpoky5V7KbUxF1fKCrShj?=
 =?us-ascii?Q?faN9MBFYkExnDX294cCC4abmY4G2X2ldvT6s7rO9dVKz4P/WI6CuPaZmMgtD?=
 =?us-ascii?Q?nLx8LGhkwqteeOaVPyl38QAqQTx5YYEB8gb+dNUpLhJoDnUx4lrekWhtq/AS?=
 =?us-ascii?Q?wqQoO88vLJEddOu8oF3HGrFAa59WmG6xrguPuEvWSw7WD5qbC4/bNrwH6fK1?=
 =?us-ascii?Q?n1zyXMNMOPd0SAHXPuNH1BauK+doGYY5zX5mlrj9VTCoYlTPmAkGvPailrSj?=
 =?us-ascii?Q?t/yHGN6xYNFdMsN8GoPmvxSkCHrwdRjDqTmtnH4nFSk5FrGPgxlnhMYOZ86u?=
 =?us-ascii?Q?omObMW9LF+1+US+6sfU31uDWFJ+hKZkYQW2OSVJrFt1HU612/CZzyX8G2yMM?=
 =?us-ascii?Q?Cv9sk4XFE0bsYpjWCuavKCWxLhJyzGmzn9P8LKba/RY+XO//uAMMamZc/Cib?=
 =?us-ascii?Q?M2wlAg0p4vR0t93uxzs7RTtwhEsnQUDDxvnep8LW7NuzI5fPcpVLSBmKR9Y6?=
 =?us-ascii?Q?s8yqEEHGw9uHuYfs/lFm9P8RWRtrltcHnMUrRC6nxlqgTCWvidTRxwjPu6Ud?=
 =?us-ascii?Q?SGreSsOHeXOf/ZnlYX1JoIIm7zE8AVdsDT1O043UD2pVLfVLbsMho+KWq1yW?=
 =?us-ascii?Q?qbBSzHlumkzpDvec1UCfejFozPopdDVYBmARKMJy96bHB7eXyAr1y1Lt4Nlx?=
 =?us-ascii?Q?AMlepzMfJhtLoQXG0j+p08vHC7EZ/+8PM5Q9ZjFdHvJTt7vBm5fdnAVPEMFM?=
 =?us-ascii?Q?hTlY2Jcj1EATqC9lJ6M07vDhG7EYHiQj9Xp7hjaIXHW7aBsYk7rS5LWb+9I1?=
 =?us-ascii?Q?hMny+8ZW+UGGHGx+oG0+d4D43/NJXgDiza01p49am/AeG6BQFEuLURhklZjh?=
 =?us-ascii?Q?ddm473SFvyUILeN768DGZd2aMU9CxT8lZYqnuuGab5Kl89FXszKBLuGZ7dYu?=
 =?us-ascii?Q?hgeMnxt9/E7ybKiGuob0iJuLGTDwhS07e4io/PrOtI4LMaHnH3vhGS41uurZ?=
 =?us-ascii?Q?4EDpUPKljwAMm5xF3Y1Wur0+ZJ8NB4YhU7RllzHNmdUkfnaOZB0vIGtION8W?=
 =?us-ascii?Q?+xvgK55SMUXPVIM81DVTKgkzCnjuInldF/zd49GLGcuj1bKjzPOIF8IqGo8Q?=
 =?us-ascii?Q?q4SaLInu43pi9ZsioWB4g80UoRy027DYNIS4nUFVr98ezrln9z9+RxPry3Ho?=
 =?us-ascii?Q?lTy+1nzc0CxqA5nLse5qYis2xmhKFK5g3ANbXihpXDKg2IU2NR92JYXwMqYy?=
 =?us-ascii?Q?WihOhMUZZWCGJzXfLX8C937dbkUt2XFrl0fCwQ1R6Hf9g0DtV0bfgRpyuGrh?=
 =?us-ascii?Q?GdO/vIXN63dfSLJusIp3QpIY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae0a02e-669e-4a57-4106-08d90adc9f72
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:01:33.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IL5hMkzLvZwuep3GeInkJA28ZB3tEzZDwnQVu9Uozp5sYudtoAno3D/WID/YjgYq+njqYJ2XLtuozJJYpyJjVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
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

