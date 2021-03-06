Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C1532F9F0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhCFLl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:41:57 -0500
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:47969
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230208AbhCFLlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:41:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw2VDkAveTPAP9QAddOfTFi6T9WgolwHLX0t/7er1HFVFSbYyj+ml0kNFQwdoDEdI4eiAw6kwndNsWe24892cbqoCAC3f4bOLjafKupJvbydtTPKfHGkW0WVWlsbWz4FX2QNPnIgCC5s69cX9nLwzpElww6wxqEKql0qg+sET/bHPyNT62WpM5xuBwgbNmn3ezZnehsN/5A4m0bfvZdB4XeKUCC/Cor9muF9v/EK5A1BnIHV50OAeczHA3kV0oAetKEL6q1HekC+gjnyADLTnvtpBcABbapnfSaRKZIi/fkN4mYAVMN8YTi03R4mI6VMz+TyKzVcyUh8gj1vHpOnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AITUwyRKxRZp9pgVMvI2v3whlC6IPwz7C0/2JRL/glU=;
 b=KSouZh79Q70X8RcHQn/du9QqKzEs1vezgPupK7HcF+IjtBLDdSC2jk4+PU8oF2oRXF/pnkY9YXwaCHl+btXPsG+oL6HFDVtogZg/hOBQtusMlXNS6SgrDzYqThYclN0dqU4Gr0e22V7RUc84vfuYZdO+St1U1NmCwm6YdcPnLq2b1YhBIGlbz8Pg929y4kgYlpgVX3Nr684UZbtALu/TiaP0BMwPV74YumGkfHiDGpomiD9Upr826Vi1CMH9JVTZUVlV3GzkBZIoLS+hDGqohJjNtRvYxLEma5L3Z77ur7ylUjU4Do2hl12ycqi6W/CvXqQxolnIGjX0bXfeim8WwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AITUwyRKxRZp9pgVMvI2v3whlC6IPwz7C0/2JRL/glU=;
 b=NLylvLgRPzBzxXktFIivQj7wbxoBq6GDfX9p4Y+NK5VxKwHynxVjXz95XqOTlYNUEs9HqbBvFYtHEw+E4rF1gjXQeocg6TqRagvqSWagI8TewVeHtiCgyBUCULyTf2SNqHTWXfx7J1fkfnFYlbEY+AR4Nhk9Rypz90oP8DIw3YQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5802.eurprd04.prod.outlook.com (2603:10a6:10:a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 6 Mar
 2021 11:41:26 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.054; Sat, 6 Mar 2021
 11:41:26 +0000
From:   peng.fan@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mp: add wdog2/3 nodes
Date:   Sat,  6 Mar 2021 19:28:40 +0800
Message-Id: <1615030121-23439-1-git-send-email-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0192.apcprd02.prod.outlook.com (2603:1096:201:21::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3912.17 via Frontend Transport; Sat, 6 Mar 2021 11:41:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf73eda7-8a4b-4a4d-80bf-08d8e094c63d
X-MS-TrafficTypeDiagnostic: DB8PR04MB5802:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB58020AE0652A2B8A6E0A5314C9959@DB8PR04MB5802.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R49ULsPZvITfxfc86lH8+xiOpLTev6krWEp4fHeuIEKoBdmfGCJGOs7Chkbyhk8tbWq0awPhtDWmwsV3bcpGVIgxHUlv/l0kmxmMhdsQa4Y6AgNDpWC+PBc5GiA3JZJOqUWFy1xpgIFL2nLoR/irJNIeWpmYjbOzZQELEgMAbfFQQxxlDQTGAVXQWOjwJCqK+OTFbgbcxK9UqsvtCdleZQlaho0GTLnZ1vvknjv/hkNXPkdy6nzsg3BaBnnZ2XNZK32m2/B3yWbqlD0ribl9dERewPQYT46boEN0J+eNduQ+S47hl92+pFByxnL5zEPWymbPK8orCK6tYtK0tMEgyzloFLLrtuIWsaTazXMZBjj/dpapITfFVF2VaiSMV8YOpmUTbmor4zlmRr2pD/3BMBdGD3aQtJ46tTlJoUuToZUAPAJtA2lQtGzqKKikf2dGsiAUMj6U6FW3MYBhIEwK7jX974qqUXa5b4DmOQZFG0vzd0fyPx2bbeOkAHaGbWptCiIBaySi8/GYI01fu2DmZc5h7rk3bes3+/iOtfhdN/3buCxSVW83nQU03e4183LBJfV3nFn+zWNNkSdOGbPxh8KtO47fyasNTMs7xcroXGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(26005)(52116002)(2906002)(316002)(86362001)(16526019)(8936002)(5660300002)(6506007)(478600001)(66556008)(66946007)(956004)(66476007)(6486002)(4326008)(6512007)(6666004)(2616005)(69590400012)(9686003)(8676002)(186003)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gIT1wahj81KwRCMF+bjWQ5BGo0AsGq9yd1AKeYhnQWEir1yNBTP6kavgMMBx?=
 =?us-ascii?Q?OM2J/y1S323zu8+RS4CVfNlQn0Ky+PCH2lXQM8rkoNKZTdUd9sMTmcv6s8rz?=
 =?us-ascii?Q?0qHhi4c9aXLiROX1ULVL7YOAYgsKQAWp6ODqE8ckjeKqplj8aPC9dEHuH3VN?=
 =?us-ascii?Q?lfpuqpdILsssfz7VTiH64qScG9hidiCojtZwDAnG85F0o5G3oYQhGTfj7Z1u?=
 =?us-ascii?Q?eZKB5cb0Z5itRCQq6H2tnGMlGdEKevjsxoD/LtKuSgAhMTlS63aq9Ig9ek3R?=
 =?us-ascii?Q?xS2uUdTAfZZczMpMRFv+LbeDIw/AguwIjRNXXXbr11IMYdEu7hgusjz2W7sf?=
 =?us-ascii?Q?CeKMRh5RAp65EwdVPNGAcM1S+38qtDle9VT2J9mItCwoaP6+Z3F/TSiMoXm/?=
 =?us-ascii?Q?Sa07UwB3ruwLD4kksGCo8fdK8HRxwnPXrv4h4ZUytYX4aAY10RaMLut+N+QT?=
 =?us-ascii?Q?mc7eq2AQvrpL+ahBDlYJ7PrqStOumHehpeHvfyzghdAk0LD7reqkn4e4YPIH?=
 =?us-ascii?Q?EmvTqte2GDRQD1iqKPtS/H4Mn05pgByi4QVzHQuwhbX3cM8soNZDBujALMOg?=
 =?us-ascii?Q?hc/pNyNSXJJ5+q+oJbqzJLNjMO3Pogs3dRGL89BrQFREM6CXRBbAzd+5F3c5?=
 =?us-ascii?Q?rHaRL+aZxHE5A2jMFvrr8huTzgSuAPrcq+Gvyk1+47CzX4gIyTBd6F1ZtxBX?=
 =?us-ascii?Q?9yrxETrgGmb5ivjAU5s+jcEhfSomrxhLTtRTYHH/wsDV+eva5uo9AAw64k9v?=
 =?us-ascii?Q?MkU/LZWV2eLyzS5Bg7CdImPocIn4XTpboAUVFJO5VNBp67IhjtjGSgAnFgiE?=
 =?us-ascii?Q?FyCPJQOVhDADHzOvx5sd4XkUTCgnVLb7gVPGdWqU3l7L8XNTqgg5Tv472H7d?=
 =?us-ascii?Q?ZwNSwP3UJMJG+85wlUHiMQ2d9ybRZ9Yg7KpfyvNsG0DVZOC3/lKTMmX90vrr?=
 =?us-ascii?Q?17C52UcX72OklJG52MfYH+Zkw/JLEWxdX/xuV4LIMUgvL/vRhwlin4qFQLfc?=
 =?us-ascii?Q?Z1iCRctrK/2+xJkoSiLMtyMEzVcqoZKMHyv8mY9vOr4XNkYNm5YEAgjNkz8r?=
 =?us-ascii?Q?ieRObbZmsOYnBRN/O6HreEd5fQnQXPyjARdOwqpZqMx3c0EsypeCj29iCHoQ?=
 =?us-ascii?Q?/H2A3PtijCQeD8eVbZ0kZYaGqHn/3aLkq0UeJ++vkRKFszMiWHvBFIBemV5c?=
 =?us-ascii?Q?SZsyqh7CPcnhUkX3k8JQ0ZkNUWOXd7IgI/vMR+Wkj8JdJTznBdjZ4+NsbVh4?=
 =?us-ascii?Q?rWz2620t/RVD5RwMqig/6xjcDBa6YRKzwYgTFcmT+C7UoKSECDgVAY7vF9WN?=
 =?us-ascii?Q?+iYqioHS4KRnubAFDd1aj5gA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf73eda7-8a4b-4a4d-80bf-08d8e094c63d
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2021 11:41:26.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFAtuoFVwCHkAozfGHEl3C9p1IkOeqWamsP07y6HQViwsBOGIGCtmPThI3SCq9tXNj0ghvtyDF9Qlm+J2xPzpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5802
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is wdog[2,3] in i.MX8MP, so add them, all wdogs share the
same clock root, so use the wdog1 clk here.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c7523fd4eae9..05dd04116f2e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -312,6 +312,22 @@ wdog1: watchdog@30280000 {
 				status = "disabled";
 			};
 
+			wdog2: watchdog@30290000 {
+				compatible = "fsl,imx8mp-wdt", "fsl,imx21-wdt";
+				reg = <0x30290000 0x10000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_WDOG2_ROOT>;
+				status = "disabled";
+			};
+
+			wdog3: watchdog@302a0000 {
+				compatible = "fsl,imx8mp-wdt", "fsl,imx21-wdt";
+				reg = <0x302a0000 0x10000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_WDOG3_ROOT>;
+				status = "disabled";
+			};
+
 			iomuxc: pinctrl@30330000 {
 				compatible = "fsl,imx8mp-iomuxc";
 				reg = <0x30330000 0x10000>;
-- 
2.30.0

