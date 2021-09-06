Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718BA402090
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhIFTxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbhIFTxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:53:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8FCC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:52:06 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id u4so913534qvb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=/HWCAki5G+lVbiHxWhcyDiqEfC+VEd9DkU7YY2YmJIE=;
        b=mEMfKCujdhFTd1UNMLYapbDASirmCMlcWBmAG+ICS1uHk9R14HJqkGrlQUPsRRI25u
         P0Zdf7eVspSFnAUulxZHC+nvRVxMvW//gGUBb8CUDuNmC2IFXxxn4vvlJ4V7z+doCXGg
         vlSfvWDj58XD4pjDO+DUegyIt4r6BzyrwM+K4+zeQYwEZCIqNuVJ4NuAX8dsujwTTabb
         kBNFqmzIhkNJK4n5NBMhrYpZovE4ssULYobKDasABMNlf/QYd3Eg3jurWNGYB55wd8H3
         yhAgSIZarxCVlXOwMuS9r5YRoNF8jqkbXRTKaQ3kQa+ZKGBUEnuYQ1rCcS/LoRLe7gxB
         Xfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=/HWCAki5G+lVbiHxWhcyDiqEfC+VEd9DkU7YY2YmJIE=;
        b=QzryeecHwwpNtEyCZ+7JbY93pG4cUZG8y1kmvz/fYWbHehgYho8rdrMaJAaXlyDhhJ
         Y/w5OXbx8J9mPhI/xPhsrA0SFoosYWMRmhq88DHzYhDAbVJZff86ZXLTFFyZI+hrN+la
         ZuD1LR6tiz310AqASPNytPSrYIBxVZTgOrI4TrC3YyBthquHJWJJUIMt/a9QBYb+V75t
         5qXMeIfSrOqSlsfuoIKxxyhPP9GBf6ugitZzbx3g9WFdDSU3ft6L8VL/CzGwaN7WbssQ
         ins1Z3P2F8d2HlnyQvavDk1w22oXTHvQrA2edjnn7+poGGD8u30jJi2pBH5jIy6VSeps
         XANA==
X-Gm-Message-State: AOAM533kU3+VNDn9zOoX2C+stGfeqpAxyJ2xWPk3OeCqdD1lWlkdLvxr
        tUhMfWAVwrc9BzcKd8DEJhwLuQ==
X-Google-Smtp-Source: ABdhPJxkMdyPqihtMbecIkVh3QvlQZ6CM5K9jNcXKt6Os+i9+qJJSTCujwN5BKXl3Q+du82VzB6IjA==
X-Received: by 2002:a0c:b293:: with SMTP id r19mr6066662qve.19.1630957925669;
        Mon, 06 Sep 2021 12:52:05 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m5sm7280699qkn.33.2021.09.06.12.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:52:04 -0700 (PDT)
Subject: [PATCH RESEND] drm/rockchip: cdn-dp-core: Fix cdn_dp_resume unused warning
Date:   Mon,  6 Sep 2021 12:49:18 -0700
Message-Id: <20210906194917.376116-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hjc@rock-chips.com, heiko@sntech.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

cdn_dp_resume is only used under PM_SLEEP, and now that it's static an
unused function warning is triggered undner !PM_SLEEP.  This
conditionally enables the function to avoid the warning.

Fixes: 7c49abb4c2f8 ("drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static")
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
I sent this one out in January, but it looks like it got lost in the shuffle.
I'm getting this on a RISC-V allmodconfig now.
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 8ab3247dbc4a..bee0f2d2a9be 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1123,6 +1123,7 @@ static int cdn_dp_suspend(struct device *dev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int cdn_dp_resume(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
@@ -1135,6 +1136,7 @@ static int cdn_dp_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static int cdn_dp_probe(struct platform_device *pdev)
 {
-- 
2.33.0.153.gba50c8fa24-goog

