Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8607F3DF510
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbhHCSye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:54:34 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:5700
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238389AbhHCSyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR52tUr01PidXxCYDZexGUZE3HhfGMHS+cf9Egg5IC7IaT4BRW5eeLlbpfekDEERPqNB05E0+Em6zXDfnX1yOg3ipeCoo2rQeMOm82aeLtoYgv+99Hl/2HITdZZ0N4O67n3PnqyRJccz9NY89e48y6JJV/OdFfWGAVGP39y4utTip2U7wk2TiP594mE34tuPhnGUXBudhUnM/sa26UfeLOkAZ1LZinEFjYPqbgOZnlpcsmINqIYe/sszDBzI9XZWIANeEl9n1Ruydo1LthGvJfmTHDl++ZoS0EEF1UAGm8DIhNCGiRkyVCNS5fRZtgAIu9LOZmqskordEcrGi0VrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QeObz3KBwdIHIYXMu4xxQprm5RqW5+Aw60EcvG8ITk=;
 b=ZIcIshqn96FdhCbeqcGbNXcRWHwujUE8isQM6HKMgOz3bHL6RXdAOQDqaY53H0rpwT/Eil+c0mpVzra57PFl/VSeb5qa8s3zTXTvX7/9LZ2RP6xfHqAlMV6g2ereL14S99WSi5cHqT3dqHsEdnqzZBgIyaMqrwyfEfZnapEdNubrg4kidY65xiacbbYm663ZcV9Bz5OaUwgW9gRjIy3D4im6iqqRKhHVazJQeUN3Y/H56A0amU0lXFGoI6o2G22VfZQOxUONSzPP1N5NFrblXV2nkJKLQmjYKQP9/OdEEVHSU/tDWYKNJlviAf6U7eDl9h+QDhPgsV5nByrJ+68qOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QeObz3KBwdIHIYXMu4xxQprm5RqW5+Aw60EcvG8ITk=;
 b=hGgSRz7L0BvrEC6j5nEtqkCBwmqRdWypmZS4ml1ub4KFMKP2UmrS7I4yszuRnqMnoUk7x3KWpQm2OTvWKhzYdJg991CwGjpng+j++1m1j+BhLPlFh+we7hK/rXhnPjK5rnLguD921/ejYg9x8sVa0ihVyNopfjriDbxOJDgBGUM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB9PR08MB6921.eurprd08.prod.outlook.com (2603:10a6:10:2a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.24; Tue, 3 Aug
 2021 18:54:12 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 18:54:12 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 5/5] arm64: dts: rockchip: rk3568-evb1-v10: add node for sd card
Date:   Tue,  3 Aug 2021 20:53:09 +0200
Message-Id: <20210803185309.10013-6-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803185309.10013-1-michael.riesch@wolfvision.net>
References: <20210803185309.10013-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P192CA0019.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::24) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by PR3P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend Transport; Tue, 3 Aug 2021 18:54:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc39ef0f-7272-4acb-f071-08d956b01546
X-MS-TrafficTypeDiagnostic: DB9PR08MB6921:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR08MB69216EBD424FCE2B4D1FE091F2F09@DB9PR08MB6921.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8vo7D0tuuf5x5YrpkgbbX9pF3/+uOtv3lyqfmCE3eAt1NsrHs3cUb2Mdqm6so73n9Ny9Jd1LxrCIFq+Wuz9TMuw3FmcNMoBw3ic4U9km138ShKhx4iUKle/NBh/qm1DK1IDDmF7taY3Ampt+0Iy1abawChKp/HDoRIvmbE8jl/Oqbhi/i88asij4N+MF2NHNHMigndBbbJyq2ZAOC9twgUkdusa96uVlylyUiDQvfrmQnOODiN220kQ3UQmTBJFj4KGTxKYzmFniXG3fgmXRstY6vG8hdnF9auIrqBf68JTvOXBCcD71bVEA9P46wmMt/7jFMVVHpUNpP7c56YlzrJUvP03NAalRRcAdA75tvA7VDSM+VsemX3kY8NUJdSZZXx/gDyIh2Aa+o3IGrc3HXhku6s+fq/BZJ0dVVBvmJBub4SxInjow6qnlt+TuYibiKcu7FsFI2Dsl+TS9ZPBEJgBSZCzfgvCnFAmcN5dbwjdX/f9SHgtwisjqrqh5iofGOhfYKKWZZcLVxsBgkY4qBonudbnQNx1tA2vUbQR4d0gbJy03rlOXG7/FaebXYBVSJldUb7NIVpU0abAe5QFct6US97V/zJesFRUS4n4gkJtAvEQ8g8x6nveuFzjOo3QzTwCr68IlLr3H44CvxAmWL6fg1StAtK1ny+TIvShPsHy8dMdjSZzgn9DWIrJC9SYo0GpgvJKEK7lZIZkOEDzUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(346002)(396003)(136003)(376002)(478600001)(52116002)(2616005)(956004)(54906003)(86362001)(66946007)(66556008)(66476007)(316002)(7416002)(2906002)(6512007)(44832011)(6506007)(4744005)(8936002)(186003)(8676002)(36756003)(26005)(4326008)(1076003)(38100700002)(38350700002)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nOqhPlhdxMz6vBHP+Tda5/n+Bry4Zoq8K1+VRm2ZNBL4/eJvK+2ZtwXYKj98?=
 =?us-ascii?Q?KGRx1vgGmCJQHxuxMwsL8esEZ1EBndnteZfIFqcVY30qp9E0gj1xOAGUorRM?=
 =?us-ascii?Q?t4bYw3EoCLximHo2Zh90UMLzddJCieacCQxN/4WXLMtu7UXPzJMRaPO0kdec?=
 =?us-ascii?Q?fHDGO/MktM19o0IcrppN6jXkmAkDrFS4484x4XQXiUXslYi1DtDg2iDV4zIo?=
 =?us-ascii?Q?ahzSS7ahRd1+ymq6eHYllp0eGEVJ06ZbAc+v8XyhObHWf77+4j9QqmrkpyGW?=
 =?us-ascii?Q?tey+z9DL1nlJuyMTNAJBVe7BWGyJH8BHH/rlg8rnGITF/ruGj1yHirCdxqT7?=
 =?us-ascii?Q?7FXijnKsPwP6AmBMTciECsgq4hXUz5qAev9MWui4U1TTlmIgSs7Jayfo6gUC?=
 =?us-ascii?Q?fJ3wvlxJ6wm2NM57Hcq4N0P+4vo4L3zXEVYRmzayFfiFxqN8woYE/BTo8ErD?=
 =?us-ascii?Q?dUanKojZfxGcxlmdYWwPkT+VNMxSVYuz4EiyVI+se4a+j4mvZoXuyfgxHxMv?=
 =?us-ascii?Q?yHIueg2Ns8gIE0Kechd/zA4YGgQiF4iH/h92li/H5VDFfancn1W57YqIq3qi?=
 =?us-ascii?Q?YiSK7G7TBrR0EvKZavqBYlhwWAO65dWsQ3lwagAeZ+R1Umrh2at9boe36VSS?=
 =?us-ascii?Q?ibHEDXCQGakSYrP9HEdURKiLK8cMIpiBi31PXh3nsyEmk7CV1fEc/Ngx/U/V?=
 =?us-ascii?Q?mmMdEUkMgbPOJ7KLSjw+plhZt3WdnJzZw6Q3XCwuysTJwOAyvAOGbxiFtiTH?=
 =?us-ascii?Q?/PIeK4C/gg0xaqPSoK14Ec6N/nEpd2dSz+OoPd7vur9CL2jNSo2oI7B1HCUi?=
 =?us-ascii?Q?CD+jEWU3vLo3FGTNOQogGXYPArwL3b6V3jztE0BCW7WCrEsYElu0c2qjH/m+?=
 =?us-ascii?Q?SHM69Ad+3G8M+nodslhzcKIQHnJKUmmcH9w7HrtX3q2m5xZwGFxjzPpT5qsY?=
 =?us-ascii?Q?YlnuGA6YX4EaLLA0hfV/tqsYsptJ8UoSt1ndJ7cnbc3vSVuiNdpFcYfgMQx2?=
 =?us-ascii?Q?KVv6CkqK/26Dtenzp6gaPRQWMCmxtdM6LJlbFJvpAv9PRnGv5SYhPFBVoZK7?=
 =?us-ascii?Q?nVeNbtF4+sPD5pNj540mQInsCVioHh0hRDtI59E8gRTsrzBDnUZVZGlvgtaH?=
 =?us-ascii?Q?2yQdqY40X+TNvd86EEJjLJeufKmIyFKByPqfL23o/uoTWWbm2gXEHtylAszc?=
 =?us-ascii?Q?LEoFghthlJS4EMtYLA2eKpaUKA4FZ72l5+QcEn6auMEiIty1ZYZjtzUFeZ2a?=
 =?us-ascii?Q?FPQENOYy0Cs25QpIvKwKRzv95xTwECuJjE5hUzCdF51BkBtUKK993RJzVq8S?=
 =?us-ascii?Q?J3XOfYR/7+WbqS6YLtJ1U2kD?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bc39ef0f-7272-4acb-f071-08d956b01546
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:54:12.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1yc4elbKqAJx2XrimoFwQR8PIpSNFJPsIapgoI7lF9nz+L0h+OF3I1xpTk0Gl9WvESOHV482tuBFiiSf8HTgEPVvdzCsdufsjeic9hqCNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6921
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 3ac70a8183c4..b0f5aa8c979c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -17,6 +17,7 @@
 		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
 		emmc = &sdhci;
+		sd = &sdmmc0;
 	};
 
 	chosen: chosen {
@@ -353,6 +354,20 @@
 	status = "okay";
 };
 
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr104;
+	supports-sd;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.17.1

