Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5240CACA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhIOQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhIOQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:42:15 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1484C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:55 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x2so3552048ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6exbJ96DRAUwSDXN6VLx3tabOaZjxnXBHHpYK96D7s=;
        b=S+R3qkzE8FHmf9BfggSx7Gjol2ncVKgQGlHOEAv38FJbN1gLb65YIRExwXl14H579g
         o1xaY685XBeQxXhA4Mi23cx7NYM2TB+yxiIbvQQnoqpfr0Y4ujuQojX+OGf+Qb/pAZD6
         67JzS4G6QWGzKATuODPf6+963e9cYgE2It6ijB21OWSMlT0EMoG+j9nwoAYXJLkK/0bd
         T5podgLlzl5jMfn0KLusI6Ll4Sfm4CaUvR+94A/kGFjXtjTK4ZMpg7uMa/iMLqJEHaWM
         DPzuNGwHUTcHYK1k03YPaAMppFMqF+9MrNV3l2CRZhKFaolmzrY1Jj4rQuXdkYp9/sMn
         y4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6exbJ96DRAUwSDXN6VLx3tabOaZjxnXBHHpYK96D7s=;
        b=gFxCwtW+saiJUNMXPQmC2Tpjlyun3Czjui7JzpGjasWGpdxTDA3nmaaYG541Oz0huj
         hS5sSIgyo12ig8r7qqSZFuccN0yt/xsWOo6Lb1yETbcSNEOLjeCfcc6s/hlJJeZFYL1I
         vjeT/jzMUJP9rO5gLrs6aQRLojdALgB56ub7OY58UvlM30bPHmcLYkDopwE1GTq6SZ8/
         U4CexCJTfpi9STjWp4Sx0h9JgI12NJa320pPNFL2qIrozMEvtcD6wQp198bLQjmNSLIF
         8LbzX0YqszSTgTXiKgsmxJuhJwKAUol8wEWj7rO5p4bhU0cd9f4VqfDSu1gQ3VtOFyN0
         BuGQ==
X-Gm-Message-State: AOAM532Q2WyJA4kk/f+nTmKswC0jYLfXUvCfEeoBcYAMxGa157XMuJcc
        7FynKgtcAlNO4+UF3STIk0o=
X-Google-Smtp-Source: ABdhPJwl8+MbL7a2+4QomeoiJql1rTLvPFjVkec1XA19bBqKvTTPOamQ1o1jm6tgFSVA+57UvMPC0Q==
X-Received: by 2002:a05:6e02:1a28:: with SMTP id g8mr767821ile.158.1631724055203;
        Wed, 15 Sep 2021 09:40:55 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:54 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 14/16] drm_print: instrument drm_debug_enabled
Date:   Wed, 15 Sep 2021 10:39:55 -0600
Message-Id: <20210915163957.2949166-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
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
index 4a38591a424b..c9cabc8db672 100644
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
 #define DRM_DBG_CAT_DP		"drm:dp:"
 #define DRM_DBG_CAT_DRMRES	"drm:res:"
 
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

