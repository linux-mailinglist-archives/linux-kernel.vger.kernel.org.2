Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53556446904
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhKET3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhKET3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:29:50 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3137C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:27:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id k1so10497130ilo.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/eb6uDj0ZcPussZNWTyXvX7+BhhrBBdZ4eRtPk3Njs=;
        b=fIfqGP52iMjTWJ3rJiWHeZApL+OE+qNoX8r4HqPqhUJsBNZBk06CuQTKr8jLitRKC2
         89ldORPkk/VwhqpGKMIfFgwCsdnzOvDotuAbe1BEGzzhHF70zd0TnPQAjlakfTLpTazp
         +dlPwKK779zSg/PwgWsvuvoAGlTy9d0JLStrfkVARlKT+p9Hcc3/mMoq3nxpG3CI/1mc
         nhfd1S715+l8rmbG+V/8phkn4T52/qFF/rRFZe3W+ePU25y4miS/Ver+6oDKXjr/WhEH
         IdkiUkDHsic4l4UByJMEZn7GcFFPMHPYRPzcVap7vxJv4R6jiRbkSS6GSvLje3ZwYG7y
         oWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/eb6uDj0ZcPussZNWTyXvX7+BhhrBBdZ4eRtPk3Njs=;
        b=PmEjhRbJAISsyxmQcT10K5Q80q9+9KDM0Q2SL6mLde4WQ5ULG5khVKI3DyQe9zp4Xj
         RQrqruDtDva4W8QSpbOpZp2VIiMXY9NcqindEmJUmjppIcOoY9BACYKNI4GAbi5BWPTt
         XHv7DMp3qsu4SxiW9+SBnCNxgJhq5wpbYwP0Dx33gEsAIKOsmxR++tkeBW0aKNHjFmYW
         SMQ8aNPUOtzdEQHfBxDBJMw8MpEaJDnG66QpVga6yHOCeXWaKb5LrPTWpBoXKQHz0ild
         aozea5V7k0Ro6dooW1qIT0hrzIJxm5P0E/y7zs6Mi0jDS6DcqOFiF0h1SPRq49y1+Y0F
         EO4g==
X-Gm-Message-State: AOAM53376A7ib3An8FEs8+OmU6wyxyVpgRAXhuEoPBdfElVNAr32D9ri
        FqjzldA8+d/OVwlgG3SbgpE=
X-Google-Smtp-Source: ABdhPJxel0Z7f8bD3NjrFD/j0wBPFyQfk151niEjAkFKLKmn/Dr7fv6lOMFJehAzWUYQyTtDdhcaEQ==
X-Received: by 2002:a92:c74a:: with SMTP id y10mr34886664ilp.122.1636140430381;
        Fri, 05 Nov 2021 12:27:10 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l18sm4338617iob.17.2021.11.05.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:27:10 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, lyude@redhat.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v10 03/10] amdgpu: use dyndbg.BITGRPS to control existing pr_debugs
Date:   Fri,  5 Nov 2021 13:26:30 -0600
Message-Id: <20211105192637.2370737-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105192637.2370737-1-jim.cromie@gmail.com>
References: <20211105192637.2370737-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

logger_types.h defines many DC_LOG_*() categorized debug wrappers.
Most of these already use DRM debug API, so are controllable using
drm.debug, but others use a bare pr_debug("$prefix: .."), with 1 of 13
different class-prefixes matching [:uppercase:]

Use DEFINE_DYNAMIC_DEBUG_BITGRPS to create a sysfs location which maps
from bits to these 13 sets of categorized pr_debugs to en/disable.

Makefile adds -DDYNAMIC_DEBUG_MODULE for CONFIG_DYNAMIC_DEBUG_CORE,
otherwise BUILD_BUG_ON triggers (obvious errors on subtle misuse is
better than mysterious ones).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 47 ++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 653726588956..077342ca803f 100644
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
index 21be2a684393..e49a755c6a69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -36,8 +36,53 @@
 
 #include "resource.h"
 
-#define DC_LOGGER_INIT(logger)
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
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
+	help_(4, "[HW_LINK_TRAINING]:")					\
+	help_(5, "[HW_AUDIO]:")						\
+	help_(6, "[SCALER]:")						\
+	help_(7, "[BIOS]:")						\
+	help_(8, "[BANDWIDTH_CALCS]:")					\
+	help_(9, "[DML]:")						\
+	help_(10, "[IF_TRACE]:")					\
+	help_(11, "[GAMMA]:")						\
+	help_(12, "[SMU_MSG]:")
+
+static struct dyndbg_bitdesc amdgpu_bitmap[] = {
+	[0] = { "[CURSOR]:" },
+	[1] = { "[PFLIP]:" },
+	[2] = { "[VBLANK]:" },
+	[3] = { "[HW_LINK_TRAINING]:" },
+	[4] = { "[HW_AUDIO]:" },
+	[5] = { "[SCALER]:" },
+	[6] = { "[BIOS]:" },
+	[7] = { "[BANDWIDTH_CALCS]:" },
+	[8] = { "[DML]:" },
+	[9] = { "[IF_TRACE]:" },
+	[10] = { "[GAMMA]:" },
+	[11] = { "[SMU_MSG]:" }
+};
+
+DEFINE_DYNAMIC_DEBUG_LOG_GROUPS(debug_dc, __debug_dc,
+				DC_DYNDBG_BITMAP_DESC(debug_dc),
+				amdgpu_bitmap);
+
+#endif
 
+#define DC_LOGGER_INIT(logger)
 
 #define SURFACE_TRACE(...) do {\
 		if (dc->debug.surface_trace) \
-- 
2.31.1

