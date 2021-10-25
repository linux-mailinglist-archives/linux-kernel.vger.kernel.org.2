Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D19439A88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhJYPcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:32:06 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:33873 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233867AbhJYPbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:31:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9EB395806D5;
        Mon, 25 Oct 2021 11:29:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Oct 2021 11:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=bcImPUUCZRnod
        a8rkq5E0JntKhmq7ioUCtF9FNNBE3Y=; b=S8RHEphe3mYxRtP1G5k+uzMCi61d2
        dHbMhxuABOJ04n8IsL4Ph1xIBsJjgNB5NwDV4hE/4R/nTBzRJnjacB3Xq369ZLFB
        5qFpcPd5SEv8FpPO7AI/2K6aMKKV0sZkmlBlLBAzztvdoCfQKaBCW2SuXl5pDv6+
        i2zZkizd4vOUrjsZAa/nh67lbmxUHsyleHsHVXLYfT4lEXrtjKf3JunfwRCzFkhP
        KaRCDB4aTiRhKcm0PY5aiupS2bazUv+fMKyXH72JwIM3TL4pJxryySk+fVjUpFHS
        qW7H1O7SUxoE/Se1U/WrUuKxOW7P9Xyii+K96mcaBsIoDwLlfNk5txvAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=bcImPUUCZRnoda8rkq5E0JntKhmq7ioUCtF9FNNBE3Y=; b=c5vUttwz
        r1dYO2XbdaBV0kb/erJUDaZ+7/4F76qqdoQuRV5WEmGZXi04LgyUmFccfLrhI326
        KNAFFKpLKvfns0HuzSAmQVF4kWOcsjxGdV6i6e77imyCuNPB5ZsuI7ay9oC4y0kz
        gzvtlrlUpl8OhpbfwRj6WplzVR8MLLlkQeh9Sq8MhrZsLelJIb7Oe1+Es+4jpQQG
        WZ9qt7qOKRu6WllXFX9H9wSzdFhlJArXaF37ZcOZd4RIJThbBJU0bB0KZYfRMYeT
        nVAKyy3aTrj+Knz4Z1ajBI5mPF155fE74aClu3hAUIz4IXtmQsSsF6ponZ9HlT4w
        ZwvCBnQoLaBFig==
X-ME-Sender: <xms:U812Yajh1SBPtWxiWNtViBOV4dvdtVRtq2UKE04XU-oWpqTh28mvpg>
    <xme:U812YbAgpCJvSdR-hXuxVu4p2GQAjvlIpYXcLJmvi316hDIxSPqDW5BeOPXJv9ogF
    NFzO6HzFl9ZYODVSCA>
X-ME-Received: <xmr:U812YSFj4O5lkMDUSdI8FegyJ4sxVRITbe0iGsFvgt9YcdD4Z0LlS_gOoMZ-jfh_1-N5BIjhPFPj-dLqOS-fMUMjvbiMstWv2BKtATbR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:U812YTRH6ZPOLy6jsRKVYyKtyLB-TlQPinamcEvBjoDwRs2bN-VEGw>
    <xmx:U812YXzNf4i2sAHbHwAp6jX8ZGVcyGHy3Cve8QZGC3O_O35YYl-yYg>
    <xmx:U812YR6CPmiwmMKhnM-6E6k4idG5PxBzXy-_61ANQsm175BRZ1ldUg>
    <xmx:VM12YcK8r2lU9QZsGP9lgDgV6ByBwh4Pnz6SySdR_vaLffx_fKYRUw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 11:29:23 -0400 (EDT)
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
Subject: [PATCH v8 08/10] drm/vc4: hdmi: Raise the maximum clock rate
Date:   Mon, 25 Oct 2021 17:29:01 +0200
Message-Id: <20211025152903.1088803-9-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025152903.1088803-1-maxime@cerno.tech>
References: <20211025152903.1088803-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the infrastructure in place, we can raise the maximum
pixel rate we can reach for HDMI0 on the BCM2711.

HDMI1 is left untouched since its pixelvalve has a smaller FIFO and
would need a clock faster than what we can provide to support the same
modes.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index dde67b991ae7..d36b3b6ebed1 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2706,7 +2706,7 @@ static const struct vc4_hdmi_variant bcm2711_hdmi0_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi0_regs",
 	.card_name		= "vc4-hdmi-0",
-	.max_pixel_clock	= HDMI_14_MAX_TMDS_CLK,
+	.max_pixel_clock	= 600000000,
 	.registers		= vc5_hdmi_hdmi0_fields,
 	.num_registers		= ARRAY_SIZE(vc5_hdmi_hdmi0_fields),
 	.phy_lane_mapping	= {
-- 
2.31.1

