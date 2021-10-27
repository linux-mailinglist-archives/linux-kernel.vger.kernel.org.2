Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1394943C1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbhJ0EkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhJ0Eju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:39:50 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F12C0613B9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:37:24 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e144so2123312iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7iYW4I4CStTbC9vQQqx1wbnaW7QfaWOV+gu+PhQHi68=;
        b=bwhmmQWaeTqGmfGhryL8vuXPioJB6//CiznbOIm2iZRVPl+AcEv1t65GnJrm3HtNuO
         ZBH7pXp8+qRNbXE0VVi/gb4lkEat831GjKilUCXymAF27Fy+r0vJhL6Dmp+SNaZw8ycM
         4c9X1c6sUb5qNz8/QUN6Ih55N5s51IrpLl9SeYAQ3QS5NEGA0PHUd4ksB3mv2MnovIZ3
         KjVo1J3ALQUK5ZmRSq89qyFRBA1ms9LJRBK7gsKxM7ZmJf4MXYNHgHQYJTL67sUKr2vo
         vjLKq6FIwKO4/v+3wGYJlbk+EbMI6EETArObjvi/15aDCG2Yo274Ng/+NSGiwvsKGvDC
         nIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7iYW4I4CStTbC9vQQqx1wbnaW7QfaWOV+gu+PhQHi68=;
        b=vVFHCWLY9ZZsDtwjY9xbnUIoRkEsisPYYFimstz5y8fQxoMHkMJWmfA66kGZjK91iA
         71o934wrt5CzOMmAs2X/LF1iC6opH7dFpUd3JvUWHpJyWmcau6xqEAGfWUbuUVCXtosp
         SJRoSbH7vuzJWpIkz6gErs/zFBEbWByaTiv/HwqbJf8Zi+u0E6KIMrWgdE71ximDqXrY
         GIA9kq17CKFHu0YJI3nF5GndKlg86bqVb+mC7NwvDpa+Y6CNPe+sQn6lA/6CVUMrq2jT
         Ic9Ym74x4mb+KR2La8MYp5ZHCGtDJpuiY3yNdHXjH6+adVcjAJ3QgKljV10LPosdWbDA
         f9OQ==
X-Gm-Message-State: AOAM533N+Y14uwZhGIpcxuwHDy+8B5+TsL3n4OJYVW3G6lP2focSA6oF
        pqeAXZm/GWwdh0emYzCb3uo=
X-Google-Smtp-Source: ABdhPJz4nVn5zyXeRfn7gHHvpvDCVU+3Y3rIZxzBfd8KgODE1Ou7nwBG8jJvpQ1lwq6FuX/hS41vVQ==
X-Received: by 2002:a05:6602:158a:: with SMTP id e10mr18367339iow.157.1635309444000;
        Tue, 26 Oct 2021 21:37:24 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a15sm2030404ilj.81.2021.10.26.21.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 21:37:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 07/10] drm_print: instrument drm_debug_enabled
Date:   Tue, 26 Oct 2021 22:36:42 -0600
Message-Id: <20211027043645.153133-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027043645.153133-1-jim.cromie@gmail.com>
References: <20211027043645.153133-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate drm_debug_enabled() code into both "basic" and "dyndbg"
ifdef branches.  Then add a pr_debug("todo: ...") into the "dyndbg"
branch.

Then convert the "dyndbg" branch's code to a macro, so that the
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
 include/drm/drm_print.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index cc853314f44a..36373a91c9e0 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -381,6 +381,11 @@ enum drm_debug_category {
 #define DRM_DBG_CAT_DP		DRM_UT_DP
 #define DRM_DBG_CAT_DRMRES	DRM_UT_DRMRES
 
+static inline bool drm_debug_enabled(enum drm_debug_category category)
+{
+	return unlikely(__drm_debug & category);
+}
+
 #else /* CONFIG_DRM_USE_DYNAMIC_DEBUG */
 
 /* join prefix + format in cpp so dyndbg can see it */
@@ -414,12 +419,13 @@ enum drm_debug_category {
 #define DRM_DBG_CAT_DP		"drm:dp: "
 #define DRM_DBG_CAT_DRMRES	"drm:res: "
 
-#endif /* CONFIG_DRM_USE_DYNAMIC_DEBUG */
+#define drm_debug_enabled(category)			\
+	({						\
+	pr_debug("todo: maybe avoid via dyndbg\n");	\
+	unlikely(__drm_debug & (category));		\
+	})
 
-static inline bool drm_debug_enabled(enum drm_debug_category category)
-{
-	return unlikely(__drm_debug & category);
-}
+#endif /* CONFIG_DRM_USE_DYNAMIC_DEBUG */
 
 /*
  * struct device based logging
@@ -569,7 +575,6 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 #define drm_dbg_drmres(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_DBG_CAT_DRMRES, fmt, ##__VA_ARGS__)
 
-
 /*
  * printk based logging
  *
-- 
2.31.1

