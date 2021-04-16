Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155563622D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244826AbhDPOiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243572AbhDPOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1ECC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m3so32536121edv.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3BFodeOPTMMoMJFhYQYaXV3COFge4hJ56ydgoQMcn0=;
        b=u2Cuu4Jc4BAtOcP2wM3yaX4ApJCJGReeFsvfaoDTG3jKvKE3+Iu75Kt7ZdJ2zK9z7l
         fbTQxy6O245G8O9EHIoBFyChD/v/K62OwzhOwL68dACvrQyMliAqxL4InjNRq5jAis2c
         exA8ZmQsMUtVPgvKzkfSMyaKhwr8GL2Abqnqk4UAOiA6O3bDneKMvcbyZM9YuX5zkzc8
         tZhzJUOzm+R5/ZHP5qJn7pVAdvyDNLGeQ764UfKpbHf/lkkxgeN8MjUnkJKZGo4tstbo
         35E4GaxucIbTZrvooB4yyntd03WQe+Phz4IXTPvTnxrsURAvnAbinRVGuE9dR+su51Kk
         B4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3BFodeOPTMMoMJFhYQYaXV3COFge4hJ56ydgoQMcn0=;
        b=TcbtYWvKqNeBYSdJdyBENe9pEkSDqlChL016oQTYEgDA1o4eqS1ExAQw0rrkKwiybl
         v2a696+9SrAfAwfSLlQnGEge4ZslcaP9sb2p4PldRvMpU1TJ9GyhGRy/L4pQNJkEgvSf
         Tip9HUGcFc2P8a5Ow6eS2ZZiBu9BNknDYhWDhx1Lo+0xQ15SOty8bz1VJ3plmD0l7fom
         sUgFTDuPE+gQMZZfj0hHa7bTVDJ3gJnrH7VZCdVmfN68WTsPptJ+/2NqgzyqW5lpqBG1
         n6KOOxe58RyY2g/pH15HtsH8gceELz8hSEWyWdhMgzSY45YYRV3qGPYyyAMfswkgUCIV
         7S2g==
X-Gm-Message-State: AOAM5322WYv3L+3u4RYN8wprNEqDf+jOmfmuME6cuTaGKdWrt9/SpbyX
        jBKxpmTfqfrAqAX1rFsDutt9Eg==
X-Google-Smtp-Source: ABdhPJwm/qXC9CmXFKpJRRi0FkxYSeD2m3JvMfrF6aIw+Mh8m2TcrBzkpSLtohDDKKDObBVHHaPD7A==
X-Received: by 2002:a05:6402:1287:: with SMTP id w7mr4512924edv.208.1618583860376;
        Fri, 16 Apr 2021 07:37:40 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 09/40] drm/nouveau/dispnv04/crtc: Demote non-conforming kernel-doc headers
Date:   Fri, 16 Apr 2021 15:36:54 +0100
Message-Id: <20210416143725.2769053-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv04/crtc.c:462: warning: Function parameter or member 'crtc' not described in 'nv_crtc_mode_set_regs'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:462: warning: Function parameter or member 'mode' not described in 'nv_crtc_mode_set_regs'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'crtc' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'mode' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'adjusted_mode' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'x' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'y' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'old_fb' not described in 'nv_crtc_mode_set'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index f9e962fd94d0d..f9a276ea5a9e0 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -449,7 +449,7 @@ nv_crtc_mode_set_vga(struct drm_crtc *crtc, struct drm_display_mode *mode)
 	regp->Attribute[NV_CIO_AR_CSEL_INDEX] = 0x00;
 }
 
-/**
+/*
  * Sets up registers for the given mode/adjusted_mode pair.
  *
  * The clocks, CRTCs and outputs attached to this CRTC must be off.
@@ -625,7 +625,7 @@ nv_crtc_swap_fbs(struct drm_crtc *crtc, struct drm_framebuffer *old_fb)
 	return ret;
 }
 
-/**
+/*
  * Sets up registers for the given mode/adjusted_mode pair.
  *
  * The clocks, CRTCs and outputs attached to this CRTC must be off.
-- 
2.27.0

