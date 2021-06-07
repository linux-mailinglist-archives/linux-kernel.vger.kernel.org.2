Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADFC39E4F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhFGRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:09:37 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:43528 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhFGRJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:09:30 -0400
Received: by mail-pf1-f179.google.com with SMTP id m7so633184pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QFddLOHKMkDWCo/3CJ6wD0VeACMC/xRkHRaz1DXreL4=;
        b=VUYMkHkOdCN0d9Kzmy6/vVCz4a+LAxY0BdwuAOSzLNJqvbgmWJqXOQLjZPftDM/hFA
         S4sKnmI3ocXTQZ7wYLwrOSH9jg491VW9QKj9matJ/vZQJfuwtnvtxYsexmODKmy1v7cn
         m9RJtgRs3BMDFegVPavrzKA20e2ng0ZkRXfyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QFddLOHKMkDWCo/3CJ6wD0VeACMC/xRkHRaz1DXreL4=;
        b=oJSeHTaGhLWvsAQIMussLFRCx8fYZfYj6HamCzEy5vOo2MDq42QXJAiosLc0HiI52W
         vOf8Ped0aEUCo1C1psqoRvVUpbvvINKc6K7KJXnwxfhJWl5gBBL3CLOJZInu/XrTW/YP
         RWKqDbX+SRYJWMHg88rORCitAQc1n0GAaTeIwqnKcFR64lt+wSMLEEmwaoce9f/CIRi3
         i2ITtMmiz3J4BTJIFoJjVlP275UOIYeE6UmFjpsItesrmpDIg4gS8QuMJ++woLtKsOQR
         r2VZk8pcQ68GX6krdtA8BnH3f6JNYRb/46wQyLenMnhCpudhBvwTjucKMSjecnufynzS
         8c2g==
X-Gm-Message-State: AOAM530LoFP64p3pVpKif889z29TzYGORESYNq1F/HaqQx2DDk8lHmH1
        +SezqwuBTRRCiC3l2UKZg/DFzA==
X-Google-Smtp-Source: ABdhPJzGbsmGgNdYrdMCYElyKRxtwRKUm08v3yvz8uRp/WDjLVgv0nkTYzOdWrjU9NDZEuLzFn7CEw==
X-Received: by 2002:a05:6a00:882:b029:24b:afda:acfa with SMTP id q2-20020a056a000882b029024bafdaacfamr17889560pfj.72.1623085586388;
        Mon, 07 Jun 2021 10:06:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f656:ffce:6348:a42a])
        by smtp.gmail.com with ESMTPSA id fs24sm12897639pjb.6.2021.06.07.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:06:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Linus W <linus.walleij@linaro.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 08/11] drm/bridge: ti-sn65dsi86: Add support for the DP AUX bus
Date:   Mon,  7 Jun 2021 10:05:52 -0700
Message-Id: <20210607100234.v9.8.Ib5fe0638da85800141ce141bb8e441c5f25438d4@changeid>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210607170555.4006050-1-dianders@chromium.org>
References: <20210607170555.4006050-1-dianders@chromium.org>
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

Changes in v9:
- Rebased atop v9 ("Promote the AUX channel") patch.

Changes in v7:
- Patch to support for DP AUX bus on ti-sn65dsi86 new for v7.

 drivers/gpu/drm/bridge/Kconfig        | 1 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c96e4b38d1d3..5e1e28d4520f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -293,6 +293,7 @@ config DRM_TI_SN65DSI86
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
2.32.0.rc1.229.g3e70b5a671-goog

