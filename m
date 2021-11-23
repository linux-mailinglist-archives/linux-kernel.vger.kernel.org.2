Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672A0459D63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhKWIIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:08:17 -0500
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:22016
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234397AbhKWIIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:08:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR2+M8aSFW3bto17SXgiaOqttiF28slbpqRmq1mROGvFvbCpv5hmkTqiDg8opDGxq57CWCH+VJMwNTcjfgQUOG7Nhk78JqGaIAKMIJVTm4D5a7bE8UgrqrlNB3qgLpDD624Sc/lmcVFIf0Q6MeDFDuRM+hgZKhEmJoMeafGmWTsbL+3o7KlyAeKPYaT5HMVbz/Lu2szhv4iFamp/02Nc86K2XHuueWfdnR5B+WGNIvGkKID1PyuATwJ8/EKcirRRG2qA+smrh0ci4kKgw2ZaZM2BC6cKwCCUKEvVWoD12gBxazAPKw9hSBWofjLPRYmk0bEms4hwZ/j8k+Rigy78zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0Nwa5JzsFlJZ+prEzV7vs67ds4KuvuImQLtSNomBZs=;
 b=YPSmuv0ioC0uyQHpV+7rHRWcF2bmybblG9sSQy3SUCbQOVHSVSzMHMwGkJzITHljsL453FeURszYOC60pyrxM4Sq8S+jiMQT59aqYI7sFtx4qfda3w1hq2XG/LYncoFD80wCcXqhpkB7gnwjwnoh2f3wcGEKMIWtYmjruDDDgDuYKNl8y9kPORr86k6OH9bR+xXda9TPgx5r6TVQGe2cHwvV2zs7cXO8Ag0ZuxurghRFz5dObj4Hik5adBQO07Bu4PZc5KDSV0sIUgXLz2oq8CRY8yIzWJrz2qPNLUG+ELauYFu2TIafw2dl/ANILEOtEyOq0LFu1Y5Wcc+gZEasMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0Nwa5JzsFlJZ+prEzV7vs67ds4KuvuImQLtSNomBZs=;
 b=r8XXFwj0HWHSYFyMuR/2xBnyDqDg8/i0aLvWaK21qU6McImey1rl5wePhs8zmnxFciemnxLSuKho+IGkezoAZ8H4l5toPayWHNn9Y4qlu8gs3a60D9JoewvnHONE2Gjg//N0dmPqxzyEnXfAYl5tsBbLWAbD4VAyfEXwSEbBcX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4106.eurprd04.prod.outlook.com (2603:10a6:5:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 08:05:05 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:05:05 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] arm64: dts: imx8m: Ethernet improvement
Date:   Tue, 23 Nov 2021 16:04:59 +0800
Message-Id: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 08:05:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a273a3a-1b6c-46a1-017c-08d9ae57f537
X-MS-TrafficTypeDiagnostic: DB7PR04MB4106:
X-Microsoft-Antispam-PRVS: <DB7PR04MB41063BF1FCFDCB3F8B6646FCE6609@DB7PR04MB4106.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LG4482XkV7DljFvBU5uvjISDFIVCiYy1KcjhOhp96rBBHM/udfYl5riKVW0rbMpImVYS6Ojmt/TyJt2V8L4CAbuvdFFXhfXIOfne0yLvpw0Yx2ZdfanDMTGuk7bAJ8KTSo6gi/cKiU9HOuLPD2s79BTDLghPhqX8wGJbViP3IVfHvDPRDhD6jxc6juwFThHDtnN5/5HRaHjTLs33wg0281cGUSXWLmqeZwLlJEkTmmHuFT7wVPuF6rkmJbHS7VjzFq1Kjd7pqIoA6P0NwwSp+xyihS06SaTdSRByGtlfyAvueGpB7Dc2W/qkhDvKIMqxhMz1UW6jG7beJyPqpIymKqZmUczH6gjuL2hpnPKRxqCsZneVt5PX8UnPA8TPnRTlGmnrWqavI+pYeJafWmHtF0mtLi1awPKXFMBBM4XUGWhTefJ61ePrOdtCRGPQZX8Ehd3PLVhaqfN6Kgjd6DCRX/PZbmvOKplWNtR/aHN3NWD0zBdTeZNydUWv+JEbsbVWMQfmjhEb3iYNN5iPwuRfUayCH6A+4SUTxFvKO631u13NY00y3cCLfGgAvtoy48EXk3Jql8zR+ZJkuS/2gSPg1X1V+m4Su6/kv46y84o4b2JTMjm7Hp/PJ5H4fHMkgGlfLq/U9T/kV63c14DEfnvdjMbnuZorekriAvRunKOcaREk0PMG08ZDLpkLO0baos3BpfFuW0zdQJwofPOZ7f4Z7yhLpejSBQTeAMRLi+ZM0aM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(6666004)(186003)(956004)(8936002)(8676002)(4744005)(36756003)(5660300002)(1076003)(86362001)(508600001)(38100700002)(38350700002)(83380400001)(2616005)(6486002)(66476007)(2906002)(6506007)(4326008)(52116002)(66556008)(6512007)(66946007)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5u+8GKFtBqfYBUx8VCvtC2ua5idRiQCDkAIfrJS4cleiDPd0WaPnq7Z0RrV?=
 =?us-ascii?Q?ly6mC5Izms90XwfB+EJM5BlRQC5uA3u9cJ8+xM3IqrJ4wQymtAc3BPjVeXqK?=
 =?us-ascii?Q?yMXmPUyR0T5+ES0NBfy+1YBp3Hvh3RXUH4gGX50Y6w/io1mpaZ/n3P00SNwz?=
 =?us-ascii?Q?okMTxdfLKlZL+feJQYX+Z0+1lYyg2rSPD+uySnYlGlZCydTLMHwxQeDvQGEt?=
 =?us-ascii?Q?jLcoqVNvSdZLMUq9B+1yBGuqG+uWO85aRVGDelyKEOzI1gEvnf2/OmYm/apm?=
 =?us-ascii?Q?rPFvy9R8pEhvoWf6R31eNJ88Bp/Jk/cFQuadqaRnM0jZiSH0j0Ek8T1gTyRb?=
 =?us-ascii?Q?ocZp+MYjDiG5O0Pts4npQC/MuNA604rHdaDLAELHBpxmNLsK2nBscN8o0LLh?=
 =?us-ascii?Q?kqxBrL0ePzNq70brJgkHzv6Ff98GMA7vK5cKv1+2MLfRr0u40mRTkVRw3mBa?=
 =?us-ascii?Q?CpIb/ASr5bmkKan35YtZV0T3hM6GpHm3FJkiZ6MyJw1JdzspbCCK/pgpQgki?=
 =?us-ascii?Q?3FnnC3jTAS9eaT2YaFzFPyaBpj6QMKtmHfE/Ae6D4xkRr5pJetq00/31rkXr?=
 =?us-ascii?Q?V9NRY8F876Fwz27JIuNaVZVTPc7HqeS4l6MF15DxJHC0Q3auZrHYAfck9F9U?=
 =?us-ascii?Q?CvoXjH/c1UtIADNkbIop4KFGJv0s+GmQmlm2zwCqjmvpfBKcI47AifM0Tb7+?=
 =?us-ascii?Q?5ArKR79ksNPsbT3dNGw/uRg67Jylj6duGaS3+itiZu20lG9Z6+rieeMnHye9?=
 =?us-ascii?Q?ZrrFIP99hjV69fpW6d9ZIBB8jZbs2oVobJx/ipJbfTjLtzi1pzmFj7dSFnCp?=
 =?us-ascii?Q?lj2fOVtdxWIybwWUFPpzLx1g1nZ0Q8blelhU966yRG8JFDH7Fairy9JOaOFB?=
 =?us-ascii?Q?6OcWrG2ubfWxTQ7A4fWSTGFTNKUYqXVmYhQr8hKLZdPEXyhBG8xHASIDaDWl?=
 =?us-ascii?Q?J+bWa6XMo8CAbOg6t95QKy7ZwZbJ6iE9egIbyqpEzYH194erWSMebflyIg//?=
 =?us-ascii?Q?GAaVoqU6FnR7NUfFoNeBN+eW82mTi0531xZ1QLsRnHF3gdCC1cwJug3caTrq?=
 =?us-ascii?Q?V/YJwMiXF7jCPAK9BHLt4veO3ep4KOhS+hj0UzyQu3X6e3p9+qIEpY/dHWlJ?=
 =?us-ascii?Q?BT1jJ/yQ6TJCkb8kBnL+PAGvZd0j6wSijjqpGEFtiA6mDo5usnCb00i6oe/1?=
 =?us-ascii?Q?VL2sxE15C+Ak7MgIoNuE9DG4K6FFSnYjGWhqDjdNowwZ0uqaIXtqYsbVzj8Y?=
 =?us-ascii?Q?PqHCl80lZhMjBoABCuX0LQgrOSOw1aNrjdSmZNa14vwiBFZfRgPjJJrX71qS?=
 =?us-ascii?Q?RPdqKg4UFFQfM35mNJcRgattFXITHC7QiQWQ2g0R4966dhEMFjDU8hbw4GBC?=
 =?us-ascii?Q?0vwdfupn/863WvMcBqCusKwuZ4iZ9b5cHGN+K2D+MchUaqYfnnbxoFWrpxqq?=
 =?us-ascii?Q?3el6bBWgbJoJIFhCj2wfcV1BgLn88g0hnRfaAgMW6g/KOwwj6c/T4QhwrhrB?=
 =?us-ascii?Q?MUhnhDrac5pGi36Q+NipV+rJmxCCcHS6kOZz8paN2qkwppEmVpZ6Jcmq+Vdn?=
 =?us-ascii?Q?gsGsi1smgqCYifcSKkF9a5xdArnilGzkqvhn1fb4ejQJ+K8o/DCMA46SS6CN?=
 =?us-ascii?Q?jpYKbabBaTjW5C8W3BGUVVU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a273a3a-1b6c-46a1-017c-08d9ae57f537
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:05:05.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks2qp9tpTCTImYnhIFLJV8OQ+ysZo4vJqFSJke0mOKnY7ykrIWi2vp5CUbgOIX+ros/CwAJ6yg8JzVx0x4SDvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Ethernet improvement for i.MX8M serials.

Joakim Zhang (7):
  arm64: dts: imx8mn-evk: add hardware reset for FEC PHY
  arm64: dts: imx8mp-evk: add hardware reset for EQOS PHY
  arm64: dts: imx8m: disable smart eee for FEC PHY
  arm64: dts: imx8m: configure FEC PHY VDDIO voltage
  arm64: dts: imx8mp-evk: disable CLKOUT clock for ENET PHY
  arm64: dts: imx8m: remove unused "nvmem_macaddr_swap" property for FEC
  arm64: dts: imx8mp: add mac address for EQOS

 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 7 +++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 1 -
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 1 -
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 5 +++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 7 ++++++-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 5 +++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 1 -
 8 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.17.1

