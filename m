Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1627F341774
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbhCSIZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhCSIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA39C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id va9so8266877ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgIHEbwNozF8CQjai0jy8D0j5kT9wSfHdAr6OHIEyt8=;
        b=jFlylHIdiRjWW3YT3NJyatX6kumdMHVDL4w5muuu5ZNZkb2snt4y8ikCg0ranm6Ww8
         m96+ml0edqRsT4qgjrvCK1wmR2oixp86VlSHuHMKFeI7SwKtaHNkwIpQJGuwmFOBMvib
         8BnfX1G10yRT43gJCTd8AhCTP4I6RFuLd6Zp2FMpE0BRqb/AK6Zyb8wRvI9rSkXF8I5f
         XKXTj2wMGcieuKJSobaGIG2ybJpcCKSDTFqiahHaf4SOLV5wbFRZNMANF9OdrAHwTxfd
         +UzINV1MUayN9Bm9eBacrVY1zmu+7E+XNGBZY688dw0TJZxcrg7wwbkYDcuC1+rQr82C
         AGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgIHEbwNozF8CQjai0jy8D0j5kT9wSfHdAr6OHIEyt8=;
        b=ayGVaPNupvFuzOfC2/J7rF0uVjEv34dhcq4pJRF0VK14OaqAyDlZGEMEfbkPBIRb2K
         FJPSevihbsfmoohfw2Oynl27xLe2DmyOxk1Lk/gx6p22MZ1QQvHRzkE/rbs61r6acRU6
         0MhNTBJYZ2Pcg1KaYmhx5NTOdj0IyL6WPp4g5QPW4BHZ3z1vou6PlYonLEJ8e+Bk/kJ5
         dhzb7qUv+sX9gM3G+bpTRTZWPtYgYQ6HskSAw4ug14GPWZ//DF4K7NLxQSKS1wr+mZWM
         GLMMQWND3m7t5NFMn/fZBBJFvpYjE2+i7jaN9EYVZxgWNe3fmlJueAnjkVdVeUcCD+e+
         QG1g==
X-Gm-Message-State: AOAM531lGplu1OtlyH07TTMlw0HQLYZU+d/LfKKgbZrKqfhxGvxVehYf
        wFsO2HGmzZjZ//np//fRcxsPOQ==
X-Google-Smtp-Source: ABdhPJyVuWB7o4CF5wAL/W6n7Ok9f0Tc0wd4Z4nANrbihKHz6pBJkEP20GSW1Lukf9i/YMR6XsDz9w==
X-Received: by 2002:a17:906:73c2:: with SMTP id n2mr3009679ejl.224.1616142286710;
        Fri, 19 Mar 2021 01:24:46 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 15/19] drm/nouveau/nv50_display: Remove superfluous prototype for local static functions
Date:   Fri, 19 Mar 2021 08:24:24 +0000
Message-Id: <20210319082428.3294591-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following build error:

 drivers/gpu/drm/nouveau/dispnv50/disp.c:2530:1: error: conflicting types for ‘nv50_display_fini’
 In file included from drivers/gpu/drm/nouveau/dispnv50/disp.c:71:
 drivers/gpu/drm/nouveau/nv50_display.h:36:6: note: previous declaration of ‘nv50_display_fini’ was her
 In file included from drivers/gpu/drm/nouveau/dispnv50/disp.c:71:
 drivers/gpu/drm/nouveau/nv50_display.h:35:6: note: previous declaration of ‘nv50_display_init’ was here
 drivers/gpu/drm/nouveau/dispnv50/disp.c:2581:1: error: static declaration of ‘nv50_display_destroy’ follows non-static declaration
 In file included from drivers/gpu/drm/nouveau/dispnv50/disp.c:71:
 drivers/gpu/drm/nouveau/nv50_display.h:34:6: note: previous declaration of ‘nv50_display_destroy’ was here

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nv50_display.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nv50_display.h b/drivers/gpu/drm/nouveau/nv50_display.h
index fbd3b15583bc8..2421401d12636 100644
--- a/drivers/gpu/drm/nouveau/nv50_display.h
+++ b/drivers/gpu/drm/nouveau/nv50_display.h
@@ -31,7 +31,4 @@
 #include "nouveau_reg.h"
 
 int  nv50_display_create(struct drm_device *);
-void nv50_display_destroy(struct drm_device *);
-int  nv50_display_init(struct drm_device *);
-void nv50_display_fini(struct drm_device *);
 #endif /* __NV50_DISPLAY_H__ */
-- 
2.27.0

