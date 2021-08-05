Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F303E1453
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbhHEMBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:01:53 -0400
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:49473
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241222AbhHEMBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyDG7UxCqsMNHiiUxZdYIBbuFOCWlkwN/BCUAwOL3bllKHMcZbTIWYEcc8oZ5fW0fA2Phijaido1KH4QwOCj6pMBbLdHrY3+PHMu/GlsctEiiqYaGcb1shu1RGujnPgMZQcKr/w1SGSUvarOeYiUn6bMIrCoM2Xj9fp6+Z0cjOSF5htqZU8mq31ly3MbBm1CTgo95FHx/1244b6pnJLQ3pQXxem5y2q7YOJ2h0fKwCftl1dE3Xlv21tYavPztZgVgtW3lP7bqdpjQ+d6l7Bb7Po6R9mtvuyH2WhkNZ5Uy/NGn89DXnAqb8zKF6QLvd/xWj+Ab3FV9SZ0gGMWmgfpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/U0NRjJN5MTO1F6TknfwHPMb+ruFjQnqI5JN2HbLAs=;
 b=Z02RwVvYlacuW+sx4+Umf/Qi5s3pzUvxIcMZyifIJ/b5s1VYhISO2Wzn89uTb0j/KEPh5BzjK0XgopdJ42IxRHOv6CtGOeEIL8P7mrpFohb8K8FmNtRzkcxv+9FL5jqTsQkAELO4IVfoiHWgKJ13MwWFyiyy3AtauSJIuRf+EbllZcFK5eWfddMYD0ps55gcTjd+07/GLPB4yBPl0tB8rRoiVXzowAiZyRqxpJkhfanCpn8mn2zEQiOyxFbP9iu6ab8gC6lo35LwMkttTYm3b1TelYQnXdghXaptNPGIAjJv/zA6ehTQ2BnPwWR2Wbq+97YygUHYM1S+Q5R4+6kBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/U0NRjJN5MTO1F6TknfwHPMb+ruFjQnqI5JN2HbLAs=;
 b=K+IKhGqRA9S9RLb7JEdSQfe8lNBSEBzBNSkPXFyz3U1AaFo9X73nPrrb6LmjdXe/G1Jc0EE79Y4z+m+2eyDxc64LWSaEZ3vYrmE1CTS6TnB5N9ZcWgkbop+ll8aj9cxsLuvWF2qJy1b7+Sr0q89oPo07RZfLGQfaTVnXXs7BbBg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5419.eurprd08.prod.outlook.com (2603:10a6:10:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 12:01:27 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 12:01:27 +0000
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
Subject: [PATCH v3 3/7] arm64: dts: rockchip: enable io domains for rk356x
Date:   Thu,  5 Aug 2021 14:01:03 +0200
Message-Id: <20210805120107.27007-4-michael.riesch@wolfvision.net>
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
Received: from carlos.wolfvision-at.intra (91.118.163.37) by VI1PR04CA0099.eurprd04.prod.outlook.com (2603:10a6:803:64::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 12:01:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfc2cab9-312e-4550-73bb-08d95808c0c7
X-MS-TrafficTypeDiagnostic: DB8PR08MB5419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB541984288622B52F3F6943BEF2F29@DB8PR08MB5419.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMXWbTKxsghmEDbkKZaFvo/U0qq+uuDuHZMam1Gm27NfvjcgA8SidmzeZEbPclddlu3tXntRVCx2yOOc2LXRpxTHfuw7ubotxJd0l9I0pqtpMN2EkigHrDBGO+Uq3dEcFATxEiUYK0fpJ1Qp0Jfz74IR3wBn/ZSmVsyhk6htucLTy0L1kqlB0MMp62fXGe3Bpm+2domhe3sEWwHLgL457ZaFIekELmcw4U8uLb3qPCi0MHw3tb34/FbDBeRCjHYn1RF7j6TmStDgVek2lwJWVjUftpnEyHdx/9gSmU6pS6C+PCYpVIURr2a9hcBkIS7WORkZUBNqeWD6Ji2/6JLVMqAjhZVn1b/6CS+bBhDsRcj5eV/Ybrn6bmhULzTRKV6DghJdAYshiLTOkxhowvrWQ3WlC32sHkUhAuy3CCNrz+effjdAEUvDoNKaFcfWHPp4IMUoMJCkklJLwcJH4nXRgVzrqhG1ji6JFXmhdcmhvm5qPcvsmicQvzecZQc4+pBdeioj2pJ0E25Nnwi1qb8l3dGD2BunA8hswwGKhEKXWev6F2hPCHaxs4hwnjHHMnOxjV6XI8EjUFYLJ4u/qnyLLIgWVvLSjxU3unhSlhcbxy8j7xg2DKk26cFX4V2EK+p4zHS/UyNff548X0LdDHDM1+4Ygnw/oh2ZeLdDn7oGNObR45IlMq7izFTYYkOE8wcEKnCcNlO4OnnwLxrNk0pnoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39840400004)(396003)(376002)(346002)(6512007)(8936002)(66946007)(38100700002)(7416002)(66476007)(6486002)(66556008)(52116002)(1076003)(2906002)(8676002)(4326008)(54906003)(478600001)(44832011)(316002)(36756003)(38350700002)(83380400001)(2616005)(6666004)(186003)(6506007)(4744005)(956004)(86362001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jUgagapuONxI3/0w6UaxK2STOfVp1zS6rkEFVBeh7UZNHwA0EVLlUmlBER+w?=
 =?us-ascii?Q?32K7ktFwbH+0I/cQizNYJWlwHDPA31d8RF0neOvdiroBSkcyZB0Be7g+qk1P?=
 =?us-ascii?Q?YCoMlk6Q+Cm/3KebxXaJtBWHpS/UPAG2fRN17F5fJ6y9i1r/Qafg3//GsyZj?=
 =?us-ascii?Q?3KePE7xn5IWIlFksFzmVww4Jrx3G0fLre8hVzEj/tZr3NWbiQq2RqZZicamI?=
 =?us-ascii?Q?nEy9vJL0jsfsYoP97DwUB5puwlNfHEQVHWrKbHu/CPPSToavuLQbGIlXBPaQ?=
 =?us-ascii?Q?+JZgHfcNtsgmDW5krzy/wW7HwmYODuTQnxSn989Y4kftDyYJiMf6LSMgyiw1?=
 =?us-ascii?Q?e2/VUyHGuKRNhnisd7yK7CufdBgbpgeHxauaD5aYJc5DgPeFlRWwIRdNjPi0?=
 =?us-ascii?Q?DM2LBonLUCxyWSKtw3Oqv1Byk+vQ99nSabuNwe9zs2+VfFh30v52ItesPXs5?=
 =?us-ascii?Q?nwNdqUWPpZEng/SxNEFofSJ2xhSkm1v/aPEn+4HoQO3c2bbsCfT1FvMfdoOY?=
 =?us-ascii?Q?VK/nuTfbqr0m2BdxLY5vuPsp4dy5Vcmu/wZ8iSm2GiWXOLRf5ZJlwEu40SGl?=
 =?us-ascii?Q?nOUG63RRB9zXBM5nQIeaPluB4YVbUc0eof1O6QzhjcjJM4caUP2HM/ybSSDk?=
 =?us-ascii?Q?mcAqp7mn30V6SmKub8W7ukNWlkskCM2pmCYwZOIoaRNtL9G2hIMiy5O4Bblv?=
 =?us-ascii?Q?GSDCZYfvnBk8TtL7lUZwgoHE4dTq73XUXGNSUEQhSHIZoMkAsZwhrxAGjg3m?=
 =?us-ascii?Q?GpRBMAHImbp7ExYZxGneVvg2Y90WyQaFivM8V6wgO0Hpi6RKk1fWJFM4HQpv?=
 =?us-ascii?Q?5Sd0q84y5tjndzk4vl8SPrcOgNlO4Rapgxvn2NAXeBKI4dyjtddAjn3ztY1n?=
 =?us-ascii?Q?FpeyDNku3FHGV0UUQlQYzJTMykqzIBDfiebKr/rApD7sLz9PAiZDht9ZUra6?=
 =?us-ascii?Q?Xu6S2na9AIcNy2UDc82c65ocAYuhD/qqtNEUWTGWDltG5EkkqmVoD8sHVI7R?=
 =?us-ascii?Q?bhwyYP9oTaVKYpQPpJEvF4GqNJqNHh4hN1gYcOuL4nSkKjWZjNCkns1sZpP6?=
 =?us-ascii?Q?SMyXMQE+dH1gzYBvEpIbDitfmhHOThHW8FozbrDBAtgiZLMAbWE+8dI8kxeR?=
 =?us-ascii?Q?H8f9y4OZHfmnZMqBF10UQwCf3K3E70Mi3+0Yz78wEdfCiR/0LcLSGfVB7x43?=
 =?us-ascii?Q?rHA1ZuXxygvI9gv61SbYLeWN4CBMJ3KEEV8dBQateoGvvblYZ6JrZrDsu8hg?=
 =?us-ascii?Q?i2glqGm/fyaiY2qBF3S0zruYcEOsTs/rl8JLiAH7DQRHBjmiN3wLmoxZW39a?=
 =?us-ascii?Q?98YjuE1ZDk71VnVvCAS0aPO/?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc2cab9-312e-4550-73bb-08d95808c0c7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 12:01:26.8834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aY1meD727vSaJ/SNOKQJ5MjfYsBDD9YyQL5uuHog5nw+KaqK7B+PFXUGVmnO6JAp6RSod3XLMJAI0bXz3OQsMklV1J/8nV3x3MgXIB1dkw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5419
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the PMU IO domains for the RK3566 and the RK3568.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 3e90a8832bb9..834863940eba 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -203,6 +203,11 @@
 	pmugrf: syscon@fdc20000 {
 		compatible = "rockchip,rk3568-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xfdc20000 0x0 0x10000>;
+
+		pmu_io_domains: io-domains {
+			compatible = "rockchip,rk3568-pmu-io-voltage-domain";
+			status = "disabled";
+		};
 	};
 
 	grf: syscon@fdc60000 {
-- 
2.17.1

