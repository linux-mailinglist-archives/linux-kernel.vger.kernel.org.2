Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26870439DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhJYRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhJYRob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:44:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13CAC061224
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:42:08 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h20so12391319qko.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X9zUblVIGuZd4IjMbSrFBsAjSqw6zhs1OIqj/eH6y0g=;
        b=dhzO+fgnJ3U+lS/5F/TkufBFbMB0FNv9RJNCypmqJeBdqIvAj71pWD2NOfYrm2raA+
         Gz9sHdjGm2gbUyrghphWehHsFnCPBtO6T9pVNjdQSUCyFAmXo8C3q3oGIkmxya074LmW
         TlFgNZF+u6HWvpfWXC/CyLuVW2E9zBF/LQH6/EulYw0xE0hGLB2G2+L5qnzUUVo+OSTW
         KqdL/e4Zr/FS54+IBlJsSt/8phFMwL6kcbkRQh9cplG6LIR2aVK2fA1oVATMLa4ubnex
         paHwS5WXDqXF08tonhgFBfATSqQZsS+YnFccAJ8MBRZF6Iw71aePvl9Td/MigGEoJmT3
         LRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=X9zUblVIGuZd4IjMbSrFBsAjSqw6zhs1OIqj/eH6y0g=;
        b=5ZKSDzciryhLiWViGdwTo+o9sQnSUzgEUaHh9598ccERKAJSfKOce7HzYRG/KNSk1M
         WhOXmMzDnrlCSorq/dGaKoizZhFS/QOcQ92cM0T4SGjWi9s99I3i5mq2u7xPZM6nbzh3
         x8HTqVYJ80p0FP3UfXwWoZj8dHRNeWjGeO7Odr6YfNLSiSWmN2Z8BfkfB+SZx7lT8IvB
         wu2PoACfueVhz0S4t92tguH5czKuGICMQB6bWlPE9VKdsjL/5WLx2n/yWjJDdlBMFBju
         ZBpTgLBxBZml4tThYK5qBa+z/vb/NCTiZtnRHgtB/Mfr7JQ6YUaCVnl83EkPT6ajA7E6
         WVJg==
X-Gm-Message-State: AOAM530Mtco5RkKmTxF4aOyliX/LBcEBG+9qOE79odoaEDo1oqsgxzLI
        x4sDIAbvrc5bB9AQUXi/XmA=
X-Google-Smtp-Source: ABdhPJyM2kiThlmSeP8Np46MA9t73+LW7QdDF8frc+w+QIhaegc9ynRNr+0HDKlD7vGk7em/wPsvEQ==
X-Received: by 2002:a05:620a:4153:: with SMTP id k19mr14333359qko.246.1635183727839;
        Mon, 25 Oct 2021 10:42:07 -0700 (PDT)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id v21sm502280qtk.46.2021.10.25.10.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:42:07 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     robert.foss@linaro.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     jagan@amarulasolutions.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: fix unmet dependency on DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Date:   Mon, 25 Oct 2021 13:42:02 -0400
Message-Id: <20211025174202.32396-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DRM_CHIPONE_ICN6211 is selected, and DRM_KMS_HELPER is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
  Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
  Selected by [y]:
  - DRM_CHIPONE_ICN6211 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]

This is because DRM_CHIPONE_ICN6211 selects DRM_PANEL_BRIDGE
without depending on or selecting DRM_KMS_HELPER,
despite DRM_PANEL_BRIDGE depending on DRM_KMS_HELPER.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig.
Please advise if this is not the appropriate solution.

Fixes: ce517f18944e ("drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge")
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 431b6e12a81f..a630cb8fd1c8 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -30,6 +30,7 @@ config DRM_CDNS_DSI
 config DRM_CHIPONE_ICN6211
 	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
 	depends on OF
+  select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL_BRIDGE
 	help
--
2.30.2
