Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1170446DFE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 14:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhKFNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhKFNDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 09:03:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE1C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 06:00:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t30so18070760wra.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8wHab6566qURbj642hZQhjoNEVpnY3BwaarHDvq0L0=;
        b=XND+wSBUuPYLMgjewQQ+ZfunYmZNgCh8WWfsCXD0+PsOEDkfOKExouoH06ea4qyP2R
         FB0MqJKNiVp76AcUeWDBaFrBCmucksujIKNWtlWQ5+zBIpYORG52udyGka7M2ZFGQ76q
         V0TcnCJwJfirAXNGLwFVEV69RebWVhDKwLPb16UmV4cHYfZyD5rlCkOq6mgP84tWVzDS
         X1LtVHIqZogdb3d9gwGkK3v1bmpVRt2HQaxrtf9Uqfp6EXssJtqwuhO+gWxqd0KOkYIb
         YCVFhO33SLioM8xwNMnieu74NedU5n2fWXbBeTBYVWLTmxv/YQ6ZO8EBkmez93iCZFGO
         03Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8wHab6566qURbj642hZQhjoNEVpnY3BwaarHDvq0L0=;
        b=v6/1I3qTOAheAmKgq9apaFHPJV3oLtdTwxhYFxG0t4pHrwPZeEIQTJIxDR83YXQZXw
         VwN4OP0pG0XXuPREbG6R/igeU5YfDJyyLbZ3UnLh/JmWBbTCAKmynv7xg6tV/4L5u0+H
         e+s3DmjwtUgLYuwgeqgJnOgGvo5XZ/VI+kMhA/s/z4ouM9IKBUdbxUAA3ArqXpsZNdIQ
         LpWMW/aErAyEhTTTWGh6JM1IQhtNlL+oftgZNLdyVQwu4u8yE4+oS3p0Xd/wPOl75GgZ
         J8mnBtbgBBS4sWTukLFi18Ff5J5OAwlxOf+1j8N9QBn0gy4pIiMR8JuHWXo2Ym1nYE6Q
         6b3g==
X-Gm-Message-State: AOAM532YHLCAgiO5HQD6Bke1sgLaXNOKenYgRXpcSxMZPbgn1qUIuAqa
        HfTc3q3Uqck1eUz9m7Ob4A==
X-Google-Smtp-Source: ABdhPJw/FzXBTpUJ4P9/xdnyrcrIhUJIRVvdOeNvjS5d8P59c56FmQdYXt8IzHbi1eD/sZhPdkltdg==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr59891089wrp.103.1636203651372;
        Sat, 06 Nov 2021 06:00:51 -0700 (PDT)
Received: from alex-ThinkPad-E480.. (ip5b435a69.dynamic.kabel-deutschland.de. [91.67.90.105])
        by smtp.googlemail.com with ESMTPSA id h27sm15786674wmc.43.2021.11.06.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 06:00:51 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] drm: bridge: dw-hdmi: Fix RGB to YUV color space conversion
Date:   Sat,  6 Nov 2021 14:00:44 +0100
Message-Id: <20211106130044.63483-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per CEA-861 quantization range is always limited in case of YUV
output - indepentently which CEA mode it is or if it is an DMT mode.

This is already correctly setup in HDMI AVI inforame, but we always do
a RGB to YUV conversion which doesn't consider that RGB input can be
full range as well.
That leads to incorrect colors for all CEA modes except mode 1 for HDMI
and always for DVI.

To fix this, provide additional csc coefficents for converting from RGB
full range to EITU601/EITU709 limited range and rename the existing
arrays to clarify their meaning.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 62ae63565d3a..1cba08b70091 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -80,13 +80,25 @@ static const u16 csc_coeff_rgb_out_eitu709[3][4] = {
 	{ 0x2000, 0x0000, 0x3b61, 0x7e25 }
 };
 
-static const u16 csc_coeff_rgb_in_eitu601[3][4] = {
+static const u16 csc_coeff_rgb_full_in_eitu601[3][4] = {
+	{ 0x2044, 0x106f, 0x0644, 0x0040 },
+	{ 0xe677, 0x1c1c, 0xfd46, 0x0200 },
+	{ 0xed60, 0xf685, 0x1c1c, 0x0200 }
+};
+
+static const u16 csc_coeff_rgb_limited_in_eitu601[3][4] = {
 	{ 0x2591, 0x1322, 0x074b, 0x0000 },
 	{ 0x6535, 0x2000, 0x7acc, 0x0200 },
 	{ 0x6acd, 0x7534, 0x2000, 0x0200 }
 };
 
-static const u16 csc_coeff_rgb_in_eitu709[3][4] = {
+static const u16 csc_coeff_rgb_full_in_eitu709[3][4] = {
+	{ 0x2750, 0x0baf, 0x03f8, 0x0040 },
+	{ 0xe677, 0x1c1c, 0xfd6d, 0x0200 },
+	{ 0xea55, 0xf98f, 0x1c1c, 0x0200 }
+};
+
+static const u16 csc_coeff_rgb_limted_in_eitu709[3][4] = {
 	{ 0x2dc5, 0x0d9b, 0x049e, 0x0000 },
 	{ 0x62f0, 0x2000, 0x7d11, 0x0200 },
 	{ 0x6756, 0x78ab, 0x2000, 0x0200 }
@@ -1023,9 +1035,13 @@ static void dw_hdmi_update_csc_coeffs(struct dw_hdmi *hdmi)
 			csc_coeff = &csc_coeff_rgb_out_eitu709;
 	} else if (is_input_rgb && !is_output_rgb) {
 		if (hdmi->hdmi_data.enc_out_encoding == V4L2_YCBCR_ENC_601)
-			csc_coeff = &csc_coeff_rgb_in_eitu601;
+			csc_coeff = hdmi->hdmi_data.rgb_limited_range
+				? &csc_coeff_rgb_limited_in_eitu601
+				: &csc_coeff_rgb_full_in_eitu601;
 		else
-			csc_coeff = &csc_coeff_rgb_in_eitu709;
+			csc_coeff = hdmi->hdmi_data.rgb_limited_range
+				? &csc_coeff_rgb_limted_in_eitu709
+				: &csc_coeff_rgb_full_in_eitu709;
 		csc_scale = 0;
 	} else if (is_input_rgb && is_output_rgb &&
 		   hdmi->hdmi_data.rgb_limited_range) {

base-commit: 89636a06fa2ee7826a19c39c19a9bc99ab9340a9
-- 
2.30.2

