Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA30437BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhJVR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbhJVR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:26:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D7C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:24:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a13so5178464qkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bhRqLM6yW3BElMhr6p8JxBlLhkjCyrvm/fO8BA6PxAc=;
        b=n0REBVugNN6h/yPp0kthsRhifZEkvICP1H0DNb4lHJcDlVhDv7nMaKJ2Vhs+3mG8wb
         P+9hayC3ZcaTRQbQ6Yg/emEujycTI0bGB0+E/8Au1iQ2EaTxB9N8pARvjQsu5l7fjzyx
         LXthrCGguKWkBeGh5u6EqjmXuYKmprV7mEMPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bhRqLM6yW3BElMhr6p8JxBlLhkjCyrvm/fO8BA6PxAc=;
        b=jG7x+Zk8pjJLzXhPKobDjyG2nZXTnUXQXnMRxrwomId4Rsjb7j3nDt/hhNBM+irszz
         ifrlAnPYIP3745ERvzcoMcUzmT1GtRuvEdbBPpa4TNhT3zMz+ynPayEZZHoyHYY9Kl4R
         AJ1cf6sHtlP29ZF4yxEkkDVOMy6US0zEnjQ/aPbeAVuGs2nzqchX69T1sjrfqtKAOFm/
         8/oHQr7uc+DBac75tpmTokYcN20lAAl3cuLQAG7/tUVFo+wLOpOlzdAPu+6z20/ZkiMj
         y04kLqrGsQPBNfTT8WI5cwekq4rUU+HU10yl/+HlA65XcnQOo6hG/yd2pRhvqv9dT9SR
         vjaw==
X-Gm-Message-State: AOAM531JVXA76yC/3fhQ3MauTyQ9FIkSNokpJLvvQJOl4ec3oDwAL5zo
        JOVYCaBPUVs+mUNrkZ8adAhVZg==
X-Google-Smtp-Source: ABdhPJw5+Z3gbQpB89P9MYXrYchvZhhA7n6NVaZf4RXniPOT8qvw6+uopCRuEw1xS7/oSzdg0o1iFw==
X-Received: by 2002:a37:a2c1:: with SMTP id l184mr1122332qke.71.1634923459566;
        Fri, 22 Oct 2021 10:24:19 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:6c36:8d9f:c50a:b0f0])
        by smtp.gmail.com with ESMTPSA id m17sm4607611qtx.62.2021.10.22.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:24:18 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     seanpaul@chromium.org, Mark Yacoub <markyacoub@google.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mediatek: Set default value for Panel Orientation connector prop.
Date:   Fri, 22 Oct 2021 13:24:03 -0400
Message-Id: <20211022172413.195559-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@google.com>

[Why]
Creating the prop uses UNKNOWN as the initial value, which is not a
supported value if the props is to be supported.

[How]
Set the panel orientation default value to NORMAL right after creating
the prop.

Tested on Jacuzzi(MTK)
Fixes IGT@kms_properties@get_properties-sanity-{atomic,non-atomic}

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 0ad7157660afa..b7c2528a8f41c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1039,6 +1039,8 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		DRM_ERROR("Unable to init panel orientation\n");
 		goto err_cleanup_encoder;
 	}
+	drm_connector_set_panel_orientation(dsi->connector,
+					    DRM_MODE_PANEL_ORIENTATION_NORMAL);
 
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
-- 
2.33.0.1079.g6e70778dc9-goog

