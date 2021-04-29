Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C184B36E565
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbhD2HCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:02:04 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:60161
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239269AbhD2HBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:01:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsSbqhMhGbkreTzi0rSSwWrDGlIVWOsdYLf+k0sd93swbrdvusFpXOy8HHNPp4nU9fueuf4PXSO750PIuzIbflE3XWkQFHPMOekizHlLWQ6Bo5TqofXk0wYBrN3e0lBs2zVe1U49OjOkj6bTkMAEj8YzbPZ8sDwf310Y2Clkfk11/fhyYmBlOkVNM3Yx0zHK8vFI8RahL9V/JsaHge+txUasGlSHoF89JPfjLDjgg2XlwgaNQCvW1or0wYTKO+Ehtwf1zmWlyNiVaLVtosZ8Hwkbs8SevhN+1pkrgv1KHi9buuMMBUHcnL70ZjTOMmcnj+5zeROOuUeNu33PY0+EhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyVFzo6FDwBuBULigZlxWIA8Q3htTSbXK72A7UBeEMM=;
 b=OVMuiWIgTqvF44VlsPp+R+g93AaCKdxXmCNZz/OUf8P5DA2V+M+n5cMJLkvwXdakPA+T5NQJ5auOKRTKeMd9mphKJ3PWmzIJ6tC1kc6tG6hEZj4OH+Ktzu/1ucyik/RTty8x6Pv2cdoHYC1AFcLacd+K63eMf0gjhL7Rt/07pKGWTqgSjBw9MqMrqEyyWR5omwHA1TQ1qzTkzatZ9PIVGmQpnrt3dDHDowPTFswrT4l7wIr6F8QtCLPkU5xWKTiQP/moMZBz5if/37iVBDsTVLAgaUcVkGcbKYdtuiGKlJVWQcro8KtZR9GBPzT0hC/BTk4rOQuMC5ET3tk5clVDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyVFzo6FDwBuBULigZlxWIA8Q3htTSbXK72A7UBeEMM=;
 b=G8yqUG1TttUKAWJym6UGCOA+0qOwsnRSvC9KJi7EaxErdSQIqJWZliKsQVidanNNJppgpbr0GmWnZ5c8ER+M1cXDmHDECrALnTE4Lf6ME1STiyn/gKbG7T/IGEBoXRsjtv696+kofEJQVqCqe5jC853sl8THsSERJl+5kEepOYM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 07:00:32 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:00:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 15/16] soc: imx: gpcv2: support reset defer probe
Date:   Thu, 29 Apr 2021 15:30:49 +0800
Message-Id: <20210429073050.21039-16-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 07:00:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abea79ba-6298-4e3c-8dfb-08d90adc7ac1
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5468637D1C693028B5F4D20AC95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzFKLxeViH8WCvWls0FdnHFivhaokFVupNMVND7IkiIwI3re3Eb5J7wYPY7Gq8o1kc+OpziEBJ7IE+edZm6iSvHJ6BLcg/fm4cpy/P69iVr5ZZXIPwgXpCAMX4D5mZRgmGalVZNlJgVk2pcWD5KpVwqoX4+aFR4XgZO2p6RvGbdQyOf54etiJCOCF8TTaDz1R1o/vbBjehEPuiNecnj4T4mwvHSCctBmmCC7H8OMcHf1DwfSEtEauh74aeiV4drpIFy6mx86U/lyCPUpAOQ4sBgDKbOjnV7Yg+ykettcB2ONLYziYQCmTdDuEuT4P+o9bmize0YZn4pkoQEEHqaY54XYTFWKLbF2Jdr3N0lSMn8cxTCsBSm7Vbb+G571mxh04KIgl4A1yG3M5BBkpxrhqv1BkOfhHk96AhuzkdpRn5QsQFn55/jsFwTa8QkWXrsPS2BRwulr60buvuoH+KgHRzZWBnpknwtrT2yCzTrSuFby8V70K9Eg4zPoyzAiIdQT60r1jZxwJ8qwYIn14efx/4nWUHmMLHJJAPOlyKFoXCXmijCga52cSjmuIYjEH2L7DCohsM7sKYWWvv/F5pIvmgkFUKK1H3FQzbRWrNhJ637f1zvcW41DZxjqQIHFh+m1WfZebnlRUM137rJ64r66kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(4744005)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YuV8IKhMebdl7Y/egh47PWBTzwB8ObQf7+nxwDdv/8zYAf2qKgEU6t2C35JA?=
 =?us-ascii?Q?NJkKs7aZkxMfxDfzYG7IaxFLQz258eUKJ/COTdfW8VGHpm1g90q22MAdBmHm?=
 =?us-ascii?Q?FBt6SbmWz8JzhC3dqJ04D2lA1+K1CKh9SIA7TrNI9fsz0Sv/dCkrc2shpQ9z?=
 =?us-ascii?Q?P5aMntwGKweWmr369Y7YsRwxIAWN6lETWHV7WYproPsvCoqnTgEOwfpDjrWz?=
 =?us-ascii?Q?dxFwIIcc/gNpmyFj85Cc81VBgihK2nZdGdgFq5s1R0CfUJ11Tlp1PmL3prVz?=
 =?us-ascii?Q?xet0vVglAmk6f8AFhOh1FLGJmvgR6rSYSt/zaWLt/3sAeCeUDh6T5c2crOBv?=
 =?us-ascii?Q?bPBv8B3Nc5o/DGPLSAwMSPvPSpNvXZqhtqJ9UI299jrLWMMs/fLiJ9HS5QIk?=
 =?us-ascii?Q?QbjCTwp5OWvzFA+X4+ithHICTIRBfinbhcf7jJf1wASJsBwOrq5j/MZGDetU?=
 =?us-ascii?Q?vrYxMKWNCxmsiZFi8e7ni3SaHr/IR6U3udQ/seyewMDabNVt0R3ko3IsVXaL?=
 =?us-ascii?Q?t9qWJf/AZpHSgKLWSpmWyeJtvGAHBIEdacuxjQ652+J3VahKgIFovRz20Fd9?=
 =?us-ascii?Q?y+C1VoyhsEPmual8uEx+MlsiddBqn4l3HJUSX0rLgKQTmU7Ig0KH49U3EPGk?=
 =?us-ascii?Q?CKqgK14+GqpL5C8/jrWZKVSrPlJDtJ560PsCNTUhhPiSRRc5rqES73O+wxWP?=
 =?us-ascii?Q?TVzO1vt3bUlTJSoeHqzJ290fcRJhvKoTrBKtdwefpDHkDRGG6bxorAe4OUJz?=
 =?us-ascii?Q?LbrIFtvuNl2f4DRlkWIpc2GnwUM9RaOkFF5Je2t/Kt9HWqdOwfnLSlmMIJjH?=
 =?us-ascii?Q?jVE7yMdVk8Rf+4GXrNYlQpsz7NgFhx978Ra8kjsnhDLxUtxXsHXSURNFSIBR?=
 =?us-ascii?Q?jusowAvAho0Gt/wwcUBvLQXD4c+62fAdRenc78LAfVRxxUXYptJfytqKwT6/?=
 =?us-ascii?Q?uHE1jzs8ww5UdGP1uFDRuGyC0O+N2Fpv972U7Ccp6EmotsaqiQM+OgwKzra3?=
 =?us-ascii?Q?9AY8KaE/PmJtJ8PnC31FOCMPq5gwLzY5sVvnP5hiOmamfFsmEHhfPhOrFom/?=
 =?us-ascii?Q?4hBB33IVeRRJVodKGNct122uCaTWSSNcJcV5DgK2GY1e6BjRDlPzSmmeZJPS?=
 =?us-ascii?Q?f8g2xiFhaynUgFq+CRkCgFJqpHqSKtz6K3ovA5Eql8cQa3kNJ0grMI5Db8qe?=
 =?us-ascii?Q?BGk90SGBRVo4UIkIy6qQVeclSJB3kwMd2IPzhvfIKUdBNjVc3iYs4jcHbLWg?=
 =?us-ascii?Q?fQnq874QZaNOEGnEkkd2ghR2Okw6Uz0QKLlZ9neKxjdjRUrrW1tyZpXz8BN3?=
 =?us-ascii?Q?VwiQ70VD0Lc5JUZWl/rElilW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abea79ba-6298-4e3c-8dfb-08d90adc7ac1
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:00:32.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pu0lMIZP6m5H8hAsRxcFA9PsXL0+P5Dr6SvPqnejJt4AN4uMhz0bDa9YzTYFYivh8qRA5CdRAFprmvrMzB2YVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When gpcv2 probe, the reset controller might not be ready, so we need
defer probe

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 072f519462a5..49dd137f6b94 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -784,9 +784,12 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 				     "Failed to get domain's clocks\n");
 
 	domain->reset = devm_reset_control_array_get_optional_exclusive(domain->dev);
-	if (IS_ERR(domain->reset))
+	if (IS_ERR(domain->reset)) {
+		if (PTR_ERR(domain->reset) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		return dev_err_probe(domain->dev, PTR_ERR(domain->reset),
 				     "Failed to get domain's resets\n");
+	}
 
 	pm_runtime_enable(domain->dev);
 
-- 
2.30.0

