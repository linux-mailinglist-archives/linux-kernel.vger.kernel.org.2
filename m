Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C54439A83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhJYPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:32:00 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:49421 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233932AbhJYPbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:31:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id E539B5806D0;
        Mon, 25 Oct 2021 11:29:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 25 Oct 2021 11:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=a9roag1oqPjXR
        LZgnod4bYHBt3pMTWCwcd3UoUXihu4=; b=mv0j6KCPChwCcbStU2zzOnZ25al4m
        ZJ63fa9Ys0UmAU4cEOC6QeZE13tXoNpIZf9VMPVrIonBQ3756i77aWsoIR62ES3E
        MTzRTzGJQIpWlJno/2cLKAyRyA9cEzy95lgpZhSIMOAAZlxMtLYMe0nWe90S2SLy
        qY/V17lVuOmZua2nxKTlUxWrhf9pJMd2dMhrhscGaAt+Z/DXwMHklR27J+0ezCvY
        dQhH0Cj8eAnqt5fttu+O3J6AAhnRDYh4bLjU6R/kcADWFqvo3oFEiDFs4ohR5HXL
        bn3MV+ZFLnhmgbORDs8EQljb/cFgDBLwm9JLoOtVkYns3KM+r8FxNEe0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=a9roag1oqPjXRLZgnod4bYHBt3pMTWCwcd3UoUXihu4=; b=mJrsUV57
        KHgdlgYugttWnqM7mMK8ebtAn7mXM/WS9eS1If6OeIGu82D61+xcx2k1TY9wlmVE
        TDaVjfTkYCz8sO2N7n4Prj3CF+MV2lhckn1O0EoUBAcmulppWwi1C44lxTWYH76I
        69HeQuveVgcrOun2+BSb/IdDIrbKPvo4SY0GBp/H446t6XkTKXtM6cL5TITGUEJf
        j/bTXhGwKrc/SQXDfLwLL6p2nrfmqmnxwsuHpEZJ+8zSQbyCKVkvC+5l5pT25Vs3
        wr4cvGJFmM8Lftd0NV0EkRGn9zSosvz5n8UAAMeGkz7hY6EPfT2FibZ7Yr9poDHW
        8GNKMa5bDDVyjA==
X-ME-Sender: <xms:T812YaqFeMi8WVX1_L4IkGnDPfjc95XrNiaStgLm_tOO9YxTaRtJ8Q>
    <xme:T812YYrBFZAhNV_f1A6W-MHHJ7mww4w9_JSK-7iB9IVdJQFoQDvgSNS6vk0ECIxd-
    ZhiuboOwAX8nP3FyW4>
X-ME-Received: <xmr:T812YfO7vfM4i8JgWsM3sg0KN-XvZBwOtZYvqdok5F1yOkvVmzMbaXp9GK0jjw0VWQNEJzZm_pBkJyBYYEQ6RSVd14Qk63OYOHR5Aao7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:T812YZ7EjIG0TqRldE_Qo42pFREkitIYzWBfqXSpTlD247j0q7HiCQ>
    <xmx:T812YZ5vgSMyCaDn0PUCNE_yufaU0H3K_w5qQ0UJ_d9g5f1zCmrMGg>
    <xmx:T812YZgW89Jtvyrep24N1OEcuTRi8DsgKUpdoDMtA3PpdTjsY43xzw>
    <xmx:T812YYQzEwYohJa-cANeJoF3WF88tRTJgbKk27raf6JXeqzY1Ly1Ag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 11:29:18 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Emma Anholt <emma@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>
Subject: [PATCH v8 06/10] drm/vc4: crtc: Add some logging
Date:   Mon, 25 Oct 2021 17:28:59 +0200
Message-Id: <20211025152903.1088803-7-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025152903.1088803-1-maxime@cerno.tech>
References: <20211025152903.1088803-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The encoder retrieval code has been a source of bugs and glitches in the
past and the crtc <-> encoder association been wrong in a number of
different ways.

Add some logging to quickly spot issues if they occur.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index fbc1d4638650..6decaa12a078 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -541,6 +541,9 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, old_state);
 	struct drm_device *dev = crtc->dev;
 
+	drm_dbg(dev, "Disabling CRTC %s (%u) connected to Encoder %s (%u)",
+		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
+
 	require_hvs_enabled(dev);
 
 	/* Disable vblank irq handling before crtc is disabled. */
@@ -572,6 +575,9 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, new_state);
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 
+	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)",
+		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
+
 	require_hvs_enabled(dev);
 
 	/* Enable vblank irq handling before crtc is started otherwise
-- 
2.31.1

