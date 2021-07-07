Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4A3BE4A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGGIu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:50:58 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:52411 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231225AbhGGIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:50:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 56B672B0093E;
        Wed,  7 Jul 2021 04:48:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Jul 2021 04:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=yOB63fJHzsg9Q
        ZNkKHIHmJfI18jn71wpRO/ommwdZ6w=; b=qy4ynOkj/TE0lvx/2xxIpijR8vUns
        dRJF5p2d2Dji2W6f01W2gnd0aFq/3/Hdikur8uh8Ubmmg0HngFpngVTT/urBoXjC
        60eaHccgIdj7YzuSVymWsbBG93rx10FsE1C2Bb4MAuOWTtejUiOTmHbg9G19XCtU
        cFDgv1mHOHOQwhtgLG+VDdTikO2JuKi5Oj/g41+wtaDudZzVe3P4PWjfDMQwJIpu
        uOz242hQXYq9bEsCWtQjZQYvD8sU1XDvE4eRXWu5XW4CtuLtiUisyj7NiQfWVaXH
        JrvWpATSTdHfKSSLm2fZHM9pDz3Lisw1lk/N3CHNGprm6QSBmFdEpMFqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=yOB63fJHzsg9QZNkKHIHmJfI18jn71wpRO/ommwdZ6w=; b=Yy49Pzlb
        qlVMxwnzx2CP0md6l0l1b0xKF1+N8gIeOPt1mpie8VpeNX2pIY4ywjnPp6pPNTyM
        SqaqysusWtZoC2lfPJ64kRkVJhLx0PvfxwMA7fin7KJre6r+QQQuRByp4IKsClNp
        86Z24x15vxRpQAEWxT13oh/lwt1BIzuLHb3bKMR/gRwHbWwBIUQ+xHsUiJJ4lhLA
        NkPWGKMP0f28tf6xQ1scij7YXGIZHqpbLbNMhaDtCvCcR9LnTgsB4Xadj3b4ti8a
        7sVPWqD/ChCFIImwJBfaYpOVkRzuzt2yBbE14XoGwEytXyPhlmFTXgQnUB5WvWzO
        ptj0ODmv49vhUw==
X-ME-Sender: <xms:SWrlYPpv_K8Eg_bsK8Vf2k2935r7p5jvWNjs0WbrKoI0-zbL_FUvlA>
    <xme:SWrlYJplhAmsR0BKFfOb9z5uNTjCYxUDT7pc4u8ZyBK8bLLRtlw3MDFl6uqi_LJRn
    R6hDLo4qjUOG-Qm7LY>
X-ME-Received: <xmr:SWrlYMP2_y19HUzSesnk-FGZ2oXBuF0Op4Gm9GDgmiDhIgJ-Npdg75mKlpNeVrsU33715pUI0yLEi4nTlNgaOIP8QXkllxUDNR3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddvgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SWrlYC6vVmhs05oPb0le1ARkxj3VRO9zIIcumx8Up3hNWQzsXNcxWQ>
    <xmx:SWrlYO6u9-yRtmht7tHjAV-U_ZPxA57k3QlYUGK5V8r5UYQu9yltLQ>
    <xmx:SWrlYKjr7ZSG3Jul2sAssGl8xslLeRljbFrHVdOB29DUHF4m-Qk3NQ>
    <xmx:SWrlYNTLbQY6I66D7OA9SnFz03zx9oGAui68qkjOI1vdm4i6iJvKqnY6fBQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jul 2021 04:48:09 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Emma Anholt <emma@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/10] drm/vc4: crtc: Rework the encoder retrieval code (again)
Date:   Wed,  7 Jul 2021 10:47:40 +0200
Message-Id: <20210707084745.1365390-6-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707084745.1365390-1-maxime@cerno.tech>
References: <20210707084745.1365390-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out the encoder retrieval code, in addition to being
unnecessarily complicated, has a bug when only the planes and crtcs are
affected by a given atomic commit.

Indeed, in such a case, either drm_atomic_get_old_connector_state or
drm_atomic_get_new_connector_state will return NULL and thus our encoder
retrieval code will not match on anything.

We can however simplify the code by using drm_for_each_encoder_mask, the
drm_crtc_state storing the encoders a given CRTC is connected to
directly and without relying on any other state.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 30 +++++++++---------------------
 drivers/gpu/drm/vc4/vc4_drv.h  |  4 +---
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 93d2413d0842..c88ce31ec90f 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -280,26 +280,14 @@ static u32 vc4_crtc_get_fifo_full_level_bits(struct vc4_crtc *vc4_crtc,
  * same CRTC.
  */
 struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
-					 struct drm_atomic_state *state,
-					 struct drm_connector_state *(*get_state)(struct drm_atomic_state *state,
-										  struct drm_connector *connector))
+					 struct drm_crtc_state *state)
 {
-	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
+	struct drm_encoder *encoder;
 
-	drm_connector_list_iter_begin(crtc->dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		struct drm_connector_state *conn_state = get_state(state, connector);
+	WARN_ON(hweight32(state->encoder_mask) > 1);
 
-		if (!conn_state)
-			continue;
-
-		if (conn_state->crtc == crtc) {
-			drm_connector_list_iter_end(&conn_iter);
-			return connector->encoder;
-		}
-	}
-	drm_connector_list_iter_end(&conn_iter);
+	drm_for_each_encoder_mask(encoder, crtc->dev, state->encoder_mask)
+		return encoder;
 
 	return NULL;
 }
@@ -533,8 +521,7 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
 									 crtc);
 	struct vc4_crtc_state *old_vc4_state = to_vc4_crtc_state(old_state);
-	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, state,
-							   drm_atomic_get_old_connector_state);
+	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, old_state);
 	struct drm_device *dev = crtc->dev;
 
 	require_hvs_enabled(dev);
@@ -561,10 +548,11 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 				   struct drm_atomic_state *state)
 {
+	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state,
+									 crtc);
 	struct drm_device *dev = crtc->dev;
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
-	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, state,
-							   drm_atomic_get_new_connector_state);
+	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, new_state);
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 
 	require_hvs_enabled(dev);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index d3e5238eadb5..52214a1568fe 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -516,9 +516,7 @@ vc4_crtc_to_vc4_pv_data(const struct vc4_crtc *crtc)
 }
 
 struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
-					 struct drm_atomic_state *state,
-					 struct drm_connector_state *(*get_state)(struct drm_atomic_state *state,
-										  struct drm_connector *connector));
+					 struct drm_crtc_state *state);
 
 struct vc4_crtc_state {
 	struct drm_crtc_state base;
-- 
2.31.1

