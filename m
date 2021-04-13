Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9435DE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbhDMMLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:11:37 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57083 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhDMMLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:11:31 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2500758043B;
        Tue, 13 Apr 2021 08:11:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 13 Apr 2021 08:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=zstF2kI0HrVH1
        HQPqUiHA1fhN+BOhvPMMfpaIAmuoU0=; b=l5jZl7acAXE10AcUXo5cSwFI1gR+W
        7kx3F1P9tnsjYuj646ADeDsdv8c6IFu1jw7cKWE52k4R4pPhXkWtsAPWndSz0Itl
        2svOTmfBHPGBA5lJ7m7XiHVVpMkVu6Hopk/2wcQI6kdfPyKiXyG6aFupR0EoSXA2
        Wb4821LCEnt3EYz0T37mRSNyyYrgCVcqdebXpL6p0Uvq35D5qjihFwjaHdm58WnW
        j5KOujPx4MkTFSiqVWblMXqAcr200W4fgzEdncQiPyj8D1033Pc0BWbqnIbPP2C0
        3f7OFopB0rsPU4ZjXtbK+CZd1MWfEcz/BZURd7Q6/Ho2XBHoEt474Yg0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zstF2kI0HrVH1HQPqUiHA1fhN+BOhvPMMfpaIAmuoU0=; b=OG+9lCST
        xAdJIfUGsfzi3tgVG4lQ3n+zY56sqDUNepavJpD9MAV5bbCDyA8zjWvTeU0U8nzi
        hSW7FTIrl9PHtaf1gdwKx1kIdMfp/M8ycxFDUih1wEuosrfaRGBkPGyrqYyKDI9i
        k09I1re5TkavvUbptNlBM+VdhrbyHBUscledU7GDzQTZrduN9bd2J7pHecUl0/w+
        TqVKZSE/n8EnXwJX5dcMfYSoxAxlVAQ8y+7SscWO+x7jRCsQsM3EPkmLcqNzQwTT
        cA6y9I//gSO5IthzJG6kt2TTr/DRB5KyxmmlhcqoLno4iuUnZcXqRjWT8gZqNDP7
        D4/+EF0gcWStkA==
X-ME-Sender: <xms:YIp1YJ-TTAs0QWPfsbEt-g7HYfyP2kVpdsZdU8fP6hVWuiwQheM4NQ>
    <xme:YIp1YBiJhNyD6ezBOeEgxvKjCLg_xfJyxzM62vUP2yCsU5LeH4I43-QxlOTl_J7-Z
    L79JWQ2YjmLsn2p-TY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:YIp1YAFPB3wiWOqb2oNKOHZDHtj1p33sMyGorU5GA-5ZyRx9puSbyA>
    <xmx:YIp1YA_l3YbAQB8jlWAc4CNQIxiFYzWw1wD_N40W2_Iywn6SDQiXcA>
    <xmx:YIp1YHz8goJatFpfcbra7IPMQ9Jf86LFFVixwO2PR7Uij9RZFdiPfw>
    <xmx:YIp1YCpRC22a2jhcrmf0a5IGn0Y71ZKsa9xQ0j_Y3u3B9f_7WkT-hA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B1DF8108005F;
        Tue, 13 Apr 2021 08:11:11 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Eric Anholt <eric@anholt.net>, Leo Li <sunpeng.li@amd.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 4/5] drm/connector: Add a helper to attach the colorspace property
Date:   Tue, 13 Apr 2021 14:11:03 +0200
Message-Id: <20210413121104.375789-4-maxime@cerno.tech>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413121104.375789-1-maxime@cerno.tech>
References: <20210413121104.375789-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel driver uses the same logic to attach the Colorspace property
in multiple places and we'll need it in vc4 too. Let's move that common
code in a helper.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---

Changes from v1:
  - New patch
---
 drivers/gpu/drm/drm_connector.c               | 20 +++++++++++++++++++
 .../gpu/drm/i915/display/intel_connector.c    |  6 ++----
 include/drm/drm_connector.h                   |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b13021b1b128..6a20b249e533 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2171,6 +2171,26 @@ int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *conn
 }
 EXPORT_SYMBOL(drm_connector_attach_hdr_output_metadata_property);
 
+/**
+ * drm_connector_attach_colorspace_property - attach "Colorspace" property
+ * @connector: connector to attach the property on.
+ *
+ * This is used to allow the userspace to signal the output colorspace
+ * to the driver.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_colorspace_property(struct drm_connector *connector)
+{
+	struct drm_property *prop = connector->colorspace_property;
+
+	drm_object_attach_property(&connector->base, prop, DRM_MODE_COLORIMETRY_DEFAULT);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_colorspace_property);
+
 /**
  * drm_connector_atomic_hdr_metadata_equal - checks if the hdr metadata changed
  * @old_state: old connector state to compare
diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/gpu/drm/i915/display/intel_connector.c
index d5ceb7bdc14b..9bed1ccecea0 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.c
+++ b/drivers/gpu/drm/i915/display/intel_connector.c
@@ -282,14 +282,12 @@ void
 intel_attach_hdmi_colorspace_property(struct drm_connector *connector)
 {
 	if (!drm_mode_create_hdmi_colorspace_property(connector))
-		drm_object_attach_property(&connector->base,
-					   connector->colorspace_property, 0);
+		drm_connector_attach_colorspace_property(connector);
 }
 
 void
 intel_attach_dp_colorspace_property(struct drm_connector *connector)
 {
 	if (!drm_mode_create_dp_colorspace_property(connector))
-		drm_object_attach_property(&connector->base,
-					   connector->colorspace_property, 0);
+		drm_connector_attach_colorspace_property(connector);
 }
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 1f51d73ca715..714d1a01c065 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1671,6 +1671,7 @@ int drm_connector_attach_scaling_mode_property(struct drm_connector *connector,
 					       u32 scaling_mode_mask);
 int drm_connector_attach_vrr_capable_property(
 		struct drm_connector *connector);
+int drm_connector_attach_colorspace_property(struct drm_connector *connector);
 int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector);
 bool drm_connector_atomic_hdr_metadata_equal(struct drm_connector_state *old_state,
 					     struct drm_connector_state *new_state);
-- 
2.30.2

