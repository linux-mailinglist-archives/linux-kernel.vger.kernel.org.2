Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9933DC861
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 23:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhGaVmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 17:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhGaVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:42:45 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BBFC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:39 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z7so14983948iog.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TarqHKb2wh9HC+czOpmfvpe+4WJMCMhoUET0HeAvQsg=;
        b=ChHEB9cn1Lk8yB5rfWFQ1d5yu+CRBv6BPI2R74etPqUCzJgU0BAuSuspXSZXz7q+65
         Rqx3mbokyv+23fwMzoEP10GrYIrqp9gsrU/wAzIo4KLqsW9Mp88Dp/k5PPfq/nyHPYqv
         GAAP8fLAEu39c4S5vjxbaUPBTAgMrrpAOQPSwPUHnuzF7S1ZoZY3Hut+uNkJrpoFvsLr
         ZLm8Yn/ZQDE3Y9R3QyKBW8vnjIMzh1/SrhbwUmlcqvS+PKPewpMtXyeHf08ev2WaqXaJ
         1sGc+yd14y5kw11gIiokecM+s+x7KNmonzI4UenSCXK29vNtwUfBomYKRpG06bIEhQXJ
         D/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TarqHKb2wh9HC+czOpmfvpe+4WJMCMhoUET0HeAvQsg=;
        b=jb+fv5SzoBTbvOXpA10/nsaQmYHWSIvTDDS+ByoJK/9agv1eswY7o17vbBIjOkYs8p
         8S1FFP/4s/OKyTf4EwEoM0/QiFT/xj7f4ho7thuv8vf8tslW/Zz8Gl0aDRRRIZ8QOQ4d
         pT/KLvxF7J6RlAklWqSAFAqIVjGjTzAaRlMf901RgzrQdxeDcHBirUtuNsxw5nJsM0Vk
         w2TrSYtKt8JLiLH05tGHUcVg1lO4TMIiHY0tm+b1u0iMKG6wIQTbiR3Hy4gdBaIkWApg
         K1cPXqQ5pAiDJFLogPYhujiEkd4Ir2bI0OSGQBeZCDa6xHXKZaqn5W3YiR6m1I23cX7t
         Typw==
X-Gm-Message-State: AOAM531XEnj1cAhLTpBy0KUJ+lhEFej97kHHToRGAyt0IjseMMC3ji3H
        lAesUrMMu+npKQ6ojlXxWNo=
X-Google-Smtp-Source: ABdhPJwVYVK0Xb4+Y+xg/kICohGw6QY3fg7nUx88vH0xZrpT+G5YyF7mdDH9vGymQy1CL8T8OS1Lig==
X-Received: by 2002:a02:2a07:: with SMTP id w7mr7722468jaw.96.1627767758496;
        Sat, 31 Jul 2021 14:42:38 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id q10sm3721040ion.3.2021.07.31.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 14:42:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 3/7] dyndbg: add dyndbg-bitmap definer and callbacks
Date:   Sat, 31 Jul 2021 15:42:00 -0600
Message-Id: <20210731214211.657280-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731214211.657280-1-jim.cromie@gmail.com>
References: <20210731214211.657280-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DEFINE_DYNDBG_BITMAP(name, var, bitmap_desc, @bit_descs) to allow
users to define a /sys/module/*/parameter/name, and a mapping from
bits[0-N] to the debug-class-prefixes that the author wishes to
control.

DEFINE_DYNDBG_BITMAP(debug_gvt, __gvt_debug,
	"dyndbg bitmap desc",
	{ "gvt:cmd: ",	"command processing" },
	{ "gvt:core: ",	"core help" },
	{ "gvt:dpy: ",	"display help" },
	{ "gvt:el: ",	"help" },
	{ "gvt:irq: ",	"help" },
	{ "gvt:mm: ",	"help" },
	{ "gvt:mmio: ", "help" },
	{ "gvt:render: ", "help" },
	{ "gvt:sched: ", "help" });

dynamic_debug.c: add 3 new elements:

- int param_set_dyndbg() - not working yet, // __gvt_debug
- int param_get_dyndbg()
- struct param_ops_dyndbg

Following the model of kernel/params.c STANDARD_PARAM_DEFS, All 3 are
non-static and exported.

dynamic_debug.h:

extern the struct param_ops_dyndbg prototype.  This appears to be
needed to reference the var, forex in i915_params.c

TBD: set_dyndbg() works to enable categories, but fails to disable
them.  This is because the code relied on having an old copy of the
param (__gvt_debug) to detect +/- changes.  Rewriting the loop is
probably easier than stashing the old state for change detection.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 36 +++++++++++++++++++++++
 lib/dynamic_debug.c           | 55 +++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dce631e678dd..677ad176b167 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -2,6 +2,8 @@
 #ifndef _DYNAMIC_DEBUG_H
 #define _DYNAMIC_DEBUG_H
 
+#include <linux/moduleparam.h>
+
 #if defined(CONFIG_JUMP_LABEL)
 #include <linux/jump_label.h>
 #endif
@@ -227,6 +229,40 @@ static inline int dynamic_debug_exec_queries(const char *query, const char *modn
 	return 0;
 }
 
+static int param_set_dyndbg(const char *instr, struct kernel_param *kp)
+{ return 0; }
+static int param_get_dyndbg(char *buffer, struct kernel_param *kp)
+{ return 0; }
+
 #endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
+struct dyndbg_bitdesc {
+	/* bitpos is inferred from index in containing array */
+	char *prefix;
+	char *help;
+};
+
+/**
+ * DYNDBG_BITMAP_DESC(name, var, bitmap_desc, @bit_descs)
+ * @name: basename under /sys
+ * @var: C identifier to map
+ * @bitmap_desc: string summarizing dyndbg categories
+ * @bit_descs: list of struct dydbg_bitdesc initializations
+ *
+ * Defines the mapping of bits 0-N to categories/prefixes of
+ * debug-callsites to be controlled.
+ *
+ * Users should also call MODULE_PARM_DESC(name, bitmap_desc).
+ * Maybe we can invoke it on their behalf, but we want MOD-NAME to be
+ * correct, test soon.  may also need modname in name - "debug" will
+ * not be unique.
+ */
+#define DEFINE_DYNDBG_BITMAP(name, value, bitmap_desc, ...)	\
+	struct dyndbg_bitdesc dyndbg_classes_##name[] =		\
+	{ __VA_ARGS__, { NULL, NULL } };			\
+	module_param_cbd(name, &param_ops_dyndbg, value, 0644,	\
+			 &dyndbg_classes_##name);
+
+extern const struct kernel_param_ops param_ops_dyndbg;
+
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cb5abb42c16a..045e1cf92c44 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1154,3 +1154,58 @@ early_initcall(dynamic_debug_init);
 
 /* Debugfs setup must be done later */
 fs_initcall(dynamic_debug_init_control);
+
+#include <linux/moduleparam.h>
+
+#define OUR_QUERY_SIZE 128 /* typically need <40 */
+
+int param_set_dyndbg(const char *instr, const struct kernel_param *kp)
+{
+	unsigned int val;
+	unsigned long changes, result;
+	int rc, chgct = 0, totct = 0, bitpos, bitsmax;
+	char query[OUR_QUERY_SIZE];
+	struct dyndbg_bitdesc *bitmap = (struct dyndbg_bitdesc *) kp->data;
+
+	// pr_info("set_dyndbg: instr: %s curr: %d\n", instr, *kp->arg);
+
+	rc = kstrtouint(instr, 0, &val);
+	if (rc) {
+		pr_err("set_dyndbg: failed\n");
+		return -EINVAL;
+	}
+	result = val;
+	pr_info("set_dyndbg: result:0x%lx from %s\n", result, instr);
+
+	changes = result; // ^ __gvt_debug;
+
+	for (bitsmax = 0; bitmap[bitsmax].prefix; bitsmax++);
+
+	for_each_set_bit(bitpos, &changes, min(--bitsmax, 64)) {
+
+		sprintf(query, "format '^%s' %cp", bitmap[bitpos].prefix,
+			test_bit(bitpos, &result) ? '+' : '-');
+
+		chgct = dynamic_debug_exec_queries(query, "i915");
+
+		pr_info("bit-%d: %d changes on: %s\n", bitpos, chgct, query);
+		totct += chgct;
+	}
+	pr_info("total changes: %d\n", totct);
+	// __gvt_debug = result;
+	return 0;
+}
+EXPORT_SYMBOL(param_set_dyndbg);
+
+int param_get_dyndbg(char *buffer, const struct kernel_param *kp)
+{
+	return scnprintf(buffer, PAGE_SIZE, "%u\n",
+			 *((unsigned int *)kp->arg));
+}
+EXPORT_SYMBOL(param_get_dyndbg);
+
+const struct kernel_param_ops param_ops_dyndbg = {
+	.set = param_set_dyndbg,
+	.get = param_get_dyndbg,
+};
+EXPORT_SYMBOL(param_ops_dyndbg);
-- 
2.31.1

