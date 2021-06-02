Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20043988AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhFBL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:57:40 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com ([40.107.7.115]:41590
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229586AbhFBL5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:57:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjAbiP02n+DWDs0/+vb6ua79qsXJVVKGatkDppeo4dpAza9REFjMMbKzhgGxDCEoOelqfsLowVEM+mNGdXHJ/ho5K3n9jjhLh53iG5sfF5xUikbUfw58GiEtbTRmK2CmsoYh6V6yUhU6V/pexLQOFWy6XstQz6LjvX0a+FonO4GO08IH6UvAWDuFBDYxT6toOGW+hTtePKEC7WL2zicLhha1gESmRvLAv2ioP15utoaEZrtZAXKNycI3KUEQZZ8Nv8EYpnYmIxv0wiJDDa8u/GEyowl/AGCm/S+QtEaquHDQMSv5BtUrLL6/EjFr52Z9JF/uxjsP6C9U2Ij833DBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBt1hWbklCNLGZGqQnvYcVuvtaN/sPsIJRNvbDIx37I=;
 b=Cl4tQfTQtRaJfBYk3G3tNhS98Nn+l52dDjzsGT6D9xY5DPg5xbGFYQ1oeN+Rb9RX3nMJyl7bNEiEWSbC3+pABOKu5Db7KLgaHwvqep4H66WBWqshn2Z6zsgBiIA5sAu/rD6wQweW00Czq1pLFQIQiaZMfVC0/g+uItkV+DfSObrXzsZEATAD24o1XNLCu01YvXdokjuOarofh6XnTWJUi3UHeAhbzXzLJJ+x+1DMs6rvLDKh392JphcrSXgnAyM9nGBsiVw3nJxo+IGGqVVPVAId0VIVTk2hZQ7lxxVlMWLv9j22MnosrBgNTgs9CQLRALnnmhPSZdqtjuvs/3C4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=televic.com; dmarc=pass action=none header.from=televic.com;
 dkim=pass header.d=televic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=televic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBt1hWbklCNLGZGqQnvYcVuvtaN/sPsIJRNvbDIx37I=;
 b=NImQ6qAkdaohYGfb1r+N6aIc9ddOpRT28Lyptwr4XoIPnKYRIaU9tSrFrRX3RBn8rW6uxuYRVyt4uvSh2wNOLMQx7RMuINhk4UbSooevgmIIRwRWzN9rSuWSM/mX4TfYqXc8IhBz+BwEUTDKhDtpzbH3hYycd6NrEsb+ZnBLcmg=
Authentication-Results: televic.com; dkim=none (message not signed)
 header.d=none;televic.com; dmarc=none action=none header.from=televic.com;
Received: from PR3PR07MB8049.eurprd07.prod.outlook.com (2603:10a6:102:14c::21)
 by PR3PR07MB6988.eurprd07.prod.outlook.com (2603:10a6:102:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.12; Wed, 2 Jun
 2021 11:55:52 +0000
Received: from PR3PR07MB8049.eurprd07.prod.outlook.com
 ([fe80::395a:cb81:11c7:f958]) by PR3PR07MB8049.eurprd07.prod.outlook.com
 ([fe80::395a:cb81:11c7:f958%4]) with mapi id 15.20.4195.015; Wed, 2 Jun 2021
 11:55:52 +0000
From:   Pieter Cardoen <p.cardoen@televic.com>
Cc:     Pieter Cardoen <p.cardoen@televic.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: mach-imx6ul: support ptp and rmii clock from pad
Date:   Wed,  2 Jun 2021 13:55:32 +0200
Message-Id: <1622634933-4098-1-git-send-email-p.cardoen@televic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622621468-17013-1-git-send-email-p.cardoen@televic.com>
References: <1622621468-17013-1-git-send-email-p.cardoen@televic.com>
Content-Type: text/plain
X-Originating-IP: [2a02:1811:b71a:2e00:dd9:9421:9245:2349]
X-ClientProxiedBy: AM0PR02CA0198.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::35) To PR3PR07MB8049.eurprd07.prod.outlook.com
 (2603:10a6:102:14c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:1811:b71a:2e00:dd9:9421:9245:2349) by AM0PR02CA0198.eurprd02.prod.outlook.com (2603:10a6:20b:28e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4173.22 via Frontend Transport; Wed, 2 Jun 2021 11:55:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68d09ba6-b948-436c-dc63-08d925bd5f23
X-MS-TrafficTypeDiagnostic: PR3PR07MB6988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR07MB6988043376A88A1C479FA9B1FF3D9@PR3PR07MB6988.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yI1mh/eMkPskM4odyJBYqviDOfvqjIelSH99t5LJzYMKkvYIYMlE9+SdoJfzVhgLGwQeWoynLM0vpdsAtUY2JdPMIZ5kz/ftX28ooxIh8D1DHdTSFUxSllwfvK8VVabYtaZ50FzOCm4gm8btWLALqWuMDd34CBXmd3tgsKYem7aLZJsJBuLm7x0yZm9A1r2kvPugzrKqqMrJGE8YJwbeMGiGTu+ZsKBVjE4C1EXt9DmuuLXKZYKkEUOAT1GBUzv+k6hhxoCdLEiTpNHUbWhB1JOSu6gPryF19XUQNcUKarU056hldefqzwjCC5kOK3KkTDvcnkDhDPgeeuLzOdpYGaDvhnl2tHojOtptHUHPDBhoVyO7MtCf6oJE3CUklh7zLuGNpg7FDlhStUa+6rjMWbgyiP9eDrNGEQhbfxynjch0yAWQkk3WNG/zEcmiXd8YYHtW3Zj/wi9WYTDJW3qM/AOxL8pqSxtZWbFGBpjjRDUhfHTYiZnfdY2iNRzNMiH0SgMr8/0mQu+CmO14kIo768KJTH0ELImt9yDiOZbRQVUH252AWW65gKyvQKlIgS5+O2Xa7vnRvDFmGc6rIPMKyY0ZaK0WLcXXrIh+qrTkjhNgZ3FyztNFU9WLZpYRaptKSzzf1PhSwCHtcyl3W3UR5TAlK6ubEt5OOcETPlHuzG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR07MB8049.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39840400004)(366004)(16526019)(4326008)(38100700002)(109986005)(6666004)(5660300002)(8936002)(186003)(54906003)(316002)(6506007)(36756003)(86362001)(6486002)(2906002)(83380400001)(2616005)(6512007)(66556008)(478600001)(66946007)(8676002)(66476007)(52116002)(7416002)(69590400013)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jLhaKtLmuwBCDeUt2EzZL/K+SJ9dT0udbWAuyOYWk8pznYh44ZiUYKvzXMpk?=
 =?us-ascii?Q?cCAJ8p5CShd17AmPAtTZgiv3rJ29YzRsA2/QmCqPcaqnRzteWPV3BKURiK3S?=
 =?us-ascii?Q?grCpie4duU+omtW54sBFgDaWjBr1mzofV9Awnjn9H4EUviWibWzzAi6Zhbri?=
 =?us-ascii?Q?i8eKsve71g0zFJd2Qu5eDsj6DC2elYFn6BvmPD/6LJSdFKCAfZQykGLkx3rh?=
 =?us-ascii?Q?x1FnGa+NCSDSm9ZwZbmqZ5awNwE+YpV2rwG0o1PK5UmMegjGnE8bkzGrfXVP?=
 =?us-ascii?Q?zZuI2/3PXDZfIGh5eoc9aL39dFJhyb5fr38xGkcbfta5JqLiKr5otbdWnel5?=
 =?us-ascii?Q?m+UDS44SntDuwmf349iYCv7UGH9rL2z3zk5vByW5GnJeKxhPw+jgq6ays6Dl?=
 =?us-ascii?Q?9GNwk2WLGXfWd6oDIMH2KlUkHNf3m16d01AC/YeU/N9fsOeMsL3vj9d8NWdl?=
 =?us-ascii?Q?t+wqbRhnrzYsfUFrICoAg3S0MC+wACqshO97cEaZLQeZOgHZ3D9/OLgjoL93?=
 =?us-ascii?Q?BNZVM/cxDn9kB9mK3WQf6JBLKcRwFby2aqeJc1c79ucNCjEAt6MM3K1PsyA4?=
 =?us-ascii?Q?OsVSPxB9CuvSsJlO3JwqWvqyW6jJaneaMcH5d+L9ylkLe2ozVAx4NjNzOazF?=
 =?us-ascii?Q?KCNEpv4hlgjMXJSwv1NGGYWYnpU3EvwaLhi95f4pMg41ggo7I4EBIndSsqEj?=
 =?us-ascii?Q?AqQa8B5LmKd+1u083y/jvtAYZOVDTFbyNQgmH/ajW84QVZEovHe8y2LC7WEL?=
 =?us-ascii?Q?sqTdyHSssdSSQqNSglEd8t195f/PbKza2Eyox1qRP4dUEqto+6iSE3Fb6BFI?=
 =?us-ascii?Q?1GrvfXkCX3COBEE0xV2rAgh1oFCjhAQvLz+NHpFK4bD0/7YlNAnRHduya1co?=
 =?us-ascii?Q?HMphpcuTW2Lg5Bxt54/6aCpZEqqFPCXWVQIAzKG9xMhbgK8R8dqIUVDu+pfQ?=
 =?us-ascii?Q?EdTN7PCTeflRXXiZ4nqQgXai+y931HbAZjVKUhC8hvAxkbXknRjS5oF70qDB?=
 =?us-ascii?Q?bN9T7EOMt/DE3L2eqX2CIfPraY032BSdvG1k+e6OHDrnMfJkS45gEGnW94wa?=
 =?us-ascii?Q?ifgGLO5yKl86HlHjUhtuz7oU/RXpLKv1/4XYViM2kNGbvRSiLuCz9hEfsoq2?=
 =?us-ascii?Q?prO3WNdE0j5A2hF1DCihTAI8jmHz0Ztzj/EBa3Y08u/o2DtXxQVUyhvEN0iM?=
 =?us-ascii?Q?bIhOWvtoeyJQRXMANT0WMVPikYShKfPcQv5NsvPN9IqYo+ijuJog7u6nxClG?=
 =?us-ascii?Q?aAuXaxiW4joj1rvVnSEIU90fCtjfTTXSeXI4+I3hM3uI6zQOVXlKA27ZtmOL?=
 =?us-ascii?Q?qtoatLhn5kJe8CphLWFQovaGJjNt+GlreLHmT4wNStVzUjhDN3ZVYLh2n4oO?=
 =?us-ascii?Q?oUxwTRXCx9hR4P5LOHvOwe9CqVaw?=
X-OriginatorOrg: televic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d09ba6-b948-436c-dc63-08d925bd5f23
X-MS-Exchange-CrossTenant-AuthSource: PR3PR07MB8049.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:55:52.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 68a8593e-d1fc-4a6a-b782-1bdcb0633231
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCBzX1XIqqKV4/21M0hmBzSzQ/Obo6ZpPJdpB5XIRDsKbTyJhIwdHIRpsU/V/c64/1D0HHImxt3g4xrqC8Ncug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6988
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx6ul, the ENET RMII and PTP clock can come from either internal
ANATOP/CCM or external clock source through pad ENET1_TX_CLK.  But in case
of the external clock source, bit IOMUXC_GPR1[21] needs to be cleared.

The patch adds the support for systems that use an external clock source
and distinguishes above two cases by checking if the PTP clock specified
in device tree is the one coming from the internal ANATOP/CCM.

Signed-off-by: Pieter Cardoen <p.cardoen@televic.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 44 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 35e8120..70d82cf 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2015 Freescale Semiconductor, Inc.
  */
+#include <linux/clk.h>
 #include <linux/irqchip.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
@@ -18,14 +19,51 @@
 
 static void __init imx6ul_enet_clk_init(void)
 {
+	struct device_node *np;
+	struct clk *ptp_clk;
+	struct clk *enet_ref;
 	struct regmap *gpr;
+	u32 clksel;
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-fec");
+	if (!np) {
+		pr_warn("%s: failed to find fec node\n", __func__);
+		return;
+	}
+
+	ptp_clk = of_clk_get(np, 2);
+	if (IS_ERR(ptp_clk)) {
+		pr_warn("%s: failed to get ptp clock\n", __func__);
+		goto put_node;
+	}
+
+	enet_ref = clk_get_sys(NULL, "enet_ref");
+	if (IS_ERR(enet_ref)) {
+		pr_warn("%s: failed to get enet clock\n", __func__);
+		goto put_ptp_clk;
+	}
+
+	/*
+	 * If enet_ref from ANATOP/CCM is the PTP clock source, we need to
+	 * set bit IOMUXC_GPR1[21].  Or the PTP clock must be from pad
+	 * (external OSC), and we need to clear the bit.
+	 */
+	clksel = clk_is_match(ptp_clk, enet_ref) ?
+				IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
+				IMX6Q_GPR1_ENET_CLK_SEL_PAD;
 	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
 	if (!IS_ERR(gpr))
-		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6UL_GPR1_ENET_CLK_DIR,
-				   IMX6UL_GPR1_ENET_CLK_OUTPUT);
+		regmap_update_bits(gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_ENET_CLK_SEL_MASK,
+				clksel);
 	else
-		pr_err("failed to find fsl,imx6ul-iomux-gpr regmap\n");
+		pr_err("failed to find fsl,imx6ul-iomuxc-gpr regmap\n");
+
+	clk_put(enet_ref);
+put_ptp_clk:
+	clk_put(ptp_clk);
+put_node:
+	of_node_put(np);
 }
 
 static inline void imx6ul_enet_init(void)
-- 
2.7.4

