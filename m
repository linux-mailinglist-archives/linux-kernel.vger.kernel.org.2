Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4563B5E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhF1Mpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:45:38 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55451 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232916AbhF1Mpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:45:32 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2ADB85804FF;
        Mon, 28 Jun 2021 08:43:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 28 Jun 2021 08:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=jS6TVx0UliOrH
        1OI8iaaFRuBIIJXKjPyTT8H3/Zjx1Q=; b=FAY1g7r8ZslKc1jQAd2Ap+060AfAz
        7fUlp9BRjPk2ePPfHGg4yNjIdcwOHIvuuqgk+9UXkrSt8TOR5AtR6ZWF1AwtJtTG
        RMwxDksal0w8y9rfRvnddqggfLlaOEhZj9JH1u9QM3qcUHxD80y47cgKu4VPCyrX
        Kapkap/J/Rh+9UA1eULYTBv8/rzYuEsp/kT3f4odnN9BFedKA4+rzy6h10JrdROF
        /i576cGKI9BKK4vW9nfqm8GmPM+8p45vytoFm4j2LuGsVov432mbdQIisdbvS+3G
        EiJWsOKvlRhVnsgobeWpPxmxz20NZl/sSL/Xk7YlUH8LPKuWtV/DfQTKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=jS6TVx0UliOrH1OI8iaaFRuBIIJXKjPyTT8H3/Zjx1Q=; b=cJFqIgbJ
        Kg8tYNebR4Ac/aeyHgLQNlewe5zDhQPCd339NAm69dHcjSC4yOIeAcBqDCthOl+a
        BwqrDwME1/MXnr9maSsVI/2NaAD+5BBegB5uNpuNuZbprSPh+QfJCPlS1xrKRJi1
        lclvhuKLlhMuDXvYMTSFDQkyp+f1bAsFtOdJrRwZRhc4IHDJ2xV4CTy9SCc7KG7f
        CQgbzkwxqeHfHJAUkT+YkjAWlrM3ZplAjjZEjcsvK7ZQskDSlOeXDr94urwvRRp7
        Kt6jKeZ8/MGJIZHoD5ZZKcQ09oBLzVU2fVhzOBNGEv7QLpqR9ZwTb/rV/CNUATo4
        2VreJ/zX5XsANQ==
X-ME-Sender: <xms:28PZYNZqFSdalbw4aXdR2TZ8XzUoBLeNRqxFpeJIRiQk0jCXvJqfDg>
    <xme:28PZYEbdWDvlIB7rIco6-MKgxdlCCXW3I4o5udpatJHnT5zY9kLHJtR8PyKCU2dKX
    w6WWsANDs1O6uRveqk>
X-ME-Received: <xmr:28PZYP9yi8PFW9AnIRt-gwCmniG9ni7WQNgc62ho0s2NGJMLpYRKDwB2L2ql1Q8_dVMvYpQLur3bjE4ASCDdmkT5ZMeMFbM1bnf_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:28PZYLp8qPXn8bMUynE7m1_UEB34ZRD4DuXD_FR3Lh0pAXZEilrVHw>
    <xmx:28PZYIr7h3yzMZdemWzmjl4KWPMiSlBKD3n8vrbnFEjZ9PT0GawTcQ>
    <xmx:28PZYBSyAkK04qC9BXXUpWtE_0CzxMQxcylXaj6zspoAWBDpQ3PW3Q>
    <xmx:28PZYEYv-eR3xzPGWPSCX3_1LTC35eKhSXXnMClpY_VNdtH-X6zAUg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 08:43:06 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Emma Anholt <emma@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/10] drm/vc4: Make vc4_crtc_get_encoder public
Date:   Mon, 28 Jun 2021 14:42:50 +0200
Message-Id: <20210628124257.140453-4-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628124257.140453-1-maxime@cerno.tech>
References: <20210628124257.140453-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need that function in vc4_kms to compute the core clock rate
requirements.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 8 ++++----
 drivers/gpu/drm/vc4/vc4_drv.h  | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 18f5009ce90e..902862a67341 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -279,10 +279,10 @@ static u32 vc4_crtc_get_fifo_full_level_bits(struct vc4_crtc *vc4_crtc,
  * allows drivers to push pixels to more than one encoder from the
  * same CRTC.
  */
-static struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
-						struct drm_atomic_state *state,
-						struct drm_connector_state *(*get_state)(struct drm_atomic_state *state,
-											 struct drm_connector *connector))
+struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
+					 struct drm_atomic_state *state,
+					 struct drm_connector_state *(*get_state)(struct drm_atomic_state *state,
+										  struct drm_connector *connector))
 {
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 5dceadc61600..d3e5238eadb5 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -515,6 +515,11 @@ vc4_crtc_to_vc4_pv_data(const struct vc4_crtc *crtc)
 	return container_of(data, struct vc4_pv_data, base);
 }
 
+struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
+					 struct drm_atomic_state *state,
+					 struct drm_connector_state *(*get_state)(struct drm_atomic_state *state,
+										  struct drm_connector *connector));
+
 struct vc4_crtc_state {
 	struct drm_crtc_state base;
 	/* Dlist area for this CRTC configuration. */
-- 
2.31.1

