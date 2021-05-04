Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61591372C33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhEDOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhEDOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:40:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 07:39:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so7111540pga.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fJxUztk87HDlZdXytL1WDKfEHMztqMj95QbnZpVdIm8=;
        b=LXY7otbqzp7kKh/WGFZ2KREYsyxMjV+ElUKfdrO2x79Hqa3npPows9h2lsddQzIuH7
         ch//Xg+YKtwOVuI+LjH2KlgILE1GwyJSZ4YDx5SSeFddlp9AjxXwlDS0SaypGA/IsMBV
         LbXWj8uKfYK6vf1k1Cj+JYv3agBtKNMf9Kd9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fJxUztk87HDlZdXytL1WDKfEHMztqMj95QbnZpVdIm8=;
        b=V9uEMC7AdjS8pp82Pg44wULc2kdP9FZOqKNXbxCEw7psvUVI98bU15mCU3aB6kdl9C
         5TbMcjzf3BRt790HCJbLL4WQTU5UukQ01L110eZpHpRtb+JrOTpMoXz1RuDH0faI+CGL
         ig8jvXd+Zlr+ySKHHqR8Yl23FsIXPQ/q7GYUWT2xEeRd7VO6j0qQzfHOHwe0/qKeGSN8
         5AHO/iYrL+vTZma/x9v2jCPU0wL6TRDLcEGfrdw8vntpvD4rneJNNyTgNPq0CXOM1Es1
         t9NI+xvNDh8wzXlQdYvTkSnh7VdPFSDjBj+PuC6so1x1VhBf/VG2NFJo/ZFRibQozz0J
         AYzw==
X-Gm-Message-State: AOAM530f0f3UUUOFUQuaNcBcFCPPpRLRLaOqnTY0Wqpn4dPl+GBCQI38
        RQouwhZEfPyhyhPEx6glpSSOxA==
X-Google-Smtp-Source: ABdhPJw7Jmt/AjPrttnmGcoLR0aC0LG87RUcyje7PjcMVtIZ+7a1Xg0Vhkc7A8l0u/emqKYNa4+E7g==
X-Received: by 2002:a62:3892:0:b029:250:4fac:7e30 with SMTP id f140-20020a6238920000b02902504fac7e30mr24502740pfa.81.1620139157421;
        Tue, 04 May 2021 07:39:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:a592:ac50:b17b:5c43])
        by smtp.gmail.com with ESMTPSA id c6sm3948908pjs.11.2021.05.04.07.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:39:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Remove __exit from GPIO sub-driver remove helper
Date:   Tue,  4 May 2021 07:38:54 -0700
Message-Id: <20210504073845.1.Ibf4194f4252846edaa0c6a6c7b86588f75ad5529@changeid>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti_sn_gpio_unregister() is not just called from the remove path
but also from the error handling of the init path. That means it can't
have the __exit annotation.

Fixes: bf73537f411b ("drm/bridge: ti-sn65dsi86: Break GPIO and MIPI-to-eDP bridge into sub-drivers")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index db027528febd..bb0a0e1c6341 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1251,7 +1251,7 @@ static int __init ti_sn_gpio_register(void)
 	return auxiliary_driver_register(&ti_sn_gpio_driver);
 }
 
-static void __exit ti_sn_gpio_unregister(void)
+static void ti_sn_gpio_unregister(void)
 {
 	auxiliary_driver_unregister(&ti_sn_gpio_driver);
 }
-- 
2.31.1.527.g47e6f16901-goog

