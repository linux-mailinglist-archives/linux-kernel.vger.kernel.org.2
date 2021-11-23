Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2704459D69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhKWII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:08:28 -0500
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:62593
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234397AbhKWIIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:08:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ97NA48pkKZ9/ttO8NJqynes9yPdIi4dv/LZ7nbLY+mRUpYehMV81semRBdabcbXgr3CzmcoVsgfGwTM1gn4pd2Ws5FtCZh2evjikz3AbnOsOz7hc1AdvjhgqN2XGcGIHIDDgPNtncz5ny6BIwDWZzmez0XrPMCM/Z3cnWCKmLfGxpezIEuOt9lY9rAv0NxZbPMcdqD+vQtWOKzcgeJjnZxsubY34AhfML767SbFLJ8+U28bLzaWDMEl8x0DIQ4AwKt/h+0UfJNlFDgyKqs/ZCPXEuQDeSeLR9VxEXato7CzUO0IInDTU/Y89u8WGoBTDBnMxIDKX/Os2oy85un7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d057y7nG7bQEhQavxFgsliXlbfNCAebxSB2ayACzDYk=;
 b=Hv6mn0C3GZADvEtnU1aqRx2BrkrGHp3A4kGPSYJ1TFiR9xUIopodFyOV7REj5pk2IihChBqhVeL6r/+x7tjCPko1Ppo5wqyIz555Madbj4RhSyPcF4YAuyA9r+WCBd6MaxhEqhD5IE9nipMfi8rULphIP8KQRDA8b1FRaLrgsTTNZAdVqhoctNgWy3zuGeaLM3uba+lWNBWXVyjRuJJih3R/frsSrbOi1fxcbuzCOajkH7lAjb0L4M3UIt+rlPa1gtvflhS9US13/woVLXkseasI2Z7cLeiHjJbm64rkBgCigy+hztqCbZoYzDRpE2TInJhNBDFRjfrulRwaE6tE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d057y7nG7bQEhQavxFgsliXlbfNCAebxSB2ayACzDYk=;
 b=Zst/739xbztwZCbRxEREGVAd0arm/4DOn86/xgqW97gIIeRc06kGwItAxtu+12pqVksIY1knzmeAhNZZiBPWXtWVoJgQy72izBF5rbKp3GTFhN7Mcoegu0f/GIEBOCkoCHz21XqtCRU+3rGsCwjKXPaw1qAeU6RzpqC2jcSFEcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4106.eurprd04.prod.outlook.com (2603:10a6:5:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 08:05:12 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:05:12 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] arm64: dts: imx8mp-evk: add hardware reset for EQOS PHY
Date:   Tue, 23 Nov 2021 16:05:01 +0800
Message-Id: <20211123080506.21424-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 08:05:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f582a04d-f0a8-4495-b905-08d9ae57f8f9
X-MS-TrafficTypeDiagnostic: DB7PR04MB4106:
X-Microsoft-Antispam-PRVS: <DB7PR04MB4106F1C84A119F5B50B217FEE6609@DB7PR04MB4106.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEiI26t95guIQuSAW49Ic9Ws6qZL36A+14Z/b8RvmjHcOtmujPewTn4idhHWRhYS0v3s0CM17x+ZGhlnztsvFD26q7oUO+LIV0jk9mRPDrhx1jpz7pFdPcQ5+EiyNdPXFw16E4Xw0OLWlSNx4IGDTlhWSa7vbw+VFZU/KE2RIghgSsTk1diPvVN7iCWMkte8ikayuqyBOF5ebHzXhIHab13a+5StdwkVttoh7iX1bFzENN6zpsWsQSMaC7hiiLcIpSTB7JQHU8YEcpGxhr8dgsFH+RehIucDNwaTUwzeDovaN2UNFdpj+tyVD5uIOSfnHNlzJ+3/xepj5KJMYNtio723Ozz/bznQiCNOUyr4+WYhlH++0FkrtN/Ggo/Klx3DCslZw9M2yFj14ArSyGvwpv49IH8cK23qg+CcFSkVmpHtes0K0uXn7e8UX2Y44q0zyeoVcfOq/uo7DGoCYPXXLbiP6vGrwoc2B5hJRpV17xlHq+vo54eBIjCk58RGnOebnNC248qA9wwr4Rqg6x4UONKyjLIjvmN/FfDn4e9prQY+yfS6mJd4Lj2Ghr/AxnKfkoXVR0v7r9xlHkyLA9EW1dQdM9T9KBgr6fUxt0GwedVQpJ71kwE8Fw9mX/P0MxooM9pu+ORKIO7wSrQXl3Y2E26nPQph4uICfz/c2UOG/6omIRgkmpcrXgztm1bwpwWomLyQfYe3tjvod+DGFtrLMi+xMmT9s8OmGoy5/DPuJ20=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6486002)(66476007)(2906002)(6512007)(66946007)(316002)(66556008)(4326008)(52116002)(8936002)(8676002)(6666004)(186003)(26005)(956004)(38100700002)(38350700002)(2616005)(5660300002)(4744005)(36756003)(1076003)(86362001)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OF6g5SKB1sCyW3xtLtLgelcFz2/EQEkjeuC3sNk/arHqGwfsdQEbzLO71ql5?=
 =?us-ascii?Q?CyRZnM2D20V6FToj7xgmgxpQViEghRh2Mh0U8CZ9ajKafoLBegzwdGaXBnNC?=
 =?us-ascii?Q?bK5/iG3ahsxb3hWI1yubB15llk2ZMcWft1mHM7EcJQcNatNeldibVivTt1Xn?=
 =?us-ascii?Q?RK9oNzjE5X5Z+Cvbt9VDiOhNi/ZkM2/jycamZZ+X7PqkO3ABHtTpsT1LYbly?=
 =?us-ascii?Q?8Xvd5nhpClqwvNd+OvWiu1VcFYP+fPbFV/d4mwLeZrrfhEdaeF+l8/0UK8zS?=
 =?us-ascii?Q?+FijTTVRcGDk6uyma1GA/FfBchLth3mYEt2tR+0ajg5fOoO0OWmwRQb/kH4G?=
 =?us-ascii?Q?7NSt9fy2dsUZBaM6G8l8LlGvM914/nGK4rz/8Nw8AdL3W45/VvTe0TxI88tf?=
 =?us-ascii?Q?+lrEUoIQDU0e2MiKN3/uRa2pncBvwcf4eeBbpooV2E3epYj1VlhttjMuDjCh?=
 =?us-ascii?Q?nQcLx0Aft4obMBWRQJanAtBpCo+aps+GPMlz1J8ZxtY+1HRd+l3+qaZLGPgN?=
 =?us-ascii?Q?5TeTD7mFpeRqmxDNG6mxhWiuckkxp/DqwbUmMXdWvk97viKGYRRQtqgieynZ?=
 =?us-ascii?Q?R+du7GptxmSpQTZ8uwYL87gknV8LSimgETovvJi42bkM4/vICdv4cGhoMjER?=
 =?us-ascii?Q?wC98TZAO88As+2beTB0XTd4KXobx4tqCVDxCsMuhhyjjLyOcxn4118OVCxkW?=
 =?us-ascii?Q?izRbyK85+EXsJPBYnWuA75znpiYRax8zUJ603Ajb6XtyHdf1Avh+MQ1bgzBA?=
 =?us-ascii?Q?yjeLKROzFgzcAHEH8weOjWonKm7oXXWZ4hO8Euj3fFwiM8t0++yFcM/Z6la3?=
 =?us-ascii?Q?92MB51dwsCThB4vuS4B8mG9w6G7/T8x79g2+CbhkBe1b7EN6e0HvYs7a/XSa?=
 =?us-ascii?Q?DPzApLhQT/XKOxtu3n7XcQSnue18BTHvR1wNQ4Y0THDqJqQ3R2965mPo+4aM?=
 =?us-ascii?Q?/MCnXgm1k/TKsh8VIGYC8uptzrVH92QN3/pBmNKGglM+fXjP2C/mr++64P4s?=
 =?us-ascii?Q?0jEj0aqwcbNGIW1H6Z6wwJGcWihA39pan55zImkBdLIdaf77nFkUnQR5a7Ks?=
 =?us-ascii?Q?Z2khBFqDRi9WSSjcNHlMiwuKY43FNfJRIZzYCFVxzvcVlB1nY/uy6+HlMvaI?=
 =?us-ascii?Q?9//HN6nSG5ApPKkWdXG316uJ0zLETr3BqlorgIeQUTpsZeh6K1/KL1aseUXN?=
 =?us-ascii?Q?u1HBAcfSaQy9H0xnstE/2RTcbGOeNG6JyUlkDWvLlxjOoZl2WyNFd/0p0WwJ?=
 =?us-ascii?Q?QTj16b20txlY0XWDx0vDhshIAHETiFSxpHg+eQ9O80FHolhMu864Le0yfhDl?=
 =?us-ascii?Q?gNYiTG3C43+lfEWLw7S2ue5IG/3BruvssLoiLzvZsTyHHAVGoFYSMNaJ9XcZ?=
 =?us-ascii?Q?UWpXyxUlP03Ef8QYwfLrnmwRV2JaBt72R2SAeUnpiQ0YzaKl38/RzF0vOkoT?=
 =?us-ascii?Q?3fk/bxx9QIVGMaPToXihV+/bIC7LA5GQWZ2fVcWLDW+uMchqdATa+EfsgwEJ?=
 =?us-ascii?Q?TZt05+E+aYv2EtayHsxoOGb4tiHXidy2PZ4CzazxUXMIAHW0/nuOXwehjWu8?=
 =?us-ascii?Q?V48brtrT2MkGme0ZJGDWC1BpAKTCQpn6nRe6O5FYZDwk2xP1uUYIuIYeGGpy?=
 =?us-ascii?Q?9Rfyqbi0atVAAdgx6bGFw8s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f582a04d-f0a8-4495-b905-08d9ae57f8f9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:05:11.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpbxSm7PRNekwjNGmLI93JGUxJBDErh1bDMMosHZ4oJuN+g/FQObf7IOWuRjZPOEhQyJUOt++Lb3UB8hOIm96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 798a1807ab13 ("arm64: dts: imx8mp-evk: Improve the Ethernet PHY
description") described, add hardware reset for EQOS PHY.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 7b99fad6e4d6..a7dc0d160f79 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -97,6 +97,9 @@
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
 			eee-broken-1000t;
+			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
 		};
 	};
 };
-- 
2.17.1

