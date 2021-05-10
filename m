Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96526377A99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhEJDba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:31:30 -0400
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:61774
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230431AbhEJDbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:31:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGUYhk+/nzXgUJSufgIs8R5/9ieHifG+7LmqrggPk86CHx5aGhFsJqVXmUWRhV7pTAP3aLzNtggEYS+DPRYw92OWKFMpfCZZmMAmNmVQBl7rXqsDlaMZa3XsHiIuUp5KQvDhf5KWs6o6urs0zpDG1qY+KWIu1zU/ZQA/LImUXx33K0EGvabG9PDPWWs6aa8JDcx2gyUV2xg6N6hCzoJKAKD2588mhlGeo+JJSlYETIeERAFHTZ+6mtgwwiD4dRHNOP5Ybr+kyfFGNMykEoLo95L+N4cBAlkoSRtURUJSgQZ/i5HCuU+dyBEZsaBTtpnpjBt2i0z+D9dz7hYJdpHdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9CnNtvb9vIm+pedslTBJfFuW0h8T99Um/krzsU0U/k=;
 b=bmmyO/k+RtLf7DDwMCF/zIht4Qe7jLn5mc+660FKzb5Z8QuKyyOK/tJlT82MdpgSnUFyIi2Dmx+jp+PIg06f/6WJPabF7fBSM8U5WxGXVTxdecgDFkpGMvM0xqhJ3ptuQHSBh3wKA8qoTkFOAnK0wEEyTsNqVlP2NmhnjlsTB7hV5IjgtmcjhWq4wvhaGYZmZgHIzzjW9fanXrzGLhu1tRK+Q5wmOd+vzw07urvqxYTPL/fkeuL2LqxlfVnuKagvPScPheO0gjEcWdabTXEKAN8UYVgUgQ1DdkypwwhgkziUBmL/3cvieWUz4zoDhqbLvt0i556FoSuFZkO4cNFF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9CnNtvb9vIm+pedslTBJfFuW0h8T99Um/krzsU0U/k=;
 b=Ogsn8zbutOGkYFOB/kY5d5CHQXI8mbd5J5FO3FKGd76KUaezy5hAPzwpt5KfRYWnVzPBoaRepZF1S6cZskAd5d9wvWn0oiDYkmVRtpNRHc37LzzUtzKt0BUz1wD+12UcDh25R1yeEIJt7QPq2keUHvQ58rCDCc+A+iJS8eLsjZ4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:30:16 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:30:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 13/13] soc: imx: gpcv2: move reset assert after requesting domain power up
Date:   Mon, 10 May 2021 12:00:45 +0800
Message-Id: <20210510040045.13225-14-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040045.13225-1-peng.fan@oss.nxp.com>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:30:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f8f77be-5368-4011-a131-08d91363ed85
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4091942218792A03D8493691C9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjYOaw5NCXt5X1N500HHy9ymuAVn7a+XtQ2nmb34nk/e+/waLGSFDE8Kmjf+pPvbg1vCl+kS8gnwCS3VKE+4nBQGQzhyiUiSOCU/OV4L2+PNYN1fNyOtOU4XaOChK5/1vbcDSSysuvgOJ3JbVwU+ZP4i+dZLnBKDQ5lFK2TUkFKYsqxnu34InlX3jj/nzse/OY4lhgWg87bHb4OVmlzeQulgqKgcEI8DcNxO0jPoVEhUI4sNJbngb6KNrT1eSv3I56YeU+rLGyfDDgQxyP3Xt6RGKf4qQkNsSsUWFEu4T6tAAqtvzUviccKSklyQYjfTTOKPbcW/XTulPWJxEXIoWnyHWdymti1IKifX14gMcv8QhkntAmJ55Ja3NA+Oyo0B5npJYaTlDpMtRuZlR1xR1rEoetg3LHZWLw022IOt/+3nMaqbtN6jSKrdxUn/yE3dflHIIfl/EplkgWHbypqsYYNle/su8z3ew0wM5/knUyjp1oS/+IikcTRu9lgB5cp/VG+5dAOBbCGn4t7HfOF/mCPGW8e3o1boIRMkCI8aNTTyGichGGCmPvpi54CQmPunbfaGaJBJBnVdg0u85KHHGAorNJ60HW3s8kvcSEMQcyR2P1/mY+q0APkuJ22cTqnljveNPGgbhwfnpjUMvww6qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?i01LAJjWUDjWyuqRR4WyLXUUch332BbTGqb95/cHe2umD1KF4fociNFagxKb?=
 =?us-ascii?Q?i+fT/+xTjZfFK6JG+4UNNnbWFjI55cSsBDwHLhH0SR3Jde7CTCdl98bfYiTs?=
 =?us-ascii?Q?DvpD5JNNMqOz3XfE91bORSQHrluR08nel6cYkcsk1NjigpFbcLEgptmsl7nA?=
 =?us-ascii?Q?YCrp3CBdw1rrYzLUBnZfxa2M7t/OQGLZdGTOLj6fK7QwPdhxEpDzeg8nY2bn?=
 =?us-ascii?Q?Oewwfy450Q9Y5pX47vB5tvV+Bo7UeBR1LhRNI603nR2q3CrgrMVpxWnpY+kF?=
 =?us-ascii?Q?hyvvDBxPZ5FP0TycFG7gcq0Gh4uyXZJwt48hLRO+jAqRg5VXrPjmg4svt9jG?=
 =?us-ascii?Q?7Z+ti1djBbHFVUsJtAd5ift7HSMYvK6BB2GAuhBWjOSnTuMWxoIXxl24V6iN?=
 =?us-ascii?Q?vr2twR+UCsPsYuq+hG36L2LTGJMBCj9SbVQy7C07ImuZdcIAg/4uj9WNIlI4?=
 =?us-ascii?Q?eiXYiI8OevDYdLaoJmDgj2Qp6FQWo5lLnaHqr+RxWIkWG/wJedBqYLgJ61no?=
 =?us-ascii?Q?vcRM2SGTVNFFVSAHztzWhRPc/piUS/M/F34i2KngD3cUF6fWURlyUpeoUz7A?=
 =?us-ascii?Q?ovO58K6yiuXzuVZO0TeSMkqGJi6rRwnkfhjKr1ZiwXLZ/u8BgxjzHoPIwrZy?=
 =?us-ascii?Q?MjZ08V5/HOMhasAmXgwtmjQXg96qCQHXYjCT4innr3ZSIgb9GF7I9YNVoefn?=
 =?us-ascii?Q?WH7DRuCN6v8hc0QPnRHGYiOha6l8IDpQagFWUiPcqwOWIHJJW7fwTGL9stYL?=
 =?us-ascii?Q?HjuHkAkqNZiLcuvMjgpMs3a8AJayY6v5//CSwVPi3CmfHs8zKlSm38vPFx/c?=
 =?us-ascii?Q?SSQXuBYjRSPLVRKQvi19D6xT2VdBpc7ECt859IMGLIXMH571KYRs8EYFmqlW?=
 =?us-ascii?Q?vNlH9qUlBO9WGiXFlTT7ipf2HNHfXJk+wP6H1rDuXr6H8p37X9ifWkYK+POa?=
 =?us-ascii?Q?W6V1ZQ0EyjtztxmfuDwmnuwfC2Blgd0S37ZWvVER3BFNAczfza+0tBWg/e/J?=
 =?us-ascii?Q?tnYC50bl4wriXTTR3Mlj9QxU7oGtpjdzKMjM+4Lmcmt1f9dpYn1ms0naAOKc?=
 =?us-ascii?Q?Z5OWi3AAvIx50d/9SS/HP9QN+Af0To8Mt0ArTT4iYvQtTMrzHRQAxsS0YPde?=
 =?us-ascii?Q?bspHcVsMewrw1WlbAhVgwNhgcgU0BJ/l5Al91dbTk7PvkYCybOiTOP8AIrZ6?=
 =?us-ascii?Q?U/QYChI8tuan363kchce21qmJrjqeJRFnaezncdXQ/b7s6so6ucDprSHgdpp?=
 =?us-ascii?Q?lnp0nab9WY9nVnwTYj5aSHJ3Utt4PoOt6EohK2XeUwZFNmUzQPNzyc+sd4Tt?=
 =?us-ascii?Q?phUJyT6j55QKDMqREOUEgn2L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8f77be-5368-4011-a131-08d91363ed85
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:30:16.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSnydgZQYtUcfcV5mucEY8PaU9nINJN2kP83uEoVO3hfg4eolTGcSKJmRvF/gghPOy3oT2F2f1BvhR9TcOKKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
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
deassert the reset. It also applies to GPU power domain.

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 2490757f759d..35bbb1bc5159 100644
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
 				  GPC_PGC_CTRL_PCR);
 	}
 
+	reset_control_assert(domain->reset);
+
 	/* delay for reset to propagate */
 	udelay(5);
 
-- 
2.30.0

