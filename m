Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3E419DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhI0SCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbhI0SCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:02:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A1C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:00:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x8so9492025plv.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XeK3fC1as7/l09IEKRp5nj1z/349IvKAECLEDwlj+pQ=;
        b=eeMKXoA4LwztWls+u58Kp6dhBDTL2K6aGw4lSmpWOp9Aq9feo0aOC2ysbKEjJzfccI
         wF8/owbs/fy7OeESMzFl6Hott5p4vcWR2HAELQiL3e/AW8M5bXzUtHcTRiyI2mwMH5yh
         4QRYDRIBMaMxhNxzcZghfcZ/TM05tDlxAUEeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeK3fC1as7/l09IEKRp5nj1z/349IvKAECLEDwlj+pQ=;
        b=GKff6XS40w1ayBN4cfpnNailzBi3RBmT8VIaz7QL42CZ8zFTvx7QXGOtnaSQrkzIpu
         STLi4Wfv5nkdbfocQDSRFralTCdnQDQ0zZTMTsH7QO+esUnuEN2frxHKztw/+7J1Bb8t
         PENqEbEX+7UT272+b8f7LBHFCKBrtsMIRn/GUPTsTEdA4KC/fZ7yF0nik0CFi1wY4wz3
         8ehiK2ARn+pdcPJeeQ4hsgkQII8UF3kFMPitMpdhTLH0PvXUKEYKckABHIgP8K889ZpZ
         tBG7TOlRDprTmrUfW+t159fc+fPXk5nAtM1tQ4HqRuyLHj0iLznlb1DXt7PDEuBDuz/X
         BJLQ==
X-Gm-Message-State: AOAM533Kf8mCrpekaxNdK18uGGopZPTgnYDrLjfdKuIm/+2ckWLuQZEB
        Wk9DkRG3QulTV0d9E/MIGAoAWA==
X-Google-Smtp-Source: ABdhPJx99jitosZspKZ2TAmKA7Weg9Nq6qSA3epb+VhUvrhehR+ICQzgBodfoUiEwH6y9LdUTRTFkQ==
X-Received: by 2002:a17:90b:4d05:: with SMTP id mw5mr379107pjb.175.1632765623593;
        Mon, 27 Sep 2021 11:00:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:82d7:f099:76bc:7017])
        by smtp.gmail.com with UTF8SMTPSA id q12sm19986829pgv.26.2021.09.27.11.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:00:23 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     Thomas Hebb <tommyhebb@gmail.com>, dri-devel@lists.freedesktop.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/3] drm/rockchip: dsi: Fix unbalanced clock on probe error
Date:   Mon, 27 Sep 2021 10:59:43 -0700
Message-Id: <20210927105928.v2.2.Ie8ceefb51ab6065a1151869b6fcda41a467d4d2c@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210927175944.3381314-1-briannorris@chromium.org>
References: <20210927175944.3381314-1-briannorris@chromium.org>
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
index 45676b23c019..fa4080176719 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1398,14 +1398,10 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
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

