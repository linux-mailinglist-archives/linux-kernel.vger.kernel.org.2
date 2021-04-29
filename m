Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E52B36E43E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 06:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbhD2E3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 00:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhD2E33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:29:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875CCC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:28:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d124so2461413pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5arbhYfGXT82qjQUTN0xccKMerRCIU7+UPVnm07W9Y=;
        b=G85VcZJiBhrc0Z+xTBYX6C5fC+iasG268uM+qWiT0xg/xpPu0RRhUrnr8buAZ+LlV1
         lSKD7pRAcedECmwTgS8kTxBRZ76a6Itsaz2/daIKpP6tkNusndubKuXvj0rjc6r64pQ6
         ektV8bQmN/zPS9egbWIlp0qx+zMjeyKhAqJOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5arbhYfGXT82qjQUTN0xccKMerRCIU7+UPVnm07W9Y=;
        b=TwCfyaEp9o8/XvZ3yz/vD7DtAsj5TS7Qam4wcBPG78/Wm7Bp6CofR8K83dDwVDvrc3
         xOxjmumG507Y7zoW4DKUkmjQBXE2SUT25nVKxeSTs1LEVW89/jbjBotzeBibKnlTPXQA
         XQgyhu1LNAeuDSqRvilkOOaCok/trccv0E11H3bSucfcfSj+iUE2YmI1EIg3nh+y1fDY
         5p/5pvb9NIN80pHL4qG/84KTEzUbZsp2CuqYY8Fiw4KybbL6U36m2FGAhKHQLVOW/Vqv
         vOttbS7DaWM/+3Pd50ne3wQL6Wsk6LgV4JtXxZ/JpBOZ7+c4yd4TCLarpxaa+7HFx8Qe
         3ZgA==
X-Gm-Message-State: AOAM533cl/duRbopfptWBbw7Nk51acUZcBYRK0s7OOWaalx2MWU8J0lu
        Z46rnkmgiHVGkr3eofJf9tC0xQ==
X-Google-Smtp-Source: ABdhPJz7d0lwcYiWWsZ+p9irRnLEfdh2OXdUkleFkMQkFzA1hAfKA+4YpXWMxwylDQGJh7nhUk4LhA==
X-Received: by 2002:a63:4550:: with SMTP id u16mr30275755pgk.440.1619670522054;
        Wed, 28 Apr 2021 21:28:42 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:f701:2ca2:56ba:8e83])
        by smtp.gmail.com with ESMTPSA id w124sm1069390pfb.73.2021.04.28.21.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 21:28:41 -0700 (PDT)
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
Subject: [PATCH v6 2/3] drm/mediatek: init panel orientation property
Date:   Thu, 29 Apr 2021 12:28:33 +0800
Message-Id: <20210429042834.1127456-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210429042834.1127456-1-hsinyi@chromium.org>
References: <20210429042834.1127456-1-hsinyi@chromium.org>
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

