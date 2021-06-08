Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5C39FE10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhFHRpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:45:35 -0400
Received: from srv6.fidu.org ([159.69.62.71]:56210 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233758AbhFHRpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:45:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id E9D3FC800ED;
        Tue,  8 Jun 2021 19:43:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Scg0SkiuZhOe; Tue,  8 Jun 2021 19:43:27 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300E37f4F60006a44b0068bFE089d.dip0.t-ipconnect.de [IPv6:2003:e3:7f4f:6000:6a44:b006:8bfe:89d])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 8130FC800E2;
        Tue,  8 Jun 2021 19:43:27 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v2 5/7] drm/uAPI: Add "active color format" drm property as feedback for userspace
Date:   Tue,  8 Jun 2021 19:43:18 +0200
Message-Id: <20210608174320.37429-6-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608174320.37429-1-wse@tuxedocomputers.com>
References: <20210608174320.37429-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new general drm property "active color format" which can be used by
graphic drivers to report the used color format back to userspace.

There was no way to check which color format got actually used on a given
monitor. To surely predict this, one must know the exact capabilities of the
monitor, the GPU, and the connection used and what the default behaviour of the
used driver is (e.g. amdgpu prefers YCbCr 4:4:4 while i915 prefers RGB). This
property helps eliminating the guessing on this point.

In the future, automatic color calibration for screens might also depend on this
information being available.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c |  2 ++
 drivers/gpu/drm/drm_connector.c   | 46 +++++++++++++++++++++++++++++++
 include/drm/drm_connector.h       | 13 +++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 7ae4e40936b5..bb78da2405f9 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -875,6 +875,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->max_requested_bpc;
 	} else if (property == connector->active_bpc_property) {
 		*val = state->active_bpc;
+	} else if (property == connector->active_color_format_property) {
+		*val = state->active_color_format;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index c0c3c09bfed0..f4f35c4117b6 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -887,6 +887,14 @@ static const struct drm_prop_enum_list drm_dp_subconnector_enum_list[] = {
 	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
 };
 
+static const struct drm_prop_enum_list drm_color_format_enum_list[] = {
+	{ 0, "none" },
+	{ DRM_COLOR_FORMAT_RGB444, "rgb" },
+	{ DRM_COLOR_FORMAT_YCRCB444, "ycbcr444" },
+	{ DRM_COLOR_FORMAT_YCRCB422, "ycbcr422" },
+	{ DRM_COLOR_FORMAT_YCRCB420, "ycbcr420" },
+};
+
 DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
 		 drm_dp_subconnector_enum_list)
 
@@ -1202,6 +1210,14 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
  *	display engine and connected monitor, and the "max bpc" property.
  *	Drivers shall use drm_connector_attach_active_bpc_property() to install
  *	this property.
+
+ * active color format:
+ *	This read-only property tells userspace the color format actually used
+ *	by the hardware display engine on "the cable" on a connector. The chosen
+ *	value depends on hardware capabilities, both display engine and
+ *	connected monitor. Drivers shall use
+ *	drm_connector_attach_active_color_format_property() to install this
+ *	property.
  *
  * Connectors also have one standardized atomic property:
  *
@@ -2191,6 +2207,36 @@ int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_connector_attach_active_bpc_property);
 
+/**
+ * drm_connector_attach_active_color_format_property - attach "active color format" property
+ * @connector: connector to attach active color format property on.
+ *
+ * This is used to check the applied color format on a connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_active_color_format_property(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	prop = connector->active_color_format_property;
+	if (!prop) {
+		prop = drm_property_create_enum(dev, 0, "active color format", drm_color_format_enum_list, ARRAY_SIZE(drm_color_format_enum_list));
+		if (!prop)
+			return -ENOMEM;
+
+		connector->active_color_format_property = prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop, 0);
+	connector->state->active_color_format = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_active_color_format_property);
+
 /**
  * drm_connector_set_vrr_capable_property - sets the variable refresh rate
  * capable property for a connector
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c58cba2b6afe..167cd36129ae 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -788,6 +788,12 @@ struct drm_connector_state {
 	 */
 	u8 active_bpc;
 
+	/**
+	 * active_color_format: Read only property set by the GPU driver to the
+	 * actually used color format after evaluating all hardware limitations.
+	 */
+	u32 active_color_format;
+
 	/**
 	 * @hdr_output_metadata:
 	 * DRM blob property for HDR output metadata
@@ -1393,6 +1399,12 @@ struct drm_connector {
 	 */
 	struct drm_property *active_bpc_property;
 
+	/**
+	 * @active_color_format_property: Default connector property for the
+	 * active color format to be driven out of the connector.
+	 */
+	struct drm_property *active_color_format_property;
+
 #define DRM_CONNECTOR_POLL_HPD (1 << 0)
 #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
 #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
@@ -1713,6 +1725,7 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
 int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
 					  int min, int max);
+int drm_connector_attach_active_color_format_property(struct drm_connector *connector);
 
 /**
  * struct drm_tile_group - Tile group metadata
-- 
2.25.1

