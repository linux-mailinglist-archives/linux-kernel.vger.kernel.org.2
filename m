Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2EF3C334A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 08:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhGJGsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 02:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhGJGsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 02:48:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9352C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 23:45:19 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i13-20020aa78b4d0000b02902ea019ef670so7905146pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9CMx4bIcdXWpRX9qOXiz6bFTgQH2pecsmU1gY1OoGwk=;
        b=hb7tV/VnMR0zjITwjQo9kcBwJbMt5Xl4lPxJMBHWl+wXBD04ICzAZUfbTjBughG6ND
         cFWB0fGyo7hVciVd70kfkWVrVzBg9ISCUvwCFufzl8YJCJZHhEMLddxgCRnGgMUbbuA5
         tP0h2rpj6iv9/g9ujZUEilyHtep2i9qkXIQvhUo5JMDN6wOoi4Lw/CW9AVky1ujx5LRi
         2zTp+WXvoVbMn+3hAdAAQaEgJQ61qk5A2gEJYwcqcbIJUhGh+7klHPKdghy8pCywhQvG
         bvv+A5bO7VufxD+sOryC7BQeFY1kC9mtpoTjXICTr4Xg2eo9u9k2DaiV7ACTXxWl0CBB
         CXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9CMx4bIcdXWpRX9qOXiz6bFTgQH2pecsmU1gY1OoGwk=;
        b=IcR1xpOLSqTY855AP8rWXGUhakrmWdYLzx3E8tUfxDW5y1JwiBuCvbPVQTCXoZ+9Jy
         MJy/+jqY5d9LQhlhGWgS1f775gsrQdxUvFvmJaXifkEuG3iL1H7xW1wP4AHMTfQgiOb7
         0TNQnpi5YxNpVV4AS0Z9lEV5ZmmEg37rvJha2KitaEaK92wFTLvSoEZ3JoSdGuk5LMpb
         zbSJbiUhCE7GFnqU6yNKGfa0w8JlUwq71MtcROHbLPbbvRxFlIBzmQsWHStXoC0VH1vI
         MVUca5OXs3OHczVgqgjZgSp7leb/8hEdBPu0M9+ghtmzvZEaLptdPf10GCUN0F/6p8eH
         uuwA==
X-Gm-Message-State: AOAM533Gm0tIcjCf0FAUE57BS8i9CCIxdR46PQ0+VnaIWhCmEiH6TwKg
        fSP+vRisfcektgtNDsC7Vz9yd0Ea8NII9b9Qqy8=
X-Google-Smtp-Source: ABdhPJwuWRRzdqbJqHwcxv8Nn5JDV30GafdKLv2JCFLlKFuEUJC6nTof1vswMR5ky+KhimYrkbRgjqbTf5svF5v+s3I=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:903:3091:b029:12a:ed47:93c3 with
 SMTP id u17-20020a1709033091b029012aed4793c3mr1859770plc.34.1625899519125;
 Fri, 09 Jul 2021 23:45:19 -0700 (PDT)
Date:   Sat, 10 Jul 2021 06:45:11 +0000
Message-Id: <20210710064511.1288232-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] drm/mipi: set fwnode when a mipi_dsi_device registers itself
From:   Will McVicker <willmcvicker@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed for fw_devlink to work properly with MIPI DSI devices.
Without setting the device's fwnode, the sync state framework isn't able
to properly track device links between the MIPI DSI device and its
suppliers which may result in its supplier probing before the mipi
device.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 5dd475e82995..469d56cf2a50 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -222,6 +222,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 	}
 
 	dsi->dev.of_node = info->node;
+	dsi->dev.fwnode = of_fwnode_handle(info->node);
 	dsi->channel = info->channel;
 	strlcpy(dsi->name, info->type, sizeof(dsi->name));
 
-- 
2.32.0.93.g670b81a890-goog

