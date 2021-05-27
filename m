Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F15D3928C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhE0Hnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhE0Hnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:43:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F32C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:42:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q67so3009954pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKPatIdYRxq+Xo6lopop8fgePb2STDXynanM3KtfV2E=;
        b=UzhS0TSGWLsdtGeMsRR9DXcxIAZf9yxmavKOZAwL5cSNom1Ge/Ba1Uxw/Lg2KECen/
         iW7Zv/AEndzzyqjRQt6icQYPlYTsLewTmTmaVB52vkI8cdlyq6cNV/gJHPyTlRgk2jlz
         hxRQdQI2gTCY3qLIN81UKFt5s3KHLP3Vt1TtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKPatIdYRxq+Xo6lopop8fgePb2STDXynanM3KtfV2E=;
        b=PSo3fKJB5W0VrNyCrZUzsD4Sw4v6fW5IAPss3YFA8ZECEZY8RwAk4M1hxx1GVmJwWR
         jxoUx3w4LVGDta5T+DhRh42BVR7PQZf6xSkmpO8ZqVfn9ObYS+TLV1gpxXNlEEpVHdkI
         KQDvwADBJwQeGMd3ZZ+6/Uwjd5Plk+0E9usQw7aDB5HkC0QlJkw5co6tFhnjYxNfK4+W
         3TWNfrdYT+mXbbEUPo/OCnyRLFP7Dzh/XchRuK0jo4KFyfEj7KZif9lsgnPihOLIntQS
         qpXrgmtDGi6rAaYXneQW6Q+QfmNpPa/vErAlBv24ViyJC8WXBhmMOW5muC5atrzlRcVK
         eMsA==
X-Gm-Message-State: AOAM532SrDQsSZp81M74iSMFkawf10xsr4QRa07jggAST0XzNMCxOhL9
        2Xk7i60qNnPeqGIJREUWB/ts7A==
X-Google-Smtp-Source: ABdhPJySHEslyEih5kQLA88oXODQQ0Wi1oBA6Q/oIq4BZUbKZolgVJv44EvipwhBEGygRsph69B2tQ==
X-Received: by 2002:aa7:8703:0:b029:2da:b87f:7d38 with SMTP id b3-20020aa787030000b02902dab87f7d38mr2569228pfo.20.1622101332688;
        Thu, 27 May 2021 00:42:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ece5:55a4:6ad3:d20f])
        by smtp.gmail.com with ESMTPSA id h24sm1184857pfn.180.2021.05.27.00.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 00:42:12 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH v6 RESEND 2/3] drm/mediatek: init panel orientation property
Date:   Thu, 27 May 2021 15:42:01 +0800
Message-Id: <20210527074202.1706724-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527074202.1706724-1-hsinyi@chromium.org>
References: <20210527074202.1706724-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init panel orientation property after connector is initialized. Let the
panel driver decides the orientation value later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index ae403c67cbd9..9da1fd649131 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -964,6 +964,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
+
+	ret = drm_connector_init_panel_orientation_property(dsi->connector);
+	if (ret) {
+		DRM_ERROR("Unable to init panel orientation\n");
+		goto err_cleanup_encoder;
+	}
+
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
-- 
2.31.1.818.g46aad6cb9e-goog

