Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B212459D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhKWIIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:08:36 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:29302
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234709AbhKWII3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:08:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5klKyKLYtHpsT8Qb+zbMZBDwtiDOzAO10WuccDM+ynaLiWvnylLQDy8Qt8UNauX3UDz5xxj2mI5HUAvNLK4DOo++HezXdqdih3pVdSLc1XEXN//QnR+as/T/03SWlcqtifhSh2WoRWjWm/gGNFWMK73fpDXxS/a7sSSJrnma+omZW78/NPSqDoxQBExMQoPCrZP5XGf1YWJwNDrBRNaThgpWDv4DAqW/ZMvNAuFOvSVFD+5S/EjdBG2+8mUyGhSjvaXhvYHleLMrzv1Nmaxcg1n1paIr0nB0c7UScIgbylKd+HVi68tEWo84yfwr8xNNbIfi+zWtVo5NFB8QRcpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sMjNFxSn5YDvg/4fch8PTmtkvY+CkuYjdTbk5jr0uo=;
 b=SimlfL/jU9G8Vmtqo2KM/7lYlFI18PBPr8DpEVzL6/QVnKbii9lf4jC95c25z2JPe4p/x1xWW+m+CINXXPruNqaoc7+pIyCHU63kGNHPPxTLAU2VWu7kHj9exmwf/Jtk5hhj2YOAmJiYWAB+g4gbJaSjPHvLCdCAaHFKYs5fjX/6u5cRlTDsS4sg7uckOh5K/qnBi+B0aAULl9Sk5SgL4yrSHmM71/x02QDlv5Lb6Q0mbN+ZqhHttrWb3AmuIZDcc5Y7rFj1QZaiSGiGO54jOy0jJNVXvmcUY7IvTOLZbsYEQMiNukMfLQA7/nW3PjO/aKlcMvoYn4PkZn+Zy4+Liw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sMjNFxSn5YDvg/4fch8PTmtkvY+CkuYjdTbk5jr0uo=;
 b=PJT/t/txBlq6Essj3YXb5f5Vh7gqIuje3Lc5hRr0WxIRmS7uQAlKkn2I2Dh5J+lnLPLE8OPW5Dxoc1bIR2brcAFlaYQIVu+7VgZRe2XFmQ97gRJhKAAvwSiG2RzgKh9vak8Q+eaflqhK5t51MqEDbeoTLdRWFILZuOvfDKWxeYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6971.eurprd04.prod.outlook.com (2603:10a6:10:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 08:05:20 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:05:20 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] arm64: dts: imx8mp-evk: disable CLKOUT clock for ENET PHY
Date:   Tue, 23 Nov 2021 16:05:04 +0800
Message-Id: <20211123080506.21424-6-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 08:05:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3233e755-85c3-4c32-27e3-08d9ae57fe5d
X-MS-TrafficTypeDiagnostic: DB8PR04MB6971:
X-Microsoft-Antispam-PRVS: <DB8PR04MB697129C2A7331F432153E082E6609@DB8PR04MB6971.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFwDugnm1ug0ibAi53r64dJMSdtnDjjAmYJRugLowVjBN7Njbvj9aIjwzLq6yo9XTRxVy9ABM/8YprkE1/xZkIEczW7b/3wvIJsT4N1TacDWltHRRGsU0pQNAoApyVBtUHB1aN3nU/fHXr6LhDF4BqjWcaTNsl9MCdAp3W9f3zjkcBWgAENxVjnS7Qyp52cn79RNO8L2gsgCSrhoJWRWRMq0H7iavWfQ5T8GNnxH260a8RD2iLgLMOm/oouCmIO8IX0lmLDvDlTui5RFNHV6Md0MEum8l4o8T9q+L5ZnECtLkp568iHyvogdWz49FAXo1MHWnQFT57B6Zw/4MojHhh00ZOhWIVS7N+l1ycKlht/V5+5miNMB9fHTU91peZWFwvNwWNg9Qg/skAn6LIs4ldVLaqe57EOK4DDKKY9WsqqB5MXAobYUU+Bsf+vI/6Sb09VjHjRMu0IBO4utw8QMHz5Pkr5nBzEM+3d+g1g00dIOfGDJyctKm1NExxKH5d5fca0GTeiM2CgkoLOYXeN+LjcsqDXm9eHgUSbDB28dNSQb+9VpraWWOvlIgqXve9D1Z0bzzYCmETRG6pj2KU9BAyoD7a9bI6GHqAJyJxnNI+oVTyyNvsZTerfvkyYYsO6ytC1830qjXhOHsnx6pvQndhUxQWMf4b3DwJZR0d00sr+Ahd4qrIR3Lk5JXger9bkf+sucHcUZFlDs5N3h9T1uiQ2pklqQiPXFeOhKX3dJs3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8676002)(508600001)(2906002)(316002)(1076003)(66476007)(4744005)(6666004)(36756003)(66556008)(6512007)(956004)(2616005)(6486002)(66946007)(38100700002)(186003)(26005)(86362001)(83380400001)(38350700002)(6506007)(4326008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DkEuB06o/N1OJz6a7EEvgknVOCkhKep+G84ISvrrw+8OOSgSnXE74fFzdMi?=
 =?us-ascii?Q?Hu7W/SbKzIGF4/FSMy/eYZv/8RFMUyGRIq4jzc5pH0vLb+YZfoSj7sxifRbn?=
 =?us-ascii?Q?6vO2lg8euFflHt1PcTaO7A48fO9unTPxOwiYmKwPQRoGmIkbfjZedvIEvF44?=
 =?us-ascii?Q?CmAmlTOe4u5rw52Jc399NXZMM9jvsP/xnFclBiykW1ceiIBoYkxbnYSk3TNa?=
 =?us-ascii?Q?cvJlREjbfDROvYyxRiwmAQlCMdWu8PjWIoYM9etXu26zx8mqsT6FHUsR+IDh?=
 =?us-ascii?Q?YUkNV54c0L7SPm0V2lVsr+DAwLFapStAIJaIp94xnCRF8LgghMCtoTCft34D?=
 =?us-ascii?Q?BrXHFfHJ89rpa2BD0S9HJbHUCO4wsE2gEzvmq3uwltES4XHk7w9j6PAlc1fR?=
 =?us-ascii?Q?Qgf8vuRhmUIkbHpxSPoj0Et1XMbnA1nK7debHPPchYKaTumxV5wIuN4G0Gjz?=
 =?us-ascii?Q?3agFqbX12lRilYsDzpwyo2aCBI8gEvdV1EscG+zATQz4zy3NwaeZL1PxCDrF?=
 =?us-ascii?Q?OZBOc5HwQZQChClpICUbYq6RgHWUpZTE1zED9DJsN5e0J0JbvDZZUAfxltNG?=
 =?us-ascii?Q?eor/8rq53nkKHtd4FffXEJF0Us2H8zVvTrL2njxiJTZp4YQg/rwaJ2V5nUUk?=
 =?us-ascii?Q?CCJ50pSkIEUOXVZEPtSyjGBYeSzMhy+cDQi56ZxcmDSPvaWX3xw0/dRXX1nf?=
 =?us-ascii?Q?cHWZf4oiydowZGQUWvBhiH6FbagK9A/6vEcU3cjeiKOkynKVIeluqSJ5W7Gb?=
 =?us-ascii?Q?LNUk6Zy4hamuekWXVrFy/+j3F6N8fZH33W1cHaJDzYhFwDd6+Uy8wDdGovcL?=
 =?us-ascii?Q?MDf6Dm+4w7LSpMFr1jN6miIMW9+Ksy6wyATYeHsXpy90l7WmvcgD3BMIP/Id?=
 =?us-ascii?Q?696QXUZ2/0a0/A+VGL/AunNPL0Nu1bozs0K0ouv/c3iTA3C9nLc6whNNUjqA?=
 =?us-ascii?Q?pg1HvX8nIggo0fQcQvkDAo5bGzw9wK5DRC2Rynl3xgeY9bUXXasASDiDzSfH?=
 =?us-ascii?Q?TK6jYFPRYEX3OFy9bIQxybIzLOPjRxllxTxRxJZjHRDnxVAt1TU45Uff33Ac?=
 =?us-ascii?Q?ym8gsfQ3PYiuW7a0YThKfO/s3FYNs1+bZfMMyMA2dx+9dW/XzmtgoRctfJ+8?=
 =?us-ascii?Q?wjc0s7bUsgLaX/RL+PWH2VC1F++d3VxUGAF8MtSLUaifEyZInTHK/Qz7VrDh?=
 =?us-ascii?Q?5KthMDzndWETINp3kyucT6kXsWloz3Tqx5nQnjroddwi/oeuoEEpR+5eWb5+?=
 =?us-ascii?Q?JwXzgr6gznOIh8ARanKxEDF5f+2lGp5bNfvZmKOkG3vA0paUJMTfkloFu5m9?=
 =?us-ascii?Q?AaUNuhdFErGtZERPHezFJVVS05SlkfZGOWAsTowX9QvrCYBzj0dm22j791oL?=
 =?us-ascii?Q?algZZvTmSWxWMQCyyGKG8XBnkuyA0oHA/DcNF+MF9bDnWSQOBosChGoSStEk?=
 =?us-ascii?Q?6PUUA6qNi12UTzMSL/dHkFuPzPts2Z0Tn1RwvOdYrF9mpVbXKq67pda173qq?=
 =?us-ascii?Q?ikMjfnjetecDkt9SosL3d5rRLzIByQizAnbGOLRUt5Tg/MJrkPYcTj/7MYHW?=
 =?us-ascii?Q?GDmKP1UcREqbnDnf8mpQj4wzNFr5b6MqMQE+NS/d6jGrz7PLopnYKQVOlSAR?=
 =?us-ascii?Q?iB9svelpFFim/DN1niAyMLw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3233e755-85c3-4c32-27e3-08d9ae57fe5d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:05:20.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ul66fTPI9QTczme1jkFhkqshTQ3bH9EMQHCXyATt/eNVu/vbEBdvPa4xDY1jqRYFUUeS2c84kH38IUdvpGOaUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to commit 0a4355c2b7f8 ("net: phy: realtek: add dt property to
disable CLKOUT clock"), diable CLKOUT clock for FEC PHY to save power on
i.MX8MP EVK board.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index a7dc0d160f79..cf03a82f9dcd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -100,6 +100,7 @@
 			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <80000>;
+			realtek,clkout-disable;
 		};
 	};
 };
@@ -123,6 +124,7 @@
 			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <80000>;
+			realtek,clkout-disable;
 		};
 	};
 };
-- 
2.17.1

