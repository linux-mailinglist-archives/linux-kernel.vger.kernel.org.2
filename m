Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8740CABB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhIOQmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhIOQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:42:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33425C0613D8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m11so4256880ioo.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XB/xyYwxwBAmIJHfc4hKxFHXrq1UVZ3eu3582ed7hX8=;
        b=DXWFMrUePduPkhJUeUikZrZJYpnNyQRvsEgVL4LmtmSZZMFnAUa3JkSD1oUYhwag25
         T6V/XBgMidIidjS7C2vpCQMKi1iqp1BeM+AS+IlDH2dY8X2i3YuCd1lh07StIGVzvqhg
         YZT8/vn+ppEulinrEkDXEcksE2MZzCx8gOKzhGHXk2owwvMM//L02nLb2+yiHlqhHY/j
         aXAbVoXDAwCtQjfKqDb8wBXdSSLnwm83QsmbR/y2XGEdn49DejSyIXXtFMtWcb4UGiBQ
         jCx/e70Fp/csP81A5W1rsGsb2TPUcSYgWlmYzEO0Z72JjSLVkyytP6xAxCnRVmA2OzuI
         HCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XB/xyYwxwBAmIJHfc4hKxFHXrq1UVZ3eu3582ed7hX8=;
        b=g8qPwV+E40xQbsmOdFhJQDdk3vfdae5j0XiFfNSwMI09z8iJ9/8EDZgaOVUZvrO5sh
         Ghh16UZb8idhuniDMHhj8CLPpqGx4XF4xd6oOLAiJwEs+5SWtJxocWrviw5dEzVd2P/t
         8H4aemanLntpaGk+jv92C29RiGGja8+kaQ9eIFo9w1XFslnZUup1F3mJsVL7/swYuRHJ
         /xy2RFwc54R2AO+vxytki8KqF6NqL/mQD9q+F5QfsglAi/qZhOLCQDDbaSokXw3zESK7
         fobAMYApcgat9OEdjI2JmrPuVhG5gkad8oK/Mgu9Kqdp3std0Dl7jRQhZNW/leHI/PK1
         vlOQ==
X-Gm-Message-State: AOAM531+HN/DMDmgiDJ9Cz/fscZ1VM0TdX0gSAevk3C8UDWIFvjcnn27
        krfkJX6q0i3dGvtCnpQAdhs=
X-Google-Smtp-Source: ABdhPJxqu+089Osk7hjsC7fuIwiWknAbm0fb+4lnzX9SFQho779bpmIk/xl1hCFpYDhp5Q+128KIGg==
X-Received: by 2002:a6b:24d:: with SMTP id 74mr791712ioc.134.1631724046632;
        Wed, 15 Sep 2021 09:40:46 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 12/16] amdgpu: use DEFINE_DYNAMIC_DEBUG_CATEGORIES on existing prdbgs
Date:   Wed, 15 Sep 2021 10:39:53 -0600
Message-Id: <20210915163957.2949166-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

logger_types.h defines many DC_LOG_*() categorized debug wrappers.
Most of these already use DRM debug API, so are controllable using
drm.debug, but others use a bare pr_debug("$prefix: .."), with 1 of 13
different class-prefixes matching ~/^\[[_A-Z]+\]:/

Use DEFINE_DYNAMIC_DEBUG_CATEGORIES to create a sysfs location which
maps from bits to these 13 sets of categorized pr_debugs to en/disable.

Makefile adds -DDYNAMIC_DEBUG_MODULE for CONFIG_DYNAMIC_DEBUG_CORE,
otherwise BUILD_BUG_ON triggers (obvious misuses are better than
mysterious ones).

Anyway heres a baseline, of existing prdbg use.
Each callsite costs 56 bytes of kernel .data
amdgpu has "extra" prdbgs due to macro expansion.
(see repeating linenos in control)
(it also has substantial use of drm.debug)
- tedious fix but clear size payoff, as a separate patch, later.

bash-5.1# for m in i915 amdgpu nouveau; do modprobe $m; done
dyndbg:   1 debug prints in module drm
dyndbg:   2 debug prints in module ttm
dyndbg:   8 debug prints in module video
dyndbg: 167 debug prints in module i915
dyndbg: 2339 debug prints in module amdgpu
dyndbg:   3 debug prints in module wmi
dyndbg:   3 debug prints in module nouveau

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 43 ++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c56320e78c0e..1f084919294c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -38,6 +38,8 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 	-I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
 	-I$(FULL_AMD_PATH)/amdkfd
 
+ccflags-$(CONFIG_DYNAMIC_DEBUG_CORE) += -DYNAMIC_DEBUG_MODULE
+
 amdgpu-y := amdgpu_drv.o
 
 # add KMS driver
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 21be2a684393..ae462e5d42c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -36,8 +36,49 @@
 
 #include "resource.h"
 
-#define DC_LOGGER_INIT(logger)
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
+/* define a drm.debug style dyndbg pr-debug control point */
+#include <linux/dynamic_debug.h>
+
+unsigned long __debug_dc;
+EXPORT_SYMBOL(__debug_dc);
+
+#define help_(_N, _cat)	"\t  Bit-" #_N "\t" _cat "\n"
+
+#define DC_DYNDBG_BITMAP_DESC(name)					\
+	"Control pr_debugs via /sys/module/amdgpu/parameters/" #name	\
+	", where each bit controls a debug category.\n"			\
+	help_(0, "[SURFACE]:")						\
+	help_(1, "[CURSOR]:")						\
+	help_(2, "[PFLIP]:")						\
+	help_(3, "[VBLANK]:")						\
+	help_(4, "[HW_LINK_TRAINING]:")				\
+	help_(5, "[HW_AUDIO]:")					\
+	help_(6, "[SCALER]:")						\
+	help_(7, "[BIOS]:")						\
+	help_(8, "[BANDWIDTH_CALCS]:")					\
+	help_(9, "[DML]:")						\
+	help_(10, "[IF_TRACE]:")					\
+	help_(11, "[GAMMA]:")						\
+	help_(12, "[SMU_MSG]:")
+
+DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_dc, __debug_dc,
+				DC_DYNDBG_BITMAP_DESC(debug_dc),
+				_DD_cat_(0, "[CURSOR]:"),
+				_DD_cat_(1, "[PFLIP]:"),
+				_DD_cat_(2, "[VBLANK]:"),
+				_DD_cat_(3, "[HW_LINK_TRAINING]:"),
+				_DD_cat_(4, "[HW_AUDIO]:"),
+				_DD_cat_(5, "[SCALER]:"),
+				_DD_cat_(6, "[BIOS]:"),
+				_DD_cat_(7, "[BANDWIDTH_CALCS]:"),
+				_DD_cat_(8, "[DML]:"),
+				_DD_cat_(9, "[IF_TRACE]:"),
+				_DD_cat_(10, "[GAMMA]:"),
+				_DD_cat_(11, "[SMU_MSG]:"));
+#endif
 
+#define DC_LOGGER_INIT(logger)
 
 #define SURFACE_TRACE(...) do {\
 		if (dc->debug.surface_trace) \
-- 
2.31.1

