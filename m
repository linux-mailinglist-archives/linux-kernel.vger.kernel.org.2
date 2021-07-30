Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613F73DB22D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 06:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhG3EQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 00:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhG3EQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 00:16:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0AC061796
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 21:16:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z3so8208140plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 21:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNpsX16ewG1iiORmtZLS9PvQb+EIL7dKmm9U42mmA8Q=;
        b=Ud7pUpMBgAV45KErEo5arYi0ZcWV1YkNk6F+QLPSB30bGRKkONHEmqIRmG2KMw2Azu
         kVhstTDTB5rjbdYv9QPkLWm+Rv1i1WwKTb7RvgVzPu5mkfgNZF20GrQi+jAVE5f3+azw
         oMPXalcmC0aS0bc8T7aHFlZKblk/EC7SyVGAHOTjrc9rXv9ddnfTK5dDuTYK+eSIwlPz
         uCrh5ASccN6GsO8hrS+WeI5tu9+Ra1jfnSg+dqn/oZBjIbgVW+lbnuOIJcEBG1TeB/g3
         8fqUS5eZXhV41aBF5xyk4RcX7dLEPjYXcR1TsbCCREqiAStlfropXNwTEa2dJCERam7V
         Py9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNpsX16ewG1iiORmtZLS9PvQb+EIL7dKmm9U42mmA8Q=;
        b=eDoEUbmYEi1lJK5SwEq2SrswRKbYpPjNZb/jppcu15H2oj0I7hrVDOU+zHjWMKDyTf
         TMOlhmoHazM+fVMER0eWdIhn1PcXb6uULGRdgD45svv4M8CFVzVjbTClvZVeHtmmfhzW
         igzJG+JZh48XYteTszJNQeee7/zEl9JpkdASeYcjMNHwgpLJUlaz3VozRS1U+ieKaN2k
         dXiop53MGGyOEDi1OjejqBpIoinTaLLqfWEDA/Paf8nEZeEYJnDc30CuaGcSHiX6G6IK
         2NvTatOoWQ8+y+PDSSAePhlU6oi4+PVRoCzJe7rzNX28L6rx7253nUn5MlN3xCmRO4Ri
         0TOw==
X-Gm-Message-State: AOAM533EYiVK1SeT1eqhQERw/5EAyai2ugk6HlkT3VYq4mD67+E8UNOm
        gtZHWVSymnhl4F9nXMVaEUg=
X-Google-Smtp-Source: ABdhPJy+yWGhf7xYZLTwb/KaVBrcXdWzABuAHT54038pNIzOFNYsKZwvgkD1vj1A8p77hKqIWyKIFA==
X-Received: by 2002:a63:dc15:: with SMTP id s21mr505834pgg.281.1627618567842;
        Thu, 29 Jul 2021 21:16:07 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id t19sm439322pfg.216.2021.07.29.21.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 21:16:07 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/2] locking/lockdep: Provide lockdep_assert{,_once}() helpers
Date:   Fri, 30 Jul 2021 12:15:14 +0800
Message-Id: <20210730041515.1430237-2-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
References: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Extract lockdep_assert{,_once}() helpers to more easily write composite
assertions like, for example:

	lockdep_assert(lockdep_is_held(&drm_device.master_mutex) ||
		       lockdep_is_held(&drm_file.master_lookup_lock));

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 include/linux/lockdep.h | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 5cf387813754..9fe165beb0f9 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -306,31 +306,29 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 
 #define lockdep_depth(tsk)	(debug_locks ? (tsk)->lockdep_depth : 0)
 
-#define lockdep_assert_held(l)	do {					\
-		WARN_ON(debug_locks &&					\
-			lockdep_is_held(l) == LOCK_STATE_NOT_HELD);	\
-	} while (0)
+#define lockdep_assert(cond)		\
+	do { WARN_ON(debug_locks && !(cond)); } while (0)
 
-#define lockdep_assert_not_held(l)	do {				\
-		WARN_ON(debug_locks &&					\
-			lockdep_is_held(l) == LOCK_STATE_HELD);		\
-	} while (0)
+#define lockdep_assert_once(cond)	\
+	do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
 
-#define lockdep_assert_held_write(l)	do {			\
-		WARN_ON(debug_locks && !lockdep_is_held_type(l, 0));	\
-	} while (0)
+#define lockdep_assert_held(l)		\
+	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
 
-#define lockdep_assert_held_read(l)	do {				\
-		WARN_ON(debug_locks && !lockdep_is_held_type(l, 1));	\
-	} while (0)
+#define lockdep_assert_not_held(l)	\
+	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_HELD)
 
-#define lockdep_assert_held_once(l)	do {				\
-		WARN_ON_ONCE(debug_locks && !lockdep_is_held(l));	\
-	} while (0)
+#define lockdep_assert_held_write(l)	\
+	lockdep_assert(lockdep_is_held_type(l, 0))
 
-#define lockdep_assert_none_held_once()	do {				\
-		WARN_ON_ONCE(debug_locks && current->lockdep_depth);	\
-	} while (0)
+#define lockdep_assert_held_read(l)	\
+	lockdep_assert(lockdep_is_held_type(l, 1))
+
+#define lockdep_assert_held_once(l)		\
+	lockdep_assert_once(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
+
+#define lockdep_assert_none_held_once()		\
+	lockdep_assert_once(!current->lockdep_depth)
 
 #define lockdep_recursing(tsk)	((tsk)->lockdep_recursion)
 
@@ -407,6 +405,9 @@ extern int lock_is_held(const void *);
 extern int lockdep_is_held(const void *);
 #define lockdep_is_held_type(l, r)		(1)
 
+#define lockdep_assert(c)			do { } while (0)
+#define lockdep_assert_once(c)			do { } while (0)
+
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
 #define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
-- 
2.25.1

