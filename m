Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664A7368F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbhDWJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:43:06 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:26049
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229811AbhDWJnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgwfYdWsdJtDBjHBDlbMkCrbYl8M68pUj54mRp03/2jrk+R/CG5sp+u7rzde7C0CVX3XGyR1tMeFdqy6CUtO3p1cpOf6h2/piPky+nCReuQ7jWhNX5jOQVueh4jZbFPTU0VAXvOzCh9mCd4QgB9adlmzZy0sorEk+dDlAC3Acowb+fpUEAaNTsA3/Do+tkkG3V06ZVkrTZTT7fwkWE9l7QWrqtfaQMKpkN90fTOQNHt7YKKkR6cD5prcpO4jelH+dnZF9bL9tFr10G7vDKd46aK7/voYIF/R7bWNNljd+qBmU+j96oE34cyjLWcA2CX9XC4D6E+PvgFBkqCGDn4VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdu3u3yeBunLeUPDtKnG3pTLe15EG3f1+C2OXax/s1Q=;
 b=fREwRF+h+tW+KIeCcZAoN9xwmRaSKFJVXN6baQa2+4nFIYom4JoTYoLpDweg5J8R+/uUZuHhqNFNQi5aR5142u1/DyPIy911MDaSCPkEH+i2+xV+Odl/okwvoLKtN+8Sof+crBQ+pMAQrNK8tRlD1ztkR/2BqWMf3HNpEZIqk9OEEs+0dpQNL3Hrgq9RZgKfezIeXxfPPYMARIOVR9grtYjSPOKYP9jkuGMoreSAngr+vjBheMxMrx2pgKN2bFm5qnPttXiZd0lV4/Xk0tjASrJy2xRP8oR5zwzgMEZ/78C+G2d746XHH+X/nlZp93iUTMEYseEwDwt2cF/cIaFo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdu3u3yeBunLeUPDtKnG3pTLe15EG3f1+C2OXax/s1Q=;
 b=aJYOwcnYPrTO8Sze4HSwh3idhDO8CAljNiVL4v2YXIm0kr3xbyLUtMAD0giQQ6tIOGkOL40VQQHGEIkTC3fQcQXhpFe59B9DLxQV7Looj4ix3XiRo99lfH9KnUdM4mwHlLDEHlmJp/aQTYWWVGAqOrD/Ckz4qY/CTTMKfp1Q9Io=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB5711.eurprd04.prod.outlook.com (2603:10a6:803:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 09:42:25 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28%7]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 09:42:25 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        agx@sigxcpu.org, robert.chiras@nxp.com, linux-imx@nxp.com
Subject: [PATCH v3 1/3] drm/bridge: nwl-dsi: Force a full modeset when crtc_state->active is changed to be true
Date:   Fri, 23 Apr 2021 17:26:41 +0800
Message-Id: <1619170003-4817-2-git-send-email-victor.liu@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0181.apcprd02.prod.outlook.com (2603:1096:201:21::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 09:42:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd2e2aef-12f1-46db-6448-08d9063c19b0
X-MS-TrafficTypeDiagnostic: VI1PR04MB5711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB571107F71BC677CBC9D3129A98459@VI1PR04MB5711.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VB2LFm2AXsyO8J+e9hkzBd/sGK91U4g/YAQLqdZ+N5r0/WM+a/c0S3HTj6kPzVLhDqcNjRm7XMIyVf1HTcDVFPe056kGJ5SCl8aVh8V7jVa8gbnY+NixQ9EKiWMp+Owdku63Oknu40NbZ22bYqIKWpbIVJn63iKF4c90CVqJjzK61C5AmTz9pehMS9KMDcVrN0Nu0xUuseq2zY+RsTif+NtMOxA/lHWTCsCxO0nSWBzVMm1s/naw/lHRvY17XQ++gJzeGU3WME9SEgaT9fCIpukXg3+5/Cn3hAmYZPWAbAsJrDbQIKSzRgggKUANhHTvGEzd7PWcjrboDaGs8B2yX7d7fJMs6LP6LcCOtbGsDIAp92lZQ4LXIqg3KJAY8c7jx9wjHTDuBQiIoHfqoSd0l0ngFGQG73YE4kvOBFSDTLEBDijc1ERZqnQx11puXyQKEk5cr/ZyiRnjVLJLFSeR9yvrug0/WYLL4a/jJfIX1WXWcirlehwKEwzn/PFX2510Vm7S2N9I88Il1nd2MoC9r6GXbCNysob4HM7l8NXmQROCAQXLWAGHUcuWatYnnlrr4G9FUTCziZew34+3gWtV+cH8wPMvmVlBKwB7B9Aw0VD+IyAXw8uf5Lpx94r2AWd/NbP4XoIIrj9ERh2YSbGDGnO0/keTuORds4C0vSKxkDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(38100700002)(4326008)(8936002)(316002)(83380400001)(6916009)(52116002)(86362001)(6506007)(36756003)(6512007)(186003)(38350700002)(16526019)(66476007)(8676002)(26005)(7416002)(66556008)(66946007)(6486002)(2906002)(956004)(5660300002)(478600001)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M04yd3hLTndtLzJPOVlIT245NFR6M2RsZUZFQ05YWFMvQVNaZ04zWWZIRE9x?=
 =?utf-8?B?SnVZOTZVMzV4aDdwUnFtVUdwN2xoRytJMEVvWnRBR094bjBuZkY3UDl2em1h?=
 =?utf-8?B?YVZvVStRMHhFZXFNNVl5bEpKNEZuODFpQ1kyeUZIU0I3aHErSnk4Zm1GRVVB?=
 =?utf-8?B?N2dKOEx2bkJPWVZ3UDRlUStmUWxoTVlITnB1bTkwZm0xVGVOVjBEOXlTM2Z5?=
 =?utf-8?B?cXJwNFc0eXJrNFF0R3ArQlhmeVI3ako0RWZBOHY1d3Y3Y1N5Zjkwc0VkZ2hE?=
 =?utf-8?B?WXMyS1laRUxCTXhqaXNSd0s3M0RtSHZYZTZ4MTVwcVNMNlF1MXdvcEE4RUNj?=
 =?utf-8?B?c0cwbUhlQnY5Zzdhdi9KMEpZRHphWW0zRkFMYUEvZkZKZWNNczZnakVRVHRZ?=
 =?utf-8?B?aGYyVnJ6TlMrTC9ZaXZKeWZKdTEycDZlSVQxc3lWVWxOR0llejFWUHhyaURN?=
 =?utf-8?B?TC8zdFZFbS9tVUJmQnhHUVk1Q1J2RG9ML2RwRVZCamdXd3pPL3JUSktsK2U5?=
 =?utf-8?B?cm9HNTVJaXJsenJkVHZlZWx3OXhSa0J4akJJTyswb1JTMENCbTZpb1dvMmVS?=
 =?utf-8?B?ZUp0UjEwVTUwdWlKd2g1S0ZMTTZVTEQwUzV2U3Vyc2xTSHFHejFsMmtEeUpR?=
 =?utf-8?B?eFJ2a0ZmbzV0Y0tWdXY4bFVYOHVsWDF3YmtmK2JYY0RjMEhqSEx2L3dDanF1?=
 =?utf-8?B?Z3lDYXZyU2VCTWphbVp3YWtwUmtrSnR1TjZMd1R1UHNsdEdQSnVOMHB2bWQ4?=
 =?utf-8?B?R3NWZktkZTliV1UwVS9yMW5lTnFYdDBRZ2lURFprQk1jL0gram1LZnZvZlRi?=
 =?utf-8?B?VTdWN3BuOUV5bCszUnhwc3Uxb0czOENhdHE0Ni9xWGU3VTFiR2ZtZkpnczk0?=
 =?utf-8?B?UGFkZDNDT2VINnFkUFFOK3dSNzlMYmhBL0VWRGdSQ0FRT0FlVFdBWDRBRUZS?=
 =?utf-8?B?VWpFRjdSU3pldmRwWjNNQW5LRjZvMUFacEdFZms0c09sT3N5T0hFL21hUWpy?=
 =?utf-8?B?a1FsTkIxNnEvbDVpOGV3eFM2L0w3TGdCZ0t4bHZyak9vUEFEeGRPTy9JU1BO?=
 =?utf-8?B?Mm5xQzV6cXFvdlJsUW5lWjZTQnhnTHhCLy9CUG5LbG91Tnh2MkN5K0dpLy9E?=
 =?utf-8?B?QzRQTGQ5SUgzcjFmRFp2eWF4Z1ZrNjdVSzRtaDYvU0VkSkFUeVh0ZENvZWNF?=
 =?utf-8?B?Q1F0VWorZXhxQUNwa254V2Z3elZrQTV3aFBOVm9ZKythSFRzZHg4a29zSzVC?=
 =?utf-8?B?c2EyNVVoczd5c25ua1FPcGY3bzlvdWN6SkdQWHk1RUNzeTB3NUlJSERMQUdM?=
 =?utf-8?B?V09uRndSTnZLOEt5UmI5Q2lmOU9xQmRqL2JXYlNJWDdOYXpkSHRZRVk5VzJs?=
 =?utf-8?B?Y3V5YjBnWFJLWU1pdGhncGxTL3kvL0Z2ZmdZV0s4czcyWHVyejZyakFwcXJR?=
 =?utf-8?B?ZVVwem5QTm5BTVEycko2R3JZUm5LTXdRN1JvL2VQdHUvY2Zha1g1c1JSaDNy?=
 =?utf-8?B?eGdkRVV6b3RZTlRHenpuT3YwRW1zd1grQzUyNUtqUlZRV0plaDVRSGlFT2Ny?=
 =?utf-8?B?TGNyQVpIU0hUQ2NoRms5WWRPam1Salk0d3NIbFFqUkcwVmlzSzVvM0xDN2ty?=
 =?utf-8?B?ZTRYTmJIR2xZMTNPUEVYbHh6c0lFaUc0U0dIR0tCZzlFL3hjWCt2R0RFOG91?=
 =?utf-8?B?M1p0V2txbldwdzdjcjIrK1dTYkltK29zVHAzV3dlMFFLaytzZkVvRk5OQVIy?=
 =?utf-8?Q?3/GyQAF4CjTcw8nnhcPskrciqdcY+j3UdpjiL4W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2e2aef-12f1-46db-6448-08d9063c19b0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 09:42:25.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUHd0BlroMRTJ/kTPXzHQ3T6TBEaOVtRSU++8FV/8bfCr7+U4b5lSRCVh2Q3uaBEo7Gpl3xFwFNYGXINZlcL6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces ->mode_fixup() with ->atomic_check() so that
a full modeset can be requested from there when crtc_state->active
is changed to be true(which implies only connector's DPMS is brought
out of "Off" status, though not necessarily).  Bridge functions are
added or changed to accommodate the ->atomic_check() callback.  That
full modeset is needed by the up-coming patch which gets MIPI DSI
controller and PHY ready in ->mode_set(), because it makes sure
->mode_set() and ->atomic_disable() are called in pairs.

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
* Split from the single patch in v2 to clarify changes. (Neil)

 drivers/gpu/drm/bridge/nwl-dsi.c | 61 ++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 66b67402f1acd..c65ca860712d2 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -21,6 +21,7 @@
 #include <linux/sys_soc.h>
 #include <linux/time64.h>
 
+#include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
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
@@ -831,6 +823,24 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
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
+	/* Do a full modeset if crtc_state->active is changed to be true. */
+	if (crtc_state->active_changed && crtc_state->active)
+		crtc_state->mode_changed = true;
+
+	return 0;
+}
+
 static void
 nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 			const struct drm_display_mode *mode,
@@ -862,7 +872,9 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 	drm_mode_debug_printmodeline(adjusted_mode);
 }
 
-static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
+static void
+nwl_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+				 struct drm_bridge_state *old_bridge_state)
 {
 	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 	int ret;
@@ -897,7 +909,9 @@ static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
 	}
 }
 
-static void nwl_dsi_bridge_enable(struct drm_bridge *bridge)
+static void
+nwl_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
+			     struct drm_bridge_state *old_bridge_state)
 {
 	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 	int ret;
@@ -942,14 +956,17 @@ static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
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
+	.atomic_pre_enable	= nwl_dsi_bridge_atomic_pre_enable,
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

