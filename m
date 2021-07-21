Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777F03D13FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhGUPk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhGUPk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:40:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A41C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:21:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p36so2566893pfw.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOMlhnPS9Nt4DVyaFyvYG80jB8+C7ONbrQ+seug7Wxg=;
        b=cGuTawm7QzPgnDQ2S2lBhfqZe2oQT9RclM2l7wFOT5+bpRX12HXvpkz0fOQEj25Iyx
         opfFHWp6wCsCs+sQnYt6yOr87OncONaTi0vjLveXVMTs5r1BmPUPcoKgGK+f8gWrHIbH
         QMwYpV1T5pGKvivnwzOhI6rjT7HLFTSEvVOpNlcextvJUZY9nr3tK3CYwMTNPVBkfjGV
         etCpEvnfKPcaGbOKEWlxcyVb3MFo9sfjuVx+zT+hqLye5VJ+yjoQwtR6jk3BxVE5G2Hu
         AByCG+kUKczOweJxiYnVQlOT7CAtQMDl2HWRTAGLDnZFi+XYPBf8Yjye5FwAcwbj7ZRs
         +/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOMlhnPS9Nt4DVyaFyvYG80jB8+C7ONbrQ+seug7Wxg=;
        b=F9NBZ8G+RYdMXm32L94nKqfgzIhUAw9Udw15IGfs67BSNfrLdNoc/UFi83r8FzTAiG
         ivty6zaAkJuc23rr7EvdM1Y9L5DQKO5+TlmjmeyFDnCWp2u/tgj/KlWkAaKt7omD0AIf
         OXA51y8qwrxmqRIsoMq3KWFa96Jz/nHILsA8XyQge86V2bfIC8BNeVV+dOzN5uE3sNDU
         cgY7yB8bFrIsEIfdwm11DsHnGUN+Ks008NpN7pb4eubxKqeXq7qU5qlM4wGnPrtYMNyM
         0JrJyBVfPWleywcYNeDUwQ0X37qy23XTRtkhApn6chgF9F3ZGn/6joSOXh6roRsbt2x3
         9Zug==
X-Gm-Message-State: AOAM533FhRG4xZNdK2Cnt5rtlYdHxMV7kXH2qyBDEDJHm+sEY9C7CkQS
        PEDwS4TSBTC47lGoOQRd5VA=
X-Google-Smtp-Source: ABdhPJz2QB5nHumrbYyy3ah2q6gjwwnlawyUVfc7Gphimka9Abw7k+TFrgpDGF+ODFl8jkdfuPRO3Q==
X-Received: by 2002:a63:3107:: with SMTP id x7mr28440504pgx.303.1626884495202;
        Wed, 21 Jul 2021 09:21:35 -0700 (PDT)
Received: from localhost.localdomain ([122.161.48.33])
        by smtp.googlemail.com with ESMTPSA id s21sm3013459pfw.69.2021.07.21.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:21:34 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     Ojaswin Mujoo <ojaswin98@gmail.com>, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, dan.carpenter@oracle.com,
        phil@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] staging: vchiq: Refactor vchiq cdev code
Date:   Wed, 21 Jul 2021 21:50:49 +0530
Message-Id: <c0e538eb0644292a52267d39edd85ab2af9f9a4e.1626882325.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626882325.git.ojaswin98@gmail.com>
References: <cover.1626882325.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the vchiq cdev initialization code to its own function for better
code organization. Call the initialization function during probe, thus
shifting the whole cdev creation logic (which was earlier split in
vchiq_probe() and vchiq_driver_init()) to vchiq_probe().

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 142 ++++++++++++------
 1 file changed, 92 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index b5aac862a298..3a0724fe25ea 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2134,6 +2134,81 @@ vchiq_fops = {
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
@@ -2644,7 +2719,6 @@ static int vchiq_probe(struct platform_device *pdev)
 	struct device_node *fw_node;
 	const struct of_device_id *of_id;
 	struct vchiq_drvdata *drvdata;
-	struct device *vchiq_dev;
 	int err;
 
 	of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
@@ -2670,38 +2744,31 @@ static int vchiq_probe(struct platform_device *pdev)
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
+	 * Simply exit on error since the function handles cleanup in
+	 * cases of failure.
+	 */
+	err = vchiq_register_chrdev(&pdev->dev);
+	if (err) {
+		vchiq_log_warning(vchiq_arm_log_level,
+				  "Failed to initialize vchiq cdev");
+		goto error_exit;
+	}
 
 	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
 	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
 
 	return 0;
 
-failed_device_create:
-	cdev_del(&vchiq_cdev);
 failed_platform_init:
-	vchiq_log_warning(vchiq_arm_log_level, "could not load vchiq");
+	vchiq_log_warning(vchiq_arm_log_level, "could not initialize vchiq platform");
+error_exit:
 	return err;
 }
 
@@ -2710,8 +2777,7 @@ static int vchiq_remove(struct platform_device *pdev)
 	platform_device_unregister(bcm2835_audio);
 	platform_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
-	device_destroy(vchiq_class, vchiq_devid);
-	cdev_del(&vchiq_cdev);
+	vchiq_deregister_chrdev();
 
 	return 0;
 }
@@ -2729,31 +2795,9 @@ static int __init vchiq_driver_init(void)
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
@@ -2762,8 +2806,6 @@ module_init(vchiq_driver_init);
 static void __exit vchiq_driver_exit(void)
 {
 	platform_driver_unregister(&vchiq_driver);
-	unregister_chrdev_region(vchiq_devid, 1);
-	class_destroy(vchiq_class);
 }
 module_exit(vchiq_driver_exit);
 
-- 
2.25.1

