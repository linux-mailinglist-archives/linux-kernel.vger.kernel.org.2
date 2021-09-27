Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B44419DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhI0SB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhI0SB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:01:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2000C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:00:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so18536737pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PbJI/NGQNYdtwQzX1JrUbqIFsSdwzRguepeO6Wp4No=;
        b=Pz6y/M5hn8b92RZGVzmR+TkkhbEStVLovKP2oxkVOGpyYnQ+BvBPGDBKKrbaCJ+ATV
         4+DMtH7ssQsSjC7SRGOiOOPo3nrn5wDM4yaVLSaCIA9GSP7vTLyEt+NV9JgXXwuB/MR0
         UWDNF+nUhFT5ny6ZVEVDwFMFCDkaOW4msrPHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PbJI/NGQNYdtwQzX1JrUbqIFsSdwzRguepeO6Wp4No=;
        b=SWXHAfN6yg1zJJfVfbLDabvI7umSvwnmNtRJlh53X6Oh4AvloCv032zTXlnQgEuF5X
         W6V5bfs8KXltD9/95/+dMEEeOSFPSFNl1ziCPjXcy86iuY+mk8AwBVu+AJT7oNO2nFoU
         PQG6++T6PTVkAMcyMMJLGXD8N598kdlXQfCJDSHqbzmGDaHDAThqWAq8i295xkko/LYN
         dbXMk2/MhGJ14KZiLYzEm54RrtuubFWAlQ0DMa0gpVkdHU1zuXfA/VLNI+Aco41blg8Z
         r/D9ST7gfxVXUiWoUip4Rp+KkFnq5tEv9sZ+Wlsa+EpnTND91t8NK3TAGDSpAjZnfR6t
         kOqw==
X-Gm-Message-State: AOAM530Z9rclg89buUMGGoknz9qKOXQcrXAL+H0R79l3sOyZ20hS16vF
        dVjvNkAcJtlsU7gsKXqwfUxkXvtdXDqNCA==
X-Google-Smtp-Source: ABdhPJwLp0SdiYhLnw613zBO3yuNqwAhDyhZ0EPM2HnxJTM/+CQ0S55JBw+qQ66o5PleLMz8Jw3fxA==
X-Received: by 2002:a62:1b08:0:b0:43e:88f8:8f5e with SMTP id b8-20020a621b08000000b0043e88f88f5emr1169552pfb.41.1632765619293;
        Mon, 27 Sep 2021 11:00:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:82d7:f099:76bc:7017])
        by smtp.gmail.com with UTF8SMTPSA id a10sm17521756pfn.48.2021.09.27.11.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:00:18 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     Thomas Hebb <tommyhebb@gmail.com>, dri-devel@lists.freedesktop.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        aleksandr.o.makarov@gmail.com
Subject: [PATCH v2 0/3] Fix Rockchip MIPI DSI display init timeouts
Date:   Mon, 27 Sep 2021 10:59:41 -0700
Message-Id: <20210927175944.3381314-1-briannorris@chromium.org>
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

Patch 1 is the most important fix here. See its description for more
info.

While I'm at it, fix a few error handling and cleanup issues too.

Changes in v2:
- Clean up pm-runtime state in error cases.
- Correct git hash for Fixes.

Brian Norris (3):
  drm/rockchip: dsi: Hold pm-runtime across bind/unbind
  drm/rockchip: dsi: Fix unbalanced clock on probe error
  drm/rockchip: dsi: Disable PLL clock on bind error

 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

-- 
2.33.0.685.g46640cef36-goog

