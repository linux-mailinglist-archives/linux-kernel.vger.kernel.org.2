Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81AD43A903
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhJZAE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 20:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhJZAD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 20:03:29 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12A5C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:01:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l186so5844385pge.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3a3i/nDaB8ZUdNqJ4VU8hWXyXTL7/wWiLoMS1h5NiSM=;
        b=POKLqO9A5vFJYIMS8pDOGDNHrdvF+JGJ1RBptw04C+3ULsNNXEb8rzNes3OwQLycD9
         mK8PUPDvEmyMLAr5KMKceB9OAR/WBuFFTb6yYUkDXh/hFm6aNHjQZt3iaLddpIFN7kSB
         yIgyLMqUT295OnHqv8CSdmE6qYj2QfMN/v0nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3a3i/nDaB8ZUdNqJ4VU8hWXyXTL7/wWiLoMS1h5NiSM=;
        b=AAFmHovVg4CO0x8BD40oPPOwpWnkhYxvZQqAoP0zu3mnZS8zyf+hTSH3TdhQTRaYFZ
         pfNLDQ86MUxdke8W66fOJTy+3XOOTRLo1jselPj/wL2hfCJGeQz95FHQR8cY938S+FI5
         /m3RtfVHWS/K/Xy6blooq9A48R1kpW6N32ns61CMcU0I4pJ14f9AvGL07dU6JptFn8Yg
         haKvU7KpRLqGaSC4qnEbLh+ycb7QW16qfUPwVELQyOXjuCLNwlrmtER39dsbGFvr2wpx
         +x81AkcPAYMBPkuwGOq1DfLZisExE+7ENj523QDJtkU6L+3CK2pzFHwvVhfLArBfIyKL
         Jucw==
X-Gm-Message-State: AOAM530CeD9SRh74nSjq4kSAYAlz2KP561E6oVz2ISAJu6KFe8TqE0xT
        DYalk9pKu6kjjUP0a/g7P/XX2/bsQQI=
X-Google-Smtp-Source: ABdhPJwyghGp8z+hGwt4DgRUq0G8EmSQY+HM8pjy5c/TQQoyxw212WuajFfYIV51GIC8q/N6JFDdjw==
X-Received: by 2002:a05:6a00:14c6:b0:44d:4f03:78ff with SMTP id w6-20020a056a0014c600b0044d4f0378ffmr21882495pfu.13.1635206465460;
        Mon, 25 Oct 2021 17:01:05 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f5e3:5eb1:d5ee:6893])
        by smtp.gmail.com with ESMTPSA id b7sm9900747pfm.28.2021.10.25.17.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 17:01:05 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3 22/34] drm/sti: Migrate to aggregate driver
Date:   Mon, 25 Oct 2021 17:00:32 -0700
Message-Id: <20211026000044.885195-23-swboyd@chromium.org>
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

