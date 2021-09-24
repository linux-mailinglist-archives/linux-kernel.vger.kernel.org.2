Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684B9417E27
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 01:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346121AbhIXXZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 19:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346092AbhIXXZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 19:25:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339EAC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 16:24:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f129so11339941pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1xurLATt1ex61qvV7KZiCU51/9V6GkfxwxIS9VeD8VA=;
        b=M0iBjYKc31rwburlfMZhx8Oipce7pYY2b5Wpof8qmfYNDOvUxojzCbPVRom/Yf98BS
         U2aMO7VEjPmHKfCPKRqp6w1QdDDg/lnJZL7ZZEi2aaExAU7LgRYJwhNBFrc6Qvq3CExX
         nLwe3BAxUsOGADFUJj40SReGj/U7+suX8cfR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xurLATt1ex61qvV7KZiCU51/9V6GkfxwxIS9VeD8VA=;
        b=GFl6XzMb2UXSnFwy57jxhUN/jJTfA4o2B+NsI8jbdTfQp2Q+qlPvzFxo+VXWRxCrE9
         7JKJZwBJWqEIDQr+n2mmusJFwrxlGwDxk1b8gKdN3cHh2xhXqnTEBvSKUJzBa11nuOiC
         IPJNiXIVn9hLHETlj7TTghB/YJFepu19drb4j6KxwqV9BR7hlNtq5b7ZDjHrv2Ppj3dH
         l1KabHv/J9hI5ruQ9euoySQ2tCB1IlaQhSNXLffNFwXocXtp/1+wBH0JmSLrApJVQLDz
         q5nK0FnHinNleUnrvNrkHV7Yg1ziK3GoDh+/ucJFHUQ6Yc1Kd7yyTYzp4NytTbKDxn/d
         9pvA==
X-Gm-Message-State: AOAM531ykFo16rJf8lpxP4vq1kUElFZN7xARZ36DoVT+cEJyZvfDfkD5
        Y+yV+bPsSkYJuXSigX5kdh+0ew==
X-Google-Smtp-Source: ABdhPJxSkNCeRzwyQ3fSmMMMaH7U8DCIuSFSDDP6SFmH8mr0k4mDFzipSj7Tc0UW0PwqVpy2bX58+Q==
X-Received: by 2002:a63:555d:: with SMTP id f29mr5911472pgm.33.1632525839778;
        Fri, 24 Sep 2021 16:23:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:74de:c8b7:3a35:1063])
        by smtp.gmail.com with UTF8SMTPSA id 18sm9916476pfh.115.2021.09.24.16.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 16:23:59 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Thomas Hebb <tommyhebb@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] drm/rockchip: dsi: Fix unbalanced clock on probe error
Date:   Fri, 24 Sep 2021 16:23:46 -0700
Message-Id: <20210924162321.2.Ie8ceefb51ab6065a1151869b6fcda41a467d4d2c@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210924162321.1.Ic2904d37f30013a7f3d8476203ad3733c186827e@changeid>
References: <20210924162321.1.Ic2904d37f30013a7f3d8476203ad3733c186827e@changeid>
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
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 4340a99edb97..0886a5dee58c 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1391,14 +1391,10 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
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

