Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA335311F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhDBW3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhDBW3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:29:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED3DC061797
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:29:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f29so1861344pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LWCZqEnQt7O4dKOp3uwcwxtiQFjYMPyEMkDo43bfXr8=;
        b=YHdp6YkAZFHy7ph7L0Y8wFiPRja6fUyOKBIrreFiGUeAQaOdtiOE3kD19znNKVphAm
         QEOc3L9wZlp/cuaGQfUJQCvwElQN+lGbhPWW4Z6S7UKxwunn024GJL4Agcz4MJWbmarp
         zXXww/rb77+KKMosD1Q9oM7hNimK2+vAzaG9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWCZqEnQt7O4dKOp3uwcwxtiQFjYMPyEMkDo43bfXr8=;
        b=FW83BgrtijZdu95+Dup3eJtI5L40dG0+ZAYbg2rj4nbJo4XJr87elUOgEajHowTgbI
         b1/ZkXqc9g4a62zi6bZzjL25f07ez0khMGM8KR6Xy+r6yMpFU23zgAsFb9jFFDAtIzRr
         OO3LVN+X7mEVV/siVm/9lj5AzjjEMnc6CEzLixtiqmIBACl6kh6E/ML3Azi6+2hHdpB8
         ozXv3GNfkrwIBPhaRqNrJkvs8ogC5OanCdgf8l/hraHpinBFpIb9Sv4hyo2l2Vg1GIK/
         EFQdIPLPhIVlXKB6Kko272CaS1NdBSwDPdRWKDJn6RkAK0i2cTxb7mV+FWNgfDcCpnU0
         6teQ==
X-Gm-Message-State: AOAM531mJat5dvWcyJd0Od/+qQV4ghrVUP90yGIfG17RaEYk/inpNnHU
        hd/U+AhLtAsAcI2XWP4QvSgC+Q==
X-Google-Smtp-Source: ABdhPJwtwqI2tvZw0BgazX6ZmDH5UDrOdbnhYE1ACnzRHDuaa4PqC6+vmRWdeDEmIu3Kc2t4/6c2Yw==
X-Received: by 2002:a62:1ad0:0:b029:1f2:c7b3:3039 with SMTP id a199-20020a621ad00000b02901f2c7b33039mr14390664pfa.30.1617402570970;
        Fri, 02 Apr 2021 15:29:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c58:fab2:c5e2:f2d7])
        by smtp.gmail.com with ESMTPSA id t16sm9233094pfc.204.2021.04.02.15.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:29:30 -0700 (PDT)
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
Subject: [PATCH v3 04/12] drm/bridge: ti-sn65dsi86: Reorder remove()
Date:   Fri,  2 Apr 2021 15:28:38 -0700
Message-Id: <20210402152701.v3.4.Ifcf1deaa372eba7eeb4f8eb516c5d15b77a657a9@changeid>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210402222846.2461042-1-dianders@chromium.org>
References: <20210402222846.2461042-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make the remove() function strictly the reverse of the probe()
function so it's easier to reason about.

This patch was created by code inspection and should move us closer to
a proper remove.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---

Changes in v3:
- Removed "NOTES" from commit message.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 76f43af6735d..c006678c9921 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1315,20 +1315,21 @@ static int ti_sn_bridge_remove(struct i2c_client *client)
 	if (!pdata)
 		return -EINVAL;
 
-	kfree(pdata->edid);
-	ti_sn_debugfs_remove(pdata);
-
-	of_node_put(pdata->host_node);
-
-	pm_runtime_disable(pdata->dev);
-
 	if (pdata->dsi) {
 		mipi_dsi_detach(pdata->dsi);
 		mipi_dsi_device_unregister(pdata->dsi);
 	}
 
+	kfree(pdata->edid);
+
+	ti_sn_debugfs_remove(pdata);
+
 	drm_bridge_remove(&pdata->bridge);
 
+	pm_runtime_disable(pdata->dev);
+
+	of_node_put(pdata->host_node);
+
 	return 0;
 }
 
-- 
2.31.0.208.g409f899ff0-goog

