Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AE36DDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbhD1RFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbhD1RFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:05:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DFFC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:04:24 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d10so6807251pgf.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5arbhYfGXT82qjQUTN0xccKMerRCIU7+UPVnm07W9Y=;
        b=Oh1pOQY3nDNpYWg6CBPvoxbwz9Lp5/mgbvExVmkdIhmJlVZGash3DmwrmBb4CIKHon
         qhIf723E2NT3KLDzilpKerGauzvnOHbY+s/nFoAFNFIGUDyS721zHl0d0K2csd5vwIJO
         eIVQuYBad9ZmHQ0iSC96gsmAMu/m1PJWWkJCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5arbhYfGXT82qjQUTN0xccKMerRCIU7+UPVnm07W9Y=;
        b=q1C+GvQN6ADPQkU9ekxijaFejAt4ZQpX3+KMZ1dWoF2uB/UqFvutJRhqRPGW4PJ83Z
         a4mveLXpV3Fu2SWY/Xt9IxNocEr87DUErS6DLFi/Ja/feFDvkgmXbhzX2H3Tu6fLbbGI
         MqRjbKVDQfuDCWATIaZSO2TfG/kTOfACMSW0Z61i75R+t/a5k9yQu5LmbpJKzT40r5cB
         6RCoAYhXZzNbweoN8Quly6aAp9rBm9rc0FKP4PCCLfyT5LtPUGRXuex6v+4ZmwIm1sAn
         4OSGev2shz+Y6MtlrpRArGJ+qvC3RjR/JDYFzKdM/oWj5rjjdPGd9wlaaVcqQ8c6VRQl
         uZkw==
X-Gm-Message-State: AOAM5330ej46yKMCtK3AcKx94mHdVnc6mrOOv85gWn2UiqZq6DhfSi7l
        vY9srMPEO3p8+TS1eP86jdCOiw==
X-Google-Smtp-Source: ABdhPJxErM53epytFNpIJdI3/a9zdSqFrICBlsEBiJkNLoECwWzSEjPVpUQPi64CmaQN2g4Kj9Mq2A==
X-Received: by 2002:a63:1921:: with SMTP id z33mr28455929pgl.211.1619629464253;
        Wed, 28 Apr 2021 10:04:24 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1faf:c32e:8742:d913])
        by smtp.gmail.com with ESMTPSA id c8sm244351pfp.160.2021.04.28.10.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:04:23 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 2/4] drm/mediatek: init panel orientation property
Date:   Thu, 29 Apr 2021 01:04:14 +0800
Message-Id: <20210428170416.1027484-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210428170416.1027484-1-hsinyi@chromium.org>
References: <20210428170416.1027484-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init panel orientation property after connector is initialized. Let the
panel driver decides the orientation value later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
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
2.31.1.498.g6c1eba8ee3d-goog

