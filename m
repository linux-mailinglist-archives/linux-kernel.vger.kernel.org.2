Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B267C44E1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhKLGfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:35:48 -0500
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:18809
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231156AbhKLGfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:35:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5dpnLxe2sNQL6NQEccx1kDhjy5gO2TVRLlO9OAlEeH64WpuSgHNfsZGZNLA1ScCiO0h4w/qG/Z4YPG+vQfV3s/hIWT+fxXeyMs861q+vR7lqDcBhLU/Kxd0YG/ZSnInZ4z++Z1ubwwWQR9mHK6UVlIq3Vrc/bCZLHkjxQrA8ZRX2caKJlsi7Mdfq2lWeOxrFqbOJTOaVl9Dl155LEvJiZyq9Z8P608SMGb4NnPrTSE5nVPPb5kHpaqkwvZ18dVYNoldReP6jdnLNn4eU1IGTFqy/jJCoGQY/pOt/jHXeWjHq3xghOOXghIm0VPHHDZ3ASufk33m9d9+kk4g9jVAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQxaa+15nV0q7lVSaQcVb8SH1Yx+st1OHaGLTbL/K7Q=;
 b=MuqUJEYYvhrPp87wvZHzCH1FzQf5lpKf0+bLPghBafzxPXhIRI1qbCF5oQmYr+CEhuPm//SbnEc1C0ZfYgzCPKeR5rn7Guqgoi2wqtRbeXaGTJ5dZ9XVVs7hhnZZNOK9Zyrdp9kY1Cx7Q3sYIqF/fwktGT2SUBKb7IZ/i0aH46ftW9oVDSuekSZpWAX7mrx2Vu1QW+GsGdg0sunicPP2lWrYBxC3vqoNxPlxrRv8aehB/lAmCAAqtVrzGTYgz5UH6guZhJGnUo8V9KL2KwFo+IuU8UuchUDlw5wabqiRWk+RloQM85jB5y55fpR3YckJR49IHEksaTwE+vZEoUcaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQxaa+15nV0q7lVSaQcVb8SH1Yx+st1OHaGLTbL/K7Q=;
 b=fydq34wKhDeIXoJKAcs7HFkQVrMJgRlcTv7xNPs/TQkI9rw3aLYIXohIvuoXBpcXurNppBTOOFwpT8QLTqnh2+uhQ9Pj58rMIHimRAKJuBsv0XA58M1fGu/cGcdfnKMqMU2O9kow496IGzv8TKro3v67H7ggQphTJeR0U5ORnC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8886.eurprd04.prod.outlook.com (2603:10a6:10:2e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Fri, 12 Nov
 2021 06:32:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 06:32:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
        s-anna@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: k3-j721e: correct cache-sets info
Date:   Fri, 12 Nov 2021 14:31:55 +0800
Message-Id: <20211112063155.3485777-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend Transport; Fri, 12 Nov 2021 06:32:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df19392c-fb3a-4e80-bcad-08d9a5a64188
X-MS-TrafficTypeDiagnostic: DU2PR04MB8886:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8886BF131535B9432072128BC9959@DU2PR04MB8886.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmF4PMGKi0yw8DrPd4QMKdBbDqGffMkZsMGQAfe2WGIhfo8HmS9+y84KcCngfqhzcupcZbz6qpdmEZ9ISaDmhWpVlVmX3K3HB5VQnrCw3YRrH1sF3K0jE630jNw9+U4j4QrkuDpSJe1Q1i1m5bBIlSGw90ZSHipxu1X95ZqSrzit+NVUX5RoWdg4rbg/tqMgxUJAbdvXo/uovW7LBInVr7isiZW7UI5G6Mqbbt3mzKH3+8B47vRHVL1ZPqavLV36Fr1tTcOwoKQ5pPD7F4xV0Flrzx6AcZ+cWINbfS5AemcoXHKfthvx+QKd6597e6pOUAZcSn/ZqxW7JqKlrkBjjBXwlcYH1pMEV1UcEUj+77YebFukDBwKcx8xxduVBPS8b0Ovh7ocKUfap+vMT4qqHoj5tSEUjrPzQ/7kgTocTNlywRpxnUy6iVMqM3gr5/DimaLPyIeEZ+xMeFoMadT98GchTT2w8KWpoaYD2JhZk5ZnYy6C0aCmuxrN2gUs9Z177+u+chuhOApqYtZytY/38YPHKDjxd3hPFm2Z/ChWo+ck502nOGw6tKnNZTgCQWBn3dbo4J4piQ8rbNHGK6uJqmQ1sLyGKfc+d/lghzUpX+ndoGbTD6TgT4+kgI8i3Br6IrurZjsbN3ZUwI8QLp+kvnCvb+O3hhe/t9KDxD1x1J8nx6ATH5kg9bcgPiowuHovl6xjaUDXSDc1h/42UhoCyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8936002)(2906002)(66556008)(4326008)(8676002)(52116002)(2616005)(6506007)(956004)(1076003)(5660300002)(316002)(86362001)(38100700002)(186003)(38350700002)(26005)(6512007)(66476007)(6486002)(66946007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psY5p74JD3c/XOh4J0oaTeJJ25ZANj6Hy1Sp4XHbhYoDzAK/D2HCtPsmjlTv?=
 =?us-ascii?Q?ISD4fPuPIt3GSaEFzg7qEA8nfLkhYCLtPhx0tN0DrRXhux/uXXOJZ7G0QnuZ?=
 =?us-ascii?Q?5YbwYbMZvQkxuBi1dJAu+7gWauwA3uvKdQR0KBWJVIkRmQ9vnWYn8mNrWhIN?=
 =?us-ascii?Q?hlNG/LyQb6GO5FvgrRl/GbNzsJTm/7JTRBfC4NZMHMTjrwoYiaySdlKMWeKw?=
 =?us-ascii?Q?Pk0myWaa+WJ/o4NzWgeq/m0s/xqyxc5Tn/gAJgLmqr5m7JnsCP3xeByO/kc3?=
 =?us-ascii?Q?rup0WD2aHJ+cmUF19l6S9jcvi6IQKKxHq05bGAkVfoAWH7svkzhkb+Hw9KB2?=
 =?us-ascii?Q?RHquODdDnCTeCIX4TbbCj3q718FL6BdCx6JzAsi7+i+x402wh+8FNMlOQGBp?=
 =?us-ascii?Q?ZUiAL0zswePMWz4WdXVl0NJjGpCAMCYtdnp6ZCDnSMAp1MNKUXPiZpqKTOIF?=
 =?us-ascii?Q?3WgWLr5sIoZ4I1u8TkQOA51nj8aw+uZJPTaFro/msrq/Hqlp+TerZytnaqot?=
 =?us-ascii?Q?SHn58fQGPFI2GQWTqI2kUxa071PZTdaAjfV/Rfqh0jir4XfhveIHW03eraS9?=
 =?us-ascii?Q?WM80T5f+cdBWrsd54losolDK5hIIh+wXWvMmFHindhkn/w3K0YzaFeIZRTLW?=
 =?us-ascii?Q?jn8u22PuzwHxWJgIm0ozZM9jn7AO7KgpCj7suDC5UMqhCTvQTYJK/cBqZpgL?=
 =?us-ascii?Q?n8uxaCobHn2RV/KrWMFY21j5fuoZ1FizkK3sDuLdSzEcTWRqLsmZaJvbTv33?=
 =?us-ascii?Q?acY/951rjgNeheaQiCopl45aOngmXmMTO7wO1rt9s12VuJUa7zWD/i/8Qcc2?=
 =?us-ascii?Q?rmCJWRuaLA0R5mphLIeWdhnMaC0dKhrdYuGycHfDRhZPH2u9A1xGWqViiKnO?=
 =?us-ascii?Q?BZCkKGPDVb11IcTLRkwBGZ4/F7tc04DwmbeoIh/okRXkHIbgnHHywH4EkPJQ?=
 =?us-ascii?Q?oAT0gyQ2wQvywjLgtTO/CPP4326TD9EwKbxWGveCQ0Z/a9DXEqlzoXUUhPSr?=
 =?us-ascii?Q?kaZmhgdTj38tGwFi38VlrYuwo470Hnxo4Os8ajL7Nc8BJuHAd3sW2TiSJOcI?=
 =?us-ascii?Q?kukI6f4iyXm6uhYeUv35zE055pXix8qS8tmQl4hX/7YjReG+UQZiDUmGvfa4?=
 =?us-ascii?Q?CCSzuEAeeakifhIlbV75buVnOri/nl5OhYp5ZJVHEzclMruBCw3zYTjzSCUU?=
 =?us-ascii?Q?C1HAallPTE/wafzy9KBVojqqDl1Ii1mZBdkHaI/RbQ0Ci6Zv3F3n04+IJUv9?=
 =?us-ascii?Q?My5o9XQjawfEHganmBim22caq1IEve6Xxszc5FYQxELfHIhOjD7mVTdmFzrl?=
 =?us-ascii?Q?YxU9emrAT0lQF+dd4ht6PJ1hFWOKWUMpwY/X3YfijsQmpXBjdm5gEoNPI0H+?=
 =?us-ascii?Q?Bv+4siagacZo6kVsC9Y/rWRdvdgCWU/uQ7FOI/jkwiW1nb53IKuyzTQUgCVL?=
 =?us-ascii?Q?7sqhGTjbeQBsEq8bzOeDntIQ3wXXnTD5jDEIHkgbDXLTS3cnCsWVqnm6I8zm?=
 =?us-ascii?Q?kRi3eeP7flImtW1vlEZdlzg1aTuaAhXXNSt4KewMaRDgwIV8Chc+ueOQUjuB?=
 =?us-ascii?Q?g1wGPFLDs/hMp+OodLNx8f3p0KGEYtQj9OU3/hIJxd3HZ1kc2a+iveUh5XUr?=
 =?us-ascii?Q?n5Mzy0DVSZqfNQuQgowPf/A=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df19392c-fb3a-4e80-bcad-08d9a5a64188
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 06:32:53.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1lsSKZpZysP85TAvo8nsvERIeZHBFvZpQMaT1/NexNDd6NUHUi994UKxtHoBCPJV0RiXT9upuaJQk9Tpzhglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8886
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

A72 Cluster has 48KB Icache, 32KB Dcache and 1MB L2 Cache
 - ICache is 3-way set-associative
 - Dcache is 2-way set-associative
 - Line size are 64bytes

So correct the cache-sets info.

Fixes: 2d87061e70dea ("arm64: dts: ti: Add Support for J721E SoC")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/ti/k3-j721e.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 214359e7288b..a5967ba139d7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -64,7 +64,7 @@ cpu0: cpu@0 {
 			i-cache-sets = <256>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -78,7 +78,7 @@ cpu1: cpu@1 {
 			i-cache-sets = <256>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			next-level-cache = <&L2_0>;
 		};
 	};
-- 
2.25.1

