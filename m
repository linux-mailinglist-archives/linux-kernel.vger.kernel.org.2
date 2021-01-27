Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6E630591A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhA0LCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:02:43 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:50816
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236336AbhA0K72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:59:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liXQ4PYHHwo3XE1dSJQEoz3EJCrKPTVCw6mNbD1yF0dxk2Dnn04gZOc63HXd1OdS9WmA2hQex4JMqpRoL+6+x+NCypQUxpRy/RycY3gR3rujHrTR35lGaSnMvPHCNkKXsVR4dpz2chbzrxh9x7leakA+HCe404yESpjhBrZuqKOU+g7VcTX7iV/aY9im5hpnWqpYEDqQCBUIdyHxyp3U2+ietd2ET5DSx1uZKbjWZdtQSiTD9lNbrXlMwRSCbPkoJCbF+FzZmHKMJc3Dhafs3oSEbZyEP8XMV4P3NlP6vLEafRiXmxFMfHpPMMSGBLdo23UPB477JuBE5ELJa01iKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT9m9cF0Kc0jm3bqJhb/OVvJufFPLtY58gbuDBTQaGA=;
 b=TFyw8GqAhSp/Hu/gmdAZB91S/otwf9ts4jeWSDP28qdRAHJ36VVF2Pxx1L9whkKbb1H3gaOMIzNIE6qkMHksU3yr8aBBCo2qkR7l8x/f2wsuZ8ftPiL+Z005ESEN5eoZUWH/v3JVn+7RfWDZSz1CtytoJ32OnvHJG6OSkpQQG+Vd8C7nFeEBY4NeBLWRxQdXZi0ZCAGpeLxFlSXOTIWfLM1oLuyWt7NicqJpAUUAsTVzmjqggIJX78U0JP9DLjX3fNLCwAlC90BhYbgjPDow11XZ3lp11Ju2zLfl71aw4nRVf2Z3+ojGxKHdk61reGRluX5F3PtcgcvI2mfbLJPSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT9m9cF0Kc0jm3bqJhb/OVvJufFPLtY58gbuDBTQaGA=;
 b=csiFR19rNpnzEbS5CAAMxL+hMEZVxQyERMfg9ZB0TJOjRvPf3U+e1nKKoPvZWL19Ux3rKaLWbw+vOMyClx1CC0myuPoyk7UiXshGUqG3YWIpu1DeU7hPHkB8A7E4vE+tr/kM41DuERRx8ezPiQKNDQFOEmVpaoEYg8DhejM4WfA=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4108.eurprd04.prod.outlook.com (2603:10a6:5:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 10:58:35 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%3]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 10:58:35 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kjain@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] perf vendor events: Fix indentation of brackets in imx8mm metrics
Date:   Wed, 27 Jan 2021 18:57:31 +0800
Message-Id: <20210127105734.12198-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 10:58:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e236592-39b3-4f30-e8c8-08d8c2b27dfb
X-MS-TrafficTypeDiagnostic: DB7PR04MB4108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB41084AC9DC55D08D04E75DA9E6BB0@DB7PR04MB4108.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxe6ir+fRkyvt+ZHBtASxPMpoDEzy4b7M8zHH6fE4Gi+PItnZ5svrHezIjYkZF0DIsYg5Nvn5QoOSlPJQmAlOUyJ5thzzNG4+3Y6PXYnqVtLScqWfE/9yWza9X1qKVVMPtwscb4OJejwp1w1nb3PzYRj5QeN0pAuL2SWgpkG7m2XU5wohMl4vxCKm7jSZR8e5NvLYzKA0vdBVHtYvVPXv9HzQMjzSgbxlON6lGHxGgaiS5lGGWGKn9+Jz+TR7oGLa3qO4+6bCCiiuHCodjW3ugINdfvoje9HS7zsqKYcNTKUYw/P290L11KXg73tq9dfjn1b0htBIcDJpSyX0LcPUWlMmLuEsUlhAJFwAyPCEu7iX4shKZGm/D19p2EEDrNrsK4szFI8N+rjm3srLhdWVB070HLqXxdUbeWeNvBjZA8ru8MgH3fTxW9gz8IkEG9fP3vTSLH0ruCmks/1D4wyK36kX6FVnPe8GsB4JOYKtro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(52116002)(66476007)(921005)(26005)(66946007)(66556008)(6666004)(4326008)(8936002)(8676002)(1076003)(478600001)(956004)(36756003)(2616005)(16526019)(69590400011)(6506007)(86362001)(6512007)(83380400001)(4744005)(2906002)(316002)(6486002)(7416002)(186003)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?puG3ovnGd4FlOm+QxE/qXocc0jtXek4cGzup7A5fqzq385IFHsbhx/iT6iGr?=
 =?us-ascii?Q?X951xWPlZRTHCTEDDvh8gfZ4Vs6D5EmP9yMMALt7xtKi6BslnjTTtj0j/gBq?=
 =?us-ascii?Q?sXBdu2ig9xcF/r4NTwxPUa5byx9MotTCFG40SgCK5SN72yYQch1qAeYFcB2b?=
 =?us-ascii?Q?DqBToPIP5GpUjaRG5FalZHR+RJn3i7HCUhO8noAkTjJrdlpBG1T9fncxjQN6?=
 =?us-ascii?Q?y+YSUWyPAZAZHVF9AUPmKQ2HzvQuJeS9cqtAz0qjULimID7EdyexHGht+KVp?=
 =?us-ascii?Q?rUpiMWj+/Mb0jP1uh8aOZv8ls9/kAA/IDugl8LaWrg+7EHEdq+5S1RSW62Ny?=
 =?us-ascii?Q?S/zji5DXCFx2chMjzX5pQgopj6V/ZuzPI7CH42RunhHhTm+0Z0w6YI19avPL?=
 =?us-ascii?Q?dNB6upWpsPBgRzmEe2kjFTGLsi8pbw/h0EpzYRv4sn4a7bbl9ms4/lN3rSAr?=
 =?us-ascii?Q?E/7739+2HrxtUoaRI4SAjjeDMJLWWx9A7A7OPCV72h4Qd/SdI9YQ1Wtlap+B?=
 =?us-ascii?Q?7ViudfRGH2yDjb+pDwrrEySlxBAq63I5cPAhhSwIXS84YcNsTISSw0lCmLHh?=
 =?us-ascii?Q?dDMNWthWWJy7k0q+6j50HAZ/zEZk4c2JqD2Ffc+Hd5yY39eLxqFaIQrF/p4/?=
 =?us-ascii?Q?Gevmi52RVxpkWTmHOwswHVn6ZHKvzPFkGfZ6YiGw354/EZqWno0CMSvaz7XF?=
 =?us-ascii?Q?6s2b+YcMck3LbEp6NhRdlbE42qjgQugTAFKPrd4/8bKrkAJpaI3oYEQlIAMj?=
 =?us-ascii?Q?4vhCpdjX7cwVjTbmBZk2L4pvwBQzqM9Y6Cfm6onJEoP4bwq/qX7eZfaE2sL3?=
 =?us-ascii?Q?fuIYvWuVVrPisyD8iKinMEQYUu3oRTfQzZj+razcMKNHKbZA1Ysz+i9u9gpJ?=
 =?us-ascii?Q?Gw261eBgnGfNlwgEaGquwohOb7vfK2PuOALKtRon9URObxP0UP5yhEs1Qk76?=
 =?us-ascii?Q?JPSBTd8NCf43LcwqR2HjnovC7xvVYQMaIrym3R+d2pdSrUl4mepkksA52uBi?=
 =?us-ascii?Q?mHnWNeXIER4NZF3akEKxLj58Arm/KfY1k7sE/GiGPn426ywOhWdE8ZMpJEPq?=
 =?us-ascii?Q?zyYnTLNC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e236592-39b3-4f30-e8c8-08d8c2b27dfb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 10:58:34.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZ9kC6OdetYrOSKqEjko77Gz6/canpU5FFBh4yt/fdGnYLSHWP9UYTCnoxR7VtBwI/eGR7cmti5TwhLW//wPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation of brackets in imx8mm metrics.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
index 8e553b67cae6..f416fa052337 100644
--- a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
@@ -6,7 +6,7 @@
 	    "ScaleUnit": "9.765625e-4KB",
 	    "Unit": "imx8_ddr",
 	    "Compat": "i.MX8MM"
-    },
+   },
    {
 	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
 	    "MetricName": "imx8mm_ddr_write.all",
@@ -14,5 +14,5 @@
 	    "ScaleUnit": "9.765625e-4KB",
 	    "Unit": "imx8_ddr",
 	    "Compat": "i.MX8MM"
-    }
+   }
 ]
-- 
2.17.1

