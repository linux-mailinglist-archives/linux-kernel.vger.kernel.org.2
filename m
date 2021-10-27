Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739B343CEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbhJ0Qal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbhJ0Qaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:30:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67286C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:28:14 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bp7so2938114qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kcaw11fIjDklEqqCtjykwfsrJvW1LW9AxQoWbgSjC4M=;
        b=Ua/sCb/y9VDGpUgeNnsC/TY1iozBS8HSs8sB4TzNnEPa+6427LOWQi6WL9uSP+9r0f
         KGOwJodnrSB2fiQhxLQFuuW8O4HKPNi3pVV1x8cV2XHk8wFzt0Z2GsjSi96dOsDPs1pd
         jAq2oO9A9mstmfyKZ9gWU7sZY5Lj5IMLSkyfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kcaw11fIjDklEqqCtjykwfsrJvW1LW9AxQoWbgSjC4M=;
        b=vcs5OBrJGW+IPcpIznHW9LKaeKaNTQlu1MFpI4S6UJfiNzxAB3t5Yw9MxxvB7uncnC
         ELDLQ95nZVNp8CkUVgQg9G0yq28XQ7jXkWlhrp7S88tTgOHKlC0f9I2P2Ogwl/Xbq734
         8Fc8QXvyYFYuJtU7daMrO4vq+TUzjvz55PrFs8ZbEdRTUQFpjbbHUhu8YdVRQlUCiLxd
         K1+zWz9QuvEo6h7M2RQ1zkmUlfU5DhubaCb0jqi2N0R/6rzCVFklVr3SA3wmQWHyRZo2
         N23u9KlMsGlU+XknMh2LNkM54TT/HAewF/LH+yyQfc0Ze58Vj8rIin/jkLJI0V6czx/A
         JqZA==
X-Gm-Message-State: AOAM533CVAZyEqG6oCcSMNBdXRsPD7fUpDn91hVdCPWV3v3ycIkmEW4a
        eE8DkG7Ffn9RySH5u6x73sIiJA==
X-Google-Smtp-Source: ABdhPJzvDL/hbW8x3WlZ9XGRkGRqMyNVExMy38ru/QmkZqYlZSlc0XaIiKT5o4RWmWJvhzMO0AsrYA==
X-Received: by 2002:a05:620a:1035:: with SMTP id a21mr8908441qkk.354.1635352093630;
        Wed, 27 Oct 2021 09:28:13 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:121e:94ae:f1a6:940c])
        by smtp.gmail.com with ESMTPSA id i22sm311589qkn.80.2021.10.27.09.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 09:28:13 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
Cc:     seanpaul@chromium.org, Mark Yacoub <markyacoub@google.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: Set the default value of rotation to DRM_MODE_ROTATE_0
Date:   Wed, 27 Oct 2021 12:27:51 -0400
Message-Id: <20211027162806.2014022-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@google.com>

At the reset hook, call __drm_atomic_helper_plane_reset which is
called at the initialization of the plane and sets the default value of
rotation on all planes to DRM_MODE_ROTATE_0 which is equal to 1.

Tested on Jacuzzi (MTK).
Resolves IGT@kms_properties@plane-properties-{legacy,atomic}

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index e6dcb34d30522..accd26481b9fb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -44,9 +44,10 @@ static void mtk_plane_reset(struct drm_plane *plane)
 		state = kzalloc(sizeof(*state), GFP_KERNEL);
 		if (!state)
 			return;
-		plane->state = &state->base;
 	}
 
+	__drm_atomic_helper_plane_reset(plane, &state->base);
+
 	state->base.plane = plane;
 	state->pending.format = DRM_FORMAT_RGB565;
 }
-- 
2.33.0.1079.g6e70778dc9-goog

