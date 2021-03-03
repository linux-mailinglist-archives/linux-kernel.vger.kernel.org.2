Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB232BE7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348286AbhCCRbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445920AbhCCNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:48:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4046C061A86
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u125so6380161wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tmSWc9lSX8plC+W5s/fzd/gmEeVkpduD+/cr5gvR47U=;
        b=XG9g9GqcUfSvxhKZ3LXb18saIpgWwFds4iItiADLUMMHBM00te+esEhv7OYwz62YS2
         ZVXaG5uHxzk3+7ib+aQ1hfw+dx5mg2ohpnRw6S7Zgo51DC1RG/BJ6VkL6d8IzEwNchUG
         MLXBaQoleIiBHUZanNQJFIJD15MSH0bP+V/kKXMn0FcIuyeK/pscQ1iLvqWs6FopfsK8
         BBPkuMQYZkq+FIvdehyn+ZmXrSCtpep1o7Xk5wX1lAZKkgtmQq8o7m7VERTrLRii1Y83
         czQ5lbvifM4mqqyMn1QNeZOHJL2qfhdIpc9chnfmKHEY0lFgjeTJADscLImG+tswDopd
         IytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tmSWc9lSX8plC+W5s/fzd/gmEeVkpduD+/cr5gvR47U=;
        b=QrcSqW01hCGCBAPWBmKEx/lRr/hM0inRiaU5dIMIiS5kv10EN5FjHTBGBViYNshBS0
         ZiZi3IiHSRrVaJHu5clS65F0Jph4pr55LriRl0WjJUP8qK5MBhkTXztvB0UqkNiI3XXY
         DA+DCe/G2vv0OdClraJOJUfHr7x52okqdIbkzsL7lL9c9jEfinUhmt/PngcQpTuI3V1o
         LIm8p+wf5Vo9JJM+C0EaSpzDb0dLnaesnb4cKP3ZInenslmJi3GiRK19BWD1oYq4BAI2
         poXCD6rkTHu5iPxqE2OUR1DnSTDbmg2NZp1DSMivYbae1gZFBrOZoo/K4sPp7UHBPbnE
         gvVQ==
X-Gm-Message-State: AOAM533I0BLqwX7OkIqkvlZ9RM3TnGrHVbvZ2hbDyt520z8l0ft0we4P
        lelSwrQqLzNs1jJ+21czXQWheg==
X-Google-Smtp-Source: ABdhPJwFgTcETayyMMWtzZVDN6UJAXq0mvasuXRA0M8p4u4vBy1m9KLvRyxeigxIOdfyIIWoARHaBw==
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr9317471wmk.135.1614779045399;
        Wed, 03 Mar 2021 05:44:05 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 31/53] drm/vmwgfx/vmwgfx_ldu: Supply descriptions for 'state' function parameter
Date:   Wed,  3 Mar 2021 13:42:57 +0000
Message-Id: <20210303134319.3160762-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c:55: warning: cannot understand function prototype: 'struct vmw_legacy_display_unit '
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c:218: warning: Function parameter or member 'state' not described in 'vmw_ldu_crtc_atomic_enable'
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c:228: warning: Function parameter or member 'state' not described in 'vmw_ldu_crtc_atomic_disable'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-14-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index 9a9508edbc9ed..acae92a07f4f3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -49,7 +49,7 @@ struct vmw_legacy_display {
 	struct vmw_framebuffer *fb;
 };
 
-/**
+/*
  * Display unit using the legacy register interface.
  */
 struct vmw_legacy_display_unit {
@@ -206,6 +206,7 @@ static void vmw_ldu_crtc_mode_set_nofb(struct drm_crtc *crtc)
  * vmw_ldu_crtc_atomic_enable - Noop
  *
  * @crtc: CRTC associated with the new screen
+ * @state: Unused
  *
  * This is called after a mode set has been completed.  Here's
  * usually a good place to call vmw_ldu_add_active/vmw_ldu_del_active
@@ -221,6 +222,7 @@ static void vmw_ldu_crtc_atomic_enable(struct drm_crtc *crtc,
  * vmw_ldu_crtc_atomic_disable - Turns off CRTC
  *
  * @crtc: CRTC to be turned off
+ * @state: Unused
  */
 static void vmw_ldu_crtc_atomic_disable(struct drm_crtc *crtc,
 					struct drm_atomic_state *state)
-- 
2.27.0

