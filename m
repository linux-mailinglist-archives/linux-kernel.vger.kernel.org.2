Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9183427A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCSVYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:24:41 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:11580
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230347AbhCSVYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbICIgxWu5Uy9EbNG4xk6P65alp1U5KW4LGIDCe1vHHIknqtV7pcryxvkcPVdGdgc7T4hMx3GJy/ZmTn4Vc+WNyPBGxxsA5Ytd1RP6USrOnG8MtvUgkHMmB7/u77ddbgDGR3wnc54ZXPSmhBOfRykKJCLxFMZ28kyrpPa1QvgSq0LjZfPMUycBI7NZdLYdYATetfvh4F5GvEGL1bWckN3+/aLYCN3BmlZ0T8sUPLJuvVFxGlav3LQ9iDF+fiVUhu+E7nG5JTw4imb/5pIaE5UE2YMhPJWnaM+Ekv8nYuD+A7qmmutBn3a9W/wUjjDkh6WTxZO/znVRtULU/WS2kQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mpyrht6mRrWf12j3yOYi0G43Ykhr5Cuz7ppF12UJWI=;
 b=Agyv6XyJ+jmT8Lakh3kXPsr266YsqbISvAG1a3mfBk9zdkR4iGDoNW7iaIWzJG5W1ohxisGwFxGaop7UAmUBCI3tsFKiJ3bCsYUZYCOWqq8QdebVsE0NiHFc6VzRlL2h5to5AMZPhuH9Yv7qXJpbNz2ems9vWYy2lKZtHp3wy9PjtiFE1aF2L8teWLnfnh/XNABOrSnIyJ4AWqg/tH0vUOCRRpLG1DVbYOc/+fzHNi1lcBGaCI0+8lLm4OTmr9EmDy/6gX3PyPOUXRiLas0xV4FonnPiXNrbDPGbGFHjPJGQ8p68GnZcv/Gd24Se4QOsLI50J2mnUscBAk9SDrlO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mpyrht6mRrWf12j3yOYi0G43Ykhr5Cuz7ppF12UJWI=;
 b=rhkGAOXPK0+AG+nBdnnaUnu7+JdB32donWt1gFVLM0EaeqOfExmgHIiSLCHw6n3VKIFsPs+Y5j5FSH80+1uRIQkbJ6WHDgh7b3dWIEncQ7XOEjT4MCYap4ov4akpKcIWA0F4V/ZkUEmCQvxDqBNerGBoQARN+EPrRilMqAFM2kY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8053.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::12)
 by AM7PR04MB6837.eurprd04.prod.outlook.com (2603:10a6:20b:10b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 21:24:10 +0000
Received: from AS8PR04MB8053.eurprd04.prod.outlook.com
 ([fe80::d468:8d7c:d307:7991]) by AS8PR04MB8053.eurprd04.prod.outlook.com
 ([fe80::d468:8d7c:d307:7991%4]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 21:24:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        victor.liu@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com,
        mirela.rabulea@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lznuaa@gmail.com
Subject: [PATCH 1/1] firmware: imx: scu-pd: add missed ADC1 pd
Date:   Fri, 19 Mar 2021 16:23:52 -0500
Message-Id: <20210319212352.31869-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0201CA0040.namprd02.prod.outlook.com
 (2603:10b6:803:2e::26) To AS8PR04MB8053.eurprd04.prod.outlook.com
 (2603:10a6:20b:2ad::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lizhi-Precision-Tower-5810.am.freescale.net (64.157.242.222) by SN4PR0201CA0040.namprd02.prod.outlook.com (2603:10b6:803:2e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 21:24:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ea3a3de-260e-4d45-d247-08d8eb1d55c2
X-MS-TrafficTypeDiagnostic: AM7PR04MB6837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB683753DD83B1E983049EF35388689@AM7PR04MB6837.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfTui1RPQrVZEHOD1hMZH8tv4gWotfwICV661/+KDzGIvo4aYw3qrl9Hg7OpPqRAegrpeBw2DtQOtkXbgJF9d+g1TVLUdHZgByjkOspaoDo3/NSN4I8WgJ/lO1tM8c+tm1vCa7xQkuahIflBk4tXuYllN0xWjkqkCRMZTnEWSIakeWOmIIrIYTj8R/IK6EVT7St07qQus6DNX+0UDc3XNJcKKEWoKpz+jMSNwrBP6gy9yt+DD4Nu05B6yB3DACjQAv2/ErsXzqisF5qSbD0AFYZoS1KR/t1HN10rNEFySPrucStgn8ynA/OTJBLZkQfBl1wZ92iStS2hlg2zCgj8OmgU9GeLKj+PdRF9uq+ZTJEUjIpuZ2jt3z1whErLGwWVbJ7/wFnYLABj4fRz/VWn6knxpwKBjVUcp6LrcxpwReHpSIJ1SCuIOBMQ4dep6xeCtqdFdPbzvVsgv5sMI79wkPbzYahwT6TRkGlCsAd3iPJcFhE1sjOPwUX/NcFuiHVrJkd67ZgCPP80belUnn3VHX0K3C+K+YRGklj227pUJQVTYD3zeYFqRB+V8z5SqU2xDVf5Fjumu/zT5bzWLaS9I2kVtARvQkMuqLSRlVBb1EpkO8GnQdJVyvG7jL12J4QrvooZ225G20FhwpSBSMQlKeQ4i1V1orOTFCXA3BiUCJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(38100700001)(956004)(86362001)(2906002)(478600001)(6486002)(66946007)(8936002)(2616005)(8676002)(83380400001)(66476007)(66556008)(186003)(1076003)(6666004)(4744005)(316002)(5660300002)(6506007)(52116002)(6512007)(26005)(16526019)(36756003)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZExzaGOFLT0rdH+oZxfC+O/lFS/TwW5PEVTMosKqGurJcSgIU9o9/n3SI/pr?=
 =?us-ascii?Q?7DjCC8yRg2bnvr9dMA6pr1+UI150FsX3eew8AIvAjmaV35zlBUDoqXdZ2glS?=
 =?us-ascii?Q?t39PUCZoZvqLrGtp+igQiOGmyrmDyhA+JHmpTIWE/9TES9vznVsaBuUcc7VH?=
 =?us-ascii?Q?U2J0x6Gqry4RDD8yBcxwa6Nmiqv1AhKiO+Nn6MY/bCTZp9ROQAQkHXPNtbvz?=
 =?us-ascii?Q?qHtiHt6GsJ0aWZPnloBL1YwNTfzg+UAzyezBf1hDpz5DFE6iJEz/+gANrH8u?=
 =?us-ascii?Q?nGF0P6pzTmn+CTTsQLvhEnBXkqKLLguX8k0rCm4KhZfn1iZc3JtG4kwBMrgT?=
 =?us-ascii?Q?Bphb7+QGm8CH8eAmUox2ykfS7HldhSQXYqyCSLbQTYO1KpoBak7BCeqie3Fa?=
 =?us-ascii?Q?Ym3mwUyaRac9YZhT0t0IUZzquofKbYpDAp1RNBP6pSQjzKuIEQYg34nR/a3h?=
 =?us-ascii?Q?NlW7tLEIDUHXloIhhspkK6ytBxIDZBXg4lLxvn434WY0cvrb+2PMRrHt8J0g?=
 =?us-ascii?Q?nbT5xPzpk/4EZMz18bNsFGJRVu6Sq0NNT8LOct3k7AcuccCAsGTgkzB9r3iv?=
 =?us-ascii?Q?o+XbDQkRkbdaXPB0jMdxegMwu/jeGS9p+LoGbOJxMgpz/Q0BGhGZmRr/AM6+?=
 =?us-ascii?Q?pQk+4/djnTRaS+AZlTj+z8DSejifUYZD0dMtoMfHUkO66s1uWdyQVkuvhcKN?=
 =?us-ascii?Q?wpxsfES10t61Q9bLWaSpCalffjnSxXRSdpIeZkG83H5ux7a1KJxGvSFxv6JS?=
 =?us-ascii?Q?jf7MpfGnnqSCHCCnzR558MKFxfXmjJlY3h8ghs8dfjDv1KOPd4pz4fXfgwvz?=
 =?us-ascii?Q?Jo98GQECU0RNl0pA/YqhgABiJLnz+KyNWca6p4MvmV2QBQg9oavknLgA/zXg?=
 =?us-ascii?Q?GA3XfcWOEhQ348D7PhDWtyuP+LH6qJB5LJs4EkCXT80lXlEx4h1OD3poKYHr?=
 =?us-ascii?Q?OGXfjgznZSGbDYh8Uq5/FRa5m6K49w92KvDjhMPHIQ/0PHxABwsWhn4HOb0R?=
 =?us-ascii?Q?+HyiMmLB7vtI16M1AEIg+Wtm3wlxR1p71zhhTuCZctQPSkwCvUyJeFtpGTpH?=
 =?us-ascii?Q?JikJi2jNNrXhxO5bTshNcXcL4lsHMzB8Do/zMIIgTDe5/F3fEYdx+NlwBV0c?=
 =?us-ascii?Q?wiQBdhV8FqDCgUH8YG07/KJuc/FSxyrXsIuH2UAR472TcYjlI4Ni4ZAK2Xe7?=
 =?us-ascii?Q?Wirv43C5Uw9hmK85wXjqW4v5966PibUzqdGJXX7FL63Q7aWOPYWzRuszr7fO?=
 =?us-ascii?Q?txGBscvzh5HaXR29gBrk6J9ZriI7VuYvQUcOxVuNXqvEh9Z0YW7BHPX18tws?=
 =?us-ascii?Q?cpUpQeJ28EODTIoClJo0llK1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea3a3de-260e-4d45-d247-08d8eb1d55c2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 21:24:10.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cat8RpQBvAq5t++deK431AZxd4YEAwLns76EtQBViQEd2wvB8tDg6+7yfV0sQZvz1yg4unjn9Mgexr9cKVAmGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADC1 is not defined in pd driver on 8QM.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 338800d16c653..966de5e5fc44a 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -136,7 +136,7 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "can", IMX_SC_R_CAN_0, 3, true, 0 },
 	{ "ftm", IMX_SC_R_FTM_0, 2, true, 0 },
 	{ "lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
-	{ "adc", IMX_SC_R_ADC_0, 1, true, 0 },
+	{ "adc", IMX_SC_R_ADC_0, 2, true, 0 },
 	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
 	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
 	{ "lpuart", IMX_SC_R_UART_0, 4, true, 0 },
-- 
2.24.0.rc1

