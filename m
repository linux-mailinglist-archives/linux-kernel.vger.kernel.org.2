Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626EE41B961
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbhI1Vhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhI1Vho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:37:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB8C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:36:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k17so133667pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lAhEZS11LpnIzc7KynPjRxiAb+PLMH/7bgGJPagJjE=;
        b=QdcmfJ/qSoowWbOPbMWVW/bQNIsR4/5kP2vt1OphFKkG11kzG4kPRJldG1S2xUqt4G
         4J5Hga2V7YSQwxs2qS+93eWwf2ot5DXO7ROHAwVwifmu7ZUjA/pZAMDpzIrJWfVQIDGL
         1y2rm2Wiu89koEtTmWthN1Q1lK2gqElQoX830=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lAhEZS11LpnIzc7KynPjRxiAb+PLMH/7bgGJPagJjE=;
        b=ZRDFC84rBkM5DfKb4AppTg/Q9yVZaF40ZGiUMSo1QQqgNqkkK9zUhvYikV6WEcTi1k
         V8yw4CL3JSdAU1q0ybf2NGOZbNdOP/wViqfRDGkpFSvhJxPo0mVXs1uLlSZ4aK4+6JBT
         QOEzDTfsr27xoKSQuU06rx7+tW1/L3SGiK5bjBlRHj21L42z4XgpK32NkF1npdLI1hU4
         8Yh/zCXNpr5anxmaL+rQnEKLS06HH4CMC9OUcQ4oYfmePd/TtNqSP9JZOPPKA9BJ++Ig
         nRHXrD+lDTgKYXMM9bqzN+h8WW3+CH8XHxciHb3IJjDZF8Li+9M+ARc0RG82Lch1vUZ9
         vuXg==
X-Gm-Message-State: AOAM530+q590MdYlpuHJlN2s+fId06mjoNhyGKQHK8gO3Og6PQ9DcUNp
        ZS7s4r8tIC9Zcgd527/dQZdOnA==
X-Google-Smtp-Source: ABdhPJywInmIIvWE43lWuKer/3uSKHLxj/LfTYQvFzSRtg3uj2Dg+SYa1UT9GlC6jKYZR1llpkUCcQ==
X-Received: by 2002:a65:5c85:: with SMTP id a5mr6559490pgt.126.1632864964181;
        Tue, 28 Sep 2021 14:36:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d7ca:580:94ab:8af8])
        by smtp.gmail.com with UTF8SMTPSA id z4sm108545pfz.99.2021.09.28.14.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 14:36:03 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        aleksandr.o.makarov@gmail.com
Subject: [PATCH v3 0/4] Fix Rockchip MIPI DSI display init timeouts
Date:   Tue, 28 Sep 2021 14:35:48 -0700
Message-Id: <20210928213552.1001939-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip DSI driver has had a number of bugs over time and has
usually only worked by chance. A number of users have noticed that
things regressed with commit 43c2de1002d2 ("drm/rockchip: dsi: move all
lane config except LCDC mux to bind()"), although it was fixing several
real issues of its own that had been present forever in the upstream
driver (but notably, not in the downstream/BSP driver).

Patch 1 and 2 are the most important fixes here. See their description
for more info.

While I'm at it, fix a few error handling and cleanup issues too.

Changes in v3:
 - New patch, to fix related PM issue discovered after patch 1

Changes in v2:
- Clean up pm-runtime state in error cases.
- Correct git hash for Fixes.

Brian Norris (4):
  drm/rockchip: dsi: Hold pm-runtime across bind/unbind
  drm/rockchip: dsi: Reconfigure hardware on resume()
  drm/rockchip: dsi: Fix unbalanced clock on probe error
  drm/rockchip: dsi: Disable PLL clock on bind error

 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 82 +++++++++++++------
 1 file changed, 59 insertions(+), 23 deletions(-)

-- 
2.33.0.685.g46640cef36-goog

