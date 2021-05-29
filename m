Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41F8394E1D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhE2UFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhE2UEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:36 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FBC06134C
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so6950555otc.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9VUHUllVMMzaD7k37pR+lcrEy5GxtE+HZ2MKbU9tis=;
        b=M5YcIfEhkZJOtdLtLdXXyS4a0SE9SYj+71JDJ/jpRhD+LdSBDylV9OH75NE9RfL0x6
         R9pkkgvdgA7BPSOxrKLfxJ9Q5dAlL9DSip5a+vbiqRcpTo3orIbwqyRMqIMMElFHtmin
         8S95v67M3/UgczUMqu6EJGLPtW3PE31PetUnWeatqeuF6YxEBXwxeXSOelot0Ci9KZxy
         OZgXk3PwD8IQsw3Zqn5uyHAzzvglUuLPZpOyIAe7eccMbyMpx8QsLu1KPFve0FHUOEO8
         GnVwKcH2EWkhMu8Y0EMcXIztD2AOQt2gfamF7uERhyg/d3x9eb/uQSfWXJI8vplOl+1P
         P/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9VUHUllVMMzaD7k37pR+lcrEy5GxtE+HZ2MKbU9tis=;
        b=lL1Bqf2dZzroFCrqrnSQ+92hDHXtCQ0nBC8cZ4q2Ved1BXlgYeRTq5aYw7BFgOiSpH
         TGLpWpLcz//hgkibxqA4To1CPulU7JIaK9dDMI/VH7JJGd125/jGREK1pXelJdyL4xKS
         MxoJFrMUFCqw0P4pSAfFIctQ8Oxu4P/hCI/+s0bkCQyELfdDmpnLDOsYbXaStPQb+PY7
         0hQ0QnTP5kjvn5XKNctQAyI394TmfftRJwyjCY+Cx4k4kOYwsNlyuP3jQKvdYbOtfQFN
         MnjgPnxfeiBI8mLNKW1UjGhIwhIDQJAGwaeP5Yfi2j94W2DLci5bAQysz/i4l3S1t5tL
         eoEA==
X-Gm-Message-State: AOAM5329ckza3SFy0sErXDVXxg/KUGRoHgpP8T33YlCB5BE62mff5Xg6
        fgrhpzi0uOCkjUiDMpc8ydA=
X-Google-Smtp-Source: ABdhPJwNf93vk6xD3DbqbZto1xWlIYxX8/ZlTBQiNu7SewvQe/E76rFjuEotniAGwU7nw0iQhLxplQ==
X-Received: by 2002:a9d:1ca2:: with SMTP id l34mr2228777ota.250.1622318568480;
        Sat, 29 May 2021 13:02:48 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:48 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 34/34] dyndbg: prototype print-once and print-ratelimited RFC
Date:   Sat, 29 May 2021 14:00:29 -0600
Message-Id: <20210529200029.205306-35-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand ddebug.flags to 11 bits, and define new flags to support
pr_debug_once() and pr_debug_ratelimited() semantics:

  echo module main +o > control		# init/main runs once anyway
  echo module foo +r > control		# turn on ratelimiting
  echo module foo +g > control		# turn on group flag

Test these conditions in new is_onced_or_ratelimited(),
and call it from __dynamic_pr_debug and others.

print-once: can be done with just 2 bits in flags;

.o _DPRINTK_FLAGS_ONCE     enables state test and set
.P _DPRINTK_FLAGS_PRINTED  state bit

Just adding the flags lets the existing code operate them.
We will need new code to enforce constraints on flag combos;
'+ro' is nonsense, but this can wait, or can take a new meaning.

is_onced_or_ratelimited() should be correct for +o,
and should be testable now. tbd.

rate-limiting:
.  for now, reserve the flag only !
.r _DPRINTK_FLAGS_RATELIMITED	- track & limit prdbgs callrate

Intention is to wait til a prdebug is called, and if RATELIMITED is
set, THEN lookup a RateLimitState (RL) for it.  If found, bump its
state and return true/false, otherwise create one, initialize it and
return false.

That lookup is basically a hash, with 2 part key:
. &builtin-vector-base OR &module
  or the hash(s) could hang off the header struct
. ._back OR ._map
  chosen by _DPRINTK_FLAGS_GROUPED
  choice dictates per-site OR sharing across function

heres what happens:
- header fail seen before, time to dig more

dyndbg: get: header fail on 100-3231
dyndbg: changed drivers/gpu/drm/i915/gvt/mmio_context.c:3231 [i915]restore_context_mmio_for_inhibit =prg
dyndbg: get: header fail on 101-1412
dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:1412 [i915]init_cmd_table =prg
dyndbg: get: header fail on 102-1409
dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:1409 [i915]gen8_check_mi_display_flip =prg
dyndbg: get: header fail on 103-761
dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:761 [i915]gen8_check_mi_display_flip =prg
dyndbg: get: header fail on 104-760
dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:760 [i915]parser_exec_state_dump =prg
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 10 ++++++---
 lib/dynamic_debug.c           | 42 ++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index fe70dda704d2..300fd0eed66f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -64,18 +64,22 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
-#define _DPRINTK_FLAGS_DELETE_SITE	(1<<7) /* drop site info to save ram */
-
 #define _DPRINTK_FLAGS_INCL_ANY		\
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID)
 
+#define _DPRINTK_FLAGS_ONCE		(1<<5) /* print once flag */
+#define _DPRINTK_FLAGS_PRINTED		(1<<6) /* print once state */
+#define _DPRINTK_FLAGS_RATELIMITED	(1<<7)
+#define _DPRINTK_FLAGS_GROUPED		(1<<8) /* manipulate as a group */
+#define _DPRINTK_FLAGS_DELETE_SITE	(1<<9) /* drop site info to save ram */
+
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	unsigned int flags:8;
+	unsigned int flags:11;
 
 #ifdef CONFIG_JUMP_LABEL
 	union {
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 66b48f1cb2d0..a81461b58f6e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -86,13 +86,17 @@ static inline const char *trim_prefix(const char *path)
 	return path + skip;
 }
 
-static struct { unsigned flag:8; char opt_char; } opt_array[] = {
+static struct { unsigned flag:11; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINT, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
 	{ _DPRINTK_FLAGS_INCL_TID, 't' },
 	{ _DPRINTK_FLAGS_NONE, '_' },
+	{ _DPRINTK_FLAGS_ONCE, 'o' },
+	{ _DPRINTK_FLAGS_PRINTED, 'P' },
+	{ _DPRINTK_FLAGS_RATELIMITED, 'r' },
+	{ _DPRINTK_FLAGS_GROUPED, 'g' },
 	{ _DPRINTK_FLAGS_DELETE_SITE, 'D' },
 };
 
@@ -728,6 +732,30 @@ static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 	return buf;
 }
 
+/* test print-once or ratelimited conditions */
+static bool is_onced_or_limited(struct _ddebug *descriptor)
+{
+	if (descriptor->flags & _DPRINTK_FLAGS_ONCE &&
+	    descriptor->flags & _DPRINTK_FLAGS_RATELIMITED)
+		pr_info(" ONCE & RATELIMITED together is nonsense\n");
+
+	if (descriptor->flags & _DPRINTK_FLAGS_ONCE) {
+		if (descriptor->flags & _DPRINTK_FLAGS_PRINTED) {
+			v3pr_info(" would suppress print once\n");
+			// return true;
+		}
+		descriptor->flags |= _DPRINTK_FLAGS_PRINTED;
+		// return false; // wanna see rate stuff
+	}
+	/* test rate-limits */
+	if (descriptor->flags & _DPRINTK_FLAGS_RATELIMITED) {
+		v3pr_info("todo: fetch RLstate{%s}\n",
+			  descriptor->flags & _DPRINTK_FLAGS_GROUPED
+			  ? "grouped" : "solo");
+	}
+	return false;
+}
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
@@ -737,6 +765,9 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 	BUG_ON(!descriptor);
 	BUG_ON(!fmt);
 
+	if (is_onced_or_limited(descriptor))
+		return;
+
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
@@ -757,6 +788,9 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 	BUG_ON(!descriptor);
 	BUG_ON(!fmt);
 
+	if (is_onced_or_limited(descriptor))
+		return;
+
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
@@ -788,6 +822,9 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 	BUG_ON(!descriptor);
 	BUG_ON(!fmt);
 
+	if (is_onced_or_limited(descriptor))
+		return;
+
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
@@ -824,6 +861,9 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	struct va_format vaf;
 	va_list args;
 
+	if (is_onced_or_limited(descriptor))
+		return;
+
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
-- 
2.31.1

