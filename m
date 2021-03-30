Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6A34DED8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhC3CyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhC3CyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:54:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1061BC061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w10so6349117pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPXUOmfQRekvQeQvsP70z1DtiDzMfmRzBeh0Ag8UFxM=;
        b=OaZPcHG+xa8TmTWZTA0Hwp0y/rk+j9Ba1UMowY1egymnOB4p+aNxLcC2BSvqDs9q5q
         4alN2gzkfnk3Pm8vKeca7tvK6mDFvMGmm43+hA3Wj3N4MWwTz4FQMcOux+jyfjfXcW7v
         cVWAmDIe8H4TDNqiSVKQWU3ft/UkzrUp2AksE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPXUOmfQRekvQeQvsP70z1DtiDzMfmRzBeh0Ag8UFxM=;
        b=QzM0iGgZEBruNaMmNxwdd1GgME4W4/74mKW2BEY71D1//eVfvCi/ANOI4D3+MX3rpX
         APxMzjpBlOCdRT21uFCC7NBmmdJ3ky2CABC+F9+3Wp+RZZVy+jmmXRoKTcKYxJNzrPVX
         +kidHuCT9PFGOBR5UG21dbLdl6ccoJlR6t2cZe+uax9cAd1UYkKszg7FpQ1gdUbLBz8/
         DUzbQq1cg4jbAwylqQeJSE5F+ZL02+0BMl1VvDrqLZIL4U4NgXiWiyHRsOIqm+A6H/74
         gMxaxfWSEwewabnqVYJEIMaF4/uhz2CknejD6KlAoszRY2FIYAqReoaJEx16Qisg2FnL
         ht3Q==
X-Gm-Message-State: AOAM530loWzTLbqSwoS17vIK4zI0eJw92gp6+96dN53SSOf4kqBJVUHM
        otUNEnq6Bf6TnHPbnYFxkJ8cKw==
X-Google-Smtp-Source: ABdhPJzNB5xuvOvavd2lC2JLfMQFcwfveLVKJQBZBZzHvrCJVMqsfbDPgPl2Nyg9excKNq+Ek1sJvw==
X-Received: by 2002:a63:2265:: with SMTP id t37mr14590832pgm.452.1617072847654;
        Mon, 29 Mar 2021 19:54:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f599:1ca7:742d:6b50])
        by smtp.gmail.com with ESMTPSA id t17sm19152706pgk.25.2021.03.29.19.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:54:07 -0700 (PDT)
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
Subject: [PATCH v2 04/14] drm/bridge: ti-sn65dsi86: Reorder remove()
Date:   Mon, 29 Mar 2021 19:53:35 -0700
Message-Id: <20210329195255.v2.4.Ifcf1deaa372eba7eeb4f8eb516c5d15b77a657a9@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330025345.3980086-1-dianders@chromium.org>
References: <20210330025345.3980086-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make the remove() function strictly the reverse of the probe()
function so it's easier to reason about.

NOTES:
- The MIPI calls probably belong in detach() but will be moved in a
  separate patch.
- The cached EDID freeing isn't actually part of probe but needs to be
  in remove to avoid orphaning memory until better handling of the
  EDID happens.

This patch was created by code inspection and should move us closer to
a proper remove.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

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
2.31.0.291.g576ba9dcdaf-goog

