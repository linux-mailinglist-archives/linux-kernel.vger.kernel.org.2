Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34483FCE56
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbhHaUWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbhHaUWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:22:38 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A8C061796
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:43 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y18so616625ioc.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88wRQUNtMUJi/6hPAvOwHORhoX/taPR74JK48uf6HWQ=;
        b=tOmsHdtr+3QHTB4nAZ0LrbXC75hOjRt0DUzslctjaj7goTX5XnHeSn1L7KRJtdWLI3
         JqMMyB7N5cBkQ/bMUztphUJ+oM+2H314BrNCemyeKd1vOMqrXE1SMep3EJStF/3liA7h
         u2hyWUUSRSbhgeSPchr36YwMj2or3GxAZuE1Zh3Bbl6ZdKrirfVIoMEdnuJQN1OyUKxW
         CGljvBZSYago5D/YvDZYnsZSAyNsU4AL541wcMcoOXngNRSnCA5aTTFdGbOrro61EuaC
         yT+Y4rtWdNsEHNrL57S1XIy4G4AMQV8WIYj8uUIGiGWoFK7z5uCMk4lK2gGkVT6H1VKg
         ps1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88wRQUNtMUJi/6hPAvOwHORhoX/taPR74JK48uf6HWQ=;
        b=Xz5866gHjSJqVpFFXybrktHTjKdt9PR7P2thJ+nwe3jtghcpgd5KZNo5BfLLV8yytA
         3jG7VEm7sWlZnXiHJJaXv0pJkH5lYE8Yf6eGI5SBeSnBqie31O4jm3NWStI06sqxzwIs
         X82OrrFsizs3tx82jegusICIHg6OUx/S95/TN/HVBbTmrQu3Ca49zTH/p8WawZSt+Iol
         GVjRFCWz4qjDmWBfuYDeDtb+awPcBXtTvjKFxm+zTjINVf9jzTc1zFhZOaxifOYrhNVF
         ELoU2wNlAAnUuBRQT8yDRGDYEI4ShtB6lvYQKiulHU1rbabZeCqLjUHJb9DL4420qhPk
         0Bug==
X-Gm-Message-State: AOAM5338kWX0HMKoLXla94502oekHAvffMDUkKRLqI9MsXEoXBrJFklZ
        dCEd4ADDVs10EBt+30RTJ74=
X-Google-Smtp-Source: ABdhPJx2LWgsyl+WrSNUOvCznskXzHNhCRv+oT+lELyqi541d9Xl3BoShcdyi5xKp2cgj4TtqNKxEw==
X-Received: by 2002:a02:946d:: with SMTP id a100mr4447643jai.118.1630441302509;
        Tue, 31 Aug 2021 13:21:42 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id u15sm10597384ilk.53.2021.08.31.13.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:21:42 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 3/8] i915/gvt: use DEFINE_DYNAMIC_DEBUG_CATEGORIES to create "gvt:core:" etc categories
Date:   Tue, 31 Aug 2021 14:21:28 -0600
Message-Id: <20210831202133.2165222-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831202133.2165222-1-jim.cromie@gmail.com>
References: <20210831202133.2165222-1-jim.cromie@gmail.com>
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
v5:
. static decl of vector of bit->class descriptors - Emil.V
. relocate gvt-makefile chunk from elsewhere
v7:
. move ccflags addition up to i915/Makefile from i915/gvt
---
 drivers/gpu/drm/i915/Makefile      |  4 ++++
 drivers/gpu/drm/i915/i915_params.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 4f22cac1c49b..5a4e371a3ec2 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -30,6 +30,10 @@ CFLAGS_display/intel_fbdev.o = $(call cc-disable-warning, override-init)
 
 subdir-ccflags-y += -I$(srctree)/$(src)
 
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
+ccflags-y += -DDYNAMIC_DEBUG_MODULE
+#endif
+
 # Please keep these build lists sorted!
 
 # core driver code
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index e07f4cfea63a..e645e149485e 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -265,3 +265,38 @@ void i915_params_free(struct i915_params *params)
 	I915_PARAMS_FOR_EACH(FREE);
 #undef FREE
 }
+
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
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

