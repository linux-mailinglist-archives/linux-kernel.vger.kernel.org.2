Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3342F4E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbhJOONv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbhJOON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:13:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACF4C061765
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:11:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v127so2682030wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kCc3E13c2H8+vCz2os2oO95SvYIRqrhbNDFi6yRCNEg=;
        b=SKXWwCixN4Ndd/dD+Y1DwaXKIk7fc+Dor/2SAZ8w5Xi3RRpI+GbF8zbEj+f/BSdHIp
         uxSp22gw/w2PeB+bA/wL07HQoM38NJG86WamPAqi0ySEcWodNL6TLuKGTnlehu4ixggU
         rTJDwICMZmoGOLOWRnGaEKJE3r4dGaI0EawcHMzbO7F4GhvccHS9or6aU5tMRf3xjeqP
         97sjDm0B9btstMdbv55PyoXPbV8dCNu0v6W3gjL5iTzvDn0zwloUBBEts6dqZphKi4vI
         av9E+ExeNUkwvAxb/M6tr7IDTYS7bdYiKaAfQi/6nJTJ0MkU3cwCpHdDb1TIIiMklmw2
         PN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCc3E13c2H8+vCz2os2oO95SvYIRqrhbNDFi6yRCNEg=;
        b=XFqwSTO3j4dogCA73+rH61H/F24a4d+Fm0RUBt+38wo0Mp/5tWdGWyS+WN8WWDChjZ
         vsJtI8vmuwc08vNpzCQY5RQE0JRSetqcobb+9zKJcPy6W2Qhp2ZqGxQj1nwXPB8SlGeK
         MmDv6S3XlUhfJvqTfCkbbM2beHQKebsfEfjJHgT5iTYNVuZ3/FqmYcuh/LLcCLvT7jD/
         8AgUEKtZZUjxtG+i1tgZY30+JOhKfJFT33Fo3Ye7XnJxpRbRJxEabAaAMzaKOSC3cJKo
         YdVb1LYdtpCmYUv7NzGxVCnwak5l53zo0F6j+d7BJUixzS6S6saGPKpIjOxiYMsK8Wzw
         ch+Q==
X-Gm-Message-State: AOAM531KIdbwXgqBDO2CvBc2g7V7IoxBKs1WMQrg1pFISb8YapunXi72
        HC5Ii5kwXmEWskCT2BTmMUHKlA==
X-Google-Smtp-Source: ABdhPJxg/c80Md3tBbhojA+REK5dnDAcJv72CFp1LgI7FY/bS5/0Lonyd+Rrv6uv2Hubk8j1S6nLdw==
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr12643195wmr.99.1634307074920;
        Fri, 15 Oct 2021 07:11:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f6e3:13bd:45ae:5eeb])
        by smtp.gmail.com with ESMTPSA id f15sm4971434wrt.38.2021.10.15.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:11:14 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 4/6] drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date:   Fri, 15 Oct 2021 16:11:05 +0200
Message-Id: <20211015141107.2430800-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015141107.2430800-1-narmstrong@baylibre.com>
References: <20211015141107.2430800-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7687; h=from:subject; bh=mc1HkDGnl66dr3h6jQnSyYMWMkouuV+zR/jqYEsACZ4=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhaYoliamQwIioUrdZjrrJ86ijqytyqgjw23+0QZSh Ygw/jNOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYWmKJQAKCRB33NvayMhJ0eRIEA CuOWcHPu2bb870v3z7XtcvdEvtgTfhPmBv2UmnDpo52GpCCp5cXvASNUOgeo583bJ/eHXZge2TsWTt J0TxpiWkatO5AjZrULA2UCBDHYpdpZ+5fBo32ds1pDBiP26aZvy30YREDxHBPhUngISXM2Uzdc1RvD 1dJtupadDl+npsE5my7q+R86fGxpf+umiRwM3Nx6LQcVdTvyvZk4NLy3pv16HKmiI6y6oSOjkeFPA+ OyG30i8VtfqyKIHy9/zcc9IZcXRTai2YY/RCSQYNuDm7uIbij2BxYehFUn0VCAJOQNknFzxJ0iYB0g tus38U7H7kvgfv3dZ4cPNlf6BpwN0+/lIAE1zUuRj7CSjAn9kehM4OPPqXpJSGGeW1ay1j984UQAaL fX6FDJDxUWEY7rEgk4SfUU94MeDO8rvtPGmnE/Am8VFHggvu6+L7SvA5dr71PqjyqenhnYmLdwVR6a NC8OXkIxjDc9X9LpVoGboTBAGUM9DltqCZs1d+0R2SkVgbrcp4PjX4XYEG+jtgP0IccuwRiMrLn25b /XjNW1ypODSouHqXFhwd2Hqi4lWc3c5azVktytySwmADHu4jCZce8/dXtNcO2McXoB9Z6F8X9XvR8D Kb3Ys9L4jT8T08vZFwZPoNkcw3M4OoRhaoNyAOhb6jC3uSyJew0h64SDjYeQ==
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
index 971da662c954..32f52f1c423b 100644
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
 static void meson_encoder_hdmi_enable(struct drm_bridge *bridge)
 {
 	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
@@ -302,11 +315,32 @@ static int meson_encoder_hdmi_atomic_check(struct drm_bridge *bridge,
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
 	.enable	= meson_encoder_hdmi_enable,
 	.disable = meson_encoder_hdmi_disable,
 	.mode_valid = meson_encoder_hdmi_mode_valid,
+	.hpd_notify = meson_encoder_hdmi_hpd_notify,
 	.atomic_enable = meson_encoder_hdmi_atomic_enable,
 	.atomic_get_input_bus_fmts = meson_encoder_hdmi_get_inp_bus_fmts,
 	.atomic_check = meson_encoder_hdmi_atomic_check,
@@ -318,6 +352,7 @@ static const struct drm_bridge_funcs meson_encoder_hdmi_bridge_funcs = {
 int meson_encoder_hdmi_init(struct meson_drm *priv)
 {
 	struct meson_encoder_hdmi *meson_encoder_hdmi;
+	struct platform_device *pdev;
 	struct device_node *remote;
 	int ret;
 
@@ -342,6 +377,7 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 	meson_encoder_hdmi->bridge.funcs = &meson_encoder_hdmi_bridge_funcs;
 	meson_encoder_hdmi->bridge.of_node = priv->dev->of_node;
 	meson_encoder_hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+	meson_encoder_hdmi->bridge.interlace_allowed = true;
 
 	drm_bridge_add(&meson_encoder_hdmi->bridge);
 
@@ -358,17 +394,58 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
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

