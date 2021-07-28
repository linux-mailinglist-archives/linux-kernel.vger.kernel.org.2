Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269A83D937E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhG1Qqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhG1Qqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:46:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF2CC061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso10983487pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4EzQ3N+ODDdvnvVDTZIarWyD37aI4tmhSikXWpjiVUY=;
        b=EU3iKiBW+M2JHYQkK//DzPmyuUiY16zfe/dyPa7qUUIzTsMOSUFAQqW+N3JQg9VrZV
         lxB6ABgl/2kluHAMzNN7nuczUvBQAC8xM0Hlqgvi1CKjFMqyKjVWklc0uTuuRZWZYd7d
         lBabA3MxS6WKG0Rzb7zJLZ8vf1u1osWdifZ1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4EzQ3N+ODDdvnvVDTZIarWyD37aI4tmhSikXWpjiVUY=;
        b=lD2u9g7wcIJT+sScuExrrTdolS4Fgqi/qMA4i8AtoSYqmfw54/+uZlhs7FYN2JosMQ
         4pSAuJ3PLg3mrx5QikEXIETxkDDgg+CEkIlOOiVjYjZ7tQNbr29IjJx+bMHGUo0ncXET
         1Iw9l9+rxF82EHbsPEBD3ApN+HdXMLIW3XCHIDBSHzx9np0O9W+htInWXvurp7iQgOee
         /E4wFhmL3VqnXuG4u3jVi2ug/+lTunPjWfJm8vzyiEoQB0Hs5Fq49E1yuj9q+tmOHnCn
         PUf2n0MgSo0TiS09dO6UfiUwtHGQsqnS/c6LOMjbIsDw8Ze1GnRQbf6ynloxepeOfHzv
         A5KQ==
X-Gm-Message-State: AOAM532fZqsjtbPMJTA8pkglPR9iA0OrR8zZdWelJFdkXvkULl1qrgPT
        RtJXyJufTHG7QT97SUv4yy25eA==
X-Google-Smtp-Source: ABdhPJwFA6ekQGuPWzWt4zMkZMwPi7juaMmH8xgdIcduykGrCB8inwPTTU0kSK3K8ZC4aCdmzv8rUg==
X-Received: by 2002:a17:90b:2286:: with SMTP id kx6mr1613944pjb.11.1627490788164;
        Wed, 28 Jul 2021 09:46:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:9f1e:e713:1a5e:89dc])
        by smtp.gmail.com with ESMTPSA id l12sm474075pff.182.2021.07.28.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:46:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, linux-arm-msm@vger.kernel.org,
        a.hajda@samsung.com, sam@ravnborg.org, airlied@linux.ie,
        bjorn.andersson@linaro.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, rodrigo.vivi@intel.com,
        jonas@kwiboo.se, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, robert.foss@linaro.org,
        jernej.skrabec@gmail.com, mripard@kernel.org,
        linus.walleij@linaro.org, maarten.lankhorst@linux.intel.com,
        rajeevny@codeaurora.org, lyude@redhat.com,
        thierry.reding@gmail.com, steev@kali.org,
        Douglas Anderson <dianders@chromium.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] drm/bridge: ti-sn65dsi86: Fix power off sequence
Date:   Wed, 28 Jul 2021 09:45:53 -0700
Message-Id: <20210728094511.2.If8a8ec3bf1855cf0dbb62c005a71d6698c99c125@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210728164557.1882787-1-dianders@chromium.org>
References: <20210728164557.1882787-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing with a panel that's apparently a little more persnickety
about the correct power sequence (specifically Samsung ATNA33XC20), we
found that the ti-sn65dsi86 was doing things just slightly wrong.

Looking closely at the ti-sn65dsi86's datasheet, the power off
sequence is supposed to be:
1. Clear VSTREAM_ENABLE bit
2. Stop DSI stream from GPU. DSI lanes must be placed in LP11 state.
3. Program the ML_TX_MODE to 0x0 (OFF)
4. Program the DP_NUM_LANES register to 0x0
5. Clear the DP_PLL_EN bit.
6. Deassert the EN pin.
7. Remove power from supply pins

Since we were doing the whole sequence in the "disable", I believe
that step #2 (stopping the DSI stream from the GPU) wasn't
happening. We also weren't setting DP_NUM_LANES to 0.

Let's fix this.

NOTE: things are a little asymmetric now. For instance, we turn the
PLL on in "enable" but now we're not turning it off until
"post_disable". It would seem to make sense to move the PLL turning on
to "pre_enable" to match. Unfortunately, I don't believe that's
allowed. It looks as if (in the non-refclk mode which probably nobody
is using) we have to wait until the MIPI clock is there before we can
enable the PLL. In any case, the way it is here won't really
hurt--it'll just leave the PLL on a little longer.

Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 9bf889302bcc..5e932070a1c3 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -766,10 +766,6 @@ static void ti_sn_bridge_disable(struct drm_bridge *bridge)
 
 	/* disable video stream */
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE, 0);
-	/* semi auto link training mode OFF */
-	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0);
-	/* disable DP PLL */
-	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
 }
 
 static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
@@ -1106,6 +1102,13 @@ static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
 {
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
 
+	/* semi auto link training mode OFF */
+	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0);
+	/* Num lanes to 0 as per power sequencing in data sheet */
+	regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK, 0);
+	/* disable DP PLL */
+	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
+
 	if (!pdata->refclk)
 		ti_sn65dsi86_disable_comms(pdata);
 
-- 
2.32.0.432.gabb21c7263-goog

