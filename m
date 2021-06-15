Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E463A7527
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhFODbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhFODbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:31:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD10C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:29:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v11so7717973ply.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ko1IwBGBst5Jf2WhqbyLBt78jSlpiQeS/6AIDQFiD8w=;
        b=ZuGe39zMIh0zTAo7XlKLZPzD8gyv2KE+kIUzjS2rlpekG/fPV7gz1czM1SUsTsL+fS
         npwq05fl62dITgBoZksqFKJxpTL9C+H+nMc+5OA470NtLeF/nSH6Nt+QlBaTrrmNROcr
         PZ8z6Zhzn2mCde9ILXCzny9Q+VW+vTxgkg/ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ko1IwBGBst5Jf2WhqbyLBt78jSlpiQeS/6AIDQFiD8w=;
        b=PbIw/lzK9nmZFlJW9ukMwwXsmrZRhOtQaeElh+B8u0temcs4QDvpxfYVwj9KSPWRux
         Be8RWvlLNrVhp8xV182N1IOZ2jbqgtybKw06j8Nw6Fu6xmnoVFZuzfOEBjCk8LRPLYRp
         jKjyKGz4TpzYZAi1on4x9pPSM3A7U1J5LiBXM2i9tDcYqCwxMS9wv4O3UMe29TMuU6Ll
         th9g1vwVPv2cD1sR1JmMr1lv5JopNyjQyHX9A32lJweD3CUg6ranx+PTPccrEo1eIJ4F
         s217TQvyGD2hjAlnTf+6mC2BJKwpDV0zPRQ3A9unrDZiYSXKfu3gm1AlSuYVYnK4lLQK
         6pFg==
X-Gm-Message-State: AOAM530UX5GM+UUZgVfWsFb0IP8yib5PiC4Rg8pgxanneVjt++NRCc+2
        LBwRfzYMX0198AsgaG7ggYG5aQ==
X-Google-Smtp-Source: ABdhPJxk9ulOgf+BkOotf4gBXMadqzHQr5KaW1jAZnlUzhyqv6EQetNNiVdjMmPmoQdgyjUSsr3s0A==
X-Received: by 2002:a17:902:a98c:b029:119:926d:f99a with SMTP id bh12-20020a170902a98cb0290119926df99amr2388315plb.5.1623727785121;
        Mon, 14 Jun 2021 20:29:45 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id o16sm13441990pjw.10.2021.06.14.20.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 20:29:44 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/bridge: anx7625: Make hpd workqueue freezable
Date:   Tue, 15 Jun 2021 11:29:24 +0800
Message-Id: <20210615032937.2328468-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were still a race condition between hpd work and suspend, since
the workqueue work can still be run after anx7625 had powered off in
suspend.

Since we never want hpd work to run while suspending, and there's no
harm to delay them to be run after resume, mark the workqueue as
WQ_FREEZABLE so all works won't run while suspending.

Fixes: 409776fa3c42 ("drm/bridge: anx7625: add suspend / resume hooks")

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 7519b7a0f29d..e165be5a2067 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1730,7 +1730,6 @@ static int __maybe_unused anx7625_suspend(struct device *dev)
 	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
 		anx7625_runtime_pm_suspend(dev);
 		disable_irq(ctx->pdata.intp_irq);
-		flush_workqueue(ctx->workqueue);
 	}
 
 	return 0;
@@ -1790,7 +1789,8 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	platform->pdata.intp_irq = client->irq;
 	if (platform->pdata.intp_irq) {
 		INIT_WORK(&platform->work, anx7625_work_func);
-		platform->workqueue = create_workqueue("anx7625_work");
+		platform->workqueue = alloc_workqueue(
+			"anx7625_work", WQ_FREEZABLE | WQ_MEM_RECLAIM, 1);
 		if (!platform->workqueue) {
 			DRM_DEV_ERROR(dev, "fail to create work queue\n");
 			ret = -ENOMEM;

base-commit: 25fe90f43fa312213b653dc1f12fd2d80f855883
-- 
2.32.0.272.g935e593368-goog

