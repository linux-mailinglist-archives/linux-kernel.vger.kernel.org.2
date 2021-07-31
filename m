Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B53DC876
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 23:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhGaVnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGaVnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:43:12 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC211C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:43:05 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d10so13016949ils.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Fjsw3W3/UmlQsTKfLEE1H6kTd7xaAkJp0etT9YYbz+I=;
        b=DUQOmqbS6V186tr3AR4AQ/htc0Bg66ZwKaVnDhi8fD4VVZlKCf/XiMXwkRotjoP/oD
         OlEohbOBL4Yoa9TdR+Rt4U35G0nEQ8KC1XEx4lPrsDTudjD848VcRX4MLxvsBeZw/1G1
         sTsh+9jmrH/+DkMS13G8ysj2cw3Gbc0Y/imnc903XG+ZXkdCSUgEye1gO5kadZ0NHB/7
         QoTZ/7GP4NjMU6SpCQNZxUXX0+r7NF0RdNFHb5ATQxh2tgpzFKgYwf2gNYLWlmt9BMSY
         cz2ik8KJfEIuoyTSo19BihMCTNQfO9StMfPsChEJF5EwgtM60BYWqB8C+i00hvEv47mX
         w6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fjsw3W3/UmlQsTKfLEE1H6kTd7xaAkJp0etT9YYbz+I=;
        b=aifOUScgQu+Hi13wG4u+p4DpsJRC8zQzrLf6i+qG/SBEmQaFCN2JIkhEVb3pFFFWI/
         sbiePjp5jRmm2SibCrvgzKp+KlRETZaWL1owuhgF0hDbetEHAaCMRsUZITsa6pdsbRTe
         f7hCcuc+Y1IUh87HmZ+vB4peGqlt90E8aTX743Cw/fQPpwKRwtQnCKRoGV+Gv/gWSfKN
         4tAAHz3bUn36nm0/XbKeDZJb4yxUDA5YpByIC4BIkce/h1ScHiXgbBdnrDVaVDu30Ef5
         /lWgNfm+gCYokd9JCyH5pjs6gOX1b7hSD4Xrw7T9sPC7pTUCNWlzD6sm6gtbs6LUCByC
         kFzA==
X-Gm-Message-State: AOAM532jmhzw+8t6bQ+NtRxhC+SStDN9MHhZ8a2+fbz6z+YHuaEQR/6e
        GrOMiRloECREvsILuHiINEc=
X-Google-Smtp-Source: ABdhPJz/2EtrrYIqo1LVW1aQs2Xb4oaL2S+YhuZgVD/CT6F5x/mjSOje1mie7ejlt/ixr3AwR/U9tQ==
X-Received: by 2002:a92:c7d0:: with SMTP id g16mr6296943ilk.278.1627767785160;
        Sat, 31 Jul 2021 14:43:05 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id q10sm3721040ion.3.2021.07.31.14.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 14:43:04 -0700 (PDT)
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
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 7/7] amdgpu: define a dydbg-bitmap to control categorized pr_debugs
Date:   Sat, 31 Jul 2021 15:42:04 -0600
Message-Id: <20210731214211.657280-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731214211.657280-1-jim.cromie@gmail.com>
References: <20210731214211.657280-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

logger_types.h defines many DC_LOG_*() categorized debug wrappers.
Many of these use DRM_DEBUG_*, so are controllable using drm.debug,
but others use bare pr_debug()s, each with a different class-prefix
matching "^[\w+]:"

Use DYNDBG_BITMAP_DESC() to create a parameter/debug_dc, and to define
bits to control those pr_debugs by their category.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 21be2a684393..3041e0c3d726 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -36,8 +36,48 @@
 
 #include "resource.h"
 
-#define DC_LOGGER_INIT(logger)
+/* define a drm.debug style dyndbg pr-debug control point */
+unsigned long __debug_dc;
+EXPORT_SYMBOL(__debug_dc);
+
+#define _help(key)	"\t\t" key " : help for " key "\n"
+#define cmd_help(key)	{ .prefix = key, .help = "help for " key }
+
+/* Id like to do these inside DEFINE_DYNDBG_BITMAP, later */
+#define MY_DYNDBG_PARM_DESC(name)					\
+	"Enable debug output via /sys/module/amdgpu/parameters/" #name	\
+	", where each bit enables a debug category.\n"			\
+		_help("[SURFACE]:")					\
+		_help("[CURSOR]:")					\
+		_help("[PFLIP]:")					\
+		_help("[VBLANK]:")					\
+		_help("[HW_LINK_TRAINING]:")				\
+		_help("[HW_AUDIO]:")					\
+		_help("[SCALER]:")					\
+		_help("[BIOS]:")					\
+		_help("[BANDWIDTH_CALCS]:")				\
+		_help("[DML]:")						\
+		_help("[IF_TRACE]:")					\
+		_help("[GAMMA]:")					\
+		_help("[SMU_MSG]:")
+MODULE_PARM_DESC(debug_dc, MY_DYNDBG_PARM_DESC(name));
+
+DEFINE_DYNDBG_BITMAP(debug_dc, &__debug_dc,
+		     MY_DYNDBG_PARM_DESC(debug_dc),
+		     cmd_help("[CURSOR]:"),
+		     cmd_help("[PFLIP]:"),
+		     cmd_help("[VBLANK]:"),
+		     cmd_help("[HW_LINK_TRAINING]:"),
+		     cmd_help("[HW_AUDIO]:"),
+		     cmd_help("[SCALER]:"),
+		     cmd_help("[BIOS]:"),
+		     cmd_help("[BANDWIDTH_CALCS]:"),
+		     cmd_help("[DML]:"),
+		     cmd_help("[IF_TRACE]:"),
+		     cmd_help("[GAMMA]:"),
+		     cmd_help("[SMU_MSG]:"));
 
+#define DC_LOGGER_INIT(logger)
 
 #define SURFACE_TRACE(...) do {\
 		if (dc->debug.surface_trace) \
-- 
2.31.1

