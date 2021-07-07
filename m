Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98B63BE4A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhGGIvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:51:01 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:38973 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231253AbhGGIuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:50:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 13C0B2B00940;
        Wed,  7 Jul 2021 04:48:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 07 Jul 2021 04:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=QYwjYbERT0K9u
        SYo01fONKt0VxIOtLUAbN9O7B83ar8=; b=XjlGzop5eXhL7RyQ8Hl1dl8nMtal5
        4sYQROFIC2B1IcSs+bCE/hoZtpvJsMkRToR0eh+81egNnhEkp/9LUNmwBSrZmx31
        JdqjRkLX4mTVd4aLJ9EfLr8WLAHl2rCYAOoheJtB2SwkfLc+8QMlZPyTfpqXyFCb
        GDLoPERm9pyZJQtVq8OlYSzV13MCNy7xlZsd7BnPqwziaacRIoB1xgFRQCJRJxDZ
        cp5vkHbdynE/NXKg2eyi5BROyqCSiN0Gp2fEVOFjHhzZDPkSbm697a1iQmMx3kh8
        p5JdUHjnRr8nQM84sDoTCQBtOwAMn4R4uBZXkHni1tG6H/Xk98RLJ/A8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=QYwjYbERT0K9uSYo01fONKt0VxIOtLUAbN9O7B83ar8=; b=TCmULdeT
        kLSJqBa3EKJxBijlna7jl+SxdNpwVEiJIUFXfUK3M7N1vF9KcBEoN40n5EREwb0S
        8tKa099NcP1Cf8bpGaQ/07q6K2uz9qA7LPTPS3HmRQ16lUN8G+JIGLSV2wjdTcLw
        sD3OjYhWvp6EXhRIroeYBEUPSfz0N+0Jh04CAL4IzShV5KIqkSCeaX8SE8aHnDvW
        cNwNyWOtIciE4nbDHwvKI4y7ISsaH70Jb3x6LNEns3VosSzgG3a6LPMAA/ReCtTf
        rMwt3okvTPRQ9UVaLwlZqE3Nkp/eYs4Yd6h8l0F14Rzx3fFmetO8kLUX5yBGf7Dp
        +UuN0/DZcy2uxQ==
X-ME-Sender: <xms:TWrlYLlD5sKWZ2e3zVKiBYQ25PtMphF0uOJtdhDeMg1ZBGYwnJESPw>
    <xme:TWrlYO0nZQFK9JlJDh8fIhLWramdp9_i3aN4LHijchGpzmVigrE0LeI54FXt75dOx
    zzQvaMscPcU2ZLWfqY>
X-ME-Received: <xmr:TWrlYBpGzcUjrRUGz2hPXFTUObMZARA4NfU1M92K00-XRVZa2r7NAeqMqnV2qQYdEmNDK9crBrTTsSO-f4WWdjJTx3XYIzX1MN6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddvgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:TWrlYDmhPRapFyUzxGuH6IfHcLTQ2hN72R6aYAK-Eztj7KqL3RLr8w>
    <xmx:TWrlYJ2f5iGytuf0Y3tFlzhvDC0yObtd1-sJmPPSioc8HRfDuLaBXg>
    <xmx:TWrlYCugO25qlEJL2vHkHzFDkih_tqroczPM874lLpppISb1JS7DjQ>
    <xmx:TWrlYDMeUdsupIUbI5DGNcws-VN7nYufeeV8gHH6cPWduOvnf29kd8YvNUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jul 2021 04:48:12 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Emma Anholt <emma@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/10] drm/vc4: crtc: Add some logging
Date:   Wed,  7 Jul 2021 10:47:41 +0200
Message-Id: <20210707084745.1365390-7-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707084745.1365390-1-maxime@cerno.tech>
References: <20210707084745.1365390-1-maxime@cerno.tech>
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

