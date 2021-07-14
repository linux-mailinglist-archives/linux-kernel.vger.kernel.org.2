Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED13C8452
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbhGNMPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:15:33 -0400
Received: from mail-am6eur05on2085.outbound.protection.outlook.com ([40.107.22.85]:10057
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239316AbhGNMPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:15:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrBE8VItlBQ9Svpo+R5YrfROTg6Hn1ZFCVzcZtQLcIPR00y69Uzw5qlMQaylAnBvsVS+iWx+eXxVEZp4KHWqsB2hVKdgxfpuzVSUfnl1rBYRcBVMs+gZV98uhdJGUUew5NOLXtaSMUNJuz4W8jgdl2T2vdP0Lhyj/0URTPYGlB/TXldsCfqMjo+Xq45rKsJG4Ehb3GMn9qSfQxH5fhu6vt3UcDnFQMPGtRYrxKJhwP3uJpGRiqO46NoB2ZXXzpNfVSrvivgJwWuT3dL2iM+IFQYFsWdS4ZdPieuvG9dQHHRjHOYNDg0EcHARhx+867vtoIcJ9sXOKsYk4N28DwRr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR/1NPzHUEE7Xqbwg5vKSVUow8kTNoEnbngJH0VIJ7Y=;
 b=g92LXy0Vd6LLO8rBGaWJUZERFMwWrNbi97xDiRkw5NN4FqvVt8M9YmxoHWWbUVlPVySs4kiAmbOlFJYVEwLspL/mWzJEhKQS2lqvZKMs2xwIRip6df7iD5Ae2sHd98JueJvc8i4vSb5DBihcRnq1TDrMNIdql4CW1Q++SEtHXeWxAYcLGbw1+cK9CU1OLZb6Ltl8hi3VcKFAWB6K57vO7AqlhlBiqMxu/FXyyV1wtYLQs8ibwu6MCfSXDs2TcrvvR94uiKRQmM5kBnLTqgMr9Fm3ezQa/Ar+q+e1MKXXMdTK99E3ysNRZporPDk5z/NfuO5Jx0GsHlixW8LMGba5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR/1NPzHUEE7Xqbwg5vKSVUow8kTNoEnbngJH0VIJ7Y=;
 b=P/QDGsbq3udi/tVCvx0gdW1b2UyihuvdemF0/nYRyyWqC5uA97AkIkQmj7DUkSxu80X41rzLu1ArisXJcaNKQrzs8AjWOl4JdtGFDGxK39+w8iogSL3yJ1nMIaJGafiZGyT6dmpFH5pBgqbI/OgAqKHe8JEYQTEN/DmI88Rj+e4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by AM4PR0902MB1748.eurprd09.prod.outlook.com (2603:10a6:200:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 12:12:39 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5%6]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 12:12:39 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, aisheng.dong@nxp.com,
        fabio.estevam@nxp.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8qm: added System MMU
Date:   Wed, 14 Jul 2021 14:09:18 +0200
Message-Id: <20210714120925.23571-3-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714120925.23571-1-oliver.graute@kococonnector.com>
References: <20210714120925.23571-1-oliver.graute@kococonnector.com>
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:208:1::15) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM0PR04CA0038.eurprd04.prod.outlook.com (2603:10a6:208:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 12:12:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 656166f5-ec7e-4721-31a9-08d946c0ac71
X-MS-TrafficTypeDiagnostic: AM4PR0902MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0902MB17481E554979CDAA6160FE0FEB139@AM4PR0902MB1748.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4N1kVZb54Iq1B/u7RcFJ0XT7uzIKnC5c9c1vXqvf/lOSEamHSGBkvi71hpE9zV1NRlZ9G7Hx8G+cZ/5YYuu+O3dNFPNdYOo/0IsGVdcPkkAhXhYnJSKuziKa5ZqlwxyrTUW76K4nzKSoXLn8SLm94Ah//H8nUDrLiyWnKqzkO3lnqmgj6OPaggnIWtNMjXxsaVxfyhJcaaelkOMoDx3Cew0yYBDxpIWnGKudIySJt5s05Ak2ZZUNkzMODntxq8DYn5ev5mZmAwQ48MUE8YruTEZgXt7KY2JNlFwYnZGvnoobQXhLUBpgR8ubXT4X4ET62a0zzUDySAGC2laC+gIosZL5rzSJid8a+KtzuN86lj5FS4sPUCoxcb2lPkaK/6nqWxR+UThuUK9az9Ni5QGKTHT0dfaDmkbWZ6n9NK72Ez9fl0uHHDVajLv3zvz3nyI7O6SKwsNmWnQkPEfwOaIUqbW1JRZFGcqlXrUJtqKsmFn78ogGRDjL12yA2hpLfEL1VElhSMziAOZuoeHu1p5HDo6VUKcWMpGJUmCj8DeO78xNfWvAyxyhb02p0znkm7dgLncT4yCRgGv/MRKgwNiObPNkqnloPVL/RyQE0OWGnnFgPV8aTouRnBaUCG9UHszdKHx9SJ+0ghmbQrJHk5BPDCY4FLFrollE+l2/dbzHPDxmCCA0vPMIHyAgUSWSY1BKy+atLYHSgt60X/zvMwhXm5ndk6+kQPG1nbcMnr9hq70=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(136003)(376002)(7416002)(1076003)(316002)(6486002)(8676002)(54906003)(86362001)(38100700002)(478600001)(6666004)(956004)(6916009)(36756003)(38350700002)(6496006)(26005)(52116002)(4326008)(8936002)(66476007)(186003)(5660300002)(66556008)(44832011)(66946007)(2906002)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tVhs4RDowo4uJdbMya5XXRGDsnlbUxca0hjh8OlJKTzCOIp+qfINC8lp7BZ5?=
 =?us-ascii?Q?0cW6LnQ2OG7o9l5vtjM/4x1mfGZFHaMbgJkSPkAhhGIj4/lHcl0pLvQUMyet?=
 =?us-ascii?Q?C0aL0wnW2qhE9w5LtZ/bEiHUPKwwms7lRWb749/JOMZVdCZ8KXC5BaP2LZFY?=
 =?us-ascii?Q?90uPMMbvB7HP+0XmvOAaY9QqhZbMmWh+40H6xeKShrPNLD5tBRPFzGIXoE3G?=
 =?us-ascii?Q?gWtQwNe/mJ5XSKP6vJv95IcDj0XH3P6qJPnrIZ/BijNwGhvbGi7AwHl6xXuM?=
 =?us-ascii?Q?rwlcRhoUxecE2Aqppn2V2w9swJtWffJ7alXqI8RmxiJpvfUv5GDGXdAmHvp6?=
 =?us-ascii?Q?q9PcYJAEV4DppsiMZYZY7/bgs4rAxLgeWDlqeZQbe2GbuYUyNqRKeE3U85Iv?=
 =?us-ascii?Q?L/M3oALvkurzwI0nTmWsV94OQ0J/i5tJltMidgYWJDhbHT4GTyB2e3ca2xMp?=
 =?us-ascii?Q?NI5nmu6URTdllnq/kuj8BzLxtmt71EDJ0qONpskKm2bK7ZNadK4PjNjZB8ow?=
 =?us-ascii?Q?Pe6rqzKg9q1XjuwUxREcbQ+UBIlwlYMDwKFQzmkk0BibfZbSqpLa262VcGM4?=
 =?us-ascii?Q?wJNuzTsZPV24GBAvoHXtn/8jNO3UJzOQfgxOwlLyeLLfXKNRKEQL4mJw4Tzm?=
 =?us-ascii?Q?bFZ3R0614Fpq/ovlk7so9IcrNQa4mUkN1OBfywtdxJhuZSCa+Tr5jwNwojeX?=
 =?us-ascii?Q?RQDz8VZ5Ut2mbk/KjyhlwGp8udRzSYY6oQ+BO9hIbCFzq/gKpgJBfZzTGCBy?=
 =?us-ascii?Q?Z+C1ep0RB5xlduZErKJ6GdkkxBOci8L4F9kbnS/ba3lTegs0DCV740SDUCYP?=
 =?us-ascii?Q?YCGAQ+e+CrqSRlL5Khb4yU9RmuHjJX/GLnZHPYCo572BWgetAJVQ3jyWZPYE?=
 =?us-ascii?Q?o3J5Xqm7wMKbN/yCQU6e8umqZDLDEjUVLArheVqmzc+PFga574d17m5fU0Jk?=
 =?us-ascii?Q?JOt8bQ2MTjZRV1pL6dqyJW6656HzrHBgUmUDAT9dEiQzCxzRuJyBOz3vogsg?=
 =?us-ascii?Q?LPB37EedKtlUAx9NMGQIs/xhHTTIMkb5E9p/qDZFmv26oFszIhE4HQ4dGHBp?=
 =?us-ascii?Q?kyugE2ySwCWZx4KUS9iH+I45VV9ZFKQo6+CoL4g2d8BUlHwDsGjNIZ5e2CRe?=
 =?us-ascii?Q?gPfryx9exS9zZxzRfB5zaUanALJDOu59DzG1khrTjDOQ0EMkIpVhu/Ks9Bhi?=
 =?us-ascii?Q?bO+k4LVfLj4rfdqTdde/6lMl0pOYuBZ+UXg/liKxOswOXyb5Qr8LUfjPqhVp?=
 =?us-ascii?Q?gLw3B+FFx9BPdX4PPzOg0YodZ9W5eXcJNawj+dydGEYaWSb/FfGvKmmGFfQe?=
 =?us-ascii?Q?/dgDqSH+rcfTWBRTREOzVupt?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656166f5-ec7e-4721-31a9-08d946c0ac71
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 12:12:39.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dl7RFbyIjnH/wYfS6yBRskLfhYJVXfI/XYhY44dt+vvf1o46NWkw29aVDCvvn/hpHwQvpEVP98g9PBLnw9DvowjSK033zXK3PdP5roknJ7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0902MB1748
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added node for System MMU

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 7efc0add74ea..fa827ed04e09 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -140,6 +140,23 @@
 		method = "smc";
 	};
 
+	smmu: iommu@51400000 {
+		compatible = "arm,mmu-500";
+		interrupt-parent = <&gic>;
+		reg = <0 0x51400000 0 0x40000>;
+		#global-interrupts = <1>;
+		#iommu-cells = <2>;
+		interrupts = <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
-- 
2.17.1

