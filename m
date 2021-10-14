Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2648342DE1E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhJNP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhJNP2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:28:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E9C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:26:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r18so20734948wrg.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZnfkK09uhjWqw+DNrCRghBv6QinaoLIxZDB7Hb28mg=;
        b=g/NzPc/NwJzQRwO5rPKji2Pmc828XRZBZEsPwsoOqiu6MoG2kscJum00aWzjkVRsp/
         Cs+R8hor6ve44wZpLrlW7ah6vBISlyJ1/WrUlSm99Sx5vj8j1i1wPS8xQp3R2G1aeeJ8
         6N8C/pLnVuk1XzRvQ7qozezFv0xJSGq5QVlp5Qgl/vJrs3lWJHtqSd6O4R4Oi8NwwKEn
         VvGQXYZVsWR8P0duXOrP32M+OZ4xOUEDA3phU5fRIvGj9SIOa78wFAtOkUyf5mYcBuYe
         uMMKAP63GFXzk/Sznq8rb/m8rT1pBZAhi4vvhmj4GCEiyDmHwbOvUwudiPKmVhNV0VvS
         CyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZnfkK09uhjWqw+DNrCRghBv6QinaoLIxZDB7Hb28mg=;
        b=Q3M/Znk/nluQAF7mermvoEnURMSua21jBpso7O7bnsfsNjdLUAO8KJ1pddhO9eSN3Z
         YM6tbgNtoV9wa/fuXJ9y6CznCyq2MoyK1JSGJcDJaH11jgI9Ovl1e2lVEvc5K2LeEDiQ
         9uqBa0EqLi1iACMMDxVHhrpvQJAkV88ajMIsnt1I7MH8h21asgT9k70vD+KSqrRVpcB8
         +nNZTISPqsQq6HRKWcqyxjhBNZ2hxA3SgLGIPAYe+1sWZWg9TG/ooHt5lDly1SruXfSV
         0W4iE4/7Kw6cw2z3tPjcFMU6Z/ENKkMTmwJvWL+a/Vmk+PNbb+ywnrBkXEej7ELkR/ho
         +CRg==
X-Gm-Message-State: AOAM533wWhR5KlxK5BTG057UREUHq0If10XuDuzOhxrawJA61BmY3nA6
        yZ1FhMvT7Mldr9ue5uyvHQxZMg==
X-Google-Smtp-Source: ABdhPJwZoNXIidqiqnHVpBnZZse41KQMw/qtXG047QyO3Dpq8ifkksnDqJ6h9ZZpO8qMpyBKKAn6Cg==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr7668686wrt.334.1634225178294;
        Thu, 14 Oct 2021 08:26:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:209b:8400:2b80:b4ae])
        by smtp.gmail.com with ESMTPSA id k22sm2626790wrd.59.2021.10.14.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:26:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 6/7] drm/meson: rename venc_cvbs to encoder_cvbs
Date:   Thu, 14 Oct 2021 17:26:05 +0200
Message-Id: <20211014152606.2289528-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014152606.2289528-1-narmstrong@baylibre.com>
References: <20211014152606.2289528-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9494; h=from:subject; bh=FeZfVcXcgSpdb977WidjFbWDVjcPsPKUucXlcKGhFP8=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhaEuAtMhFpVoXXFxFzbYa68362S5l7Ul/yhos8IZ/ JjuXh2+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYWhLgAAKCRB33NvayMhJ0SczD/ 9kTN2vOPqWl7g7i+JwGJl4oXTY4K/yqepY7qk8pqPKfOY4IL3Ps5ECNZXD1fwCcVRahXmmrxAICu5s 60Fugj67QfV6t9tFiCBZapS22olvStUVEwkxnHlb13HB31sEl8TImq41fs1wqogERw+HTLvzJ5sgpX gJnu4xFHo9nbg5H9F80+WCLReX8EBSYf5YZr9yscrXVl93bEBA/F58O+XUGcAE0wRPQciyvHqq37Kw l3SrjQfMhtA1xp0RDysTB0V0YWsz2giO7V6yXh2rfUXAdTFF4GueHeVCKSGc3YpcF1Y8lL93b8jXsq LAV3CQdi36du9EkBEMDL4uiUY2d5+DsDy5V4AE5B0tINU6MgkijwA9ziHJfnw4UBbz0A0/Wy6Fta4i 9yA49epe+8XQSGiA5p4qxmL+MJkWHxphuS9pW6F8oP0L9IDepRIiVUHexf+1EXHLTx6VmjAqmJ2Ym4 Brxo7wdepC4g1dkYtBZi3VKBjPsmIAzd2zyh78BpmeCcLxU6Xo3Jshw4hjI6QHUPW+gAtDOzqzN7TD GQiS+RdxT/H2ZaA/GJivo8RyO0jw0L5A3nWTtuF2u7MHOMmkemZD52vnKCPzarnLRxInZwXcCtZE6R YkHN6YcH4m0+eyk3x9XBNDK821pW+uk1dQJiylq6OwGoGi0XnFdews/PmLmQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the cvbs encoder to match the newly introduced meson_encoder_hdmi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/Makefile                |  2 +-
 drivers/gpu/drm/meson/meson_drv.c             |  4 +-
 ...meson_venc_cvbs.c => meson_encoder_cvbs.c} | 78 +++++++++----------
 ...meson_venc_cvbs.h => meson_encoder_cvbs.h} |  2 +-
 4 files changed, 43 insertions(+), 43 deletions(-)
 rename drivers/gpu/drm/meson/{meson_venc_cvbs.c => meson_encoder_cvbs.c} (74%)
 rename drivers/gpu/drm/meson/{meson_venc_cvbs.h => meson_encoder_cvbs.h} (92%)

diff --git a/drivers/gpu/drm/meson/Makefile b/drivers/gpu/drm/meson/Makefile
index 523fce45f16b..3afa31bdc950 100644
--- a/drivers/gpu/drm/meson/Makefile
+++ b/drivers/gpu/drm/meson/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-meson-drm-y := meson_drv.o meson_plane.o meson_crtc.o meson_venc_cvbs.o
+meson-drm-y := meson_drv.o meson_plane.o meson_crtc.o meson_encoder_cvbs.o
 meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o meson_overlay.o
 meson-drm-y += meson_rdma.o meson_osd_afbcd.o
 meson-drm-y += meson_encoder_hdmi.o
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 0a28a8e29d63..d07d302ce4a6 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -31,7 +31,7 @@
 #include "meson_plane.h"
 #include "meson_osd_afbcd.h"
 #include "meson_registers.h"
-#include "meson_venc_cvbs.h"
+#include "meson_encoder_cvbs.h"
 #include "meson_encoder_hdmi.h"
 #include "meson_viu.h"
 #include "meson_vpp.h"
@@ -308,7 +308,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 
 	/* Encoder Initialization */
 
-	ret = meson_venc_cvbs_create(priv);
+	ret = meson_encoder_cvbs_init(priv);
 	if (ret)
 		goto free_drm;
 
diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
similarity index 74%
rename from drivers/gpu/drm/meson/meson_venc_cvbs.c
rename to drivers/gpu/drm/meson/meson_encoder_cvbs.c
index f1747fde1fe0..01024c5f610c 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
@@ -20,7 +20,7 @@
 
 #include "meson_registers.h"
 #include "meson_vclk.h"
-#include "meson_venc_cvbs.h"
+#include "meson_encoder_cvbs.h"
 
 /* HHI VDAC Registers */
 #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
@@ -28,16 +28,16 @@
 #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
 #define HHI_VDAC_CNTL1_G12A	0x2F0 /* 0xbe offset in data sheet */
 
-struct meson_venc_cvbs {
+struct meson_encoder_cvbs {
 	struct drm_encoder	encoder;
 	struct drm_connector	connector;
 	struct meson_drm	*priv;
 };
-#define encoder_to_meson_venc_cvbs(x) \
-	container_of(x, struct meson_venc_cvbs, encoder)
+#define encoder_to_meson_encoder_cvbs(x) \
+	container_of(x, struct meson_encoder_cvbs, encoder)
 
-#define connector_to_meson_venc_cvbs(x) \
-	container_of(x, struct meson_venc_cvbs, connector)
+#define connector_to_meson_encoder_cvbs(x) \
+	container_of(x, struct meson_encoder_cvbs, connector)
 
 /* Supported Modes */
 
@@ -140,16 +140,16 @@ struct drm_connector_helper_funcs meson_cvbs_connector_helper_funcs = {
 
 /* Encoder */
 
-static void meson_venc_cvbs_encoder_destroy(struct drm_encoder *encoder)
+static void meson_encoder_cvbs_encoder_destroy(struct drm_encoder *encoder)
 {
 	drm_encoder_cleanup(encoder);
 }
 
-static const struct drm_encoder_funcs meson_venc_cvbs_encoder_funcs = {
-	.destroy        = meson_venc_cvbs_encoder_destroy,
+static const struct drm_encoder_funcs meson_encoder_cvbs_encoder_funcs = {
+	.destroy        = meson_encoder_cvbs_encoder_destroy,
 };
 
-static int meson_venc_cvbs_encoder_atomic_check(struct drm_encoder *encoder,
+static int meson_encoder_cvbs_encoder_atomic_check(struct drm_encoder *encoder,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state)
 {
@@ -159,11 +159,11 @@ static int meson_venc_cvbs_encoder_atomic_check(struct drm_encoder *encoder,
 	return -EINVAL;
 }
 
-static void meson_venc_cvbs_encoder_disable(struct drm_encoder *encoder)
+static void meson_encoder_cvbs_encoder_disable(struct drm_encoder *encoder)
 {
-	struct meson_venc_cvbs *meson_venc_cvbs =
-					encoder_to_meson_venc_cvbs(encoder);
-	struct meson_drm *priv = meson_venc_cvbs->priv;
+	struct meson_encoder_cvbs *meson_encoder_cvbs =
+					encoder_to_meson_encoder_cvbs(encoder);
+	struct meson_drm *priv = meson_encoder_cvbs->priv;
 
 	/* Disable CVBS VDAC */
 	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
@@ -175,11 +175,11 @@ static void meson_venc_cvbs_encoder_disable(struct drm_encoder *encoder)
 	}
 }
 
-static void meson_venc_cvbs_encoder_enable(struct drm_encoder *encoder)
+static void meson_encoder_cvbs_encoder_enable(struct drm_encoder *encoder)
 {
-	struct meson_venc_cvbs *meson_venc_cvbs =
-					encoder_to_meson_venc_cvbs(encoder);
-	struct meson_drm *priv = meson_venc_cvbs->priv;
+	struct meson_encoder_cvbs *meson_encoder_cvbs =
+					encoder_to_meson_encoder_cvbs(encoder);
+	struct meson_drm *priv = meson_encoder_cvbs->priv;
 
 	/* VDAC0 source is not from ATV */
 	writel_bits_relaxed(VENC_VDAC_SEL_ATV_DMD, 0,
@@ -198,14 +198,14 @@ static void meson_venc_cvbs_encoder_enable(struct drm_encoder *encoder)
 	}
 }
 
-static void meson_venc_cvbs_encoder_mode_set(struct drm_encoder *encoder,
+static void meson_encoder_cvbs_encoder_mode_set(struct drm_encoder *encoder,
 				   struct drm_display_mode *mode,
 				   struct drm_display_mode *adjusted_mode)
 {
 	const struct meson_cvbs_mode *meson_mode = meson_cvbs_get_mode(mode);
-	struct meson_venc_cvbs *meson_venc_cvbs =
-					encoder_to_meson_venc_cvbs(encoder);
-	struct meson_drm *priv = meson_venc_cvbs->priv;
+	struct meson_encoder_cvbs *meson_encoder_cvbs =
+					encoder_to_meson_encoder_cvbs(encoder);
+	struct meson_drm *priv = meson_encoder_cvbs->priv;
 
 	if (meson_mode) {
 		meson_venci_cvbs_mode_set(priv, meson_mode->enci);
@@ -219,14 +219,14 @@ static void meson_venc_cvbs_encoder_mode_set(struct drm_encoder *encoder,
 }
 
 static const struct drm_encoder_helper_funcs
-				meson_venc_cvbs_encoder_helper_funcs = {
-	.atomic_check	= meson_venc_cvbs_encoder_atomic_check,
-	.disable	= meson_venc_cvbs_encoder_disable,
-	.enable		= meson_venc_cvbs_encoder_enable,
-	.mode_set	= meson_venc_cvbs_encoder_mode_set,
+				meson_encoder_cvbs_encoder_helper_funcs = {
+	.atomic_check	= meson_encoder_cvbs_encoder_atomic_check,
+	.disable	= meson_encoder_cvbs_encoder_disable,
+	.enable		= meson_encoder_cvbs_encoder_enable,
+	.mode_set	= meson_encoder_cvbs_encoder_mode_set,
 };
 
-static bool meson_venc_cvbs_connector_is_available(struct meson_drm *priv)
+static bool meson_encoder_cvbs_connector_is_available(struct meson_drm *priv)
 {
 	struct device_node *remote;
 
@@ -238,27 +238,27 @@ static bool meson_venc_cvbs_connector_is_available(struct meson_drm *priv)
 	return true;
 }
 
-int meson_venc_cvbs_create(struct meson_drm *priv)
+int meson_encoder_cvbs_init(struct meson_drm *priv)
 {
 	struct drm_device *drm = priv->drm;
-	struct meson_venc_cvbs *meson_venc_cvbs;
+	struct meson_encoder_cvbs *meson_encoder_cvbs;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	int ret;
 
-	if (!meson_venc_cvbs_connector_is_available(priv)) {
+	if (!meson_encoder_cvbs_connector_is_available(priv)) {
 		dev_info(drm->dev, "CVBS Output connector not available\n");
 		return 0;
 	}
 
-	meson_venc_cvbs = devm_kzalloc(priv->dev, sizeof(*meson_venc_cvbs),
+	meson_encoder_cvbs = devm_kzalloc(priv->dev, sizeof(*meson_encoder_cvbs),
 				       GFP_KERNEL);
-	if (!meson_venc_cvbs)
+	if (!meson_encoder_cvbs)
 		return -ENOMEM;
 
-	meson_venc_cvbs->priv = priv;
-	encoder = &meson_venc_cvbs->encoder;
-	connector = &meson_venc_cvbs->connector;
+	meson_encoder_cvbs->priv = priv;
+	encoder = &meson_encoder_cvbs->encoder;
+	connector = &meson_encoder_cvbs->connector;
 
 	/* Connector */
 
@@ -276,10 +276,10 @@ int meson_venc_cvbs_create(struct meson_drm *priv)
 
 	/* Encoder */
 
-	drm_encoder_helper_add(encoder, &meson_venc_cvbs_encoder_helper_funcs);
+	drm_encoder_helper_add(encoder, &meson_encoder_cvbs_encoder_helper_funcs);
 
-	ret = drm_encoder_init(drm, encoder, &meson_venc_cvbs_encoder_funcs,
-			       DRM_MODE_ENCODER_TVDAC, "meson_venc_cvbs");
+	ret = drm_encoder_init(drm, encoder, &meson_encoder_cvbs_encoder_funcs,
+			       DRM_MODE_ENCODER_TVDAC, "meson_encoder_cvbs");
 	if (ret) {
 		dev_err(priv->dev, "Failed to init CVBS encoder\n");
 		return ret;
diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.h b/drivers/gpu/drm/meson/meson_encoder_cvbs.h
similarity index 92%
rename from drivers/gpu/drm/meson/meson_venc_cvbs.h
rename to drivers/gpu/drm/meson/meson_encoder_cvbs.h
index ab7f76ba469c..61d9d183ce7f 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.h
+++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.h
@@ -24,6 +24,6 @@ struct meson_cvbs_mode {
 /* Modes supported by the CVBS output */
 extern struct meson_cvbs_mode meson_cvbs_modes[MESON_CVBS_MODES_COUNT];
 
-int meson_venc_cvbs_create(struct meson_drm *priv);
+int meson_encoder_cvbs_init(struct meson_drm *priv);
 
 #endif /* __MESON_VENC_CVBS_H */
-- 
2.25.1

