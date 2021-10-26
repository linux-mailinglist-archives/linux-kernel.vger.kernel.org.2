Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714A043A90A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhJZAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 20:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbhJZADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 20:03:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E190C061348
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:01:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 187so12450228pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8fBlAXi6sFYrXtAp7S0GQqlwZRRttRb1KFYpoiMF4WI=;
        b=lsr8K2a030rR0WfvezZcCFE1im2JtiNyOoBBVNT3ZzLz0QpGkEOgTqxRQLzMQySVcO
         5z0MWMfaXteKDv1SCA424nO791h6lLbvMPSHVDDlk+MuE1qDtbIXl7u0HizxUv5q6PiV
         sT5ZngUKTpX+KCzmIzo7JdHpKMFIEhgOs54yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8fBlAXi6sFYrXtAp7S0GQqlwZRRttRb1KFYpoiMF4WI=;
        b=nkGUElmA9K9RyHelDRs7RZ/dBwkMrsnqTmrU0JjQw1Atp4i6b5zk/5IUuUw6jYF1FE
         kwqYYWmseGPqCkx63D0eZz69sUL/tLWSzCoDqucLnGu5sjqqKMpp2sGQ3Y556cDq2n8h
         IEayPH1JypIc8Apu8gQyKQABSDlWMqPMSjQAFvvj1RvAXMCgypsqVUiYKqrLqucwAjHs
         +OCSiaF2P0+B9H0Zhrldo3XMNrsUCdo+k42jKG/OKysk4v1i4ZlTFLUe1Iq+SeiOfXEt
         J/iKrv0KdufFnh5Zv9mDnSxwJagqVGxWEQ49Dhlw4Yrj0qk/y8LWnXqFP8Kc76oSWqV9
         fZbw==
X-Gm-Message-State: AOAM532pkuI52L//icwK3e3NSfDtf7+XLUEOV72Q70zR2+OmGujeqN3A
        LElAbC9ScZ0vx9RGDWNWbHzzEQ==
X-Google-Smtp-Source: ABdhPJyr+Y42XiVJbe97WieMkIZF3lwI88q58uOwx49usBfS0ujaudFSbSSCCsC5/7Hh0FMIQghMKw==
X-Received: by 2002:a05:6a00:1681:b0:46f:6fc0:e515 with SMTP id k1-20020a056a00168100b0046f6fc0e515mr21771511pfc.11.1635206468058;
        Mon, 25 Oct 2021 17:01:08 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f5e3:5eb1:d5ee:6893])
        by smtp.gmail.com with ESMTPSA id b7sm9900747pfm.28.2021.10.25.17.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 17:01:07 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3 25/34] drm/vc4: Migrate to aggregate driver
Date:   Mon, 25 Oct 2021 17:00:35 -0700
Message-Id: <20211026000044.885195-26-swboyd@chromium.org>
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

Cc: Emma Anholt <emma@anholt.net>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index f6c16c5aee68..bccbde7a2f59 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -214,8 +214,9 @@ static void vc4_match_add_drivers(struct device *dev,
 	}
 }
 
-static int vc4_drm_bind(struct device *dev)
+static int vc4_drm_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm;
 	struct vc4_dev *vc4;
@@ -286,8 +287,9 @@ static int vc4_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void vc4_drm_unbind(struct device *dev)
+static void vc4_drm_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm = dev_get_drvdata(dev);
 
 	drm_dev_unregister(drm);
@@ -295,9 +297,13 @@ static void vc4_drm_unbind(struct device *dev)
 	drm_atomic_helper_shutdown(drm);
 }
 
-static const struct component_master_ops vc4_drm_ops = {
-	.bind = vc4_drm_bind,
-	.unbind = vc4_drm_unbind,
+static struct aggregate_driver vc4_aggregate_driver = {
+	.probe = vc4_drm_bind,
+	.remove = vc4_drm_unbind,
+	.driver = {
+		.name = "vc4_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 /*
@@ -328,12 +334,12 @@ static int vc4_platform_drm_probe(struct platform_device *pdev)
 	vc4_match_add_drivers(dev, &match,
 			      component_drivers, ARRAY_SIZE(component_drivers));
 
-	return component_master_add_with_match(dev, &vc4_drm_ops, match);
+	return component_aggregate_register(dev, &vc4_aggregate_driver, match);
 }
 
 static int vc4_platform_drm_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &vc4_drm_ops);
+	component_aggregate_unregister(&pdev->dev, &vc4_aggregate_driver);
 
 	return 0;
 }
-- 
https://chromeos.dev

