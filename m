Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53211361DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbhDPJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:39:20 -0400
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]:30433
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242004AbhDPJjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:39:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjYgbTq3aRuYNo1hNSBzGJzjWZ83QxjWwx5mDwuThazMGeCZChEsXjuI8sLHHO95PldcETri0TS3H8iB9EXuaqK0HQB2pmqfDR1Wne6tMlhPZUodq0BIKVXJOex66XITFvHDx406DrxE0qqbPt65mW7rmCk60ol8r31hBd7MJl9XxMIlf1RcOcyChl/5tGoGygmWLbaAhkAqzk6VItII55Vqc+j0gBUD/Kge280BhsW7e8ydFK1u4+8xxTYjAPplwzKRgpsPeazYCe+xdpZWGfsVsn9MOeXT8hXbJugA87MKocCXrBBCoJuLaaOSE3o3c/xnk8eflVq+1ald63oOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T91D4WOmNM/0cIga8paSNvjqW56ERZpNAToqoSkvmk8=;
 b=M2xl5Hz5+WlqF35TaUXjPsaioeuq5SD8/sBG5MRJeBYaG80/hExrxGTDH+78v7h9M0LDqL8bdfFLrJ3xZ6Mc53WPJ/bAmuUFuLi8utrhRhjw7QG6bFzSj1qonG/iB7g/7yXepJBDrN1M76FzgFoFU0ttdlRIoXs879wW38n/an5BGz/9sdZ4bcfHmS8ITnlHvj/Y6qh2QRn+BpGqHgrbt/y9o0Y3dUaE7mLbS9cn3B8pjsxYcAJoXQ/F/2KovLUGkEALeSdmoqPWyIUORlu1KCju6hUdGcY5BgC3Zmj4GayKDWXyQ/EJtIqtrw/iRxC4gZqyME8NNneKi1jv01zoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T91D4WOmNM/0cIga8paSNvjqW56ERZpNAToqoSkvmk8=;
 b=VLA5hZpON/XkMQu1X5q6Cf8p7Jnmd4nBbguUsrtzEJNK9i5mCEshm8Qla/Ez9V3an4Tm4Ssbzq773tp8TsUGVv2yKR1SYM7/YbzBYYjwTMBCi0xzjaJ7NEIW1N7iubIFsbE1eLUayp4/KZP4956boVYFCmWirgMQwWr3JMI1bt8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 09:38:41 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28%7]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 09:38:41 +0000
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
Subject: [PATCH] drm/bridge: nwl-dsi: Get MIPI DSI controller and PHY ready in ->mode_set()
Date:   Fri, 16 Apr 2021 17:23:25 +0800
Message-Id: <1618565005-1184-1-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 09:38:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a08e0a-31de-4c4e-aed0-08d900bb6b82
X-MS-TrafficTypeDiagnostic: VI1PR04MB7118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB71183FE0A40D16FDD6B97A62984C9@VI1PR04MB7118.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elaMFNrF4DEYZopVluRuNDA+Wxkjmta8OFPUFP6iJLnUkLiJP98cchahoEgAw6hC1hwX7uY2xs8119XOetYKjc0vIoNtmp1YZJmLwuzCbmqjYwafcITw5OriHfOv4GNoI1lQq4GfZUMOOIjvTt5jtiHeta1NcSghfdgpN+Cc313Xzik3UwNXsONFOsos2rFN+5WTqdWu8/05kzbu/3LKbpe727F6o/P0PgE/HIgLdwZUXHFhpP4y+JV97wInoWBXmGZtfLKMcE84caU24t+RnTan2I0LDFfIMgQo+OgI0x515PjiQc4fhfg6nBGNpQreBjsuXyguCZgMc/ihAKEJo+mGasKfOBVAPFT1PEMK39hSQqouPUKo8yv8p2DnVsYPI1oDcPvwsdiGlBmpA0Qh816Ge0CS3W3Utyg6UkmpBrP4vtrPyApind961WxL5WYV7b6KVyNSPx0cT+Be230IjUv1IiUJ8ckMibJoJuexn6ylaZZ4k1aJ995rE3eT45hLV+mMfKbUIwpr30KmoJMldX1A//M4HgtiBpJxKKLAtPF+l/STyx0uMVqH6R6eb6dDRgNCW7FFMUatAJCvvbR9mUTRnbnSuqT30uOvKLGyprtAbxb47tUs1nTnij7NBCKJPfWPIsXeWCy9+91lRUIVBqTRHGa38seKyyzk5hFfsQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(6486002)(38100700002)(5660300002)(7416002)(6666004)(16526019)(54906003)(316002)(38350700002)(86362001)(186003)(6506007)(26005)(66476007)(6916009)(4326008)(6512007)(66556008)(66946007)(36756003)(8676002)(52116002)(956004)(2616005)(8936002)(83380400001)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aDc1aUhRUTBGR0I0dWRFbDN5SDd1WHU5UGE0dTZHdkNpMjJjVkJRZ2lpZjRv?=
 =?utf-8?B?N25qeWcxK0h2ZjdVSENGUHc2WHpjcGFsQm9yd0t1cHlxKzlnMyt2ak9RNElM?=
 =?utf-8?B?clh1M25uWEo0aVV3emQyN24vL012TnIrWkVtSlJCYkZIVXFxbzIrbVNpeFhI?=
 =?utf-8?B?YS9JU0lXZStrQ0RGZDVtZjE0alR1dk9ZYXlsYmpqNE11ZFd6MWdud1RLVlVC?=
 =?utf-8?B?NE5tK2JINy9INFVjYk03VCtLSGxxUDloWlNuZXRYWW9JMVJscjl6bHJUenJy?=
 =?utf-8?B?dDI3by9pSDNtM3dZbnFtKzhia083REJyNzRza3h5SnZCeWtTdG1MMmU4Sk11?=
 =?utf-8?B?NzVTWERBdWxROXpuUUhuOGluSC80Y2RZUStGYkFhTWdxbzY1UXdHSVdiZ3RC?=
 =?utf-8?B?SWtnZ2JkRURSbmQwTFdmeUJ0cytIcEZVMXE1UWRKcHRLWkhsUnJOU1FNeXVh?=
 =?utf-8?B?enprODBLeWZsTU4zenBIa215OGovay8welNCOTlMNDRZODFOUkUwakF1aDdH?=
 =?utf-8?B?MWFSVXpaWU5lWnZMV3dMa3p1MHBRM1I4Y2duUEpsNFFtSnh1U2ZtS1FHK1pq?=
 =?utf-8?B?U1Z1cW9Mc1F2VXFadWtxNHdYOVNPV1QvVWhlUmYyTnIxYUpIcTB0MnNYWTBn?=
 =?utf-8?B?M1d3QTB3eUw5QWg5djlZMWlBV2VKQ25CNmFrMVdhWG1adzJpVjV3TUFrczVl?=
 =?utf-8?B?K1BmWDB2UkFnWjlQYmlFbk5WZXU1c0VvQ3o3d1YxdENrNGNSVkNuRjIwZ3dr?=
 =?utf-8?B?aHMvdWJxekZiYmF0S0ZrcHB6MTVxQlFQWlllcWVRNXFJeG5EVlFaOEh2RWRY?=
 =?utf-8?B?Zmo5OUtBVVpmbGwvV2o0Wmp5ZTc5V1NmV2ljRnZmbksxLzBIZ2h1RUtrMmcw?=
 =?utf-8?B?bUpUVlFxN0NVZmlmU1hSZHF1eXpZeFE5NHNGL1hheHIvVkdXNTQvNXljaDBD?=
 =?utf-8?B?UmVPUUxvRHVvcW5MT29WQ082SUJWUVBBdFpKQXVvbHhEaDNUT2xEUEl6V2ps?=
 =?utf-8?B?UCtyckY5MDVqSjNYMVdVc3pGSkJqS2p3REp4Tmd6bURWOTBLZW1QenpsT1lj?=
 =?utf-8?B?R1VKay9aalM1YnNJMm5HUzFGVVZURVhLNlpwbDVFMWhoSzV3TXcxMlB1djlk?=
 =?utf-8?B?SmhQSkEveEN2TzhDUitNakZWb2UzL0xGRUE0RWFWd2RTTVdEdUFUVG1TYm9U?=
 =?utf-8?B?UFBJYVhXRjVvT1A3OXAzcW1pQjduN1lJVi8weXBFN1R3MnRTRlBaTVJsdzVt?=
 =?utf-8?B?TDlHdFJBd2xYVWNQdFlmeXVvQlpzd2p3Y3lILzI0c0xIZWpjREtJRWRLeENq?=
 =?utf-8?B?akx3VTF2WllaVVVyUER1aE5nMUc5VjE4YkJxWFhmSUROQkhydkU2cUVSRWNK?=
 =?utf-8?B?cEFqQzF6RVBsQWMyd09qbyt0eU40Tlg1V253SklJUWxESDdMMFJxdWNINWF1?=
 =?utf-8?B?OGhwOVMxc2szMjY4aVJDOEFTYmk5b2xBc3RNVFY3eGwxMHFoc2dlbVk2SlFZ?=
 =?utf-8?B?U0tVczZTUDUycjd0bnpoUTBSM1BFazVPZ1FMazNvMm1WVGNwVWxBcTA3S1U4?=
 =?utf-8?B?Y3doaFZXRUE4TDJRdTRXV1RRNTZIM25TRkNTN2VZK0VFTSs4M2F6c0MreEhr?=
 =?utf-8?B?ZDVRcXk3UFNjVGJuS0NTT2FqNnZWTzRwb0xXYmMwMkk5ejV6THk5SU1USEJS?=
 =?utf-8?B?M1N1LzhTNTl5UTdsYlJ2WXJXVGpjZXkyYVRGZmU4eTE2amxLelV2VWtCUnNj?=
 =?utf-8?Q?AwE7wxo3TYregMcYWXd11kigUflKpsls2nOTLjZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a08e0a-31de-4c4e-aed0-08d900bb6b82
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 09:38:41.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U1utliucY1HFAy1lnMpQnyIDjQ5qtzq4Aak7fGIASj2q8ovNRPM8jYRalGaVzqCiF0juDi/zuX/IGgHgFKISA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
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
are called in pairs, which includes removing a check on unchange HS
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
 drivers/gpu/drm/bridge/nwl-dsi.c | 86 +++++++++++++++++---------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 66b67402f1ac..873995f0a741 100644
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
@@ -742,7 +743,9 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
 	return 0;
 }
 
-static void nwl_dsi_bridge_disable(struct drm_bridge *bridge)
+static void
+nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
+			      struct drm_bridge_state *old_bridge_state)
 {
 	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 	int ret;
@@ -803,17 +806,6 @@ static int nwl_dsi_get_dphy_params(struct nwl_dsi *dsi,
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
@@ -831,6 +823,29 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
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
@@ -846,13 +861,6 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
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
@@ -860,14 +868,8 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 
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
@@ -877,27 +879,29 @@ static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
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
@@ -942,14 +946,16 @@ static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
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
2.25.1

