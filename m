Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80803F41FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhHVWVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhHVWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:21:34 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF40C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:52 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so22755036otg.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Di0vKi6q1FQK7H2Iauu5LRuMFu/619Qh3TdTrNtKXuA=;
        b=tkqpGHbOO1QfJaHHrjSYZV7sKqxU8LscpiATOjdtyBrYvalZ9xwCc/QRtKMPRBeM3O
         3Us3/BDJ4e3nAf9cDIu/wobznv7ozP+Ugyrsovxtni/JsiGp3ida5BX2QiI/BKJ7IqM+
         5o2DgNteMcs2dC9Vmhwqr6H/3bD/84053Ep9+9JWmx7kmr991Qn/nGMylV4vpljJ3mtl
         uSM3sWRDNqrC8waHsm8aGd5lvmKEFTxng2l9oCVRXHSlHlqmPJ4WgOdRkGK2bNqIlrT8
         1AA/n7ESClY5iOu7PmhraN4cZVc6ru94/0E6PkaU5fF5xy4LhGx/HjNWGzCCBPto8CCC
         gkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Di0vKi6q1FQK7H2Iauu5LRuMFu/619Qh3TdTrNtKXuA=;
        b=nh18sqZcxnAnyXX/wE+q43t83yGRdOw1tOFX3dli4pKTnCfPSymwXfwr2plL49kUVO
         HRO5vzMP8G3U0KwEwiKDKOoox3GyW2kM2iPqkMlY8FWAKY+8S7DVX0miVD65EcZ/r+OU
         3/7PWHOUgTBz5CS4Ygo4QKv/9MC/eOa6P7V5lUx3MD/nU6hhbFJrkcS0HS25LHAwabiW
         E2oD2IiM9EaDalJa4RGZwRMEFoFgEj2GkqugoeKQc6TBBKcupbKJMwG0goTmYQ7fS8k4
         sINyVZXRXfP59dMS4WAWepBoLj/klZcWdzJu3XKfP7TEu6H0x89tZV3yQ+v2jujd2rtU
         0wEg==
X-Gm-Message-State: AOAM532Hn1GejZNPDS4XbA1BQDRKXS7C8tWbnNJWNcKVqeJ31WU7jl5Z
        3BkmY0A9Q7tEJ2YfxYbuYsY=
X-Google-Smtp-Source: ABdhPJyPpT9XiFfOy8V8QORSZfW/NxURz4DN+wweH36YGXMRDoirpmpnVsnD73+/3/1paYsfg+mTUA==
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr25581181otq.351.1629670852237;
        Sun, 22 Aug 2021 15:20:52 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x198sm2964122ooa.43.2021.08.22.15.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 15:20:51 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        seanpaul@chromium.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 05/11] amdgpu: use DEFINE_DYNAMIC_DEBUG_CATEGORIES to control categorized pr_debugs
Date:   Sun, 22 Aug 2021 16:20:03 -0600
Message-Id: <20210822222009.2035788-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210822222009.2035788-1-jim.cromie@gmail.com>
References: <20210822222009.2035788-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

logger_types.h defines many DC_LOG_*() categorized debug wrappers.
Most of these use DRM debug API, so are controllable using drm.debug,
but others use bare pr_debug("$prefix: .."), each with a different
class-prefix matching "^\[\w+\]:"

Use DEFINE_DYNAMIC_DEBUG_CATEGORIES to create a /sys debug_dc
parameter, modinfos, and to specify a map from bits -> categorized
pr_debugs to be controlled.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 21be2a684393..69e68d721512 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -36,8 +36,50 @@
 
 #include "resource.h"
 
-#define DC_LOGGER_INIT(logger)
+#ifdef DRM_USE_DYNAMIC_DEBUG
+/* define a drm.debug style dyndbg pr-debug control point */
+#include <linux/dynamic_debug.h>
+
+unsigned long __debug_dc;
+EXPORT_SYMBOL(__debug_dc);
+
+#define _help_(key)	"\t   " key "\t- help for " key "\n"
+
+/* Id like to do these inside DEFINE_DYNAMIC_DEBUG_CATEGORIES, if possible */
+#define DC_DYNDBG_BITMAP_DESC(name)					\
+	"Control pr_debugs via /sys/module/amdgpu/parameters/" #name	\
+	", where each bit controls a debug category.\n"			\
+	_help_("[SURFACE]:")						\
+	_help_("[CURSOR]:")						\
+	_help_("[PFLIP]:")						\
+	_help_("[VBLANK]:")						\
+	_help_("[HW_LINK_TRAINING]:")					\
+	_help_("[HW_AUDIO]:")						\
+	_help_("[SCALER]:")						\
+	_help_("[BIOS]:")						\
+	_help_("[BANDWIDTH_CALCS]:")					\
+	_help_("[DML]:")						\
+	_help_("[IF_TRACE]:")						\
+	_help_("[GAMMA]:")						\
+	_help_("[SMU_MSG]:")
+
+DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_dc, __debug_dc,
+	DC_DYNDBG_BITMAP_DESC(debug_dc),
+	_DD_cat_("[CURSOR]:"),
+	_DD_cat_("[PFLIP]:"),
+	_DD_cat_("[VBLANK]:"),
+	_DD_cat_("[HW_LINK_TRAINING]:"),
+	_DD_cat_("[HW_AUDIO]:"),
+	_DD_cat_("[SCALER]:"),
+	_DD_cat_("[BIOS]:"),
+	_DD_cat_("[BANDWIDTH_CALCS]:"),
+	_DD_cat_("[DML]:"),
+	_DD_cat_("[IF_TRACE]:"),
+	_DD_cat_("[GAMMA]:"),
+	_DD_cat_("[SMU_MSG]:"));
+#endif
 
+#define DC_LOGGER_INIT(logger)
 
 #define SURFACE_TRACE(...) do {\
 		if (dc->debug.surface_trace) \
-- 
2.31.1

