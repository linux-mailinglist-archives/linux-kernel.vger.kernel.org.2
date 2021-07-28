Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4C3D936E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhG1Qq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1Qq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:46:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF2C061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso4991148pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Wf14gG5Rla0NCThAzrC4jotbBpcH9EXwPpxX3uNRjo=;
        b=EtlAYDaEc0TpuNyXhqKi50L3nKK4in1bT8Phheri8gREf7P5NrxJ2A29bcz9tTkNV4
         KMxG0EH+veKm8iIIsYG68Hmklfn+DxuQp9m7Kv3Wqy4kOtalb2dvdpSOmUM0aFyN6p9x
         8aa2qd57b8OCOv02Ru/xKrV2Y1aghXj14dmi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Wf14gG5Rla0NCThAzrC4jotbBpcH9EXwPpxX3uNRjo=;
        b=j7CKK7ySp2I/uORJwWMQ4O0qRsezm1V5SNVGChZmdJxARLT/54IAsYKuH7rCIw6rUc
         OzwEjNDlMsDWtgVGl10yZ0RtHEckuAA8X7OEaW55HYH5JwzuBBndYX4ILuMgOCSy5OjM
         LBhkXWlOtBusM/9iXspP1lQ97QRsMmT/6vHxh7xXjb5V9hp8oygApxuRLBYFCAeG8h86
         jzjmk5eL9FdrXZ/y81va4kilbJCrPjhcHxwVsSNW+HjXphboQECKAJuUzy5QWzXOojF6
         dU57tqb3YL4qF7KkWOZsFPllh/bk/GIXz8h5utCg+wBH/os2iUweEHmNiK6Tvc2PhCn6
         4a4A==
X-Gm-Message-State: AOAM5316G1iPHORuAJ0a1brzJRSb2q4SO7AOlstJJfkzoHz99B3GiOeJ
        2RUeIOZ2W8QaMEG8qS+QhbctrQ==
X-Google-Smtp-Source: ABdhPJzfO4KkJpCh98jEoXUePNoIZEGk1qRg4kKFgs4O1HX2oxNwF0DCb/etyqdvMdxChckiCrP56g==
X-Received: by 2002:a65:4382:: with SMTP id m2mr656852pgp.205.1627490784259;
        Wed, 28 Jul 2021 09:46:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:9f1e:e713:1a5e:89dc])
        by smtp.gmail.com with ESMTPSA id l12sm474075pff.182.2021.07.28.09.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:46:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, linux-arm-msm@vger.kernel.org,
        a.hajda@samsung.com, sam@ravnborg.org, airlied@linux.ie,
        bjorn.andersson@linaro.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, rodrigo.vivi@intel.com,
        jonas@kwiboo.se, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, robert.foss@linaro.org,
        jernej.skrabec@gmail.com, mripard@kernel.org,
        linus.walleij@linaro.org, maarten.lankhorst@linux.intel.com,
        rajeevny@codeaurora.org, lyude@redhat.com,
        thierry.reding@gmail.com, steev@kali.org,
        Douglas Anderson <dianders@chromium.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] drm/panel: atna33xc20: Fix the Samsung ATNA33XC20 panel
Date:   Wed, 28 Jul 2021 09:45:51 -0700
Message-Id: <20210728164557.1882787-1-dianders@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The overall goal of this series is to make the Samsung ATNA33XC20
panel work more properly. As part of this, we have:
* A bugfix for the recently abstracted DP AUX backlight code.
* A bugfix for the sequencing of the ti-sn65dsi86 bridge driver.
* Removal of the panel from panel-simple and moving it to its own
  driver.

If the bugfixes look good but the rest of the series needs work then
those could land early on their own. There's no real compile time
dependency on the bugfixes, things are just glitchier without them.

NOTE: this series will (slightly) conflict with my other recent series
making eDP panels probable [1]. The conflict is easy to resolve and
I'm happy to repost either once the other lands. It should be noted
that the fact that the Samsung ATNA33XC20 needs its own panel driver
means that it _can't_ handled as a probed driver. I think this is
fine, at least for now. I don't think it would be easy to make a
unified design with this panel and other panels given that it's an
AMOLED panel and has a whole bunch of different components on board.

[1] https://lore.kernel.org/r/20210723002146.1962910-1-dianders@chromium.org/


Douglas Anderson (6):
  drm/dp: Don't zero PWMGEN_BIT_COUNT when driver_pwm_freq_hz not
    specified
  drm/bridge: ti-sn65dsi86: Fix power off sequence
  drm/bridge: ti-sn65dsi86: Add some 100 us delays
  Revert "drm/panel-simple: Add Samsung ATNA33XC20"
  Revert "drm/panel-simple: Support for delays between GPIO & regulator"
  drm/panel: atna33xc20: Introduce the Samsung ATNA33XC20 panel

 drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  17 +-
 drivers/gpu/drm/drm_dp_helper.c               |  10 +-
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 366 ++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          |  61 ---
 6 files changed, 398 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c

-- 
2.32.0.432.gabb21c7263-goog

