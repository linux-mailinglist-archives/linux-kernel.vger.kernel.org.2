Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5271E353107
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhDBW33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBW32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:29:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EDEC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:29:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f29so1861273pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON9CSoAEnPg/WEZHphopZ5IRnDJ/6agQdPsBBenWtGU=;
        b=WYn26BMcz3yEwP1DJXlf666yiWCvKw3heAG5lqx4UDpK4pkPo9S8A8uq9wHkp79ptX
         HtWLWemjiurAQbKo2QNPn32UkGobrDER5QFmDVEvYQvVbg08AmPMLLOkXgmxuxa0oyn3
         bwZHckjECdG3ztZRfluFiRFUWb6OVUPx8NTUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON9CSoAEnPg/WEZHphopZ5IRnDJ/6agQdPsBBenWtGU=;
        b=sMt3E8H+4pAOSlUMOOjK4X4bAG3rhZj44RxiFq1ca+uRcgQwlJGv/gVH7bp3GsdVV8
         uLn58laQneT4+WDjTBb2uxjXPz7fuMDDE48FE5kGIK/9XcMTziiqFdcx1O/08H7R/4Fk
         oz60cqv8NlTuytvwKTghSLWs1AnL0yGU6GVEoSnbJNk1lng+CZgzb2bZYo9Jo/5HyvL8
         hKyA+Z4TfAGU/TlEQf04UyHQcCYVyEFlny+JQbl8E89qGkQkbjmdb29JPzQPEbc/Hwgt
         7kK8naYVfoXLoSSGh3OwT2n36d9SsE5hl2X7qhflv6gtBg6g/aMIMY6fES0yzuBHxUAp
         gtZw==
X-Gm-Message-State: AOAM5323TrVXXU4iTmCSZKTmvy8234C9IUsxsMtqWB8LBLPTo3cokos5
        0ps9EoeD5bQc/y4D1Pb0NXlyKA==
X-Google-Smtp-Source: ABdhPJz/MKLIo+p9Jsg9Gej8nSjFSkKcq8Dmpmm4/rKRf0nNFYk9rmNUkc054Jiiu/Oq0+lV6XoVJA==
X-Received: by 2002:a05:6a00:170c:b029:225:8851:5b3c with SMTP id h12-20020a056a00170cb029022588515b3cmr13980887pfc.0.1617402566637;
        Fri, 02 Apr 2021 15:29:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c58:fab2:c5e2:f2d7])
        by smtp.gmail.com with ESMTPSA id t16sm9233094pfc.204.2021.04.02.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:29:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Linus W <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robdclark@chromium.org, Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] drm: Fix EDID reading on ti-sn65dsi86
Date:   Fri,  2 Apr 2021 15:28:34 -0700
Message-Id: <20210402222846.2461042-1-dianders@chromium.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary goal of this series is to try to properly fix EDID reading
for eDP panels using the ti-sn65dsi86 bridge.

Previously we had a patch that added EDID reading but it turned out
not to work at bootup. This caused some extra churn at bootup as we
tried (and failed) to read the EDID several times and also ended up
forcing us to use the hardcoded mode at boot. With this patch series I
believe EDID reading is reliable at boot now and we never use the
hardcoded mode.

This series is the logical successor to the 3-part series containing
the patch ("drm/bridge: ti-sn65dsi86: Properly get the EDID, but only
if refclk") [1] though only one actual patch is the same between the
two.

This series starts out with some general / obvious fixes and moves on
to some more specific and maybe controversial ones. I wouldn't object
to some of the earlier ones landing if they look ready.

This patch was developed against drm-misc-next on a
sc7180-trogdor-lazor device. To get things booting for me, I had to
use Stephen's patch [2] to keep from crashing but otherwise all the
patches I needed were here.

Primary change between v2 and v3 is to stop doing the EDID caching in
the core. I also added Andrzej's review tags.

[1] https://lore.kernel.org/r/20210304155144.3.I60a7fb23ce4589006bc95c64ab8d15c74b876e68@changeid/
[2] https://lore.kernel.org/r/161706912161.3012082.17313817257247946143@swboyd.mtv.corp.google.com/

Changes in v3:
- Removed "NOTES" from commit message.
- Rebased now that we're not moving EDID caching to the core.
- Separating out patch to block AUX channel when not powered.
- Added note about boot speed implications.
- ("Fail aux transfers right away if not powered") split out for v3.

Changes in v2:
- Removed 2nd paragraph in commit message.

Douglas Anderson (12):
  drm/bridge: Fix the stop condition of drm_bridge_chain_pre_enable()
  drm/bridge: ti-sn65dsi86: Simplify refclk handling
  drm/bridge: ti-sn65dsi86: Remove incorrectly tagged kerneldoc comment
  drm/bridge: ti-sn65dsi86: Reorder remove()
  drm/bridge: ti-sn65dsi86: Move drm_panel_unprepare() to post_disable()
  drm/bridge: ti-sn65dsi86: Get rid of the useless detect() function
  drm/bridge: ti-sn65dsi86: Remove extra call:
    drm_connector_update_edid_property()
  drm/bridge: ti-sn65dsi86: Power things properly for reading the EDID
  drm/bridge: ti-sn65dsi86: Fail aux transfers right away if not powered
  drm/bridge: ti-sn65dsi86: Read the EDID only if refclk was provided
  drm/bridge: ti-sn65dsi86: Print an error if we fallback to panel modes
  drm/panel: panel-simple: Use runtime pm to avoid excessive unprepare /
    prepare

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 97 ++++++++++++++++-----------
 drivers/gpu/drm/drm_bridge.c          |  3 +
 drivers/gpu/drm/panel/Kconfig         |  1 +
 drivers/gpu/drm/panel/panel-simple.c  | 93 +++++++++++++++++++------
 4 files changed, 134 insertions(+), 60 deletions(-)

-- 
2.31.0.208.g409f899ff0-goog

