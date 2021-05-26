Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF53912FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhEZIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhEZItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B2C061352
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r12so231608wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1FEEZ6P0S4l/25hBadFVgOVdkrL3aHOBAeW0vMC5CA=;
        b=zfhh2O6P8DylNjUuy1kAnE6HCVfcj23pKW4MI4X3zCxipAtycmlxMCpGLJEDvIXUWW
         LD6HVf3BT+Ps/iZ5CVJR3AaB6fmApN8qkHBuzls0+EXNDrOE5WkasQeAy00bgmffHV+V
         BAKy4ziCI7YVymwUrqeswepb4mOTa4CDPlcDKr2yYY8SBwNpIFEe87HqreB3sOyz9zmj
         cmLs943uswyNh0+VxY1t/kZ1qWjfayz9dLd9OS4GhQ1zscL6CVhoS3JhEH2OamRiSe0+
         /b+UyjY43ON8f/fBGr785HlD4TWqXuV+NmARfDvjEhyXo3PhtFep7q6BWCtl/niBz5Id
         ihgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1FEEZ6P0S4l/25hBadFVgOVdkrL3aHOBAeW0vMC5CA=;
        b=ZWUBa8McEkKvbdOAjsPmtLIlfMEYRrDD1van4oxFlISlAYzgMMaq6lZyL5a+dngtNY
         gtXo4w2T/xy1LFLc6BgDqFok869xiqgaR7Pt7QdZ33NtXWHafYL8SAf9qXIDKwJZwPlb
         XQFU/fd3zEFOHv182GZEL/RivO8FsSZ9uF+BR4VOQ45ry7uJjvL1ctdBPffYcKN8CDBd
         cCBA1JtAi+Yiq3zk02xuszpdU6xoC+MVZLZ20HEXSwjDJlaFIpKnwkI52K2RkzRYtME0
         jPovfJou2hwq3Gq4AJAoMqMcvP6BTfbn9FXVDD/i5pPy3ZRgQg1wT85tHTDTRg1Fftrk
         QZiA==
X-Gm-Message-State: AOAM5301e36Rhq9zGPmn6RzkwfWldLkiPqxl/sojgDuiV09rMTLPThzp
        y/U0NgjwO5W2zbvt6CV52mvTUg==
X-Google-Smtp-Source: ABdhPJxGXwJgROU3bwZTUbIFx7pkLuSuNxFOiW93AfYV3f4AEdnue+CYugHm9C0HVHvuuVYMdhN1rg==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr31666122wru.94.1622018887659;
        Wed, 26 May 2021 01:48:07 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:48:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 33/34] drm/vboxvideo/hgsmi_base: Place function names into headers
Date:   Wed, 26 May 2021 09:47:25 +0100
Message-Id: <20210526084726.552052-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vboxvideo/hgsmi_base.c:12: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/vboxvideo/hgsmi_base.c:42: warning: expecting prototype for Notify the host of HGSMI(). Prototype was for hgsmi_send_caps_info() instead
 drivers/gpu/drm/vboxvideo/hgsmi_base.c:74: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/vboxvideo/hgsmi_base.c:102: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/vboxvideo/hgsmi_base.c:174: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vboxvideo/hgsmi_base.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_base.c b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
index 361d3193258ea..8c041d7ce4f1b 100644
--- a/drivers/gpu/drm/vboxvideo/hgsmi_base.c
+++ b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
@@ -9,7 +9,8 @@
 #include "hgsmi_ch_setup.h"
 
 /**
- * Inform the host of the location of the host flags in VRAM via an HGSMI cmd.
+ * hgsmi_report_flags_location - Inform the host of the location of
+ *                               the host flags in VRAM via an HGSMI cmd.
  * Return: 0 or negative errno value.
  * @ctx:        The context of the guest heap to use.
  * @location:   The offset chosen for the flags within guest VRAM.
@@ -33,7 +34,8 @@ int hgsmi_report_flags_location(struct gen_pool *ctx, u32 location)
 }
 
 /**
- * Notify the host of HGSMI-related guest capabilities via an HGSMI command.
+ * hgsmi_send_caps_info - Notify the host of HGSMI-related guest capabilities
+ *                        via an HGSMI command.
  * Return: 0 or negative errno value.
  * @ctx:        The context of the guest heap to use.
  * @caps:       The capabilities to report, see vbva_caps.
@@ -71,7 +73,8 @@ int hgsmi_test_query_conf(struct gen_pool *ctx)
 }
 
 /**
- * Query the host for an HGSMI configuration parameter via an HGSMI command.
+ * hgsmi_query_conf - Query the host for an HGSMI configuration
+ *                    parameter via an HGSMI command.
  * Return: 0 or negative errno value.
  * @ctx:        The context containing the heap used.
  * @index:      The index of the parameter to query.
@@ -99,7 +102,8 @@ int hgsmi_query_conf(struct gen_pool *ctx, u32 index, u32 *value_ret)
 }
 
 /**
- * Pass the host a new mouse pointer shape via an HGSMI command.
+ * hgsmi_update_pointer_shape - Pass the host a new mouse pointer shape
+ *                              via an HGSMI command.
  * Return: 0 or negative errno value.
  * @ctx:        The context containing the heap to be used.
  * @flags:      Cursor flags.
@@ -171,9 +175,10 @@ int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
 }
 
 /**
- * Report the guest cursor position.  The host may wish to use this information
- * to re-position its own cursor (though this is currently unlikely).  The
- * current host cursor position is returned.
+ * hgsmi_cursor_position - Report the guest cursor position.  The host may
+ *                         wish to use this information to re-position its
+ *                         own cursor (though this is currently unlikely).
+ *                         The current host cursor position is returned.
  * Return: 0 or negative errno value.
  * @ctx:              The context containing the heap used.
  * @report_position:  Are we reporting a position?
-- 
2.31.1

