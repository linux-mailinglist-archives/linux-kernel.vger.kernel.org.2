Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D754F3D92E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhG1QLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:11:30 -0400
Received: from mail-vi1eur05on2057.outbound.protection.outlook.com ([40.107.21.57]:32865
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237352AbhG1QLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:11:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQsP6M15LmyPXZMAX30UZJ58MwEak9a81hDJKVzkN44qgjGKm0PWuCGoiWzHd6jUfdWornZR3IKBJ+1QU7MWKDEEQQCNoWqnz3SXnKRIofaG58e224Za91MTMGS7NfyjJUN1Up+x5R7/nYHWQ8XpJQRt52ocxFjcVRWX2owsUAfD49jJ/BeKRC8pOaq3LM22iDgOECVJePS80gcVRHZbTSj4VWlxlBDPNQMXaHbPTmt4zoLchG1HcaNvVzl8bjv8Uf6ix04+DOact49vI+Oyl3NHIn+IfrANAbjEi+ew/+e3YieRmErrZJqO7GLbO9aGKaJ9PyxygmK5NW5nAhDsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4A+99w74vHHvuLhnKCXvOdyjtkacxEou996/BWDRWY=;
 b=aegnItlx4IRed0ojAx/qcwm5UM4FiLdg6bQmkpWBUooDimO2z8zf1GBMvGMqyk5Qg9wfqqoh35Na/RJfRC0x1vzXY/wrRBheBdDaaIIbeTX0jywnPPKPpEL27SRT5D1oVlM2KXw6TFUvwYA27oS+9gfn9bhfvPaC6c1T4VIrPF64UZ5n3FCIIUxFQ4oAQRCOuCulTLurToYltVc6JRvsGE1TqHHERrSlbt6CdlRcXbex2UML6sKSgGqd9ZqaGgxkBqWRvDi9AoYwkKhNDFZRyY8DiRfEQiSI6nER4S0m9pBeegtwMtfiM6owF/7IN3IJcxFU1nkNBylBP56InIBsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4A+99w74vHHvuLhnKCXvOdyjtkacxEou996/BWDRWY=;
 b=Absh6Gi/JQ9FDYu+740hkSlAjuz7S62lNAJEHF1Vi8+R4HF9DEUD3ohra/r9gVrEhci5peUSJJPj0LFOTmKlY0WxBesUlExAKVsd3/x3C3SYMSKBmDYtnz6CM4aywYCSu9KENudXXTdQDg777/ppXMeW1l9bTKs5oxfhmQv+obw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB7PR08MB3195.eurprd08.prod.outlook.com (2603:10a6:5:1e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 16:11:19 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 16:11:19 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: add gmac0 node to rk3568
Date:   Wed, 28 Jul 2021 18:10:19 +0200
Message-Id: <20210728161020.3905-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728161020.3905-1-michael.riesch@wolfvision.net>
References: <20210728161020.3905-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR0502CA0068.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::45) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM6PR0502CA0068.eurprd05.prod.outlook.com (2603:10a6:20b:56::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 16:11:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac6a3a32-7d0c-4da7-46d6-08d951e25585
X-MS-TrafficTypeDiagnostic: DB7PR08MB3195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3195633F41DEDC91008A816AF2EA9@DB7PR08MB3195.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfmMoSzsMzm/0BaTqmXP7H07QKkthxqT0qTSWWXh8tUTqcfokbFcRo8My8lm9/o6NNSvK04x6o4rjroh4thnHwHs37ed+Dr17yFqgiP2sym4vF7W+QWFMCeoTvgYjZtGchHLrwLKBD6SX3w0+L6vNcmCxebfeC9dnC8gl7QBU2/I+PslsFyi+xg848FLRWT75Uh3yx15TdelE1rmKC1VwiNoLV85v56Zq7XeK6TDR9XutxDOj6WU9EoWvhdwo2KPVQetFesbHGP4lNaWdBBQkLfckqOTDf6+eiSk3o3PhtJNbdee+LkNEm6xJZGAhALQMeXtdP0i71c9nV55ZiqS8QCsUHXQ31aCIq6OMITTKOMO6SbLPIlyCSg8mx1Yog3pHs0wdz/g38mIsufh1gPtpYEnP+Q5vub0D6yfxc0sOyIFHrYYUmYcg/C6VZ0Rpph6H1PKqxmvELMT+qOXL1uoWT5TWpCKqFzZnkF+jCGzOgmXdzSvBIVfbu7l5t5SXuD5vbKp3zidqaGK2ZgDhVefoUMtlckQrviUB74mAwuOc4xPWv4hHZb8eEc7jke1pvRunaXX87ioEAQ6MhmtqVEChtgCd5oKTsw+JN7cnBPFKe9VC4l6lhlSDYoxX229xq+mxjBbmlB15OcOl2A6nHB67n1u/LetJQArfPnzoytua8AcApIlPc9v+rWQAMXfW34Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39840400004)(376002)(86362001)(6506007)(66476007)(66946007)(8676002)(186003)(6512007)(5660300002)(8936002)(6486002)(36756003)(316002)(26005)(4326008)(83380400001)(2906002)(52116002)(54906003)(38100700002)(478600001)(1076003)(44832011)(956004)(66556008)(2616005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ureM1xIV3aRaK7sHwXE+0OFhxbr1E7tTS2Bp3K3M/ChgzxIlDnDdxYYZkkPW?=
 =?us-ascii?Q?BxTW9dodpC6/XyPZfFoaCO0uBtlolMYGtgk5Xq/oU2MWnMK23HY2sno19u33?=
 =?us-ascii?Q?vj2Xgneecz9pBM56aBjpRdROjiODJ4vI4qULux9Dk8M1Mz8gOeYXol5DQZYa?=
 =?us-ascii?Q?zZgeaSFiAJ2kH5hkQOa9kCu/+TmzxZ/Yw0TexsewMcrltfi6uGf++gozx5VK?=
 =?us-ascii?Q?wxRv7l8JBet01MgjI95Aq9zvQ5SkginHQuKf9KfXS1Sg1h+43yisPFq6v+wm?=
 =?us-ascii?Q?81ZK0IRWQU8oPlS2Mbyeal9Tbbj3XrqvedfD8/vnBBCE6OM/wCoM6EQLrHqL?=
 =?us-ascii?Q?rG7vQeRhd2mJ5CBCrVcQfKlClLtm7AIJwDAZ2Tv5NzQs/kCROe27dFajM2ZK?=
 =?us-ascii?Q?MjQkkALdpSOTB0BnTEMLTyCOY30p4sIPcHbJeGMvu8rVkka8iQWqyhyAD8aH?=
 =?us-ascii?Q?MfuRA4Oa2Fh0Z223hlBimRBjbImRQzNhkI39R8nOyRIGyyg7IF0byG8GytCL?=
 =?us-ascii?Q?Q4Fyqki4stZKOkDvBRcR+E5bh7fAjekvYhixfmRplT8TMNX9zStpWXycjPxW?=
 =?us-ascii?Q?tkT30D1aytLJvNAevxfHubnFlFLV/GkXMdUSUqssZ4AsoIHh2HwtTFzLIOVm?=
 =?us-ascii?Q?7KIFj5xnKmAJlmkBdxg2hIMHzpZTzAKthyhvMM9PReTKih3qa5LuZ0FMKCAI?=
 =?us-ascii?Q?xfdxX1EttOcC1Z8Scj/8pJeMhXrztufvIqM6X1KrCsK/LVBQcYNoDKUkmb88?=
 =?us-ascii?Q?TN7EQkGqGlk52clnFO2fjJO4nEO1tSXnToHCROqQKb5s+DkmlCsbIM2KzJ4r?=
 =?us-ascii?Q?asQghptsvV/eXFhxnM2zSWmHSkBHTaVGnCW3tf0oAUJxD++3dSj7HOvkqf5N?=
 =?us-ascii?Q?Mocypmr1+onfxKAQv2PbgTt073JFpq+fTgrxcyeO9SVzgFVlVIoWAJeKpjqO?=
 =?us-ascii?Q?/+XI6KvHgm7rGAaA9ssOjfSYfSMkBqWs415lXUKjnfUwkLQNvkRkIGU6oPMv?=
 =?us-ascii?Q?fvF9wMJv0mQ7sNZzr/u+GfNNgutA8H8VPBpkXW5dYtLeo7kcyCHWpIDBBD6q?=
 =?us-ascii?Q?BiSizoa2I+eCi4IRp0JhnO7wn6FGUM13ZZDwDvHTlQsUqvHPE1aJ19Lifsw3?=
 =?us-ascii?Q?n/9VGmLVQgQoNvvkoui8SXerdv6JFSEMT8ubJOCEkir2ygOnc9wXHM1UOdCs?=
 =?us-ascii?Q?vllNHvX3Blo0qcpsCFnB7rAgFI4YvW2FAS5p1bgMqt8HU7hB+RqmKBBTQ5pd?=
 =?us-ascii?Q?wF6EssDyPg58okQq7Huk2vzjtCWxVnqC6xkv6CEc64U2p1ztOci7OanrmFTy?=
 =?us-ascii?Q?YHjPQdZK55srCdq82OsyETUV?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6a3a32-7d0c-4da7-46d6-08d951e25585
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 16:11:19.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lquMnBzQmWkt3MwKRJSV5o+53mAi4KM2a2tJTLp86rGY2+B3Ck6+Lb9vfbrymfJgeQqvLIHOP3vRosZEjzb09yDl3hlUwbkxa6IiZOgGTiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While both RK3566 and RK3568 feature the gmac1 node, the gmac0
node is exclusive to the RK3568.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index da01a59f6f26..ec39a2c593b6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -22,6 +22,57 @@
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe190200 0x0 0x20>;
 	};
+
+	gmac0: ethernet@fe2a0000 {
+		compatible = "rockchip,rk3568-gmac", "snps,dwmac-4.20a";
+		reg = <0x0 0xfe2a0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq", "eth_wake_irq";
+		rockchip,grf = <&grf>;
+		clocks = <&cru SCLK_GMAC0>, <&cru SCLK_GMAC0_RX_TX>,
+			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_MAC0_REFOUT>,
+			 <&cru ACLK_GMAC0>, <&cru PCLK_GMAC0>,
+			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>,
+			 <&cru PCLK_XPCS>;
+		clock-names = "stmmaceth", "mac_clk_rx",
+			      "mac_clk_tx", "clk_mac_refout",
+			      "aclk_mac", "pclk_mac",
+			      "clk_mac_speed", "ptp_ref",
+			      "pclk_xpcs";
+		resets = <&cru SRST_A_GMAC0>;
+		reset-names = "stmmaceth";
+
+		snps,mixed-burst;
+		snps,tso;
+
+		snps,axi-config = <&gmac0_stmmac_axi_setup>;
+		snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+		snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+		status = "disabled";
+
+		mdio0: mdio {
+			compatible = "snps,dwmac-mdio";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+		};
+
+		gmac0_stmmac_axi_setup: stmmac-axi-config {
+			snps,wr_osr_lmt = <4>;
+			snps,rd_osr_lmt = <8>;
+			snps,blen = <0 0 0 0 16 8 4>;
+		};
+
+		gmac0_mtl_rx_setup: rx-queues-config {
+			snps,rx-queues-to-use = <1>;
+			queue0 {};
+		};
+
+		gmac0_mtl_tx_setup: tx-queues-config {
+			snps,tx-queues-to-use = <1>;
+			queue0 {};
+		};
+	};
 };
 
 &cpu0_opp_table {
-- 
2.20.1

