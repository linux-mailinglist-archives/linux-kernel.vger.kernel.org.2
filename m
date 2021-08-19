Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646413F143D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhHSHP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:15:59 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:29315
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236698AbhHSHPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:15:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKQilwEznmnQKMj2KIVFcDWNPtCnRR1cfPk9NlZgLs6R4WVoQbos5S6dTy4rnhfycPJmZeuDvt8Isv3KIs9CS7/o7/7O7pmfFZVqYIiVfOqScsZ/RVHhx5EfCmWdKJBiufAQZAGAjcvTUy1k+T3reg5q7DPJ9I9klBqhv+gPR7rPwVG8hXSZ+BKYTPAnQC1xaRwJFn2fwCiIWW92pzsc3Meu/41U3v9tDEfUWvOtaM81JGPKSZWbX3rM15Q4V4Ivz4EpboX+XLaQic7Mkce0pZJkl3AzqiSmON7PoQj9MPIecWHNsN0DJGwjNL3x5578IHVeSqDbc9VwxLjClotoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/GIpRiMkvLVYgACQooW+yvam959ck0REa0kDsrKlzY=;
 b=SIDgX6OQhZvGI4vwRj1IiVUuHS4Qsqm11Ep0EFrsYsTkO98iC6g6FBToFb79Bb2idEeDIE3FPYUkFSkbBYpkZySZonmP3+b0jo2QKuEexPQ1WH+JjRwTzRFQlTnwEGnfXdMSfHFI6BV6nSr7PnXo4eyQHr9G+dR3jB5gPk3IJuh8Slri8PTEwtecw/aBDEz3H55n4gPLEfdPOx+q70wiqrD4yU2+HHPzQpc/NiUvDAJ9XROgrLjDkBHliPCFLza0Y/UMpKng0UAYshkF0WQoSlRbt5pG7hq3pDT73Yykcwr0hSODzj3Lhq6l2SRpm8fA11O/oix1DiZR30v1bn01FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/GIpRiMkvLVYgACQooW+yvam959ck0REa0kDsrKlzY=;
 b=M65yV1JdvE6gwbkeJ3jmfJXHjLR6PT2ro0r7CAP+w4JD9qaSidLnifpmPA1e6ywFTlpuFWuhxWmUuj/JFA6fCewy+bJeJgVrwUnQxzDOJqlqz4UhJOihbSJkCJnJ9hYr+BZkltMb5t9hTKLRdPQvdo+ABMfOYn6aJRF0QqQKWss=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 07:15:11 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 07:15:11 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 3/3] arm64: dts: imx8mq: fix the schema check errors
Date:   Thu, 19 Aug 2021 15:14:08 +0800
Message-Id: <20210819071408.3856475-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
References: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To VI1PR04MB5853.eurprd04.prod.outlook.com
 (2603:10a6:803:e3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 07:15:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 026d1bdf-5cb0-45e2-8874-08d962e114f0
X-MS-TrafficTypeDiagnostic: VI1PR04MB6941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB694181B85100C580DB726A818CC09@VI1PR04MB6941.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C32l385itpXkMTI21vN1ICYOUwADek3oPt4/FSQ83Cl54HMzH9V7Zmbu+iDx7tGLQshNmtwSWZMV6qpnF7NP/CRGBE1PZ74HxkcFWpJ7Mx+mS7Vknr/ns/kGjfO6fTKtI2g4uc1vC4lw6zyBSKDli2GnhH0e5+81hXTlPy1GMMK20wwVzyR6dn8lurW82zB2JrJjH1yrQCTYjQjc5yVjOOhmLt1tAxWWGRKbPes2jn4Vjr/3YqQzLC/1DfMZYpElcH/5XXpt5/MF4oyf7VxhoppJmHwDkWWi8qyEOH4XI6fUa3QSBb6JVdhvd+opzCKmZR9Em5khCJfq30W6fuGpKJ+HtdOr4RwrcLEuxSsDYe+KrdUeQkeilCbfsPa3BrVhIOZMW9H+NmLz3BMShTAO+mXcXv3uC1S63J8lcki/knHJc/q0yDgPBH7gopuJLmsGvYbsiyQJToKHfV0Czvdk7oQOq0wnQmhdeB/kJBmlLoJ00F0nFpaNxjMYnIiO878P5ON44gsv78CiFdkGQKSY6zH0m531l9Turs+ExDQFPgtNIq+EGpGiVpAUXgfToGAiUZNhIBeR3bmWZK7tjiS6T4e19yGKw4tNi/3Pi9j+McuBCXoTELZjaueKjpy4hVCSjsbpTVmUEkWqLoCwTgNxIANPZU5xMCQMZfBpxFHKug5qcqux0PkypSnntIhhj5n36WwUggB543I0l3k1FmgOPbwDus2Q/RXy57YjBoW6w3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(6512007)(6506007)(5660300002)(2906002)(36756003)(4326008)(2616005)(8936002)(86362001)(66556008)(66476007)(478600001)(956004)(83380400001)(66946007)(6486002)(1076003)(8676002)(38100700002)(38350700002)(186003)(26005)(316002)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AXQqv+B5Cr2tsLTg/8QEr8XzaZ4ktuZDx6kJFOrfTUJFJk+yS44KFbo7TA4I?=
 =?us-ascii?Q?vErxVzFzaQcw1X+vOXIforQdmTCp+VGNQrGMzz6fQbz1KFUbEaZ90pOqXLaG?=
 =?us-ascii?Q?Kz+bna9Dqu4ziT08LBVqcZjj2DEdjbbs8bY/qnnmzfMecuHYDOYT05q1E/Zm?=
 =?us-ascii?Q?ZhIbGPjIeNGF+Qm/uEGHIpioi8GbbBOKQ14DgO3YiCaytJCDvtvhEuH4vkyZ?=
 =?us-ascii?Q?RVzt38fJyY7iPSKuzsts8Q4dtTtn4WspIBKaHeOa7svjHcYsWgF2R/XGpnXE?=
 =?us-ascii?Q?9VgZssgVReoFJKSvcMTlmqhtGDGSbDu4qzRNayi03RxadY+Yc2FfBw7o68Wo?=
 =?us-ascii?Q?tmkgxmhe2wR1OwCTKNgekqSegZdMuKlkXqY02b9zr31c5zCM5AmZa9hwG2ec?=
 =?us-ascii?Q?kg3uTUtzfeC0mTrnLwy2IeRMusNx7m/a4jZK/rHCFfy0+RBEMpJN+YGprWT2?=
 =?us-ascii?Q?w9jlJLGtxqu/jSybSOfWJobwKGRoEcTbt3OekaJchv4I9wBTmfeb7c0QE+Qw?=
 =?us-ascii?Q?LeATEcVLpXeucI7EkOWCAnhqxB7BzBW1bUMnGmlF6LDoyXlJdo2eMowLa5dX?=
 =?us-ascii?Q?hCZGK4uqOF50C1VnxZr6GeVyETdILP0eIzZjozD42Iy3HmdWZJ1SAaRerxfU?=
 =?us-ascii?Q?DDgznLDPKExE1JoEB/MXSGfcqoOvc4laLXi9/5G0S3s+7odMiffknTvaMLdz?=
 =?us-ascii?Q?apYnYTaKoLeuylyMfEXau05lM/hqIytzh8f+1AWGHJ7hpZT/Itnpkz14Qocx?=
 =?us-ascii?Q?maj7KVE2OwMEN3kRJTUJVQO81sr5RWA2lc98aqhUpjNXpOr+93fuVCyXleXv?=
 =?us-ascii?Q?/EeMZkL4fghrlSCuDMhWnWPJKxorIxaDlNDwsRQDK1mDVHRnoFvnNSB36NQ/?=
 =?us-ascii?Q?Sg7Tjr4TpiSfLGex23kYB0n5cb7boxZFLEChnO5sfgvCGlZpAx/x2KYN9dXx?=
 =?us-ascii?Q?SFhZTXP1Uw+JWVxgRV9CJLnnubSfl2aERU53aysWQ9EYxbbiKiNKymlVC4m0?=
 =?us-ascii?Q?zLUvM6RMFPkuw5d8cQQwfW3cy0BfK/mfbkpLWXofWOFRQOYSM2ZfGirDWG6m?=
 =?us-ascii?Q?8boBLwlVyM3MhoxWCrjp2gf4kyqj0hPInl02glZJ5h8tnGi4IfyKQG1X19Co?=
 =?us-ascii?Q?vT8mynzNm3IuniAK6ctTg9xa+KzWb9BbnPfLD3EJ8WYfX0h82NHhji9NVPGN?=
 =?us-ascii?Q?4ylAwJJk7cL8Pq2aQhhEKv8brV0U00hzxTgqVMVeFHM4BorqPo0rF8niItCE?=
 =?us-ascii?Q?/xJyYCE/Rt/oMqhiMbVw11J59nSXeAK2C82hcVpzOFCKozWZyOURbAvxxcZD?=
 =?us-ascii?Q?Ku5ixQ81TjP7zJm0GB02qlFo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026d1bdf-5cb0-45e2-8874-08d962e114f0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 07:15:11.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJKCgMiKg29Qz0hhrFkvmPSrE+7s9l4dYfOeLB7vIVNTlpKRnQJVQ02kAI/DwtZLsVp/XNKDLGr39XCqHf7McQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ranges should be aligned to $ref: /schemas/pci/pci-bus.yaml#

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 91df9c5350ae..45895dad85e1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1364,8 +1364,8 @@ pcie0: pcie@33800000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
-			          0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000>, /* downstream I/O 64KB */
+				 <0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			num-viewport = <4>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
@@ -1402,8 +1402,8 @@ pcie1: pcie@33c00000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000 /* downstream I/O 64KB */
-				   0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
+			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000>, /* downstream I/O 64KB */
+				  <0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			num-viewport = <4>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

