Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A64412B22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244392AbhIUCIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhIUBvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28600C0363D1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:53:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s11so18866791pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCz18209aZjxX68VY6I5xMHLRD2Ccy0UqHFvYku0NNA=;
        b=H5WoUKZoRCGn0F5IG7ChSePrGH/W1GoC/gJahDMQdRC6+76rieWJbM2hgS8eb1nehK
         SDoiUiq9YPC32FhftznNSOvLcmT5v3qY2/i/80Xe1fi/aul4Dx1Zz2mcd1JKPQXESRj+
         qCklL2OzveRCh/yRG/O6jLy1du5vRP8w5gzVe/PXYbkj6I/BxiV3Q/6D8s3+yAxyTAuc
         AjKRFBuZDOHB1KO5NZd+YsRKx6aIr2cEGsLeXNkmHYx2plJY5jkKzNIl8/MFDJ7XYAL8
         /lu32PG1iKZxpFu/AuEn8PQdylwGUKwKuLgTllWkje0lvnly7aqqo4qngLTmt8MTHTPi
         TcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCz18209aZjxX68VY6I5xMHLRD2Ccy0UqHFvYku0NNA=;
        b=j3CcyfTxoe+2SR/eCGdG2ldUaowt94cls4i0C1fK5OseC5FL7KJcll6L4PN5kz/v7q
         JjX3c5YNYL0KvxPQo4r1iloevQ2mz4nDSaYc4K/r4m3OWoiOrIa7+rMS3cOUlBqu4Ocp
         RRviKOEiQnQG7ib1j9U5vYyvJ5N1KjLx2C4T7Kc+bLsNH5o30aBBaFWGWCiTdcwcVNZZ
         LR6o0DE+XGPEcKSfR+1s9anIXIMX8W41DR+9K+QXc0Du1SZC7jva2bvJqTRtm9LX4qO7
         Ia7FS7wEySk2R5Uk4u/xHS8GF8yLEwX1U+PCOelHpYgx/+7kJ6aSRrJVludPykCDb9w0
         oTbQ==
X-Gm-Message-State: AOAM530/XCJffK2vc6zlek/C42dD+6fCwwkDyNPr30/ZE7Q4ir/fhGJ6
        k1mpDv/6RAgXlzMwpGIgFA4=
X-Google-Smtp-Source: ABdhPJwXFcgNrdtg16son2IIazSXF5if2APFcLfqLr521yNXaCWlsxFiRpyVfsBLXE5Z+Vj3v8hfBQ==
X-Received: by 2002:a62:19d4:0:b0:43d:1bb7:13ae with SMTP id 203-20020a6219d4000000b0043d1bb713aemr27253731pfz.63.1632178413677;
        Mon, 20 Sep 2021 15:53:33 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id k22sm15495282pfi.149.2021.09.20.15.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:53:32 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] drm/bridge: ti-sn65dsi86: Add NO_CONNECTOR support
Date:   Mon, 20 Sep 2021 15:58:00 -0700
Message-Id: <20210920225801.227211-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920225801.227211-1-robdclark@gmail.com>
References: <20210920225801.227211-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Slightly awkward to fish out the display_info when we aren't creating
own connector.  But I don't see an obvious better way.

v2: Remove error return with NO_CONNECTOR flag

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 39 ++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6154bed0af5b..94c94cc8a4d8 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -667,11 +667,6 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
 						   .node = NULL,
 						 };
 
-	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
-		DRM_ERROR("Fix bridge driver to make connector optional!");
-		return -EINVAL;
-	}
-
 	pdata->aux.drm_dev = bridge->dev;
 	ret = drm_dp_aux_register(&pdata->aux);
 	if (ret < 0) {
@@ -679,9 +674,11 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
 		return ret;
 	}
 
-	ret = ti_sn_bridge_connector_init(pdata);
-	if (ret < 0)
-		goto err_conn_init;
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
+		ret = ti_sn_bridge_connector_init(pdata);
+		if (ret < 0)
+			goto err_conn_init;
+	}
 
 	/*
 	 * TODO: ideally finding host resource and dsi dev registration needs
@@ -743,7 +740,8 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
 err_dsi_attach:
 	mipi_dsi_device_unregister(dsi);
 err_dsi_host:
-	drm_connector_cleanup(&pdata->connector);
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
+		drm_connector_cleanup(&pdata->connector);
 err_conn_init:
 	drm_dp_aux_unregister(&pdata->aux);
 	return ret;
@@ -792,9 +790,30 @@ static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
 	regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, val);
 }
 
+/*
+ * Find the connector and fish out the bpc from display_info.  It would
+ * be nice if we could get this instead from drm_bridge_state, but that
+ * doesn't yet appear to be the case.
+ */
 static unsigned int ti_sn_bridge_get_bpp(struct ti_sn65dsi86 *pdata)
 {
-	if (pdata->connector.display_info.bpc <= 6)
+	struct drm_bridge *bridge = &pdata->bridge;
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+	unsigned bpc = 0;
+
+	drm_connector_list_iter_begin(bridge->dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (drm_connector_has_possible_encoder(connector, bridge->encoder)) {
+			bpc = connector->display_info.bpc;
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	WARN_ON(bpc == 0);
+
+	if (bpc <= 6)
 		return 18;
 	else
 		return 24;
-- 
2.31.1

