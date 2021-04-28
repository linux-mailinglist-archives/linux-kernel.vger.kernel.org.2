Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA836D6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhD1LwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhD1LwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:52:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:51:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so8905907pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ggqrO3Qchc0pj7s94KCNuU19NGYvqjq5lpDMS8H3Tw=;
        b=TaxV56rAxX7DI8UcYkHNfDIiMW39vSkIvG80M/cHa9F8EHu0ZhIDqq5LxQQ++R0zAW
         43N7aA+0N2Xv1Dldc9f0lrCFJqrmb7BzORDlQOiFYljP4an+R1YTCxxTOq6q9qDm+cSS
         5wDplLbbtZhW32jTxiT//mI1RAt2gAJRbDugM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ggqrO3Qchc0pj7s94KCNuU19NGYvqjq5lpDMS8H3Tw=;
        b=e8kMu2/9AUtWTlTw9JYoyjUgDSTxZ7Aa/bv/KSPa+q8AEJtvnPN3Gf6f6a1M5aO4Np
         iWv3w8d5BvaBJhSAHObzG0iYhAiF4U6k6/ZJauTyK36vDCPKj4LQn+UuAJNjrryguLrW
         f+AVgs1IzpVci7C1H87oUA1Iyw4rY5NfNKpgWy/J13fVf1xqgKaD3fIX9kWUN78YqREr
         kre1zg2QPKsfQwCfGl/dXcb6dXHoRQX0GReLxxStfUQm8NM63QRxiVeGhdAuQutF79sz
         OUenh3ik1MfulcmtOriudqaAwBt0K7kMKXczRSHCcQoc58ofPjXxX2ocCND/ggt5A/cm
         DVOg==
X-Gm-Message-State: AOAM530QwpFP03fVu4K7TNUgLYVCpJIM6cK2z+5Y2rDJyrV5Ssel2cF2
        z6BhTvAodVCnSTHD26ajkvLlXQ==
X-Google-Smtp-Source: ABdhPJwjgoH7hDN3JydB+39qADl+YpIqlvB7+GbFcirFX78xUnDZJs9piLSTNKYh9oW6oiklSYLooA==
X-Received: by 2002:a17:902:b78b:b029:ed:5429:4c2c with SMTP id e11-20020a170902b78bb02900ed54294c2cmr10025560pls.4.1619610681285;
        Wed, 28 Apr 2021 04:51:21 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1faf:c32e:8742:d913])
        by smtp.gmail.com with ESMTPSA id y8sm2403760pgr.48.2021.04.28.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:51:20 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2] drm/bridge: anx7625: Fix power on delay
Date:   Wed, 28 Apr 2021 19:51:16 +0800
Message-Id: <20210428115116.931328-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From anx7625 spec, the delay between powering on power supplies and gpio
should be larger than 10ms.

Fixes: 6c744983004e ("drm/bridge: anx7625: disable regulators when power off")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
v1->v2: Extend sleep range a bit as the regulator on some device takes
more time to be powered on after regulator_enable() is called.
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 23283ba0c4f9..b4e349ca38fe 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -893,7 +893,7 @@ static void anx7625_power_on(struct anx7625_data *ctx)
 		usleep_range(2000, 2100);
 	}
 
-	usleep_range(4000, 4100);
+	usleep_range(11000, 12000);
 
 	/* Power on pin enable */
 	gpiod_set_value(ctx->pdata.gpio_p_on, 1);
-- 
2.31.1.498.g6c1eba8ee3d-goog

