Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FD43DA072
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhG2JkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:40:02 -0400
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:48358
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236209AbhG2Jj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:39:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT1k8oUerJF0SPPip8RDZd0XKy3t8qsEZF0v60Tj3433WQjJvFlYFA37tFmnomwyqjwFvUyKx/2qK9TRwYZiEsLxumb95TOBF0Bs+iMRAaT9DclgCEuvLIyZYT9Zk5UBayJC40VukBHfJqwFCddZU+QhAUMGw/ux34MWC7DSwcakWcZBzsp9p8cQSnVz7Ks4uYTC4HkZkl5O1+WQOh8jqWZ/nTp6Ji1Zqpelkm1bseGtkcUfBsBvRDxjaKSLnqhdtBrbotQmkL8O5NxCfcWa0kFv5FaAjQXmGRF011VRrNavLL/II6WtA8vKVXZZVJiBCBNVLt4ypus3zKUGKkKeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hSJS0PEz0nkwiwguedeCZqn0gRUmyNjY/+ynYYIiwc=;
 b=IXmZiph6UCLnzW9cND2+/DVKZ8ullDK8I0VH4NciH14cWj0Ky6VjHR8HdgV9SnmxSDpneI+8sD0DP7jc12wOp0fDp8p/PmZSenX36GzSJZkRfr5OZVZwDSrDL2Yts52IPFHxakKoxakP2cH3GOc3dxLh+c6QX0C8Dzvt5keHbYGDcFDWVMSSXKBW9kpra9gM81zckmOGnkMwvgYUZkI6E0JNKeLuxfFdPgASMJUciZx3jxqiIuc1NBtpeDGrw35eCaviYmC1pIaa8VTZXO4Hdm21t/9xt3PPIF9n/48sMNOxPt4xauIEmqC2UhrzgEpIDvbCNXCCOJdBlkQnFeEXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hSJS0PEz0nkwiwguedeCZqn0gRUmyNjY/+ynYYIiwc=;
 b=IhavrHdOrq4+KAdqmQFt/UfgVbbvDqoZiWzhOtUnAhqDzrGslyAewOrc0Y8dh9uVbGM1kc9psS8+M2qsx/8pftkgUBwuWMeG9jMd4/30IYqsNnw0XE+nbSlKU65Dk+lZMfeq7SCwcdVECx72uKdOrFFI73xOIif+WfN+0uNWjvM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB7PR08MB3548.eurprd08.prod.outlook.com (2603:10a6:10:4d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.31; Thu, 29 Jul
 2021 09:39:52 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4373.019; Thu, 29 Jul 2021
 09:39:52 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: rk3568-evb1-v10: add ethernet support
Date:   Thu, 29 Jul 2021 11:39:13 +0200
Message-Id: <20210729093913.8917-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729093913.8917-1-michael.riesch@wolfvision.net>
References: <20210729093913.8917-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0018.eurprd07.prod.outlook.com
 (2603:10a6:203:51::28) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM5PR0701CA0018.eurprd07.prod.outlook.com (2603:10a6:203:51::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.6 via Frontend Transport; Thu, 29 Jul 2021 09:39:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bfdd051-8789-421c-8c7b-08d95274d085
X-MS-TrafficTypeDiagnostic: DB7PR08MB3548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3548C021E9FB7479579C3231F2EB9@DB7PR08MB3548.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1X7NtbXT3CXxAlZIRwDCHFKyBRrwGsesesMwlNyQTVRLVEHI34Ok3k4mcVC4W+/5BpV1A/YgiGJ01eeWmiPueYJmBR/DVZom5BAN137g93oboXxIxow9uoxzbt5P2YbAl7YN36uCWmeqZiDiMF/IE4rV/70DjHWq2QrJ03mGgcn8ZBybrwoHShpFLjzjgWMDs2Bxt9pPLzNhm5rzW/k8ImEqRUlVKzrIqZ5gjnAXQ3+dY+/bHiQGQpSf3G5SU4siipGCFnItVngOVFHnRWjIxcVNwvtexod8DHXia2DEsO0CmR6uCPLe2nGCRhteFDdd8jqXd5zw+DX6NIEf8MRxebKYRO5yyuePOcsbBxpy7rvq395X0OgaEhratfzqW2UabfJXqwboqfpe7HF/dWTjypz3MQjHm1G2Fp9qpUrmxc8iTHCf2306pJuSaV2GHHbMX7J76BxOTgSbHjfzj2AqEpRCsN+23wd9HFith/NveInXtpPARkJ9/keZZp3mHcrvQGpVhfpQSgBWRovadpQnayK5QvUaQqb8jk8nefPiADwZsTtmWXXyD3Uzym5rxIXlFxvOEAdZZOvSy3G8mmEAgHXdVMG7K+JoaiupukVCGxlcsuXrCE9cltdZq7cftc1L0f9fDV2x0ZY3AXcATS7HZtNBYp4q1gds6GXXRQJKnbD69xk4mtOaaFHuwCz+pTlRbKzuASCrWh7e9bWR6o0uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(366004)(346002)(136003)(376002)(8676002)(52116002)(5660300002)(26005)(2616005)(44832011)(316002)(6506007)(54906003)(66946007)(6666004)(66476007)(2906002)(186003)(478600001)(36756003)(6486002)(38350700002)(1076003)(38100700002)(83380400001)(8936002)(956004)(86362001)(66556008)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gPO/BitUk+/Zdq5nhTjf6pWmSHd9tWd70ZB8kuIEASZM8Imp8ngatE6Q5q4K?=
 =?us-ascii?Q?MznILaK0aknJvd3GqUgWgjsz0mJ6z39h4H/dzr5zvKJB1ZNJSNgbbgifyw/E?=
 =?us-ascii?Q?BdtGkAeN7h5gJsHidWHlcPIgBOZjiWccGKahHYLM6AoAGdPA2Uv05kBjA68W?=
 =?us-ascii?Q?7jdo87XSxutOxX+1/fmZWC5RvqD3JSvtiGb81oMYyjemtJ+uOEKTwcboCNuB?=
 =?us-ascii?Q?v2v0FFi34+r9og0NuN/c8BNOTB5oyog/LUfuBexXpcuciCF/E55NBhZ6jCWu?=
 =?us-ascii?Q?gyjRJQP5q6qX9RVivYBLz68JjKLBtUPsz2kp6ztipQqYXFegM3izKqosIOlk?=
 =?us-ascii?Q?LqkbBYXccmBGhxcG6SUPmNSEc0SSbgYxFSwXADRu3QC0+/7ze3w10Zbj5gXr?=
 =?us-ascii?Q?wy1YrWnw9YFJRf3A4fGGWVCda84ZeG15eIbLbrvixF3c3xKmXWOz30ZUE4E0?=
 =?us-ascii?Q?rhLkGigBJTeyOBkbKjx4GBXMRxW5EOe1p+7L43izpUSHobdpp4L7+Vu3ZfEj?=
 =?us-ascii?Q?zVPIQRx307/TBsMjGOR8on2ZQx/U8dfBOlgRgc8unYkw0trMmcS9l/mWkigq?=
 =?us-ascii?Q?A3rxE4gL/vZrgWHc5K5JKFkb9bwujIFv3E9GNORxYyD0wrPuPkrOrrzPg3qa?=
 =?us-ascii?Q?cu1MwzbO6Y0nxdkQIekpolSlnxNclaz5DIy2R+Cn0Em63w90s5/ofY6HbMI+?=
 =?us-ascii?Q?iKpfZaXVL8gvZCw+B1yzO/X8I7JMTD5FrwuhETP4625BbWxsbHkjtWyY07VJ?=
 =?us-ascii?Q?jIvH8ixA7+xcFXzVI6ImdX9AVmjz/SCc2PvBohD/Th7sjmee+paKNr1j6T1Y?=
 =?us-ascii?Q?YbU2Pe7A7j+yP77lMN/QNKH22IXE5wcDtDbnTa7jEmr5jkMfEft836sXO3wX?=
 =?us-ascii?Q?F/wZ7Iu2PhvPdAyxdaV6i/siQtCuNp1iT5ZJkael0MUC/1vPPV9QgdvOVijm?=
 =?us-ascii?Q?M/CtP8QVSnJwxP1fPJL2nqOQZLXogxUDjknMU5AMiKI85Jbij6BGYXDFu6Xp?=
 =?us-ascii?Q?EUxrMK2JAn+7b/Tx3zcND8wmvcvb69dRH7O4V4NuqzF+Vypop1F2YVvGZpg3?=
 =?us-ascii?Q?gAsI7sZfbayhUdro0Myq9OcI6VKux+tgbtTecDqSuIYp+ln6pwPOA1YpeRoy?=
 =?us-ascii?Q?//ADBQXqDr1DgPYD6grSdX7sSIZWUP04d0tQZK+qhqIRHuMQoKkKUKnGFTli?=
 =?us-ascii?Q?AUXlYh/P5WJNi8qGYm3+lNGlW05Tn5h+ztSYu8yxjSWiO1QC0DjfSxQGDbo+?=
 =?us-ascii?Q?arFIAvwr1EU2ka8+VkdJ8Zfs6aIuMQIPgAojV3GgJgtXiyMwPqdAN9uKvSE9?=
 =?us-ascii?Q?cYxxHJhscquLRowijFBHb1i7?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfdd051-8789-421c-8c7b-08d95274d085
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 09:39:51.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pBGUMxMDLfQEFAmwsfL7u/CsPWQnxBwWcUr3/e5R4zMps928OTzcKzl51cp6xRUP87kcPJ96LHAPXoI8HMEZ1VQEUZrUmj18pm46itDYh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3548
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v2:
- sort properties alphabetically
- use phy-mode "rgmii-id" without delay properties
- rename phy nodes to "ethernet-phy"

 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 69786557093d..65e536c78d2e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -13,6 +13,11 @@
 	model = "Rockchip RK3568 EVB1 DDR4 V10 Board";
 	compatible = "rockchip,rk3568-evb1-v10", "rockchip,rk3568";
 
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
 	chosen: chosen {
 		stdout-path = "serial2:1500000n8";
 	};
@@ -67,6 +72,58 @@
 	};
 };
 
+&gmac0 {
+	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
+	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim
+		     &gmac0_tx_bus2
+		     &gmac0_rx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus>;
+	status = "okay";
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus>;
+	status = "okay";
+};
+
+&mdio0 {
+	rgmii_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.20.1

