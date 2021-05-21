Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BCA38C4D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhEUKaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:30:13 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:30180
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234122AbhEUK3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:29:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzvY+CuBdhdt526IV1y0cDXRdLu5QqyU6ezxMU4x9Vm19mEBBHRS76F6ey3dDoqBVNjGZG+n07JrSB/oySCFVphR8I2WT3DJNkRtDx4YPswvt4foB2THGTPsjgaURvxvIzc7YA6BmcQRPkkmskv0QxtZw/0O/qvbTJF0pmy9xdfNNdmRo1O6/PlH8luh/59GKUXSAv6ZSDYd4P8CwteMO2ohN7rRFtzpdwYjFOGBZtSsfWTzk8WoiwJGntlvko+ZCPj/sflmB19VywpzBFDA1gzuLOA4+iCd7b3puInQd+beNrHEZGMjUJ8tBd6EPLqv6TttxYcRzTSJK9yDhEqAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/woyMMdDjmoLpw+OB3GH/kDvCzq6VvqWMWVeZD4Bi+A=;
 b=kEDL24n2Q1cbtZQaYy+pHn/Q6zE/n/Uery/mMFzGBJAUFaFBRhrCmFLTPq5HsFWjfmmoD01uF/vcEM8ueBxc7yx53Vu5u1OhqYEG/WNUSyczH6Gq7zK3tTn33fNgoLdrFif1RQxsmsvhJ5JZM5AcYFUSGHWSNHnZzpwCCDYf1vg2svSJltC1nt2tiWEX/SHosJNNVLOJlLoREbO3Zf5v/MkUbXOqZjYoss7WxuEorszb1M+lys+Epzair6LLhHj2fHuzq8lEnjNKhyN3/wXBNE35IqYX0xWwoRa1SJgA5EYp6aGZ0MOKRntAOyVtpiqckRtOroJxr+Bk2mUtNw6Low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/woyMMdDjmoLpw+OB3GH/kDvCzq6VvqWMWVeZD4Bi+A=;
 b=Yjv6KDZdZcfuD9fVMoVv6gj5OaI2DUr0vclCRMufnRHlWLcZMQXJ+lp+KABeC9SN8XHnhmhyVAP6Ug174UlXA3PO8HXW4+TeHE7ZLYjtr8sac/dSaELvj6oBHl3ees9iXu2HA9c7C6CPKca5j+epEGpsS3YLgziSswxUltKqy9M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4636.eurprd04.prod.outlook.com (2603:10a6:5:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 21 May
 2021 10:27:13 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 10:27:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V5 1/4] dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
Date:   Fri, 21 May 2021 18:59:16 +0800
Message-Id: <20210521105919.20167-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210521105919.20167-1-peng.fan@oss.nxp.com>
References: <20210521105919.20167-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0163.apcprd06.prod.outlook.com
 (2603:1096:1:1e::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0163.apcprd06.prod.outlook.com (2603:1096:1:1e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 10:27:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11f125c0-9464-4db6-6f5c-08d91c42ff80
X-MS-TrafficTypeDiagnostic: DB7PR04MB4636:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB46365214118CAFA4EB05ED16C9299@DB7PR04MB4636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgQCSNppBMO3PUbrAGv/1H4fCwkAXEvo72XBWlX4QOeP8fKRjyEPCs/+5zNumkYW1W4zrjJMobi4IAXKDzVukYmKrIS3WcvX+/QIUOdNvAI7VJ5XUQZxl/N6sB/3IYp+ewI9Ow8KCRl/Eg4YD9PHIQ8pNtF6eMHamBkcV+bSqRGsjTduQTrvOC7t1vdDL0ZTLf15MW9HQ4ESg8uwYV4xAOJmuNA3ojfE2WFJ4EJGUufDMO0Zf1iQC+lXz8RED57NlF4uc9dlJCFRP9wjCPl3gqVGal2mnckLvzM9rSVytmSCU2Eat8VuEo6Zirzn04Z8hTMub118FBCtDGXHvZRY357QL1iW/BhHBzDI/ZnUdPNKnoNQoqKrO/wVIAyf275EtNky20PKtgcIkT85yxjVxP1VFtj/setG3cUNtA+0Dpm1Ognw8fWyHoi+V/3IyG2XkbImBkTq+0CoqxCE5RacC5Vr4dny8VdVwWhq9ztXqLrmvo8YOwOpuggo8/s0eZ/GfPQj5XbjBbm3yCMi/WcAhbOmiJPdXYUEZKkVBC5aSD0aSFeH14xN42SEvOuWak8/mHEuwBR6eCjd/+T7oqy6fCVMVbNjZvupqERKWRCo+dKM2YLy91fWPZPL29g16qKu0OYEUKuVlE7p/f0iQhlrNkhNzaLrIgkLXzavo0HhlVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(16526019)(1076003)(6486002)(4326008)(956004)(6506007)(478600001)(186003)(6512007)(5660300002)(2616005)(52116002)(8676002)(8936002)(86362001)(7416002)(66556008)(26005)(38100700002)(66476007)(6666004)(2906002)(54906003)(316002)(66946007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BnD10z/9b9OpG2YkrILJ9VXbAS4fxKtPRJJgCgS9Rgw7iNu6psBmX5Yg7oMq?=
 =?us-ascii?Q?to4qj6Nfhj7f+p+xf/m8Xybz4BiqPe66MNhkTLWQhff4i+oCuzyYiLybO0hO?=
 =?us-ascii?Q?lLyDn1Wr+iHzat251+0DvEGS2Gz9/+kYiVnBEpf4fJ3HSwMvIP05kFCaNWpV?=
 =?us-ascii?Q?VlPCYgDJqs8qqykpPsoV1XXMSOP+5ulkVZlPSeWHqAcNtzwGhxIGkAr2G4bT?=
 =?us-ascii?Q?3D28EW7yo8CmIsNCWHGqOoGaeHAYNs1RbSXmNyW2wib0nws2HywvVjE628CO?=
 =?us-ascii?Q?O4I5aB2T8o6v3kvECe0ZD0I0bL5M/ty9jix398OcSHY2OlBPV+GOmkMvyYG/?=
 =?us-ascii?Q?0A3hYt1plLzDCu1CRPsYh0iXR6MtbmWKNZapUX8TGrDBhJJkG4VxVbB/x1Vm?=
 =?us-ascii?Q?YpTL7/4GwCy9BK+W1LiWEG5OFfmNfr6mCq4iS65RJN0HsiFqPJ5z1fzlocIN?=
 =?us-ascii?Q?mJV14nsHd3tI/lWLQs5urP4XUOXme3g6Cu3R/ZnrjNsTXegM+6FU1VM5C3qT?=
 =?us-ascii?Q?JT4Yz0E6aTNdLO2gA74mwcUahST76s8tDtbxyjxVY5SV0JILD4TkosWeVZEy?=
 =?us-ascii?Q?DAueMMdaIEhyWoLQ4LOAMxnWZrsu7SZrL8MMyI4f9zig2Ntl5Vx6T7lfEbIT?=
 =?us-ascii?Q?culfQYHKRk74mYLtkOeefDy7aux1vgEeHK1RBZNDufQOz7OE73QecTjNcQFR?=
 =?us-ascii?Q?SxRmiQngUphUBTom+P93v26lCeh1mcxNqqbdekXV2IhGl11iB7oDEeIXS5Ts?=
 =?us-ascii?Q?KWvZooBMNS73QcxqI+NnzKsBUatLRdPkCP8ogMNJ4uAhQDGQhqk2RF6D8o/P?=
 =?us-ascii?Q?ZQdkBTrr6AyeyPp5jj0ML3BoutapCHTQJxfEjtQ8pbz81GqeF7A+tXY+qJSa?=
 =?us-ascii?Q?FFffz+YBTZjPUqOxuVuikvDTzCEnJZP0vIiVApehJyIjybu4UfUy/Mvelt0d?=
 =?us-ascii?Q?nPHmrrmIcFB6WSlxWzXs7drtGTlpUBV9xeUcQqa4Kz5Je3KJ/mSKTKZEVsOK?=
 =?us-ascii?Q?2Wh6B4DPJbiFUW5jPJs15KP9z+E59RTLs10qb22Xj2i41a9KLBOhiSzApNTp?=
 =?us-ascii?Q?23+KTthxv8dTYBDflob/rz5PjwdnDcMOaQBaXVllrVgRKMz8dn/n3OtSdegR?=
 =?us-ascii?Q?35ziA7Tr8lilaxvKdXYIYReiQjwl97YPhfzdbhP4cjmIvahFGTmZV7grRadX?=
 =?us-ascii?Q?I3deQCbsyzbgSI/fbhKmJQBbSpcjuZVx4S3rXjPQTdaCen98vkW3gNpswupP?=
 =?us-ascii?Q?HiHAXYsfcMZY67s/jjfJ5aepmgvJ5xSvls0MbBBIt0In0d6HOd1ytCbb3r44?=
 =?us-ascii?Q?mfPNCnZ3Napl7wwJu3Syep7t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f125c0-9464-4db6-6f5c-08d91c42ff80
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 10:27:13.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnnxB9enNk2YuhHkUvgjKiIO7s/j+ypVPqDVa3bQdKFYtpgHNz0nOLjDbmqe473vD/m/be4nTDvEcCaoHh7JFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4636
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Adding the defines for i.MX8MM BLK-CTL power domains.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/power/imx8mm-power.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
index fc9c2e16aadc..982ca2939cdc 100644
--- a/include/dt-bindings/power/imx8mm-power.h
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -19,4 +19,17 @@
 #define IMX8MM_POWER_DOMAIN_DISPMIX	10
 #define IMX8MM_POWER_DOMAIN_MIPI	11
 
+#define IMX8MM_BLK_CTL_PD_VPU_G2		0
+#define IMX8MM_BLK_CTL_PD_VPU_G1		1
+#define IMX8MM_BLK_CTL_PD_VPU_H1		2
+#define IMX8MM_BLK_CTL_PD_VPU_BUS		3
+#define IMX8MM_BLK_CTL_PD_VPU_MAX		4
+
+#define IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE	0
+#define IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF		1
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI	2
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI	3
+#define IMX8MM_BLK_CTL_PD_DISPMIX_BUS		4
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MAX		5
+
 #endif
-- 
2.30.0

