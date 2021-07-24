Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A713D49DA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhGXTrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 15:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhGXTrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627158469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q/1snXio7orhyt4GADMoDog5tLPSL6yylMx5qgvWHcw=;
        b=hUgOaQ71ii+La14vPbtXjdw2aSBVDQ8chq11VIzs6xZnlzD708QoKMxHUU9DQ0w348QuM1
        hafWZp0EBBt+4IHjMg6pgxfO6T/Xi2STYaiiD/Z/F2X2XhajGF9c9vwUglIFuKND3/pyf8
        l+OKFZVATxqGKyWjnqsl/TeeBNL++hE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-2TeN5s8tPiq_sHoSA18u0g-1; Sat, 24 Jul 2021 16:27:47 -0400
X-MC-Unique: 2TeN5s8tPiq_sHoSA18u0g-1
Received: by mail-qv1-f72.google.com with SMTP id t18-20020a0cd4120000b02902fbda5d4988so4575838qvh.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/1snXio7orhyt4GADMoDog5tLPSL6yylMx5qgvWHcw=;
        b=VbtmLX0hTIOPlXDqn/A+Y5/cKDwuqIvXvbvc+SBbc0e3rSWjsHv0Mc6O67djuGxD3Y
         iIKCIhIfYN8WFmxMbkxUGZ8XnPvXkBU13+Osrzwx3HqY2GY2VgZzJKjLagtqIC8koG9V
         ra3t1kTaXVbkHMi/PdUvDdF2YhplLiInCwdFBvyZUixQ5GS9UfUWQ0dk7cMWpaXwrTyb
         X1sVE+0LwLR4Va6L31QAgrq/YPCd1prlymMorqV4wgcN+AF7tfXWvLGXLvG8rin8Fi1T
         d9U9YlP8tAw9JPLKDhJ0DzO5R2k8unrMOhXG3VE8hSOkAB30u88s4Ar3tiQ5rkZfKXXr
         aJvQ==
X-Gm-Message-State: AOAM531cG0ZHN8RIootPw6/tqfu3JK24rXykQqApTB40wqboDATxMYWy
        ZrHJQ6N7NFSb2Bj6CMmRHdOnMuCEAp8mxK8i7pd3fST2W353yJ3+4IF2I4w24bNO2FRcaSpNCxv
        0UF2GB3aJIAe5lbjAZYUnITlk
X-Received: by 2002:a37:f50d:: with SMTP id l13mr10711203qkk.298.1627158467380;
        Sat, 24 Jul 2021 13:27:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi6hIhq+NVUhVPqnbgHKJ7z9VSQvET+rT1MdV2KhuXvUks5lvzfgQYu10UOdSyzb83grMAEQ==
X-Received: by 2002:a37:f50d:: with SMTP id l13mr10711196qkk.298.1627158467186;
        Sat, 24 Jul 2021 13:27:47 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h68sm16650148qkf.126.2021.07.24.13.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 13:27:46 -0700 (PDT)
From:   trix@redhat.com
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        lyude@redhat.com, nikola.cornij@amd.com,
        ville.syrjala@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/kms/nv50-: use DRM_NOUVEAU_BACKLIGHT consistently
Date:   Sat, 24 Jul 2021 13:27:31 -0700
Message-Id: <20210724202731.3949331-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A build error when DRM_NOUVEAU_BACKLIGHT is not defined
disp.c:1665:52: error: 'struct nouveau_connector' has no
  member named 'backlight'

Use ifdef's similar to elsewhere in disp.c to conditionally
use the new backlight support.

Move scope of drm to where it is used, inside the backlight error
reporting.

Remove shadow ret decl.

Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 093e1f7163b31..6e957041edfb5 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1659,23 +1659,28 @@ static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
-	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
 	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_backlight *backlight = nv_connector->backlight;
+#endif
 	struct drm_dp_aux *aux = &nv_connector->aux;
 	int ret;
 	u8 pwr;
 
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	if (backlight && backlight->uses_dpcd) {
 		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
-		if (ret < 0)
+		if (ret < 0) {
+			struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 			NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
 				 nv_connector->base.base.id, nv_connector->base.name, ret);
+		}
 	}
+#endif
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
-		int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
+		ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
 
 		if (ret == 0) {
 			pwr &= ~DP_SET_POWER_MASK;
-- 
2.26.3

