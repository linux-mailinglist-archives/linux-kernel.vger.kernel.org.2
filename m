Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8483A47CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhFKRVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:21:50 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:37846 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhFKRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:21:32 -0400
Received: by mail-pg1-f170.google.com with SMTP id t9so2996818pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7mAnmaPaVMV+mWzPwVY4n8i3eQDdwgnqGWGWeaIDwP0=;
        b=W5bPJdBrjvqCku2In6aVn0zD2GstngrY076zfO20+umnrSQXllmwxSed6loqJUtexM
         6Zy2bQfRUoc73GR7TWu61oVev8v8taXJN7UTjcTuRIqZ+Skytr/mRlQkPcxmC3QG5JXw
         42ZQbaBRNFRuszP1mM4K7htDee3Cih4fvvmKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mAnmaPaVMV+mWzPwVY4n8i3eQDdwgnqGWGWeaIDwP0=;
        b=m4OxIx9Hd49idE2ElFTqdEaVCjoyh8eIcidTQDid7NoDG7pu5DWNxUSvyZDMe0N9wI
         Y5eEWyQOVQfJ5ht8GBD6/MUt0vPlWARYDPWyVTSlBrzYkIgKQdatpWH7OMfJnO6OzrWh
         HpGD5JJK+cRWkcRYH0CZKwm5M6Ykt6EleTyLJTgoTz5QXNiOY7Ay3w2Ugk4WSaqDTMcC
         z2nPBHN22rA3CuvHaks0vwZfUtVaNRzK7FQUFWP2w67yO6BFgee8ixMr/wLYKDSdD92m
         V26bPMhepl5itXKB6u2FDFeA6EIGWcK0Zj2ieVcWlMs9xOPgLUv4209ovISFtRors8jz
         CGVA==
X-Gm-Message-State: AOAM531NZXtufl3Aqf9P6XNp69ahSeLMnYVUJH7zzgux+m0f2C/tEaz+
        2xA+kl6O6lCER3uDfKmvPHvWGw==
X-Google-Smtp-Source: ABdhPJwQGgKbRuSHdwthATamDLygBvxHvvM35RXviRa9wxyNi13pMhJ5Mc1QRdPc+KuGSpBbHdxMaw==
X-Received: by 2002:a63:9552:: with SMTP id t18mr4707431pgn.206.1623431897904;
        Fri, 11 Jun 2021 10:18:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:4128:5428:5cd0:cfa5])
        by smtp.gmail.com with ESMTPSA id f17sm5837850pgm.37.2021.06.11.10.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:18:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>, robdclark@chromium.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 08/11] drm/bridge: ti-sn65dsi86: Add support for the DP AUX bus
Date:   Fri, 11 Jun 2021 10:17:44 -0700
Message-Id: <20210611101711.v10.8.Ib5fe0638da85800141ce141bb8e441c5f25438d4@changeid>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611171747.1263039-1-dianders@chromium.org>
References: <20210611171747.1263039-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to provide our panel with access to the DP AUX channel. The
way to do this is to let our panel be a child of ours using the fancy
new DP AUX bus support.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---

(no changes since v9)

Changes in v9:
- Rebased atop v9 ("Promote the AUX channel") patch.

Changes in v7:
- Patch to support for DP AUX bus on ti-sn65dsi86 new for v7.

 drivers/gpu/drm/bridge/Kconfig        | 1 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 85b673613687..431b6e12a81f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -303,6 +303,7 @@ config DRM_TI_SN65DSI86
 	select DRM_PANEL
 	select DRM_MIPI_DSI
 	select AUXILIARY_BUS
+	select DRM_DP_AUX_BUS
 	help
 	  Texas Instruments SN65DSI86 DSI to eDP Bridge driver
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 8e61005cf4ad..32bd35c98d95 100644
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
@@ -1426,12 +1427,17 @@ static int ti_sn_aux_probe(struct auxiliary_device *adev,
 			   const struct auxiliary_device_id *id)
 {
 	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
+	int ret;
 
 	pdata->aux.name = "ti-sn65dsi86-aux";
 	pdata->aux.dev = &adev->dev;
 	pdata->aux.transfer = ti_sn_aux_transfer;
 	drm_dp_aux_init(&pdata->aux);
 
+	ret = devm_of_dp_aux_populate_ep_devices(&pdata->aux);
+	if (ret)
+		return ret;
+
 	/*
 	 * The eDP to MIPI bridge parts don't work until the AUX channel is
 	 * setup so we don't add it in the main driver probe, we add it now.
-- 
2.32.0.272.g935e593368-goog

