Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79B362B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhDPWlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhDPWlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB18C061761
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:40:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a12so19258128pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lu8AkZNDWlNH1fxgO+EV43zlL49xIkQqM7cXQa1E70s=;
        b=boe3GraedXsJgeS77vtR2rV2V7UGXCxUaQcxH1b5+AOfv4z1Z27hGPMn2tDe6fhRsn
         hvDtUo57zkdiGiJELJycymBwSweYrtJbTs6zoLwzgHftJlJQKjMQ99dXQxfQhkhTjAAh
         u9n+/dhH6qEfJPbCP0XrOfmurcTC84gRst7uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lu8AkZNDWlNH1fxgO+EV43zlL49xIkQqM7cXQa1E70s=;
        b=Th245HaPQQ+NQ2TOjJH+vKjghCqShOO2+t85SRw5qAjLT5tHjYN14SESIHBFf+XRna
         KJ0a4CXjZtZJjMlcD15XbOeOBkok22wO89ssZC5pCFuA2e6AkjXgUSXGFfmhcWPxjoSE
         R5CfgC+LmPh8pm0tAU8DcE9QrTs4F83aRaxDhXXtfB3+Gf9kGiiJb4OGL3fSKpDK0S9S
         v5TABc/7YuuSuZqwLN0rcqgD+3m0RbiITGc8UTkYbLBQewm0xFCUxKNEngh8RNTiz1ir
         byUyL0u7h6KHzefe16okJz0NfP0Jcn4hHT6wTtYu+9BnqOz1DTZyus7yvmdEaTaFWSdQ
         b5yQ==
X-Gm-Message-State: AOAM531kk75tCrmG0MIxEED90ge6EgW+RNJpSQmPCnVWf04HkRzWvRg/
        JhVT3D54zdNVanBCPo7LWQYvEA==
X-Google-Smtp-Source: ABdhPJyTDqtz7UW4GkJ3AlSBpIPnxOnqUox/SqIrqnGsonE9KjngvVcmJxuRuSYBWLmdJQvyT8RIIg==
X-Received: by 2002:aa7:904b:0:b029:250:991e:315 with SMTP id n11-20020aa7904b0000b0290250991e0315mr9708738pfo.70.1618612857697;
        Fri, 16 Apr 2021 15:40:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:40:57 -0700 (PDT)
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/27] drm/bridge: ti-sn65dsi86: Reorder remove()
Date:   Fri, 16 Apr 2021 15:39:27 -0700
Message-Id: <20210416153909.v4.4.Ifcf1deaa372eba7eeb4f8eb516c5d15b77a657a9@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

(no changes since v3)

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
2.31.1.368.gbe11c130af-goog

