Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC444301F1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 12:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbhJPKYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhJPKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:24:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8DAC061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 03:22:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t16so48260037eds.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPwi9bv3AwLXQNt+5z8klYHbS6PLiM3Ne2X045V+1Mo=;
        b=eujFLhEc8Z2MlCySf5/p04gtBbRyIbpBNBoczlmQ4zPvDnwLUAjNuFH7G5o5e6C0q5
         70Q9vPenbyrUOejoUCF+ZllglN19cEZTwEMdxz6ubscCWbPSqJ/SFT3uwvIO+OYkv2Nr
         uHAdqa8IYB2UX0fSNWeTf0XrquN27i1/gnniM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPwi9bv3AwLXQNt+5z8klYHbS6PLiM3Ne2X045V+1Mo=;
        b=fmWROjl9nTQPst803X3Ne36oQmMDDClKpBqNF9G74UEUmfe13YoaxKvArJ+GtNNn69
         t3JyO6viO07K84Yx4yI6vUNhlV7q8OQ9d+gP8jkDQiBEK5jj6dlmFHQnUCxQ4ziIDjmO
         KHDprEHEa9iavJIodO5slZDCHldhIF1cmloa0IeA3O74ehbTTFBE+n6Xp5VX6DLfdm/Q
         bezHHvYO04ji1aQ8tvahPc90O5VZloDHE+QmCxoHhmTflgBR0BERm8RtFCYudm7GbuSh
         Uhpy9hQxleDqDmd7CTiluAW4+jGH8E0eo3YrMyD+KzCAAI4x0t625LjfZKr9oHiMGLzZ
         GEFw==
X-Gm-Message-State: AOAM530RzzB2v0e3TiOMC6psHYeyTOVUx8eDWLtgnS+wsRZrcBXZa60P
        zbGjKs/VcirAUmFG4guEwRHT/Q==
X-Google-Smtp-Source: ABdhPJzE3izz+NFWNjpYJ6wjjvut2arrelK7aHCUq303rPRV7bZXYq++e0FMe+EqdwFTd7rYPQb7gg==
X-Received: by 2002:a17:907:7803:: with SMTP id la3mr14082680ejc.235.1634379754545;
        Sat, 16 Oct 2021 03:22:34 -0700 (PDT)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id la1sm6117361ejc.48.2021.10.16.03.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 03:22:33 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add support for Wanchanglong panel used in px30-evb v11
Date:   Sat, 16 Oct 2021 10:22:27 +0000
Message-Id: <20211016102232.202119-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for W552946ABA panel. This panel is used
in px30-evb v11. All the patches can be applied on top of drm-fixes
branch. The last patch is suppose to fix a race when the panel is built
in. Tested on px30 evb

Michael Trimarchi (5):
  dt-bindings: vendor-prefix: add Wanchanglong Electronics Technology
  drm/panel: ilitek-ili9881d: add support for Wanchanglong W552946ABA
    panel
  dt-bindings: ili9881c: add compatible string for Wanchanglong
    w552946aba
  drm/panel: ilitek-ili9881c: Make gpio-reset optional
  drm/bridge: dw-mipi-dsi: Fix dsi registration during drm probing

 .../display/panel/ilitek,ili9881c.yaml        |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |   8 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 240 +++++++++++++++++-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |  12 +-
 include/drm/bridge/dw_mipi_dsi.h              |   2 +-
 6 files changed, 257 insertions(+), 9 deletions(-)

-- 
2.25.1

