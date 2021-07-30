Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A063DBC88
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhG3Pqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhG3Pqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:46:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D639C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:46:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso14822172pjf.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Al3zU95t+cRa9Xq+Cnwa4MjCtmJk0IfPGeKxkOfMrWw=;
        b=iFotTX5SQKrJqgrwj8NQQHxLjvjibMx5KyTlOaO0pgcCGYtt1T3OHLphg/L7EF/w8/
         a5lv3WFBO3h40xIp8c5aKfET9wRqDcQ3rInjlocgz5wIxr84A5R7ZP0kB3Q1NN+6H34C
         6Dn3YqoEzPjI8Y0c40v/veZ+zWDZI8gPKoUHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Al3zU95t+cRa9Xq+Cnwa4MjCtmJk0IfPGeKxkOfMrWw=;
        b=WI9Fo1VMONxTIfhYyfydfruQLLpAR1Y+cg3zXxNaBOfBjJX37IRzekYr2zaO/ZhdYj
         jukEeEgu8cTh5/1lK6ceoGVm+WYrNVx7Lrim+BgC9bq/Faxx5yA83tYoWXdDTWbBgQY4
         5u5R8QAoH1LWoT8dHP0kdhFWyZsoOSp7KSsXY2ds7PA+rbrcvC6A7vx/AFysmABZ4vNA
         56SrMKVL2NrVUakJmgspiRLZ43eCpLIibaSXE3iv9Gjx6mvd1qSJZCNIED3JiqacZzsq
         hOCBB2eFH8ip8BKOu0+FHGfVj7W6SQo+2aAs55ghZ/t85lCP0rYvEIcqAAZpqykKFkWo
         zoMg==
X-Gm-Message-State: AOAM530OQJEe4fGjQXxwA+rFxcUzKuuL6nep3gqCC2/ifivWVACroJMO
        oVULKPiC1g5hfM+AB9YyZRfetw==
X-Google-Smtp-Source: ABdhPJwfuNDfy7TwpDboUrkCy7S3fyCYpsKNYqiJcOmuCzyAD6S7KqF81wmUUp2kSa64MFFimzZKlA==
X-Received: by 2002:a17:90a:5b18:: with SMTP id o24mr3870789pji.230.1627659997829;
        Fri, 30 Jul 2021 08:46:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3424:e0ac:5a92:d061])
        by smtp.gmail.com with ESMTPSA id u188sm3175621pfc.115.2021.07.30.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:46:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, steev@kali.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, bjorn.andersson@linaro.org,
        daniel@ffwll.ch, airlied@linux.ie, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, rodrigo.vivi@intel.com,
        sam@ravnborg.org, jonas@kwiboo.se, mripard@kernel.org,
        thierry.reding@gmail.com, lyude@redhat.com,
        linus.walleij@linaro.org, rajeevny@codeaurora.org,
        linux-arm-msm@vger.kernel.org, a.hajda@samsung.com,
        tzimmermann@suse.de, narmstrong@baylibre.com,
        Douglas Anderson <dianders@chromium.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] drm/panel: atna33xc20: Fix the Samsung ATNA33XC20 panel
Date:   Fri, 30 Jul 2021 08:45:59 -0700
Message-Id: <20210730154605.2843418-1-dianders@chromium.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
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
making eDP panels probable [1]. I'll re-post that one atop this
one. It should be noted that the fact that the Samsung ATNA33XC20
needs its own panel driver means that it _can't_ handled as a probed
driver. I think this is fine, at least for now. I don't think it would
be easy to make a unified design with this panel and other panels
given that it's an AMOLED panel and has a whole bunch of different
components on board.

As discussed in IRC, the only difference in v2 is the addition of a
"Fixes" tag to patch #3 and the collection of Reviews/Acks from Sean
and Robert.

If people feel that this is ready to land today then I can help land
it (please let me know). Otherwise I'm happy for someone else to
actually do the commit next week (I'm on vacation) or I can take it
when I get back.

[1] https://lore.kernel.org/r/20210723002146.1962910-1-dianders@chromium.org/

Changes in v2:
- Added Fixes tag as requested by Sam.

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
2.32.0.554.ge1b32706d8-goog

