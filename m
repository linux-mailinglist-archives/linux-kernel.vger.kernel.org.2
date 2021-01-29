Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1BB308D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhA2TRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhA2TPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:15:55 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E795FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:15:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id g3so14589965ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cTTnr27KoTM28FV0WElzZDWAloMkTnxUWGWEMvKemNI=;
        b=ouQ+OYCAbmjkG53A7Kh9AhOxgW8pp1Iv/SjpwRKr7JmCh0A+0lDEOPbQFrdVqXpBTq
         5i2aI9UnG+DPOXfhCI/549NPsIooiCAtXcSl1eqcifWU4tVP0DIOwOUHLpi/g/JskLJb
         NY2c73SBJbKOpSmYE8uyb5adVwkhXZzIo3i27wREi/buvNY/3S/DzchR6TRPqyQ2mRyZ
         koQt8L6fkArnOurp4i+FhnW91CBXODvd4NdtUY2GlZKCSarMPEIo1JpZYOX9bzjRV2Vx
         2IOCj8lC1mMMiiQ5DJmflWgPAzVn3A/yNFhBFXxj/I5F8Yz6jKS0LbWaHyliMdqof2qo
         FZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cTTnr27KoTM28FV0WElzZDWAloMkTnxUWGWEMvKemNI=;
        b=PL4cZZE5LpK5a5YiBNRiC9Zb6/ml9BTEINDkUox9AIMlm8PzsKPrfrlhcfF45eWbqH
         mSqtthy1zDyESqIL6UjaKTrHTSc3dHZosjEDtRw6wgNMVsmh9GLuQHxVDsozHkbmHbAG
         VGfqIsgbQAke+8HwuE7ar99Tn5faN1NF5l8OghppwDXx+Or+WyEPbGIqGawdgTwjPO9L
         yQA13PpjPEhzuWSwhFEcwhWAz1IIrK+rwqhYqQNgtK/DAF6V7EVmp14U5mzURUWJ0Kue
         f4B2l7Ixh4jAIAJqnjmNE8jxT/rYdlGk9LnWImruTqZ4i4q2vOsQg9VDzfT5ZwRrYq3G
         7tXw==
X-Gm-Message-State: AOAM532odmELhaL4jl2PcnxiyHY6DKgMh795fP+j7uMmjFiR18PZKUZh
        p1/jOL9tsW7TfYy3eZ3ZwuX7NkYgOflGQQ==
X-Google-Smtp-Source: ABdhPJyFygyhSHIzBZV3gEcgJcHYnrJ2+Tij4oZM5edb+/sG2By82GcdMNxrbsd8BJGXHxK9uvyJtA==
X-Received: by 2002:a17:906:1741:: with SMTP id d1mr6278342eje.182.1611947712598;
        Fri, 29 Jan 2021 11:15:12 -0800 (PST)
Received: from localhost (ipv6-4a6ad23dae79b927.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:4a6a:d23d:ae79:b927])
        by smtp.gmail.com with ESMTPSA id x16sm4273139ejc.22.2021.01.29.11.15.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2021 11:15:11 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     thierry.reding@gmail.com
Cc:     oliver.graute@gmail.com, Marco Felsch <m.felsch@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel: simple: add SGD GKTW70SDAD1SD
Date:   Fri, 29 Jan 2021 20:09:23 +0100
Message-Id: <1611947364-30688-1-git-send-email-oliver.graute@gmail.com>
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
Cc: Marco Felsch <m.felsch@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
---

v2:

- changed bpc to 6
- set max value of pixelclock
- increased hfront_porch and hback_porch
- dropped connector-type

adding of bus_format = MEDIA_BUS_FMT_RGB666_1X18 results in wrong colors.
omitting bus_format and using some default is good (Tux Pinguin is colored
fine)

 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 2be358f..c129a8c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3336,6 +3336,28 @@ static const struct panel_desc satoz_sat050at40h12r2 = {
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
+};
+
 static const struct drm_display_mode sharp_ld_d5116z01b_mode = {
 	.clock = 168480,
 	.hdisplay = 1920,
@@ -4222,6 +4244,9 @@ static const struct of_device_id platform_of_match[] = {
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

