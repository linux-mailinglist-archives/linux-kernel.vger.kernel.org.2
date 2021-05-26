Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE33912FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhEZIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhEZIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35BC061357
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso2908683wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVk/K6SiOopKBeZrOFr3ETwL2h0sUuVeJjHQIvLbemo=;
        b=nP2v/yOq7y++OdxD8esKUXZCbD7knxLYxvNUMGe8eczAbKtAZB0Noi4WYds+F5h4nF
         aHEDPl4vj4f/qqvIdFUNo83sIAVBvdjTgk6IAVHC4XA9RTrRO7lUGH72cSg7RAQ/IbuZ
         ozf7cJcgZzhq6Oo6M9Xmg1dWZV054Ha+tCTpbtll+jmQpmcuWwUxfL1eRhlaRGIVhRen
         04os9v7VPlmlAlSZdYJO9oNMQ32kKvCo5X/PcNFikiqHPyBk6x1B5XJdzCz3Fy8zVAIU
         /mr1dy1c4bpQ6K7zWoMUQjifoDJkObY6Xqe0TS7+2tr2IbmPkzsvr01ABIRkB1uRroVF
         aSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVk/K6SiOopKBeZrOFr3ETwL2h0sUuVeJjHQIvLbemo=;
        b=I9frwQ3KCnmn2s2FbVQD4LhVMQmmIvR1Wg6/KWptfG3C8gZJ4QTDHOcaKIlHHoY2YD
         63ptnfkuyR8P1q6xwb2dHObyUDALLVgHmh/AzEh4CrS8Pi9sB+tu1qIFWlSCqcgCTmpe
         P9cztadF0sct9FykDUgUqQcyB/q0Sf3TqqCGropx84RGNlony7quG8Fx/lkAFFLMCbvs
         Tng7ESg2CCkJLSTvtPvIyBNh0rnTvGB+3ny/YuyT7GrA7/mWIaM+aDJYrBVd6nDjrq5e
         NAqk0b7sPrrgL69njyxRswn5sHqrwFjN+ucmt4vHIL182KNeiFO1vCTc/b0ZVebdRDQq
         Rlpg==
X-Gm-Message-State: AOAM530ZfJGjcpIt5620UQhQJR9DgHs1ZV8Vdqn3l7fZunMXHogeru4V
        yNRJHML8J6QZs43unHAAzbxzsQ==
X-Google-Smtp-Source: ABdhPJwPUsJd89Hlud9WCfrbJsuLZuyhv1Vh6sXdRQBlQX/zH3fwxRZXrKlzShfCGJ2d+PE2esLA1w==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr28151212wmp.164.1622018889518;
        Wed, 26 May 2021 01:48:09 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:48:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 34/34] drm/vboxvideo/modesetting: Provide function names for prototype headers
Date:   Wed, 26 May 2021 09:47:26 +0100
Message-Id: <20210526084726.552052-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vboxvideo/modesetting.c:11: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/vboxvideo/modesetting.c:54: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/vboxvideo/modesetting.c:87: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vboxvideo/modesetting.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/modesetting.c b/drivers/gpu/drm/vboxvideo/modesetting.c
index 7580b90023792..10b32d986b956 100644
--- a/drivers/gpu/drm/vboxvideo/modesetting.c
+++ b/drivers/gpu/drm/vboxvideo/modesetting.c
@@ -8,9 +8,11 @@
 #include "hgsmi_channels.h"
 
 /**
- * Set a video mode via an HGSMI request.  The views must have been
- * initialised first using @a VBoxHGSMISendViewInfo and if the mode is being
- * set on the first display then it must be set first using registers.
+ * hgsmi_process_display_info - Set a video mode via an HGSMI request.
+ *                              The views must have been initialised first
+ *                              using @a VBoxHGSMISendViewInfo and if the mode
+ *                              is being set on the first display then it must
+ *                              be set first using registers.
  * @ctx:           The context containing the heap to use.
  * @display:       The screen number.
  * @origin_x:      The horizontal displacement relative to the first scrn.
@@ -51,10 +53,12 @@ void hgsmi_process_display_info(struct gen_pool *ctx, u32 display,
 }
 
 /**
- * Report the rectangle relative to which absolute pointer events should be
- * expressed.  This information remains valid until the next VBVA resize event
- * for any screen, at which time it is reset to the bounding rectangle of all
- * virtual screens.
+ * hgsmi_update_input_mapping - Report the rectangle relative to which absolute
+ *                              pointer events should be expressed.  This
+ *                              information remains valid until the next VBVA
+ *                              resize event for any screen, at which time it is
+ *                              reset to the bounding rectangle of all virtual
+ *                              screens.
  * Return: 0 or negative errno value.
  * @ctx:       The context containing the heap to use.
  * @origin_x:  Upper left X co-ordinate relative to the first screen.
@@ -84,7 +88,7 @@ int hgsmi_update_input_mapping(struct gen_pool *ctx, s32 origin_x, s32 origin_y,
 }
 
 /**
- * Get most recent video mode hints.
+ * hgsmi_get_mode_hints - Get most recent video mode hints.
  * Return: 0 or negative errno value.
  * @ctx:      The context containing the heap to use.
  * @screens:  The number of screens to query hints for, starting at 0.
-- 
2.31.1

