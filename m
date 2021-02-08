Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EF313EA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhBHTPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbhBHR4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:56:54 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C16C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:56:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jj19so26388622ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eIvRill5LnmjWkouRCFhqrQjOtTIYxe1H69dV2Y1RJo=;
        b=Z+8ub28Zc877Pt3iUCoMvDNPaJsrXh10MSL/Htr5fZnmT9sDqNYGWIA92NYP8wUkwG
         6sUQ5mjKsmbtW3q1hgNLs4kkdiatEzj3ViGcu+C66NedPgM3ZHzLFTsR7m/JzicFZfZr
         ZfTaxMCILPGJT0TfA1QnKj1piYN02qr78DMVTKVx3+vw9tNR3nHPXIDGZjO/riotJPGA
         0Dp0RiNeBw0VxvgEOgdDU8IVFlhmAGjh+B83Lsnxw+dxPaou8sqYsf7fTHIyc2OeNf0V
         ProGLWe3MaVH8aj/VrocXxi/I2X99APsROzCEMHbzkv3u+KB3aUT/JoaZgiGkUov+NRJ
         vvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eIvRill5LnmjWkouRCFhqrQjOtTIYxe1H69dV2Y1RJo=;
        b=q9C5hsbmimpyg88Vcsgylz2EDnwg8fXGZEM1CwtuuU6fDcrhQrwDUZ37LQUr+4bGhS
         dz8yBNbaAJh1TA0nsX6PJLgijSaSHXnxR8lu8JDdqygca++QXeNyoX1oB9NIYKuqzGPT
         7J2PCUeSUytFJyjVSS9tF0191aBFVpPKB3enfKFVc+SX2divnMHzB0zWp+wIcee5D2oA
         Z2/hm+oGcLI5/em6RbjApkPy+qwbLk7oS8w9w2rEXoqEsaFRZ+a+RdOxjiBeMXMelwwu
         X2q3WcICiWe8mRMt2Wn9lrQsYzZJnUZQwLNfpYnqpYciZIAICKhY6OUrxJmOFObcFzj7
         pHBA==
X-Gm-Message-State: AOAM530T4BkWwYOVLlNle1V7vMUfTvF0gqLpq8k5dd5VeZxQ2d+1uhHq
        fWdEUzoUyxxsZm2h70Oq7c/cD/p5Om0oeA==
X-Google-Smtp-Source: ABdhPJxVjghMsHAgz3SHuB2JxQEmEp2rDupvZv4O3wJGYmCO9N3ol3mc8yYNf4U9NkufmFR9PuJ7qA==
X-Received: by 2002:a17:907:770d:: with SMTP id kw13mr10452650ejc.219.1612806971864;
        Mon, 08 Feb 2021 09:56:11 -0800 (PST)
Received: from localhost (ipv6-8b5f7baafbe9cd6e.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:8b5f:7baa:fbe9:cd6e])
        by smtp.gmail.com with ESMTPSA id p15sm9020856eja.61.2021.02.08.09.56.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 09:56:10 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     thierry.reding@gmail.com
Cc:     m.felsch@pengutronix.de, festevam@gmail.com,
        Oliver Graute <oliver.graute@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/panel: simple: add SGD GKTW70SDAD1SD
Date:   Mon,  8 Feb 2021 18:53:04 +0100
Message-Id: <1612806785-12464-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Patchwork-Bot: notify
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
to panel-simple.

The panel spec from Variscite can be found at:
https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---

v4:

- added the datasheet labels
- added Reviewed-by

v3:

- added flags
- added delay

v2:

- changed bpc to 6
- set max value of pixelclock
- increased hfront_porch and hback_porch
- dropped connector-type

adding of bus_format = MEDIA_BUS_FMT_RGB666_1X18 results in wrong colors.
omitting bus_format and using some default is better (Tux Pinguin is colored
fine)

 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 2be358f..c63f6a8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3336,6 +3336,36 @@ static const struct panel_desc satoz_sat050at40h12r2 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing sgd_gktw70sdad1sd_timing = {
+	.pixelclock = {30000000, 30000000, 40000000},
+	.hactive = { 800, 800, 800},
+	.hfront_porch = {40, 40, 40},
+	.hback_porch = {40, 40, 40},
+	.hsync_len = {48, 48, 48},
+	.vactive = {480, 480, 480},
+	.vfront_porch = {13, 13, 13},
+	.vback_porch = {29, 29, 29},
+	.vsync_len = {3, 3, 3},
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+			DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
+};
+
+static const struct panel_desc sgd_gktw70sdad1sd = {
+	.timings = &sgd_gktw70sdad1sd_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 153,
+		.height = 86,
+	},
+	.delay = {
+		.prepare = 20 + 20 + 10 + 10, /* T0 + T2 + T3 + T4 */
+		.enable = 50, /* T5 */
+		.disable = 50, /* T5 */
+		.unprepare =  10 + 10 + 20 + 20, /* T4 + T3 + T2 + T0 */
+	},
+};
+
 static const struct drm_display_mode sharp_ld_d5116z01b_mode = {
 	.clock = 168480,
 	.hdisplay = 1920,
@@ -4222,6 +4252,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "satoz,sat050at40h12r2",
 		.data = &satoz_sat050at40h12r2,
 	}, {
+		.compatible = "sgd,gktw70sdad1sd",
+		.data = &sgd_gktw70sdad1sd,
+	}, {
 		.compatible = "sharp,ld-d5116z01b",
 		.data = &sharp_ld_d5116z01b,
 	}, {
-- 
2.7.4

