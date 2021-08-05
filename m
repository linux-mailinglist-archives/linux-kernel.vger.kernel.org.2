Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFE3E145B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhHEMCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:02:23 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:52366
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241233AbhHEMCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:02:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo2p6ItmrYvtbgXu+PjwllHGsrSWlGBptHFdZUbLQD51hOSMhq3TzWSkrXCmULCx0Aft+QK7Hz5JcXRLgibrBXINMzHWIEmVN5ThgVRH8tPEHZQ1Hq+mkpRYPxBn6tjacu0wz/YBVtXPr3UZv2RFLGBBOGxxnD9Bwx53SvM8ntXIcPZvXvi9LNNahb2fjp8tpAxLdF/hEs2LpGLxJ0Rtu0KBNdS9ZfmWdM1+bUdQb43IKfJfDhwMjgHK1RHuMYr7KSnuc1LicigCCk+E6J2AkXxiad86pKSij4EGJSN0e3K2ka18poyWb0sRzsxXHx+jc25J4mFcmec9By9XYF7JiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGM7xdNl8qTh+F2OjSu0oxVzXyI1trZBaIy6nQkBlTA=;
 b=AvJpniLwSFqad3S8+4eVifOLqlEZA6U8ur/HLHTZ4qrsxVvKOu0unNDLYgzu46ANYVeLn2DTWtKiJ+QsyCqK3e/rToCy6rCf6+af2bGufzz7cANcs6cgkS/U1nXSQJlf2DLYWqw+ZhedgVP9jBIbFrGgugMFUooJicNUk/MdR6h7yVtkqCLqufQY3dLT5Y8WkzvaWD9ftvTsGbSZn1Idy5btzjnjVgiQzMI7kp7pQEwHLqByk6K6jxRxV70Ie1YyOjipElG0qAspSRqUo0JhxyX9HVQZQNXozld9oDcGUzo0Mq50owxeTc6Kt1kjeFz0EnFIN0zhftOTvlZOFX84hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGM7xdNl8qTh+F2OjSu0oxVzXyI1trZBaIy6nQkBlTA=;
 b=z2FZH9fYRay4LqFhJjZJ8tDkM9BpwePltAkNkGTXgc1KwNerejWIzbgvERHyuDdqj3gEv0cPGBAKkOk61iJtqhgJIh6hkw4nNjeCsSbm0zwssdyxspiNh1mSyRaZqLoAM75xLI3JmIZssT+WvulfpU/Mc1H6jtApMLmaALXkFNg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB7PR08MB3865.eurprd08.prod.outlook.com (2603:10a6:10:74::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Thu, 5 Aug
 2021 12:01:33 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 12:01:33 +0000
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
Subject: [PATCH v3 7/7] arm64: dts: rockchip: rk3568-evb1-v10: add pinctrl and alias to emmc node
Date:   Thu,  5 Aug 2021 14:01:07 +0200
Message-Id: <20210805120107.27007-8-michael.riesch@wolfvision.net>
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
Received: from carlos.wolfvision-at.intra (91.118.163.37) by VI1PR04CA0099.eurprd04.prod.outlook.com (2603:10a6:803:64::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 12:01:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0362f7a2-7a29-47e1-181b-08d95808c43e
X-MS-TrafficTypeDiagnostic: DB7PR08MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3865C734A0C6A3B1CB1D490EF2F29@DB7PR08MB3865.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x65xH0eq04fYIXy3Z8Xy8DajLtWj4dcEfgV3GnU/FOMFoxSCcckMWOXymW7CwZ/U2UsluBiYVtLvwgs7KGuiU3RCwm4BGw7aRgCAqN5IppgPMmqIKMOPGi8BHhzJQ0/9/hoGV6qfqDWpH/2y7EBeMCqff+vySXbSVp+itNWBSreSOdfS6KfpoN0sb/anWgFwYDqBeVHuptYU6JKHespEkBTny+aj3vXTFqg9pgE32EASFSMg5znAoBEtq/NEJuA/figZ53z1wiGWP24/DWGYVo+6a0CQc1/lqDqbXHhCp1/e0ctGty3ulqZMU709cXdXiTiNhBWBCG3F49cVWlGFB6TeE5ezjjpyxwXNRzXfOFQ43fqQgB4698D9iSEG47J3AMdkw3EROSXTlPaqsvr3oZ0J+41QotJ7XTwVyoPn/6FuyZQXJI463nuHFB8oFPH2fDCJNFnm0euV4SPHTAGiA20ADKxrRxhJiTdTGJ0+J2HszDgbv65WChXea+RMUDO9kxfwsIqz2umiG6aS2AfUCt7i6FoErQL5AnSR9V0KEdZ3JyTqnl4TUB8KfwL7ORaWQ90HhKTOJRAZjjKRwSsCLR+fHBtvCoTnNPN33Y4Xb/Ep212I5MT+OHZioDrHYNQD6lILJ3SRL+lSPvMoSqGDBOfP1B9TavnW0btGMcW1RpJtL0HZP72BZmyT89FF4l/iDJWbRVUHLSJ7/uwgUEJ7UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(26005)(38100700002)(36756003)(2906002)(6506007)(4326008)(66946007)(508600001)(66556008)(7416002)(66476007)(4744005)(1076003)(38350700002)(956004)(44832011)(2616005)(54906003)(52116002)(186003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ho7hqzXwtUVO6PcMr4HtDvJL8lJo8dSvv7X2jUM9Lli3QvV28pPssTGJGi9Z?=
 =?us-ascii?Q?dbMqCym6I7GG/ys/HhI+Dgt5Cyxc4rcOO9Dm8R7i7kV6J+HrqS6rk8bG6OLU?=
 =?us-ascii?Q?i3tdiWw/hLOZUYMwo+FxgBi/OgOXMt/EzLo5dfi6ZtlyBRr55wmod++C4xF5?=
 =?us-ascii?Q?x85FznSoygT8s8h4p6uOX+/SYRYi02xHCBPguh/lEabp8JyHdrI7dk928qjJ?=
 =?us-ascii?Q?Pd4UGKzBgKtqAsrVWasqe8DSnmCM3ifI9Y8x8zE5/SVVolAsLKowpM6eLPBP?=
 =?us-ascii?Q?VMf6tX7xhxF+mGH0KQH3RL7707wq7UwMgqcSXQqS0uQJRlqbq3VL+Kvs/S/k?=
 =?us-ascii?Q?Fl5x8jbZJm8vY7mTX6s4rk0q5BWPZTE7kXE2zbV4hsBtfMzR8ThPlJ18kau9?=
 =?us-ascii?Q?pf6ObEdNNqehNNP0N3oR4hQdwFdfS7jSiS2laqAuwoC7T+687mElwg18JcJT?=
 =?us-ascii?Q?EJMbJfVNGwzTh9s2wmGzvxeVBlDKIZGtaFBX+gZ4GeAsE/tQFBr08vdDecBh?=
 =?us-ascii?Q?YyhEuip/F/Wmac1ZJ3BTZPJdWm1ORAqX6vnpcCg4eg+sEEWDEL2mNy9mUxm6?=
 =?us-ascii?Q?tjqH2yhGAJ7dqZv9F1B0jUfqG6wScsZlsXL3CSwQNxxCu96StLVLW0ySrPFz?=
 =?us-ascii?Q?CHcfaMKEMQH24+XHqx3w3L/qr72VKXooE/BQ1x0RyibjbqR+PAJcObKsvYJ1?=
 =?us-ascii?Q?Wgan0RbxgHUyHrnyijROS3aDkm7oqq3jaUK5AUbKe93EcF6p8DGDy6k3rSdm?=
 =?us-ascii?Q?a5mr1t2paCXRnE8vkJf4X6FpWEJWGGNGL9TucavtUTrK9gujVCPH7VFjfMVu?=
 =?us-ascii?Q?Ievton+eYGeYK2voTGE/aoeIssB31q+rTIb5FdDVhMg6KC2/C3KgtEAE6/Du?=
 =?us-ascii?Q?dqk1naU3FcyZyWKGByYBMvmB0XRzLTEjgn3R6N1El0hvShJnawlCbcnTbQ+j?=
 =?us-ascii?Q?KELYIUegl09WTKIByDHJHuqJL09DoF7cjgocmKVLYXjzU8rlSqgKswNaTBRj?=
 =?us-ascii?Q?7xgBgyrHxJB+dcYhWExjQbYuzCO+gBRoz+YFPYgRhkHk98UuRw5I6rB7lJ3H?=
 =?us-ascii?Q?TaHbAkwYINvV8pKXHtEma3U2ubxy88LL3WNa5pvrvlW08npIuY9HO+/nH3o8?=
 =?us-ascii?Q?I2u09aJO2qrCZ4aj0LbQjJDrD8R7kf0V60+8b67GDi7RdHFhDJp1ryHeyExV?=
 =?us-ascii?Q?RDkP3bdReV5TGeJGS3BDYlSoasW5jfSDhdIVt3k0rekZsmPSg2cyC4RIK7Yi?=
 =?us-ascii?Q?YYs1G4NKKlBx51uY4+HC6MBglbyZisxhj5PAHzKN/2XPhIPhsUjr6d1Ab9AS?=
 =?us-ascii?Q?CCiBhP8abtDT3qSTwKJEZVLv?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0362f7a2-7a29-47e1-181b-08d95808c43e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 12:01:32.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N5yDLb6C2DVyWmsOIjRqcxwZTCvNDRyWTxr1wVC+YHvTVoS1Thnl8gET5HA44jLqJHEPWR3gVovGToP18Qia5yRF28v/X5jUUAsZ7kJ07U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3865
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the EMMC pins can be used for other functions as well, we need to
configure the pinctrl.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v3:
- revise alias

 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 1c34d529b771..1bc79e95b2fb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -17,6 +17,7 @@
 		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
 		mmc0 = &sdmmc0;
+		mmc1 = &sdhci;
 	};
 
 	chosen: chosen {
@@ -363,6 +364,8 @@
 	bus-width = <8>;
 	max-frequency = <200000000>;
 	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
 	status = "okay";
 };
 
-- 
2.17.1

