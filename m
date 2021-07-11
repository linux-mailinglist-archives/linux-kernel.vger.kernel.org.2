Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8893C3ACE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 07:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhGKFxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 01:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGKFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 01:53:01 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3DFC0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 22:50:14 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k11so18080342ioa.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 22:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUO2MpmIkpz5hk5OMfz1zDgFEamJA/bkKepVVtTsO3Y=;
        b=T4Bint3avKEjdVQFJ7H5Ua1fzhlTvfSMpuzlZmEEZG33uATVnS2zsOLqCj6E5OlDg4
         w/NzUJn/Vv+xBQ8mf38wNDPJw1cZpG28KjosfLSogp9v83s90/WTtKrWB+f8s0K4XGi7
         iwgJkE00khPeZIogUHxqCPws98ajYDOmesx1i7a1SoqhQbab1WNvUZ8BugX5QfGleDkU
         +fUNcdCKrZZPbll2ijV05C8/qpQbb/y1x2gv54G8KoKm72GKEFWL0HkCoU8HMs8qzfb0
         fKxdXpm7Vrqiush5gOvoo1WUiLTL6149BinTO35ID1N5E1mACgqGaZG4oV04NCjHOmep
         adTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUO2MpmIkpz5hk5OMfz1zDgFEamJA/bkKepVVtTsO3Y=;
        b=IAn9Hs0h5z2QjegrpECRFfBRoqdwFpR7RwftAReZhhV/qGHH6GpfKIoYVMo8GX5BTd
         kqzgnMIgWUa9Zv9xLvtxuzcNSq87AefRPlYT6OPZa0/FXmjsrMIUT0D2L7RwSR0uOGXU
         PK0pADMYDVOdtHfIALcITigQ7JeGLck4WWvREQfOEOHWnvau37cBAraTQqaAxoo7Tn5S
         B71axkyMSLkeHrIinofvy5gC1qjlWpnixYhbwiwCjT/mWR4kzYVz6SX2ijAZAVRnV2x0
         4mSDCFpAm3OoqobK3RxOeo6SCasBMzHhr9XxxTdmh9eAbFTjlo+Uf7jn2qMXOcoODt6l
         qzTw==
X-Gm-Message-State: AOAM531tdCv1v3GlOxFsfqeJ+q4nNtasVtDlQvVWuuhSlVF6kUMvloEn
        kkAzWXXt7GpchfAENVc955ua+nxUswCg84Tg
X-Google-Smtp-Source: ABdhPJxPNSdXW2SdBDXeauqnEm3MMvu9wOMXaZZkOzhx/qrun+yLXndZvq+sF/ai7j76OQxBZYcDXA==
X-Received: by 2002:a5d:8511:: with SMTP id q17mr35667488ion.98.1625982613674;
        Sat, 10 Jul 2021 22:50:13 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x8sm5852400ilq.63.2021.07.10.22.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 22:50:13 -0700 (PDT)
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
Subject: [RFC PATCH v2 1/4] drm_print.h: rewrap __DRM_DEFINE_DBG_RATELIMITED macro
Date:   Sat, 10 Jul 2021 23:49:59 -0600
Message-Id: <20210711055003.528167-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210711055003.528167-1-jim.cromie@gmail.com>
References: <20210711055003.528167-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

whitespace only, to diff-minimize a later commit.
no functional changes
---
 include/drm/drm_print.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 9b66be54dd16..6419b4e7c5dc 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -524,19 +524,24 @@ void __drm_err(const char *format, ...);
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
+	if (drm_debug_enabled(DRM_UT_ ## category)			\
+	    && __ratelimit(&rs_))					\
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

