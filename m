Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660FA36F81E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhD3JqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:46:03 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:40303 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhD3Jp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:45:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id AC1D45800D7;
        Fri, 30 Apr 2021 05:45:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 30 Apr 2021 05:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=+1jVcZdjfORyp
        rwDU8d7SzSPEQYAqkZClde0yfqzLq4=; b=jcJfqu+yfkofKEq6OAhV3P/ojh66h
        AKwMz4VJR5Eh7AFt/iCNux6zabsBKGY/rrB39PyF48kkcSRf/w4tBtYOxF/vTXlr
        HuxWhlpm7a770c7qXQ/0I1z1ITQbM6ZS8TZTrsrEdoYYsi4RaCzQzg9NK64FeVkZ
        Sox6ywrndPB03eJQHmvYd8yvMTRCi25CMi9xhf2OEjE9xOSxTy56nbNFmHo/UpLM
        0UbyDymBWBM9qT6UxgV89kueVr4WcATDZUagIxklphFvEcSTI4NnxYGJXnuMr3I+
        GyPLXSh5gHtvMbtbiG0k1ALKvPEJeuEgIeVtXZbxGVE7++gonlk8GhMxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=+1jVcZdjfORyprwDU8d7SzSPEQYAqkZClde0yfqzLq4=; b=Msa9nCat
        bPWQ9xl1pljP9Qxdnj3eGhocRTpYCl0DGWF+ve5gCOBLJNNOADTWBnT1qtckRQeN
        Wymt6YHz9fxcpNREdkajMWFF6zfb6ecio+KMj9fgTs9f+ZLRCpWT0RStlswTV4l+
        eQJaCBGd/HyRa2bfUisUbAZBIVYLs0mHwFPVTQRHVeL6QPv8fhp25km2KZEqssvC
        1pJigUX0q0QpwrEWiV/NlXKeoww4FEB5fdwLxt2Mlf3ORE+DSHmeJQE38OQyioxk
        CforjQj2yikTbqudTZ7rt1HnX8trK6+FYMMCzZdCoJszdDyZrWW1EFO0q0Io5GSI
        chV/V1nJMyscnQ==
X-ME-Sender: <xms:ptGLYGuMw2jPo4DXmebqO63tNBLp3vxLzzSRr3ohgLFTn9NWI8xszg>
    <xme:ptGLYLcHBdCOF6w0FC83wSQPiDSludwn8WrannYB4V3tn4BYtOoBjyh_39VTO3SM8
    ukw2SjCPmNw_bH4ffo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddviedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ptGLYBwLJ90G_soKRBipo0VcEyfG_fXy8vERY2H5jr7g3cdwSeEPdg>
    <xmx:ptGLYBNPTghXWUS6BBrwWZProxg4gQofIaV-aHuo45lu8mpUDHkkmA>
    <xmx:ptGLYG-BKoADuw3ZoM0d3T4jmqFXF_PishVOM27hCSRbO4AMyCcmYQ>
    <xmx:ptGLYKRIuuIqkeXJNivuq4EWHDvbVkWGe0LVYzXgKcftrWBzD_0U6g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 30 Apr 2021 05:45:09 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>
Subject: [PATCH v3 5/5] drm/vc4: hdmi: Signal the proper colorimetry info in the infoframe
Date:   Fri, 30 Apr 2021 11:44:51 +0200
Message-Id: <20210430094451.2145002-5-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430094451.2145002-1-maxime@cerno.tech>
References: <20210430094451.2145002-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our driver while supporting HDR didn't send the proper colorimetry info
in the AVI infoframe.

Let's add the property needed so that the userspace can let us know what
the colorspace is supposed to be.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---

Changes from v2:
  - Rebased on current drm-misc-next

Changes from v1:
  - New patch
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a33fa1662588..a22e17788074 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -226,7 +226,8 @@ static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
 	if (!crtc)
 		return 0;
 
-	if (!drm_connector_atomic_hdr_metadata_equal(old_state, new_state)) {
+	if (old_state->colorspace != new_state->colorspace ||
+	    !drm_connector_atomic_hdr_metadata_equal(old_state, new_state)) {
 		struct drm_crtc_state *crtc_state;
 
 		crtc_state = drm_atomic_get_crtc_state(state, crtc);
@@ -316,6 +317,11 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	ret = drm_mode_create_hdmi_colorspace_property(connector);
+	if (ret)
+		return ret;
+
+	drm_connector_attach_colorspace_property(connector);
 	drm_connector_attach_tv_margin_properties(connector);
 	drm_connector_attach_max_bpc_property(connector, 8, 12);
 
@@ -424,7 +430,7 @@ static void vc4_hdmi_set_avi_infoframe(struct drm_encoder *encoder)
 					   vc4_encoder->limited_rgb_range ?
 					   HDMI_QUANTIZATION_RANGE_LIMITED :
 					   HDMI_QUANTIZATION_RANGE_FULL);
-
+	drm_hdmi_avi_infoframe_colorspace(&frame.avi, cstate);
 	drm_hdmi_avi_infoframe_bars(&frame.avi, cstate);
 
 	vc4_hdmi_write_infoframe(encoder, &frame);
-- 
2.31.1

