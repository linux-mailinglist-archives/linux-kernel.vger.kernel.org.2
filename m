Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2FF305922
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhA0LEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbhA0LAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:00:31 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52636C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:59:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrhpcFQLdlS6YbT9funIA6VZdEBZOjzR5q660iVLmHJlw19ydoqHZxDgewbdyDxTY43K0kkPpwPBNTGqf37Js5vawsxSXf2qBMDIYKTM8J4WMLOrck7wMiQbE5TcK3NWUgy2RIJns/CsEZ8rqeztdzY4kZ7LFb6g+dHK2e17cuxThRD3Qw1+WPSx1O7QTouywWacidznnXHzqW37LoUAateLS2xR2APrq71/SXWZaznU27Iv+sRepGrNBZCiI8DrwewY9wBrnywN6yy2FutM8VQcGMU2Efdvl/gx8+l1Y1bRa3KBNTxN49jTMPW1/snF2EQw+xBIE1LDav9g5ocC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtj79xuZInN6B+XVYTfqBLh9adH5iY7mutTyImwfCsE=;
 b=UpizpVFbdOn4GajzIf1a0uWsJQuvq4nCrWhgWY71qkOSVG+T2aS4FpUXH+VugGd4EWVFUe9J0rWRINywjpi3N01pEFAEFEMcDDdDFE1wGONX6MaDTnsPudJyu7wGXmszHhv9z66BFQHZ+YIzEo8moBYo/KNmlHpYODck9k/GMEREoGoMHzAs9A1+OZuTUIi3cIFTNLAdnQUK+eswBpxYgPBX6obIQBZz/DXg5gK3xhZJBwDqtmrgA4FTsUGQoHtXDQTCGGDA6hy3ndDT1JhvfTHAQjACbEnhUhben3hvIBJbQ467rr71ukuPmtaP2FHRMu1bAU2NoxFTq7uVtuCUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtj79xuZInN6B+XVYTfqBLh9adH5iY7mutTyImwfCsE=;
 b=BX/pLvanEkg99+za0rfQHsP7OOxnSLweavM723NUBSDdf5Ysl0d6gVxKHH8x0D5Rdyt03kaAAax0OgiXi8Cb9VcdDgRXusZ5t0hdG6ARO4wyUSgHeuBuZ+i8Nj5jsuufFci+J46wPtCnTZHIrEqR2hQfisrZOMW0NtLzoBpWRKI=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4108.eurprd04.prod.outlook.com (2603:10a6:5:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 10:58:46 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%3]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 10:58:46 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kjain@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] perf vendor events: Add JSON metrics for imx8mq DDR Perf
Date:   Wed, 27 Jan 2021 18:57:33 +0800
Message-Id: <20210127105734.12198-4-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 10:58:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6591b006-b63d-4db6-affc-08d8c2b284d3
X-MS-TrafficTypeDiagnostic: DB7PR04MB4108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB41088EC7DC5D1A0670638011E6BB0@DB7PR04MB4108.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbrE3eAJo1Fs9QThn/LbIek8Vbq1NbTeRQnZgFl8coxkm1vzTQ8UT9tRYXwiVQI6CM/ZiXKeEwYeY/XcM1A6gmc/ZcB4Q6jubkdv2tffV252TQ6TQ+YGql85xhAkRFnDl28QGRbZz4jzGnXiHIAwivFT2OCPJDAuNv5Pl+XweVD1f7sMOA0FoWsS86GcOPU8EBontAb998WQXZ5OR6TNx+DDBg24vamyjx6LP6wqDuXKkI7jckb9kGhdboM8F7eMYieHc+F3F4gq/sY0D55xtMTVrVXxXTofMgRhPlKYk98r0g3aC3W7H5wS0zLDjQAdlYI67T8NLRAMz6/ooLiBxsLdf/xdJiSgmKUKQEigAH4y2vyKpYqjE3ZbY4bXzH0VG8kDnIlZETQXQ+0fdZewQxjZfqLkXq6EV0d5O/Xy404x2TDknaQgCZ6eLWKJoTNObAzzFJF/uUUU0Hcol0LfETBscWcFPllu2w1Xqc4gfSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(52116002)(66476007)(921005)(26005)(66946007)(66556008)(6666004)(4326008)(8936002)(8676002)(1076003)(478600001)(956004)(36756003)(2616005)(16526019)(69590400011)(6506007)(86362001)(6512007)(2906002)(316002)(6486002)(7416002)(186003)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nXEn/LT1rdFCWH1Y8xANVLyHwNGOVvCKJ8oSNEu1YCB2rbXos92uOk78EnfU?=
 =?us-ascii?Q?+MeqEpkdLUNBzQosjQl7fPdi0Xdeeyx3TcWJbFDhY0FOt3Oqofojg3dPXJEl?=
 =?us-ascii?Q?ZvdvwGfjesmRiQJek1cJD3y8pyGJNVUWOkUueBXFMCiOyzq8jbz2IHNO39kb?=
 =?us-ascii?Q?l+OzeHMYWTJ3h72jKMoZPWrbHo/5kfPb79QPp2IhdM1lhFXVw8w+VYjsQ0FG?=
 =?us-ascii?Q?fHNpoRlE99vWD5zVHlluimg1nD3NsMhuBeOJtazR4hI4qcXudaJN0zYoRLqz?=
 =?us-ascii?Q?OB6qNP038FkabFmRg4mc5LEVQxCDjeoIhtSwn096QZOQzro7evo+kQoNX/kn?=
 =?us-ascii?Q?I2QrFI5kfl+2TXzb836msaJG52FgwC0ySfWdecLe8h0kXdo38c/M1/gU7zk2?=
 =?us-ascii?Q?ZxXjs+wKsSXdFV6wHdoxBmoF5eLeTFjil8NVXYr79lTWNh/TJ/L0hM8H5qcv?=
 =?us-ascii?Q?xz/0wvk0MYi688OihlnBRpd1arEjCKhy23RuUV13RBke3BbpqwVoMxp8+/dV?=
 =?us-ascii?Q?tIpW2NPBfB86aMWjvASJQOjZVeyF+CkReoO37F2ih+nDrY0LJxE/iT+Bg9cA?=
 =?us-ascii?Q?6jQerXZA1vYpUX6MPKgWBKLkxf06HPVXd6JBFXeO0xFrp60Bj7yvf5HaSuiO?=
 =?us-ascii?Q?lg1xJGD9yDzTwU/EYGK/peLS0dgvCTcnLATR9jN0AIoeWeBKA4fiGS5FXs8e?=
 =?us-ascii?Q?6fBM8ClLpMlTv6nxrMitPlWHEKkPXNE6gUilR7uhPXaoiMrtvLBREUS+uEqY?=
 =?us-ascii?Q?Z/a+BVn6ZkZpXKdNUkPrXzZdfdtitDTn9BAwc2SoydRptUK8sP/I5chVPnid?=
 =?us-ascii?Q?NlTUn7wwTtQ4zqlddnNexGzxrbII37I+z4yGD+vvWBhSGINcFmc4uNa1Y05l?=
 =?us-ascii?Q?w3celW11aAcYkQoHSU2EG2fSjk+ugJlUk5mVnPThVbtuE4nkOA+gHzuiDokj?=
 =?us-ascii?Q?NrJhhaDfj2T/LbXOs/QtXvLpw8BWbEWFH5KKNs/0GCPCzQepOoMVKp3FNMHM?=
 =?us-ascii?Q?kGSObNayFAA6XmdsYu7C14FY+OTlibA+0jzYgrpo4mDyNDtCqb3ICg63K7/w?=
 =?us-ascii?Q?Nct2+Opd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6591b006-b63d-4db6-affc-08d8c2b284d3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 10:58:46.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0afBAX5NXKO8vsvvCAQ0IpXAwq35rAta4gw+HOLfpt8Yh6cWkN7Cf+5LNVtXaGOfR4qjtwfL5iQbNr8DoCKbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for imx8mq DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arch/arm64/freescale/imx8mq/sys/ddrc.json | 37 +++++++++++++++++++
 .../arm64/freescale/imx8mq/sys/metrics.json   | 18 +++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
new file mode 100644
index 000000000000..c8682728ddad
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
@@ -0,0 +1,37 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx8mq_ddr.cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   },
+   {
+           "BriefDescription": "ddr read-cycles event",
+           "EventCode": "0x2a",
+           "EventName": "imx8mq_ddr.read_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   },
+   {
+           "BriefDescription": "ddr write-cycles event",
+           "EventCode": "0x2b",
+           "EventName": "imx8mq_ddr.write_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   },
+   {
+           "BriefDescription": "ddr read event",
+           "EventCode": "0x35",
+           "EventName": "imx8mq_ddr.read",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   },
+   {
+           "BriefDescription": "ddr write event",
+           "EventCode": "0x38",
+           "EventName": "imx8mq_ddr.write",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
new file mode 100644
index 000000000000..862c98171e0d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
@@ -0,0 +1,18 @@
+[
+   {
+	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
+	    "MetricName": "imx8mq_ddr_read.all",
+	    "MetricExpr": "imx8mq_ddr.read_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MQ"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
+	    "MetricName": "imx8mq_ddr_write.all",
+	    "MetricExpr": "imx8mq_ddr.write_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MQ"
+    }
+]
-- 
2.17.1

