Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B716436E55D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbhD2HBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:01:50 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:14756
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231202AbhD2HB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:01:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQO2OWGFjqmnec0GBF8LUrhi+IhrMn4XgGb1bvq4eqCYW/WO9E/CM5A4S8wSQdIAzpIvE1XCisUl2R7MYorlNw+zb11XObTkDhg/f3NkboqtaaXikckFeREITdW1LcqYJiDKN7lRHNB058cKd2gUsn1CF4Ph6/m12c6THR4YiGje9y7mD9tFvCsu4qipMMbXHFaXDXZafIYBIP1c158RMRiwKVzVgh46aDeggacfSImBq0a1OFXPf0WlCRF0S+fuattIwwk958EhxSx+LlRDuwDwb3BkdF3GbqcQLbJhkSHrVQHqp5GG2oedcBzq7Bg+KHMNNoW0VUizpfC9CJ3nKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt0GIkn1Z91P2rEtQcj8GdYvp0eIbCO3iKRwi1e9AhY=;
 b=BKZ0A2NU7XfKwsUjBzFgdllsqfp17sPh6mfitCwmLky3QpHvtaOUIha1Bh2cj8i1+RZAeLgttsc+lvBCeXK/bRqC5HKbNy0aNQ3GoelAsZLb8k4CJr8CuOgilmZ5GCjCQ4g9zkQflwSmHBi6yc1YSIrlOdQXntLiDNJKVIRSM6wSFO07G1e+iZEEauGhJtbatybQNNn/5zE8ipP1M2WAjExEz89f2o8O5eHOBU0+bZIEa41DU7iwV/Z0rx8X5+DoRe/qVbzTzSZKXxGwVH+hGUsLh9h7IjJWy+2jV8e3jmMu87I6WZSAErU1xbAt6Beu+aeREngFjlwwQWBOmgq3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt0GIkn1Z91P2rEtQcj8GdYvp0eIbCO3iKRwi1e9AhY=;
 b=HpP0gIMi29XulM98xoqDdl438CK8Lg8mB1uhW2JrAhx70lvnTXOhiSfwri59LoFjf7gvcSMaRbMPEjRYtweLEpiMK/wnbi02MAP6Z7KKkP/jvz+LFdrbr+j6FmUd01gj0w5UesdZLdXGhLmvytBY7C0T5Igv5R52Njel8pW8XjA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 07:00:38 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:00:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 16/16] soc: imx: gpcv2: remove waiting handshake in power up
Date:   Thu, 29 Apr 2021 15:30:50 +0800
Message-Id: <20210429073050.21039-17-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073050.21039-1-peng.fan@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 07:00:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d04067-85f0-48cf-760e-08d90adc7e6c
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7930C9746AF5CF3E4342BEF9C95F9@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03Xt0Oee8/Uw9QLXIFuK057f0WopZ5iQriehjNIsZ+fGrpI3LaMByBI9Fb820Go5hB09VGk9Img74vBkn3njJrPtdOOSpMGPl2i+NIh+boxZ2xtKqf6fCRDVK6XDdYotInxm2AR/tOUlBQxiAM1SoPHHvU+mifNPhmN0pDUCsKFshGlhGDeeojbBCJju+Hie9S1cj019LX8xM1USrn4yT77uvJDgQVg+LLjV4ccXOlxnEIBD9c6mPJFTDhpxstrPJZ5aG4QGW5qhm/xTrX9NnenDap7Lb4Z7dMyWVQSelNc4nOMjPfhEu/shrjZSKXaWhH67+qRJhVlq4ce9A2C744oVJDHOdLUV4H/+fOXPTUmmYJj4tZ3IERNGQdqm/zf+25Y4R+tOKI+BBfZDp7YX2RpATQj8WtigLJQHHrcJItI4+wFKhSdllNx7ufit7pTvMDVzGzwxz9OyyQYH27dOug1RXtYbhLSqm57rHh7Zl21N9XffbzOV2uAg0HgzJdATNbvPNgQFyVQSkWvxZ7vGCJk2xPrahwCAfyoZj6NgX3HIhhvtQzlsyW2HV3v972Bvp2DQDW3nSskUzVdAouyH5Nc+pu/YQqpquQBmOBmWczwh66KKzs+Ty/Ogi1XYXJWPtr7qafaFRWByigyqQqQP9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(2906002)(7416002)(26005)(52116002)(5660300002)(8676002)(66556008)(478600001)(66476007)(16526019)(186003)(316002)(6486002)(38350700002)(6506007)(2616005)(38100700002)(1076003)(83380400001)(86362001)(4326008)(956004)(66946007)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZTkE2z5f5NSOdbQdUHISGK00PrzkfHximtDFJrLyGWsXB9MIn/mzQecQ5v9y?=
 =?us-ascii?Q?PwX3pGXY/WSsNYVp1u9vl7QJTccJLL154MX4QE5/FldS9R5kw7PVrromuvcH?=
 =?us-ascii?Q?WuG6C28KQRyH0i3Lvd7Br7mvemsdY54TV0k3+5QQvemZhxHKATGGE0p8diHe?=
 =?us-ascii?Q?A/02x3wFvWPsZIflnfMfspkcGpAQ4fLEuSxBHp5VeLA9xO9WV34uylo/30Wm?=
 =?us-ascii?Q?NM5KFGtzybFHWbnz14rxpBNmFQ8aFGAtKjw2yB6sI33mcY/W5qoNXhXsXFn6?=
 =?us-ascii?Q?SlYubT3m9oTfvThREQHcuSxnda0Zn7rQn9yyWl+KksJBmuJ6kuymf+Hiuete?=
 =?us-ascii?Q?fVCT65aXIq6v8hsku4EQurKFzpMXDNoiNvTIMlPiwDbttBXuwsMeDolHUEAM?=
 =?us-ascii?Q?xXXWsJXgufAkZZEiziOxkA9tf6VIi8AgYJWvijPZsNRx+BB+Xrr8acACgPHX?=
 =?us-ascii?Q?aNGQgEeAYhHXVk0OjfzAmS8aHFpxjIrefXcnpIlOGIk7JIXhWz+APrs13mNY?=
 =?us-ascii?Q?ZJ2cYm74+DObqhUlDT7OH5957oD0ASj/TsM+szldTczVMJ4XsJnsLSfY7uK/?=
 =?us-ascii?Q?ir5TDfGlE8+nCHFS2pZxi5pvtHlReZT7sg1aeLHXSu2Jr1EhIQsAh3nIW6wR?=
 =?us-ascii?Q?0YkO7ooyVMmBcZXWMUNlgTwtjfgal4mn1MurkZrrnbrrP6zII9XWrWkX3bL2?=
 =?us-ascii?Q?gDjcDjWSgLmH3bNXfQ2XLBEoSTJuCR58v4nmnoK+K6/FtU6WH9HYl5Fh3J2S?=
 =?us-ascii?Q?NM+h7bI4RXoR8fpWfMEt7CvY8fxN/S+Rr6C6jg6F0ooLJheBGCEmT7/mDQnb?=
 =?us-ascii?Q?xz8KAywAEkc913xB9HYpTwnJTB6lUeX21rKMNpxVpYBv37La02ZroEUZdGz6?=
 =?us-ascii?Q?ULprPM+HUpcHjUf/agnX6XpDXj2xJdrtpLDpQEUGfsFbL3rhQAFMf6A0a76q?=
 =?us-ascii?Q?y8kCirSRp6Tmpmo46YJE5tE2KrS9dQUFNLTVhjmA7DlroXOn8GNx621mryLf?=
 =?us-ascii?Q?tXiq16vAIoC26oqIEZT0UvD+CHciK3ktRXSvPi4KyXdxzGbQ8gwC9fE5hWZQ?=
 =?us-ascii?Q?7tPwzoQhsD2j3a+X35fcjcM3KJGE5HPAmLZKEYMkH5a9Fw720BMzuR2LCh0I?=
 =?us-ascii?Q?t3MpYsVYTmNoIXsQYE9UszRcVNDB210++dILONNw84MOSFFi8DTbrf2DeAk9?=
 =?us-ascii?Q?USx+tePRMm2co1+K8x6rScpaUA43boyENo+gkd98TA9hII2JmH8Sm+Lw6haT?=
 =?us-ascii?Q?A8EhK62DDP/Uw2rK4i0qlOqRO1GCpLS19gz5s2Wpl+vAKtZ69q09fTRIsXyx?=
 =?us-ascii?Q?cnChDGYB0RVoLXx39mGpo3vX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d04067-85f0-48cf-760e-08d90adc7e6c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:00:38.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rz9Gp33AnDEBSy0t8HDkTm02K6QeTuzBv74RhWOELeJsHz2cR3nOliAYyBv2sVqPB1JZucxS2EZlrtLQpJQsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MM has blk ctl module, the handshake can only finish after setting
blk ctl. The blk ctl driver will set the bus clk bit and the handshake
will finish there. we just add a delay and suppose the handshake will
finish after that.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 49dd137f6b94..04564017bfe9 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -251,14 +251,6 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
 				   domain->bits.hskreq, domain->bits.hskreq);
 
-		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
-					       reg_val,
-					       (reg_val & domain->bits.hskack),
-					       0, USEC_PER_MSEC);
-		if (ret) {
-			dev_err(domain->dev, "failed to power up ADB400\n");
-			goto out_clk_disable;
-		}
 	}
 
 	/* Disable reset clocks for all devices in the domain */
-- 
2.30.0

