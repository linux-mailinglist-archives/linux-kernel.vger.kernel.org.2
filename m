Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AAA3C8A26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbhGNRyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbhGNRyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:54:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1051C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:51:51 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v26so3179376iom.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ea4AsRRmL97027kS3p/+NyUy1F1jMnaKQcqYl22WuEE=;
        b=ue40kFvKMJttvJ2rXiUJPQJNNFnMCW0Wu6rvpZkazuGGTfM8fegU8CC/kqb27Z/W/P
         2FcmrAvUoIZT5bISeVBbbYAWQg0v3ZWa5Qm9vDkJSXazSb1VY+v0Zh/+KBfmnmp1Fou2
         fv5MOmua7i6IIwO4ho/tMdtVHBHUAEHn1hKNqO8V9F/aRIuPsSbtK3pCMDO2NHrWlxfw
         bnj/BL2nuwERnZnHy9hmpSKdIDKzHAgqVc2i14A7NEiSSQKo0vyqQ5ErWaVRu712j2AH
         tLmM1YTs74TSSiNlBCOLK0ADeKIHo11OGqM8BzlKxTVnqQ2jLG16CCn2gqE/GLahcbQX
         pwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ea4AsRRmL97027kS3p/+NyUy1F1jMnaKQcqYl22WuEE=;
        b=LTcXjHAf7jjLg7t2SHkQT/9fzB3Z1HN3KfRGd7AIuMNjsqMWomVgiDfLHZiML0Gqd1
         epVDsFS6M9ngpnsYw2oNNhbVg0PAilpHhqBJvY5wDifvtpo5lhiw+sSW2uV5YvojbBUp
         OlH/Hb7US7Nl8Wp5hqK52Xt34Opcac9eBievebf1PSUZy2rieNF/rrOIBKwmK/fSZL46
         lq2TV9T4YmTtNwXaWkXw7tmxT0FxcSLaYQFUpzTvsgKYtigo0EJ86MZW67iTbgHmd09T
         nsWCeFxnUCa31yJ0TAyKANuWrtGztpGiGF5Bw3ct08UJ1dMn8WHE2crNTcJyLf4fAxw9
         Rdsw==
X-Gm-Message-State: AOAM53168rZw7TislMqdT6a3jeVTiBgAh/N2MhieDGPhnnlqOfl5lRth
        tlbITezkL1eb+LpGvUOfqE0=
X-Google-Smtp-Source: ABdhPJx2//ItOIAkrM4FJzs9OWu5rNOCwIUDOKO7EVTDAvqcwckhanULzcVS1fd2VxPEn1u+swEpLw==
X-Received: by 2002:a5d:8198:: with SMTP id u24mr7949208ion.81.1626285111058;
        Wed, 14 Jul 2021 10:51:51 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id b16sm706518ioh.5.2021.07.14.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:51:50 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jbaron@akamai.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 2/5] drm_print.h: rewrap __DRM_DEFINE_DBG_RATELIMITED macro
Date:   Wed, 14 Jul 2021 11:51:35 -0600
Message-Id: <20210714175138.319514-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714175138.319514-1-jim.cromie@gmail.com>
References: <20210714175138.319514-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

whitespace only, to minimize the diff of a later commit.
no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 15a089a87c22..ff5ac0e88321 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -524,19 +524,23 @@ void __drm_err(const char *format, ...);
 #define DRM_DEBUG_DP(fmt, ...)						\
 	__drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
 
-#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)					\
-({												\
-	static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);\
-	const struct drm_device *drm_ = (drm);							\
-												\
-	if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))			\
-		drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARGS__);	\
+#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)		\
+({									\
+	static DEFINE_RATELIMIT_STATE(rs_,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+	const struct drm_device *drm_ = (drm);				\
+									\
+	if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))\
+		drm_dev_printk(drm_ ? drm_->dev : NULL,			\
+			       KERN_DEBUG, fmt, ## __VA_ARGS__);	\
 })
 
 #define drm_dbg_kms_ratelimited(drm, fmt, ...) \
 	__DRM_DEFINE_DBG_RATELIMITED(KMS, drm, fmt, ## __VA_ARGS__)
 
-#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...) drm_dbg_kms_ratelimited(NULL, fmt, ## __VA_ARGS__)
+#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...) \
+	drm_dbg_kms_ratelimited(NULL, fmt, ## __VA_ARGS__)
 
 /*
  * struct drm_device based WARNs
-- 
2.31.1

