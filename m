Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4641934467A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhCVOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhCVOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:02:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76EEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:02:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l1so6634451plg.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6erX6ToHXLRuZfuXfXRbYjKdzeAdL/fkelwcvkPciOs=;
        b=CpmkjiZEiTD1VuoxjCroqku+wWlTOrF5gVuSRuXjI3s7XifZGkvo+mkz0kM0Hw2QPk
         +cQ4w8GVvECsKG+JVNHIrA6ig0isWKdJgP624UityAsTaWaQShGarPTA0b3lcWj40igP
         R/PpJtThw32XvhUtfMrq7XfNZPyGiyKX/GT/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6erX6ToHXLRuZfuXfXRbYjKdzeAdL/fkelwcvkPciOs=;
        b=jYnveuaoHi0Np4Xv1TQdhWztZ3G+VJe6ly8g+GUrZQDyIO4czIUS99/p+J0zqfUNCE
         F9gPE4EYorXsMIt35DZ75QDfE/1MYppE7YAqM6s6lCyuUje01zRgOkaMMrASnFGcaFsL
         vBDsAyV3coKFFs96SIJq9Ol2xpgyoCe5sHkLjpGZCRfMoRou9GjRKQEU+K63H5F9Coih
         yU+Z3tzsS83QsDtjiZHktHe3i4mCk+gcXoOjy9F53xGsb3skwfmfGrTu0v4HCnCiGBdO
         TVG0sW19b48aHBuxWWu3tm5ZJnbOPqVOs3ifs1LG2XKr0iQ9KfTaf/QSkbLDwtxDxIen
         za4Q==
X-Gm-Message-State: AOAM533XbkCJ0O+G2zSfAnLtU0wZ1Nbn+/aXmQagLA3bCauu0UUC5/SW
        QHUZVj68o1L3A5dbzY6u7hBylg==
X-Google-Smtp-Source: ABdhPJxBV7Me2fZ6O6rz7h41k6pjvrEDk+k3i0598TfX3KSj/y+ettrlscSBCT9r/k0oD1MywbpxYw==
X-Received: by 2002:a17:90a:d907:: with SMTP id c7mr13221009pjv.45.1616421735136;
        Mon, 22 Mar 2021 07:02:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:15c1:9a30:414f:d84b])
        by smtp.gmail.com with ESMTPSA id gg22sm14112997pjb.20.2021.03.22.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:02:14 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 0/4] drm: sun4i: dsi: Convert drm bridge
Date:   Mon, 22 Mar 2021 19:31:48 +0530
Message-Id: <20210322140152.101709-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series convert Allwinner DSI controller to full functional 
drm bridge driver for supporting slave panel, bridges.

Here, are the previous version changes[1].

Patch 1: use drm_of_find_panel_or_bridge API

Patch 2: Adding DRM Bridge support

Patch 3: Convert to bridge driver, that indeed drop
	 encoder API's and support bridge API's

Patch 4: Overlay patch for bridge enablement in BPI-M2M

Note: Only nit on this series is kms hotplug, added Samuel Holland
for reviews and comments as he is authorized the code before.

[1] https://lkml.org/lkml/2021/2/14/173

Any inputs on this would be appreciated!
Jagan.

Jagan Teki (4):
  drm: sun4i: dsi: Use drm_of_find_panel_or_bridge
  drm: sun4i: dsi: Add bridge support
  drm: sun4i: dsi: Convert to bridge driver
  [DO NOT MERGE] ARM: dts: sun8i: bananapi-m2m: Enable S070WV20-CT16 panel

 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts |  85 ++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c       | 100 +++++++++++++------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h       |   8 +-
 3 files changed, 160 insertions(+), 33 deletions(-)

-- 
2.25.1

