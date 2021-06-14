Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8873A6DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhFNRxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 13:53:33 -0400
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:46630
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234031AbhFNRxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:53:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2z4eB0a/n1d6NcriaX+oNsQ7keoqX1deDpB7WiBhz+Xs3AYCOfXUJUblLxVmQlvEbdDNOCssMN2DrDyJPbWW0AGBNJoVLm6tYtm5eGrfWmJxdmhmhkxkyKmGlZa1IwDOLXyEzJb9Nd0PYTEh87LWpIW5pd7oQ8GsDA2xxdh2f9SYWzPSl9Hf8rcSi8Kd/ciQF3dAQTlaubWe1D/u+3/XgZ03yOuNHxT/grYuRw2OsqygLAUg40gtqnAaiyFtF0ub1nTE9Kac4SM/mYtyNQVPukUeLHYm417Hr1cRk+ucFefUekhNK3oCgrCaPLg6E/r4QXGa8/bcVAA6PHEtSzbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cpw5E6fYTlpF5KAw+3UT2vpCqkNDo850gWN+J9ym2c=;
 b=IgSWJnfjQFN8g8WIsl9ZwrdJrtTvUlm0k+NKQR7TAZnfJ9KAnULuybxSwNTGepvK2IpULGqUEJ32weFOLytTSPXikwW1pdvHHVOCHLGzIXxzaP+iMqojDmeeVEy9QgXi4jrUvp6wEl8logOaaGKt5+yNYpR7nq7AuxJ2Z0vF5PbHcdwEn6pr/JB4UibjcnRQQfl3BpmQpvUwW5i9ZB3ajXsl01qc/2Hc8BnALR80iNozl6mvz+9p0L4gV56Aa1oajnHohMRyvB4OsfpS90LYn9y2kybVwYwPKeA+sCnW/NyrtnOoukXQUDFarpz6CBv3qKkhirnwbOYwuZrBdDjh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cpw5E6fYTlpF5KAw+3UT2vpCqkNDo850gWN+J9ym2c=;
 b=nZqqUzK6uM++UjZqfI5yyyzUuQaldfOUsZda9MLQ/FyczhQtoR9EO7ynl00JbJKXQ9tsQqpYxKtSs3m08mHEuy9+8auNTh+WrFhKqlMlUewUYuuC1gPqiSIcDvOnZyUYK/HCNQKwYWbjLtZ5MhudnIcnjb/0tWXkqrI1S+RqsGU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 by AM9PR04MB8905.eurprd04.prod.outlook.com (2603:10a6:20b:408::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:51:27 +0000
Received: from AM9PR04MB8972.eurprd04.prod.outlook.com
 ([fe80::84a:1450:6c6e:51cc]) by AM9PR04MB8972.eurprd04.prod.outlook.com
 ([fe80::84a:1450:6c6e:51cc%8]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:51:26 +0000
From:   Breno Lima <breno.lima@nxp.com>
To:     peter.chen@kernel.org
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brenomatheus@gmail.com, jun.li@nxp.com,
        Breno Lima <breno.lima@nxp.com>
Subject: [PATCH v3] usb: chipidea: imx: Fix Battery Charger 1.2 CDP detection
Date:   Mon, 14 Jun 2021 13:50:13 -0400
Message-Id: <20210614175013.495808-1-breno.lima@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2601:18d:4b00:3350:e819:fcaa:b171:933c]
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To AM9PR04MB8972.eurprd04.prod.outlook.com
 (2603:10a6:20b:40b::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from breno-Precision-7510.hsd1.ma.comcast.net (2601:18d:4b00:3350:e819:fcaa:b171:933c) by SJ0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:33a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 17:51:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0d3bdee-1f24-45cf-0265-08d92f5d0833
X-MS-TrafficTypeDiagnostic: AM9PR04MB8905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB89058270AF644509183390C980319@AM9PR04MB8905.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mykV+LquhJHJzdxlgttUI2l0jAy3hetmtCOuhEO4XXpJ9xY0C7nOtguBBn/ui30tFnJ7wWSmRLNEsykp/dOoJAekDISa2mpHF3XykaR5my5h0CTkcPMaKk2CSK/0zrDjVbRWN9IABQAihZW10WdfHIMd4GWOgNkrFzla32NeyM+sF4STPgIYQYMxfxqKjy9Hevpy1FZKclGseBgDE0ennUGejkyq4umI1HYxGShOfMh71buCPoLDcyzyc8uKksaj7jFYyxYSx1FKQEYJjbPx1JL4LTdsNhaEU/NNIlkj1Eh+kmrN53XFTHn8k69jIfDiW6fS3gG0FIABtCcgfOdb1cV8bJbXETFqfVFZrnWOQQ+uDGZ6Ec4EsZaAYOyKnBX422YEqWYUY+ATkXcfzyxWaO9/bfZeF3P5T1NljmuQarB3hUMQ7gpPDi4uMXrmhc+ZQdv7dePpdXC+cRWSTC1cP6NozNYiGhYPBwQqL4qYHolKr+/wjz6Bnwjx141kB1fc5fbtP555X5wo07OQUqgPhJw/eExbASrH1Hx28pIRKsreMvdbyz4/b6NnhQ3knTujok7sMMubUbmCAwsWPmZa6BpF1kNjynvU7BotgQY1uDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8972.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(478600001)(36756003)(4326008)(6916009)(83380400001)(7416002)(6512007)(6486002)(44832011)(2616005)(8676002)(8936002)(2906002)(38100700002)(186003)(5660300002)(52116002)(6506007)(1076003)(6666004)(316002)(86362001)(16526019)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ndty9KbsnBBduzQzsozIKrQI4oLUSDATvtzXvQgKK2JW1scy5k3MxVHFGYG4?=
 =?us-ascii?Q?iKmUMX5AATRqfdJiOqEzkkzYlB7efsdxfRokxMxWlgcw6FOIgJ8BO3v3Iwqb?=
 =?us-ascii?Q?iLabhpcijygzpEorP/Z6ti44VNTeKr+LrzRhtJLGRldxIeWME3O5mC9BHOnz?=
 =?us-ascii?Q?Vf+r6xGAgA3mjDBFaE9qFTuLTfDrIuJUUj/IU0C+eLVdxaX9XjkeJdvQNKXB?=
 =?us-ascii?Q?kqY41NO2aFn2jXoUiTEpzzRYEcb6g33RDtDWRpH6tNu3pYvYVpJ9TVHo8XbP?=
 =?us-ascii?Q?d8kS5aC/88y7J3L5jrfU5vE3tP6o8xPBBC5HbArm4Bl8kZ3M2oEqRHv0bszP?=
 =?us-ascii?Q?cbs43GpeMgGzM2sgZd49N7dps4ppucQw52+Tbiq2afXhewXKfqQIBQumKUhs?=
 =?us-ascii?Q?YCD1+zskYKmuGhZvSgpKbpokzXolBTUEbNnFSluYBNHdvuuJ2lthFrI39RzZ?=
 =?us-ascii?Q?8uU3G+KDllwkeTeSw9swq8T5HUtC156y681ufYmNP36EaojfxDD22Do/4FH9?=
 =?us-ascii?Q?qzoqL4HdT7ViDM4dxDVDY6A8DHqsCLSfJehNur0AcvhtNLlb/EdFMXtmWglx?=
 =?us-ascii?Q?yWaQMs8KEbn0Q+Wy0gdzbSGSDZTfMZUW2qSkfWMeI7/vmPoIloHx2hdpnrB8?=
 =?us-ascii?Q?5reu2rDIc+DJMyiQgmdDiZ6VGDjg/a6izQZDDNEtSDhD9w9WA4aKMQdxfF3z?=
 =?us-ascii?Q?SxT2fp3tmYfAOnVTqM6Wp0HbaOjtDMe593xwcXNnIJgVFP6kcxcyVjAdOAaq?=
 =?us-ascii?Q?7ZnO2HR5VcpFaF+yObpsoIL4y1/7UFF1YDdmqXl1MVh58PXui7pMw9c4oeYe?=
 =?us-ascii?Q?yC3vmcWkcAZrPEc90w49Jqu5Rbni0v34lf4ZgFMkcTZKm8Ybs4qCs6za2E6P?=
 =?us-ascii?Q?OA1irFacj9IPLi17sJkHs3B85ML1gqfDVz6ZAo8xHeGD1veqs/sMb4qpizuF?=
 =?us-ascii?Q?3Agj0sAr3DnBXZQZsLid8n3pccaVHaAkZIpD9BeLLRDFv6axeLlBRLRfZsaI?=
 =?us-ascii?Q?FvUCVeZeaRm+ciy2mpiA1O5LI4S3V2M+od33vlmWpCP1EMOerGjTOjnA0hig?=
 =?us-ascii?Q?JvFgAhFPmQ5cq+ws78dBXghS2xaNhyOjyVVqDOZz4bkGMjig5kFT6R0XR0oF?=
 =?us-ascii?Q?Qdvz2HDDvJo1jee5WGE8QUcjyH4OptCTTU2afcreCZld/30qLskiDWddwu4R?=
 =?us-ascii?Q?T9cGf1txMzO/HientclvRtFmtxyWsbLsdoVkzmBqwkXrMIyKEqSa0aDJJfcR?=
 =?us-ascii?Q?xSupnApRIm1RdFo4DC/hhGrhWUG8dBOLiCWrMekvGH1QnXS1j/jH79Wf7v2t?=
 =?us-ascii?Q?2mZnPBTezDwJ7ug/zd/XWZX7SBbI8GsOrI1IckyIs7LHDQK9BuwmPwntzLlK?=
 =?us-ascii?Q?+LiZRuu47eQRPUZ6AHnB+NMRflEH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d3bdee-1f24-45cf-0265-08d92f5d0833
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8972.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:51:26.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbRkaCTYG2qSU9AzQPX5/OhnVVlrw7vriYHEaFb3aoWjQo+mqzYDP59o+IHeQA7HVgmrDpvGjgOLYF7r2WUX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8905
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MM cannot detect certain CDP USB HUBs. usbmisc_imx.c driver is not
following CDP timing requirements defined by USB BC 1.2 specification
and section 3.2.4 Detection Timing CDP.

During Primary Detection the i.MX device should turn on VDP_SRC and
IDM_SINK for a minimum of 40ms (TVDPSRC_ON). After a time of TVDPSRC_ON,
the i.MX is allowed to check the status of the D- line. Current
implementation is waiting between 1ms and 2ms, and certain BC 1.2
complaint USB HUBs cannot be detected. Increase delay to 40ms allowing
enough time for primary detection.

During secondary detection the i.MX is required to disable VDP_SRC and
IDM_SNK, and enable VDM_SRC and IDP_SINK for at least 40ms (TVDMSRC_ON).

Current implementation is not disabling VDP_SRC and IDM_SNK, introduce
disable sequence in imx7d_charger_secondary_detection() function.

VDM_SRC and IDP_SINK should be enabled for at least 40ms (TVDMSRC_ON).
Increase delay allowing enough time for detection.

Fixes: 746f316b753a ("usb: chipidea: introduce imx7d USB charger detection")

Signed-off-by: Breno Lima <breno.lima@nxp.com>
Signed-off-by: Jun Li <jun.li@nxp.com>
---
Changes since V2:
- Updated commit title as SW change also applies to i.MX7D device.
- Updated commit log based on comments made by Peter Chen <peter.chen@kernel.org>.
Changes since V1:
- Updated commit log to include commit ID fix as suggested by Jun Li <jun.li@nxp.com>.
 drivers/usb/chipidea/usbmisc_imx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 4545b23bda3f..bac0f5458cab 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -686,6 +686,16 @@ static int imx7d_charger_secondary_detection(struct imx_usbmisc_data *data)
 	int val;
 	unsigned long flags;
 
+	/* Clear VDATSRCENB0 to disable VDP_SRC and IDM_SNK required by BC 1.2 spec */
+	spin_lock_irqsave(&usbmisc->lock, flags);
+	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
+	val &= ~MX7D_USB_OTG_PHY_CFG2_CHRG_VDATSRCENB0;
+	writel(val, usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
+	spin_unlock_irqrestore(&usbmisc->lock, flags);
+
+	/* TVDMSRC_DIS */
+	msleep(20);
+
 	/* VDM_SRC is connected to D- and IDP_SINK is connected to D+ */
 	spin_lock_irqsave(&usbmisc->lock, flags);
 	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
@@ -695,7 +705,8 @@ static int imx7d_charger_secondary_detection(struct imx_usbmisc_data *data)
 				usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
 	spin_unlock_irqrestore(&usbmisc->lock, flags);
 
-	usleep_range(1000, 2000);
+	/* TVDMSRC_ON */
+	msleep(40);
 
 	/*
 	 * Per BC 1.2, check voltage of D+:
@@ -798,7 +809,8 @@ static int imx7d_charger_primary_detection(struct imx_usbmisc_data *data)
 				usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
 	spin_unlock_irqrestore(&usbmisc->lock, flags);
 
-	usleep_range(1000, 2000);
+	/* TVDPSRC_ON */
+	msleep(40);
 
 	/* Check if D- is less than VDAT_REF to determine an SDP per BC 1.2 */
 	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_STATUS);
-- 
2.25.1

