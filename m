Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B35F3E4026
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhHIGgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:36:32 -0400
Received: from mail-db8eur05on2056.outbound.protection.outlook.com ([40.107.20.56]:33609
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233335AbhHIGga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:36:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8AGzTlVpyRq1SdV+DXlQufclgYXwRJ35RgqsOySlbJjlb8K/Bm2GkHTsEzEEg/mEXzCPdIe36+s8++8qyW0/E5d0V0fzLzFrOzcwnLD6PByfyQhfTPHEmGJkdvLCfz7aUH9IIzQaK6HrOddeJAgdC33z/MS0sM1m9wB21v9UvZsIWoEG9jHmjO2ncYmlWO+zTPD+LQSv2/o+aVdzoqRPr/ijKztcCLNQKIEgRKiIfeAwiSoC1JVkR22mRkgJGCxBBzylkhw6+dbLOHPBZkSEN+otBBm+CEqY0osUCVq5nOLhnZS5p9Kh+Z4065T/iRu1fZHW0FOw4nwVvIH8gLM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx0VjPfV9a7a9/c90fwoo4zLblr7vA6TE8iPQ4USZXc=;
 b=QEOXr/bMEulCs1SxcOmgZNGaWioXrJWx7BFHf+PaUzrKRBKN9V66PF+K3ZBOqEhySDM01f0Mc6JuKk+bBp1nItF3he1O4A+mLhHMiB2yB6uQBUjJqMAAG7i3qxpymv6Yh8H9fnDuwDPFTh4M19ULAIfYLmznYs5V7u5Dt6lt+mhPl8Sxh0buQHMo6jAqGiLiw2LwqW/b9IYjPoVJITNk+Ce9gaexVLvOmQieklnihLeJsBfk/Mi5tw500fmE02RQldrzHyptDKPU9IQ4Omi8RurlwVjuMtjMKcYq85teH1SONsnS/qc/m2EV35htv+OLMOYo5OrfL96Qjxj7gw0BCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx0VjPfV9a7a9/c90fwoo4zLblr7vA6TE8iPQ4USZXc=;
 b=CbVbO/yZTmBfzH/BkNAS0/Hp4uxIjsKUIETYEmWWd0LAhuSqP1M/E0RcR6boURUIP8A8ECaCQB5/GXQJn9Zt4bMNKasicAyseojhO+7CsRME3GP2pnXKzycnG3BDAXKx+l6i5NoaNbUp6xq2grVciPoAATZDL3H1TEXmzCghAjs=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 06:36:09 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 06:36:09 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V4 1/8] i3c: master: svc: move module reset behind clk enable
Date:   Mon,  9 Aug 2021 14:36:38 +0800
Message-Id: <20210809063645.2289988-2-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
References: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0103.apcprd02.prod.outlook.com (2603:1096:4:92::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:36:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e9d0fc5-6023-41e9-1958-08d95afff8c3
X-MS-TrafficTypeDiagnostic: AS8PR04MB7653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB76536C7AC6490394A68911AEF3F69@AS8PR04MB7653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNwl72hmTBc/9SjEB0qnqqeN1g0WgmIlkUQqBYLJT1EJPpBF6pyb2fj2bo8PKDG+Qdx6I4wUAXC7x3TkySQkyll+5A1ln6ujUEhRnUNoE8X3SwExgHIsKrEAagy5YmcUFCQpOmfkoWN7zw71PBVJJN74zQ0dSvb66siJJ/YrMJxlvKtzgH57BQKLH+GO6H4415+v8Ys34QKFjBkmi/wnV/TDbBTfrPoXzaXCMnFO0pUjfwFBu9Pz1Pxm8juFBfIvgsecsObXrgbD5ktAMg3qeLCi3n3YD4FN55XpcWnSgp78G5vIQM5JhJy60R7FQ0ASQoBu783/bhuvUJAt98iyAL3XR+sTa/tTvqQYIvunF99ems/FlPrL9cUL61ZY6mm7/jGBhhIaKvSefvV5HMA7Oj+Mgn8T546SJlgVCdzEk7hLch1YPrcsvk1Hcq25mEAVbicD+EnsR3s3sMdCtBZIh6c9NhyMe80tIvukLvaNOnY1e4oDmvpAqhxWJv2W0UjfNHJb2A7DhBsOtZX+nRoWl5ivk65etc0CDKmSnUc2NZmUvPhQ3g0aA7WVIc2u3CsLbki7wxXJBTUp9kCEtdv2twoi7qMblbavjm01n45Bfzt5VTXzGTgKL9FBha0PpI06eH2EY12nEYkBhk1YvzhfJCvuRB89l+YxEb3IajVMbbWXNKj1DJPXZIhyA7bfXQm5suOiKj/+AMhgpJbHAbUpYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(38100700002)(38350700002)(478600001)(86362001)(36756003)(316002)(186003)(2906002)(8676002)(83380400001)(2616005)(956004)(6506007)(4326008)(26005)(52116002)(8936002)(6512007)(1076003)(5660300002)(6486002)(66476007)(66556008)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VFcikKU+IAXaDh48dhU7nYJ8nu/QslX7JeifKQY91SAD2f36RWAvzcil40Yo?=
 =?us-ascii?Q?bxfoWHWq+jq1+fX38i2H3gjABZ/TxhH8sVh4TuoGVCEauBuFwC23p3auh9z+?=
 =?us-ascii?Q?HXy1UafvNybYKq4K945zvt+K3Ty+cP/kbGib+qnBFP8zioskQn4cNuRVS8bY?=
 =?us-ascii?Q?vr3TW4d1DuaJoMSgujeuM213WWFBRunMx4ujwWlSK1bPMdteqE8lJh9hzIBG?=
 =?us-ascii?Q?xVZ67qKbGZW5tPB45KBLVGPZJENl0vIVKwlIbGtRWXOfN2XhY2OE/5DbuZ6B?=
 =?us-ascii?Q?yudcxXdoqJaRdWIfl/AuPKT2cBRA967inwe51kbI0w4Qc7V2MKUqkbK8E6dl?=
 =?us-ascii?Q?Q/oPo332QmCHbRx9eFLCOe/0Otwfj1JzHpOd0cRSOrDpyO5JEBASHnWzc32j?=
 =?us-ascii?Q?XyguBP+PcLHJxsiJos5cLDlA5F4sCj9Wc3evHiIeKYh85P67w3WT8NrY/Mz/?=
 =?us-ascii?Q?cmSZZY22/1jqrghKTGLdBHd0DWi/+bBLaVIBQrcC5pVyIEyd+tBfddMSbbU6?=
 =?us-ascii?Q?LOlXZxWbNcU3ryjNUNLzHrlgIa0ezo+zPj9z2aVypwX0U2CvlU7hXGnbcNDt?=
 =?us-ascii?Q?yIyOQc4Ueiu+xNolIsXjjdvuLdTmUMhygKYvc5V5pVRkcGb9DE7oPdlvphLL?=
 =?us-ascii?Q?u0IjcdJvIkP6rKqgqNw7VCfF/0dP1bUpBkJy/JKCtHOxjD06hjybTH7HhlrC?=
 =?us-ascii?Q?JcxR7jsZ38aFCYaTrtWaQDUi3bQubhb5silRjnHh+EygQrGtBaPUiGSqxS+A?=
 =?us-ascii?Q?nwr9hJxsbykdoxniNYJHIT2S9sajEz/mYjTf6KxPoHNGaLEduzG4vNyl0egC?=
 =?us-ascii?Q?CmOdl7eE4sgN7A/q9dscyXaXMw7a9rf84w//VDyrDja+u5wLamBqazn7hLkf?=
 =?us-ascii?Q?J7p4cypZk+kRxYwwROTukTFn/rUefa42WhMWsBGpxIW68y6xEmNhLOQUodDR?=
 =?us-ascii?Q?KDf2rJSPRa0IU9rFMCFCR+CYDa1MMGxbOmFEma1CY9YM/E6gzb/uRhTKaxFc?=
 =?us-ascii?Q?OqJXU4PLUIFkvUrI9atH4vMGSaHcaTnqC9A69AdUs8UC08krh+53pnqiwfs3?=
 =?us-ascii?Q?xuykSx1+45vode3jyxJQtjkOdSpV7ReJoqypWe4dvORReS9AaiILqYTB2j+B?=
 =?us-ascii?Q?TMY3S6ql5VZAPJYlNfdTmxV998pkT6kSTubmMzgvxVO4Fc5o47/ffLa/G1NT?=
 =?us-ascii?Q?NJIB7Qd3Skda/cqIGt4WT05FqGWM/0+zqObWlSwNLpXtVibk+WLqAcGVZ5bY?=
 =?us-ascii?Q?j1BYyiQOFnSGSYSgAd7aKyEWZnPs6m9/n/FnA/r44JCqW73LU8viUrZhTKS2?=
 =?us-ascii?Q?oerWS4Woa+7yvmr1x/1ME9Zk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9d0fc5-6023-41e9-1958-08d95afff8c3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:36:08.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uUVZySK3somShAT9fEcIxY7VA/PaI0NNuZhCx41KJF4jAkm+hq2LqtjradYbsQI54XDvdrLAkM3wKXo9zC0VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset I3C module will R/W its regs, so enable its clocks first.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V2/V3/V4: No change.
---
 drivers/i3c/master/svc-i3c-master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 879e5a64acaf..c25a372f6820 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1381,8 +1381,6 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
 	master->dev = dev;
 
-	svc_i3c_master_reset(master);
-
 	ret = clk_prepare_enable(master->pclk);
 	if (ret)
 		return ret;
@@ -1419,6 +1417,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, master);
 
+	svc_i3c_master_reset(master);
+
 	/* Register the master */
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &svc_i3c_master_ops, false);
-- 
2.25.1

