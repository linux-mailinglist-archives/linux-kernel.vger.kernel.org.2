Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E88A3D377C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhGWIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhGWIfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D50BC60ED4;
        Fri, 23 Jul 2021 09:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627031739;
        bh=SE6snYvEeeZ9b06fLIc5TbNhAAvsQE2VfQEDDanskLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ahof7/VWmPmw0D21oaa1MW95ypJ8UCeqvOHW0gxCOovI1GP4WDQob2SBP6z6mG5kM
         rdkvSamfwj66jEMJkDqwBeIhZ650s1C2OzzobetoM2lIqESrHUshs/SfneFj1zoFcI
         QfhI6pP8cT4as2G8hKYqUcmCyj+/HzjzfUpZzRkiQqDh6JwEL9YFRXHOSy3sL9PNq4
         fOkHTpqtF7RxRupdpMFNpgGck7vrfreFZIlP3dg22xQnZru3tT0q0FySu6P+SJnPAh
         WN3506dobl/mPLCtlxUSq/yHH9Ulb8oLe3H+71W6DJSqy9gCbW2fv3UMuAW3TGnKKH
         HZXUqs24iWNdQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/kms/nv50-: fix build failure with CONFIG_BACKLIGHT=n
Date:   Fri, 23 Jul 2021 11:15:27 +0200
Message-Id: <20210723091534.1730564-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When the backlight support is disabled, the driver fails to build:

drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_sor_atomic_disable':
drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:59: error: 'struct nouveau_connector' has no member named 'backlight'
 1665 |         struct nouveau_backlight *backlight = nv_connector->backlight;
      |                                                           ^~
drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:35: error: invalid use of undefined type 'struct nouveau_backlight'
 1670 |         if (backlight && backlight->uses_dpcd) {
      |                                   ^~
drivers/gpu/drm/nouveau/dispnv50/disp.c:1671:64: error: invalid use of undefined type 'struct nouveau_backlight'
 1671 |                 ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
      |                                                                ^~

The patch that introduced the problem already contains some #ifdef
checks, so just add another one that makes it build again.

Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 093e1f7163b3..fcf53e24db21 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1659,20 +1659,23 @@ static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
-	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
 	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
-	struct nouveau_backlight *backlight = nv_connector->backlight;
 	struct drm_dp_aux *aux = &nv_connector->aux;
-	int ret;
 	u8 pwr;
 
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
+	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
+	struct nouveau_backlight *backlight = nv_connector->backlight;
+
 	if (backlight && backlight->uses_dpcd) {
-		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
+		int ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
+
 		if (ret < 0)
 			NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
 				 nv_connector->base.base.id, nv_connector->base.name, ret);
 	}
+#endif
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
 		int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
-- 
2.29.2

