Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C9A34DEE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhC3CzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhC3CyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:54:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BC8C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso6909100pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYK7VrB9zh1nJosxOHMeXf6pgnTeHfrprZk+pogrvOE=;
        b=Gc6dqK9kmETo+Nhx6WAnosO6l6Pe4N4Cqli441GiQUT9ff2Xr0mlCXlLX6zzUM2cd4
         LjzpG4qVSmYxPdvz0fL9cz8HRyyWHusIDXOzBiqGI/fX0TePOdFugaUwLbb39DagvxDI
         PyF2+19s9Frn5Yq4n6ToLHNOkTbxE9nBksZv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYK7VrB9zh1nJosxOHMeXf6pgnTeHfrprZk+pogrvOE=;
        b=iA0EwX1dFSNGlyFl5TSZFKq5FdCPOZHKh3qcmZYDd5Y34f+GVQ7vnHwvRZ5vcLmtck
         jCV/fAjfe+tqSxJBmh4dip3345HuQwbAi/4zFi1Fp6r05ioTDNUGvzaFDUlE+OhkUAHz
         EgLAg/oHpSAE0Lajvoe4P7gmnMIu0irGBSrvUGLx+Lufxc/Ot0AXMEl/Iny6UGkf5VaP
         1iGdEA+aHkJhc7YE1OFZC7tcwA1hnPKfr1ayM2hjmraJ90rbnpdemVS8sCg3AxDAR1Tx
         +MH5IHT7JCuZo+tcWQuTWWdQb5KH+gNvLts5DN28U8HoKRuqu8lUKHZHl68vDWx8G4eC
         u2nQ==
X-Gm-Message-State: AOAM533He6XJPsxaON//qZt8IYUWnE1ArAbjeRN20vZEBKoLYOASWF9+
        QD8nKd3ublEQwOi0glAWsBaqjQ==
X-Google-Smtp-Source: ABdhPJzp+H901r/w9Tl3yZlkxjUAYJrtNugSXQZRWimDt36JIwcL8mivHva4TYJaIp+QJ1HcRxCFSg==
X-Received: by 2002:a17:90a:9a91:: with SMTP id e17mr2109663pjp.218.1617072863117;
        Mon, 29 Mar 2021 19:54:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f599:1ca7:742d:6b50])
        by smtp.gmail.com with ESMTPSA id t17sm19152706pgk.25.2021.03.29.19.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:54:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        robdclark@chromium.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/14] drm/bridge: ti-sn65dsi86: Print an error if we fallback to panel modes
Date:   Mon, 29 Mar 2021 19:53:44 -0700
Message-Id: <20210329195255.v2.13.Ib4183a04e8698f60b67558f363fddbbaf33dd445@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330025345.3980086-1-dianders@chromium.org>
References: <20210330025345.3980086-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can properly read the EDID for modes there should be no
reason to fallback to the fixed modes that our downstream panel driver
provides us. Let's make that clear by:
- Putting an error message in the logs if we fall back.
- Putting a comment in saying what's going on.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 92498900c58d..20c3b13939c2 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -318,6 +318,13 @@ static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
 			return num;
 	}
 
+	/*
+	 * Ideally this should never happen and we could remove the fallback
+	 * but let's preserve old behavior.
+	 */
+	DRM_DEV_ERROR(pdata->dev,
+		      "Failed to read EDID; falling back to panel modes");
+
 exit:
 	return drm_panel_get_modes(pdata->panel, connector);
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

