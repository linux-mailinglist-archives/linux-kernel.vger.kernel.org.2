Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB883B6C05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhF2Baf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhF2Bae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:30:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08407C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 18:28:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g24so11386849pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdAmp65hciYeluIbPve30oHR/GPcy6OyyGVJziF+xHE=;
        b=ajlC3Y2BbwpJvb//BGwKk0iVmUKdgr6EEkltyLi6EKddugzIYMyVm811CxYaTI5RZ3
         XRN3lZcqg0qg+ZKvi6Csnfs2+RUTbc+LchNfBOOelhMYtnA1/2shvLGUzCo6Cz8I6y6n
         Wgb5Dyeh2Nax5GQ3GRJeG23tObPIf5m6B4JIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdAmp65hciYeluIbPve30oHR/GPcy6OyyGVJziF+xHE=;
        b=DMgs51/RRYnTW71Hpmpx9lUOXgDXKXp+aPyrEolx3vamDJNnQkbMi8xkPW/NCUlPuF
         VMHNv4OMiWfJlmH3rK1x1depqlsHodCViY/tQWQ7ttFw48Lm/PsUrV8UFJjyqz8+AxXP
         ycmRALrVRVOngkxcweZRCxmQdK9jMucZiYs4s5iu4TyFZxQCSbwqaSgjg3IkxvwTt99G
         0ZSfT+TEQ/yXpQt+whgHkFxZVVwqmmrR+wlkQ5iTVm5HrS1oMEn4DxSlbwSwftvf+ZfM
         5EO5C/BF7RG7VUym8eHD4j+yt2Q20fCjqIKm7jRawZrwIRCCdM5eSfOsFbCvozc7BNWf
         ANyg==
X-Gm-Message-State: AOAM533sgcy02O8g6CXbRveQAFQ+Cbednz0eWFNpCoyszdws8I6yxw7r
        hOUs+ASQ6GUANw/WIgN8uLpHig==
X-Google-Smtp-Source: ABdhPJxeHRsy5dAA1iYKi4mxjymB6XbfjeJZ1igdinqFlEjY7nzYbW2LIcSh8iUm3CRRIRAqczWUSA==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr16441598pjr.11.1624930087449;
        Mon, 28 Jun 2021 18:28:07 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:7a14:49d8:be7f:e60e])
        by smtp.gmail.com with UTF8SMTPSA id u10sm15664815pfh.123.2021.06.28.18.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 18:28:06 -0700 (PDT)
From:   Reka Norman <rekanorman@chromium.org>
X-Google-Original-From: Reka Norman <rekanorman@google.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Reka Norman <rekanorman@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Kolesa <daniel@octaforge.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Huang Rui <ray.huang@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Will Deacon <will@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Respect CONFIG_FRAME_WARN=0 in dml Makefile
Date:   Tue, 29 Jun 2021 11:27:18 +1000
Message-Id: <20210629112647.1.I7813d8e7298aa1a1c6bee84e6fd44a82ca24805c@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting CONFIG_FRAME_WARN=0 should disable 'stack frame larger than'
warnings. This is useful for example in KASAN builds. Make the dml
Makefile respect this config.

Fixes the following build warnings with CONFIG_KASAN=y and
CONFIG_FRAME_WARN=0:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3642:6:
warning: stack frame size of 2216 bytes in function
'dml30_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than=]
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3957:6:
warning: stack frame size of 2568 bytes in function
'dml31_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than=]

Signed-off-by: Reka Norman <rekanorman@google.com>
---

 drivers/gpu/drm/amd/display/dc/dml/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index d34024fd798a..45862167e6ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -50,6 +50,10 @@ dml_ccflags += -msse2
 endif
 endif
 
+ifneq ($(CONFIG_FRAME_WARN),0)
+frame_warn_flag := -Wframe-larger-than=2048
+endif
+
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 
 ifdef CONFIG_DRM_AMD_DC_DCN
@@ -60,9 +64,9 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) -Wframe-larger-than=2048
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) -Wframe-larger-than=2048
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
-- 
2.32.0.93.g670b81a890-goog

