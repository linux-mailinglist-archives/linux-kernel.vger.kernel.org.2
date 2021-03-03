Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F632BE8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385773AbhCCRcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhCCNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:49:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83864C061BC3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so23756701wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z4Bk/fTuFhVwU/7FdAPiJXssZfF9MOQHB9tTd64Ps9M=;
        b=bEmdaWNLhP8BgCpTYOqqi5FrXxWCwm/ouH5jo0mOjUndvlW/t72D+sET79M7hYkuf8
         auszFOXzFkigj84a5CFL2GUvyYd4efIIAisNzb14GY7wbqPqL2SK4lBJLsKdiY1amcQn
         fM5Yp/MDNth96VhuiwO5pLQkBf9NsVQGRgydLWC6VMfF6Enyp5ZqM0Y2vLbJCcRVmlQf
         HmZmErIQDtfdd7a82n2ydHDC1PVXW4TEmBLhgG62/DcUF/O4a+4BioT/G0PTdrOHDiVC
         JjlAtgKdxW7t23lkmFYNl5ud93kWxJkYti8+8cQ0ymG1H8gy/QiU9GMiM6f0rgUCohym
         d9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4Bk/fTuFhVwU/7FdAPiJXssZfF9MOQHB9tTd64Ps9M=;
        b=cNMtQMgRFZ8YlDwR9GqvqonvBQ18fwdFO+8dkoUU3dxtcU3pfE2NCKL8zTgYp2rIYx
         l1xrWpM8zERbSN2wuAHFDtfAVnccE/AQHekJBKa+6t9B/jUyH6ChdtUqfa1YhADHbHqh
         Bvl0Du0yktEeI51c0qzL4R1FWND9g+8o5w7mKENKm61eIo91PbrCYF1BtbD3rQmleJtG
         FdOU9ZdhVNIuQCmQkamLbNGRw6XlA/WOzQ0FJ1KzT7ixIn9adHog/Qqz0TEB+au5VowN
         qZ0wM9SZ5NPYjMdQ5eFPeUQ8bQf0cZWKYiVtqs7kyq53a2Y9Z6EmPI6TGd3CdEiFfUGl
         N3AQ==
X-Gm-Message-State: AOAM531XILralOKGSKccUoQjPUT5Vx1UP9WW9QI4BEzmEMvkfEdWFoT/
        BD1AW4BX6L63Aul+fdBt+jgbrHbx3oAKcg==
X-Google-Smtp-Source: ABdhPJzTgP1Y2LWJIejPOIa/WtOvSSVoKtlodrpESY6uinkDbzJWvahfvKjsPKrr5LM2TTQGVF1ibg==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr27871005wrs.72.1614779048260;
        Wed, 03 Mar 2021 05:44:08 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 33/53] drm/vmwgfx/vmwgfx_overlay: Demote kernel-doc abuses to standard comment blocks
Date:   Wed,  3 Mar 2021 13:42:59 +0000
Message-Id: <20210303134319.3160762-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:48: warning: cannot understand function prototype: 'struct vmw_overlay '
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:98: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_send_put'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:98: warning: Function parameter or member 'buf' not described in 'vmw_overlay_send_put'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:98: warning: Function parameter or member 'arg' not described in 'vmw_overlay_send_put'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:98: warning: Function parameter or member 'interruptible' not described in 'vmw_overlay_send_put'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:186: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_send_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:186: warning: Function parameter or member 'stream_id' not described in 'vmw_overlay_send_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:186: warning: Function parameter or member 'interruptible' not described in 'vmw_overlay_send_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:228: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_move_buffer'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:228: warning: Function parameter or member 'buf' not described in 'vmw_overlay_move_buffer'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:228: warning: Function parameter or member 'pin' not described in 'vmw_overlay_move_buffer'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:228: warning: Function parameter or member 'inter' not described in 'vmw_overlay_move_buffer'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:253: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:253: warning: Function parameter or member 'stream_id' not described in 'vmw_overlay_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:253: warning: Function parameter or member 'pause' not described in 'vmw_overlay_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:253: warning: Function parameter or member 'interruptible' not described in 'vmw_overlay_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:301: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_update_stream'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:301: warning: Function parameter or member 'buf' not described in 'vmw_overlay_update_stream'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:301: warning: Function parameter or member 'arg' not described in 'vmw_overlay_update_stream'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:301: warning: Function parameter or member 'interruptible' not described in 'vmw_overlay_update_stream'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:364: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_resume_all'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:398: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_pause_all'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-24-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index d6d282c13b7f7..ac4a9b7222795 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -42,7 +42,7 @@ struct vmw_stream {
 	struct drm_vmw_control_stream_arg saved;
 };
 
-/**
+/*
  * Overlay control
  */
 struct vmw_overlay {
@@ -85,7 +85,7 @@ static inline void fill_flush(struct vmw_escape_video_flush *cmd,
 	cmd->flush.streamId = stream_id;
 }
 
-/**
+/*
  * Send put command to hw.
  *
  * Returns
@@ -174,7 +174,7 @@ static int vmw_overlay_send_put(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Send stop command to hw.
  *
  * Returns
@@ -216,7 +216,7 @@ static int vmw_overlay_send_stop(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Move a buffer to vram or gmr if @pin is set, else unpin the buffer.
  *
  * With the introduction of screen objects buffers could now be
@@ -235,7 +235,7 @@ static int vmw_overlay_move_buffer(struct vmw_private *dev_priv,
 	return vmw_bo_pin_in_vram_or_gmr(dev_priv, buf, inter);
 }
 
-/**
+/*
  * Stop or pause a stream.
  *
  * If the stream is paused the no evict flag is removed from the buffer
@@ -285,7 +285,7 @@ static int vmw_overlay_stop(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Update a stream and send any put or stop fifo commands needed.
  *
  * The caller must hold the overlay lock.
@@ -353,7 +353,7 @@ static int vmw_overlay_update_stream(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Try to resume all paused streams.
  *
  * Used by the kms code after moving a new scanout buffer to vram.
@@ -387,7 +387,7 @@ int vmw_overlay_resume_all(struct vmw_private *dev_priv)
 	return 0;
 }
 
-/**
+/*
  * Pauses all active streams.
  *
  * Used by the kms code when moving a new scanout buffer to vram.
-- 
2.27.0

