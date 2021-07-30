Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939043DBC97
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhG3Pq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhG3Pqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:46:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD735C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:46:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l19so15861842pjz.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXWj3SiFugbCWCRSzVX+8Iy1ihJkRj/jg7iX1eJPuek=;
        b=LOyEwhl8I0HGdsPqwNONLr04k49BqJ8Zqb0xibyWEH+5coCeIHqfqJul+fJ0na4T5V
         bL5hmYeBWDpI2gmOivOpSxhmV9qVDEY0I1Yj2jnYHgFllLK1ADp08rjzMwnHZ8dThZLU
         fUI/xJ7OrAN2Ra0vPQ4I80K+MctPGf+37Tg0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXWj3SiFugbCWCRSzVX+8Iy1ihJkRj/jg7iX1eJPuek=;
        b=UXlGBn/ZNPyrwfTV2wKa4NjJfUemdiWLp70ni0sHdVBw/NFsykADngiUHLxEsTuyAc
         vFnr6ME11AU6P9vV+6XCnvlXjFEPOty6XByOweb0QIt48nG2kw0DLUOErMp9VpORVWhW
         SLcQyk/C85m+I6qkJId+8RS92BQewkOkYAR+CYEXsOI4ef8DlW5E3D4k3/Jy/bPjnIpT
         g6AHm6FSMDm0gh+abY9/yob7V/Xqo92Xg1lJVXZxcveLFVVYhXXC2K710NRz5W/Qs6e7
         yWa3OJ/DSeob0gKDv8urK4r/1WN7hnX62+z9IFeXBDuMeQawYuw+hmyPe5YD2Pb9fnX/
         NVYQ==
X-Gm-Message-State: AOAM531icOl1M1tI+PMTQKB8rqbXQAzLWQhHQRlmP9X4q9K7SWBb0AhN
        X1CrzW0Zhft2Otwe3QdcR89qcA==
X-Google-Smtp-Source: ABdhPJyBu9kVnKQSpFGpMuW3TcgADicSicEG7RyFmRXSR8ISFZOPp5RUwFrvwuR2LDvVfASoYIbjBA==
X-Received: by 2002:a62:92d7:0:b029:32c:8c46:9491 with SMTP id o206-20020a6292d70000b029032c8c469491mr3308985pfd.2.1627660004406;
        Fri, 30 Jul 2021 08:46:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3424:e0ac:5a92:d061])
        by smtp.gmail.com with ESMTPSA id u188sm3175621pfc.115.2021.07.30.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:46:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, steev@kali.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, bjorn.andersson@linaro.org,
        daniel@ffwll.ch, airlied@linux.ie, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, rodrigo.vivi@intel.com,
        sam@ravnborg.org, jonas@kwiboo.se, mripard@kernel.org,
        thierry.reding@gmail.com, lyude@redhat.com,
        linus.walleij@linaro.org, rajeevny@codeaurora.org,
        linux-arm-msm@vger.kernel.org, a.hajda@samsung.com,
        tzimmermann@suse.de, narmstrong@baylibre.com,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] drm/bridge: ti-sn65dsi86: Add some 100 us delays
Date:   Fri, 30 Jul 2021 08:46:02 -0700
Message-Id: <20210730084534.v2.3.I842d483139531aa4651da8338512fdf0171ff23c@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210730154605.2843418-1-dianders@chromium.org>
References: <20210730154605.2843418-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manual has always said that we need 100 us delays in a few
places. Though it hasn't seemed to be a big deal to skip these, let's
add them in case it makes something happier.

NOTE: this fixes no known issues but it seems good to make it right.

Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v2:
- Added Fixes tag as requested by Sam.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 5e932070a1c3..cd0fccdd8dfd 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -307,6 +307,9 @@ static int __maybe_unused ti_sn65dsi86_resume(struct device *dev)
 		return ret;
 	}
 
+	/* td2: min 100 us after regulators before enabling the GPIO */
+	usleep_range(100, 110);
+
 	gpiod_set_value(pdata->enable_gpio, 1);
 
 	/*
@@ -1096,6 +1099,9 @@ static void ti_sn_bridge_pre_enable(struct drm_bridge *bridge)
 
 	if (!pdata->refclk)
 		ti_sn65dsi86_enable_comms(pdata);
+
+	/* td7: min 100 us after enable before DSI data */
+	usleep_range(100, 110);
 }
 
 static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
-- 
2.32.0.554.ge1b32706d8-goog

