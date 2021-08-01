Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C393DC973
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 05:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhHADe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 23:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhHADe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 23:34:58 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95D5C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 20:34:50 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id d10so13445065ils.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuTXg0e3clW+MMWqMjMwfJqjaNCb4Ct1FoSRnnKkgJ8=;
        b=kC3SpbfGQStvm0vYCDgFFccoBC/d4pOGgv6VuIWBrntvaxsyMaVZZc7hGtP30YQI8s
         CpKdVoYLqeToXu/D392uoc4+5J2Ld5hYGS3ZyFJ0kHkkzrzLPE1Z0lhYp736hbm421hN
         NdEjKol+y8rgsYVHqiqHTrw/Ef6lHfER8Vyk0Mg7H7uajPr4iM/nO4UyzopSTPAfA9Gn
         KMxwEwnPlQ8a07egcI5HuqEjtAiqxSZ0rf3Yr3iMi+0T6cIhhnpJbiHRfXGmjJAKWFpd
         JKlvxQaRcbXeBy0KM8d9guJrj/1vUFk3cG8mhmmy5DF4GPrqx/Q2lhgziM2U2TvocZ+3
         CoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuTXg0e3clW+MMWqMjMwfJqjaNCb4Ct1FoSRnnKkgJ8=;
        b=uZ3D1yFvVAWFAnAVJz/KSB+ZKWQeEuBM5hPydLrXFK729n7z0c0laSHiJtyel+QY2I
         0qpGBZFnjZSHsjq5+k/oK+1hIbGcSBbzhbQkipfsAOA7fbyJR7xpLrOpReMJXHsCF9bo
         mD1cwugXmZTW7Hbr1Nsp8P1NQ3B4dX0SF/FIHJPWzgCRF+uzQWbGJ4FLjG2b3SBefij1
         76JgcuyL7++PzUpvUwZ5b59nSWCsp3N2ktvJng89NjCkDyg5IE/UBimIGi24qNRwh/1A
         WLIBbctFPzrI87jM+TTVVvuYXgLz8i+zqCnO68p3hInRfnUx7+NjKzlh4O89TMZN1gA2
         lc1w==
X-Gm-Message-State: AOAM530ad31KmqBdKlPbnxNz14KOTRws/q0n/c9DNdh1G688c6scrsb8
        DG2hW7KX3Ok7G5bD1Rcr9kY=
X-Google-Smtp-Source: ABdhPJwxzVLBZL+ZmF8QBZL4Gvbcc1RiS9N6/uHnbx0dzquWp60KZIHGDWSCoHisTkYzkl8QyZYx3g==
X-Received: by 2002:a92:c54d:: with SMTP id a13mr4253873ilj.74.1627788890249;
        Sat, 31 Jul 2021 20:34:50 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c1sm3366525ils.21.2021.07.31.20.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 20:34:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, seanpaul@chromium.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH] dyndbg: add special aux_print framework
Date:   Sat, 31 Jul 2021 21:34:32 -0600
Message-Id: <20210801033432.831938-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Paul seanpaul@chromium.org proposed, in
https://patchwork.freedesktop.org/series/78133/
drm/trace: Mirror DRM debug logs to tracefs

The problem with the approach is that its built upon splitting
drm_debug_enabled() into syslog & trace flavors, which clashes rather
profoundly with the strategy of obsoleting it using dyndbg.

Instead, this puts the print-to-trace decision after the is-it-enabled
test (which is a noop), so it has near zero additional cost.

This is preliminary, Proof-of-Concept, and about 2 hrs old.
But its surprisingly simple:

 - add a new struct _ddebug member: (*aux_print)(char *format, ...)
 - add a new S/special flag to check !!aux_print
 - if S, invoke the function to handle the prepared vaf

It intrinsically allows any number of alternate printf-ish consumers,
but only 1 active per callsite.  I have another patchset that
eliminates some of the data redundancies like this, it can be
extended.

It may also prove to be a generic way to implement the netdev & ibdev
variants of __dynamic_pr_debug.

It just needs a mechanism to set the per-callsite pointer to a
printf-ish function to consume the pr_debug output, a tighter/better
function prototype, and a wrapper on drm_trace_printf to bundle up the
args and comport with the prototype, which can evolve to suit this 1st
client.

it is on top of:
https://patchwork.freedesktop.org/series/92544/
(v4 on lkml, v2 in patchwork)

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  7 ++++++-
 lib/dynamic_debug.c           | 22 +++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 677ad176b167..0d068e8ed7aa 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -22,6 +22,7 @@ struct _ddebug {
 	const char *function;
 	const char *filename;
 	const char *format;
+	int (*aux_print)(char *, void *, void *);
 	unsigned int lineno:18;
 	/*
 	 * The flags field controls the behaviour at the callsite.
@@ -29,7 +30,11 @@ struct _ddebug {
 	 * writes commands to <debugfs>/dynamic_debug/control
 	 */
 #define _DPRINTK_FLAGS_NONE	0
-#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_PRINT		(1<<0) /* printk() a message */
+#define _DPRINTK_FLAGS_PRINT_AUX	(1<<5) /* call (*aux_print) */
+
+#define _DPRINTK_ENABLED (_DPRINTK_FLAGS_PRINT | _DPRINTK_FLAGS_PRINT_AUX)
+
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 045e1cf92c44..7bbdedabe6f1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -85,6 +85,7 @@ static inline const char *trim_prefix(const char *path)
 
 static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINT, 'p' },
+	{ _DPRINTK_FLAGS_PRINT_AUX, 'S' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
@@ -206,10 +207,10 @@ static int ddebug_change(const struct ddebug_query *query,
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
+			if (dp->flags & _DPRINTK_ENABLED) {
+				if (!(modifiers->flags & _DPRINTK_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
+			} else if (modifiers->flags & _DPRINTK_ENABLED)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
@@ -639,6 +640,21 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 
 	printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
 
+	if (descriptor->flags & _DPRINTK_FLAGS_PRINT_AUX) {
+		/* our model:
+		drm_trace_printf("%s%s[" DRM_NAME ":%ps] %pV",
+				 dev ? dev_name(dev) : "", dev ? " " : "",
+				 __builtin_return_address(0), &vaf);
+		*/
+		pr_info("reached check aux\n");
+
+		if (descriptor->aux_channel) {
+			pr_info("calling aux\n");
+			(*descriptor->aux_channel)
+				("%s[DRM_mumble :%ps] %pV", buf,
+				 __builtin_return_address(0), &vaf);
+		}
+	}
 	va_end(args);
 }
 EXPORT_SYMBOL(__dynamic_pr_debug);
-- 
2.31.1

