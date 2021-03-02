Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68F332ABF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 22:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347567AbhCBU6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347493AbhCBSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:07:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1792C061224
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:57:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d2so2525816pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0XgsYWzCDRLhsNvXhAFsWAxsY9xHFp6XSF1To7GMYQ=;
        b=YLXgMyNgQnRjv23cdr0A9TqS5czUZWEqzjL+SQxCKArJAenMg38p+18B8lgzV/8W4O
         6MzfIGFKr7GFV33hd1rAckk4m5r4+6cECKAnMmht559jzSqe0nza6AoCUM5mLtb3bz2+
         bT/JSMkWWSIB0AxeshdzbRMy8Pi7xG/9lxKuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0XgsYWzCDRLhsNvXhAFsWAxsY9xHFp6XSF1To7GMYQ=;
        b=hT2HYns2KEgMgGnvVd2OERxSCGeXfxPbUu7YgQ4gVO7knpEZezYRqG249kPEDE0G/B
         lshe9VMhB0r6DPh0CJCGQDekdz3/VkJrWlYixAA8axa3HHjvUt43IxNC9bAjHbDqda54
         zU+WDrIzo0JLR0szsgCjAQ4rh/Ci6CrBIVpaaBKmgVJ3X0qSJkhD5iJboX49QFikcHqo
         tf42nNoktVWZnT8IxnWfYr0KJ/Hfa2G2JxRGFk8ZrJm/pAZL8appnpDQ0Nb9yWkiisdH
         PisNmk+/cQfnV2+3hQVJX/kqb6o8CsgVyTvbl9Us1l1K4aPtKNGbCPZbrjDg9XI/Dn63
         7gSA==
X-Gm-Message-State: AOAM531ZztbsVKtmRwFKdXBdlGbP84H1DEdu5ZNkwoXsDTiP2b1Z0sDw
        811UPHzgiC0lx6u/j83ElOKfGg==
X-Google-Smtp-Source: ABdhPJyo1UjGzp40tLRvvraXfpsxXnqkr/lo8Ai+kssmF8iV7dIyu7Zguv60AaGzSRRkEo9ejOaxTg==
X-Received: by 2002:a17:90b:1bc6:: with SMTP id oa6mr5801071pjb.86.1614707841197;
        Tue, 02 Mar 2021 09:57:21 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id e22sm18521329pgk.56.2021.03.02.09.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:57:20 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] drm/stm: ltdc: Use simple encoder
Date:   Tue,  2 Mar 2021 23:27:00 +0530
Message-Id: <20210302175700.28640-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM ltdc driver uses an empty implementation for its encoder.
Replace the code with the generic simple encoder.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/stm/ltdc.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 7812094f93d6..aeeb43524ca0 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -31,6 +31,7 @@
 #include <drm/drm_of.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
 #include <video/videomode.h>
@@ -1020,14 +1021,6 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 	return ret;
 }
 
-/*
- * DRM_ENCODER
- */
-
-static const struct drm_encoder_funcs ltdc_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static void ltdc_encoder_disable(struct drm_encoder *encoder)
 {
 	struct drm_device *ddev = encoder->dev;
@@ -1088,8 +1081,7 @@ static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge *bridge)
 	encoder->possible_crtcs = CRTC_MASK;
 	encoder->possible_clones = 0;	/* No cloning support */
 
-	drm_encoder_init(ddev, encoder, &ltdc_encoder_funcs,
-			 DRM_MODE_ENCODER_DPI, NULL);
+	drm_simple_encoder_init(ddev, encoder, DRM_MODE_ENCODER_DPI);
 
 	drm_encoder_helper_add(encoder, &ltdc_encoder_helper_funcs);
 
-- 
2.25.1

