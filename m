Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685C9424718
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbhJFTlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbhJFTkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:40:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B31C0617A3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:38:47 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s11so3381236pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIr2Bk0QBgCC/Qyy7+5Gbgr8NQwlH0hHiIdNIEPo3fk=;
        b=bW+COjRtbI/s22IeVkOw6yQ870sBScBOBF2HCZngTnHoZtYsMfJOE0ofz7QpGYUlk3
         /Vl4JW5K0GR+OgSiaMKU5lJV6dRt4U31wvz3SUiHBWgysFRhZ3ohDMdS5R/FK46EaSrt
         S4SHBAHlZ/K2wI81ii8OutsoM1QQJfn2XGo/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIr2Bk0QBgCC/Qyy7+5Gbgr8NQwlH0hHiIdNIEPo3fk=;
        b=toi+WMJm48RirKWzbEpWnj89q82MWxi3FTfCNcGpeuTrMGeyd2MZyFx9UEZ9tiU1eI
         8UQfv/l+I5CbHvwA4rB/6v+e/Mj7wbHvsQLhKSPGxNkLQwcD4TueeVGSwGV/ARpOVXge
         19pKHMcA19oPeFmLkrq0+0q/HvFCkvzEC0A3SxYJpFyOq+CcJ1rJx9NFnv7fTqGdbUKc
         GGDknQzCQgrTbbRFDwqIkvqeMOuOwKB5aME1G/yQOLhuEUjPjpuWHKg+foEwuVtYmUo/
         Z1v1xHGFn0n5nEYubggmHg0mUOz4VG3FVpsBjeSoE2MAuaLHXVAmDmGS2+g9Nv/gh1oA
         IHkA==
X-Gm-Message-State: AOAM533IdofYA5wvMiyrPbLCuT2R7LzuBCuleP9lYf/Q6vDBWLcUdu6V
        XKaTZv86P5g/UZq/4BsfZ4NvCw==
X-Google-Smtp-Source: ABdhPJxQwqQ7SCmgtuHD6Kn2a24WTCagZcGpwIwgH0tFHMKyN3or9U6DNvjkc8eAzPbVbEHcBDoHvg==
X-Received: by 2002:a63:d709:: with SMTP id d9mr421671pgg.377.1633549127254;
        Wed, 06 Oct 2021 12:38:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:d412:c5eb:4aca:4738])
        by smtp.gmail.com with ESMTPSA id o14sm22011296pfh.84.2021.10.06.12.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:38:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2 21/34] drm/sti: Migrate to aggregate driver
Date:   Wed,  6 Oct 2021 12:38:06 -0700
Message-Id: <20211006193819.2654854-22-swboyd@chromium.org>
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

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/sti/sti_drv.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index c7efb43b83ee..b277cc679154 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -182,8 +182,9 @@ static void sti_cleanup(struct drm_device *ddev)
 	ddev->dev_private = NULL;
 }
 
-static int sti_bind(struct device *dev)
+static int sti_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *ddev;
 	int ret;
 
@@ -216,8 +217,9 @@ static int sti_bind(struct device *dev)
 	return ret;
 }
 
-static void sti_unbind(struct device *dev)
+static void sti_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *ddev = dev_get_drvdata(dev);
 
 	drm_dev_unregister(ddev);
@@ -225,9 +227,13 @@ static void sti_unbind(struct device *dev)
 	drm_dev_put(ddev);
 }
 
-static const struct component_master_ops sti_ops = {
-	.bind = sti_bind,
-	.unbind = sti_unbind,
+static struct aggregate_driver sti_aggregate_driver = {
+	.probe = sti_bind,
+	.remove = sti_unbind,
+	.driver = {
+		.name = "sti_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int sti_platform_probe(struct platform_device *pdev)
@@ -249,12 +255,12 @@ static int sti_platform_probe(struct platform_device *pdev)
 		child_np = of_get_next_available_child(node, child_np);
 	}
 
-	return component_master_add_with_match(dev, &sti_ops, match);
+	return component_aggregate_register(dev, &sti_aggregate_driver, match);
 }
 
 static int sti_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &sti_ops);
+	component_aggregate_unregister(&pdev->dev, &sti_aggregate_driver);
 
 	return 0;
 }
-- 
https://chromeos.dev

