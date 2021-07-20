Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523F13CFB71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhGTNQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:16:32 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:55573 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238788AbhGTNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:05:29 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 2F1FC2B0090F;
        Tue, 20 Jul 2021 09:46:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 20 Jul 2021 09:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Oi467eD63Wjwp
        FoHKx4z3s/qo/NOlxbPHqYAVB8BXxs=; b=KiwjgczlrUV+JYgkxXE7dSb/3Sbg/
        KbjMo96pTzKlNzuf+58JPZyQKX6tiTbNHk93MYDkiC9/ZJrBOS0BRZPrOjnJrFSc
        zwaPIEubV+K3slQnMWV1v9oDn+n9mywEX2SHVfz62nTjU6nti1Gj6RSoUmD09v91
        KxvuMrz+dsJzJ73NPat3eGROaCx+6uMiuxnhQGt1aaqdaph9jyxt0T0Gz7++iH/G
        6zBR7fYm38gtEvsyCU0KAxsCQGi9RKUrTYL1t0wKN4WKVTeSRM44dVO334SyQmSm
        Yucy/2Lq9tlfu+thvg+Tn7BbikcfPEaaIUEHtFDmIVL9oWpAaYXjaC5lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Oi467eD63WjwpFoHKx4z3s/qo/NOlxbPHqYAVB8BXxs=; b=tXcZj+Pl
        +r2whY8MXq03BPU/MPJFMQfa7Pu31Po76+bn79SCB1vSTPVqE/4tzaU0WwyPylYF
        AIJE1n9Nhtttos9JqAdxCtwZSQAU1z+N6Zl3kpYmZC31ktLykPvDp0DqSzN8FplC
        tIvXsRnHz+GTekCVBWLMR/xWVcagbaJW5IFXZPYiWdamN/1g3dqX9yYIr9IuFX5p
        ugNMZOp8Bv+WRYF3KulVcfQSzwYrG34PUcU3+Bvh2vnJxbX0gD/myRni7w5GkHm6
        zwUnfRuRTh32GQUdRmdiW3TzClcsuC3D8DSi8ndDCRTz+ClhA6IOXm3tHwZQ2NiX
        /hcVX5cLoQHA1A==
X-ME-Sender: <xms:nNP2YOtn9eGk8xdFr_onVuh-5UU8O_nophByvbeSA1aGYQn4X8mq_A>
    <xme:nNP2YDd9dI-8D0RWFOAPoa7uCb8WZf6FshrDP71Q7uicljT8nKX9BMdCE4snPCaGq
    cAZWHNeuWZATb5OFa8>
X-ME-Received: <xmr:nNP2YJwSLdXhohTv4pvD-dbSTbqr80h6j7samBFGzVEtFnuVMogfQtkgXHnA3X1sJkqd0bIuhJXZ1uI1cgyPrBMdAD77yJwn4JAt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nNP2YJOAnPfyT1rVQWj7H_qw0E7igVoHCO79lOHDZvd-o8cCWrrWag>
    <xmx:nNP2YO-U7kbCVrXLoSwJ61nDqThhefDCbgaQePHVReemLdmXqb0ARg>
    <xmx:nNP2YBXAnpxhr2rRj2cgSBE_OBCqvcmumNRNx2vwRWaQ4r6tt9gz_w>
    <xmx:ntP2YAeNl-QymUyB_AO5v4ewtlXGE9ck8DwReREbaJjzLf_OqDjTKzKAf_w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:04 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] drm/panel: raspberrypi-touchscreen: Prevent double-free
Date:   Tue, 20 Jul 2021 15:45:23 +0200
Message-Id: <20210720134525.563936-9-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720134525.563936-1-maxime@cerno.tech>
References: <20210720134525.563936-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mipi_dsi_device allocated by mipi_dsi_device_register_full() is
already free'd on release.

Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touchscreen.")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 6f2ce3b81f47..462faae0f446 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -447,7 +447,6 @@ static int rpi_touchscreen_remove(struct i2c_client *i2c)
 	drm_panel_remove(&ts->base);
 
 	mipi_dsi_device_unregister(ts->dsi);
-	kfree(ts->dsi);
 
 	return 0;
 }
-- 
2.31.1

