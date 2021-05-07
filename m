Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869733766B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbhEGOGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 10:06:33 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:51583 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237439AbhEGOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 10:06:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5CE72FC9;
        Fri,  7 May 2021 10:05:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 May 2021 10:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mk7wl4U7fv51G
        9FP4J4AMak3FrOXNRF04TAlRK/Y4S8=; b=ficzAXA4HTWdaPtxUNFpyPSr4tY1w
        l2zI9JsEta3o3GSGP/JK4AIs7Gk55hxUru6ZDJhRE73LyfxGnTmtx8FVP/gqRwYf
        Bn3L3oSEws3ELa0kK4kgvP09KkAsTDxpwJLXfBRTfyljNEBBIumb5c6arYLKVHFD
        zAEWynCK6odjnSPVmwz8IJOJRemrObhX+FeiSUpjLZ4Qe+GPc5sDhQG2d76NaoV5
        5dgF0gCsPea4wOmXXmvZvYS/Q2/Hy9F/GN0JT+9k8lEMnVb4q+b7FlRlTbSZjD+E
        hMqKhCm76P5NHZffBY/KvX5DNmeT1l6YXTFlhafXGGqO524g8mv5JvKSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=mk7wl4U7fv51G9FP4J4AMak3FrOXNRF04TAlRK/Y4S8=; b=szFfCf/D
        uE51CZYYz9CWiGV+7I1KcZH+PFLqpDz86huF5Bu5h4OdXYc60Px73mx8/aeiByQC
        OZL3OGxwAJxhoblDoHfq//Nh/qt17Kjv82lNMd69ogPeTWV3mVhaokNEz7KMU+iz
        2FsnGbhGe1JZiBHRXqCSzh46SnesAnGSOaBYHkyHIMO6gNkQjOT5MLhUFUd+eZyD
        GWRRqHtb0rha6Ez+s7297iNzWbtyjkFwRVGrF1Fi2Ol273DFozQBacgXruI6bxrB
        P0YNC6rAUnN3c2iEWE92Nvm+inkijJY6n+lZnzXTQKiODczQbUQF29O1qZ/EJX0j
        Ntn3qrAZ7qZ4sg==
X-ME-Sender: <xms:IEmVYFTHggYkLr9Hzt0Es2f_WIc7f33xti_I12fhwhXijAqtmmAvEg>
    <xme:IEmVYOxyKiaUFR2lDBwKcpXDRPNouH1zv76ByJZc2682_Eb1Np0Ps5GQa81ke9OKe
    Ha7qFsJQIct_um6Heo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IEmVYK1OQ_TMo1uXVd2mZpMVrO0lAKB2x5Ox6yRnYe97ej1Rxwj09w>
    <xmx:IEmVYNBZt0uSjrjs90vnSHd9YqgSfes3l4Plqav5N0ZYw-Mvd4R2Xg>
    <xmx:IEmVYOjhxV9LqRkuJLF44Z5eYzkyYQRsWKbKPKHjKqXdG7vqUM2p0g>
    <xmx:I0mVYORIny0UGv6gFRQFFx2t6GJ7tIkGkyOqJmpWNEe2wWgvuV2bzQRdGn0>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri,  7 May 2021 10:05:20 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org,
        Eric Anholt <eric@anholt.net>,
        Dom Cobley <popcornmix@gmail.com>
Subject: [PATCH 07/11] drm/vc4: hdmi: Set VC4_HDMI_MAI_CONFIG_FORMAT_REVERSE
Date:   Fri,  7 May 2021 16:03:30 +0200
Message-Id: <20210507140334.204865-8-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507140334.204865-1-maxime@cerno.tech>
References: <20210507140334.204865-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dom Cobley <popcornmix@gmail.com>

Without this bit set, HDMI_MAI_FORMAT doesn't pick up
the format and samplerate from DVP_CFG_MAI0_FMT and you
can't get HDMI_HDMI_13_AUDIO_STATUS_1 to indicate HBR mode

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 9d33ac464a2d..f74a6b99d4ec 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1232,6 +1232,7 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 
 	HDMI_WRITE(HDMI_MAI_CONFIG,
 		   VC4_HDMI_MAI_CONFIG_BIT_REVERSE |
+		   VC4_HDMI_MAI_CONFIG_FORMAT_REVERSE |
 		   VC4_SET_FIELD(channel_mask, VC4_HDMI_MAI_CHANNEL_MASK));
 
 	channel_map = vc4_hdmi->variant->channel_map(vc4_hdmi, channel_mask);
-- 
2.31.1

