Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51177310A37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBELY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:24:59 -0500
Received: from mail-bn8nam12on2120.outbound.protection.outlook.com ([40.107.237.120]:49395
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231217AbhBELPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:15:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2dXn4O3kbrJb3vvkHB87ny+cRzHQlClUSyRqUJZe8KQ5n0xnjO+bT0ZnJ0ToOlvkUgHADeFt66LReOq1/i4ShY4OE4luHfb1YQaSyyXa0tRWP69eQCiHqYKMseizOjuit9/8bwlp/3amcXMh7eBBiUv7MugvZ6L0GDqwbXgzo9IH3Z4oX5Rg2p5W+to3+WH/bBikhAPbk2PFZjvZgBlx4FefO+RcbfHKMUHu+S7AJ5a2enrbBOv1Q3s4oYS/l/5VJwVSqlwV8OQXhdITPLNidBWQ9KN6W7G/gkJS3GVkTevJjpBT5r4PERqEm2u/yrxHiT8u6/6rmO2HyaxvDxWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLqsEM2MoqYe3L87FPzeLuhZ3xHObDSW48BtBZljP9E=;
 b=kQxsRqbFRUbU89k17sy8uuDnmFgZIRQSh7gYc6ym7MZiP3woRLjD5xbRurtuTU0njGQJy+fWpbtRjtR+blXpysnKVUNQpGRwTqXYkt4usX3Xubotp6DcG3XF5ok0/b86Pbm2nVovDd0hu1apGwNu7oc+Ww6IR93LfKNXp7M2W5Eup/8nRik7OhPKGMN9wiqgugx4AIZOya2QZ/FrHGxXJ5F2119RgOMDS4dASnJZEkCDOA9/nY/uuKBsK1o0C50dstL95CV884vkhQOgVAD9t3ahy/0z6MtJkKrdeXwyNTniFuqtW++EhfDebXCBCtq4a7nthMsVR4X7Dn2J5HZf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLqsEM2MoqYe3L87FPzeLuhZ3xHObDSW48BtBZljP9E=;
 b=R0pJ3chQFXCI4kFs+36NCNWmiA/AWFOO/IsaKrzV9hQVzd9kERALIz2xmQLo2m+Kju1y0xqhej02j0jNsdrV0JqzLR7iBge2uqxJX/b6un6Ed0w+4kPRpwaDJuoTOdqYQXaDSN4TXJiq7ptUwbhosQFT8w2RiZ6cKKIUYhsZT5E=
Authentication-Results: driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BYAPR04MB4645.namprd04.prod.outlook.com (2603:10b6:a03:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 5 Feb
 2021 11:14:08 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::6481:f617:8105:491f]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::6481:f617:8105:491f%2]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 11:14:08 +0000
Date:   Fri, 5 Feb 2021 19:13:57 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Robert Foss <robert.foss@linaro.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sheng Pan <span@analogixsemi.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH] drm/bridge: anx7625: enable DSI EOTP
Message-ID: <20210205111357.GA18784@zhaomy-pc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [61.148.116.10]
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zhaomy-pc (61.148.116.10) by HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.3846.11 via Frontend Transport; Fri, 5 Feb 2021 11:14:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e8ab64-622a-4b91-6475-08d8c9c727dc
X-MS-TrafficTypeDiagnostic: BYAPR04MB4645:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR04MB4645FD7B2559EE0D8D68E2DEC7B29@BYAPR04MB4645.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMllZl+baRcwuZqEZ+Ezlhkb7vkXL2g2R4wSMhh1KWhdrHpA6xLALPKB7jaOplGNlgt0SveckST3jHnXAFIKN/Egxw56YW1QOgZCvsgGTHd8IPAWT6jCrJAmjr+4Yknbw+b7IY9covzh3l1vRNCpNx8vgI5KOAd7XJizeu1wASI+zDLh+/O8l3Ww7YolHhcFTYkWYPmT9sJnWDhJwGmNibfXMvA5jIXZq7Mw2IrW2Ldxval8KNZM2IIkotHcu+WP/cuEsaxOkbOz0eS+pFgl+5SE0GA5uQgvAtYnuhXggdQGwuJxBMMUSCfHJRetZ2mwaIHFo2YDLaAGoRaKRZg4Oy8lSyXi2HF/OWfU+6HlGVcWaGO7Pm9TPCI2Y3DI1qCypBEe541wMPpmWJFdwYGsTOdfmZDEmsubBF0WLsn8f0tgoU+9chWoPFIbC6EyQkaOH6fENyJLAHslrYiJey26VcKIh00yFoitMAGRniy8yRyDzyy923XiufE5ee7h9OeS9y/lnYFMCJH6XhaAQmQMMbJJZ3j25Q3n2hZLpfpYpRQ8tZCRhRbM/uzYjLaoZcwvUrTMLqKsQKeqifuTTlLHTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39840400004)(366004)(8936002)(6496006)(55016002)(7416002)(8676002)(956004)(6666004)(66476007)(110136005)(316002)(9686003)(1076003)(33656002)(86362001)(52116002)(66946007)(83380400001)(478600001)(4326008)(33716001)(66556008)(4744005)(26005)(186003)(16526019)(54906003)(5660300002)(2906002)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CPzNIZJrQEcFqRLlrU1gTUIS9U30VxNbsBCXqgglpjMF+EjFQLc59Jte/8VC?=
 =?us-ascii?Q?2UJp8f6En0antkgQle5bVsrZ9OUlD843HZIN4RKq1dASmTBB8VIIp3bWNIxA?=
 =?us-ascii?Q?SfVGejsNC0nQnV2+NzaPKIbz5U7+2qNqPeGcBCtt4jpEMWqes7FdQ9+OvMPj?=
 =?us-ascii?Q?vnJUjJVqLSBy6OhVs2yOfdRu7zPI1drNotIoCvNGiiKvzIdpGxNLFHnpgxIk?=
 =?us-ascii?Q?MegBlmULotkd46f00Tiz7VMtol2VQkksepLsPS6GaVYlRJWovRBFuaUUwJM7?=
 =?us-ascii?Q?wsG7RrRotXA9tlFUknrLd9baRwt9l6NPWDa8+VfDqEcmfGsCOkljbevwA+ue?=
 =?us-ascii?Q?kjl5dqHNsDbJUNES+f9dBTdtMglmMC3oSu0ZVHkIus310cro4xXLpO6CubPC?=
 =?us-ascii?Q?A2qtnZN2J9MvV+535VY4uWCScjqSN9fgbm5fvonnodm3sFmv7HxYjyCXEQR+?=
 =?us-ascii?Q?QGGNH/m2nDNJtga2URaNeSyskbx5JaOd/J7BOHUOrh2Tb3QyBB4v7AjHrhEB?=
 =?us-ascii?Q?a2LRRar9IWxaQGpS+Vuw714wZX7QUlPSC0mJH1KTunGypS2K8hlwcjIvIQA8?=
 =?us-ascii?Q?tofSQ9kCAj0C2kvsy+TkqD8ylzXURfU0KujIJfal8tVDFlCd8RvgynlNHUWm?=
 =?us-ascii?Q?9P9Xgf8jaUvgCvoK9U/1HhaDZNgi9+DV+mfRLwgjZbBaGrJDsU4RNn3+remU?=
 =?us-ascii?Q?yhvrqG/uEwmZqLpd3I42t5vcR9lkBIQBxC+k0jp52XFDBCXiq6jOq3q2QIvx?=
 =?us-ascii?Q?8qnCtz9EGJTmtjMDpCrA+RwJsbdQjEsEgyWGQXCOof632OS3rewRMRgfywLc?=
 =?us-ascii?Q?PdnomlaJh4OhKTXQUXsOBTRV6W9QW3Vwa+bmxTC/BnDwI/gVYHAW3x4UE1V3?=
 =?us-ascii?Q?1ZBt0aHC1lhIUHddOX747YS970LW35ZrRQLzRUOjlicdzIKUSB01QrTOu9dl?=
 =?us-ascii?Q?YgkFQcTNkAnCkUvPKQig9OTAMJCvMqRdyieGoDlEs4wK7dQiDeNuWBtj/7Re?=
 =?us-ascii?Q?lLxHAi6FhFyHvh297HzlMfuJNWqtsvqvKd1/e5HKbitUN48hrK814ay+EhBy?=
 =?us-ascii?Q?0TqsSuFL8c9alM1//qoV4UTl2bZ6q6QRu1IdVNzKrmHj0MFZGyZbP+fFDdOb?=
 =?us-ascii?Q?jcVgftuDF8Vu7OSOMGGsLWvLpRo33RdMHdP4RFvFJUyid19qjLMkKF+QcT03?=
 =?us-ascii?Q?7ueUVfGSxeDofbnhv0GfOIjjPa+hP6meZdotTKMya0CT22hpTde2/ud9HLbf?=
 =?us-ascii?Q?+1ajgtBrHqskE9CPv0u7+4mMc+wG3k6BfoIKxC/Z+XCL/en1zPSznUej084B?=
 =?us-ascii?Q?MMumaZRQ+8EiUUNRDkvkGDlg?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e8ab64-622a-4b91-6475-08d8c9c727dc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 11:14:07.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q27jZCGM7JGshkJNb/CZ4Szm+oXJH/u0L6puXG+5CO3R+pO+d0JWXgQ9J1hhvwsmeDtVwRtMeEkYj2bAODLQ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4645
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DSI EOTP feature for fixing some panel screen constant shift issue.
Removing MIPI flag MIPI_DSI_MODE_EOT_PACKET to enable DSI EOTP.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 65cc059..e31eeb1b 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1334,7 +1334,6 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO	|
 		MIPI_DSI_MODE_VIDEO_SYNC_PULSE	|
-		MIPI_DSI_MODE_EOT_PACKET	|
 		MIPI_DSI_MODE_VIDEO_HSE;
 
 	if (mipi_dsi_attach(dsi) < 0) {
-- 
2.7.4

