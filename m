Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0757E434B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhJTMmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhJTMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:42:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D86BC061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:39:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j129-20020a1c2387000000b00322f53b9bbfso1331737wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jiinvX9tI54x5SLHabqig93k3uxlHlswuN5uX6BjTl4=;
        b=k5UJoCfc3a/ChUJjErZfsDE8CKzm6N1fY3KZCcE+x9SM4PJtVoKiMTE8LxbCXuqEDu
         962iwEHAGITJdGE/dTJSDTc3qyJI4LUHb3I8VGKLt0YlO0/pDvIkL69Zx19tFLAaB8B7
         yG6hwqqSfqSkhlpKMOAfoQIibydJGoflr2P8R2RGgbXPXMemPP3coqYgm3CwQd2Rqine
         c4CCOUkkv0SXRiCS6w+PyIko8zdz7fab2FlGWUjVYk/U/NDLM/Z2wazFXVjlrPp7yQOi
         sINAbs5kzcx2hlnfNlCL8VitkpBjYONyV0eeJJoEQ/BOrCf2BwXfBIuX5wAVrlPJr4Cq
         Jstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jiinvX9tI54x5SLHabqig93k3uxlHlswuN5uX6BjTl4=;
        b=ByTk4xi+Ac20cdlCzubJNyh8LUu6JzTgLEUFJ3bfl4EABhEYTCenHyIgBV0ssgPFTk
         oBakM5moO1pUhjRoQGM+wzs1glvOCvA+0uHIeXxnRhDGk9hsnmAdQUqFLGC9KMm+DsCp
         XR1NsILFQdGRpTT3zEsaRcxG0FfRUW4rkeXTmzLy9iecx+f6FzPytQ5ZzVUbIPIOTNs6
         6SxI5HL4F8kXGnz9vifXUOCaEKnV4euTBnko12A9KWd/F0y2bstrxjZp1bprbh/1BGWT
         AlQlTxz0EcsW8Kvk0hjEzs6M616l5FCZMNcTjZyfJ3idcT6zvhL60Yc1YOCRp4xWEoWv
         /t5A==
X-Gm-Message-State: AOAM532AzfHaTckyQor+gBhfARQhbBzY8hzNNgyeo7buYuH5KNu+IrC/
        hRVvhHnDu3NDWlFnZD8/BWKAkw==
X-Google-Smtp-Source: ABdhPJyyKUKrwhSsBZgPAXOgJOxVvlmh9Bd+6kJ0Stkse4IyS+1nIdvnlzOUf6uPInyUF0hX5w67Pg==
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr13165308wmr.99.1634733594743;
        Wed, 20 Oct 2021 05:39:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d31f:1512:8915:e439])
        by smtp.gmail.com with ESMTPSA id b19sm5342680wmj.9.2021.10.20.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:39:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 4/6] drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date:   Wed, 20 Oct 2021 14:39:45 +0200
Message-Id: <20211020123947.2585572-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020123947.2585572-1-narmstrong@baylibre.com>
References: <20211020123947.2585572-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7653; h=from:subject; bh=JOkvQc81RnmaBjsJV0Kp9WcWJQhhemCUWGOjLkWHtaM=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhcA34U8iBkJMESB5V1Wa2HiE7z3yk0tVHj/l4NxES PySwWm+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYXAN+AAKCRB33NvayMhJ0ZnLD/ 44Z9N66wFWxCpak3SrBMgk3yzHp3oCU1WEPBErCGZjLVDdlv4WlrvXRZsY/6hYRuC0/8OpzhMTSDvG RwN03XrHCeYWsjx4dVDgvztkoJIG1v579U+j3i4OlvQVccWmg9RfYNgoxLWXoF405HzPmjOa2NLLmA 2ABEInBUiUkzaDJqXmbzqj7zbl3SSWOWUoaUGGFE65MajknYTfkT1PBgUjXBv+9FOCZsRCV5Q/ijb6 g2pyxcoyzdOCuBCnRAYkjLOnJNyMITQ0TeNE3yjB657N4afE6e4PwOMpNNzzkAaSnobtIc/vh8HOCa BKpJhoPogz7Dq6N0jMhP8OpzgITZPIHvdZoeMR7sKIoxF/fe/YOwzyaDdmC8QG8+D+kx/QU95a4CNG NCFjml+UBlcOu4G1qEMkWmT2onZT47EDF07xDPNwGjgRu9V2eGHskwmNouufSmF18NMClr/FVwWDby YOenVjFwTZXh8Qtn/m/UyuGsN/GrPGbkWjBQ8NaP56qRN31OCx7wP20LNf2SfspJMJEUHu1C8IYvV1 p+yQaz4YlKjarm+/nzlBff0uG4CzwBYpBe6gg4jNEWM2KjrUXIX1Rw6cThOSUHG19k1rLm+MKGyp7y r3KOtvjLx4yppsu2azYhgt2LmwZWhXeFQmqnc00JMShbGsfKr81UxkZxBDug==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the necessary change to no more use the embedded
connector in dw-hdmi and use the dedicated bridge connector driver
by passing DRM_BRIDGE_ATTACH_NO_CONNECTOR to the bridge attach call.

The necessary connector properties are added to handle the same
functionalities as the embedded dw-hdmi connector, i.e. the HDR
metadata, the CEC notifier & other flags.

The dw-hdmi output_port is set to 1 in order to look for a connector
next bridge in order to get DRM_BRIDGE_ATTACH_NO_CONNECTOR working.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/meson/Kconfig              |  2 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c      |  1 +
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 81 +++++++++++++++++++++-
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
index 9f9281dd49f8..a4e1ed96e5e8 100644
--- a/drivers/gpu/drm/meson/Kconfig
+++ b/drivers/gpu/drm/meson/Kconfig
@@ -6,9 +6,11 @@ config DRM_MESON
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
+	select DRM_DISPLAY_CONNECTOR
 	select VIDEOMODE_HELPERS
 	select REGMAP_MMIO
 	select MESON_CANVAS
+	select CEC_CORE if CEC_NOTIFIER
 
 config DRM_MESON_DW_HDMI
 	tristate "HDMI Synopsys Controller support for Amlogic Meson Display"
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index fb540a503efe..5cd2b2ebbbd3 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -803,6 +803,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
 	dw_plat_data->ycbcr_420_allowed = true;
 	dw_plat_data->disable_cec = true;
+	dw_plat_data->output_port = 1;
 
 	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
 	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 2e73e19d8887..156cb43735f7 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -14,8 +14,11 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#include <media/cec-notifier.h>
+
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_probe_helper.h>
@@ -33,8 +36,10 @@ struct meson_encoder_hdmi {
 	struct drm_encoder encoder;
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
+	struct drm_connector *connector;
 	struct meson_drm *priv;
 	unsigned long output_bus_fmt;
+	struct cec_notifier *cec_notifier;
 };
 
 #define bridge_to_meson_encoder_hdmi(x) \
@@ -49,6 +54,14 @@ static int meson_encoder_hdmi_attach(struct drm_bridge *bridge,
 				 &encoder_hdmi->bridge, flags);
 }
 
+static void meson_encoder_hdmi_detach(struct drm_bridge *bridge)
+{
+	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
+
+	cec_notifier_conn_unregister(encoder_hdmi->cec_notifier);
+	encoder_hdmi->cec_notifier = NULL;
+}
+
 static void meson_encoder_hdmi_set_vclk(struct meson_encoder_hdmi *encoder_hdmi,
 					const struct drm_display_mode *mode)
 {
@@ -297,9 +310,30 @@ static int meson_encoder_hdmi_atomic_check(struct drm_bridge *bridge,
 	return 0;
 }
 
+static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
+					  enum drm_connector_status status)
+{
+	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
+	struct edid *edid;
+
+	if (!encoder_hdmi->cec_notifier)
+		return;
+
+	if (status == connector_status_connected) {
+		edid = drm_bridge_get_edid(encoder_hdmi->next_bridge, encoder_hdmi->connector);
+		if (!edid)
+			return;
+
+		cec_notifier_set_phys_addr_from_edid(encoder_hdmi->cec_notifier, edid);
+	} else
+		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
+}
+
 static const struct drm_bridge_funcs meson_encoder_hdmi_bridge_funcs = {
 	.attach = meson_encoder_hdmi_attach,
+	.detach = meson_encoder_hdmi_detach,
 	.mode_valid = meson_encoder_hdmi_mode_valid,
+	.hpd_notify = meson_encoder_hdmi_hpd_notify,
 	.atomic_enable = meson_encoder_hdmi_atomic_enable,
 	.atomic_disable = meson_encoder_hdmi_atomic_disable,
 	.atomic_get_input_bus_fmts = meson_encoder_hdmi_get_inp_bus_fmts,
@@ -312,6 +346,7 @@ static const struct drm_bridge_funcs meson_encoder_hdmi_bridge_funcs = {
 int meson_encoder_hdmi_init(struct meson_drm *priv)
 {
 	struct meson_encoder_hdmi *meson_encoder_hdmi;
+	struct platform_device *pdev;
 	struct device_node *remote;
 	int ret;
 
@@ -336,6 +371,7 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 	meson_encoder_hdmi->bridge.funcs = &meson_encoder_hdmi_bridge_funcs;
 	meson_encoder_hdmi->bridge.of_node = priv->dev->of_node;
 	meson_encoder_hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+	meson_encoder_hdmi->bridge.interlace_allowed = true;
 
 	drm_bridge_add(&meson_encoder_hdmi->bridge);
 
@@ -352,17 +388,58 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 	meson_encoder_hdmi->encoder.possible_crtcs = BIT(0);
 
 	/* Attach HDMI Encoder Bridge to Encoder */
-	ret = drm_bridge_attach(&meson_encoder_hdmi->encoder, &meson_encoder_hdmi->bridge, NULL, 0);
+	ret = drm_bridge_attach(&meson_encoder_hdmi->encoder, &meson_encoder_hdmi->bridge, NULL,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		dev_err(priv->dev, "Failed to attach bridge: %d\n", ret);
 		return ret;
 	}
 
+	/* Initialize & attach Bridge Connector */
+	meson_encoder_hdmi->connector = drm_bridge_connector_init(priv->drm,
+							&meson_encoder_hdmi->encoder);
+	if (IS_ERR(meson_encoder_hdmi->connector)) {
+		dev_err(priv->dev, "Unable to create HDMI bridge connector\n");
+		return PTR_ERR(meson_encoder_hdmi->connector);
+	}
+	drm_connector_attach_encoder(meson_encoder_hdmi->connector,
+				     &meson_encoder_hdmi->encoder);
+
 	/*
 	 * We should have now in place:
-	 * encoder->[hdmi encoder bridge]->[dw-hdmi bridge]->[dw-hdmi connector]
+	 * encoder->[hdmi encoder bridge]->[dw-hdmi bridge]->[display connector bridge]->[display connector]
 	 */
 
+	/*
+	 * drm_connector_attach_max_bpc_property() requires the
+	 * connector to have a state.
+	 */
+	drm_atomic_helper_connector_reset(meson_encoder_hdmi->connector);
+
+	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL) ||
+	    meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
+	    meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
+		drm_connector_attach_hdr_output_metadata_property(meson_encoder_hdmi->connector);
+
+	drm_connector_attach_max_bpc_property(meson_encoder_hdmi->connector, 8, 8);
+
+	/* Handle this here until handled by drm_bridge_connector_init() */
+	meson_encoder_hdmi->connector->ycbcr_420_allowed = true;
+
+	pdev = of_find_device_by_node(remote);
+	if (pdev) {
+		struct cec_connector_info conn_info;
+		struct cec_notifier *notifier;
+
+		cec_fill_conn_info_from_drm(&conn_info, meson_encoder_hdmi->connector);
+
+		notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
+		if (!notifier)
+			return -ENOMEM;
+
+		meson_encoder_hdmi->cec_notifier = notifier;
+	}
+
 	dev_dbg(priv->dev, "HDMI encoder initialized\n");
 
 	return 0;
-- 
2.25.1

