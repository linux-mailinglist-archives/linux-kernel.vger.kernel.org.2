Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D7834DED9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhC3CyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhC3CyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:54:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27A8C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bt4so6973894pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I36IxPptwcREtpot0iJCH+3WfYFhSmpYp5deLinpPgg=;
        b=kPzNiByEkfsePsfPtj6S5YnMKlXu7wXISif9REAqYuFnbIttV4HEzv66lzECdNerwv
         7caDpqP6eV3Ii4qxlTPIHhsdUFLm2GnOWAFy+MOBzjGH9Nz8Z0o0lMCvIAbizAOKHaOR
         PbfqnEFWer573aC3LXsoSyid2BQ7sYqn9l95U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I36IxPptwcREtpot0iJCH+3WfYFhSmpYp5deLinpPgg=;
        b=YQh5ZBX0wngfLHBf9sLB1m/N1AWRh/GNcmg1UFkxnIHszd3ic07lJr3OXJtLJN0xMd
         wmchw4FEtwWlYcIo0L5RNBdu89NkC4xUdQEKPxCIARuGfMkYupiAqvJO5AmaLyHiUN5e
         5ImacXsaxk+KuxoASSsXBhqqHaAWEtLo//mqeKYA2ScCaynF4pZ0sazAl9lCyrzLEMn0
         Aw8VYD1oAvFcU/gcKT+mMG3yu4znbOhBFXcEFRNnrz532X527mz52aoZXI24sfVaIcZd
         c4HXPvCWV7waGO90iTZD6x4FiaL/Vlb1f7cXINgqTYIf6V1jXy//I26ukhCfR2byCtvq
         OTjA==
X-Gm-Message-State: AOAM531W9uUa98NPUavN/SVzjJTJ2euFqApVcRgHE8W26GnrOOXayNvA
        tdEJ5W904uGwnK0grVCnWKpLRg==
X-Google-Smtp-Source: ABdhPJzao4hv+1lRc1IJmNX9LkjQKMN0rQjB/u4FznRywuq7j6sWJCoD2wfDN9s9896IQSi9E/Bnug==
X-Received: by 2002:a17:90a:c20a:: with SMTP id e10mr2008412pjt.221.1617072849314;
        Mon, 29 Mar 2021 19:54:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f599:1ca7:742d:6b50])
        by smtp.gmail.com with ESMTPSA id t17sm19152706pgk.25.2021.03.29.19.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:54:09 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        robdclark@chromium.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] drm/bridge: ti-sn65dsi86: Move MIPI detach() / unregister() to detach()
Date:   Mon, 29 Mar 2021 19:53:36 -0700
Message-Id: <20210329195255.v2.5.I1a9275ffbde1d33ad7a3af819f5fbc0941b7ee02@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330025345.3980086-1-dianders@chromium.org>
References: <20210330025345.3980086-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register() / attach() for MIPI happen in the bridge's
attach(). That means that the inverse belongs in the bridge's
detach().

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index c006678c9921..e8e523b3a16b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -437,7 +437,15 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
 
 static void ti_sn_bridge_detach(struct drm_bridge *bridge)
 {
-	drm_dp_aux_unregister(&bridge_to_ti_sn_bridge(bridge)->aux);
+	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
+
+
+	if (pdata->dsi) {
+		mipi_dsi_detach(pdata->dsi);
+		mipi_dsi_device_unregister(pdata->dsi);
+	}
+
+	drm_dp_aux_unregister(&pdata->aux);
 }
 
 static void ti_sn_bridge_disable(struct drm_bridge *bridge)
@@ -1315,11 +1323,6 @@ static int ti_sn_bridge_remove(struct i2c_client *client)
 	if (!pdata)
 		return -EINVAL;
 
-	if (pdata->dsi) {
-		mipi_dsi_detach(pdata->dsi);
-		mipi_dsi_device_unregister(pdata->dsi);
-	}
-
 	kfree(pdata->edid);
 
 	ti_sn_debugfs_remove(pdata);
-- 
2.31.0.291.g576ba9dcdaf-goog

