Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8273622D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbhDPOi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbhDPOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F14BC061763
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so32525308edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgIHEbwNozF8CQjai0jy8D0j5kT9wSfHdAr6OHIEyt8=;
        b=vIYbLsCnXZcnG2cRVSblNfFcyusCLsjiUbckjgZLHrJu6wDwi1lkqsJDWjwnKopAbu
         op3YKHikZtzbx4ebcA//omZ7wElXRbE3SIzbxL7lHvJfJz9VvqtD8XnemiSCAyA8Kwnp
         k5hBgFXoTYJ+0Bmaeztgy7ain6htlqbELXe8o/1/xm2P/RJeL+z+SPFh0r40bmb6emob
         VekFGRhmY26RK5HqiqPScD2iCiATVkSt/PR2mBWrYuYRmZom+0wbf9wfUICQXaonjPQc
         UsuTfOaixW7nlp/DpWhgEkkXSwA0gDFdxm1f31eD/B27hticKj+ixocIwwQ2cOScMtd1
         iqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgIHEbwNozF8CQjai0jy8D0j5kT9wSfHdAr6OHIEyt8=;
        b=g+kcH8Lvj9CrliUuoth6wlo1gdkDSYN8tUQo9c6W8R6lp9nwCiVV9peVzxMaXPJ3iC
         pvL0EexT1NhpLf/yWytnR0O1xB7SAqtENV7Tda5nyqKoFmX/9iCbOPtYhJczJrsQ5zEc
         PkPnTJrTsMAdcwBJvcNBRY/5Sym8phVPB4GrZgsym9XLJuDeZrqneuWdjmSZeOdvFZBi
         P+rwJq8fRuNXviycrBIOMRd0FJVAPJzyOMGLZmrGhPVY7Y05R5BABp7MNV2C5Uv3q9bN
         Vw7T3cC/wz/LIP1HhajocOsL9EJWLd6B6zTCxxCD1rAqmI2oiuIhFT9RcASS4I1Tt7+0
         HIgg==
X-Gm-Message-State: AOAM5338SvdFNn4cGgzv99kcPF4mhQvBE0zoa4Gy9CqyhAYlXK3jqJpn
        LARvRrD1vtitkCV3hvYQnrhFeA==
X-Google-Smtp-Source: ABdhPJzhK89Pf/RdgigL+rbG9MyZVtIoXNauFJ4PHalgntAntPQIt9OfCxq6jsCVsJ1pk0yfnwv/Lg==
X-Received: by 2002:a05:6402:35cd:: with SMTP id z13mr10413409edc.21.1618583863370;
        Fri, 16 Apr 2021 07:37:43 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 12/40] drm/nouveau/nv50_display: Remove superfluous prototype for local static functions
Date:   Fri, 16 Apr 2021 15:36:57 +0100
Message-Id: <20210416143725.2769053-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
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

