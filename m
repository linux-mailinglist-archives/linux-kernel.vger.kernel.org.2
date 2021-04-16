Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C173622D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbhDPOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243683AbhDPOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFEEC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x4so32589958edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QN4aBNwxKOCABxwfpyuG0Xk/7oUm3WT2PgkGnXFzadY=;
        b=RwSZt871KIA+ZvsKOJpIutalCd3bcubnhe5yJ8ZZvr1njX2RG+VN1gGQd8B37zPJu/
         9xA9SobU/iCgxon/a79k928X3sbW/Xlu5UGL+KSDQSMWyyoR1EUGtMzfiGBEtSkoD/1w
         Yo0mDcvabfy77pd1QqB2qJ5Rzl8bv7Zums/J7av8dbzQpx+EpvLFCcpOa/wletkE0Kie
         oBgD09ElxbYvm/sK6ZwyTKhnXlWhwQZ+NuMTqJH6HpdEuGbMbz3uW47dPpvKl6eRimEL
         +PSoJBKs8IEUisnQOl+YPDBubofRWi0JVa2FAJ5reYSbOIBuEvIhhtHgC4D5T696N9FW
         O0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN4aBNwxKOCABxwfpyuG0Xk/7oUm3WT2PgkGnXFzadY=;
        b=KKv3SmSaccyPebt/P2MWwA+yYfiGeXw/pqz0zQHiCfNwdDCRgh+RM6X3CpsZ9jeMUD
         RgViBugFbYAepeX1SfKr45THF3GzSNSbXPpNnJMFQHMScDVEOmQKZxgoY81vtrgIcTZh
         3Uj/4WXCzWeUx7Z7eey0eyrL3uCEQluwHMcuR2L3eiY56DYiVQkh4R/ozSUMERrRkoN9
         2z0dkuBosOsatVyYaZS1wnC/0nx8Fa4tlbqJClgiAKKhhw5hH/gKFv1aGZfMoBpHa+xW
         TbjaR+N17dMWIWMdp57UpY8nDITC5ve+ptovTeo6x9+2cHa2yJ2UcAprxPQo0rIPNavz
         PTBw==
X-Gm-Message-State: AOAM532jVXJ0NiznZPKyd/QmPiJMNcX9vn7NbpUaYnIooQQk8XlGE94g
        6UWu3k4C1IVHqLMaJIKHh1yCRKbCs63YlA==
X-Google-Smtp-Source: ABdhPJw0G9wVgPhyke4No6DirCQEXf+UVha822Lo3qpRPrJK540wDzZh2MuxAjhp/0+TJ35klHf7Tg==
X-Received: by 2002:a05:6402:31a9:: with SMTP id dj9mr10380014edb.343.1618583865142;
        Fri, 16 Apr 2021 07:37:45 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 14/40] drm/nouveau/nouveau_ioc32: File headers are not good candidates for kernel-doc
Date:   Fri, 16 Apr 2021 15:36:59 +0100
Message-Id: <20210416143725.2769053-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_ioc32.c:2: warning: Cannot understand  * file mga_ioc32.c

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
index adf01ca9e035d..8ddf9b2325a42 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file mga_ioc32.c
  *
  * 32-bit ioctl compatibility routines for the MGA DRM.
-- 
2.27.0

