Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AFA362B82
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhDPWm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhDPWli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E833C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lt13so5918904pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDe1MXJmAaYPVB+3IXfqjGW37xK+xCJdqcyZAHEPidk=;
        b=KWfqj0ACbYfw5nTP+fIaVlC9b2gMX+VrrUP+qLnpXthwm14bl/ukKUPYjJlfuhPHl9
         F+dd7eA+MCFJRp1SU7zCty8Gq0UZIgrmvHm6gaNJgh18GkrmjQ4WmZcYdLtZJEsnNNwc
         Nq3XkhXdgaxHCrS+5UuFVZSHW0YJMhMoRSg9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDe1MXJmAaYPVB+3IXfqjGW37xK+xCJdqcyZAHEPidk=;
        b=bmlL0Kl/F/8q9v2FtEHLW2+RjqoQbR4YVepUiCtVrfyNLzGQhgR9+VbKJWM7qwF5Gf
         YCtTgiE9y/Q+7uH3Edxw+qqY/wT89wtJXjvIz4Az69rHH2ta+d+2VkCIDdyoc8FHhZDI
         QaDnDkCxr0E5RSLEGZfXXY5gOwKz03zwuQKkdF7xxzxhu9x0WqfKhJFOn8K66hK74/oT
         BAOAyEIWo16FVVeGKHGS5oeSXk6p8e6dgoMg0PcLb2oCmT8Td25Os1qPm2DWr+7JracJ
         381eGQjj2QZazBqp3XpK/wLJh7jR3BIAnR9dYRA/VYtqDzaGxKCxQP4GPs/iMadIBDj5
         oRmg==
X-Gm-Message-State: AOAM533M14LC1tTLKWvd+8DrsP5avcR30Dnresmnu7qQYbZZYzqL80ru
        j18hePP2aXwrr97WwziwcjlbGw==
X-Google-Smtp-Source: ABdhPJzynOLhdYlVwoWPznXp3DqIb4mSI5Ve0BjgovmBaNyzMFh48QBAu3YNOKaPFJH5725ZzUExLA==
X-Received: by 2002:a17:90a:850c:: with SMTP id l12mr11700172pjn.224.1618612873018;
        Fri, 16 Apr 2021 15:41:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:41:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/27] drm/bridge: ti-sn65dsi86: Code motion of refclk management functions
Date:   Fri, 16 Apr 2021 15:39:41 -0700
Message-Id: <20210416153909.v4.18.I047b8c7c6a3fc60eaca473da7a374f171fb021c2@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes--this just makes the diffstat of a future change
easier to understand.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 116 +++++++++++++-------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index a98abf496190..b3c699da7724 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -192,6 +192,64 @@ static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
 	regmap_write(pdata->regmap, reg + 1, val >> 8);
 }
 
+static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn65dsi86 *pdata)
+{
+	u32 bit_rate_khz, clk_freq_khz;
+	struct drm_display_mode *mode =
+		&pdata->bridge.encoder->crtc->state->adjusted_mode;
+
+	bit_rate_khz = mode->clock *
+			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
+	clk_freq_khz = bit_rate_khz / (pdata->dsi->lanes * 2);
+
+	return clk_freq_khz;
+}
+
+/* clk frequencies supported by bridge in Hz in case derived from REFCLK pin */
+static const u32 ti_sn_bridge_refclk_lut[] = {
+	12000000,
+	19200000,
+	26000000,
+	27000000,
+	38400000,
+};
+
+/* clk frequencies supported by bridge in Hz in case derived from DACP/N pin */
+static const u32 ti_sn_bridge_dsiclk_lut[] = {
+	468000000,
+	384000000,
+	416000000,
+	486000000,
+	460800000,
+};
+
+static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
+{
+	int i;
+	u32 refclk_rate;
+	const u32 *refclk_lut;
+	size_t refclk_lut_size;
+
+	if (pdata->refclk) {
+		refclk_rate = clk_get_rate(pdata->refclk);
+		refclk_lut = ti_sn_bridge_refclk_lut;
+		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_refclk_lut);
+		clk_prepare_enable(pdata->refclk);
+	} else {
+		refclk_rate = ti_sn_bridge_get_dsi_freq(pdata) * 1000;
+		refclk_lut = ti_sn_bridge_dsiclk_lut;
+		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_dsiclk_lut);
+	}
+
+	/* for i equals to refclk_lut_size means default frequency */
+	for (i = 0; i < refclk_lut_size; i++)
+		if (refclk_lut[i] == refclk_rate)
+			break;
+
+	regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
+			   REFCLK_FREQ(i));
+}
+
 static int __maybe_unused ti_sn65dsi86_resume(struct device *dev)
 {
 	struct ti_sn65dsi86 *pdata = dev_get_drvdata(dev);
@@ -459,64 +517,6 @@ static void ti_sn_bridge_disable(struct drm_bridge *bridge)
 	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
 }
 
-static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn65dsi86 *pdata)
-{
-	u32 bit_rate_khz, clk_freq_khz;
-	struct drm_display_mode *mode =
-		&pdata->bridge.encoder->crtc->state->adjusted_mode;
-
-	bit_rate_khz = mode->clock *
-			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
-	clk_freq_khz = bit_rate_khz / (pdata->dsi->lanes * 2);
-
-	return clk_freq_khz;
-}
-
-/* clk frequencies supported by bridge in Hz in case derived from REFCLK pin */
-static const u32 ti_sn_bridge_refclk_lut[] = {
-	12000000,
-	19200000,
-	26000000,
-	27000000,
-	38400000,
-};
-
-/* clk frequencies supported by bridge in Hz in case derived from DACP/N pin */
-static const u32 ti_sn_bridge_dsiclk_lut[] = {
-	468000000,
-	384000000,
-	416000000,
-	486000000,
-	460800000,
-};
-
-static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
-{
-	int i;
-	u32 refclk_rate;
-	const u32 *refclk_lut;
-	size_t refclk_lut_size;
-
-	if (pdata->refclk) {
-		refclk_rate = clk_get_rate(pdata->refclk);
-		refclk_lut = ti_sn_bridge_refclk_lut;
-		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_refclk_lut);
-		clk_prepare_enable(pdata->refclk);
-	} else {
-		refclk_rate = ti_sn_bridge_get_dsi_freq(pdata) * 1000;
-		refclk_lut = ti_sn_bridge_dsiclk_lut;
-		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_dsiclk_lut);
-	}
-
-	/* for i equals to refclk_lut_size means default frequency */
-	for (i = 0; i < refclk_lut_size; i++)
-		if (refclk_lut[i] == refclk_rate)
-			break;
-
-	regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
-			   REFCLK_FREQ(i));
-}
-
 static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
 {
 	unsigned int bit_rate_mhz, clk_freq_mhz;
-- 
2.31.1.368.gbe11c130af-goog

