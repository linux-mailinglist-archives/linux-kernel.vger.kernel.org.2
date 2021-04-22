Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8836794E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhDVFa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:30:26 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:16715
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230189AbhDVFaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:30:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPgZpG8njkJ1ySAR/7Z4RnsQZ9z7QrTCuoj+sENNhbCyOo0IAQS26p3gzk9l2laaRHlhbxDC5+xHHGvv2ISNAw8clGgF/0LzHqhJMzCAPpu/7jTYrzLVWTN9P/E7YxLM6lj6mLcFuPMU7RSpvFVULvfJXXOj7eRvTO0+UavOCkIQYxWzTf08C72ytKEoiTkmnr1gcWyEIL0JwlBNbpmvrQu/EacDkuJKh/vQEnu+55Dg4cZ2OGITuAdHj5Q7h6/RlMV6Cmlss/70GgxKRzhYOV4hpdMvBLI3eCXo6s8fpG8jpvE1ofvAw7IPzJPESSo1oYz0Grgy7yYTa6jyhiMoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/d1A9TTSddTV+yDZWOc6z9ylBryz7emjPznElN62Xo=;
 b=S4grGMTQyBZYHmrqSDQ7BB2Kr1wxiVpFuTLVDcSJasU82TdgT2u0w+kO4TkWuE0uHd4qjfNbrQXD5qHD49po3cjJi4TNVRGsEgJKALas1VZaEdigXmUw/BxX90m5KlbA/vSh04qPU/F+EcTJQBGNV7tjnYPAgtiiBI0uAZnzN1tPibwbQa2FCNdAqw3TIrfAWofZODiaupLorfi5vHtM7TMbwAagh0gRlqoTis8OqgbOh48UliM3LEw9MIidN7qU8lBW7t39a70FOMfss8fSTdagTjTSj5rTgxvjtvx3Pz3LMBwvsS73NZqoss33dEDTfQUDH2kR/2oUkra7VaGNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/d1A9TTSddTV+yDZWOc6z9ylBryz7emjPznElN62Xo=;
 b=IBP4VT4/0NtyxV4fea0ICPCQvdZ2qnAD+IL+I5aDUfT4OVCyna51omTQeWbZnMGTXTAHzhYFW4wgHJUhpg+KrRbLksPIklXguVWqJTb6QKGuEuTtPQ8hyQCawK+1f8i/Qkqu8h322BkfMXbPGAqyg3iycITiotiKjjj+r6iRHOw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB6814.eurprd04.prod.outlook.com (2603:10a6:803:138::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 05:29:48 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28%7]) with mapi id 15.20.4065.021; Thu, 22 Apr 2021
 05:29:48 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2] drm/bridge: nwl-dsi: Get MIPI DSI controller and PHY ready in ->mode_set()
Date:   Thu, 22 Apr 2021 13:14:15 +0800
Message-Id: <1619068455-1932-1-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0161.apcprd02.prod.outlook.com (2603:1096:201:1f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 05:29:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c9de187-c2f8-4e15-208d-08d9054fa4fc
X-MS-TrafficTypeDiagnostic: VI1PR04MB6814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB68148C2D9E8991666B7C4EB798469@VI1PR04MB6814.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: US9akwvrbASv9Ou9MyEyJXvqHZ4aUz5CloufvPDXL2OaMgR3h9jB6pO4fxcmBU79GkFPKHd3JLJ0pnA9AGt0hSlTDNxVJw0lTC9MXqKJlSK6Qf/4sczwVI1uQ7TxK0vMUPTYCwMwRvdxQdiwOUm42CeogRGlIm+5d164My1oTD3oQlAjgBmjzeQzfZD88oxJNWwN/aNqI0yniEKe0soMqEknKFTAkz74r7BMjIQFUIQc6JeZ16+9K3UdcYB2olX/A58q6oH3Oth46tWrkv2odQPMSQPd4TS/tgGSPRCekcoaJvFKSSdiAg7OrGCUFxgDDrwX+yo7zbvqp95teXHRfggP9EevXeyCN2BkiDQAf8T6GhBfjWV8H7AlSO+PGM/vc1gP/sISduheN0RLOd+oS5UOHPVr+dmHlIuymttWcZ/MTLi1DGTosE15wyJyudkXgZAJAV2DGGULGw8V+AZYp+VTmod9HPkBIQscG2zqg2/H7Bc1MrrcEwMPa2coSoa7TxkmQ4LnNwer+3R3Se9UfCDRwn/Pz+oyEFMd9yJuL5N8gDu9NiUiCLyn5kefa5p3OfAKEBhnghLqVWYUtS6LH0IRakwvC/9P/QrdSKACnwRgCq3gGREccvKbjowGLZleZS55AF5hosdkgsgEAyV7Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(2616005)(52116002)(6916009)(6486002)(6666004)(316002)(7416002)(8676002)(4326008)(66556008)(2906002)(186003)(26005)(83380400001)(16526019)(6512007)(66946007)(38350700002)(8936002)(38100700002)(5660300002)(6506007)(66476007)(54906003)(36756003)(478600001)(86362001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Yjd1a2ZDR3NOSEJjZk1yczVvQzBOWWgzTGpoUVBRdXQreGtpS1UydmZYOGxQ?=
 =?utf-8?B?bzV0bGZMMUhWb3pUVGk1SkxiNXczQjZDMUtWbHNwdlN1NDRBQU5WL1pOa1Zh?=
 =?utf-8?B?UGJySjhxN3ZmWjZMY0EvWVhHc1dIWVZCRWZkazZlbVlIYmJOdHA4TlFPdWpG?=
 =?utf-8?B?TXNLbnE2aWd5WmxPVkVGUGo2eEt2dUdEUFQwcmJmakE2Tkl2UE1JQUNnditW?=
 =?utf-8?B?NC80aFNsTW5abFFxOTBsT2Q0NS9uN3dKMFAvNXpYYTBqSWdaZm1LTkJGN2hx?=
 =?utf-8?B?WFNnUG9leFJEZHdqekM1bkdhU1owVG5OMnBMT2hVVjZGQ0pFVVNmTSsxVEVn?=
 =?utf-8?B?YWVFUm9TRkFUVlpvLzJockg1VlVZNDZIbmVEekZkVTFtdS9lVVdmS1FyUEZj?=
 =?utf-8?B?YW9HZGxMVThyTkh3WlVCUFkwK0crY1p6THYrbmZQT3N4ZHJYOVFpano0QXpH?=
 =?utf-8?B?QnprNzhoSU9FWlFyc3VEM1dzR0Jnb3hWeFEyQUkzaWovNm5MS0ZWTnRYTks0?=
 =?utf-8?B?NG1ZTE5pb294OXVYMXFoVzlUZE1WSGpraEJ4c2k3MDdjL1Fwckp1Njgrb2Np?=
 =?utf-8?B?WldxS0RNSDNjNkhwS1QzRXRrMG1XbGNRYVFiYXlmVE5sTnB6aDhSV3J4cUVF?=
 =?utf-8?B?aHpqZFhVV2RnRUNsZXhQd21qQVlUNytBU3VxbXFYMHFoaklxYnAwL2pJQWZQ?=
 =?utf-8?B?MnRUM0lHYzRZaW5KQzYzTlZTdVdJTGZhdENGSmljcCtMNGt6Y1JaUTFKd04x?=
 =?utf-8?B?SCs2OFdCalNmeXNPYzd1NFR3Q2NYSU5OYnhkQm0zQk1IZncvS0pjMU9OTHdp?=
 =?utf-8?B?SjBzWEpRUFloeUh0RXllTFA4WFJrYXNYT2tZS2NLbkJYZ0pPYTQxbGx3VG9s?=
 =?utf-8?B?N1gvRXpUMFVMWGdWZjI1dWZIZ0U2SDZMMWRqcEdTOS90TjlPOXAydEZacE5m?=
 =?utf-8?B?OEtwdnNDRlRLVEViWExQOGxDYWdiVHpoaVBrL1paN3ZzQU9zTWtCM2NxSGhO?=
 =?utf-8?B?eFRHeEZLT28xVEtSRHFEV3c5MEZyRjZTVUpqdHdiem5WMnlaa0dOYnE2bjdZ?=
 =?utf-8?B?akxGNnhNSmhpZTF6bU1YMzRibGMrMS9sdHVwNlExRldNZkpBazd2SXlYT1l5?=
 =?utf-8?B?dkcvSkV5R0V6U0dvWEFnZUxkc1FyS21CbUtCZkpVaXNlK2ppTllGRFFFN29D?=
 =?utf-8?B?VlhSSjhOSWd0MXA5TFJsSTkvOENmdkhESEsxMXFhZE1JbitMZTd0MTRPbURl?=
 =?utf-8?B?b3pINnErb0FRYW0xU1piTUNCN1lPVDdLWXl4aisxM0ExM0s1Uk1oUWkzTC9X?=
 =?utf-8?B?UnZFUzZKUGhLTHlHTE9uYmwraHFIZVMxV3BBT3AyUmc5QlIvM1dZd1BTYUxv?=
 =?utf-8?B?ZHUvdFdxNEZGMUZ0dk1ncnhZdWMyMkh5NHV0T1NVV2FoWm9icm5YckYvZ3pm?=
 =?utf-8?B?TUY5OVA4TndNSG1oRXFnRXJINnN6SXlYZm1LMmtHR0k0RUdXYnQvczFGZ0hF?=
 =?utf-8?B?N1V5TlBIU0t3Rm1kcmdOOXhKWGRGTUw0MURFMElvKy9qOWFhdFFINDhmbVNI?=
 =?utf-8?B?QVJ0SEtTallPMDQrcnNYMEppNEs0U1A5eWVzckhWWFVTcnNBTUt5S0g4RzVp?=
 =?utf-8?B?VEJ4K3JST3A0NUVSVGNML2padTEzZzhDRVFUZmFwdGVhcXJkZFE3S3VDN2I5?=
 =?utf-8?B?WjJkc3R5cTVlYWdEUmRmNDVKenRmZTBLY2dqd2JOM1VldmpvaFIyUmkvVWlO?=
 =?utf-8?Q?7mLXA2JvdoFm61YfV9Dtxp6iTxWVVQR7xaNG7tj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9de187-c2f8-4e15-208d-08d9054fa4fc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 05:29:48.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+RBVe+nlZyhcrV6vsOLiiqYwX4EC1z722013WVgn2g1Rro7dsZmVCb/+GsqDVzJQXWqfF1WO7XRxm8Cvm9SiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6814
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some MIPI DSI panel drivers like 'raydium,rm68200' send
MIPI_DCS_SET_DISPLAY_ON commands in panel_funcs->prepare(), which
requires the MIPI DSI controller and PHY to be ready beforehand.
Without this patch, the nwl-dsi driver gets the MIPI DSI controller
and PHY ready in bridge_funcs->pre_enable(), which happens after
the panel_funcs->prepare(). So, this patch shifts the bridge operation
ealier from bridge_funcs->pre_enable() to bridge_funcs->mode_set().
This way, more MIPI DSI panels can connect to this nwl-dsi bridge.
Care is taken to make sure bridge_funcs->mode_set()/atomic_disable()
are called in pairs, which includes removing a check on unchanged HS
clock rate and forcing a full modeset when only connector's DPMS is
brought out of "Off" status.

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
v1->v2:
* Fix commit message typo - s/unchange/unchanged/

 drivers/gpu/drm/bridge/nwl-dsi.c | 86 +++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index be6bfc5..229f0b1 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -21,6 +21,7 @@
 #include <linux/sys_soc.h>
 #include <linux/time64.h>
 
+#include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
@@ -661,7 +662,7 @@ static irqreturn_t nwl_dsi_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int nwl_dsi_enable(struct nwl_dsi *dsi)
+static int nwl_dsi_mode_set(struct nwl_dsi *dsi)
 {
 	struct device *dev = dsi->dev;
 	union phy_configure_opts *phy_cfg = &dsi->phy_cfg;
@@ -748,7 +749,9 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
 	return 0;
 }
 
-static void nwl_dsi_bridge_disable(struct drm_bridge *bridge)
+static void
+nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
+			      struct drm_bridge_state *old_bridge_state)
 {
 	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 	int ret;
@@ -809,17 +812,6 @@ static int nwl_dsi_get_dphy_params(struct nwl_dsi *dsi,
 	return 0;
 }
 
-static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
-				      const struct drm_display_mode *mode,
-				      struct drm_display_mode *adjusted_mode)
-{
-	/* At least LCDIF + NWL needs active high sync */
-	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
-	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
-
-	return true;
-}
-
 static enum drm_mode_status
 nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 			  const struct drm_display_info *info,
@@ -837,6 +829,29 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
+static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+
+	/* At least LCDIF + NWL needs active high sync */
+	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
+	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
+
+	/*
+	 * Do a full modeset if crtc_state->active is changed to be true.
+	 * This ensures our ->mode_set() is called to get the DSI controller
+	 * and the PHY ready to send DCS commands, when only the connector's
+	 * DPMS is brought out of "Off" status.
+	 */
+	if (crtc_state->active_changed && crtc_state->active)
+		crtc_state->mode_changed = true;
+
+	return 0;
+}
+
 static void
 nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 			const struct drm_display_mode *mode,
@@ -852,13 +867,6 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 	if (ret < 0)
 		return;
 
-	/*
-	 * If hs clock is unchanged, we're all good - all parameters are
-	 * derived from it atm.
-	 */
-	if (new_cfg.mipi_dphy.hs_clk_rate == dsi->phy_cfg.mipi_dphy.hs_clk_rate)
-		return;
-
 	phy_ref_rate = clk_get_rate(dsi->phy_ref_clk);
 	DRM_DEV_DEBUG_DRIVER(dev, "PHY at ref rate: %lu\n", phy_ref_rate);
 	/* Save the new desired phy config */
@@ -866,14 +874,8 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 
 	memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
 	drm_mode_debug_printmodeline(adjusted_mode);
-}
 
-static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
-{
-	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
-	int ret;
-
-	pm_runtime_get_sync(dsi->dev);
+	pm_runtime_get_sync(dev);
 
 	if (clk_prepare_enable(dsi->lcdif_clk) < 0)
 		return;
@@ -883,27 +885,29 @@ static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
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
 
-static void nwl_dsi_bridge_enable(struct drm_bridge *bridge)
+static void
+nwl_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
+			     struct drm_bridge_state *old_bridge_state)
 {
 	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 	int ret;
@@ -948,14 +952,16 @@ static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
 }
 
 static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
-	.pre_enable = nwl_dsi_bridge_pre_enable,
-	.enable     = nwl_dsi_bridge_enable,
-	.disable    = nwl_dsi_bridge_disable,
-	.mode_fixup = nwl_dsi_bridge_mode_fixup,
-	.mode_set   = nwl_dsi_bridge_mode_set,
-	.mode_valid = nwl_dsi_bridge_mode_valid,
-	.attach	    = nwl_dsi_bridge_attach,
-	.detach	    = nwl_dsi_bridge_detach,
+	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_check		= nwl_dsi_bridge_atomic_check,
+	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
+	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
+	.mode_set		= nwl_dsi_bridge_mode_set,
+	.mode_valid		= nwl_dsi_bridge_mode_valid,
+	.attach			= nwl_dsi_bridge_attach,
+	.detach			= nwl_dsi_bridge_detach,
 };
 
 static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
-- 
2.7.4

