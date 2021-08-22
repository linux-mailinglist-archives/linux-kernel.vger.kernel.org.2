Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD13F41FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhHVWVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhHVWVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:21:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346BCC061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:55 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so31317751oti.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NImqTCiBgLna+lubDsLYPmHeBlSQY6fcNq9UxNqMtcA=;
        b=gcJjRMlmfyYaQaYcrxuoWI1sdIm6jiEox/ljCzceKl0L/Ap7JN0JsfIVafUKj85N9E
         G2lf+V18utvTMHSTWSczKVtnsc9ojwXdzhWmjbN1h1chu80rse41Md3rXCB/KyyyKHAU
         oXmvVPNUBehVI0LR71zTk8V1gFHsz+KYfcXvw0IBrK3phXdZ4PzOibutYFjjBibz8UvR
         3ZHnWYFJf8+XbrjQqmlGkEoCZ+n41dwRooGhtPKX6L4SYvGB1n58F82g6BBeIqwNSmEv
         e0SbHjYFsc7gRBMWNL1Y2o+tAAszwzWbU50TEs3rfWU9ZXATaHtvpXJxuvkK5zVFBkiM
         feoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NImqTCiBgLna+lubDsLYPmHeBlSQY6fcNq9UxNqMtcA=;
        b=sA7CaIsNexCjiieMKYj66ClP/qAGbpd6SD1AvmsneJ4VJaeeDX9HUxL1atcmGRf3oK
         uZyeWE3s9l3fGxjH0wpr0vLHr9AnQOJvYhCLfiIZ6VFaUIoj3Q9qLWnJesGxCLuDq4dR
         i+W7tYm3P8Uabz8YzPGIg0Gc+huVAuFATsPgojWCpdMse40P+/z100Be61D4jkup4nyf
         BGAHnwBTnfA4lISLTCAEfREWBL+LkRUIvuDAUyorV+qvm3QfP/cK1AYyifFeRFETNpzs
         5kZh8CfkedEjRglT0gMmcSarDeFMa1Xq+aNGhFPa8wGux75VTkGd2bOTDeeQ4QliB/iQ
         T6yA==
X-Gm-Message-State: AOAM531sxbJao9/cpkSRni+d+0YnhCNnIItkXAdY6+e+aOv7cZZf7T6m
        LLwUdT/4qNLuwnvLHFWXTFA=
X-Google-Smtp-Source: ABdhPJyM08jOd2qVALAViUlN3DnSciVGzMWk6TyGhrmK2Jl2EvKGNdE0c+udOzGzbasoNVBn1iQpjQ==
X-Received: by 2002:a05:6808:9b4:: with SMTP id e20mr9610450oig.57.1629670854613;
        Sun, 22 Aug 2021 15:20:54 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x198sm2964122ooa.43.2021.08.22.15.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 15:20:54 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        seanpaul@chromium.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 07/11] drm_print: instrument drm_debug_enabled
Date:   Sun, 22 Aug 2021 16:20:05 -0600
Message-Id: <20210822222009.2035788-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210822222009.2035788-1-jim.cromie@gmail.com>
References: <20210822222009.2035788-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate drm_debug_enabled() code into both "basic" and "dyndbg"
ifdef branches.  Then add a pr_debug("todo: ...") into the "dyndbg"
branch.

Then convert the "dyndbg" branch's code to a macro, so that its
pr_debug() get its callsite info from the invoking function, instead
of from drm_debug_enabled() itself.

This gives us unique callsite info for the 8 remaining users of
drm_debug_enabled(), and lets us enable them individually to see how
much logging traffic they generate.  The oft-visited callsites can
then be reviewed for runtime cost and possible optimizations.

Heres what we get:

bash-5.1# modprobe drm
dyndbg: 384 debug prints in module drm
bash-5.1# grep todo: /proc/dynamic_debug/control
drivers/gpu/drm/drm_edid.c:1843 [drm]connector_bad_edid =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_print.c:309 [drm]___drm_dbg =p "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_print.c:286 [drm]__drm_dev_dbg =p "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_vblank.c:1491 [drm]drm_vblank_restore =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_vblank.c:787 [drm]drm_crtc_vblank_helper_get_vblank_timestamp_internal =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_vblank.c:410 [drm]drm_crtc_accurate_vblank_count =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_atomic_uapi.c:1457 [drm]drm_mode_atomic_ioctl =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_edid_load.c:178 [drm]edid_load =_ "todo: maybe avoid via dyndbg\012"

At quick glance, edid won't qualify, drm_print might, drm_vblank is
strongest chance, maybe atomic-ioctl too.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
---
 include/drm/drm_print.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 8775b67ecb30..1f8a65eb5d9a 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -378,6 +378,11 @@ enum drm_debug_category {
 #define DRM_DBG_CAT_DP		DRM_UT_DP
 #define DRM_DBG_CAT_DRMRES	DRM_UT_DRMRES
 
+static inline bool drm_debug_enabled(enum drm_debug_category category)
+{
+	return unlikely(__drm_debug & category);
+}
+
 #else /* CONFIG_DRM_USE_DYNAMIC_DEBUG */
 
 /* join prefix+format in cpp so dyndbg can see it */
@@ -397,12 +402,13 @@ enum drm_debug_category {
 #define DRM_DBG_CAT_DP		"drm:dp: "
 #define DRM_DBG_CAT_DRMRES	"drm:res: " /* not in MODULE_PARM_DESC */
 
-#endif /* CONFIG_DRM_USE_DYNAMIC_DEBUG */
+#define drm_debug_enabled(category)			\
+	({						\
+	pr_debug("todo: maybe avoid via dyndbg\n");	\
+	unlikely(__drm_debug & category);		\
+	})
 
-static inline bool drm_debug_enabled(enum drm_debug_category category)
-{
-	return unlikely(__drm_debug & category);
-}
+#endif /* CONFIG_DRM_USE_DYNAMIC_DEBUG */
 
 /*
  * struct device based logging
-- 
2.31.1

