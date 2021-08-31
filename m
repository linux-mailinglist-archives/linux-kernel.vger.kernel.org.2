Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D73FCE65
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbhHaUWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbhHaUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:22:42 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CB5C0617AE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:46 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id i13so540979ilm.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aQgzlM6bufLJJz+lhddL1EzpIX3TCLzK+pfF17zKmc=;
        b=HZi4nhNHvgUWeuFtXbQxyQmtp+hamEPox812vfdSm9trSzRzb4PrgLdRxfZw/MwOg4
         88PQyG6djgMEbvT9q/RiXmMK7GkLsnoX8UeLTQxb1zpeuMdVU5pi8TEQKIuVg7KIrBln
         QBV9vriJ9c0ryb7mH8wq1NS8PfjmBRDlmbzviAvTuyRH/ibjGWCgyPssKMV4wTgzMJh0
         UoDwLv/MUkUSJq4RdDan7+mCZzxPS72qzgkac5lANtTo0/2YuIxQiVJvrDO/0onhbzMQ
         HXwjU16jjZNySuAJEIt5f3Ry9IqUyIs8nTD269GcxqAjT0d3m4SaOErgjSx+gIjDSy3V
         yewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/aQgzlM6bufLJJz+lhddL1EzpIX3TCLzK+pfF17zKmc=;
        b=UtMapey6Cc3eERtJuCx29wOwncry9/pWVmT/wODwW7Ldw0ptlGsZDKXOs2pnkimCK0
         HdhT/niJmgoBusaGBP3mdEvxE6RsAkw/V5I3cgQ5ozR2gbmqw0x1RU4m+/+RNjxjE1d3
         zr5Mk+8l5EIRFL+v3amIO9Rpv+lm33cnYW53cFVkRAcJ13mNI/tVuFAFLJQIJzgJHHhH
         LJ+PlocpaEmmwwu3kZBIN+LlLyXM/w7RTiYv1VPppD0b6ukk3+4HSLYFybLuhleUseZE
         02+PED+Oe3FlK4Htu/ZxmwjVsNqEUjR9dQkkrpBUAy2yvTeH093HH7rryYNNCkyERx1Z
         wizQ==
X-Gm-Message-State: AOAM532tGXcrTvGY0N8oZlwIXZDqNrnmvtftpmvbHK4SNKQfCAUFVkao
        u7L0WAWyeWMPqoAzWLKmUEs=
X-Google-Smtp-Source: ABdhPJwm+w3tlXwW2CSDZpMztq6O6HI+4KqEByRUeDEkX0QkIUL05KoKl6K2RdTvpHIwZihdpooYzw==
X-Received: by 2002:a92:c241:: with SMTP id k1mr21807966ilo.270.1630441305804;
        Tue, 31 Aug 2021 13:21:45 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id u15sm10597384ilk.53.2021.08.31.13.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:21:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 6/8] drm_print: instrument drm_debug_enabled
Date:   Tue, 31 Aug 2021 14:21:31 -0600
Message-Id: <20210831202133.2165222-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831202133.2165222-1-jim.cromie@gmail.com>
References: <20210831202133.2165222-1-jim.cromie@gmail.com>
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
 include/drm/drm_print.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 973443040561..03f9ae83fade 100644
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

