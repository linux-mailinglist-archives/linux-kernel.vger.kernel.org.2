Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A36F362B87
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhDPWmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhDPWln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C037CC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n10so3590374plc.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRxEiBxo2TK9eYFaE6Z8QmjhtPKi2ZOYbG3MBiDbq5Q=;
        b=dMXdGHRO1j71y2Iv2+48IjAI9YY8qkW+j1r2PquWxQUiBGEQRIkzBbRh2GOWbOacTc
         MtacNteNbERfxUY2N6QuKbKfYAwXWwb9TlSzfQqVWzhYjzbrpdsxY/g5qnlaq+jX8Qtz
         BJGuMy3uVZxA6SGPfmYi3n+73r1YGoNx1Fe1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRxEiBxo2TK9eYFaE6Z8QmjhtPKi2ZOYbG3MBiDbq5Q=;
        b=lx8a2mYvzCG9HCffW2y0Kxno8UBwwhFUKQeBr6ZIHgToLYkDa17CoFWlubXBT7MHiA
         kUzgkRP0ZlfuULHjINKlXsY/1RwwyBq+3rhovm3M8cwZdwdTETdgWI0YQuZLLj1oWIAD
         8OAG7+9AX/fZGUqjstXuhEz6ujh6o5mgH27VL3tY9o/nX+DJ8M0L3VxZorfu5AXjgdU+
         pOI7bF97ePmtdyaOH1aZx26urUpCSsTFJ7KjXrh3gFjZh8qh7apgW6VCrp7/SQ7gVpEY
         eVTDBfy9V9Ls6Tqcoj0bY0tPG5jWYxyRFocXQSm/tNtkpwn4MXUZJ04DfwSIEv3LCm4F
         3ETQ==
X-Gm-Message-State: AOAM531mF8o2Gu6se9upYMemGO9uL77ZJhd5G2G1IEET9Cz7KUwch74G
        XaWdrA4ICA58OP2ptICTnXCZ0w==
X-Google-Smtp-Source: ABdhPJyWnRznUdTyIvfS7dug/lUV2TaYTjzVaxsnEcIWBHeIiVhb9ryAZZH4fGMUWj2xhxmdm+R7Nw==
X-Received: by 2002:a17:90b:344a:: with SMTP id lj10mr12317920pjb.101.1618612877403;
        Fri, 16 Apr 2021 15:41:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:41:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 22/27] drm/panel: panel-simple: Remove extra call: drm_connector_update_edid_property()
Date:   Fri, 16 Apr 2021 15:39:45 -0700
Message-Id: <20210416153909.v4.22.Icb581b0273d95cc33ca38676c61ae6d7d2e75357@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 5186421cbfe2 ("drm: Introduce epoch counter to
drm_connector") the drm_get_edid() function calls
drm_connector_update_edid_property() for us. There's no reason for us
to call it again.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
As Laurent pointed out [1] this is actually a pretty common
problem. His suggestion to do this more broadly is a good idea but
this series is probably a bit ambitious already so I would suggest
that be taken up separately.

[1] https://lore.kernel.org/r/YGphgcESWsozCi1y@pendragon.ideasonboard.com

(no changes since v1)

 drivers/gpu/drm/panel/panel-simple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 90a17ca79d06..c91e8aa108f7 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -512,7 +512,6 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	if (p->ddc) {
 		struct edid *edid = drm_get_edid(connector, p->ddc);
 
-		drm_connector_update_edid_property(connector, edid);
 		if (edid) {
 			num += drm_add_edid_modes(connector, edid);
 			kfree(edid);
-- 
2.31.1.368.gbe11c130af-goog

