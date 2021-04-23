Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44457368F93
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbhDWJnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:43:18 -0400
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:43790
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241820AbhDWJnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:43:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAvpOGqDisacT3p3Pa9EZm/Zo0CoNth79CXsqDK2j61xbwDv4mabRipAMceh8j4m/HhTd8v6vVKbM95i7bbAmPuaOjEONeD3rWVP6enyqXdTMlxviU/KDw4uKNpBAMvjixjdpY4FTUciRm9JqLRByQzepHlgqUdIx+PVMKPF5KkiPy53XzlYst2fvHf2W5/U56c57fmeQQDe6PEsyB+T7WB2PzslSA0FPQ6FkTiZrWNSsSMNCdrXur+BKewMzcZQfwT7Nr36U6r1ry5axlD2zIlotCBV1a+U/DqaLIRTy0v7gE8SBa0FUjTme2hIKwXwiyJQl9BxnMZb2LXHZavzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoMUdqA2OyqCBybPV0IXzjVbE71UnLKGZ0hGPNA0S5k=;
 b=cblAqmQsOwrsBANtI5IGJPCmQ8iHTSJmL2BcRPNqenS4owKEwpVBIEvkfB/RnHUR/7nKzy/DdS2T/TUcewwg1+mwBr0thYimviq3fB+FnLW0+glaBOedWf8JBhLwDkKQWfs0H240GrrhVwoSq8uH2EhQxoC/BgkOviCA0vy1/mnBRcxGkWXc3xVNC37nZM8Ym7pSuc9p0I6MKiYarxMzDOrgyhH6dHFEJN8ibGOXTLc2yPduSe//oD2t7Y7JFaLkOYY2jmIWiTsc8ge3Bk6ABHV3qJCnKfkJtficiENtiQcSQABjBTIEPglASo9UAFYFR12f8sEUrcmpd4nWgPX1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoMUdqA2OyqCBybPV0IXzjVbE71UnLKGZ0hGPNA0S5k=;
 b=LBCCW5WaK4ZYDCdYABhrR1Jf1N4hDQ13k3d6kcNSaz7qOHUWIARIW+nypFNcOvCOi3GPT4mTMHQcfQHBBMdjJrLIa9cd9ST/kG6xmx/BaNpYZtUFmDzmWRn3oxywbD792rkcuscM8J7Ao3lRdRVe8THtbldvbOTy25E1mLwJpgw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB5711.eurprd04.prod.outlook.com (2603:10a6:803:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 09:42:33 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28%7]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 09:42:33 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        agx@sigxcpu.org, robert.chiras@nxp.com, linux-imx@nxp.com
Subject: [PATCH v3 3/3] drm/bridge: nwl-dsi: Get MIPI DSI controller and PHY ready in ->mode_set()
Date:   Fri, 23 Apr 2021 17:26:43 +0800
Message-Id: <1619170003-4817-4-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619170003-4817-1-git-send-email-victor.liu@nxp.com>
References: <1619170003-4817-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0181.apcprd02.prod.outlook.com (2603:1096:201:21::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 09:42:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e10bee85-7b80-44f6-1ddc-08d9063c1e82
X-MS-TrafficTypeDiagnostic: VI1PR04MB5711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5711726248BEBCF9F27B509298459@VI1PR04MB5711.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZXr0LK96cAE4OfcFwvwY538FulBcuNEiliQlTsB/CEYgae3VnkV+0W3ffQ9doq2QPuXQzNZP6pNEx2uJLnaSuA2tBsYvwl1WM6ztwlQg6ghX7o2NYCR+d9hOlKHLeZ7Rsw+kDu7rCNOtMC2wdp9Qxyl72j8Ygk7uFHUvkbqr0ba0sBa0w3P0AnoXRFWZejciQxITlZR5NV1lahvLyJSL8a6XLSiy0jMMN3amzmSGlOwuJ0rqwOlG7kucJnYtzfCenyWgywlecPge/Cv0WdzWr5J1BOOUXtRAHca377W+AK3tU7ctLvgZMaOHjyF8ZVvsN5oiLn4bwhm1krAEkbsYJuKEUTUay1jKPV7fE5I1bKs4An+HqyiqfJUG4/WIDCZsiSXspG8jYooSvoMEl7uoTJ7Cvj14eprL36i5aKKT04ODSDbyiwNa/uXjQeV+gPKA5J0jS006vapkjN634idVUkoM263PycnE9gAMil5p8f0gnqz62bZBKQLqNPj3EheLWsmBgGCkfjmHIrqODx9JWIpj5wODVDtfcz9YlfeJ1WuZsSddifMlGHXSVtvJ8sRDO3tSXNw1b2cVpY8uJJw6FPUZvTqMZ2XdqyPCfsRdiDpi7rWWmJL0IGvKJ/gpHBwm28RkkSpxyXWK1XaZOwprD4+W6220FGvG8VF62AOAtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(38100700002)(4326008)(8936002)(316002)(83380400001)(6916009)(52116002)(86362001)(6506007)(36756003)(6512007)(186003)(38350700002)(16526019)(66476007)(8676002)(26005)(7416002)(66556008)(66946007)(6486002)(2906002)(956004)(5660300002)(478600001)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WEw3c0xkMExSZmxLYVlFYVYrN0lzQ3hwUzN1cEthbUpGcG5WM3RzNkUxRjZt?=
 =?utf-8?B?SStveFJkeXZyaU9Ednk4dEp2UGVRa2d1dEJ0cVVobFE1NzdYNCs1azI5WlF0?=
 =?utf-8?B?UnE2ejN2RCtIcm52am5UODJrRGp2Z0hvczJzZks4MjFKajZlUmRXQjJDM0Vi?=
 =?utf-8?B?NWdyNjIxT2VtTk1pSGxpbTU4Tk9GcmxRTGdZSERzSGo3S0p6djV4clhMajNt?=
 =?utf-8?B?d3BTeGNHeGVsL29iWnB0aXBhc0s5SUczYXpaK0pDaVdoc0p1OWR4ZkplV2JG?=
 =?utf-8?B?MThkbmwvR2RDcnFjSWxkaUVqa3grN2RiV3FCR1Q5QXJVdGlkNGdoM3dOLy9q?=
 =?utf-8?B?dFgwV0NDeTk0bkJpNTZEYmVvWFJqUmlqMGtoLzExSmRDMHRQb0I4eEVFbEVE?=
 =?utf-8?B?MXJ0QStnVC9LSUtySmlhRG50SFpObEQxNDdDSWttY281aHpkby9RUWg5TTJP?=
 =?utf-8?B?aktIbEVEY3BFaGRpT0pqMnkwOGRIakZtMmhXRmpLdGd3U3ZZMWZOUGRWYktB?=
 =?utf-8?B?MmIvdWtMMndJb0tWeS9NU0J3T1FFaXpWWkhkUEViTjFSaW4wSzI5MFJxVDhM?=
 =?utf-8?B?ajVYTXAxSThhaWo2ZEwxM3NYVXl4UUhIb1VucTVsenk3Ly9Lb3dzeVA4NW9B?=
 =?utf-8?B?Wi9ZZVM3QzNSajZrbmU0SGltRTJtK2Z0WEk1eEk1bUQ3ZXR5ME43bXpONlUx?=
 =?utf-8?B?U0VPdlk4MEx1QnRsQkUyeTJZRklZS3FKQ2dRd0FLWXFlK2g4YWRmeG1pTExQ?=
 =?utf-8?B?dWF1TnhZWnlvRmp5dDY0WXplY0VFNzNiYWd4bHd2dGxlb0tlSU1XaEMzdExZ?=
 =?utf-8?B?a0FWaGE1VFc5TExCSFdGT0RzdmRGaURTZDZKRmZPMWk5aDg1M2xHQmFFekpR?=
 =?utf-8?B?RHZIeTBLZHFQZjJLb29JcW9sSHBBWWR1Yk8xNjg3WWk2QUZvU0lWR2JCemg3?=
 =?utf-8?B?NGNuTjhoaEN5bkdTT2ZCSkNvMmphbXhUUThBalBSR0pBU0s4S0dXbE4ybytH?=
 =?utf-8?B?WVJ5UjRNT256NTcwam03aGNNYmdkdS9jQm5vRFl1VmZBYTJvcy83WjhPQU1h?=
 =?utf-8?B?SkR3WGs2eXRnNm8yd0ttWjNWVFZySW5oeW1ZTHZUQWZpcWlIdjJIeUVDZVR5?=
 =?utf-8?B?enpHSkN2UVIzcG1lTHRleTVMUVhPd3JJdmhzZmhGdFFrb2VZbk5Mc3NlNDFP?=
 =?utf-8?B?bmFCQnRmYVpER0Z1T3QzWkZYMi9uMmUyZEpjMGQ3N3RwRENnVGpiSm1CbHNk?=
 =?utf-8?B?NmxOeUt1V2RadXF5YmxjNzZSb01SelVSRHB5biswd1Q0MGdablY1Wm1XWVpB?=
 =?utf-8?B?Wnp1UWdTU3V2Qml6LzJBeGVPa29WZVl0d3VQK2hSdm9CWlZkU05rUnN3RXd4?=
 =?utf-8?B?V0RUQnAyNnFBVVFFb0N4QU4rblZvcDFoV3E5TXkrakxoUnJ6ckVmcHRtRFlF?=
 =?utf-8?B?aklkRVlpWk9LcWNQUjNhb2hZeDRQZWFaNEJIYmY4Tmk0MXI4RUhqQnVVSGhn?=
 =?utf-8?B?aXlPTjJhd1lXaHBpcjZvSnM5R25aM090NGprWm5yeEtlT1JrUHlqVmFpd2g2?=
 =?utf-8?B?ZWhMSFRsa1VKNjN2amRxZStuUXFoTHRjdW9ZOUtBYVF3R2p1VnM0elBwRFln?=
 =?utf-8?B?em1hbExLd0xpUGRUeUIyQmFKb01RUFJYRW42a0k0SW10QXVDNE1CYSs2Z2Y4?=
 =?utf-8?B?VFRPWWovZWw5V2ZDd2RaOUdRMVVXOWl4SkxBZDlVYXpvMHdKZ0ZnU3RyYmcv?=
 =?utf-8?Q?GiwOIuQdyWjqrlEK4fT8GHfQoPfNdky9oTMv/Ha?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10bee85-7b80-44f6-1ddc-08d9063c1e82
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 09:42:33.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWpxbGv2EKDBVHuFvcwkeyzMFNs+0NoUt3RM7IfvWPuGP8p71nNgI0p80uazx9DpfcMqliqItOvhZ76dsYHaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some MIPI DSI panel drivers like 'raydium,rm68200' send
MIPI_DCS_SET_DISPLAY_ON commands in panel_funcs->prepare(), which
requires the MIPI DSI controller and PHY to be ready beforehand.
Without this patch, the nwl-dsi driver gets the MIPI DSI controller
and PHY ready in bridge_funcs->atomic_pre_enable(), which happens after
the panel_funcs->prepare().  So, this patch shifts the bridge operation
ealier from bridge_funcs->atomic_pre_enable() to bridge_funcs->mode_set().
This way, more MIPI DSI panels can connect to this nwl-dsi bridge.

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Guido Günther <agx@sigxcpu.org>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2->v3:
* Split some changes to patch 1/3 and 2/3, to clarify changes. (Neil)

v1->v2:
* Fix a typo in commit message - s/unchange/unchanged/

 drivers/gpu/drm/bridge/nwl-dsi.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 601ccc4a7cdc7..873995f0a7416 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -662,7 +662,7 @@ static irqreturn_t nwl_dsi_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int nwl_dsi_enable(struct nwl_dsi *dsi)
+static int nwl_dsi_mode_set(struct nwl_dsi *dsi)
 {
 	struct device *dev = dsi->dev;
 	union phy_configure_opts *phy_cfg = &dsi->phy_cfg;
@@ -834,7 +834,12 @@ static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
 	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
 
-	/* Do a full modeset if crtc_state->active is changed to be true. */
+	/*
+	 * Do a full modeset if crtc_state->active is changed to be true.
+	 * This ensures our ->mode_set() is called to get the DSI controller
+	 * and the PHY ready to send DCS commands, when only the connector's
+	 * DPMS is brought out of "Off" status.
+	 */
 	if (crtc_state->active_changed && crtc_state->active)
 		crtc_state->mode_changed = true;
 
@@ -863,16 +868,8 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 
 	memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
 	drm_mode_debug_printmodeline(adjusted_mode);
-}
-
-static void
-nwl_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
-				 struct drm_bridge_state *old_bridge_state)
-{
-	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
-	int ret;
 
-	pm_runtime_get_sync(dsi->dev);
+	pm_runtime_get_sync(dev);
 
 	if (clk_prepare_enable(dsi->lcdif_clk) < 0)
 		return;
@@ -882,22 +879,22 @@ nwl_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	/* Step 1 from DSI reset-out instructions */
 	ret = reset_control_deassert(dsi->rst_pclk);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dsi->dev, "Failed to deassert PCLK: %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to deassert PCLK: %d\n", ret);
 		return;
 	}
 
 	/* Step 2 from DSI reset-out instructions */
-	nwl_dsi_enable(dsi);
+	nwl_dsi_mode_set(dsi);
 
 	/* Step 3 from DSI reset-out instructions */
 	ret = reset_control_deassert(dsi->rst_esc);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dsi->dev, "Failed to deassert ESC: %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to deassert ESC: %d\n", ret);
 		return;
 	}
 	ret = reset_control_deassert(dsi->rst_byte);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dsi->dev, "Failed to deassert BYTE: %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to deassert BYTE: %d\n", ret);
 		return;
 	}
 }
@@ -953,7 +950,6 @@ static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset		= drm_atomic_helper_bridge_reset,
 	.atomic_check		= nwl_dsi_bridge_atomic_check,
-	.atomic_pre_enable	= nwl_dsi_bridge_atomic_pre_enable,
 	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
 	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
 	.mode_set		= nwl_dsi_bridge_mode_set,
-- 
2.25.1

