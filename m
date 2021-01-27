Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CDD305920
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhA0LE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbhA0LAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:00:32 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED29AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:59:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4EX1iIbWfcerqslD1lpuk9hVOidf9Koix7RcQN39TPAD3JWo8YL0XAapTnCmqPLyLeawIzCkyQIGMUdy4dGG61boGjN0BRFUBW91A2/ofV6JzdFfr65VF35ClaqGuzwEoGCa9eVMQRMMG57S49FJbDHLRIrEHlXNtrKfYulPqpNQun///3S4Yf21I1BcYcbc8d/MZUWCvgO8oRh/9muiiC7x1yEu8eX1Chc1blOGQw1o3jz20vXpw0rlwknueGavQWXKYEBJ6PXKRDG9Y7yuX71I545gynW30ClCdCgYIAxAMoTVPYkw2/WiKQbLh/oOtenWVIYNaCAOLNpelNnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEGTMWiLpYFYRSGXWEoWmgl4qaheWwh5CNvYEDCRCn4=;
 b=S4Fr/Pfmx7DzRA/1A/W79eArxnK5AhP+cT6oruJ3BPSVYNZ5RxHbRMLu/eVubZU0omgA+TxUM6aTDuGtIY0qun3Y0h6k2u2pByLOjLtBHj3qyJU2ip5nncCzGc/vivF+XMpa8thY39p3NIFzIN8gPxO343Xn73SdBMEYo0EpV/kf0XfZ6jpmq6V3PDt4VpNvoqyKLLTHEUP9IvCPQw6dX3n/lXcmBXrr5QU1TWJl3e3VwFPqJde5MHIGUOGXSHJ0akhvs0vDBw/YDxE0XHJ2NjNHFLenTZoL/YCY/nlZmtReqOOwAhWHneK5v2Z16Y/BgpoFutFH4nGZnY9FLkvzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEGTMWiLpYFYRSGXWEoWmgl4qaheWwh5CNvYEDCRCn4=;
 b=N6Hw8A6SWDLqkjqq8k8hGYe5XmE3e/aKuJram8Jz6D60CGkEdbwiNryUxg91V6QmfbUUL39iuO30FQA8kqn6IsaNHj6PXN9GHfetZq+28nBGWYGPlWVRkBnERQRZV+s7EJ0VKG2Yei6dHDMsIEdBpcKn2NYgK6g1f4QinSacrCY=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4108.eurprd04.prod.outlook.com (2603:10a6:5:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 10:58:52 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%3]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 10:58:52 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kjain@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] perf vendor events: Add JSON metrics for imx8mp DDR Perf
Date:   Wed, 27 Jan 2021 18:57:34 +0800
Message-Id: <20210127105734.12198-5-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 10:58:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f7a2973-6539-4701-2b80-08d8c2b28835
X-MS-TrafficTypeDiagnostic: DB7PR04MB4108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4108991BE9A222A902B59012E6BB0@DB7PR04MB4108.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqKpV5ulEmNSYI1NhSXWxfBgZNa3OUSNAFiTgYjitpdS/K8RPd9t26nKE8kdaQB9/miKmmQQlhvwGqlj3GhNsy5Clnfc07wrlG0Bqk2PdakfJ/nQamlZbA6hA2NSV/YYTN0on6wluGbqYldtFFsryUYmeP/htu50mYk1DEb+Sp4QRGL+xojobk0OLu3N8IYss/QPxwmVU+O7PcMhZc5b1qRLG2WDhtWygSBLwzelt4TsShnEY3AVil/X0cuaXNk221NmghmtNVn7XLorryiM/BIMMNTio345j4DCi7xIush0V2GO4MO+P/SKWA7/Rog4yWhqd3KPQtnpcaJPaE5qTZT7QF7YHV3icuulOquL8nP32AQBbLSW+e4eBMlRZVLGOmBAYdsQoF9KMkhNllJWtWGICqbP92DXogzqhKpOQcYPyu7qALEp9p14NvQvgNfPaqnfcWzWMZ2kanF8/+FYhsOhgKmVozCyqvXli1n3260=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(52116002)(66476007)(921005)(26005)(66946007)(66556008)(6666004)(4326008)(8936002)(8676002)(1076003)(478600001)(30864003)(956004)(36756003)(2616005)(16526019)(69590400011)(6506007)(86362001)(6512007)(2906002)(316002)(6486002)(7416002)(186003)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3X6T2EqnBm2IdfOto1AodRkLbvuWwDDbpKEte9UPMwg4CMeRD+a5YZtpfj85?=
 =?us-ascii?Q?bB+vMyja4p4ebdtKSVeLkKtfjUaYWrFx46H5uLIu9pS4oR4oy7ypE/9PqxXY?=
 =?us-ascii?Q?kpOFLya2ddzlp98RkV7SenMdc7cgfXJJYX+Hhw+0NhXIbSSeoSj2W6eRAsBU?=
 =?us-ascii?Q?Dpk/JPEscH+I0qd2wwWu971NrC44+1uIuAG6FHKe+bqOVJ1BPdO00ylcaZhl?=
 =?us-ascii?Q?3Dyx11ukah5ARQFx/0w6kvp9dcXc7H1xA1bh0kOZhKIxlME/W4v6DqXFLSIr?=
 =?us-ascii?Q?CpEoaFu8z2Uenar1ex0oy9T3zU4/GCQ82D3ygYLtekKipv6dkumEQEdXfst1?=
 =?us-ascii?Q?6iKearxJTfP5+T1d6gSUfMZU/VCOlInKUMwE9wvbG9h1SHbq89XTJfjXC7zj?=
 =?us-ascii?Q?TDb7NU1Q2llOKJsY8/liiwxBTodE6xzvDYeDHXANZQB9nemMJlDeNjcuUhVX?=
 =?us-ascii?Q?Zn54xDdObWdfoaAEX9U3s7auoX+YiXMyEjvQQ0q46QyumpNgMByWtRAEgqsL?=
 =?us-ascii?Q?iA9YoasR0SSzRBWFUfdqEoSAzGEXET8WgcJwtNlS0tQ5djnxy2GNCvIy40k4?=
 =?us-ascii?Q?77NPdMXIstRw9LAHMAepDVOaoDmHFzWSxh9UneSweoUUOyoJEywrUnqOJ9ss?=
 =?us-ascii?Q?apVYIIw0+9dn2N0EQycxtEIiWRsVWPg4yiEXtCjcv61AqxvuK4OotKNktRoD?=
 =?us-ascii?Q?IyHhw8CqL2qZtCkHpPUHKOb9Uhb2LjaNNRnMsIV69E7+2S1nky4zgGMZ+cAI?=
 =?us-ascii?Q?slqnAKdZzI4H1JgsVlMqtoQTNbrYYsEHZ5IeJ/8tC65HWZLOh0A8pZzYeEMC?=
 =?us-ascii?Q?5CqT+4nZthLf4YDjz2cQaLni0bHfaLhOCR/hhz6dP/6MTgd3zioYN3vPDEPM?=
 =?us-ascii?Q?zbwYcjfAEQwb/lPfSSRlnAvPXmAMdud3+Mo9oogybULamfYqxc+4qdPTUiUA?=
 =?us-ascii?Q?c84T0BMY76gNa9UmKsk/0t54/JfAZPrPkz7g8p/cfFTUQwdFGKA2NJEqDPYE?=
 =?us-ascii?Q?M9UBGQ7ScTFHkmMh9ILGvz2Fjz/Es7xdOe4cXc64PhsTwJsOKmQht+NWrODR?=
 =?us-ascii?Q?nP9NBjzV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7a2973-6539-4701-2b80-08d8c2b28835
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 10:58:52.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnOjA7bt7aOiEBzeXQ+O6e4xz+EeQMT9OSuZg3aHt/tMfJ9xXIxQy+2DOpIEEUwbvdjxO0NPhWS7tcwTLNXhCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for imx8mp DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arch/arm64/freescale/imx8mp/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mp/sys/metrics.json   | 466 ++++++++++++++++++
 2 files changed, 503 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
new file mode 100644
index 000000000000..f9a89efc9b24
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
@@ -0,0 +1,37 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx8mp_ddr.cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   },
+   {
+           "BriefDescription": "ddr read-cycles event",
+           "EventCode": "0x2a",
+           "EventName": "imx8mp_ddr.read_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   },
+   {
+           "BriefDescription": "ddr write-cycles event",
+           "EventCode": "0x2b",
+           "EventName": "imx8mp_ddr.write_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   },
+   {
+           "BriefDescription": "ddr read event",
+           "EventCode": "0x35",
+           "EventName": "imx8mp_ddr.read",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   },
+   {
+           "BriefDescription": "ddr write event",
+           "EventCode": "0x38",
+           "EventName": "imx8mp_ddr.write",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
new file mode 100644
index 000000000000..8b9544424b3f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
@@ -0,0 +1,466 @@
+[
+   {
+	    "BriefDescription": "bytes of all masters read from ddr",
+	    "MetricName": "imx8mp_ddr_read.all",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of all masters write to ddr",
+	    "MetricName": "imx8mp_ddr_write.all",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of a53 core read from ddr",
+	    "MetricName": "imx8mp_ddr_read.a53",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0000@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of a53 core write to ddr",
+	    "MetricName": "imx8mp_ddr_write.a53",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0000@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of supermix(m7) core read from ddr",
+	    "MetricName": "imx8mp_ddr_read.supermix",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x000f\\,axi_id\\=0x0020@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of supermix(m7) write to ddr",
+	    "MetricName": "imx8mp_ddr_write.supermix",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x000f\\,axi_id\\=0x0020@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of gpu 3d read from ddr",
+	    "MetricName": "imx8mp_ddr_read.3d",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0070@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of gpu 3d write to ddr",
+	    "MetricName": "imx8mp_ddr_write.3d",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0070@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of gpu 2d read from ddr",
+	    "MetricName": "imx8mp_ddr_read.2d",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0071@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of gpu 2d write to ddr",
+	   "MetricName": "imx8mp_ddr_write.2d",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0071@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display lcdif1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.lcdif1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0068@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display lcdif1 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.lcdif1",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0068@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display lcdif2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.lcdif2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0069@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display lcdif2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.lcdif2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0069@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isi1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006a@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of display isi1 write to ddr",
+	    "MetricName": "imx8mp_ddr_write.isi1",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006a@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isi2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006b@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.isi2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006b@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi3 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isi3",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006c@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi3 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.isi3",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006c@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isp1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isp1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006d@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isp1 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.isp1",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006d@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isp2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isp2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006e@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isp2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.isp2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006e@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display dewarp read from ddr",
+	   "MetricName": "imx8mp_ddr_read.dewarp",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006f@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display dewarp write to ddr",
+	   "MetricName": "imx8mp_ddr_write.dewarp",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006f@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.vpu1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x007c@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu1 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.vpu1",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x007c@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.vpu2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x007d@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.vpu2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x007d@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu3 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.vpu3",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x007e@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu3 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.vpu3",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x007e@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of npu read from ddr",
+	   "MetricName": "imx8mp_ddr_read.npu",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0073@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of npu write to ddr",
+	   "MetricName": "imx8mp_ddr_write.npu",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0073@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio usb1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.usb1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0078@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio usb1 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.usb1",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0078@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio usb2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.usb2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0079@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio usb2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.usb2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0079@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio pci read from ddr",
+	   "MetricName": "imx8mp_ddr_read.pci",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x007a@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio pci write to ddr",
+	   "MetricName": "imx8mp_ddr_write.pci",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x007a@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx hrv_mwr read from ddr",
+	   "MetricName": "imx8mp_ddr_read.hdmi_hrv_mwr",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0074@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx hrv_mwr write to ddr",
+	   "MetricName": "imx8mp_ddr_write.hdmi_hrv_mwr",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0074@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx lcdif read from ddr",
+	   "MetricName": "imx8mp_ddr_read.hdmi_lcdif",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0075@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx lcdif write to ddr",
+	   "MetricName": "imx8mp_ddr_write.hdmi_lcdif",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0075@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx tx_hdcp read from ddr",
+	   "MetricName": "imx8mp_ddr_read.hdmi_hdcp",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0076@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx tx_hdcp write to ddr",
+	   "MetricName": "imx8mp_ddr_write.hdmi_hdcp",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0076@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio dsp read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_dsp",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0041@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio dsp write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_dsp",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0041@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma2_per read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma2_per",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0062@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma2_per write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma2_per",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0062@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma2_burst read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma2_burst",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0063@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma2_burst write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma2_burst",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0063@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma3_per read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma3_per",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0064@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma3_per write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma3_per",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0064@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma3_burst read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma3_burst",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0065@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma3_burst write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma3_burst",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0065@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma_pif read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma_pif",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0066@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma_pif write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma_pif",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0066@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   }
+]
-- 
2.17.1

