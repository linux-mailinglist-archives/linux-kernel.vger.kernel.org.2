Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6E3E1455
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhHEMB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:01:56 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:3817
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241243AbhHEMBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:01:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYCdKIgZGomULl8QaRkMJ8s1EHQWvaLqtRrr87hNjLVYnhZASTPVfFnoMnQLaitO0QFWBu2diXvh8kXj2J1AwUtvClKLOWRtU7na1q5IWCLZ55/c8WmbtkFj1jE4sg5CEy/uOtwdrvPdRe4moOvRE0OocLFpxTfV+hRS96VHsNqGILxKVl02NGE1EGLT6pe1X4Uuf1gF4pd+DZIOG9GY8rgoWeLGX1DhGWZkNmt60aItBTMJ9D4nD/sQfAS8IfjqN4c0ceH/Jq1pDvKvPJF3O6HMRaagtQWPu8Pq+zQ97pTAjeWqA1L7AOaBWjUlKuqKZ9IXnYsQcRrCku6kQKQJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeeZSM+62ID7s71q9ZX8TCZxKXSF2l5P9CB2DtqoUjE=;
 b=MgMVMyulk4iuQSkY5k+Kv/5LHztg2Fqj6kJswYP/n45ooMUIpQYO40bK5zWeO294gaHzJgMfb3JspKRaurGTVC/+X4sgXh/wV85cTQnb2ltDhl8kUOZGDJ236MR73DEFhzrZus6ZK4EBEXllcOnt9qUdzEjnhFrGeqZZs5e3AXsrNxbB8WkYFeZ1bI0HLfyPgMJ/wdZW+OcispowZv12rhKUQoYzNjBJsltGG3fu0Txy8IYkoZluYTqKWQ6JW54/vrqKDMnh8m6QODQp5IGYb3kQbzFkH+Z/8Pcd3PuOJSefSn/CABkk1MDj+nchDonEr4B7yLeAnsu/1NWdGtqD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeeZSM+62ID7s71q9ZX8TCZxKXSF2l5P9CB2DtqoUjE=;
 b=FILqjB1Eywkm8w1KL9qTQsbw7ux08oDrjMYqbDP4XXMi7KZOIpD7rwaxcprgQbsd+hRvu76NYSWdV6wWhRAL8bLya8vRvfXEzyVta+S7ErFO+H/5MC56mqha+aIEeSbi3/9Fkvv2vvD7JYNrA6hu7cLBDTqSXUqX+G4z4a+sxTI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB6PR0801MB1847.eurprd08.prod.outlook.com (2603:10a6:4:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 12:01:28 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 12:01:28 +0000
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
        Tobias Schramm <t.schramm@manjaro.org>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 4/7] arm64: dts: rockchip: rk3568-evb1-v10: enable io domains
Date:   Thu,  5 Aug 2021 14:01:04 +0200
Message-Id: <20210805120107.27007-5-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805120107.27007-1-michael.riesch@wolfvision.net>
References: <20210805120107.27007-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:803:64::34) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by VI1PR04CA0099.eurprd04.prod.outlook.com (2603:10a6:803:64::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 12:01:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88132d20-9f1c-4fc8-0f08-08d95808c191
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1847ECE477A620510EC47CD4F2F29@DB6PR0801MB1847.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0SvNRVhzd2J+FcE0Gr0dj8kye1vxYRMQOoS6FIvy+/2Pz6ofN3RIxxaeqRbSOlNv/vx5gvu2OPLQ136dXzQBoNGhSeSCVZaS5qXLYMlWTE6/8dpfw00npM1YvpR+N83X7rD/KXq5gVlS/fDX/OxESQZYMS87NVjlGaI97KtK2734Dl66pYAjQXvRCLyvZGcJjxQP2Wvy92XyauD/FL6vID049JmK1ZOKWkXK8FrRKMjyuqF9HIbxaeivwZQtD9xt5gTYE3Xjo184lzrAaXdyW1BOkYYqGQ8r+nmaAJPf/1NwjNeOhnOXOcAz5iqDjSOmFA/E7e9H/UimO/Ez1w/0WZvhNN3jcqehF4/IzTHdL6DjdQZHbj7/G95JQKWhbEG3qT5nsVJIj6gcjFL5DxZqMVAK8dyV8++AtsmtQYTpur0uqRR45d+YvyyuR8CbfXe1i5wVfW8/CLecTRN4MbgnJHPXejcqCsPvmWdnjf9Bk5YS0iYvQk4rn2VpLS74NKZrxG//sgkGBcqR1Bi4hnZ6VTWdelMXGWtjowpB4aI+MDhvqhSlkpKxT6+n5VvlSD04XDBLiMC1+seFJd6a9Ts+F0OB81qiudZA99qF2xb06SOuC3JCkj506B4L7AMc3A7fQm9T+t3ZUKJ3ErywT5snjSQl2Q5TqCv9lYFPboHTMGcJVSuwGTmesJ82oCy121YpbZIMQWOpSgywEj8vNECgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(366004)(136003)(346002)(396003)(6486002)(956004)(2616005)(66946007)(8936002)(2906002)(66556008)(8676002)(4326008)(44832011)(26005)(54906003)(6506007)(38100700002)(38350700002)(66476007)(1076003)(4744005)(5660300002)(6512007)(86362001)(7416002)(186003)(6666004)(52116002)(478600001)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSYRh0s3uAd3vTnAbs2Hnw7gt+e4sA+tMGQkhJ+nMVxD9s1xAAIVakOWxv3W?=
 =?us-ascii?Q?7o+ikEb9+7QsgcBIRtKMQlW1H/3PaYtyLrLyZCoTGLcqqPoYLaPV/jCg2j0V?=
 =?us-ascii?Q?sRk1bmCabyScII/57CXfXVhTHggZU56XjS1gpVrbixbFk3548Llcql2oCgh4?=
 =?us-ascii?Q?a4dJ1NRV4sESx4E1t7ctWNZ98uslhKpq2Luxp9hyiwxQ3ov/vME7lY9UvMQo?=
 =?us-ascii?Q?fuQ2qKZBSEH7umtHHnktyDh5sXlfnugJI7pLDIYZR+ZKQrZ7+wBYAvHGoxNX?=
 =?us-ascii?Q?u2G5lsM+7Ai/xHiBqO4dSaZ7x+U0ZQiRcsWl1vcfdMaBTQSGvwTu4pu+WJ0J?=
 =?us-ascii?Q?CqGn2Jr+cebwtX1sC/R/PWFLGw74jPQRPRTaIvx1LsVKYiN0XCTe6uC5sKYy?=
 =?us-ascii?Q?vckz+1nShdOa1mnozILpyQ6JhHj3WzLroZIBTgtwYX9xvlYKUHVPa4mDOyaU?=
 =?us-ascii?Q?Mb1Me2MstSUWHB0ncb5N2xNOkPEXldswUoDSOuYYTZAC5c8MU3otBlT2aaph?=
 =?us-ascii?Q?S4sVRrL6QC87n5LFqrwNpv08IFi6MC5cxkihJHmJRVaE8D4e08mGwKyCU7o7?=
 =?us-ascii?Q?MLqymyBJOEt9ifVuT7CzygO3CrybNB60Ffp/YzqqOmVsHvO9whgyuDXeLR8f?=
 =?us-ascii?Q?M5NKt1RQANvNBGun91s2ztRYxeaKgkxgt07dgo8AWomahbvcCff63aXVVhdX?=
 =?us-ascii?Q?Lw0WbMS9xsVSlvN0OfHnqEzujXPtO7kc0QJnxLCj7ScfYnOL8JuQO9R6Tqw1?=
 =?us-ascii?Q?6R2a+FksYv0EGAz8qeGbf67xnf9AhUQ+xIpaLAbnFcMBranx8df+kXMzeA+8?=
 =?us-ascii?Q?g5N2ULsDPX+rxg6nWUJMm/bNM/njV7YVZZwFaYk6PM9tpn0NoRWZvl2fIfSb?=
 =?us-ascii?Q?Y1PQf4uHU7NAm0Plxy0K2+DU1isFvEDLL07k6mrW+Zlb3sG+i1NB0UKyB6LL?=
 =?us-ascii?Q?T+QLWHuxbLZcN9v9QgY9CfNs5SZlfXrDbHBiSViAfqPc4jEvWXInKCeZhVe+?=
 =?us-ascii?Q?vsYswpjE0Bi5039g6TnHdweCNIw+qiG0in+yvP45PWiJCVZTmnE/ci02OHie?=
 =?us-ascii?Q?g9I3v4GeiczHLLaZEDjnjUBJObyHevPvhGUkaYhxYrwrKMjMy2IOXZNnXEPt?=
 =?us-ascii?Q?6PIwzEqSxeTFNO9HpFj3dkotdA3kRMkzJMlYG8suRH65kD4XqmFkh/5s/Lpv?=
 =?us-ascii?Q?iidMmK9nO7p01FNuZPdfw8qK/Yzja4O/RGYvAXU24H+o7tmLulNp2jIi0YH2?=
 =?us-ascii?Q?vr8O13tytx2swZ9YJ9Ti9zzRq+GHob42U8Fsy5N4ESGoxHVUQTzub9kxMxaF?=
 =?us-ascii?Q?L4NsLKCs8wIV4t3ktAiOyEBP?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 88132d20-9f1c-4fc8-0f08-08d95808c191
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 12:01:28.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcbEs56kaj+YsxLHbAwNkLAVEcfXwDvA1zUZfG90CNsUK4qTRWTFbjiBW7fVsYgRidJLNm3CJJGwlyScZoKFDWZPwkjBBYyC69SpLN2yXmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1847
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the PMU IO domains in the device tree for the RK3568 EVB1.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 65e536c78d2e..287b58aa6a77 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -124,6 +124,19 @@
 	};
 };
 
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio2-supply = <&vcc_1v8>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.17.1

