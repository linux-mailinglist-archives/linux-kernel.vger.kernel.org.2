Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A46398D08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFBOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhFBOfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:35:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7298C0613CE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:33:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h3so1449388wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVk/K6SiOopKBeZrOFr3ETwL2h0sUuVeJjHQIvLbemo=;
        b=aOFSzbMh1MJoVmxlcUdFd7U7AXDU29/SRvovXJ/BeXWOGMTp7ZiZ5+ET8rZahi52XC
         hHDhj0Lx3Wc5PNGUDrKCNTx5QuvAelYzl4pw5OkYJPkUuResbzQ9wEWBDk1JFEgvdzvq
         7LC0I3lfvRWBsPUeCCHB0McrH101t6G/TFaIl8uVofGuk+LlX2xALid4KW3okkHvPtMl
         R8YPiaapgbSYH0BtQ0eb3VJ/P9UTdLMwwZYxGHg9ElRG7QaS+dlGKDGjJLn+HLLpoDSQ
         S5XvxR4cDDxbfSnepK0A7TgnHIpxpwUpvsYtzaydMJ+KHUWD9rv6ca2rd2QY/+PL1Kzt
         Zk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVk/K6SiOopKBeZrOFr3ETwL2h0sUuVeJjHQIvLbemo=;
        b=KmHOnetifzRzBTTtROiyyLcRtTxzI0WH+QoeFFNsnReQuQPdhPBA9RoBHhRSsU+xoP
         FwzOc3RWdNDyWIew0KAeFUv0PB49wk9eHFdIpaN4AfXrYE2c8av+wM3epPDD/fBpe7d5
         BT6/No2dIcPdy9V8HUbgdoBdojZhPg8ea5tOHNgXnW9V/O4+6c2+e9J146n2XolYJJZq
         JEORS4agCLz/bIL/6Vw5A9EZ9glYKf5f+iwwUEvOsNXxJJP+sEFaNM7yNJsBQQi9ESOJ
         954VOdgqa2TJJSwpXZSYTS/IFz2qx7HTtZOHJLCwkf1wdZ68sL5MX1LiVX1KdObUCgbx
         Q5kQ==
X-Gm-Message-State: AOAM5304b6sCmmdHpTtaCSpSb6DLlZCneZp5plSgs9kd7pMFcvOgEmAS
        rJ+k241WLkNcqfzNHtX+Ljq3Dw==
X-Google-Smtp-Source: ABdhPJx7/89qHUI3nSWoMnefrKMkjP5VwkmsVsC8ptnnljyy095o77k3JyChKVY7mNukeFzEjN8Dfg==
X-Received: by 2002:a7b:cc87:: with SMTP id p7mr5628267wma.85.1622644416555;
        Wed, 02 Jun 2021 07:33:36 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND 26/26] drm/vboxvideo/modesetting: Provide function names for prototype headers
Date:   Wed,  2 Jun 2021 15:33:00 +0100
Message-Id: <20210602143300.2330146-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
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

