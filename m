Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0943F41F9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhHVWVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhHVWVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:21:33 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA86C061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso16407524ota.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcxXOS2YF8uquZi7kiX9qsCJzDtlyXVg/tWg1kXIEfw=;
        b=Lt3kAYxhulbTWzHw+KRuN9FilPfa/EzpwZR9uYqxRniMUOewDlJ4DGDT8qecdeIdMb
         CDj4rDXnMKefO6KQWz1XdVcSRAsJyfeuabR8mYqwE6NeAzqc73aEtG+EMfgnzZnRbBHw
         aUIoY4KEupW8c8za+nlCgiX5usqNljYfAin+m5PENm/85RqyKpQJOZqI4lTGCcrU2ony
         4cXIMTEP7H7VrSkoTEfudzitfhwRzFBfaryP7wk//ofLSWWhatIXLq9Z2B19XvkDs8qS
         4Ur8y+2bJmFRzvYQoPky3KY26CfC1RjNcSjjQPX0+groURVxmIE8aFjBmfe0wt2TpQoH
         MM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcxXOS2YF8uquZi7kiX9qsCJzDtlyXVg/tWg1kXIEfw=;
        b=qYLbwnC2tFJ6WXoPpT/la12lKnLxRThfGQXzn/bWmQt1tXo3KyBdPGZZ6B8rYcOt/V
         AeN0kxZxrnvROKZR31dWW7c2yjkUzPqXYoRKzlNMhIsU9+YeD6eFYqcSURY/BTQQzDGj
         LuteuUGHmwBFtZ4+4GMl84PrqlygtEPGDDsk2ZTkcn2aITCXDGKrwIR2E7TvZkuOBKMO
         SVcXCuhPIJ8MNu2XJ/0LS59UjwzUL5eqwUl8YDxQiDavP0aYbEysm/Y9e/0M0XGCWV6T
         dE1ey8t+9FAYSrI5W1tDYv9Vr7GKYX8x/Dvqf7yyKKuI6OaGMin2kgeOxpjmC/JhBa70
         tWNg==
X-Gm-Message-State: AOAM532XUH0Tcd4LZOqB25UmzhLCHJ72EbqYXA9Pm4FA5wtmzVjFVAWo
        xz4qoJWbq/6Dc8W7y/l2wBQ=
X-Google-Smtp-Source: ABdhPJyKh74f82CLns65Ub2YpnD6FguJkzgMrm73NZeDP62Hn3m6BcP++K3oGODLJTjANh7XmyyENg==
X-Received: by 2002:a9d:6c1:: with SMTP id 59mr24916964otx.318.1629670851093;
        Sun, 22 Aug 2021 15:20:51 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x198sm2964122ooa.43.2021.08.22.15.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 15:20:50 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        seanpaul@chromium.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 04/11] i915/gvt: use DEFINE_DYNAMIC_DEBUG_CATEGORIES to create "gvt:core:" etc categories
Date:   Sun, 22 Aug 2021 16:20:02 -0600
Message-Id: <20210822222009.2035788-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210822222009.2035788-1-jim.cromie@gmail.com>
References: <20210822222009.2035788-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gvt component of this driver has ~120 pr_debugs, in 9 categories
quite similar to those in DRM.  Following the interface model of
drm.debug, add a parameter to map bits to these categorizations.

DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_gvt, __gvt_debug,
	"dyndbg bitmap desc",
	{ "gvt:cmd: ",  "command processing" },
	{ "gvt:core: ", "core help" },
	{ "gvt:dpy: ",  "display help" },
	{ "gvt:el: ",   "help" },
	{ "gvt:irq: ",  "help" },
	{ "gvt:mm: ",   "help" },
	{ "gvt:mmio: ", "help" },
	{ "gvt:render: ", "help" },
	{ "gvt:sched: " "help" });

The actual patch has a few details different, cmd_help() macro emits
the initialization construct.

if CONFIG_DRM_USE_DYNAMIC_DEBUG, then -DDYNAMIC_DEBUG_MODULE is added
cflags, by gvt/Makefile.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v4+:
. static decl of vector of bit->class descriptors - Emil.V
. relocate gvt-makefile chunk from elsewhere
---
 drivers/gpu/drm/i915/gvt/Makefile  |  4 ++++
 drivers/gpu/drm/i915/i915_params.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index ea8324abc784..846ba73b8de6 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -7,3 +7,7 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
 
 ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
 i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
+
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
+ccflags-y	+= -DDYNAMIC_DEBUG_MODULE
+#endif
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index e07f4cfea63a..683e942a074e 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -265,3 +265,38 @@ void i915_params_free(struct i915_params *params)
 	I915_PARAMS_FOR_EACH(FREE);
 #undef FREE
 }
+
+#ifdef DRM_USE_DYNAMIC_DEBUG
+/* todo: needs DYNAMIC_DEBUG_MODULE in some cases */
+
+unsigned long __gvt_debug;
+EXPORT_SYMBOL(__gvt_debug);
+
+#define _help(key)	"\t    \"" key "\"\t: help for " key "\n"
+
+#define I915_GVT_CATEGORIES(name) \
+	" Enable debug output via /sys/module/i915/parameters/" #name	\
+	", where each bit enables a debug category.\n"			\
+	_help("gvt:cmd:")						\
+	_help("gvt:core:")						\
+	_help("gvt:dpy:")						\
+	_help("gvt:el:")						\
+	_help("gvt:irq:")						\
+	_help("gvt:mm:")						\
+	_help("gvt:mmio:")						\
+	_help("gvt:render:")						\
+	_help("gvt:sched:")
+
+DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_gvt, __gvt_debug,
+				I915_GVT_CATEGORIES(debug_gvt),
+				_DD_cat_("gvt:cmd:"),
+				_DD_cat_("gvt:core:"),
+				_DD_cat_("gvt:dpy:"),
+				_DD_cat_("gvt:el:"),
+				_DD_cat_("gvt:irq:"),
+				_DD_cat_("gvt:mm:"),
+				_DD_cat_("gvt:mmio:"),
+				_DD_cat_("gvt:render:"),
+				_DD_cat_("gvt:sched:"));
+
+#endif
-- 
2.31.1

