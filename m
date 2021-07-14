Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68B3C8988
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhGNRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhGNRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:18:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5649C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kX9hKK1zO72+yBWFhZs3db5NllcwOVI8dLCu+ad+9IA=; b=h1H8yRGFNMYtQhBRHcFnIOv3sR
        zEehWviMROtRkkzl8inD4QviXRaSWhD1fstkFSrsLAsJgIJl8mnPR1y8D7PGX0BbyJARINlRFh1sO
        SA9dehEkYEZKmEkgs8eyJP+DM6XxfDj9nXCFeHPJ9WjgVncE1obqWnmfEFyfr5thqSYuJf6eD2Pxj
        yp9Z+hIJcaZao6RfvYpbkHHKpRt6uu4t+MEZrjIW+V4Q2+qz8eNO7a6POsxPCH1p+pg/tolpF/Omw
        IAU5ReM0eMuoCJZD/zOYZnyaoWJ0PTiSXLuk0sCTRtwpzF2LD7DHvl2SN2eaIchw/uK9JRlFjzUU0
        1iC2ckdA==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3iTk-00EGmG-8I; Wed, 14 Jul 2021 17:15:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Lyude Paul <lyude@redhat.com>
Subject: [PATCH -next] drm: nouveau: fix disp.c build when NOUVEAU_BACKLIGHT is not enabled
Date:   Wed, 14 Jul 2021 10:15:23 -0700
Message-Id: <20210714171523.413-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors and warnings when
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set

../drivers/gpu/drm/nouveau/dispnv50/disp.c: In function ‘nv50_sor_atomic_disable’:
../drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:52: error: ‘struct nouveau_connector’ has no member named ‘backlight’
  struct nouveau_backlight *backlight = nv_connector->backlight;
                                                    ^~
../drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:28: error: dereferencing pointer to incomplete type ‘struct nouveau_backlight’
  if (backlight && backlight->uses_dpcd) {

and then fix subsequent build warnings after the above are fixed:

../drivers/gpu/drm/nouveau/dispnv50/disp.c: In function ‘nv50_sor_atomic_disable’:
../drivers/gpu/drm/nouveau/dispnv50/disp.c:1669:6: warning: unused variable ‘ret’ [-Wunused-variable]
  int ret;
      ^~~
../drivers/gpu/drm/nouveau/dispnv50/disp.c:1662:22: warning: unused variable ‘drm’ [-Wunused-variable]
  struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
                      ^~~

Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-next-20210714.orig/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ linux-next-20210714/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1659,23 +1659,27 @@ static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
-	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
 	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
+	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nouveau_backlight *backlight = nv_connector->backlight;
+#endif
 	struct drm_dp_aux *aux = &nv_connector->aux;
 	int ret;
 	u8 pwr;
 
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	if (backlight && backlight->uses_dpcd) {
 		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
 		if (ret < 0)
 			NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
 				 nv_connector->base.base.id, nv_connector->base.name, ret);
 	}
+#endif
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
-		int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
+		ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
 
 		if (ret == 0) {
 			pwr &= ~DP_SET_POWER_MASK;
