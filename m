Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1183E01B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbhHDNHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:07:24 -0400
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:53318
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238394AbhHDNHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9RiA+5QSkioUWneYZJl3YVSNGcBMZwpp+2gUp3uqTRX/GTv42IsNWfvP0Cr2epvDCwPBtisD/pDZd6AhPSgT9XgV6ASoUJms3XKJ8NOCLAktpz2lRED4TotRkc77Sf3Hd/5TYTvr99T0gIS2kodOOXbxUUz1aMUBJIPIFHprpUYgbbKn0Qh3tf9LJEQgkGwty+t/Q7ZFHRirNVYe9xkjm8KRF4vzDENBgAOwhOgkLeMdy/w4oux/z1dH2gaHCzTKn7TuKAEg3jyfebwbNatGtlBsz7IIxjx2JiD75D4+E9JBn5lPo8DMuJBJZhn37CodyvxL2fOCBhkQADr8jv9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nYDEgGXUw3Acb+ARTlml6xCVcxgSVYO+81TNIMcqgc=;
 b=P/lmsj9cblKdNvxfQ7J05kEDTbKjS+W9XyVs1TXzN7xV6SMjOn6WS0kZkdSiWDfFCLYIk1sg1i+TT1OWXMExcqI0GlpVCGLcQ3mvYzE7vhOiSMrOJtOR7OSoFO2V6TnbhLZrQPLuqabcOPkehNngf+8/tGEKcDijULsRQJuQCL/+0iCE60L69JvdvD59IdoAA2GJWqYkgRsyRtjgUmdbfTNBsELs8qZIWLQu2mALj1U8xVzCsTC4Ig9AqYSJodm+KRIVoJVG6c4FwV3B+dZviTf72GqkT6cSMuKFNYBHzl6Mwb6n105EpbjRXGI67bBnDuV+7b6afSwa/0oqe3iniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nYDEgGXUw3Acb+ARTlml6xCVcxgSVYO+81TNIMcqgc=;
 b=hlIWC3+yOtxVAKKGxamHgYpeThRtTAlex6Aku4ynzrE3Aha7+3gZ+n7tSYeBDx+RyCNiezhJrUxGvDsSKXKnKcsBwD6jY6yXFECaoDF0+dFSewj8MhIW4EzB0GxWarcFvwnPq7YDkE090ozcaZlC59jBEHMhpm5gJZ3hAvYkih0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB7PR08MB3723.eurprd08.prod.outlook.com (2603:10a6:10:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 13:06:59 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 13:06:59 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 7/7] arm64: dts: rockchip: rk3568-evb1-v10: add node for sd card
Date:   Wed,  4 Aug 2021 15:06:25 +0200
Message-Id: <20210804130625.15449-8-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804130625.15449-1-michael.riesch@wolfvision.net>
References: <20210804130625.15449-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:200:89::22) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM4PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:200:89::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:06:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f046c3f4-0563-47a9-b809-08d95748be18
X-MS-TrafficTypeDiagnostic: DB7PR08MB3723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB37235472B204F3109C242520F2F19@DB7PR08MB3723.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DL8r0JoMhyr15Vh3Vihkto88U7pwpVJyYjPH1ZnA41sn0UU9yJS5vGpYADLieNlAwlemv6tsarkgrIpsgPYyf5GV7RWhr33UFHTGLPhk5t6gfsCKewwZ0eSj9mXgiZamZkrrNeQBCy56UcRDRadImebgmQcaBvjgJ4p4EcgeZdW70cgfh6yTp6heuUNrGPScaOuWvZWZ+94JerDTKA6KsoUt4ONyjIE/PGSniuJ2er3vBCoiwgZTG3CKeV/kmZoEJN+m9WI1KxKB5RWGNU+jhMsRDGo0T9gtc9cSe54o9LybSe8Aik113lzY112TxKv2jqC4V1dbrNCP4KX91cTniAOOXsCvSpuZFbR9bw791t/9zbSLbRUPXWjZhT1tuHUEPpk3JxBTYqJ8NLlVQvRjYuloLfIAmrT1YJDN8rnNfhcfmjfEHB6cL/35kPqZRfKfsHpE/Om4Z6OpPBaqCWMhR3VAqGrdBuu8nrGm0VhmEf74VDsg/vaqM0vXantGQQkbATr+4ciA7yNy22g3G4ChxD61uBXKD+Xrx+CD/IO95bRIClFYFTE711U9bGzuKOmml0Af5w9IKRaMkaiSz0q8ffwkifUTfs70e3Mb4Q+KM4LfS92N4Z5a1e83k51XA2wFIcfCumtFwE0BOWiISQ2pSmE/LxmZXeX5mHonVQMtBw5Mh870jLKljKlM11+3UPQuO+uAKCJO4G8s1UQUrfsaUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(38100700002)(66946007)(2906002)(66476007)(38350700002)(66556008)(6486002)(2616005)(8936002)(6666004)(86362001)(44832011)(4326008)(52116002)(54906003)(316002)(8676002)(4744005)(956004)(6506007)(26005)(508600001)(1076003)(7416002)(36756003)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7rCkHK1m8Dz+niMpgovlxXnTKkaZvJ6UIRPOd0SshK/pvMIzCkSAySU8JrQ1?=
 =?us-ascii?Q?D2GuuXMSYe8ClouAuyqtiNm4OYp2OSov8xFo+WCgw/4450AvZceBWp8nHwiL?=
 =?us-ascii?Q?OM7iZ+2a6XJRPfgy7+sU+hy7Mx31M4DNl5Mmudmyk2DkWipeDJbq2ciQfIID?=
 =?us-ascii?Q?7tyTIACrGpRzlcbWJ0SolbUuR8zvHBT5xo1zgIbw4eQQb95FwD+TbBFL8a0h?=
 =?us-ascii?Q?iINwqgVTPBWqjDD0lYkM/ogld3EpbWBVlxykZgyZ9PjY62+NMI+hhrtYVlsP?=
 =?us-ascii?Q?p5ofLBWY75ZfNaeo3L2NPxypJGQ0og1G4SGKbEcBvyglGX7Z3FFBnajx16dG?=
 =?us-ascii?Q?HA0UPtjPqqvZhp58ppBHV4guHLqWSKIKVzUn+WKp/u1hgc2Dk3cyi1d/g6tP?=
 =?us-ascii?Q?XmZ0bM4wdzmwSgd5+bGrsleiM2JYHe0R9EF0aH914+86YzSDx3/NPFmj1KHO?=
 =?us-ascii?Q?MEt7rSotImc/zk+4++xSUSOgu77dwSUaSo4tqrtwb5QF6+Bk2Ev6BZ0zEMKk?=
 =?us-ascii?Q?ryCTqAreZCRi4eCykQoKMk90iTTdU/9KWORozZxsobJZFkpcC1a9RYlUAfj6?=
 =?us-ascii?Q?8My4jEqm37v5YJ3OG44iCjVyfJeGCZidkHFtDuHC7JX0a5ZBzRUDcI2QqF69?=
 =?us-ascii?Q?gk93KonD+nm3X5qJPBWKL75lj1AWvPOJxHpQJIE5/+UDEGKOh/aUh9fC3Pva?=
 =?us-ascii?Q?a5vXqpx9cLggyI+lvf1/ydKGjFDygacd2BBi/DxMrqOt5U/ALpA+WIxS0kX2?=
 =?us-ascii?Q?UA7CSPcJJFgn7fNi7pnIwMuudENCLNMspURKBu8hSrEjNw8sSgf94rbC+EpI?=
 =?us-ascii?Q?1IIzYJr8YKdxgl2lItrsBrT0NRh10licN9hPQNEaFKIMLFqUm0lexWxF/k+4?=
 =?us-ascii?Q?OuUfMhKUZNeFFG8ChUgvdlx3/ukWzLRlccm8G2y3Eau0XKIHUtNZRYlJFxpW?=
 =?us-ascii?Q?Xwq2qKMuEky4IEdmHAk2z8DNj+YGF3vBSZYraHJjEK3O+UJRADIQJJINtNiE?=
 =?us-ascii?Q?RjVXdvqKnUgUgm8qFaY4wotA14Ko27jbKee7c/DMr9fWFLzAbNCL3SIH+DGQ?=
 =?us-ascii?Q?T64qx3Wg+oDwx9bhJ4eus3ijjntcrwDn3uI8gfaY86HBVoLBe+JfbiE0XjXj?=
 =?us-ascii?Q?iagpYtM2VcI44ibcnEhh7M1ikbH6oSZfiYLFEM9Y1gIOBet22k1iWoZzPAvu?=
 =?us-ascii?Q?Oa1mKLKnxuLAlCTEMm94FV2DTK3jdfM+NVf3pwZ/RrBkHTPUBujLxVb/cYC2?=
 =?us-ascii?Q?2HhM8j5WPBH6f71oIbESvK3DqJFZTy+dAZ1AFSIBVnPRgJlBNH790uFOU7lX?=
 =?us-ascii?Q?uKGaOp09cQl0sa+x8jSnxLma?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f046c3f4-0563-47a9-b809-08d95748be18
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:06:58.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70Is3i6Rr/eAQ6F0h0eMilIMBaqYAAyWzD5GSM0CCTr9+dLRtYFQMVtxzgRZkZw0OujcTbog5oR6brJd/zj0mqujPVpH4XFEm+4FNx2HkH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3723
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v2:
- rename alias to match convention

 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index ed96f27c64a3..c4da6436059d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -17,6 +17,7 @@
 		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
 		mmc0 = &sdhci;
+		mmc1 = &sdmmc0;
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
2.20.1

