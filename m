Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03921431260
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhJRIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhJRIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:47:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50240C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:44:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t184so2410029pgd.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLFGJuZJgWUVY4U6mJha8zCwNlw6HMzJ37ClSGBJiJ8=;
        b=S4aMvMzv4qhuo1RIfEwCgmVhgUT9qctduLgNd9z4RhiOANIRwFRKxr4KztDcd3CXLI
         zo4qSexhkzrDOUeWH/POgw6cZRfoZTqFwhZpPdG9Robo24DKJmz+WtR47yF+Yj27Z7FM
         ZiEAE3zUxW0w5GmF+sDhBU/YRB6aBQFOGzqKtBP2i9MY6nG6RIb/f4IzdPlnu4yUS+/p
         wqWLDLYidd209qo+aQfJ6J0AZDhQqdvTrXavn2LaZz1BRacTr/akIpOJ/Mm8WkG4vmXU
         a3ascL6Qd6apr5WjFgitmhOys+Bo79AMUBGxo2muCKXMREzJew+PRUDlZxi+LLu3s22l
         yMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLFGJuZJgWUVY4U6mJha8zCwNlw6HMzJ37ClSGBJiJ8=;
        b=WgwoN5UesMEytso/S/hPwti7aQ6+owt9VQIIPmzsmYJgbWpIOWpsrduk7052WKS6P6
         ZOR7NE6TSQN+G9t/DYtmRkJpvZ81IOBS2iwHKTyiOt7o+JZF5h/9PQLMIhYgExJMbgyR
         +NBPHlTZX1ifscG+m6SFySRJ721pjOfp0bYFbHaGipbyDcYu0adhgTF0UootTHNQwwvj
         OL/wX8VoOKLSqizMG4ms8AY9wKWVAGa8ChMqBeA3seLr0+W11xipEBB+KS+FQo6Ox2Pi
         QUq/zkydrGYGlwXtDohU15M7crlvWwSAogKi3Qm0JBhvCeHHx377AlXp0YPHcKboNSEL
         mPcA==
X-Gm-Message-State: AOAM531j2M8cAF4Aa52SIGY3u8/l5VI4kI12TApgWfvrIYODSmvZxMK8
        w8mbGTm1lqeyPpUxniik4sStmT2SCjU=
X-Google-Smtp-Source: ABdhPJyCH5ebeJ2zcvsojuYOfS6an39MajJegEfGG+qCyWV8nPF5MI+1ywJFCEFrBeo7Qe/ksxqLJw==
X-Received: by 2002:a05:6a00:1148:b0:44d:2798:b08a with SMTP id b8-20020a056a00114800b0044d2798b08amr28522249pfm.2.1634546694934;
        Mon, 18 Oct 2021 01:44:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j6sm11961541pgq.0.2021.10.18.01.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:44:54 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915/display: Remove unused variable in the for loop.
Date:   Mon, 18 Oct 2021 08:44:49 +0000
Message-Id: <20211018084449.852251-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable is not used in the loop, and its assignment is redundant too.
So it should be deleted.

The clang_analyzer complains as follows:

drivers/gpu/drm/i915/display/intel_fb.c:1018:3 warning:

Value stored to 'cpp' is never read.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/i915/display/intel_fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index fa1f375..b9b6a7a 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -998,7 +998,7 @@ int intel_fill_fb_info(struct drm_i915_private *i915, struct intel_framebuffer *
 	for (i = 0; i < num_planes; i++) {
 		struct fb_plane_view_dims view_dims;
 		unsigned int width, height;
-		unsigned int cpp, size;
+		unsigned int size;
 		u32 offset;
 		int x, y;
 		int ret;
@@ -1015,7 +1015,7 @@ int intel_fill_fb_info(struct drm_i915_private *i915, struct intel_framebuffer *
 				return -EINVAL;
 		}
 
-		cpp = fb->base.format->cpp[i];
+		fb->base.format->cpp[i];
 		intel_fb_plane_dims(fb, i, &width, &height);
 
 		ret = convert_plane_offset_to_xy(fb, i, width, &x, &y);
-- 
2.15.2


