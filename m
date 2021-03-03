Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBBA32BE87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385731AbhCCRbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbhCCNtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:49:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF59C061D7F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d11so23735564wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KdaK2Zgurdc2XBJ7TzojsBHhNgJ68uvnriIvTNra9Q=;
        b=aCSLzlZkfC4ASi5bh4N+pN0ysuREn9w+yJ09GOBz+DLieRSdo74iSzbbgy3fv5x468
         6NKu6gBGbVxUe2gIDUv3NQWEMtBgr/SZiT5Y/Ml9z5G1K3JsSUs79ZwknNMJW8yIdgOB
         oOPEnjC/cbq3uY+dX5yhVuYwV7GNDWBbukZkRuZmTsi1Zg/k8E/H346MduYYs3flk2n6
         L47IaocbQGIF3MgSMr+ElG7ccqQ5gPi2Z/cxEYqr3tUkWjAKRz1dBKK2JPbkt8XHhLZ5
         Y5dLj0/i0yyCcGJ7X6yJ0nk9N//SRSE1YeE3B41NXhNz3XzQDMAQLACMBbNG5kLY0uAd
         P0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KdaK2Zgurdc2XBJ7TzojsBHhNgJ68uvnriIvTNra9Q=;
        b=ekr5VyznkmbFEehp3Jj2HzDEW3F7qrwzu8RYExeYF3tRCHMFCKWkW4Se4F22uODyyT
         0j9J8lQ2eszIDpkLPTWhBsOaVlElIuLz9hf1iYK/FfGdQhxzVnKt8A4hFov4iHPSLf37
         Rk4ff2WMdmo8wZTzdZwjsVS+b7h2eY4hTdWVDSLhy0SAEZviLQ8i28pb6vtNoLJ3IOPY
         mQZnBzu6FYqsAcQ3Ho7BZiE0R81gf58grBDTZM1CT7VVaUWaCkZ41uylQXECb8wyuXFU
         LZ0BcgdsRVsqTIsaJXjZqyVPJXAzXD296mLolcNL8w/YGxJXYzWFVrIIb8pcf9QAw3AV
         RoKA==
X-Gm-Message-State: AOAM5304Nm7mcWMKuQqVxZDoOkT5uG32CWEF+4pet2wHDMPD7Tdn2u9R
        X+juQvx6v5bmRUNkdPyj/nePTA==
X-Google-Smtp-Source: ABdhPJwcF/G5c1APjaXyUgeuGpHYSruSfHA6dEf1VlUZ663bNBajzGetIuRdNlM2PORt95sVf85I5g==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr27416466wrq.73.1614779052427;
        Wed, 03 Mar 2021 05:44:12 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 37/53] drm/vmwgfx/vmwgfx_scrn: Demote unworthy kernel-doc headers and update others
Date:   Wed,  3 Mar 2021 13:43:03 +0000
Message-Id: <20210303134319.3160762-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:90: warning: cannot understand function prototype: 'struct vmw_screen_object_unit '
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'dev_priv' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'sou' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'x' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'y' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'mode' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:168: warning: Function parameter or member 'dev_priv' not described in 'vmw_sou_fifo_destroy'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:168: warning: Function parameter or member 'sou' not described in 'vmw_sou_fifo_destroy'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:283: warning: Function parameter or member 'state' not described in 'vmw_sou_crtc_atomic_enable'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:293: warning: Function parameter or member 'state' not described in 'vmw_sou_crtc_atomic_disable'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-30-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index b0db059b8cfbe..6feb61a1a3041 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -84,7 +84,7 @@ struct vmw_kms_sou_define_gmrfb {
 	SVGAFifoCmdDefineGMRFB body;
 };
 
-/**
+/*
  * Display unit using screen objects.
  */
 struct vmw_screen_object_unit {
@@ -112,7 +112,7 @@ static void vmw_sou_crtc_destroy(struct drm_crtc *crtc)
 	vmw_sou_destroy(vmw_crtc_to_sou(crtc));
 }
 
-/**
+/*
  * Send the fifo command to create a screen.
  */
 static int vmw_sou_fifo_create(struct vmw_private *dev_priv,
@@ -160,7 +160,7 @@ static int vmw_sou_fifo_create(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Send the fifo command to destroy a screen.
  */
 static int vmw_sou_fifo_destroy(struct vmw_private *dev_priv,
@@ -263,7 +263,7 @@ static void vmw_sou_crtc_mode_set_nofb(struct drm_crtc *crtc)
 /**
  * vmw_sou_crtc_helper_prepare - Noop
  *
- * @crtc: CRTC associated with the new screen
+ * @crtc:  CRTC associated with the new screen
  *
  * Prepares the CRTC for a mode set, but we don't need to do anything here.
  */
@@ -275,6 +275,7 @@ static void vmw_sou_crtc_helper_prepare(struct drm_crtc *crtc)
  * vmw_sou_crtc_atomic_enable - Noop
  *
  * @crtc: CRTC associated with the new screen
+ * @state: Unused
  *
  * This is called after a mode set has been completed.
  */
@@ -287,6 +288,7 @@ static void vmw_sou_crtc_atomic_enable(struct drm_crtc *crtc,
  * vmw_sou_crtc_atomic_disable - Turns off CRTC
  *
  * @crtc: CRTC to be turned off
+ * @state: Unused
  */
 static void vmw_sou_crtc_atomic_disable(struct drm_crtc *crtc,
 					struct drm_atomic_state *state)
-- 
2.27.0

