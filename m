Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2756C330CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhCHL4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:56:18 -0500
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:36896
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230202AbhCHL4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:56:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM4ue8vFKIDbcWyQTl8P85SP6ExDXC9uDZ9M9EaaMXi6fh+2dMfdzj7x1+8onRcqWD4J4pNknKKVSofo/lLtbHpmPcjIYAl+iZCPFcyUa8uxauizDHvHgJjdCELATPyNdck5MvcRtlsE/pkDb1hbKAjy40YRnhPIEP+mGVWH1c05pk+avXvQ6tTJ4lkxwfz1NIAPzZktyJ7ufPJtaW1bwiYvz1Q5UTt5J3ikKwkKbUyJgUjRdzrMpH2VcVfnwzsYUMyE5Ncj3Ob/qR+TeGyICT2BY7LA6/DA1OS19q9GgGi3WqahoogdE10Q95Je1NXNsMO3UlQt50yDrplPPsqkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaTihwk+NTIdq8n1xCImVtV0fO2ama5F4xsr1G3lC1k=;
 b=BJ+L+iIYMSTGJbNrdEmPP2L1/y8MS94gNnxBUezNUcOUaiIvJwMHFBqmrj9gPmzxCostys3bJt9drECPfExUggco2JTmQIdTj3Z8v2FTB9xYgP0dZNj56ZVqKcHd20FoJ03kQNdeteSmbGV7qJzyGg+tYWikcYj6JPPejTkLBNCrKupYmGzf+6vWQHo2WqZVeTaRn930tAIx4bwSwe2ET6rBIcmTvbhD6pdwNi/4J4oM+xcdjfcF+q/P3ZMW5RxetUfjXsm5wJaGoOrk94/5Lepg/jJkl1DKMvXSao0gwp/NuRjT3ZsTpAh0+Uqx/d0V1rO5AsfqXHlxq3J6OQXh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaTihwk+NTIdq8n1xCImVtV0fO2ama5F4xsr1G3lC1k=;
 b=BdTXIt/mmCmSs3TwW0ntYDkZXF+krFr0tQOn4zQqDmoqZSfoR0QjlrYvS4ViWCnLBlH50Cs4J3LLVwSFWCOpjTENV9OLZm5zv4v/UsIEce3gwCbQtWp5Vhuut8SEjQTgK5z6gJTe07sUHYSUd2PgN9iXNLkFKigzVff8kXpK2hs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2149.namprd11.prod.outlook.com (2603:10b6:910:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 11:56:04 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3890.037; Mon, 8 Mar 2021
 11:56:04 +0000
From:   quanyang.wang@windriver.com
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        quanyang.wang@windriver.com
Subject: [PATCH] arm64: dts: zynqmp: Remove si5328 device nodes
Date:   Mon,  8 Mar 2021 19:54:37 +0800
Message-Id: <20210308115437.2232847-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by BYAPR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:74::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Mon, 8 Mar 2021 11:56:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ca7ab25-af4f-413c-839b-08d8e229268f
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB214933EC1A9E8BA0523F9ECAF0939@CY4PR1101MB2149.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfpLkJiB7ryNK3g0p9tG0jhvBiLSiHy5aujYES/nkod3ftPitgIAi5NoWiuBeuQ4oHryrrXbtWP9dIfPyFKfghjuAs5x5qLWAJZS7zllxS0YHvG+ruCuKLJ8RXbeGQfbYIOKv4wqjDrBtHbvEBq9M604ml25mUyOTPMukbRqm2R9VwP+l0jRbK3eEoVZfoGy1W9yWvfF3mxc6EoA/Embe1i3liG7tLGHJgE74ldnNyaowsu/Zgugo3G54AYdA7zKhcDMfF+rze9tmndXVjZcFGUr8PuwIMXt4QSO+FnKchu19DhKjZqyZXYeuwNsu1kUSk1WggpHmhdLlJ8nZ+Jz+wbredSRmXt154UNgGxtDmpN9AjUk4tuPH3M/cmtgGgRXmqrJTZ4zbm+pCA/yuFZgp0x/rGFXvyJyWtoSeoXqfL5XcWH73OU1jofDrbvz6m0LIXhtOXBF0s4EbsPxH0EVoYeTXB8ATAZ5sFO7aFaouPlAc2DkxbBy3yqcc/Iu3JUbzTM5zGNZbtRvgsYJ9uHHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39840400004)(2906002)(4326008)(52116002)(6666004)(6506007)(2616005)(83380400001)(5660300002)(478600001)(1076003)(6512007)(26005)(9686003)(66946007)(86362001)(16526019)(316002)(66476007)(186003)(8936002)(66556008)(8676002)(107886003)(6486002)(110136005)(956004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yYdynz7fsciHF/n7m/eAhxhze/eLg4ZFnMDpN7P8uFw2cj9uvaH5wkzdEYV9?=
 =?us-ascii?Q?TKWLIXC41qZ61sTKOlhzJmEqZFr5ArZ+qO4ND8J8rhoP/gQ3B+HqrKs+YPVn?=
 =?us-ascii?Q?677P/Iy6SnCzxD90Pazr0VK9eZyOXXjwoIGkEQA3msDEPdLfnLt+5r3BXuHR?=
 =?us-ascii?Q?9ihniQ2zsHYTlqUQQNFLqE/G64+arIDC1R7OrLypg+sGEKoiLw9GZ+Sg0zdS?=
 =?us-ascii?Q?daKjGknTNTYg9kjatzs6Dnh+sfC/u1ac9BS7tCAQhxostGZYAiyUfbNWnVOQ?=
 =?us-ascii?Q?qBJ2eark7NUrdjtYH5TzYJBOrH7DCWzeQ0oya+bS4LH0G4rkTHtxQUjB3O6m?=
 =?us-ascii?Q?tEAzlOzAuehUzlk3ZgyWffP0fHxNrVRu1C5NIVYjcKvrxQoVzDpCmq3fAXpG?=
 =?us-ascii?Q?jNYQh7/uzkohmoE48s7HVP4ZKLb9a93OKFIyOtoSEcTPfmCYlZkmQRp+cSRq?=
 =?us-ascii?Q?GkD2WqMki43ozekBZ+Ic+oK9X0AwQG48th7AHEWz6HqxtvmcSmopetkfCD7a?=
 =?us-ascii?Q?JKSLI2kbZPueAO9mk5QO95IkMCtRfF+9RX7kD8Lmd/CDyOPClpx/uI6jE09c?=
 =?us-ascii?Q?WB0XaJs+Td5WIvlbZmAfAkJ5AkN4z3JPbs4Oim7+Iuu6NXEDaHKgC5845SZf?=
 =?us-ascii?Q?PT72D/iP+pA1P5MT8p8Y+uqLhYxJUnjGJG7s6F4groFy1qZRWn5dAZxD8lN6?=
 =?us-ascii?Q?HNiEO9phOtdCM8a++wNBDutrmFUL8RwPTHQVVzNtzDsXWpnGwYxiERFIDUzq?=
 =?us-ascii?Q?MPCGWAaXpfFhAiOhYhnwz7yvEViA0RLXaGpIUgAMV1XlhBqg9LNqqznXKZs0?=
 =?us-ascii?Q?7P4BL0AyMPJRKYDTQ8sALPu6fXotZn3ORdvcd0E1U47kdAMyFP4XLWBRz7gW?=
 =?us-ascii?Q?zVwtFzWXovdtIHaJY7cyuWKMu9gfoGt2gpZpBOvQ1Io6P68E1sKlotjmj9So?=
 =?us-ascii?Q?fa2cnJoBFbnsLa5QBnmiCWunAg/xyU0ZAB7Ya0m8RQA9tvbQVE+Jw789VQbH?=
 =?us-ascii?Q?qBOK7KTPPVJbOvoWbznBqGNYM0nsmsR3rc8peqk5MxLpDPEk5nTDPuSCf/ai?=
 =?us-ascii?Q?aVeKARHSHLwvyABXdlEMYy4QJAisU01zYOL/CFyG8/D/aJ2vhb0CXhvDAAE5?=
 =?us-ascii?Q?+DKGrEIE2wU5JTqPgwnYFjSVcLuXstl77eD3X6Zl6/bp6CtA7AIcH1qvrEoO?=
 =?us-ascii?Q?iwM0Y63WgcBfrCy/KIBqWzfThnHax1ieuCQhgvy4RPZAdrc50NQn083FnfPr?=
 =?us-ascii?Q?LsV9dVU/wswha5gndElAw5LwNpfcjF/1X9UeH5YOFmjnV2D72ORsl7I2fgcO?=
 =?us-ascii?Q?Q6PmeNWv5rElHsrt+n9fKaKC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca7ab25-af4f-413c-839b-08d8e229268f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 11:56:04.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqCerdyHe2Y8XgDsUVIbzixEztLrppAV663JVH5HeDb97Fr1AaA1/VJDN0mLNW4onhtKSqEGV17IrBETXx4Gp+5oQ5YDLoTE+PXWHKUNN9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The function of_i2c_get_board_info will call of_modalias_node to check
if a device_node contains "compatible" string. But for the device si5328
at zcu102/zcu106 boards, there is no proper DT bindings for them. So remove
si5328 device nodes from dts files to eliminate the error info in the boot
message:

i2c i2c-10: of_i2c: modalias failure on /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69
i2c i2c-10: Failed to create I2C device for /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 20 +------------------
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 20 +------------------
 2 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 12e8bd48dc8c..eca6c2de84a7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -580,25 +580,7 @@ i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
-			si5328: clock-generator@69 {/* SI5328 - u20 */
-				reg = <0x69>;
-				/*
-				 * Chip has interrupt present connected to PL
-				 * interrupt-parent = <&>;
-				 * interrupts = <>;
-				 */
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#clock-cells = <1>;
-				clocks = <&refhdmi>;
-				clock-names = "xtal";
-				clock-output-names = "si5328";
-
-				si5328_clk: clk0@0 {
-					reg = <0>;
-					clock-frequency = <27000000>;
-				};
-			};
+			/* SI5328 - u20 */
 		};
 		/* 5 - 7 unconnected */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 18771e868399..eff7c6447087 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -581,25 +581,7 @@ i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
-			si5328: clock-generator@69 {/* SI5328 - u20 */
-				reg = <0x69>;
-				/*
-				 * Chip has interrupt present connected to PL
-				 * interrupt-parent = <&>;
-				 * interrupts = <>;
-				 */
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#clock-cells = <1>;
-				clocks = <&refhdmi>;
-				clock-names = "xtal";
-				clock-output-names = "si5328";
-
-				si5328_clk: clk0@0 {
-					reg = <0>;
-					clock-frequency = <27000000>;
-				};
-			};
+			/* SI5328 - u20 */
 		};
 		i2c@5 {
 			#address-cells = <1>;
-- 
2.25.1

