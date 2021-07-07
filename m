Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8133BE4A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhGGIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:51:06 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:34793 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231253AbhGGIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:51:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id BD0812B00942;
        Wed,  7 Jul 2021 04:48:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 07 Jul 2021 04:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=qKryS3vajFu2P
        Y4aqey6jlrzQB/c3ydj21xQAaHr050=; b=rRxwKpplj+A+xWKVXx9UcTDaHvq0K
        1G3sC6k+tkBARhdo0b6lE0j2D9DrbQ4a6SXA7wu/hIe9egNBgVoYT60Lb/lGsvyk
        Gm5q4k9VlIbzfx1YW1zepCzCc9i1lXInekZSG/ZNpKzw9BYlUpwY35+XMxK6+K9R
        yv1/gyO6pimA+I4AaccJSyhwKPm3FryQchEC8JJyWf4kMHGOIBd5M1/DDhy9/Ktt
        bzq/kLGG4av6sQhnWz/TbkTDvm1FkR2p7X8Vc7XdpD7PARZ8BhKnMWvPM/RWFBuw
        G7EgxMRwgQqxWefCuB1iBgeDvuHnH3d1UsntvcgMuIMwzTeovqo3wuzew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=qKryS3vajFu2PY4aqey6jlrzQB/c3ydj21xQAaHr050=; b=uByIghg9
        FgWE8sN45XWA5PZHn360dOk2gpYq4c7keKrsCdz5Kz7JibMbZIidNEf4D/ICEiMh
        +r8tsLbTIU7eUssSlZH3XsEYvp2opBoDzZllxjI1R/xj+dKFiZy5vWzkj1LL/NZ/
        Vr5RSPjqpC7bE/VKa0BW+OKDGa/jOtvVN5p1z9+gOxxngFoY8Hloxvo7ueWgDrcL
        UKnNaeIR7/6jhd2DIFfdhuSZV7gh0dnAxz5AEDwkMgcx5g0snu356TzsdAkxAN/P
        mVU6ZsaXPkVL2aqUW48aYz9iFpo2BeBOpcsZed8C7huMhLwQo/ckbNb1OVDRqS9f
        0U0Rf0PW68V9tQ==
X-ME-Sender: <xms:VGrlYMbyHGt-wG3S2xJUtq48XvOfy1kP_XDCKi5ZFxr99aPVkBHhjA>
    <xme:VGrlYHZe72d0azUW6GIhza8rScHNNaVkTMv5EosQbRuLEe4bnxNstq2RUlDrMQDFv
    aSwK2mrPzG-YyLSC8k>
X-ME-Received: <xmr:VGrlYG-U8a8ukQ0OQ57YvVnK5V0ZFAWb5i_6c_aYXFfSt1IOam8ARkxWnBh4PpoHOXhkoZxYKNK_MI3dpoZ7K2N-ARPfMHmgyRO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:VGrlYGpZb1IXQZcfIhl7i3iwhMpkoD_UTl_6nFWE8mFL61M-YCbjPQ>
    <xmx:VGrlYHoSurnrd-j6xOV7klcunwi3ebZoedzcRmY9bkiX3U2J9OjJBQ>
    <xmx:VGrlYEQWMpaNcAWW33IVGC9HiLaBuiSO9OvxN7aPladg9qtgCOkpZA>
    <xmx:VGrlYCAHTKJuEDW4Nk8cApZtbDeP3lxcOdrUytzlf-OnPWbrNUF47YS4JKI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jul 2021 04:48:19 -0400 (EDT)
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
Subject: [PATCH v6 08/10] drm/vc4: hdmi: Raise the maximum clock rate
Date:   Wed,  7 Jul 2021 10:47:43 +0200
Message-Id: <20210707084745.1365390-9-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707084745.1365390-1-maxime@cerno.tech>
References: <20210707084745.1365390-1-maxime@cerno.tech>
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
index eada68b65402..40f995c43376 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2282,7 +2282,7 @@ static const struct vc4_hdmi_variant bcm2711_hdmi0_variant = {
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

