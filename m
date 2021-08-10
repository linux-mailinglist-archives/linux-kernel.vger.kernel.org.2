Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A949A3E545E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhHJHgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:36:01 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:31714
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234183AbhHJHf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:35:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl3tTkSrN3o+MgMWccxlHgKWanrqRkB/mR2m/AdcOEbpjZSLQWGq7GSugNJcCJ9MLgI4sfHJ8O5tIJSd0XxY1aXsyBy6E26oPEdpklkTIiAz6AD1crGhzL59lXjr/39mw+9Xp+f0+u2/iA1eH/O0lZ1d3/mmk3RTzTUrTNq2EFDv+1BRHb37VYKazG+nStl1g9S/qXljiEne8rLB4ccfQ5TymPID6u7m2neT2eviKvUQ5vGYmQxP4l8GwTLSoDBiMy8DhD6Y9lLgithTIsovDW9XwDjcI5+/d4oVjaTHINivrU+KRQDB1DhTmjNwHpvPZBlP22OwF9MsN8MB2CkNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFPxvz60MR0+k8zULumOAc2rovjvpHIKDlynGoQswIk=;
 b=WFLsuYD6zYTOMUmyaw9FMSco/BOxYWDrj0y1R7DbPMVG0CzOQfgpll0o2y6inshop3ZHkm9srziaukTs4iktIY1UUlU+uRtq0RzoHTmjTzjJRQl6hhzExlMOec7SLBYYpux6CvXKZGyzuwW2lNc05xHfOcEX3Gv4BvdQFkuhdT5NOgUZVPNAUZwSqb1EYmHcgppwZVhcBUnwU520rrVkMflhPBMi1YmBxNpmjfF8SVhGAmBmwwQqswFzv3lxiNVJE2FBb0Xby1t7Lt9BSYbIBX+Y4Y0fvgdvQKDwmMC7a4OQwqjeBP4WFuXK0YKYZOirNmA2+EPAkjAK+Di+wxtW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFPxvz60MR0+k8zULumOAc2rovjvpHIKDlynGoQswIk=;
 b=Zb+kDY+vHFHp9sppb2DrnCYyDu0Ghr2LO4dB76qUj6r96wcac1BZiuXs+5ef9WLsM+orQfF5KDv3ldrMDSRSzqOINhOlmexlohOpHrqlFTjkQw/WDW1mi2GluGYdW/zNN8d8ziHeB6+pqZU6YuEJ6Re3NME7x/WdFcYscHIyoOM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6793.eurprd04.prod.outlook.com (2603:10a6:10:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 07:35:33 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d%6]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 07:35:33 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 4/4] arm64: dts: imx8m: remove unused "nvmem_macaddr_swap" property for FEC
Date:   Tue, 10 Aug 2021 15:35:10 +0800
Message-Id: <20210810073510.18218-5-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR03CA0098.apcprd03.prod.outlook.com (2603:1096:4:7c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Tue, 10 Aug 2021 07:35:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d84f902-3d7f-480f-d8ee-08d95bd16fb2
X-MS-TrafficTypeDiagnostic: DB8PR04MB6793:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB67933EB2942BA457A56F11C7E6F79@DB8PR04MB6793.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYFqQK3Sza2n9kODgakoit5x/GD8F1WeD7xQC0w/q7blVgpQLTOJj6D6umTLru24FgIieTf6kmHZmx3kdkanmqBarD1bqAof5fpK1ha+q6AjmaxwQAkEVzHW3X10Tuhf0nTBUgPjY0TRsN3s6H62IMTEl0yh8qo0pKKOAGbp99mASZRWAdld8ZE4szu6gFQ7lhw5CbdJMTCRXJH6gho5rn07f0KuTbnxRcznuQfnFjL67ylS58S2N8gsDtJTAMyzdXPTiq8xpWtiHZPZOY7t+6cWiyqePMK+fU4XEhJHqDyrpYwJ7kTXnOhR3ew6nXSBdcTHB7DSqduWo6XSEJyy22vrJC7TqyLLxvehVo4GOSi3oxfRO2KvkVov1GCMudDXiX3zTPe+2ATYmSw1IJWYOz+DSmBEllPR3TnsEmMZDI2jy7aijDc1hUbE35Sd0wxkLkUxEAjrSc3hMKYCD4E22Y8V4G5BvpuJthDVgK9NYNN8jw1HS8IUe3P9AmcY4LPpF6MAdzIn+MspfEFYtaEC7nXibgbPxJ/lXQWRmumtQFBBLxC3t5KEHBVK7QEBqb5+v8FvhF/cr6XFqZf46z+YKouiA6MC3yANGum08WS8vL44RKJdB6075xyvMEiy2dwNR9bnMSEAYa2Jik6sXeEAl6IS/I/c6f8wzDVitncLx8LAQRnLOaU4CzvaF7QW31QMT2dKe1DI6lqBdeFSU71AILejk3+whFI7JWnfl6oBYaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39850400004)(376002)(346002)(2906002)(26005)(66556008)(8936002)(86362001)(66946007)(38350700002)(38100700002)(66476007)(8676002)(6666004)(6506007)(1076003)(186003)(316002)(5660300002)(83380400001)(36756003)(2616005)(956004)(52116002)(4326008)(6512007)(478600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FwiuVTk7HZafSabDxqp+j1BVprJrs+CWC4jWphtJDgKcZZ2TDerfxpUxg2zW?=
 =?us-ascii?Q?yaz6vX+UTWl+StOeAX1TnSvGkuC2cdbEJS362M6EPOsD/0qYWuNG8sLW213P?=
 =?us-ascii?Q?jQqutjYlqsR2o8sNwUaAj4c4BC4fzywAi0Pd0rpGXYKJoSsPFWIWWU1xMJf2?=
 =?us-ascii?Q?e9JEU7GEctqJw6YU6e1CwzJCz+V9cwQaajIAL7a+yBuSYcljFUhALRWyOh0k?=
 =?us-ascii?Q?YEPjTK4R/WxzPGAKND+ngFohf9oRh9vPgy90W/3QEXmKc1QiKpt8tU0g91wU?=
 =?us-ascii?Q?76Zfn7lDdlyfzFc3PMZJeE1Ys1I/gOnGP1PsLsi0f9doox7TML3dLnuDjdCx?=
 =?us-ascii?Q?t1HhLR+T3cYGcpFC/8oACaj7c1xWdZW90ZVsUzOwDBZBtcS85wOYlFVx6pAK?=
 =?us-ascii?Q?jxyYt1v4YRqkeC8cNhU83VCzyYuzAF5oth3q2nIGEsMvhv/OZSqaPdLaDVNt?=
 =?us-ascii?Q?qP/LbqwVpGBFWt4MQLBezvs4b5vVRd2gXne5MP9tpNt5anQLsxqmzlR8xPpO?=
 =?us-ascii?Q?2JRhapwVS7TV2ZPxoNdIHbwNL0CeiXpYCxSY/YS1JeEmC3Zr8pq317wgFaWM?=
 =?us-ascii?Q?f+XxHQGE/CTw9H7sEAMF4pDlTpJdz4FHuyzUwt5NFZT5rtKrPzflQ9Qb5IuR?=
 =?us-ascii?Q?MKu/eZEsz7OlKg/jPM/QB6NJAmGjsGIZ/VyWHaBK/lu/yscJrMPUmZhE7Xpn?=
 =?us-ascii?Q?BFtVjCX1u4Oc2KqoqgfPkzPzsmBaEowkvg6ipCbekBf15d/0YdiGzKj8rvGo?=
 =?us-ascii?Q?MIKSix+FE69AKtGVQgmCw+Hs8SMFw5Z0KFym5XXp55sJHYZkO6OVr17i545G?=
 =?us-ascii?Q?VWwHm+FMm/HkC3qVtewNHlPh87JAnC6HSh8elRvMXk5myq1JxX7l6LHtpgSg?=
 =?us-ascii?Q?vNZQaHLy9t02bbEtRYLKLdH8zvsUOMn63Ag/h5qBDjEj0vLg9WfWKa+9of3b?=
 =?us-ascii?Q?2ZmD+ysSnmsV42fQdFXQNR066bzx1foRsI6Bqw3fpin3glFI1Z8rHITCNCga?=
 =?us-ascii?Q?LSHWxRrs9msrS0NUQPNfobQu49fR9FKfbV19eCYeZAWLRJtpqcvgfs+8KQYx?=
 =?us-ascii?Q?7kq4M+6WhYqc/NyVvHwP+XXelpNOu0TZwEE7+GZoaDpUgnOFzYhduCd63T1v?=
 =?us-ascii?Q?zMYukMpNJj1g28XgFZyUnKaWMn3fbiqd2QKu11wCDFQ4f/b36i1Uyye4HiuH?=
 =?us-ascii?Q?+2K1iJ8PAj4UEyQT7wjqznJrSXG0sQce9tdqJ3/LfiQPuSAyMAwMo1fMkcR7?=
 =?us-ascii?Q?6Hiu8+c3QIDiV/G2dJK7WEe4wm1dtFHABAyvumx1lTrULPPDDmI9BadWsHAI?=
 =?us-ascii?Q?VB8jmpSgWoEGNrnm43zTC02W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d84f902-3d7f-480f-d8ee-08d95bd16fb2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 07:35:33.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aobhE3Qb6uLg1c5GZk+GPLLUgjxrGlhmTQC4d+lQP+5zbaj7+vAr8PY+53DbhvxW0p+TKAVDdCHKkbgVJF6fYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6793
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused "nvmem_macaddr_swap" property for FEC, there is no info in both
dt-binding and driver, so it's safe to remove it.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index d4645fb87565..6b1883b3560b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -947,7 +947,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&gpr 0x10 3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 4bc250682dc5..14fe0f766d5b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -950,7 +950,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&gpr 0x10 3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e4d879d82c28..5baacb83e2f0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -815,7 +815,6 @@
 				nvmem-cells = <&eth_mac1>;
 				nvmem-cell-names = "mac-address";
 				fsl,stop-mode = <&gpr 0x10 3>;
-				nvmem_macaddr_swap;
 				status = "disabled";
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index e1eb8fa0d348..c4e107061c89 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1190,7 +1190,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&iomuxc_gpr 0x10 3>;
 				status = "disabled";
 			};
-- 
2.17.1

