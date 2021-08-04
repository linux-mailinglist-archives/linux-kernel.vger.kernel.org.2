Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE053E01B0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhHDNHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:07:20 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:35169
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238358AbhHDNHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:07:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nkeq4VEOdu04MyaN4cDCPFeUBtszijmaVcyvHjHohtQ6CZeTwAJnFhwi8FQSy2yGy8C5QfGtocgdVIuQs/yHD3H00Lojj4nZD3T1Lca3We1OyCfgh5AT7GcKrxc1OKTAGflKAp5lypf/iHuUDgorC4UBxJZGWhwxhnqxZaWRyJgCbAjyplCBdx1qdgxOvsh5rsqjm6l+YTSyr9es5JNrisdd5DVg2sWJEryLYUn+Ni+SuIO+eJY5nkXgg5GSkI27ptnqGcsDPQnYYqhaXf3uE6EzNsW3sWWyhR7vYkoodUQV7Vt/aAtsPYFElL1GuTyAA+ApzisfoAD3ZrpxyDSxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+0Gb+H3BGf4YJZYQyOIKBLChBn+0QdR0FC3oHOe//E=;
 b=DdslcTmBL/oaoIiPmWsjlrvd8sagAqL65QZd+GzsG4dxykaGEvbSJR0wkD5LkCNskPvDKh4DDg/VhUKsFGsWuEFkRFAFGEz04+rCpYFvY/EBVCt343UmnJkksC0Ze5OaV4WwjexywpbzZA/4ponPpKo9JPGk2LLws/oG6D3CdHWE0ckppUWNgC7+7vfxRDk5VtHCjSNyfwECDjOQRcCKwKO2lHkvAhYpNkNCcTya7JRQ+coJqoOyvgrzR9wIDKOyPkC5PemQp4lIOPamRmWvAi/X532q49h+LCgLbr2lNI6xsW4NaOCi7P0rWCGXVNp3DZAw39SAM1oD6LCA6hOd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+0Gb+H3BGf4YJZYQyOIKBLChBn+0QdR0FC3oHOe//E=;
 b=GSiJlPOak9FcKBJgnwtFNoo2Kv6jAowyLRgaSf8vW2U9Ent1rxBcpedCG/n8iLui0FLzhNz+QBx80IMDMoIxGij7r9x8XtcrJIYPISgPlDFWkAtnCSmjegMlkWhZvHabFv1k/9uK9Ag78C5szv7gvZAQhYnFAhvijcu8ljANB6w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5401.eurprd08.prod.outlook.com (2603:10a6:10:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 13:06:56 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 13:06:56 +0000
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
Subject: [PATCH v2 6/7] arm64: dts: rockchip: rk3568-evb1-v10: add pinctrl and alias to emmc node
Date:   Wed,  4 Aug 2021 15:06:24 +0200
Message-Id: <20210804130625.15449-7-michael.riesch@wolfvision.net>
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
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM4PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:200:89::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:06:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e725de-9742-470a-b51c-08d95748bcce
X-MS-TrafficTypeDiagnostic: DB8PR08MB5401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5401AFAEC2D7E6E807397A01F2F19@DB8PR08MB5401.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbV8DRGhXpWiFegBOv2BOnd3WbRYdjeGzY45+BFNBALQeXLOBveAmWD1z97EdnMaiRiqhv3l/b2Hhs2RBu2zxxrqxaA3cTHEhw5uR+hhBZrB517LduTyIjnvOH35kaEdIWNeooiUZCGE011QR4PYYkWA8hQ5HHmGogzSNq2vw2sEGUHzbaBeEy82dlsqBQeMChjIPcX4ljIwQgnlV2MGlovZBVEj4w5L7F3pH6Dmsg3nw+vuPYxKv2+oexe9Cbm+ugpzCiShjLGTrYrtD6ei76Sm17Mc+VGJDWui9HPbctORzHB1kgi09XwjV2aTmxOO4IhFW3HkzV/7vIYtV5gbhDf2+52zGGF8umIk8uI615txMe2kAz9Rqnc5KFtrOixTHnkRcgOewQrecHshobVB20JBVJmJKj0n6uftCrIbnurxlJvafJ3emDsb7K3GOafN4liZQEgMAOFdSl7gbMcrsFg42ubXJztyCyawbsH4H6qeHZGleDoaeldQ+pTohD8PEm9sbD4klnsXolhS1nP9AHzlToZfasTso95Y89KLXATv7ihOFtXAvvoSHXf3sbGQq8gZaigZ3Y93O/G3mSEIdYeo4tL5a/Ryoxyvp6KIJHdugCeOGFoI/VKubstRQkf+BqSh4AxrhoHAZZF0e3ryB3/ujkItekzHl2S2l/sGtZ30lI6YV3huJs+4mk6SRUtjHIuFwqyr2mbrh2dW7L0vtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(396003)(366004)(346002)(136003)(8676002)(186003)(956004)(1076003)(7416002)(478600001)(2616005)(2906002)(66556008)(8936002)(66476007)(66946007)(52116002)(6666004)(54906003)(36756003)(38350700002)(5660300002)(44832011)(316002)(6512007)(38100700002)(26005)(86362001)(6486002)(4326008)(4744005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qo9S5aLZ7vE/zzBff8A8cDk4j9KMQWq0HrDTXQg806Injjekoo4CPVg+0aCf?=
 =?us-ascii?Q?Vz6ui/ONsSYCfGa7H+ulQL+LUKWPBOJBLKs39ScwAcSMsPJCG9WB1NhoEJ31?=
 =?us-ascii?Q?n9eZf2GA+tej2Dmq2XepQedaza6Y2rniQjzBSgGZqxx3Yasnro1stUbAATi1?=
 =?us-ascii?Q?4z2LpnNeu2K2eVMosJNAdZ+jonCq844rFqNnGE2rzbuY7EfO/oZfKgsKaEF9?=
 =?us-ascii?Q?LVtKK5t7LcHlMWKVp9t91Zf26l/eed8aT/jEaZSlo9UTcl7w6ErwIX3vZc9C?=
 =?us-ascii?Q?pIbQ8h7eVIvPAF/U7j+j4wdlRUIYpNr84y51wZ/3bHs47PCJRQ4jmYJ6dPzQ?=
 =?us-ascii?Q?8bnIHei0yEYyyqcFuWPHr1NAB9ngYEoV9Gf+fNBlbCGkDImEPxtmLcZ4/t3n?=
 =?us-ascii?Q?ke7s8W1z3wS/NhZGM3iNMbF0hjjeAStlHqhI90TwEw1nt7egBz+11vTq/Ul0?=
 =?us-ascii?Q?CRG2qcQbHwqKtfW2ToTXSRrOcxs+FD9Z49uwfrMfP70rGsXDjslbdVIQ4FeO?=
 =?us-ascii?Q?k2Et9W+6fnIKBaU/9J0llc58pCDYu2btRxWG7A/aWaAjEGRvUX9quIdvt2WI?=
 =?us-ascii?Q?C3HS7a6N34aLhq+LdvoC+nbeI3U9ymKeTb6DSajhwnLyAiEAXLvnHZPutaXX?=
 =?us-ascii?Q?XQ/rErFT8zV2lzVfYq1PZNjYwRudD4987fH049F0eyjyQ69q0fEAQb37iJYl?=
 =?us-ascii?Q?DekUuvl02MGYH0JPuYzu1nrzKlAYM41xEuQzsdtAXvFt2dPpszqwao8qwDOF?=
 =?us-ascii?Q?+RI6rVCjUX2LFBOeyk3t9K3rIkzepo8vaR7kjKQYs3IpM2Jq7PP/cnQYbiad?=
 =?us-ascii?Q?zSfOF6G1/GoaZ5bmzeMER6shsTjN0LH7fEV3QbxsmX+HMOhQ4uZzb/loIAOa?=
 =?us-ascii?Q?BFRCbw5FtbmzX8I3Qu5jNTS30BBb+pjz7dZecqETdXH+DCudgOaUbD8Eu6CD?=
 =?us-ascii?Q?jMRTEJoMW/0Vfna6VorO0zOPqJvytAxEwU3I54lbhCPjTKfC15r5p0z6bw91?=
 =?us-ascii?Q?Y68yUX5/CPcdCi9WeI9T2eliUbbnCu49u8zUpUYHb2xTN7cvDab6ISruh2DK?=
 =?us-ascii?Q?ugqTBc4bSBtJfllxM80NkyG3c7yaN1Fc8Z7SwU3QojFhBVNY2sdlL5tOS1PO?=
 =?us-ascii?Q?kvG7RcaTzLGgwKIMKuLXnoYyuhq7xGGc3vuXVhfajkUSMmiP7Vl9u0/OM5Zs?=
 =?us-ascii?Q?vjbXsHUC4ZIT09g7j9DW9SidZThxBwz55HAmVF9Vk4fgrkVRIKbmkJFo4uM3?=
 =?us-ascii?Q?NzbzZpgX5YQj+3D7xtEvLHQX2Nv7VgaUXfhvI4Y81QR+A7DpP6/OSJ37vYz4?=
 =?us-ascii?Q?IPuL3Tjg5T7IozWNW3jfR/lL?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e725de-9742-470a-b51c-08d95748bcce
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:06:56.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0l0gzrY2qt+PqCmIj/r8+A2G9J7FYOitdNkRcr3WGhCFGhgLfwmUt8WcOBJXA1kqJClJmEIKT03clrDP1mCFnRFcUXXNM9Cw+PlkrAJEzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v2:
- rename alias to match convention

 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index f3fd4a6813a2..ed96f27c64a3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -16,6 +16,7 @@
 	aliases {
 		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
+		mmc0 = &sdhci;
 	};
 
 	chosen: chosen {
@@ -347,6 +348,8 @@
 	bus-width = <8>;
 	max-frequency = <200000000>;
 	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
 	status = "okay";
 };
 
-- 
2.20.1

