Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA66530591E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhA0LD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:03:29 -0500
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:8257
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236357AbhA0LAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:00:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNjQ7iJ+FUrGM4KpeEKLsPr8Ap6K9M9t927n/hocC2HxGyfdH7lKQXCvPGVSr+Dto1mQEIQmDU6ygRkmmGwjUNiYSiReli1YRzCO8dwhZAExJAYMrVwBL0t1TbTHxT/oy0rAmtsKqPwtjufMezc8flc7dB/5Py3eWwl3uwe6PX3FlNd4JdzlATBifcTkPbN5DT4IR60ws+y724RVz7qwpFRPxwOjk0ZKRyW/2KKvUnhEtHjSTvhcDstusT/6U7NIR1jJZ1IXdrxn2ze0xbDTaL0NfHpH591bCiacHkShGFFh4UN4RpoPKI8vic0UCqH0OjtGau+BdiL0ccrDg5+Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3F7j9sr75mtrlnzrgG/sVqRSxCLXmOLum8l1RirD3A=;
 b=O12LWk0bQW5VP/C4ngb5JgY0AjRLN0EMFQ7Vh+HgvM0NWIvhSKmKnrPLUO5r3auoDLH8PPwZAu9AXlWODfwU7b3bJW+4+320KaGdUYNEMB5Uimgm7cspJOqKWVto2+rqLKQfjHznN6dgfQS1shyKPY6lPcAJDzLVUz76CCy8liRsbE1sJEG3PQ16Lb7A1VnI1KI2uT9ZfOPdO5SxYtEuI8kCfKoMHkhyXpZ1Ns4g69ePtqkEBlSVdZMrDG47U1bhPX6pWh4IzsjTVcrGYlqVUtMpohDT8aFX4+k+Mx9onlmDW/VMh0vKDf81U+J7S8xJHM3QFJwQaUpwi4N7gKK8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3F7j9sr75mtrlnzrgG/sVqRSxCLXmOLum8l1RirD3A=;
 b=IHR24K/Z11NpPvblGQxs+hxHXnPAesmgcHcVE8zVYm7zsFufg4NVN/2QyN4rdRy7iHN8lCquiFRM2bydaR04Feyc0eh6X6JIIC4CH69BhF1QevJsUMGqEZAQipelqWzPoSdnDsGCK3u5LUiNhOMcBY+Tt46nRev0yJyWSRNp7w0=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4108.eurprd04.prod.outlook.com (2603:10a6:5:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 10:58:40 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%3]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 10:58:40 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kjain@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] perf vendor events: Add JSON metrics for imx8mn DDR Perf
Date:   Wed, 27 Jan 2021 18:57:32 +0800
Message-Id: <20210127105734.12198-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 10:58:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff490f8c-dbdd-474e-1a67-08d8c2b2816e
X-MS-TrafficTypeDiagnostic: DB7PR04MB4108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4108837145FFA0EF2696185DE6BB0@DB7PR04MB4108.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HvAq9abK9i4jS9eFlRMaPfq0pjj7CD9Dd2GS7Q5Mxtg1/rH4HJ9HcQnIhlZIC6c6ArEzMC0e5IHqs/1B2o1CfRYL7gjy3CMhlYgFWpATRQ2mqbo0GuUZv9hkdOkjxJ1EK0XGsX9X1T2z6OsVPQLq0RswAOI27dPjufXUEO/jmmheNgfVTxdWYmBRSKnUkWlBLLwyukFZBmnRbZssmwtDNSJj8/OVd6MuQsESQ6JLC4dzZvHGST5+mWL6tpAhzvP5+6/cfL4wF8Ui9Izx5zmnOkpfCV5ur+TkGpoKRwuAC6DZyUzLz8FofxCb417KsvkYT81le3OkjXloDhPSOQoVwyxmgOrvy1M69sXJ9LwmJozyw0UWhk2zAIxvRxKpR36hO7bANZydA7XKy5wNRlRxbQtqI8rUqvFx8GLQH7aGEmGrjWPVDvwdH0JLHzdhhmbxj1u6hpBuCVUNOhzCeT2q/AfqSTqjOtu88U0vPgpi+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(52116002)(66476007)(921005)(26005)(66946007)(66556008)(6666004)(4326008)(8936002)(8676002)(1076003)(478600001)(956004)(36756003)(2616005)(16526019)(69590400011)(6506007)(86362001)(6512007)(2906002)(316002)(6486002)(7416002)(186003)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jyni2iCt9DEf4NxG0NIMgbBnnWEVhMN8UFvXXaHD27e+Zm4LWdUp8QrfWzjT?=
 =?us-ascii?Q?TW05FNOqxRJGIThe7FogxUryYozWkZtSMu8F/PC9//ODapiUOqpObcdz3MfO?=
 =?us-ascii?Q?oVlhBLTljGVpmWsZIHQMmg6fUMDzMe0txk0ngA0wUift1606uBZv9UzqE6zs?=
 =?us-ascii?Q?U4Q7+HbC1imPkO6lv6UTfDSaYsKR31xqXnq7OiIe/4T/XgwE96xFuNjknaiv?=
 =?us-ascii?Q?mORQAehsj+p1JWlQM1AK7ZRn4QpKaoSpGrhwbNCRw8RQmJwF4d1LPT0FfKHi?=
 =?us-ascii?Q?dFMRC4E1zA1d8XIrXItgKUl25jpwRLx2r4chS15vseAt8SlS+svevWiPD1ZC?=
 =?us-ascii?Q?cPLiLz4lm/u0D0fZUGqRMCacfdQl4hESbY4yWfRnthf9J8gikG1swLLntZUI?=
 =?us-ascii?Q?lhldFKmC9vUp9wH7m2di5Iz1ibz2OAAMG0q+nXt4Xo5reWrSSAZc1eYjEmWC?=
 =?us-ascii?Q?GTRFEYLoy6FmdZcXadY9G++X+HbPItfrSyUBdJss18V4Z4a76V7h7rSZZPRc?=
 =?us-ascii?Q?XJUdIIUsz1gLVyVyzhBgiCVS0fW7sbeevoLJ/DL8jhv9wZ3y1OG9mY7g84j2?=
 =?us-ascii?Q?9/9PtbvY/JZzbGqaGRTB+pG0KQsuGJ2zItSRz9EDut8BXWksZ0rAt8MacZh7?=
 =?us-ascii?Q?MF4SkPhwoaZiCN012sD7khJmTNcSRr5kMclyt1aSExqS9oNF9iI264XwVXOx?=
 =?us-ascii?Q?3vaWAeezq0lNKMTczeeMVLNQfooTpCZqdir4tCz2m/KnZdBh6s/5LB+LrFBt?=
 =?us-ascii?Q?MXP6xGPg4NydelHwVB83+aMqtoDUD6RL4ylhuTihUm+xJFKTRjfUdcHIwRdQ?=
 =?us-ascii?Q?3z/+/hYZRKChJtGjM9tS7asJFgSp7QuaxJ5rcJ58Dj20+SfA2apRWbEdCCpE?=
 =?us-ascii?Q?LpNSQX6XLSjmOdoLhwJZ+0Y7yhb4K+z3HDbsZjSyusueQfeY1atflRw/5qlu?=
 =?us-ascii?Q?D4O3ChkCijjt0Lqw+7fcADu8Il0L55Rn5w7J0BYWMFceuPkRZt7r12g33leW?=
 =?us-ascii?Q?3GPVH5w6aXZJIhzzPf0kCUHpueR6wi9TViHaDkVLuVOqS47le16SEhdD3rno?=
 =?us-ascii?Q?pRe4VQQM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff490f8c-dbdd-474e-1a67-08d8c2b2816e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 10:58:40.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIABc5K/5QAqlTeWXYuHlg0BzYmpvO//sAusW5FkQFCvhQWqO7zeBWWtOzyrkfTLm/Ho2CKK3Jjr4g18xq2S6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for imx8mn DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arch/arm64/freescale/imx8mn/sys/ddrc.json | 37 +++++++++++++++++++
 .../arm64/freescale/imx8mn/sys/metrics.json   | 18 +++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
new file mode 100644
index 000000000000..8352e73d6d35
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
@@ -0,0 +1,37 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx8mn_ddr.cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   },
+   {
+           "BriefDescription": "ddr read-cycles event",
+           "EventCode": "0x2a",
+           "EventName": "imx8mn_ddr.read_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   },
+   {
+           "BriefDescription": "ddr write-cycles event",
+           "EventCode": "0x2b",
+           "EventName": "imx8mn_ddr.write_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   },
+   {
+           "BriefDescription": "ddr read event",
+           "EventCode": "0x35",
+           "EventName": "imx8mn_ddr.read",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   },
+   {
+           "BriefDescription": "ddr write event",
+           "EventCode": "0x38",
+           "EventName": "imx8mn_ddr.write",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
new file mode 100644
index 000000000000..2bbba4d8ea5b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
@@ -0,0 +1,18 @@
+[
+   {
+	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
+	    "MetricName": "imx8mn_ddr_read.all",
+	    "MetricExpr": "imx8mn_ddr.read_cycles * 4 * 2",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MN"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
+	    "MetricName": "imx8mn_ddr_write.all",
+	    "MetricExpr": "imx8mn_ddr.write_cycles * 4 * 2",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MN"
+   }
+]
-- 
2.17.1

