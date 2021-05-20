Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824CC389E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhETGrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETGrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:47:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A28C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:45:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso4119635pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRcdw8c/Pj8wxn1zjwxzT7G0xYC0ST2l17AHlwIRLXQ=;
        b=aZFPncyh96kPYQqIYVFxmkFbmpjVmRY5jv1B1Wc+BW4z3jAgdICY4BgX3D+j0DzFDn
         KBkFeMhiPU/jDR8+vTVWWj6M/aWMVxDfs5qLjaxXa0km0FhU3S2kPb5EDgv6pFeS4HfS
         XTPGkuF+gU/hf2GUlRUWSTW3xTI8rOtQb5MHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRcdw8c/Pj8wxn1zjwxzT7G0xYC0ST2l17AHlwIRLXQ=;
        b=U8KWR6R9oAJxjI6i97Qj+9JQQONhhuuq6rYujmVIOfWzwpVbcaO+cTY1SaBUYef9P7
         NkgJVNOfv5fXqqqBQdkrJ9f5VfYz3jVujCvOzBUcOqlQAHTyt816jlxB69ydhYuE1vm5
         T+8d2g3mDZeXP8zyzewfBgcv/jF70kHxVZnDndlzfQKvd2dywQrw8yC813xgyNlQwRmk
         5f5skNbhtTUAZf9gH/Ka1fG6t579hUrjn+2+9JR7/r8Dr+16LhsitppLs1Merdctdt9A
         CQNKpraoq6fW5nLB8PcYB7Pp8kJzoOtKSwpJcpEkFUPMZMld0D0pPpemVt6YQUj7vvVV
         M+1w==
X-Gm-Message-State: AOAM532B7CdI+DVkWmZmAKRvJS+ellh4JTR7yPObbolrPs1WJJp7wNC3
        nuG/MLIfSMUYnrsCopyGauBT4w==
X-Google-Smtp-Source: ABdhPJwXumfYk25jLMt5I1JnCLtagaL42xzRZT3YgY2ItnIC+jgV2nP8qLk5B3WTGJ689/jINcgaew==
X-Received: by 2002:a17:90b:3905:: with SMTP id ob5mr3600257pjb.94.1621493145414;
        Wed, 19 May 2021 23:45:45 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id b124sm1100086pfa.27.2021.05.19.23.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:45:44 -0700 (PDT)
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
Subject: [PATCH] drm/bridge: anx7625: Synchronously run runtime suspend.
Date:   Thu, 20 May 2021 14:44:52 +0800
Message-Id: <20210520064508.3121211-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally when using pm_runtime_put, there's a chance that the runtime
suspend hook will be run after the following anx7625_bridge_mode_set
call, resulting in the display_timing_valid field to be cleared, and the
following power on fail.

Change all pm_runtime_put to pm_runtime_put_sync, so all power off
operations are guaranteed to be done after the call returns.

Fixes: 60487584a79a ("drm/bridge: anx7625: refactor power control to use runtime PM framework")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 29493cc2d300..7519b7a0f29d 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1255,7 +1255,7 @@ static struct edid *anx7625_get_edid(struct anx7625_data *ctx)
 
 	pm_runtime_get_sync(dev);
 	edid_num = sp_tx_edid_read(ctx, p_edid->edid_raw_data);
-	pm_runtime_put(dev);
+	pm_runtime_put_sync(dev);
 
 	if (edid_num < 1) {
 		DRM_DEV_ERROR(dev, "Fail to read EDID: %d\n", edid_num);
@@ -1573,7 +1573,7 @@ static void anx7625_bridge_disable(struct drm_bridge *bridge)
 
 	anx7625_dp_stop(ctx);
 
-	pm_runtime_put(dev);
+	pm_runtime_put_sync(dev);
 }
 
 static enum drm_connector_status

base-commit: 7a42b92b6d30c3f09629c7d5ada9e3de2aba01af
-- 
2.31.1.751.gd2f1c929bd-goog

