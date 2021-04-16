Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8B3622DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbhDPOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244211AbhDPOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59592C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d21so12452362edv.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BenSWVQP2zN1koiPW0t4kws5hTFRiEoau/BE1y9GfNM=;
        b=HIAesytEg5S3sduMFPZ6ZtYIe1kNf+o5CbxfxLRVidE4pbMb2kNGB64UxIGQU2qRyM
         enc++rAblmvxbBCHBLncASVRGti1rSEsilx9FwhuOehh6gVuXXsI6Re/bG3gJuv+y+in
         CSCstZfPkCUC7FIEyTX+0I7CB1NSsmmH1fDey0abB0EpwuZKW6ueLNv/XdiZ2V2UEJn4
         NQlDG1UkwPm+gpcJ6bieuV8UmL8z8ZF5GAWLN11J0ywRM/zGDAJQ0Cf9a8fI/BrQfWR+
         FtPDM926uNLX5X90uAItZowa8ttUBbcgMOz/r7cf9oZZHYVBD/Bl8g0a8NvPX7M/jDkE
         Lu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BenSWVQP2zN1koiPW0t4kws5hTFRiEoau/BE1y9GfNM=;
        b=Fmb/mUi3sYkK2AUeWRBr8ZlyYJXDU9wl9mWMcnCnzwj0wVyc7KXqy/A4g+MpAVqvYy
         IVSP4PfdcKZqavjzcAkfuR/Eq1YLwyKtzMVs8sQqgGlmFB98Ku10E+VWT8GxkfER5S5i
         U5RFp+k8WaGwEdUlUhpep2iwMUHZizrf7M3jwfur6IfbdpDIRU6/4MmGnDXoKyTy5AxJ
         s69A77+J28sjP22zHYOtYVgSux0s+jhO0CQHUjleY4tIGJdGc+Kh9GgA7EyiljP53WST
         L8aGDUR+J0MUjzKBoVfElPd17UXrxwXegm2tA6u2JtQ/WdGwvWVWRRrItRoikEFe8/Fj
         O9dw==
X-Gm-Message-State: AOAM530+AFYIBVSjMDk1dXnDGk6bx8VGTlXpWCBfT7oM5lyOgFK7CTmq
        FTwP4pgZnPgzV76E36+igWpLug==
X-Google-Smtp-Source: ABdhPJy03x/bQOosuLTJJIEEGcLYhuxCxgQFnP3tHnQy4iOpxU3Fu9WUEZt8yiBzKt28dhZZF24//Q==
X-Received: by 2002:a05:6402:518b:: with SMTP id q11mr10396198edd.151.1618583867088;
        Fri, 16 Apr 2021 07:37:47 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 16/40] drm/nouveau/nouveau_ioc32: Demote kernel-doc abuse to standard comment block
Date:   Fri, 16 Apr 2021 15:37:01 +0100
Message-Id: <20210416143725.2769053-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'filp' not described in 'nouveau_compat_ioctl'
 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'cmd' not described in 'nouveau_compat_ioctl'
 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'arg' not described in 'nouveau_compat_ioctl'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_ioc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ioc32.c b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
index 8ddf9b2325a42..2af3615c5205c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
@@ -38,7 +38,7 @@
 
 #include "nouveau_ioctl.h"
 
-/**
+/*
  * Called whenever a 32-bit process running under a 64-bit kernel
  * performs an ioctl on /dev/dri/card<n>.
  *
-- 
2.27.0

