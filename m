Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913B63ADE60
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 14:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhFTM6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhFTM6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 08:58:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 05:56:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y14so444124pgs.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iML3X+LebYbUqiIruyQrVisHl+E/xyjft7hYS7VDy7I=;
        b=e8tvsQftsTNLUtKuaA2EpXy9VCg5x+v8pEWsQ/vBG7LLU7qU1FsYYONTdHXmSt66as
         oETD9VuIshmh3GLbtbZNtSBkqP3axHMFKdntbXaTDPN2GABSQHGlVnctayHu9bJ/Wndx
         4EJrVCuDsN7oeQYSmauOgkc+fLu9CfHQTuEYiWTVjkUVWhNR2TTyAZ08rdP11iUZ5LMw
         Y38HnQWd35H7LD2ug4IKwmbCf+MwMFHj/eL7M6Oa/EHPRDUA+IaoL1S9BJTU4EZU16up
         sy899nw5tadH62begMVgJMuESIg48eRN8OIGZxKj7G/LfuoHbU2dL0ZcJ9wI45IRXCY+
         3SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iML3X+LebYbUqiIruyQrVisHl+E/xyjft7hYS7VDy7I=;
        b=FWEvoO3dqhsZfBxmnWsF0zcP3sOl7glHPQ3KS5+C3cEgpW8MG4X3z/6FrUF7iePgvc
         6KA96ylkKinKNZ7hd2bhwYdj1WKGbGexgQUJLx1IFwEO8rIOb9Dyt7BaOMDbM5Q6vbfA
         dxK31vaEv5ikuS98oArPl89O/7O45somKS7O2W7PdrHZbeySWpitVtra4fxXAC/lIDS6
         +ZNVjxUue4EtxP8gvM6tI6rAeHT2bdAbUjjw8+ak0cp33fpBDOgzwAXVK4HtXLZzRiEP
         0kfIO8J4BRnDaQ4MKH7UJDuxPWl7yJlm96hFUHOSyBadNPdltj01BCJ+PRW26TCR/Wwo
         ykKg==
X-Gm-Message-State: AOAM533XE4zVomGKFve7X03swKEmECYVFTaQRnoJlrElGYNxGyB/Z2mc
        sm0u4bcShaDDyJ7o1yURppc=
X-Google-Smtp-Source: ABdhPJzkahBPxIIzFmiVpSwNGpcOXwxm5HsGFWd8NkHOWtAiXW9R+Z0u9Al8u/OwyA8MXNVk9HO+tQ==
X-Received: by 2002:a62:1c86:0:b029:2fe:b583:6418 with SMTP id c128-20020a621c860000b02902feb5836418mr14801744pfc.23.1624193759733;
        Sun, 20 Jun 2021 05:55:59 -0700 (PDT)
Received: from ojas ([122.177.154.120])
        by smtp.gmail.com with ESMTPSA id co18sm3812154pjb.37.2021.06.20.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 05:55:59 -0700 (PDT)
Date:   Sun, 20 Jun 2021 18:25:46 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     gregkh@linuxfoundation.org, stefan.wahren@i2se.com, arnd@arndb.de,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] staging: vchiq: Refactor vchiq cdev code
Message-ID: <e786f8c7f92561065b840490c32959932526dac6.1624185152.git.ojaswin98@gmail.com>
References: <cover.1624185152.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624185152.git.ojaswin98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the vchiq cdev initialization code to its own function for better
code organization. Call the initialization function during probe, thus
shifting the whole cdev creation logic (which was earlier split in
vchiq_probe() and vchiq_driver_init()) to vchiq_probe().

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 137 +++++++++++-------
 1 file changed, 87 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index a936102dbc34..f2d8116913f2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2207,6 +2207,81 @@ vchiq_fops = {
 	.read = vchiq_read
 };
 
+/**
+ *	vchiq_register_chrdev - Register the char driver for vchiq
+ *				and create the necessary class and
+ *				device files in userspace.
+ *	@parent		The parent of the char device.
+ *
+ *	Returns 0 on success else returns the error code.
+ */
+static int vchiq_register_chrdev(struct device *parent)
+{
+	struct device *vchiq_dev;
+	int ret;
+
+	vchiq_class = class_create(THIS_MODULE, DEVICE_NAME);
+	if (IS_ERR(vchiq_class)) {
+		pr_err("Failed to create vchiq class\n");
+		ret = PTR_ERR(vchiq_class);
+		goto error_exit;
+	}
+
+	ret = alloc_chrdev_region(&vchiq_devid, 0, 1, DEVICE_NAME);
+	if (ret) {
+		pr_err("vchiq: Failed to allocate vchiq's chrdev region\n");
+		goto alloc_region_error;
+	}
+
+	cdev_init(&vchiq_cdev, &vchiq_fops);
+	vchiq_cdev.owner = THIS_MODULE;
+	ret = cdev_add(&vchiq_cdev, vchiq_devid, 1);
+	if (ret) {
+		vchiq_log_error(vchiq_arm_log_level,
+				"Unable to register vchiq char device");
+		goto cdev_add_error;
+	}
+
+	vchiq_dev = device_create(vchiq_class, parent, vchiq_devid, NULL,
+				  DEVICE_NAME);
+	if (IS_ERR(vchiq_dev)) {
+		vchiq_log_error(vchiq_arm_log_level,
+				"Failed to create vchiq char device node");
+		ret = PTR_ERR(vchiq_dev);
+		goto device_create_error;
+	}
+
+	vchiq_log_info(vchiq_arm_log_level,
+		       "vchiq char dev initialised successfully - device %d.%d",
+			MAJOR(vchiq_devid), MINOR(vchiq_devid));
+
+	return 0;
+
+device_create_error:
+	cdev_del(&vchiq_cdev);
+
+cdev_add_error:
+	unregister_chrdev_region(vchiq_devid, 1);
+
+alloc_region_error:
+	class_destroy(vchiq_class);
+
+error_exit:
+	return ret;
+}
+
+/**
+ *	vchiq_deregister_chrdev	- Deregister and cleanup the vchiq char
+ *				  driver and device files
+ */
+static void vchiq_deregister_chrdev(void)
+{
+	device_destroy(vchiq_class, vchiq_devid);
+	cdev_del(&vchiq_cdev);
+	unregister_chrdev_region(vchiq_devid, 1);
+	class_destroy(vchiq_class);
+}
+
 /*
  * Autosuspend related functionality
  */
@@ -2740,7 +2815,6 @@ static int vchiq_probe(struct platform_device *pdev)
 	struct device_node *fw_node;
 	const struct of_device_id *of_id;
 	struct vchiq_drvdata *drvdata;
-	struct device *vchiq_dev;
 	int err;
 
 	of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
@@ -2766,28 +2840,18 @@ static int vchiq_probe(struct platform_device *pdev)
 	if (err)
 		goto failed_platform_init;
 
-	cdev_init(&vchiq_cdev, &vchiq_fops);
-	vchiq_cdev.owner = THIS_MODULE;
-	err = cdev_add(&vchiq_cdev, vchiq_devid, 1);
-	if (err) {
-		vchiq_log_error(vchiq_arm_log_level,
-			"Unable to register device");
-		goto failed_platform_init;
-	}
-
-	vchiq_dev = device_create(vchiq_class, &pdev->dev, vchiq_devid, NULL,
-				  "vchiq");
-	if (IS_ERR(vchiq_dev)) {
-		err = PTR_ERR(vchiq_dev);
-		goto failed_device_create;
-	}
-
 	vchiq_debugfs_init();
 
 	vchiq_log_info(vchiq_arm_log_level,
-		"vchiq: initialised - version %d (min %d), device %d.%d",
-		VCHIQ_VERSION, VCHIQ_VERSION_MIN,
-		MAJOR(vchiq_devid), MINOR(vchiq_devid));
+		       "vchiq: platform initialised - version %d (min %d)",
+		       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
+
+	/*
+	 * We don't handle error here since the function handles
+	 * cleanup in cases of failure. Further, we can proceed
+	 * even if this function fails.
+	 */
+	vchiq_register_chrdev(&pdev->dev);
 
 	vcsm_cma = vchiq_register_child(pdev, "vcsm-cma");
 	bcm2835_codec = vchiq_register_child(pdev, "bcm2835-codec");
@@ -2797,10 +2861,8 @@ static int vchiq_probe(struct platform_device *pdev)
 
 	return 0;
 
-failed_device_create:
-	cdev_del(&vchiq_cdev);
 failed_platform_init:
-	vchiq_log_warning(vchiq_arm_log_level, "could not load vchiq");
+	vchiq_log_warning(vchiq_arm_log_level, "could not initialize vchiq platform");
 	return err;
 }
 
@@ -2812,8 +2874,7 @@ static int vchiq_remove(struct platform_device *pdev)
 	platform_device_unregister(bcm2835_codec);
 	platform_device_unregister(vcsm_cma);
 	vchiq_debugfs_deinit();
-	device_destroy(vchiq_class, vchiq_devid);
-	cdev_del(&vchiq_cdev);
+	vchiq_deregister_chrdev();
 
 	return 0;
 }
@@ -2831,31 +2892,9 @@ static int __init vchiq_driver_init(void)
 {
 	int ret;
 
-	vchiq_class = class_create(THIS_MODULE, DEVICE_NAME);
-	if (IS_ERR(vchiq_class)) {
-		pr_err("Failed to create vchiq class\n");
-		return PTR_ERR(vchiq_class);
-	}
-
-	ret = alloc_chrdev_region(&vchiq_devid, 0, 1, DEVICE_NAME);
-	if (ret) {
-		pr_err("Failed to allocate vchiq's chrdev region\n");
-		goto class_destroy;
-	}
-
 	ret = platform_driver_register(&vchiq_driver);
-	if (ret) {
+	if (ret)
 		pr_err("Failed to register vchiq driver\n");
-		goto region_unregister;
-	}
-
-	return 0;
-
-region_unregister:
-	unregister_chrdev_region(vchiq_devid, 1);
-
-class_destroy:
-	class_destroy(vchiq_class);
 
 	return ret;
 }
@@ -2864,8 +2903,6 @@ module_init(vchiq_driver_init);
 static void __exit vchiq_driver_exit(void)
 {
 	platform_driver_unregister(&vchiq_driver);
-	unregister_chrdev_region(vchiq_devid, 1);
-	class_destroy(vchiq_class);
 }
 module_exit(vchiq_driver_exit);
 
-- 
2.25.1

