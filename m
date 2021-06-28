Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB013B5E46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhF1Mpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:45:55 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:38579 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232943AbhF1Mph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:45:37 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2CC62580502;
        Mon, 28 Jun 2021 08:43:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 28 Jun 2021 08:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=QYwjYbERT0K9u
        SYo01fONKt0VxIOtLUAbN9O7B83ar8=; b=BOjYyYr+r/I8iQ92ILNtKBwRMWm+N
        PT9G59SPQq+SyTg5y+TReJt9GE+NGjRb/QoWmW06VmbaIdH42JbqDgTtv/8hJ7le
        h61JorV6UdPaElzrzOM+Fon6eEZBf8V4m2BkWxunYue6rHJ//wusx3VWYvhbLdFe
        8AqfofOjLI5ENrhL0y+WY09yGtcyNSalSJ4zAj///YADNWKXm7EU7UqDhFCjbNPU
        LavRDbbPR2Qe0F7ssshKnaQxLS7qtJ5wKkBdu/MsMsfi+SRLN9EbNKwGoak6dJqh
        5BC47UYaWPdKFTp+QQMWpUm7G74rz5WAaLOOmg/jMC3u7B0WQOBZxvOeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=QYwjYbERT0K9uSYo01fONKt0VxIOtLUAbN9O7B83ar8=; b=N5xrNQLw
        0f8hriw1Pq+TWSCWMxaaT33EsyHw49tL8d7Q7U/nYNYueWNwhXPEwwMNVVUeFcBe
        mKMapvqh/soYQzUWe88zZd0aWB3bfl3CgnWND9MZYhhuLEFLikDECUy6QqasoQ7x
        uuur02Zf7T7DXOX+Up+iF+tpvaGXpF3TtKVQ69wQWqT9tikkOHGM2OuVnkGgyD9/
        73SaVaj7WtVpRSTzxGAyfFb+3RL6GAeCqTHA2OmHdhOKDeUH62ARLixXUP6uQmDJ
        bb+ogPlARBXSsP5NrymrM9jGkf4ZsRSIfRH6s8bG0/6/aFBT3HrTA58oFFiQF368
        /pAoCQ+WK6cxJA==
X-ME-Sender: <xms:4MPZYP0Lj1y83jqNOEqOFR7G9OfHYa0D_xIPzRXKMFr6uLCNRqqOfQ>
    <xme:4MPZYOGE36hm-u_elxfMPIqLfm2hkKwotewUoI38he6DC8hcHDDnCDZFr2YVgLhKi
    SVQJqabNp-7e2AscbY>
X-ME-Received: <xmr:4MPZYP4RWk06XDP3j9y3M23Ak7Bvn3H1Sm81sFRZC0y-rrUidF2LOETKUT5tAc2iduSpvtZqEDwKok6DwHNlWTLKrzQTvgVIgDuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:4MPZYE1Jj_oEs9DwjIjbrmIbY-4T-vbVyFblCZDMtMBkSE6P6ENIeg>
    <xmx:4MPZYCEoHQDwy46xFeb94b0cKBQ1mMmuleXZHQVGQ6U75riWwXvQqA>
    <xmx:4MPZYF9YylsPKBSJm_W3FmTB1HIKnTyMzqv_78AVA8TXqYmJzX7F9Q>
    <xmx:4MPZYAEESTBfEij02xIEzHZ7G_V0a13i9uKkQArrZnYVHoq7FCRmgA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 08:43:11 -0400 (EDT)
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
Subject: [PATCH v5 06/10] drm/vc4: crtc: Add some logging
Date:   Mon, 28 Jun 2021 14:42:53 +0200
Message-Id: <20210628124257.140453-7-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628124257.140453-1-maxime@cerno.tech>
References: <20210628124257.140453-1-maxime@cerno.tech>
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
index c88ce31ec90f..073b7e528175 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -524,6 +524,9 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, old_state);
 	struct drm_device *dev = crtc->dev;
 
+	drm_dbg(dev, "Disabling CRTC %s (%u) connected to Encoder %s (%u)",
+		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
+
 	require_hvs_enabled(dev);
 
 	/* Disable vblank irq handling before crtc is disabled. */
@@ -555,6 +558,9 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, new_state);
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 
+	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)",
+		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
+
 	require_hvs_enabled(dev);
 
 	/* Enable vblank irq handling before crtc is started otherwise
-- 
2.31.1

