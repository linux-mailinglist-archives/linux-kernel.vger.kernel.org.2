Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B88C3697D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbhDWRBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbhDWRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:00:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1117BC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:59:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g1-20020a17090adac1b0290150d07f9402so1502146pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etZUcTt+rboV/or3vFs74Bup/+mjjab123G8taaBqvc=;
        b=AjEor4mxpvSaZKgOdrkbk57bk1irf3vHm5XrDZmIsChLFe/TzhYz3WuroEtkAgRkea
         tRsds8lsuix/DVYetdGQlcKyUiRRSBwZBOFGi78SMogB0CFOgQ+2uKEaxbM84R7y1xMB
         5HO1Lwjjcjo63psNcpiAeGBrz7NlAuLp4pl58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etZUcTt+rboV/or3vFs74Bup/+mjjab123G8taaBqvc=;
        b=t1NhXnZF9bmfpUcELka6T1j+AAlYfVQidvxQaBB6E07kQXGpG36emycvRAzBrdijAb
         8UXLJoEu5BZ/s6dD81FTqYr+o0/Pl6wBMkbY+/ta6emNQpCvWg6sSPzJhTfdcjyA0RFH
         uXRU4bjcuQe7GerTnX7roaLvYnm8nb4vmccOP5e666/q9NTnD8dWjwCW5nwanXpPCLtf
         51b/XsamaNKxUH3YXDcOwqbwzm09UdBmQserhftdq4GPOxSQZlf47KLGjUHj20qM/Sxe
         AVcKgAwNXGVbgJ8jMK7L6JgS2QNsKz1Wl52d39cx8vhklAzPe/j57axUwUFwo+wehbdC
         k2nw==
X-Gm-Message-State: AOAM530UIBu7rAG95/FvRsvfXs5//861V2qB22ouVXfq9FjtHO60T27W
        4+Y/Ku7RtZLvhMVY2lXcVmbwSg==
X-Google-Smtp-Source: ABdhPJzqFVde8rjb9eQ+J8WUohhDAgHlL8Rzk3zMwNUD08f5LTwGlvvR+pOz3zdxGZJCJz2+ZLEeeQ==
X-Received: by 2002:a17:90a:510d:: with SMTP id t13mr5199699pjh.97.1619197193678;
        Fri, 23 Apr 2021 09:59:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6d86:663d:71f8:6a11])
        by smtp.gmail.com with ESMTPSA id v8sm5123607pfm.128.2021.04.23.09.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:59:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/20] drm/bridge: ti-sn65dsi86: Code motion of refclk management functions
Date:   Fri, 23 Apr 2021 09:58:58 -0700
Message-Id: <20210423095743.v5.12.I047b8c7c6a3fc60eaca473da7a374f171fb021c2@changeid>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423165906.2504169-1-dianders@chromium.org>
References: <20210423165906.2504169-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes--this just makes the diffstat of a future change
easier to understand.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 116 +++++++++++++-------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 49b76b2ffe25..db367793cdff 100644
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
@@ -460,64 +518,6 @@ static void ti_sn_bridge_disable(struct drm_bridge *bridge)
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
2.31.1.498.g6c1eba8ee3d-goog

