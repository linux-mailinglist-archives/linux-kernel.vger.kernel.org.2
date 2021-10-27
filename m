Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3343C18E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbhJ0Ej4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhJ0Ejr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:39:47 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE173C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:37:22 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id v65so2107396ioe.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KTjPwmyEBDA02pYjzS52Ng2KLEEXB6xVb20R+Q4xkso=;
        b=oEgwprXWHlgD+HK8HYagY0h+ZLXfFM042go+IjfKy+XWxWgaVtKJHZCUD/vCVb5i/s
         qLbm0A7vZLuPlH2lVgYG7W4Oa8kCBQewYb8jTuhbGz9PqfeB4W2ty0BQXOg6sBGjuSZE
         8zzzcx1FYupfJn7qNJnm18QluydqENoSfjq3gQ21tqn2ExdbsJojZrCpxqEsVXCXSKkq
         0fev0HUHDHRwXgfeO2B4H/9JwYhL/u925NwbPv2Chjswz8Gh6QT9y39MaUAKWaISc1Zs
         Cv8NevjmO5uQlIkgD99cG42HjKvfyEET+zkfzoSul7ym9YFooZ3hMgjYWM4PiEQ5IRVX
         8Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KTjPwmyEBDA02pYjzS52Ng2KLEEXB6xVb20R+Q4xkso=;
        b=eNlOWevb7rN1OlZdExLj9iU6W54n/tWkpEgt3phumqN7uPfo0iiyy2wvU9RW+y+3YI
         4awNc5UkzUyX0xNzeQDAHZWTBLZ2I5p2XXrRSTl8yj3+JwVAYSn7L/8EcaxmVvrFcyLt
         M3xtJw7c/mrLcWORVAkgltLqisTKmfNRCjGal3grgME//tMvpzDzW0+N8puLETJZs47c
         giYkpnr7NFaLXYb2sxpuDFcrxp11JoHrCUgDx/m+HCsIp1qwqEF1AplJAj6DoaVid/hE
         AdD8VQGXdOqsrkAGMkgk0qGrW7qUEF9/409R+gPsok9SiOLOVxpSj64/MfKZdKYfvI2Q
         QzrQ==
X-Gm-Message-State: AOAM530L+UI3xSj+fORMyJNmZJCwAxcwvJCFE99yKY1UalQ+8UqNJqhf
        5RD+wT8nQHFE9+vJaD9u2B0=
X-Google-Smtp-Source: ABdhPJyA9UJpZHU3+9vlpcCwM3603b2gx+HQKti7AVP908D+jG4YTlduIdgVV7qe09OFCOTviYg44g==
X-Received: by 2002:a05:6602:2d14:: with SMTP id c20mr17390975iow.95.1635309441933;
        Tue, 26 Oct 2021 21:37:21 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a15sm2030404ilj.81.2021.10.26.21.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 21:37:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 05/10] i915/gvt: use dyndbg.CATEGORIES for existing pr_debugs
Date:   Tue, 26 Oct 2021 22:36:40 -0600
Message-Id: <20211027043645.153133-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027043645.153133-1-jim.cromie@gmail.com>
References: <20211027043645.153133-1-jim.cromie@gmail.com>
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
	[0] = { "gvt:cmd:" },
	[1] = { "gvt:core:" },
	[2] = { "gvt:dpy:" },
	[3] = { "gvt:el:" },
	[4] = { "gvt:irq:" },
	[5] = { "gvt:mm:" },
	[6] = { "gvt:mmio:" },
	[7] = { "gvt:render:" },
	[8] = { "gvt:sched:" });

If CONFIG_DYNAMIC_DEBUG_CORE=y, then gvt/Makefile adds
-DDYNAMIC_DEBUG_MODULE to cflags, which CONFIG_DYNAMIC_DEBUG=n
(CORE-only) builds need.  This is redone more comprehensively soon.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5:
. static decl of vector of bit->class descriptors - Emil.V
. relocate gvt-makefile chunk from elsewhere

v7:
. move ccflags addition up to i915/Makefile from i915/gvt

v8:
. relocate DDD_CAT decl code into intel_gvt.c - Tvrtko
  cflags back to i915/Makefile
. add -DDYNAMIC_DEBUG_MODULE to support DYNAMIC_DEBUG_CORE-only builds

heres unchanged? footprint:

bash-5.1# for m in i915 amdgpu nouveau; do modprobe $m; done
dyndbg:   1 debug prints in module drm
dyndbg:   2 debug prints in module ttm
dyndbg:   8 debug prints in module video
dyndbg: 167 debug prints in module i915
dyndbg: 2339 debug prints in module amdgpu
[drm] amdgpu kernel modesetting enabled.
amdgpu: CRAT table disabled by module option
amdgpu: Virtual CRAT table created for CPU
amdgpu: Topology: Add CPU node
dyndbg:   3 debug prints in module wmi
dyndbg:   3 debug prints in module nouveau
---
 drivers/gpu/drm/i915/Makefile    |  2 ++
 drivers/gpu/drm/i915/intel_gvt.c | 34 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 335ba9f43d8f..a313e8a539f6 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -301,6 +301,8 @@ i915-y += intel_gvt.o
 include $(src)/gvt/Makefile
 endif
 
+ccflags-$(CONFIG_DYNAMIC_DEBUG_CORE) += -DDYNAMIC_DEBUG_MODULE
+
 obj-$(CONFIG_DRM_I915) += i915.o
 obj-$(CONFIG_DRM_I915_GVT_KVMGT) += gvt/kvmgt.o
 
diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_gvt.c
index 4e70c1a9ef2e..e53b41fa15e0 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -162,3 +162,37 @@ void intel_gvt_resume(struct drm_i915_private *dev_priv)
 	if (intel_gvt_active(dev_priv))
 		intel_gvt_pm_resume(dev_priv->gvt);
 }
+
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+
+unsigned long __gvt_debug;
+EXPORT_SYMBOL(__gvt_debug);
+
+#define help_(_N, _cat)	"\t  Bit-" #_N ":\t" _cat "\n"
+
+#define I915_GVT_CATEGORIES(name) \
+	" Enable debug output via /sys/module/i915/parameters/" #name	\
+	", where each bit enables a debug category.\n"			\
+	help_(0, "gvt:cmd:")						\
+	help_(1, "gvt:core:")						\
+	help_(2, "gvt:dpy:")						\
+	help_(3, "gvt:el:")						\
+	help_(4, "gvt:irq:")						\
+	help_(5, "gvt:mm:")						\
+	help_(6, "gvt:mmio:")						\
+	help_(7, "gvt:render:")						\
+	help_(8, "gvt:sched:")
+
+DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_gvt, __gvt_debug,
+				I915_GVT_CATEGORIES(debug_gvt),
+				[0] = { "gvt:cmd:" },
+				[1] = { "gvt:core:" },
+				[2] = { "gvt:dpy:" },
+				[3] = { "gvt:el:" },
+				[4] = { "gvt:irq:" },
+				[5] = { "gvt:mm:" },
+				[6] = { "gvt:mmio:" },
+				[7] = { "gvt:render:" },
+				[8] = { "gvt:sched:" });
+
+#endif
-- 
2.31.1

