Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B97035311C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhDBW3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbhDBW3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:29:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E70C061794
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:29:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ay2so3067561plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qux1BcXKfGbtkPfbhFH+jwIJdgaEMApMJYvljbzcQac=;
        b=WDsbf4lhRBTZdR+Ed/viXWb7jCiyUvqbtYl+NMkDRlA9aIsoeprHspN5GGG5ZoOIww
         ufFT4Nq1RECpf0IYakhKA4dcWMfyo4X059HXV1UaUh0P/KnsS663C4PzZ03iLIEcoj33
         AP5VnW5xF+JYQlJxpiqogAlXoqvQuQW4t9XTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qux1BcXKfGbtkPfbhFH+jwIJdgaEMApMJYvljbzcQac=;
        b=m0BwwMMsjdnWJkz2WomQRFLwjSLX8iAL770CFefmiDI6ug3/6d7Tx4KeY2PC/hPF37
         YlEUUTF+JA5jr7ffICJhuLCcjAJDgZntigDVCx/dbPy+4rbnZBBYYBeRvEOwtz9/y3Ht
         dvX8YyNf3sRQvghDilas7znj3xH+v6tNtJZYGg8pNhmOgtN+6tTREu1GaOnSbu7dxxq9
         o+NF3xeq3kdfBw7z7xAHjpvP6dqNt6xqXnqiWVCIa4MQrUd5F66CTp3AKUYc9ebgSdES
         DNV5AAWs2zl+ptK7SEQtXKAizdIIFte0YbRkUhAIVcXfWv7OyG6Mvmmn6TN1/wXbgNKF
         IkSg==
X-Gm-Message-State: AOAM533E3AO8zOez81+UVpMgI4YORoE/cuLnAqTFogg+cYJnWQJ0Fpty
        tsr5XEajokeu2b+nclOcqqRhSw==
X-Google-Smtp-Source: ABdhPJz85KJT/5mvyklmGV27zCWK7g/5WFe1sKszdh7ahKEi36K8AnjDbqPhij1HqBG/Y+24UBiNOw==
X-Received: by 2002:a17:902:9a06:b029:e6:9241:2779 with SMTP id v6-20020a1709029a06b02900e692412779mr14282257plp.24.1617402569906;
        Fri, 02 Apr 2021 15:29:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c58:fab2:c5e2:f2d7])
        by smtp.gmail.com with ESMTPSA id t16sm9233094pfc.204.2021.04.02.15.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:29:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Linus W <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robdclark@chromium.org, Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/12] drm/bridge: ti-sn65dsi86: Remove incorrectly tagged kerneldoc comment
Date:   Fri,  2 Apr 2021 15:28:37 -0700
Message-Id: <20210402152701.v3.3.I167766eeaf4c4646a3934c4dd5332decbab6bd68@changeid>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210402222846.2461042-1-dianders@chromium.org>
References: <20210402222846.2461042-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A random comment inside a function had "/**" in front of it. That
doesn't make sense. Remove.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 96fe8f2c0ea9..76f43af6735d 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -788,7 +788,7 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 	/* set dsi clk frequency value */
 	ti_sn_bridge_set_dsi_rate(pdata);
 
-	/**
+	/*
 	 * The SN65DSI86 only supports ASSR Display Authentication method and
 	 * this method is enabled by default. An eDP panel must support this
 	 * authentication method. We need to enable this method in the eDP panel
-- 
2.31.0.208.g409f899ff0-goog

