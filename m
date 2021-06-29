Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF7D3B6E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhF2G7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:59:08 -0400
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:41537
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232202AbhF2G7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:59:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWU/3eqvAN8UavLsi4/RFYh8Ek4128u/Ehpg5iteqDHFIdWQ0rPmXg9tvsGS9w8NJzFpiTy58E8mogL4G9wXDVM4b+nUAZbf2Ipd58iy2qI5hLGzDZ6ApjcR1MsYMk46YrCHK/q5GYbCf8+lznXLD1wc/phSoytVLrdAelxaTpHlE+mhePAVIPQ/XIaTc1ItESNAbT91VPNpW+TfiZna9FRLm6ybzn8xLh3ag36AV/KdGLi8a68wX1/6FO6wPQrgSJW3LpYJTx4mhR0P6U5cJh2oxWdEctZFKbe4rzWORylPUJeWKyGWoDWrWKRaLAU1ZIfUWT9pwoM1ZaPdfqNsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/woyMMdDjmoLpw+OB3GH/kDvCzq6VvqWMWVeZD4Bi+A=;
 b=SY62DrE204dirHE/kLBLN9iX76IDuSMg/p2QG+4/nz0LupSpOp8ejy1pj5QkQIE2B2Khedwmdw5/qALyHl6OU9EA1ogsOUkaPp7MOf7cGa6vXVanteJ8CX7CgglwgEdKeRO6Jx0YdkEk7dcbR069YagDbDLNCydBcxdSNycOdXh/OIxItOmN6O+kSG/0zke6mE/qFxkfwGX/Tk6dphOG/fMTfouO9OrBcncWhT0LpsagnTM9ZH+LXvOJ6GrFvmvRHZSgj6MsbVBnrlShmktmg+mj3eXHjpnKf7X2ovmz6hVtT6QQKfLu4LBbWi0V2a2p4x90WXmnrK44Yfba/DowMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/woyMMdDjmoLpw+OB3GH/kDvCzq6VvqWMWVeZD4Bi+A=;
 b=E/NcpAutrwU45wtG/xHEsK/nVqAJtI8M035MlWPL/NEs4vZu9I6g/0j522LXv8Q0h8ypvl+vL9PcAojkzi8OtRZ/InZukmMyptRWTkgEmgtABn/ZbI1TRfJWnrgw5M6uE9ylPOVFLQwL55vcFnWxbAZsEgW0gP08RXVdNWf9k4s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4762.eurprd04.prod.outlook.com (2603:10a6:10:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 06:56:35 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 06:56:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        jagan@amarulasolutions.com, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V8 1/4] dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
Date:   Tue, 29 Jun 2021 15:29:38 +0800
Message-Id: <20210629072941.7980-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210629072941.7980-1-peng.fan@oss.nxp.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0116.apcprd03.prod.outlook.com (2603:1096:4:91::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend Transport; Tue, 29 Jun 2021 06:56:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a54ec21-c91e-4d10-83a3-08d93acb08a7
X-MS-TrafficTypeDiagnostic: DB7PR04MB4762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4762AF8DBC3D41BD15001DD6C9029@DB7PR04MB4762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBU/gzfhjaiLG0td5NYJdhu3m5UO2CcvOu0MqzbmbzRcdFCfnBTZl6mkgm+PUD5O+5UDKB8z5xl/8VTin4QtEeEuI//M+AdF6zxKpz+cDzY58qfnB50i04ub5d/OdzCVqcaNHcK9Vr8ePP9ayyQfiE1gQyEtgQ91tQXcy3B0TE632jJyvToccC8ZF0GbeCBJaR96tLtp5dwXO/JN8KRFb5hEMotQvO2Usljelz298N3xztrhysSiRmQHhxFHw9tWU4Zct6o/SctWrq2Ejv6i210irC1cmAyle/pGOl00a1a09jMLoUSPYwqcGier+0/PYHp7GsoWUF9lmhCZ1qCnr3N0N3rmfLBQKEi5rdGICKnHapzKthQAxvE6d2kvghRH1l7nefQ7IXiURDNXR5y9KOEnp6ZJqweISEREsZW/YveeVvDOXCxBlpxYSHtxmgpld8d0THtsuinevy9F7Mu6ATdZbtyScjAU+d+ZXCRgWdTVNJGlGwkMck/01HaNrNA1AFqjMFTfYZsMVKprgPL3ewIp5XKbj2LEFua7UYcLOIlHSvunGj1wxSywT2lKrWbU01qBhFiH2TAZ0gHQFZGbHKxFx83UbAGn3oezClbb8ONR+f9ORGz+3hPgxLqqCICZmxQE1dqOmo+zC17OMr2gFAFeawj7AkYPTrEXB5c10T1a2PJ2fCIp2DNMca9Rv6gfQhcByJx9ttC7oumnzj/kJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(956004)(38100700002)(1076003)(478600001)(316002)(6666004)(2616005)(5660300002)(66946007)(38350700002)(54906003)(6506007)(66556008)(6486002)(66476007)(8936002)(52116002)(8676002)(7416002)(86362001)(16526019)(26005)(186003)(2906002)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/MfPHwjO2GANK2/eaD+hYFxqA/aB3zIWxsAmEoGcE80IO4BU1opvWodLjg3?=
 =?us-ascii?Q?JCl8hN0GF9To82uQAwoCmRzHQgfIpGTefp5NF0R4PIDxhphsVhfzfW128eBC?=
 =?us-ascii?Q?UgyJen3CrOHY7/b46j1gnJm0kbjqWIPdqhbUZf6FEv5qgGmjgoacGLBCI5yd?=
 =?us-ascii?Q?gHOIJ3PtApuX1q3AbZTezi32KdqrWKF9cY5VGDiCravkj35pVsoNytRh4SBB?=
 =?us-ascii?Q?JWN43/HfiLw49vgUM6+pC8EDWe4Ib1mpDM7UPjtAY/PE/NbjeJp2/dIcxBE+?=
 =?us-ascii?Q?mQ/8pz0ANbMaL1RI283i9Z6gylR3F5f4Z0EZg7q3w68cKsfp4sN6z0a/KqD5?=
 =?us-ascii?Q?zQ4zfiDRbdR64IPHkKrwDbpTNg+PiSE3S17Uybt3EOxzoJ0K68BsO74CIrf5?=
 =?us-ascii?Q?X7qaTGViPv2/RR8nWtcC/s4HJy6Q7RAS2CLaiuF/hHqIWW01s8tkqPAljv66?=
 =?us-ascii?Q?co6ZscysyrUMv3mVkjlEfaBHn0rMfsTxcHSO1p3GntfN0+D2qantBjSQXzaY?=
 =?us-ascii?Q?dM4wX5IQ//OA+fUOcbMIdOoo8STkP6JVdaMuGgsrUE2aNfBesQMpTVDAS2yr?=
 =?us-ascii?Q?1sYYrYl6i0nA+rNDqpTszZjTxd2+6tkJ29apnfgZTcHkZrId8YZDluQUg/MO?=
 =?us-ascii?Q?5nFu5TxfJlECmfx9RwLXNrDps3+HQDNrgqxZeiLaIwR3YRJxIvGtS1q4Y2uM?=
 =?us-ascii?Q?MgG/O2tqvSPix3z7F+/GgD6w9qOjDnbj3+AcVCQVosZIjQ4cQ06fkWOUR6NR?=
 =?us-ascii?Q?0xVlcElohweYwJoVTuzPe/yBFan1W209n+irSaI6xT6ZcZeO++BnwRm8GR46?=
 =?us-ascii?Q?oDg1fRRcMKuj8abG3K/KhaufDWuShU7FVEAyVMX0h5YcgQHP3LrtXDrP3P/f?=
 =?us-ascii?Q?ErU4vf+ZWqrTitsP2LwwnVVyhQFujSlM/WVsPzSgwxjujv1CnHmX+c7vdTsb?=
 =?us-ascii?Q?qAlR50vmLiR94jwg4bgGNw7OWwPARY7JEl1TQVgStEt/IdsgS1wGl6zxn0hi?=
 =?us-ascii?Q?Jh7D2B0qbhzg9VNLyZI896iyVJRUtB5/6UfA0doFvqdYLaljQR5QUaw3E+z9?=
 =?us-ascii?Q?2ewj8qsZhSoL4NParlrhwBLT00uQfXMtCi3lUZSsitonUD8mI6wT5EkkTJQK?=
 =?us-ascii?Q?+ktM0Hx/AKw50jR9Z+Y/rh++cfqDoyls0pkifI1EzyRQDq3oWtudb2sH+KgX?=
 =?us-ascii?Q?OLrF+VTF4UbrqXNH6mBE+Mwlrhwt0atR5bWptwjEfIXZ8PMSR4gGuieJu3hk?=
 =?us-ascii?Q?I/o8JChVtzxBR/xDyh3NWnLvrxhjHZfBy0A1QjB3FCKJhdlplKEsbdnY3jHi?=
 =?us-ascii?Q?xomHDJim16b/eTcqu8VUiCVT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a54ec21-c91e-4d10-83a3-08d93acb08a7
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 06:56:35.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVt33+OxLfd1SFl3Ha1UOHkmNHJx3sKjnt+d4ZVx5CLP95IOoKGgStyvL/96jiCwXfj5HlAqKSx7q2k+LjvSsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Adding the defines for i.MX8MM BLK-CTL power domains.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/power/imx8mm-power.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
index fc9c2e16aadc..982ca2939cdc 100644
--- a/include/dt-bindings/power/imx8mm-power.h
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -19,4 +19,17 @@
 #define IMX8MM_POWER_DOMAIN_DISPMIX	10
 #define IMX8MM_POWER_DOMAIN_MIPI	11
 
+#define IMX8MM_BLK_CTL_PD_VPU_G2		0
+#define IMX8MM_BLK_CTL_PD_VPU_G1		1
+#define IMX8MM_BLK_CTL_PD_VPU_H1		2
+#define IMX8MM_BLK_CTL_PD_VPU_BUS		3
+#define IMX8MM_BLK_CTL_PD_VPU_MAX		4
+
+#define IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE	0
+#define IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF		1
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI	2
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI	3
+#define IMX8MM_BLK_CTL_PD_DISPMIX_BUS		4
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MAX		5
+
 #endif
-- 
2.30.0

