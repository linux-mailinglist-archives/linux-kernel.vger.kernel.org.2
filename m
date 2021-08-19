Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0986B3F16A7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhHSJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:52:09 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36421 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhHSJwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:52:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 74AC2580B72;
        Thu, 19 Aug 2021 05:51:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 05:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ecXNfImXusamK
        Kz0RBATuvc9/gs4tk2HApsZdCCCSkw=; b=kmKAZtq4D+ldAkkM0Ur632orf5Cgc
        ZaO5ptVl9pwSjKi7riTQUoAAufEbE02CUbMO39kPIGiuJCJ0TAJTAM0Uy+ZKBP5N
        cwudIXDVssqPi4f9YyKQZmplbtxYqMgemU3gb/6Lf7HtDd8rteL01/GlFNfEtbIw
        STV7xLWsYqlfKf37TQgqvIRJmg1UZAsjnm5XtCXIW2bBEizFLj51oEjr3W3zr6KP
        SNuxyS7q5VSNwY/x4iO2d1MWCm/+lSRsm4iBuJJUFvqlbK4yKu6eG/N2aVP072+U
        97/aKRcma7XQkz1K0CIyCMMADwSZtgEwZGvGbCPAiJcq0cOaE5N1YPiwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ecXNfImXusamKKz0RBATuvc9/gs4tk2HApsZdCCCSkw=; b=PDK5NtuA
        bP4miMdr/zHSUDmIVZ8K3iy/G2Ozh3wyYqFTgvdtbSPF2zGG44giCWopRQTiLqg3
        bqj9K8rXFJAiYuglC+k2eVERlobl3BIkE5pwdwok5NCkfzuFgiH4NcEhSxYP4OT0
        GH7h1O8nt9V2YQk8J5YbeGFIJmRG03+WR6FY4Go7wJjWQMD3++Z3jBxIcDkXnkwa
        sCKrrokC/3nJFF8YWJwaNDYaDfKPw3MXkGDKnTyi4dbttVtnXg36qtR5lnItPz4d
        PzrBQXjkQny0tvcJAUDCqejgN2OZxEAKund+gGQWQd1HlBhkkbvNa0WPhGIUzHss
        UPDlzPAJinM/xw==
X-ME-Sender: <xms:nikeYRy8y9XDCV8zC4HHLSr-U4Ysi-Ivr4xKxVtAIxi_EfY_ebtQ0w>
    <xme:nikeYRRchgzI4_dzeQp7jtVGxZteKAGIEzoHFuzqUpIBx5zEN5_fIBVRqhPObDjUj
    AqnqjSN8U5DSy6wXJs>
X-ME-Received: <xmr:nikeYbWEvz3oY6oDOlTY3oM_pQ9bnsNR9l0oLnxEMteiphlJfUHkHQz6UGNylGc-_7x82wzIUSuwz-PuefSPDRBn9in99E5RhyfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nikeYTiLhe181mklb3cJAlfEPjAXsFtKzFZFGRWwFE_r2fiVHdpuXQ>
    <xmx:nikeYTBb1EBPytQZg57RH2Ia4Esgedj2HgjImiJGd8sW5UKfkqo2aQ>
    <xmx:nikeYcKPfpUhhqlL239rR3ok_OFNq3xX3hZa5vW7FBbMDiV5-jQWjw>
    <xmx:oCkeYbYWmhzFA5MNfJhb_sWaxKNjIUgdCtv9ArRzippTHIw19y3q1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 05:51:26 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <mripard@kernel.org>, Emma Anholt <emma@anholt.net>,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v7 01/10] drm/vc4: hdmi: Remove the DDC probing for status detection
Date:   Thu, 19 Aug 2021 11:51:10 +0200
Message-Id: <20210819095119.689945-2-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819095119.689945-1-maxime@cerno.tech>
References: <20210819095119.689945-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9d44abbbb8d5 ("drm/vc4: Fall back to using an EDID probe in the
absence of a GPIO.") added some code to read the EDID through DDC in the
HDMI driver detect hook since the Pi3 had no HPD GPIO back then.
However, commit b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of
Expander") changed that a couple of years later.

This causes an issue though since some TV (like the LG 55C8) when it
comes out of standy will deassert the HPD line, but the EDID will
remain readable.

It causes an issues nn platforms without an HPD GPIO, like the Pi4,
where the DDC probing will be our primary mean to detect a display, and
thus we will never detect the HPD pulse. This was fine before since the
pulse was small enough that we would never detect it, and we also didn't
have anything (like the scrambler) that needed to be set up in the
display.

However, now that we have both, the display during the HPD pulse will
clear its scrambler status, and since we won't detect the
disconnect/reconnect cycle we will never enable the scrambler back.

As our main reason for that DDC probing is gone, let's just remove it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index b7dc32a0c9bb..f9a672a641ab 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -172,8 +172,6 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	if (vc4_hdmi->hpd_gpio &&
 	    gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio)) {
 		connected = true;
-	} else if (drm_probe_ddc(vc4_hdmi->ddc)) {
-		connected = true;
 	} else if (HDMI_READ(HDMI_HOTPLUG) & VC4_HDMI_HOTPLUG_CONNECTED) {
 		connected = true;
 	}
-- 
2.31.1

