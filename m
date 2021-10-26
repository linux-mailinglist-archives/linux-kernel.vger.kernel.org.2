Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4E43A8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhJZAEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 20:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbhJZADX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 20:03:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D913FC061243
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:01:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so12292620pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InGYSc3cNsqSsbEpZp55brWuJhvXfCPzOPufF1ln430=;
        b=n27nI7U1DJDvZP2a3K1XXE0Ongz64Cp5hXkiNgMSat5fEPQ3vu1a75vTaQO3+pnmyg
         STl3OLtEq/SmPIKsXzKjPLBmUSWixbG6f0RdS7Vj1YqGvA8qSFXroU2wrN6ON8KMmdV1
         dvpfHtKuA3jb1u8Ybs8VnD+AxNg5h7KdZdi80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InGYSc3cNsqSsbEpZp55brWuJhvXfCPzOPufF1ln430=;
        b=gVIZowDBuuN1CeCG3sCc8x6bTGlxf8O8w/3x3Ifnm6ExncRNBPyX5VGYyYcqIfv/0u
         2XKGdUe5RYuv8RgPjNbXmjWwS8lFR9xUtvSp7UTW/BBRSbmVUW4JA/6yEbW1rl/GFiER
         vSD4wSCdI6NNjE0IJ2KcUmNyDwQcGLbOp9ig/YySjUl9rAguC77cj0tWT2TAwtNQ1ILB
         SPzXsu60xV6v//jrA3BlU84j2anIDh6PcVKVq0ZpZeDVN6ZY2G8JbzAWsoW7Ib+R4cpl
         3Oc81qaY/4Ajfljl0Nx4A1Y6e1alwxXrOTmz+ZD/opfpT7zcyMcGZtLhfN8r12J1oFJ4
         4RHw==
X-Gm-Message-State: AOAM530CoL9NcO6ddFLSMKFyyJ7WA4LwLMXuLKTan0meUSsuiFAGcNwt
        bwnOKHOZz9Fb1vYBDyB5/ZUC/A==
X-Google-Smtp-Source: ABdhPJzBCB5bMmUBbXNr4wciflM9/CME0NZFkIWd6rATCTqyyK//e8axZDkYIIE/ogy93mtehtTDgw==
X-Received: by 2002:a63:3f8f:: with SMTP id m137mr3065948pga.279.1635206460430;
        Mon, 25 Oct 2021 17:01:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f5e3:5eb1:d5ee:6893])
        by smtp.gmail.com with ESMTPSA id b7sm9900747pfm.28.2021.10.25.17.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 17:01:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Paul Cercueil <paul@crapouillou.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3 16/34] drm/ingenic: Migrate to aggregate driver
Date:   Mon, 25 Oct 2021 17:00:26 -0700
Message-Id: <20211026000044.885195-17-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211026000044.885195-1-swboyd@chromium.org>
References: <20211026000044.885195-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

TODO: Move the helpers to PM in aggregate driver hooks.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 25 +++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index a5df1c8d34cd..d5330fb486e8 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1150,8 +1150,10 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	return ret;
 }
 
-static int ingenic_drm_bind_with_components(struct device *dev)
+static int ingenic_drm_bind_with_components(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
+
 	return ingenic_drm_bind(dev, true);
 }
 
@@ -1174,9 +1176,20 @@ static void ingenic_drm_unbind(struct device *dev)
 	drm_atomic_helper_shutdown(&priv->drm);
 }
 
-static const struct component_master_ops ingenic_master_ops = {
-	.bind = ingenic_drm_bind_with_components,
-	.unbind = ingenic_drm_unbind,
+static void ingenic_aggregate_remove(struct aggregate_device *adev)
+{
+	struct device *dev = adev->parent;
+
+	ingenic_drm_unbind(dev);
+}
+
+static struct aggregate_driver ingenic_aggregate_driver = {
+	.probe = ingenic_drm_bind_with_components,
+	.remove = ingenic_aggregate_remove,
+	.driver = {
+		.name = "ingenic_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int ingenic_drm_probe(struct platform_device *pdev)
@@ -1196,7 +1209,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	drm_of_component_match_add(dev, &match, compare_of, np);
 	of_node_put(np);
 
-	return component_master_add_with_match(dev, &ingenic_master_ops, match);
+	return component_aggregate_register(dev, &ingenic_aggregate_driver, match);
 }
 
 static int ingenic_drm_remove(struct platform_device *pdev)
@@ -1206,7 +1219,7 @@ static int ingenic_drm_remove(struct platform_device *pdev)
 	if (!IS_ENABLED(CONFIG_DRM_INGENIC_IPU))
 		ingenic_drm_unbind(dev);
 	else
-		component_master_del(dev, &ingenic_master_ops);
+		component_aggregate_unregister(dev, &ingenic_aggregate_driver);
 
 	return 0;
 }
-- 
https://chromeos.dev

