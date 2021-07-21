Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2693D1402
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhGUPlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhGUPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:41:14 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2457AC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:21:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id a6so2387834pgw.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YhBSpMPkjoprm5QHl3l72iyxSfWeqUMApb6I6Ek3Uc=;
        b=linJ0O7VC0Exf6xqQ2Vlv4OisfLD/u3BjblB2pG25Gpo3N7vLIgR6fO4BT1hifkUdy
         e3NlPsaBmJo+XyDvLtKP43w+T4oJaPcu3KLvzja+GQeuyhml0XbYnM/aW5sK8auDWRoo
         JkZ2ExKFxrz+RNH5rS06Tib/37gR3+rWIwx+dxsIB+huPJqQVo5bMaE03TIMa1pvhC0c
         93sTMdyTXiUGtjooTzNJBEYM1gs2KOIU3NVFd70FBgVG9/ivk7bvM0NtbnpYaVYjkDvs
         goSNOtzaJiVajPewn6aWMnWy6SpG2v0qzYFJwHoshmy8JfUISe4kS2yN0k6OvqS9FbUv
         iHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YhBSpMPkjoprm5QHl3l72iyxSfWeqUMApb6I6Ek3Uc=;
        b=KJgAcftyKTd0eDh65P7+IuTmq7RAvQfCgmiVJNRVBNAO6X3t6MOVUePmXjh30RMsHc
         uG2aacz6bWhq+zFdWdvxlw6N5YmjGnFWwwvIM9eCItEemlFqz1c3wPsKBZbuKUgdl40q
         0+MNslxUPSQD6VXngSUwTe1lHQmdvalrMI0XaatU6pqIqxraKIURB153KOArjZ+jp9/N
         /HiD17Tst4e/iSYSMM4+FXAS228kL4DBWa3HEheKtXQBRTyvoHVvRTmTX7cEPbBPUA7f
         t2kNtwM4aT2+uEl3l0xyBYHU0UeevnaxjfVOXZsUcJwuOQ0Xgx+N0bAkpNPk1CSCVoUK
         oG8w==
X-Gm-Message-State: AOAM533MTkc17VJDxegCvkTNN9WePsIuCtDxxUt41+hqkUxLP2jYbUqP
        DTtYEk9fuvH0GHrOmndSypw=
X-Google-Smtp-Source: ABdhPJysHGkEZZfjArGvmcX1gUACwVayjsOpzEzNTpX7BYeTLdrzHtoPHysXUfwyaVYsJQpyXEvB6A==
X-Received: by 2002:a05:6a00:1692:b029:300:7193:f67 with SMTP id k18-20020a056a001692b029030071930f67mr37257534pfc.19.1626884510752;
        Wed, 21 Jul 2021 09:21:50 -0700 (PDT)
Received: from localhost.localdomain ([122.161.48.33])
        by smtp.googlemail.com with ESMTPSA id s21sm3013459pfw.69.2021.07.21.09.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:21:50 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     Ojaswin Mujoo <ojaswin98@gmail.com>, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, dan.carpenter@oracle.com,
        phil@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] staging: vchiq: Make creation of vchiq cdev optional
Date:   Wed, 21 Jul 2021 21:50:52 +0530
Message-Id: <846c424dd4aae14d1cc28c8f30877a06e2b7dd10.1626882325.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626882325.git.ojaswin98@gmail.com>
References: <cover.1626882325.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this commit, vchiq cdev (/dev/vchiq) was always created during
platform initialization. Introduce a new Kconfig option
CONFIG_VCHIQ_CDEV which determines if the cdev will be created or not.

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/vc04_services/Kconfig                  | 10 ++++++++++
 drivers/staging/vc04_services/Makefile                 |  5 ++++-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h      |  9 +++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index 4b886293f198..63caa6818d37 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -19,6 +19,16 @@ config BCM2835_VCHIQ
 		Defaults to Y when the Broadcom Videocore services
 		are included in the build, N otherwise.
 
+if BCM2835_VCHIQ
+
+config VCHIQ_CDEV
+	bool "VCHIQ Character Driver"
+	help
+		Enable the creation of VCHIQ character driver to help
+		communicate with the Videocore platform.
+
+endif
+
 source "drivers/staging/vc04_services/bcm2835-audio/Kconfig"
 
 source "drivers/staging/vc04_services/bcm2835-camera/Kconfig"
diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index db28be341239..0a04338fc962 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -7,7 +7,10 @@ vchiq-objs := \
    interface/vchiq_arm/vchiq_2835_arm.o \
    interface/vchiq_arm/vchiq_debugfs.o \
    interface/vchiq_arm/vchiq_connected.o \
-   interface/vchiq_arm/vchiq_dev.o \
+
+ifdef CONFIG_VCHIQ_CDEV
+vchiq-objs += interface/vchiq_arm/vchiq_dev.o
+endif
 
 obj-$(CONFIG_SND_BCM2835)		+= bcm2835-audio/
 obj-$(CONFIG_VIDEO_BCM2835)		+= bcm2835-camera/
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 2453971b6b78..e8e39a154c74 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -174,12 +174,21 @@ vchiq_instance_get_trace(struct vchiq_instance *instance);
 extern void
 vchiq_instance_set_trace(struct vchiq_instance *instance, int trace);
 
+#if IS_ENABLED(CONFIG_VCHIQ_CDEV)
+
 extern void
 vchiq_deregister_chrdev(void);
 
 extern int
 vchiq_register_chrdev(struct device *parent);
 
+#else
+
+static inline void vchiq_deregister_chrdev(void) { }
+static inline int vchiq_register_chrdev(struct device *parent) { return 0; }
+
+#endif /* IS_ENABLED(CONFIG_VCHIQ_CDEV) */
+
 extern enum vchiq_status
 service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 		 unsigned int handle, void *bulk_userdata);
-- 
2.25.1

