Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E1235312C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbhDBW34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhDBW3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:29:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AECEC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:29:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so3144709pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 15:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtWyTu8A+Bll3XZyYofmr3PZnBtQf0rbeehEFhIdO78=;
        b=Ltxl2XhjD/ANgUYImu7Hfd2BJK5hAeBDH7r6rm/XM1PchLg6jFes8pOy+fpJ+d1xNF
         mEi8EfXMnmaNGrqNPKLakjwlMXMrTeRPfxTjq/AkQhjFd8nhYHYHlNIdRaFnYkXxtc+y
         wHQML8n9Eclh+k1XvOVHhvXRVVTKehp8QiIIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtWyTu8A+Bll3XZyYofmr3PZnBtQf0rbeehEFhIdO78=;
        b=BCK0gm76MLfDxImZ0qGOwOqqTHp09MVrWAWYDmJFLR+ja9P91FGB8/KBPps55F+yY5
         3Qu2WbDApWCsdU3Pt27qwEdsoxg31WACEr4vPx8hRW9sfet0UBjxVvvpFaTotXAYrVu+
         rkwqg77vYkT/XzrVSf+qFjE5rbx7oe04TLhUTB2QVWRxCar32aYqwOZHKs9HPFIf8Ixe
         vJczbQLJekdrIC4BLwpyNUHJKp4E9LB7jFzLE9XHWIzaB19d+NK2wtbr9DdnzOdQQj0W
         a0OK7N5KEvShjN40feBWjzfKC8WwBWKvhg0utYuSxadjUF8P9Yo6HtUfL6Tuo2y9Gk95
         LzoA==
X-Gm-Message-State: AOAM5324lHyvvkg2pfB+4bRrgK/tGzOssBycWGR+TIMzXqOSSFrL8lWl
        q0ToRc50MflEM/Nx8LDmIo0ZPw==
X-Google-Smtp-Source: ABdhPJxUVyK0tKS8MW57jWx2k1rvcrhHVw/btAMD+OvmUvahUSin882TSOsaAzGaGWOl39sdORxuew==
X-Received: by 2002:a17:902:c94c:b029:e6:cd16:24ec with SMTP id i12-20020a170902c94cb02900e6cd1624ecmr14488649pla.27.1617402578767;
        Fri, 02 Apr 2021 15:29:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c58:fab2:c5e2:f2d7])
        by smtp.gmail.com with ESMTPSA id t16sm9233094pfc.204.2021.04.02.15.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:29:38 -0700 (PDT)
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
Subject: [PATCH v3 11/12] drm/bridge: ti-sn65dsi86: Print an error if we fallback to panel modes
Date:   Fri,  2 Apr 2021 15:28:45 -0700
Message-Id: <20210402152701.v3.11.Ib4183a04e8698f60b67558f363fddbbaf33dd445@changeid>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210402222846.2461042-1-dianders@chromium.org>
References: <20210402222846.2461042-1-dianders@chromium.org>
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
index fb50f9f95b0f..3b61898cf9cb 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -303,6 +303,13 @@ static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
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
2.31.0.208.g409f899ff0-goog

