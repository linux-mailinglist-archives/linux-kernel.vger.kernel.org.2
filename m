Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD5438DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhJYDqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJYDqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:46:46 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD907C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 20:44:24 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g20so10670768qka.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 20:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x16gXWpzNHpOLXxSWON9xi6tEmmvUPoYcp94QB3jkPM=;
        b=bx8eThpUK8zmEWsN8nmUkMwDmOLKZVuVKQYqVlA9Ggp2Fl07+Pctr43l+aUybocKZB
         o18h4wMUGsSmCPk+wx28pp0ynssm2H5o7Yz/GRpbbIgML9kQ1sb3fg4r0SGYhInsnmWn
         g4uNahRCtssYPnaUK6mWhgQ5I0A1Xq5jAWx4ljltjDyAhdG1Z8MmthWaPffXgeD260ih
         60UGKSFJp9REP8oPCIZ7BZRnPL9EFjwvZgKyq6+OXGHPUzA246shmRsv2TtTk7lILyB9
         rL6qjJCU6Bm+kNXGT+ytEIwrZDMXpeb6rJbpNs66GeUotSymvCKcvvjnXHXLbFIYokoH
         h0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=x16gXWpzNHpOLXxSWON9xi6tEmmvUPoYcp94QB3jkPM=;
        b=QxFC9DFwcLtiRchQMO1YivVIJNMxBF20AL2MB3I8Wh1UQnp07khcYTQZVmF4qxksGl
         1MYo0ATEXuHGinCO6cidkOlfUJxc5PQ0+HH2xXA5q/vX/agdAmWKvTobml/RBId0bLAw
         C6Sm5xam/88Iy8PIq5j9fDAsqgzCfZ8FRLyY3F0DgLQLc+cLhzL99QD1t+R8AN3vZh1f
         ZvlscBs01wqGBkibJg49wacJ/5D4V3ReoAkEMReRI7fzLSSFqiLfyuer6NhPNos7tlV5
         9QeX01oFECa6BGziHYornfXFx+N6NRE9PUKtDrVreI0MVvagJvIf3oetB4IdXlCuWMr/
         xYTQ==
X-Gm-Message-State: AOAM532gaaWhXA0V2UMm/dyKBbkjYAFQozdvWF+c3NovWY9/9v8Lpqvg
        nqdzla4wJx21PSpIS/IkWnM=
X-Google-Smtp-Source: ABdhPJz0LfMxCfvl7U0olYslDsDxnM3i+4BngW+nFvaHXxGffDk/Jb7B8cW/QyxzH7NwguFCkMTQiQ==
X-Received: by 2002:a37:6856:: with SMTP id d83mr11723484qkc.8.1635133463866;
        Sun, 24 Oct 2021 20:44:23 -0700 (PDT)
Received: from ubuntu-mate-laptop.. ([2607:fb90:1bd1:606f:7cf3:da67:cb9f:91b7])
        by smtp.gmail.com with ESMTPSA id s3sm7999991qkj.118.2021.10.24.20.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 20:44:23 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     robert.foss@linaro.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     jagan@amarulasolutions.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: fix unmet dependency on DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Date:   Sun, 24 Oct 2021 23:44:20 -0400
Message-Id: <20211025034420.28996-1-julianbraha@gmail.com>
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

