Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFC42472B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbhJFTlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbhJFTlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:41:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D192BC061778
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:38:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k23-20020a17090a591700b001976d2db364so3226805pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0lZGXHwPviChh1qGaLbcibaQ5KdksPeQeI4kBQa+kk=;
        b=TWus5/+6G/7YPt/GYoLcEu98qL5WELx1WPPHt5rZgDYPi4TbXobioa/gZGAS2oFH2d
         CggOtJzqHj0w6B0PZ7xsOVu8wltF24F6za7fdU5ieL6CQKheeChKFXLcIWyeHcY9g1IZ
         F9kMdlqVsqS+TSe+pEn2ZiG+iUNaQ5zApt9tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0lZGXHwPviChh1qGaLbcibaQ5KdksPeQeI4kBQa+kk=;
        b=vDNJloxXKI/SqeRrgIShfPN5WcZhJhnMiCRTHRoQvXnt9iopvj1LGWzjFroOyl65YC
         O9MhgJ2QUOih6H9n8KZRJSjvEXzE5dekJqpOBiCMTUK7GjhzSvxSYp54+Pgs+QjMc94G
         HqH4r+9ye5C7KLBshSEdfZHZQA6hhLnA863ur8A02l3kp9QZqbCjjrGBuvYWvoImtTZA
         a4xEBiifa2KLRD2kmj4+TqljpFNTNJuitYKUiMv6FMYcdV9Qcmewh//TnEYQUF7aBdXs
         MCRSLMuAhM/4xWkzKqNe0aCcKsWXsO9SptmfmGB8g3CiHeMTy/XZ5tKL//LhYzztm0dh
         Ygag==
X-Gm-Message-State: AOAM530w0teuD4/fRFeBA4p8qfdGSOYEsYL/JCieJqO5EtOHflycvtZk
        vAhNFQNh4Hh0NM+dYlbakxJUbw==
X-Google-Smtp-Source: ABdhPJw37huVc8Sl+jtSnZOt9wzTLpKJ426qHi4wEQ0jLRRR2Whgp9Qug67BtUn2e1soscFp4V2jhA==
X-Received: by 2002:a17:90b:2503:: with SMTP id ns3mr643045pjb.206.1633549132258;
        Wed, 06 Oct 2021 12:38:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:d412:c5eb:4aca:4738])
        by smtp.gmail.com with ESMTPSA id o14sm22011296pfh.84.2021.10.06.12.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:38:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2 25/34] drm/zte: Migrate to aggregate driver
Date:   Wed,  6 Oct 2021 12:38:10 -0700
Message-Id: <20211006193819.2654854-26-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211006193819.2654854-1-swboyd@chromium.org>
References: <20211006193819.2654854-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/zte/zx_drm_drv.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
index 064056503ebb..b46f677ea51d 100644
--- a/drivers/gpu/drm/zte/zx_drm_drv.c
+++ b/drivers/gpu/drm/zte/zx_drm_drv.c
@@ -45,8 +45,9 @@ static const struct drm_driver zx_drm_driver = {
 	.minor = 0,
 };
 
-static int zx_drm_bind(struct device *dev)
+static int zx_drm_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm;
 	int ret;
 
@@ -97,8 +98,9 @@ static int zx_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void zx_drm_unbind(struct device *dev)
+static void zx_drm_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm = dev_get_drvdata(dev);
 
 	drm_dev_unregister(drm);
@@ -110,9 +112,13 @@ static void zx_drm_unbind(struct device *dev)
 	drm_dev_put(drm);
 }
 
-static const struct component_master_ops zx_drm_master_ops = {
-	.bind = zx_drm_bind,
-	.unbind = zx_drm_unbind,
+static struct aggregate_driver zx_aggregate_driver = {
+	.probe = zx_drm_bind,
+	.remove = zx_drm_unbind,
+	.driver = {
+		.name = "zx_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int compare_of(struct device *dev, void *data)
@@ -135,12 +141,12 @@ static int zx_drm_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(parent, child)
 		component_match_add(dev, &match, compare_of, child);
 
-	return component_master_add_with_match(dev, &zx_drm_master_ops, match);
+	return component_aggregate_register(dev, &zx_aggregate_driver, match);
 }
 
 static int zx_drm_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &zx_drm_master_ops);
+	component_aggregate_unregister(&pdev->dev, &zx_aggregate_driver);
 	return 0;
 }
 
-- 
https://chromeos.dev

