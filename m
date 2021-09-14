Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6478640AB87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhINKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:19:09 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:46981 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231477AbhINKSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:18:53 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 306872B01316;
        Tue, 14 Sep 2021 06:17:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Sep 2021 06:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=+ide+UmLneTo5
        vJdUf22CynDGpfUvW89sPLSj2e8DUg=; b=DtyUB/xrQZAkOeVn8YmRLGTRbzIZ1
        VwTLc/PnqwMdCVm1qSCQlsEooLhsTOBwiW06MuonRNX94yNWIOYo4C3S2ukocoqF
        kvnsFhd99s29pQaT8OLgLvbod2mrNZ+52lBOlPZU9/334HaSGCdPCiGCm6TcN487
        vZyoTYLM9bZOx/bX+DprlzHus796VbqfgqpegN/rUHiyw5hkDa32G0gkD4hfWuVH
        NsX3HD2VRCc3r2mfLpZu3BPZlmNH57avepqzQOe7dq5lywZzI15etv3JUfp4CxZc
        4ZS2C2B8EUeR6WHwaBL7hTV6fN4qLv25KyzzBcBuQpajNPYiyJ+ABwGgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+ide+UmLneTo5vJdUf22CynDGpfUvW89sPLSj2e8DUg=; b=ukmegH38
        Nl8NHCwrN7VBblycDB0Wf2Y4paOHFE+qR166XYCOTgc2V3zmr2QwdWAFmeZI+50q
        Lvd5f9pgIQqxm6+rjPGy/DszBzETiqQ5OnzSJislwAxCTs++AXGkzN8ONhLvMxBk
        Ck4TwJbBTv52wApL+65YkNFxz9SF+0ToHLe2EzcTp6ImP5Ze2RU/KGGktQez2+A9
        TJSsDDu6WS8DdAOdgjDXF2O827U5HZY7oJxySv96ElPAJByfoz55M3J49HPwoh4m
        uQzD0ZrOfyTyZGbPHehWZv0cyVYAKvMDWyjVXnC0U7oE0FvvYT0W16IHLqP3xz5n
        7Ij8W9H2vBg8Og==
X-ME-Sender: <xms:vnZAYbG0QBW_C7C4ylIf8IzRGYXBVick_MnQ2FitnGherPh3C8oh-A>
    <xme:vnZAYYURBogC18nCWGyPT21LcGgc48BJdhmKqUDbCQVlgCu6EtfP76YXg8ufvRLKj
    CK6lDpS3ou79Ducv_s>
X-ME-Received: <xmr:vnZAYdJLT9JqtgKcIo6DzG4wTmxXH7FaZXNW029xGCRHbOy7yvsxCbNf3yn7TAs8OEXCFLlstXHsZI_UM37zhhKl3U5iDGoNtjj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vnZAYZFgXRBa0_LnPObyuhGNoI3N_oWewSAzG-ljQzypRTSTjn3Rqw>
    <xmx:vnZAYRUodNwALj_G2DqWnZTnBvvwx2ewbbU9k2HzFaemGIA3QhCrbQ>
    <xmx:vnZAYUOLuuPK-s8fKbfcQtdnoOro6kKU9CBzhUQ8B9jmsWrIOYYlBg>
    <xmx:vnZAYSukMZ33-h_TF-ZZVDz3P-JL7-2QLo6fQXS8O_QzNxj1A8OO0EbHai4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 06:17:34 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/vc4: hdmi: Actually check for the connector status in hotplug
Date:   Tue, 14 Sep 2021 12:17:24 +0200
Message-Id: <20210914101724.266570-3-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210914101724.266570-1-maxime@cerno.tech>
References: <20210914101724.266570-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_helper_hpd_irq_event() documentation states that this function
is "useful for drivers which can't or don't track hotplug interrupts for
each connector." and that "Drivers which support hotplug interrupts for
each connector individually and which have a more fine-grained detect
logic should bypass this code and directly call
drm_kms_helper_hotplug_event()". This is thus what we ended-up doing.

However, what this actually means, and is further explained in the
drm_kms_helper_hotplug_event() documentation, is that
drm_kms_helper_hotplug_event() should be called by drivers that can
track the connection status change, and if it has changed we should call
that function.

This underlying expectation we failed to provide is that the caller of
drm_kms_helper_hotplug_event() should call drm_helper_probe_detect() to
probe the new status of the connector.

Since we didn't do it, it meant that even though we were sending the
notification to user-space and the DRM clients that something changed we
never probed or updated our internal connector status ourselves.

This went mostly unnoticed since the detect callback usually doesn't
have any side-effect. Also, if we were using the DRM fbdev emulation
(which is a DRM client), or any user-space application that can deal
with hotplug events, chances are they would react to the hotplug event
by probing the connector status eventually.

However, now that we have to enable the scrambler in detect() if it was
enabled it has a side effect, and an application such as Kodi or
modetest doesn't deal with hotplug events. This resulted with a black
screen when Kodi or modetest was running when a screen was disconnected
and then reconnected, or switched off and on.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a3dbd1fdff7d..d9e001b9314f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1578,10 +1578,11 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 static irqreturn_t vc4_hdmi_hpd_irq_thread(int irq, void *priv)
 {
 	struct vc4_hdmi *vc4_hdmi = priv;
-	struct drm_device *dev = vc4_hdmi->connector.dev;
+	struct drm_connector *connector = &vc4_hdmi->connector;
+	struct drm_device *dev = connector->dev;
 
 	if (dev && dev->registered)
-		drm_kms_helper_hotplug_event(dev);
+		drm_connector_helper_hpd_irq_event(connector);
 
 	return IRQ_HANDLED;
 }
-- 
2.31.1

