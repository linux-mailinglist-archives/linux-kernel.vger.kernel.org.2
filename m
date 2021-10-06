Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD014246D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbhJFTkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbhJFTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:40:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D58C061767
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:38:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s16so3334683pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdKC3RDnWMeVhqBKuTAcfq/eZBHYEe2Kb+X7ix5SdpY=;
        b=bYXZrb2Mw0ygA/9KQUszZR0D4+fBHb1MS2IAeBPCv5THUvbkeF9CzMvcUArorOxTAK
         B1HrTvXihaUQeWiLQvL+0lEMneUWKCwMfy/POUvBJf8ELzE+zKDqutR6eEmcX2r97Guc
         Uv7Q5lG6rFPLy8WnQ5GTASLWbtTQ5A00scm0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdKC3RDnWMeVhqBKuTAcfq/eZBHYEe2Kb+X7ix5SdpY=;
        b=Vj48YTJX2Mk3dIoL2c/B5mZPy9BuQhznZkXEcHKHKCXldiP6ZN+oz+fqG9zlEb40l1
         QaAtXexHcLNBohu3ekwEYZ7JBsJb0ukNVLatToKqIIvx/j/FHIMWmqTwxkTXxjq77pdD
         8Evvox8QVaxj0E/mfC5KJbraBDzVbXrPBUPE0tsxBxyZQTrvPMK0fiOogcRP6dr9K95y
         HavxLvRx60CGwxBZiyhy+6vamtLZGEZFTrJtQuCB7ySOXSZxVBqYIoANgEC5Ny89GDtg
         Lwuyb+FNIaoVGh5bD6t0/KJkZGDipAKahas4bUZoGJ+PGXw0jNn1hgmNrdnp7n6HrXuH
         tROQ==
X-Gm-Message-State: AOAM530insuFUQWerw3FnNV649zwa6p26ryfnu7fxXXEw/9sD/GZP0YH
        CjUhW7U1vNDzDjiWDBw8wA39ATObYpzgrQ==
X-Google-Smtp-Source: ABdhPJyQxcu7a9c6zJ5OPG0sbw5QtjSSLjEp7prUkIluddBHbCR+Nhq+ATnHLHRc/o8nEL0u0iy0bg==
X-Received: by 2002:a63:2022:: with SMTP id g34mr433631pgg.173.1633549111054;
        Wed, 06 Oct 2021 12:38:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:d412:c5eb:4aca:4738])
        by smtp.gmail.com with ESMTPSA id o14sm22011296pfh.84.2021.10.06.12.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:38:30 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        James Qian Wang <james.qian.wang@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2 07/34] drm/komeda: Migrate to aggregate driver
Date:   Wed,  6 Oct 2021 12:37:52 -0700
Message-Id: <20211006193819.2654854-8-swboyd@chromium.org>
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

Cc: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index e7933930a657..0463386a6ed2 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -25,8 +25,9 @@ struct komeda_dev *dev_to_mdev(struct device *dev)
 	return mdrv ? mdrv->mdev : NULL;
 }
 
-static void komeda_unbind(struct device *dev)
+static void komeda_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct komeda_drv *mdrv = dev_get_drvdata(dev);
 
 	if (!mdrv)
@@ -45,8 +46,9 @@ static void komeda_unbind(struct device *dev)
 	devm_kfree(dev, mdrv);
 }
 
-static int komeda_bind(struct device *dev)
+static int komeda_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct komeda_drv *mdrv;
 	int err;
 
@@ -87,9 +89,13 @@ static int komeda_bind(struct device *dev)
 	return err;
 }
 
-static const struct component_master_ops komeda_master_ops = {
-	.bind	= komeda_bind,
-	.unbind	= komeda_unbind,
+static struct aggregate_driver komeda_aggregate_driver = {
+	.probe	= komeda_bind,
+	.remove	= komeda_unbind,
+	.driver = {
+		.name  = "komeda_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int compare_of(struct device *dev, void *data)
@@ -129,12 +135,12 @@ static int komeda_platform_probe(struct platform_device *pdev)
 		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 1);
 	}
 
-	return component_master_add_with_match(dev, &komeda_master_ops, match);
+	return component_aggregate_register(dev, &komeda_aggregate_driver, match);
 }
 
 static int komeda_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &komeda_master_ops);
+	component_aggregate_unregister(&pdev->dev, &komeda_aggregate_driver);
 	return 0;
 }
 
-- 
https://chromeos.dev

