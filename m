Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E366436DDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbhD1RFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbhD1RFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:05:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E78C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:04:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a11so2315656plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUBR0WopHj0WR6JMHf2d83zcvjlEdxgAs9fymIBITzo=;
        b=CZh4ewpebCFcAjzU4EibSFFnrvhXZVPNRc4wOzEuTvrh0wTnh9QHrTxtcPEp03msf7
         p7qFTJYHHFvKYz9uDrzBQ+Qy+3fq16YM4Kqd8u0m6gWqZLA9Q5vHC5ZZ5f6tWNAMjifU
         mPdOOxsXHBf119G0QvEHwNweX9sC3c6CawxkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUBR0WopHj0WR6JMHf2d83zcvjlEdxgAs9fymIBITzo=;
        b=btWL56rYvhPr4RIIVoeJ4kF1YUNTfqO0zg6T447rG7PKhS+yZfxgke8zk8UEXUXvLJ
         qAZKDQByJ70BdQwxvO6Op84ys5E/gOP3Zi+tutFwahoHzKhfm+fK7FXr5N+s3IeWfa3U
         BkJexGj44QemP6x7o0bSBnssbuxpEe/I/PdcGZtXLLTZKSzF20uzhP0fu93+Yn7wckns
         juzr9UENrrPu40KuPtUSfsHxcolhoQRyJT7kZJAXIjcH74fV83deW3dqlWdXRR0XnA8Q
         9lvwAQFy7dRZPQ8aVPdFX2qp27928+nSzIRH14FP54cE5oEuM713Wf5TsEbZ+/uiLy0o
         wFEQ==
X-Gm-Message-State: AOAM532Jm0fC+x/hA1/ED3uKL6I3/Icof86vd/MnxFrcIkgt1/H4pBqU
        XBWWEFuKI5rIVQw8AkyJh9xlfQ==
X-Google-Smtp-Source: ABdhPJxVuaBy5Crg4238Rnf+mjDK9f2leKWDPf3f+mhW2AoCjVsaiScJhXB+4Y2JkeULZDYrLebEmA==
X-Received: by 2002:a17:90a:e298:: with SMTP id d24mr10097975pjz.144.1619629466765;
        Wed, 28 Apr 2021 10:04:26 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1faf:c32e:8742:d913])
        by smtp.gmail.com with ESMTPSA id c8sm244351pfp.160.2021.04.28.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:04:26 -0700 (PDT)
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
Subject: [PATCH v5 3/4] drm/i915: init panel orientation property
Date:   Thu, 29 Apr 2021 01:04:15 +0800
Message-Id: <20210428170416.1027484-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210428170416.1027484-1-hsinyi@chromium.org>
References: <20210428170416.1027484-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating the panel orientation property first since we separate the
property creating and value setting.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/i915/display/icl_dsi.c  | 1 +
 drivers/gpu/drm/i915/display/intel_dp.c | 1 +
 drivers/gpu/drm/i915/display/vlv_dsi.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 9282978060b0..162fb3cf0f5a 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1903,6 +1903,7 @@ static void icl_dsi_add_properties(struct intel_connector *connector)
 
 	connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
 
+	drm_connector_attach_scaling_mode_property(&connector->base);
 	drm_connector_set_panel_orientation_with_quirk(&connector->base,
 				intel_dsi_get_panel_orientation(connector),
 				connector->panel.fixed_mode->hdisplay,
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index a5231ac3443a..f1d664e5abb2 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5263,6 +5263,7 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	intel_panel_setup_backlight(connector, pipe);
 
 	if (fixed_mode) {
+		drm_connector_init_panel_orientation_property(connector);
 		drm_connector_set_panel_orientation_with_quirk(connector,
 				dev_priv->vbt.orientation,
 				fixed_mode->hdisplay, fixed_mode->vdisplay);
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index 9bee99fe5495..853855482af1 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -1632,6 +1632,7 @@ static void vlv_dsi_add_properties(struct intel_connector *connector)
 
 		connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
 
+		drm_connector_init_panel_orientation_property(&connector->base);
 		drm_connector_set_panel_orientation_with_quirk(
 				&connector->base,
 				intel_dsi_get_panel_orientation(connector),
-- 
2.31.1.498.g6c1eba8ee3d-goog

