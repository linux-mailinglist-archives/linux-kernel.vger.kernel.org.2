Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8003D3622C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244622AbhDPOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhDPOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA05C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z1so32558908edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MDb62l+8C+YekUvtP2oUdE/QSSZdTHGqGLcmgtoRZ6A=;
        b=OEAZ6pguOUQ94jMlXQzmtQ7QFPzW5+1bIvMTPHQc6HJS+PcftJ6AF9Jo3cQY1raYir
         GcbbzBVqcto6mrFzlum7j3SE/HIpRj5EGQdlmzu0Fj2vW+g/XCoRlkp2nxMM9p80xnjN
         vridHysscUhssHNwEDny1VZ+bPTMhH94/K9wuMQzKCovSqSc+zCdtztyo8NQdCHamczB
         cVL2Cl8+3ZMMjVYMOfaQyG1MwZg9FpTT9u6WJ1lQ7gR40O4/xmJh4Irk55PnetEtInV0
         6+Hnu82JjUPCmQZWm4nEwmkdACQTiH3m3m6A+KHdCRz//PskTjJtDFX0d62j26DVAaDr
         B5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDb62l+8C+YekUvtP2oUdE/QSSZdTHGqGLcmgtoRZ6A=;
        b=CkZdzpBq7qOGVd6bkDZGfZxT+ZdPLzur0KQmY5o5RYUOI5CNN3CnRpBwy+UgaRxjI2
         pNr6RxwCKPLv01MZYdKTiuoEr8eHkWhT1R7tLcVmpQog5NnCJzGgdhDtk7AxFTQzoigO
         /cOPUhpq5/VDG7Q9PVsFsmdO5hmCRbzXCXNdl5zIHCVXJYChi0T9f2Upxs5PRMpZCVdK
         wPLBlkbBOIZ7a10NHlWMRepRzv9xsYBaAJqvwlUEJIqowl8MB96ZXoP6K3mYviDx1f90
         b8lyfSdVSitlAY7XUues4ZLNHIb42tvw3pao8nDzujSyxVJwd65PLqsxuq4Mu3Ejx1ok
         FqPw==
X-Gm-Message-State: AOAM53022RN6WCsuf7z85+PWi/ihIszyi9GuF815UPQcn/P79GhoLv2y
        /tBrVewFCy1MP9PBqCHRSTc5KQ==
X-Google-Smtp-Source: ABdhPJxeW5Nq4C2iQB/wfPS4zsFgvxhhdWRVuw6s5n3b8DbFsnkP2EkcK4Air1ZTyXmKgbiYULFGiw==
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr10546460edu.124.1618583859364;
        Fri, 16 Apr 2021 07:37:39 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 08/40] drm/nouveau/nouveau_display: Remove set but unused variable 'width'
Date:   Fri, 16 Apr 2021 15:36:53 +0100
Message-Id: <20210416143725.2769053-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_display.c: In function ‘nouveau_framebuffer_new’:
 drivers/gpu/drm/nouveau/nouveau_display.c:309:15: warning: variable ‘width’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index dac02c7be54dc..be2327ce7394c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -306,7 +306,7 @@ nouveau_framebuffer_new(struct drm_device *dev,
 	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
 	struct drm_framebuffer *fb;
 	const struct drm_format_info *info;
-	unsigned int width, height, i;
+	unsigned int height, i;
 	uint32_t tile_mode;
 	uint8_t kind;
 	int ret;
@@ -343,9 +343,9 @@ nouveau_framebuffer_new(struct drm_device *dev,
 	info = drm_get_format_info(dev, mode_cmd);
 
 	for (i = 0; i < info->num_planes; i++) {
-		width = drm_format_info_plane_width(info,
-						    mode_cmd->width,
-						    i);
+		drm_format_info_plane_width(info,
+					    mode_cmd->width,
+					    i);
 		height = drm_format_info_plane_height(info,
 						      mode_cmd->height,
 						      i);
-- 
2.27.0

