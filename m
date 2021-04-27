Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9236BF07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 07:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhD0FyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 01:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhD0FyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:54:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBE1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:53:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y62so7980622pfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ahbz/au3UbZNosIsF6EFm5aomtTD02orvpaKrCQHc40=;
        b=LWUJHbOKgdtJ6oX6D83nOjdlgK4s7GNJtDAuLp8ylGAzyCM6UBb/jzFgeJ7DGAbpJP
         DNd4vPaxPeiZXGX2WcIkffpVjQzwZ0a+WdyQspUanrHBH9B3DQvKHXAFXog1GY+Jg+I4
         4uTRNikVtyX498tn5gK2eSioOe9mcDzsmfo+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ahbz/au3UbZNosIsF6EFm5aomtTD02orvpaKrCQHc40=;
        b=c/p2Stmv53ilMnO5dOYaU5V8PKMUcR7l437SfBAqvbXBzohXsF9F2Y+z1WYr4Vu87H
         brYEDzN5pEvzkZ0tMeKSg97Yk1sjRi9i3ZKxLiLDsnqBWsDb2SH3uxk606WfDviy+3wn
         CeWjS2tGTB8oKkX1//e6AoSgnJHuJgGngEj3FsLwtkGjomp8LoJsc4aGWaN75KU4xmVO
         Lqg0b+kSbyfuNI4WxG1yiAv0r1N1EHrgeuesDOPTHFkq5zwVyrMeXJ6E7iK3jIjNSvGo
         za1/itqbB+Dum9Wos6aLBNQeBhldQIy2zYI3zUjGgovDOA/NOfKFpltIcnfYCxSSepo/
         UW+Q==
X-Gm-Message-State: AOAM5312iA8oj7hAIfcsU2hls+/rDlc94UpmcG0PlTlWoLSmZ4wDijGa
        DV0OyaGFVwGrDgTUyMpSAhUlAQ==
X-Google-Smtp-Source: ABdhPJzrGiIV8MdRDA3kGoxL5uIu6D4c5p2fXonC3FcGnjrTM+5T9wK9n28nao14b4ww4VXQLrSlMw==
X-Received: by 2002:aa7:864b:0:b029:272:947e:85d7 with SMTP id a11-20020aa7864b0000b0290272947e85d7mr13782076pfo.45.1619502806391;
        Mon, 26 Apr 2021 22:53:26 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3984:c4f5:8612:6b3e])
        by smtp.gmail.com with ESMTPSA id b25sm1367457pfd.7.2021.04.26.22.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 22:53:25 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Fix power on delay
Date:   Tue, 27 Apr 2021 13:53:20 +0800
Message-Id: <20210427055320.32404-1-hsinyi@chromium.org>
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
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 23283ba0c4f9..0a8db745cfd5 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -893,7 +893,7 @@ static void anx7625_power_on(struct anx7625_data *ctx)
 		usleep_range(2000, 2100);
 	}
 
-	usleep_range(4000, 4100);
+	usleep_range(10000, 11000);
 
 	/* Power on pin enable */
 	gpiod_set_value(ctx->pdata.gpio_p_on, 1);
-- 
2.31.1.498.g6c1eba8ee3d-goog

