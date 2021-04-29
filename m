Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9636E564
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbhD2HCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:02:02 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:60161
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239310AbhD2HBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:01:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3fzDnKk9YY4eLok2lEhRGPMo5xA0dtDrEHuYuQToROPisHgB3RNgwC5Q2vaek11LGLr+QNxQWl/3YmZ0O2CSP5J3YmjsCf4trdJhNCfX7ni+9fJumHck9JBqo1uB3yLzrXUvxHPjDENb9mpUotqI7D+0uxtPK41dJ3zPGF/oMZmAKN4yhBiCBOhP2myDmextjWhhw6pSi/0KkZHuE3q1r+ABwBXhmDoJaGvNB7DH3WWNjjvxdca6UeC9nPpfovP7ih31IeTv7wbpVHQs8V+6bN/d3JYeaAvZ65VVvJMdeeZtRyHswByRM4AKxP4g6Rc2IvU5Mw+xIMi+M1FCA16DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHBirtV3NAhw3AiaHaqJ6lCADJMK4dINT7svEGoqJ+4=;
 b=hQYQZ4cIhqHRCCs0M0TWPds0UGGaWGnNPeiMmBdlnpcEXEnwHrbWUWfl8SjjNQU2CWSMCac8adf+1lV86g6X+G6ApGcZzezP1upp9S1Cpgc+Qv4GZSof+mzQIaS3zWHJ3TzXDHjrlc+NcnVhwkL4PQxaN3MHLuT7NKcbZYwNgIohmLME6B0axvo1UUbEjIKMTmbkE7r6iQuvNxBkTGN5zyuRw0Tp9O5zGsx3gaThcSIS6dFDj18Jc2LSbjrCELJUKtosw9V8Yh+WMl050p0/kGQO2ne7UCuPaP2mhRpEKUVDNgc+bWfX7sDzHYhm4L2kxnr8QXD+fdB57TmhPNU4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHBirtV3NAhw3AiaHaqJ6lCADJMK4dINT7svEGoqJ+4=;
 b=cO5QRugmyT8ryc7LyFoP5RGTO7wAjAXbP0VDLfwtnBR7w56OeT3xF5UrakmM0LPKE6oGT0ImW9QM7ciD/ofrro77IUiOBJipP3y9F5q4aggb65lIVw2UJtitfBRFuHK2k23Hyl+3otGji4IVyyQJjgWrMtLhIvF/un6eZtSreUk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 07:00:26 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:00:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 14/16] soc: imx: gpcv2: move reset assert after requesting domain power up
Date:   Thu, 29 Apr 2021 15:30:48 +0800
Message-Id: <20210429073050.21039-15-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 07:00:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea4b35c-90ee-4a94-b26e-08d90adc7722
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB54686CD4B17CA63648096A5DC95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHwKodM0mHdLdC+G92jbKoGVq+9Y5K8GrlbiVjY34VmG3nauwNpDABZocX/0W7oep/V41jJD+Q2yw98R1mMCIaC4G2BnQDIKQcGA3vfFjDXYU9ZdWc+N/mWsK50sB9wb8mmLvowwyuxDA4w8G0bqkQBTJ/GkVSiIqmQ7C0Pem3CMVkoJK8ApXATqKieHDmH8tpFekKEIv0J3EL4+Z6VzuMDHPX/ZRIVYk94cTCdk2cq+iDshTl1wown4MDgY6JiwNMQt8e+hEnM5BJSa88MGZmB7EWrLjvr7rHEc5HC8dpyJ8EMwjxAPzSCsVIl2CzTM6ngBxxUFiYdlCMfWE8vAovH+jtzS86DeBGUQ7UZ6oj52gpGolzB1DZn9ovUQORr3T16CLZyofmZEQajEKkX9SqF1eSggnlvL/ZPo0WUsEbzsiZHWG3zEYNkTILElTN0XU0EeE5o6WDgJAudiP7WBhU1JlV/MryzS4c3DMTUkwcR+bQrETPFdvWBVBTgv3wR4LGzA/Qni4RxaRLZKn+bELjf5I+sb99sUp3GaBsbCs4qmyYIdwxqN4sx2NoT/BL83DM63rp5Ytn+uLtwNJWneRxjX0vFgfxBWJifTqFEzvx4NvlLkJULSoa4zQsUiM+b108nPMgyzLZxInqyswXyKJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5YCld2DVre/yPv41wT47rLAH83fjQADRvf44H04gSlRX1x513y3LBYPC/wOm?=
 =?us-ascii?Q?kNFEp5K0PItR6WEf2OF0UmYdu82O4ZEX6ooXQto0yp9eKOzDqXOp0+8wftes?=
 =?us-ascii?Q?TVhfMhfLDHqFLDJkesOJLppvmmOyZktiZ+jERoVWvDWQOvXAwUhniR05BLYL?=
 =?us-ascii?Q?+9PfJcDLObP6kXHDutfhX1QIITEbtLp7/PR72kFYIdu+4qdtJoEc/SU1kcMr?=
 =?us-ascii?Q?iv0gq7YQntaAYNU/CqHzbMVA9+TVj+ju27Nk+byvPikuQSOlAZwLQgiTNucO?=
 =?us-ascii?Q?auiJtYl3AaouwOzoXrKrrTmEetIfSb0FI66feNcgovI2AGz4DYNhMktcqJFi?=
 =?us-ascii?Q?Ctlmi6cDElv7d3+WJUDopj1NtNQOulyB1dp+EVL3n0Ojda4CIBDgYbkUyxZw?=
 =?us-ascii?Q?Ph/Ja2Gh6m1G+USE4OzMFoiwP/Q16sUoBnYudsgcrEzkBjMeEPurJvS72Ber?=
 =?us-ascii?Q?mwL+vXI0cWalnkTK7ewgc9JMK39LBzNGjARMBSwsgfbe5YPVMVsRb6p77qUE?=
 =?us-ascii?Q?0F4LW5JrAmPhhjk3mVU41QB52A63EubEfis0XzLWWefg4STEy/QuSUwLwoFV?=
 =?us-ascii?Q?xER/j3v2DnDfnPzSmBJsSHHuJ2FXIet3LnJP1prIuXglB8DDt7bjkldncwua?=
 =?us-ascii?Q?UsRDy7H396QybuV96VtbSJw94zOB1MQ2PHR0N0/Nzr4mGINl1jZfVawH0n5m?=
 =?us-ascii?Q?DJFfNIU3Ff394Bi5OvhBmwpulluSHZJjRP5S6gIVAmy9NDiOJh8lxQRo/RSu?=
 =?us-ascii?Q?JhKEFUrRFzn6CuKeFy5fVLwpODn1JFraDxetuZTrtj+z31QH9rmIhrQGTISV?=
 =?us-ascii?Q?xHq9eGpOsno1NpD1WbCnblwaPduJcbXnvGCWR8mIPa2bBM4oyoxmSC/4nNTc?=
 =?us-ascii?Q?aCuU+7wtzhwsQecOoN+o7pR+UteUkhiorHNIwtGBEECt0hxE1jPfU8tb4ETz?=
 =?us-ascii?Q?qfZ7Jo7ee9Ber9LCfo5kqUjBWP6j3XAfSHA2pdFAWBPGUxxKxprgqnsEa7Oq?=
 =?us-ascii?Q?GydOUfi1vgy/+FF47AFNUpilkH/o96EgmDxyoHFvfRAAIjsmzTDhSFxC9n50?=
 =?us-ascii?Q?G/gC/RHBmknmO1UDc3OxIWlY0C3hHnE8gS+NidLVlCJcfFQlLdj6PQQx3tIL?=
 =?us-ascii?Q?+d4QQfI6u57lJi7dT5oK93pK1vnmME3Q5G6ZOTc44u2rZVTVvTB8j2qX9dw1?=
 =?us-ascii?Q?J1+2mBiZwqPVZnYLlub8gcrZOGeOp8BBgsGYamup40yafrJ7P7Ax1MYk41+Q?=
 =?us-ascii?Q?MW7+TDofBYeFfkW2JCTxPFn2igCxrcp4ijUSkAded1Yn0XapHqH+EXV0tmi+?=
 =?us-ascii?Q?xQuO/+wiHreWgd5d8pL+2nW+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea4b35c-90ee-4a94-b26e-08d90adc7722
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:00:26.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6Yw0U72vxymGgVwissWcSWFEGCAs4UB4kENe9pJjAtTiy3o0cvLi/4QmIidf7dWKWV7LbsSE/ooUKzUgPkpNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8MM VPU power up sequence is a bit special, it must follow:
1. request power up
2. reset assert
3. reset deassert

This change in this patch will not affect other domains, because
the power domain default is in asserted state, unless bootloader
deassert the reset.

[Note: We expect bootloader leave the domain in asserted state,
but this may not always be true, so we might need another solution
to address the VPU domain requirements]

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index d2ce47a5ebad..072f519462a5 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -217,8 +217,6 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		goto out_regulator_disable;
 	}
 
-	reset_control_assert(domain->reset);
-
 	if (domain->bits.pxx) {
 		/* request the domain to power up */
 		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
@@ -241,6 +239,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 				   GPC_PGC_CTRL_PCR, 0);
 	}
 
+	reset_control_assert(domain->reset);
+
 	/* delay for reset to propagate */
 	udelay(5);
 
-- 
2.30.0

