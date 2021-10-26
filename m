Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C6A43A8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhJZAEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 20:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbhJZADV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 20:03:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9AC061224
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:00:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s136so12300819pgs.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+fM2dIjOxE0hdJ7o5inMEoSl4k+Dtn8hCQbdOli+o8=;
        b=WK1ox2oRHtuob3v/ROgeEhC1PVQBBzfwdp0Vcx+Dzp3pUstlggErRUG3DVNU3uE2n/
         vRNQwS26UtVE2R4pJjjbJxrVBD1WGWrU9P20RfSOtE5t14iUTUOVyJjOi4BSBgmP69U+
         Wx41UMi8X3CGf7P7D+FfisrIp491w2OHpPdzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+fM2dIjOxE0hdJ7o5inMEoSl4k+Dtn8hCQbdOli+o8=;
        b=4yD1wTFtHeC2t4CPG8uoa2SP587tdz5KQ/UV73Rb53Pmdl5ZdHmFpzFnXiE5wIZhsJ
         888oc9bU9HoVQKidqtv0SLe6A6BLt9PUAUjKh+6fBfBcV56jTYzwg2jbKhgBvVzYbLp4
         odgZV1Q3crl6BEQh2tunH3V0dbscw8Me/Uq3BUHXS5A2KOBri+h3A8Q7tIazQKuD7aEy
         8suFWATP4c50GYu5S2I3MCwS5OTuhNsczi5tyv2YnqYMwHhVJGiSppwoN2aUbowJATWJ
         R1wsQ6CRuRBg8ZDviWtnagRACkvWQioqf+pJpL/T9FkcmxUKgPyIjIZqe21uvrzAlHxy
         QUrA==
X-Gm-Message-State: AOAM530qnbQTINdi9W+DRqu9l0I13yt73AnTJ42XQzISGnCvcRkhGMK1
        MXJTdcsZSCDHdeSZWLVfh579GA==
X-Google-Smtp-Source: ABdhPJyAH+KqK4V7Wo1bh2UQ9/xYGJyYJ5MoNL/eKeZvWyDr56giKqwSJvUB9ld4uN59VRUEoCXXxw==
X-Received: by 2002:a62:2944:0:b0:44d:b731:4228 with SMTP id p65-20020a622944000000b0044db7314228mr21635086pfp.9.1635206457831;
        Mon, 25 Oct 2021 17:00:57 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f5e3:5eb1:d5ee:6893])
        by smtp.gmail.com with ESMTPSA id b7sm9900747pfm.28.2021.10.25.17.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 17:00:57 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3 13/34] drm/kirin: Migrate to aggregate driver
Date:   Mon, 25 Oct 2021 17:00:23 -0700
Message-Id: <20211026000044.885195-14-swboyd@chromium.org>
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

Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Tian Tao <tiantao6@hisilicon.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 98ae9a48f3fe..00d47c784cbb 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -217,8 +217,9 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 	return 0;
 }
 
-static int kirin_drm_bind(struct device *dev)
+static int kirin_drm_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct kirin_drm_data *driver_data;
 	struct drm_device *drm_dev;
 	int ret;
@@ -253,8 +254,9 @@ static int kirin_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void kirin_drm_unbind(struct device *dev)
+static void kirin_drm_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	drm_dev_unregister(drm_dev);
@@ -262,9 +264,13 @@ static void kirin_drm_unbind(struct device *dev)
 	drm_dev_put(drm_dev);
 }
 
-static const struct component_master_ops kirin_drm_ops = {
-	.bind = kirin_drm_bind,
-	.unbind = kirin_drm_unbind,
+static struct aggregate_driver kirin_drm_aggregate_driver = {
+	.probe = kirin_drm_bind,
+	.remove = kirin_drm_unbind,
+	.driver = {
+		.name = "kirin_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int kirin_drm_platform_probe(struct platform_device *pdev)
@@ -281,12 +287,12 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	drm_of_component_match_add(dev, &match, compare_of, remote);
 	of_node_put(remote);
 
-	return component_master_add_with_match(dev, &kirin_drm_ops, match);
+	return component_aggregate_register(dev, &kirin_drm_aggregate_driver, match);
 }
 
 static int kirin_drm_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &kirin_drm_ops);
+	component_aggregate_unregister(&pdev->dev, &kirin_drm_aggregate_driver);
 	return 0;
 }
 
-- 
https://chromeos.dev

