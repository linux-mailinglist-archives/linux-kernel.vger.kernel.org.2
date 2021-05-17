Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02293865FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbhEQULv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbhEQULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:11:14 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772CAC061760
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:09:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m124so5386452pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psrH5M+NKV5li8bg6y5czsIFhDiniap4e0rpHCeiOC0=;
        b=Kj0juLGE90KylFNjeKIBQWJhYQnqQajv49nog8fBiWQ74nF3gqXNIRB2q8pFC4SIiz
         DXZp6M7cW/hT7FjNmU3uhgs7jsetbUyEz4gySKqYKXWJK+hJPbR3GoaFLQTIohJ+3UlH
         IgvlcHZJht/jiHEdYAOnSnqsdclztTOVExBWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psrH5M+NKV5li8bg6y5czsIFhDiniap4e0rpHCeiOC0=;
        b=CjoqkKjjH9O+0F4rTsqJk0hltNKBP4srYvh2jNZhbTqxYrqAvsNQtG7f4aVMQ3IBcd
         S04grJG841tKwi/dGTwJP7y3tn/7VSb2mKhSgaG7YegqhyXalBwfrosP1cudMsnQce5N
         VMAKkIOQeBDNFLEjI0diw3MaVwaSqtlaK5LXqm1rrqmmdOJMkb57x/ph7/51G2q0dQ6r
         0k6th5Bij1L1GsdM/rIXQvBs7f2sUo+GEylMmKbruUE/Q3GnFGjonlfvmHHKRnmA4qq3
         bVBeNlIVZbivdbfgympauT13o3T6c5MGCudIdedxnEBvrRysCxYIKkFlf1gFstiOFVGv
         iAGA==
X-Gm-Message-State: AOAM531LkwLJck8hBvtcbtA3FtogoGf9ZY+wr4aL6c6AI3/knYVEm/WK
        eTVyNbzpOTpZ3ujersJeZxZ96Q==
X-Google-Smtp-Source: ABdhPJzNbrqMJ/kDp4vIoU2Elz4dbseH3ovLFsuUJF7+OVsGm8tUuMb+B26vxpXZ9ruhoL0qtGmgow==
X-Received: by 2002:a63:185c:: with SMTP id 28mr1257849pgy.158.1621282197075;
        Mon, 17 May 2021 13:09:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bc91:c597:ded0:7930])
        by smtp.gmail.com with ESMTPSA id x19sm9078941pgj.66.2021.05.17.13.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:09:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus W <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, robdclark@chromium.org,
        Steev Klimaszewski <steev@kali.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/10] drm/bridge: ti-sn65dsi86: Add support for the DP AUX bus
Date:   Mon, 17 May 2021 13:09:05 -0700
Message-Id: <20210517130450.v7.8.Ib5fe0638da85800141ce141bb8e441c5f25438d4@changeid>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210517200907.1459182-1-dianders@chromium.org>
References: <20210517200907.1459182-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to provide our panel with access to the DP AUX channel. The
way to do this is to let our panel be a child of ours using the fancy
new DP AUX bus support.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v7:
- Patch to support for DP AUX bus on ti-sn65dsi86 new for v7.

 drivers/gpu/drm/bridge/Kconfig        |  1 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index d25e900f07ef..294d0bdd4cbe 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -280,6 +280,7 @@ config DRM_TI_SN65DSI86
 	select DRM_PANEL
 	select DRM_MIPI_DSI
 	select AUXILIARY_BUS
+	select DRM_DP_AUX_BUS
 	help
 	  Texas Instruments SN65DSI86 DSI to eDP Bridge driver
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 42a55d13864b..a59497f7e504 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -23,6 +23,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_dp_aux_bus.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
@@ -1446,19 +1447,27 @@ static int ti_sn_aux_probe(struct auxiliary_device *adev,
 	pdata->aux.transfer = ti_sn_aux_transfer;
 	drm_dp_aux_init(&pdata->aux);
 
+	ret = devm_of_dp_aux_populate_ep_devices(&pdata->aux);
+	if (ret)
+		goto err;
+
 	/*
 	 * The eDP to MIPI bridge parts don't work until the AUX channel is
 	 * setup so we don't add it in the main driver probe, we add it now.
 	 */
 	ret = ti_sn65dsi86_add_aux_device(pdata, &pdata->bridge_aux, "bridge");
 
+	if (ret)
+		goto err;
+
+	return 0;
+err:
 	/*
 	 * Clear of_node on any errors. Really this only matters if the error
 	 * is -EPROBE_DEFER to avoid (again) keep pinctrl from claiming when
 	 * it tries the probe again, but it shouldn't hurt on any error.
 	 */
-	if (ret)
-		adev->dev.of_node = NULL;
+	adev->dev.of_node = NULL;
 
 	return ret;
 }
-- 
2.31.1.751.gd2f1c929bd-goog

