Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0803D30BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhGVXlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 19:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhGVXle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 19:41:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BFCC061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:22:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bt15so8408250pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilHV4zkFYV/inpNlTjXcax19NKR7g9Dp2bd3Wi4nieU=;
        b=H5PMaoBwCj/x/6zyYxozhyvWGMrvIQXzg/TlzwMXxkPxuAO0Sobu8MZT/+xdkHdx8U
         KOOwY8KyFWw/2ShculMhRh/bi+M+p5yRTBQBIftJ/YDVi3aoASgjN4QuoUoSFqXWbmFt
         ryb2z3k6h/2m3ta2j+N25Qa/slTSq5y5E/zuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilHV4zkFYV/inpNlTjXcax19NKR7g9Dp2bd3Wi4nieU=;
        b=tGwjOHtq6hX53GdTPkPDDqtV/qPlgp2QEheULsn5TPch7hCU3lh515BZa//fl2XpHf
         j9pIPtvh6G2EpO+IcIxdQ6a25FmKL+tK5hQYMRqHiePn2C4w5ofW5eZuFi1CpNp2C1uD
         2Aav70AUtUhdHgSU2Qcy09t1AQXo2+3njWmdwUaj3AvX6u6miRrxPQbuyVIww2SAZHaK
         OBj3Dx2jpcuf2Fdx515BLTC4kDOmsS/uA3vsUZE9sEMm1XylFQviustHd9v0/DkGQvuF
         YiIhvwvAsAX6XADrcugiNDiH97Pj/3JN6mhi86MM7ghmIqqFFap1j/bQOtcuovOL7K06
         yjfA==
X-Gm-Message-State: AOAM530v2UF0t36t9BbJ0XruH/tO4Cd1j/IlIOm4i5+A+mbZ5/HG3ckO
        gy23RXjqM8i8itLa5HnhfzUIYw==
X-Google-Smtp-Source: ABdhPJy3fNIhcYUlCjPQ6rsNOgNRR30C3i3qn3hSQwAIOxUXOxQpz3bxuGzhyKhNARRvDRL91VLEsQ==
X-Received: by 2002:a05:6a00:1951:b029:333:64d3:e1f1 with SMTP id s17-20020a056a001951b029033364d3e1f1mr2175927pfk.43.1626999727675;
        Thu, 22 Jul 2021 17:22:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:5e70:6a49:67b5:2b7e])
        by smtp.gmail.com with ESMTPSA id iy13sm4072377pjb.28.2021.07.22.17.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 17:22:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/8] eDP: Support probing eDP panels dynamically instead of hardcoding
Date:   Thu, 22 Jul 2021 17:21:38 -0700
Message-Id: <20210723002146.1962910-1-dianders@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The goal of this patch series is to move away from hardcoding exact
eDP panels in device tree files. As discussed in the various patches
in this series (I'm not repeating everything here), most eDP panels
are 99% probable and we can get that last 1% by allowing two "power
up" delays to be specified in the device tree file and then using the
panel ID (found in the EDID) to look up additional power sequencing
delays for the panel.

This patch series is the logical contiunation of a previous patch
series where I proposed solving this problem by adding a
board-specific compatible string [1]. In the discussion that followed
it sounded like people were open to something like the solution
proposed in this new series.

[1] https://lore.kernel.org/r/YFKQaXOmOwYyeqvM@google.com/


Douglas Anderson (8):
  dt-bindings: drm/panel-simple: Introduce generic eDP panels
  drm/edid: Break out reading block 0 of the EDID
  drm/edid: Allow the querying/working with the panel ID from the EDID
  drm/panel-simple: Don't re-read the EDID every time we power off the
    panel
  drm/panel-simple: Copy "desc" into driver data; don't store a pointer
  drm/panel-simple: Split the delay structure out of the panel
    description
  drm/panel-simple: Implement generic "edp-panel"s probed by EDID
  arm64: dts: qcom: sc7180: trogdor devices can use probable eDP panels

 .../bindings/display/panel/panel-edp.yaml     | 196 ++++++
 .../bindings/display/panel/panel-simple.yaml  | 559 +++++++++---------
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |   2 +-
 .../sc7180-trogdor-lazor-limozeen-nots.dts    |   2 +-
 .../qcom/sc7180-trogdor-lazor-limozeen.dts    |   2 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |   3 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |   2 +-
 drivers/gpu/drm/drm_edid.c                    | 113 +++-
 drivers/gpu/drm/panel/panel-simple.c          | 497 +++++++++++-----
 include/drm/drm_edid.h                        |  47 ++
 10 files changed, 965 insertions(+), 458 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.yaml

-- 
2.32.0.432.gabb21c7263-goog

