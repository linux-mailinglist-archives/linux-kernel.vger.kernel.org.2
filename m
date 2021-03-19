Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12CC341771
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhCSIZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbhCSIYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B49C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k10so8283482ejg.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3BFodeOPTMMoMJFhYQYaXV3COFge4hJ56ydgoQMcn0=;
        b=yDpwOUtr8Y8qaTzYWOy1tt72khTzKSstlpxPsggpndpTO0YpW29THZpXQ9yaQtYC79
         68SiANuDXV2bSx2a9n5Y3wAC/eP0plAl1TGb6e+VnH1n4+0m5M9iXQI0YAoCJfyjI92r
         bJO4s7N++8FfpUyaw9clV/1j0pVHhkhv+aBOSJlq/c34rzYh33L12XhsLGnY+GSnpOSP
         clPV01gl/MoIDV/HszIHC/Uqp5oKYVVQgSfQ1CUHacjvw22R5vfaWmvOYp9Jg7ANcaMD
         SkYlMwCKcvaSKswcxaHWWBfBb47Q4a3HBm2iAsPljuDZ33X3VcDmgTCdML23L3pKNPM2
         Ed7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3BFodeOPTMMoMJFhYQYaXV3COFge4hJ56ydgoQMcn0=;
        b=TaTLkEePmE4LTGhvZOzlPmPBlQ0pEiJBAA2K4nlWAsa1OP9RnVKhun8ggOwpaLDZG7
         q8adKYp/dbkmFa+FUuSJdwoKg3TD8XAzyVxVtVOfEbsw921c8u0QokBg+04KOXkWCy7w
         pGFt+0gvwBMHXucPn/nqKu03E0jmOEpJ18bimBP33TYt3Bd1Bf9hxqHx35q/ldsUcHyL
         EBSSTnmCOQJtsXPaCL++iNS2PzkbH2TNKxHkl7QfvqpkRL9BD4lKczJky9jWA+Ux7rYH
         8FVPCqRAI82WNQJEosL94WAvO8FfNZU5hJBG2TbRBT98EI2vIualJkt9VSSoWsQG4pRl
         HpMQ==
X-Gm-Message-State: AOAM532rfM201FFJFyzHMyxKz9+AqE0dnJ48+h7ICadE2SYQo8o6rsy5
        D0mp6w4dBMZ+r/7YGSZEhTWwcg==
X-Google-Smtp-Source: ABdhPJxoo5i8vW6NNowcMoz9sB++W3ReJn5ajzefnBphKE7+Df6szDDubQQH7q/pELeFudxCf4ap9g==
X-Received: by 2002:a17:906:b4c:: with SMTP id v12mr3007707ejg.330.1616142284127;
        Fri, 19 Mar 2021 01:24:44 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 12/19] drm/nouveau/dispnv04/crtc: Demote non-conforming kernel-doc headers
Date:   Fri, 19 Mar 2021 08:24:21 +0000
Message-Id: <20210319082428.3294591-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
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

