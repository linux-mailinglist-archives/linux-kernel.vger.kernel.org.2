Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9859941B969
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbhI1Vh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242969AbhI1Vhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:37:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EBCC061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:36:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so2672884pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQX8GmY7T6q1qGlMzAWCdy7ICpLGZnTQF7PCVQGgK8s=;
        b=S/hCXUApz8v+EUOzq+kJgswsyDLmDLWGOGe8+KqWZqgpB6uopZbXwSsAQXyn13zg4Y
         Z3qFD6UkcUsi3aLN/halyD1zf32opsJxPdQW4xmUCxET4iCZmwlzJPcxK76nAeupUudL
         5n8BzBLWXkGtKPCUHcFDAqlWt1aCP/7LZH7NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQX8GmY7T6q1qGlMzAWCdy7ICpLGZnTQF7PCVQGgK8s=;
        b=FfWmOSl1vmTO9H6lLYQKXUWpasp7rl1UmKXiUyu1Yf+qBeF1HEYxmfNgV/jHk6LJaR
         oIez9XEyCi4HSm7RET1rmWBV+u/BbPoR7tOAaeocObmZMOFMLadxRKjIhxfFBQoLQwcf
         SO2RTs42Z0wddVvOejV25P4eNXcn4FFSPV7BVm/KdBNp34yCuv/wbkWDhp7Gr4Bcz6X3
         WyDHvwj7euR9p54c/VgbzkWkGuObm35bUc0QX3mYUXPDFPzWQmVE4lMajkhcafRW6XEt
         TC5jqJ35v5WJkMYb6FklZcRR5IcpkYMG9p5FkYulJPZsxVcAZ5EITL9/eAIwuVpYsSKX
         OPlw==
X-Gm-Message-State: AOAM530WrZ0YvLVI48pzuu3UnVm5YPKlID4VqrcxHLZWqbH0+Gm1ZMAO
        aFZk0HMvxRZNGJTCDZw7wAwe/A==
X-Google-Smtp-Source: ABdhPJxBtdrSwbloXEqMEPuEWnVWzEKAvsoScNpy0XM3MNi5Y5l3IAsEFHhs+VYcC72TNoEAzTsALw==
X-Received: by 2002:a17:902:cec2:b0:13b:5916:59e1 with SMTP id d2-20020a170902cec200b0013b591659e1mr6841845plg.76.1632864970399;
        Tue, 28 Sep 2021 14:36:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d7ca:580:94ab:8af8])
        by smtp.gmail.com with UTF8SMTPSA id n18sm105073pfa.42.2021.09.28.14.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 14:36:09 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 3/4] drm/rockchip: dsi: Fix unbalanced clock on probe error
Date:   Tue, 28 Sep 2021 14:35:51 -0700
Message-Id: <20210928143413.v3.3.Ie8ceefb51ab6065a1151869b6fcda41a467d4d2c@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928213552.1001939-1-briannorris@chromium.org>
References: <20210928213552.1001939-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our probe() function never enabled this clock, so we shouldn't disable
it if we fail to probe the bridge.

Noted by inspection.

Fixes: 2d4f7bdafd70 ("drm/rockchip: dsi: migrate to use dw-mipi-dsi bridge driver")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 21c67343cc6c..8ea852880d1c 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1434,14 +1434,10 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 		if (ret != -EPROBE_DEFER)
 			DRM_DEV_ERROR(dev,
 				      "Failed to probe dw_mipi_dsi: %d\n", ret);
-		goto err_clkdisable;
+		return ret;
 	}
 
 	return 0;
-
-err_clkdisable:
-	clk_disable_unprepare(dsi->pllref_clk);
-	return ret;
 }
 
 static int dw_mipi_dsi_rockchip_remove(struct platform_device *pdev)
-- 
2.33.0.685.g46640cef36-goog

