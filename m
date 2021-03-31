Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61634DEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhC3Cyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhC3CyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:54:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7774EC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d8so5394897plh.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdhUcLdKGZws4bIuWNvM669I98WfYUeDRQetYvWjfOc=;
        b=LDZDXTvfo3j5zkAAyZvvJ/TwJjrnnhB8tUjrsrG4YoMmDxgEqWxtMmOOU845+GlpgF
         Y5/H79kEPuVKJcsebB97HKStI3DjVZ8RrcyJewIbVWJwaUqfsfLHVU/SFTqNsSNZJ4Yn
         QmvAj2FIF9WmWGMPOXaIO86aY+8+ydg3ggjVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdhUcLdKGZws4bIuWNvM669I98WfYUeDRQetYvWjfOc=;
        b=DCKltzBkNM2+WSpjoSn8MO5GjYaY/o5vz5DzU+HJLP9swE1jnqu1c98W1BMK/WPEaZ
         /7SmdZ36WxOz34CJRK2R4o2rLewFa4GecmuvfZmvMMJlOSzg5oS9M5X7x0yjdulScWSE
         WskgmsbEseqEAR4Sjeg+hKVr8m5gtcDU5z/atF45jcP8G+h8rY3DUIygzbCblv6gbPko
         Wwx9yIddFSDR84ndDBM5abP+vCKP+g3Ae0XxgW0GKTZNeiIxtH3vp2YoRov6IAG/nqxw
         OpINtyVTjvpg1cLcC/3AeiQi18J7KzbUvTf85+egiFWxWDFTDChnIOrMZ9kE7lQf15s4
         I1qw==
X-Gm-Message-State: AOAM531JrAThrNbFm0cDKoThkrWabSu/I9aYTJrY14Tjt7HqtlJw5aLG
        e1RdaNogqyZCQdvZsfmMFL8FIQ==
X-Google-Smtp-Source: ABdhPJyRbP9Dg9rng94Tm6dgBkHfUuioCdrW0smh7o8Ei4c+MuOLyUrICxVQG1NgRYkZK5JqSBmmvg==
X-Received: by 2002:a17:902:ed84:b029:e7:1f2b:1eb4 with SMTP id e4-20020a170902ed84b02900e71f2b1eb4mr19897667plj.74.1617072858078;
        Mon, 29 Mar 2021 19:54:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f599:1ca7:742d:6b50])
        by smtp.gmail.com with ESMTPSA id t17sm19152706pgk.25.2021.03.29.19.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:54:17 -0700 (PDT)
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
Subject: [PATCH v2 10/14] drm/bridge: ti-sn65dsi86: Stop caching the EDID ourselves
Date:   Mon, 29 Mar 2021 19:53:41 -0700
Message-Id: <20210329195255.v2.10.Ida6151df6bfc71df77afee1d72bb7eb0a443f327@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330025345.3980086-1-dianders@chromium.org>
References: <20210330025345.3980086-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the patch ("drm/edid: Use the cached EDID in
drm_get_edid() if eDP") we no longer need to maintain our own
cache. Drop this code.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 9577ebd58c4c..c0398daaa4a6 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -121,7 +121,6 @@
  * @debugfs:      Used for managing our debugfs.
  * @host_node:    Remote DSI node.
  * @dsi:          Our MIPI DSI source.
- * @edid:         Detected EDID of eDP panel.
  * @refclk:       Our reference clock.
  * @panel:        Our panel.
  * @enable_gpio:  The GPIO we toggle to enable the bridge.
@@ -147,7 +146,6 @@ struct ti_sn_bridge {
 	struct drm_bridge		bridge;
 	struct drm_connector		connector;
 	struct dentry			*debugfs;
-	struct edid			*edid;
 	struct device_node		*host_node;
 	struct mipi_dsi_device		*dsi;
 	struct clk			*refclk;
@@ -269,17 +267,17 @@ connector_to_ti_sn_bridge(struct drm_connector *connector)
 static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
 {
 	struct ti_sn_bridge *pdata = connector_to_ti_sn_bridge(connector);
-	struct edid *edid = pdata->edid;
-	int num;
+	struct edid *edid;
+	int num = 0;
 
-	if (!edid) {
-		pm_runtime_get_sync(pdata->dev);
-		edid = pdata->edid = drm_get_edid(connector, &pdata->aux.ddc);
-		pm_runtime_put(pdata->dev);
-	}
+	pm_runtime_get_sync(pdata->dev);
+	edid = drm_get_edid(connector, &pdata->aux.ddc);
+	pm_runtime_put(pdata->dev);
 
-	if (edid && drm_edid_is_valid(edid)) {
-		num = drm_add_edid_modes(connector, edid);
+	if (edid) {
+		if (drm_edid_is_valid(edid))
+			num = drm_add_edid_modes(connector, edid);
+		kfree(edid);
 		if (num)
 			return num;
 	}
@@ -1308,8 +1306,6 @@ static int ti_sn_bridge_remove(struct i2c_client *client)
 	if (!pdata)
 		return -EINVAL;
 
-	kfree(pdata->edid);
-
 	ti_sn_debugfs_remove(pdata);
 
 	drm_bridge_remove(&pdata->bridge);
-- 
2.31.0.291.g576ba9dcdaf-goog

