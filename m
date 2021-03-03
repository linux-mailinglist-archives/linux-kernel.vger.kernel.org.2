Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0132BE6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573923AbhCCRVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442837AbhCCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715DEC0611BD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id u125so6379371wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgIHEbwNozF8CQjai0jy8D0j5kT9wSfHdAr6OHIEyt8=;
        b=DDM5R4xsGiTVpRIEPuVyLljyb6ERGlg1KlQqC4FxmUKm7EgZzmf3FUqCqwRnWSzS1M
         W1Jt8E+Xi1w8AAO3crFj2UNIosYF9a5C5S2xPLVYbdKOz4DNyidBnrZNgND5NXGIo82m
         MwolqE2yBrUUnTQZgwYF00WIuelEBzNqvX5BX16/ko2vetUGo9U2CNIOEW1iva5w9dQL
         DzKQexO8SiTvO2U2ipzDN5VfW8AFExyg6NFrMlYQ0qSEmUutSy3cpsMN39c5j9UJa9xm
         IMN58C0+q+YtF2ntzuUIWAwHfQ8+AGB8BtnY9hrIBv3Y9aGYwpn2ACZZVULICZMS4JQw
         3qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgIHEbwNozF8CQjai0jy8D0j5kT9wSfHdAr6OHIEyt8=;
        b=P5PBOfmzOesMNWVpmnhxvU/W+/Ej8HGd0IuZoVy/5GaYsVOeKS9wEuS3GmUnKKV5g8
         RmcrzgbYK9yUFcmwl/gleQbPJAeu8JSbERcq6/xpVEAp9Qh7ENaFOISBWlVVATar/ldo
         G8BzYSMmzztakfCzlQpSyWquFHOnGTfUuSbGwvfChN5rCzSXm4gTfLFAGCdIAdqaSwx9
         vro/nubonV/Oxzdx3MrT2ObrBJ7yUI6rylZhW5VrYQuw6h9Epk2GLQhn7IkZlnjr/0rI
         YVFtVS52J21p4O381TwQWHGE0UogxVFSf8xT/NIdtsxEIgcJjNcWwcjO4xprNrDUcB0L
         GHig==
X-Gm-Message-State: AOAM533APgI2oe31SxQOVs4HaKsLARxA9vah1roKi/VLYhSuo38YygiJ
        jWmHq9uOD+Dyn08r61kl/CT5SQ==
X-Google-Smtp-Source: ABdhPJxHOaQh1gbCrDX6+3WvqrrtI5i+ZBikz6KzeCDd+omBFFvRiWkXx0KwkxwsaJwM1pEbK8z6vw==
X-Received: by 2002:a1c:f212:: with SMTP id s18mr9320896wmc.133.1614779029145;
        Wed, 03 Mar 2021 05:43:49 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 18/53] drm/nouveau/nv50_display: Remove superfluous prototype for local static functions
Date:   Wed,  3 Mar 2021 13:42:44 +0000
Message-Id: <20210303134319.3160762-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
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

