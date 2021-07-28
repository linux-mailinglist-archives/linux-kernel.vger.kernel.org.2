Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173423D9379
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhG1Qqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhG1Qqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:46:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86888C061799
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso4991549pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQzrLQVtbfQMv3/HRKhyPjphDJ6FYVHsID5Re5m9DFY=;
        b=IvGaD/1RLetm7Cjii3YEvU2f/KPRF1C+ltbml72+0w6fKj8e25td/YJRlhSFBMVA0I
         cvGSi4P8FY7EJ0aUt00+u2RDum+Rmc2RwTyyaA+oDNsC83nDAlpjqjovcatYQG5OjF9U
         WHA2HbSz37wkMMEDZgtYjF1H/UQKiDPrwurNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQzrLQVtbfQMv3/HRKhyPjphDJ6FYVHsID5Re5m9DFY=;
        b=Lvb7YttbfdIOrxr39CKKgpy+llYBu58e8UNhTkM4LsfU1Zgff1QPmGGg7ulovHUkah
         XPmRX6EkwBJ6hCNIJmOW3hc5PQgN4kOYQ6fQrwMiBFZCUvWCGf8SK6tkc9p3BdJlxz04
         4qFYDcYR/E2eKBdgSMhApA6rs2BA7a5lfLJNu5LUDoEFfhFuOQ+U702apzG21q06+Hqx
         JC2Wl8TLI97DqVvuInBe+fcnEEkjO3HcIh2G+AExNE9p09G0sgBHUneKp0K72PaBscel
         7A6rshZpQsMGq70OAmfFMoN5GtlJwxLrMyT5RB6kbW5yzYaaXOVqccsKEtBXxh9XeQI4
         3hRw==
X-Gm-Message-State: AOAM532Q50u0PvdvAY12UDaTmedrJnibQP/EgWOaRW3prEPwuVD9Yxke
        2XWshhshbGUZtVpIXGlVQrosVXz0Ah5XYldU
X-Google-Smtp-Source: ABdhPJwYmqa7VXgcysC0cEarvUasOXzxXP3vKtk023ORHTxH8iQ0+T8zkBZaWNczJ9w0ArTdPjU/6w==
X-Received: by 2002:a17:90a:4cc4:: with SMTP id k62mr10419437pjh.110.1627490790101;
        Wed, 28 Jul 2021 09:46:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:9f1e:e713:1a5e:89dc])
        by smtp.gmail.com with ESMTPSA id l12sm474075pff.182.2021.07.28.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:46:29 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] drm/bridge: ti-sn65dsi86: Add some 100 us delays
Date:   Wed, 28 Jul 2021 09:45:54 -0700
Message-Id: <20210728094511.3.I842d483139531aa4651da8338512fdf0171ff23c@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210728164557.1882787-1-dianders@chromium.org>
References: <20210728164557.1882787-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manual has always said that we need 100 us delays in a few
places. Though it hasn't seemed to be a big deal to skip these, let's
add them in case it makes something happier.

NOTE: this fixes no known issues but it seems good to make it right.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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
2.32.0.432.gabb21c7263-goog

