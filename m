Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568CD3BADBA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhGDQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 12:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhGDQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 12:02:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25A6C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 08:59:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i184so1156483pfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/YhBSpMPkjoprm5QHl3l72iyxSfWeqUMApb6I6Ek3Uc=;
        b=dyb9LU5AzNMpP1x/4ATULiORuPdljhKLCb5A9rtNjNThg1zwVWNcFQb2SKXXWCNgEr
         M3Z5bJGFa4u6Pnm9xuW1z0+DAjhDKGfDKCUVIruuUmUmtcjwB8/MskUjOHgoPGr0lhAB
         CJBf+Vgbn134bKa9ELiSjyVkTUiNzOXIVpZSu+YIXaGPaMyO4wK6rcozdB5wT/DJf9Bx
         01AvD+zACHgdh406+0j2ee53i+/SzIimsFogqBJdeRDL5JtoGk3hl3frViuBUd8sp+9W
         NyenvEZ6yn6hQcVojSqrK9fAxLDfnnhSC9Grr+cbe7trpr22WgGHSNmzFFsCs6Bxijuq
         QI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/YhBSpMPkjoprm5QHl3l72iyxSfWeqUMApb6I6Ek3Uc=;
        b=NiZ2QCY+GUM77CZzyG3D1fLchBxQJ5lgYJt5WcNYTyl+DybrcLusX3h3m+BpTgsKBV
         +Jj5PZPYTceUoMMc5EJL0Gk/R02phxQ7kZLKFEuJC3sg5e0VsCAUO5pR7Kpj9rCtTfS8
         tGTC1874KQowTaf9FvARf/X9AobmjrVTH7eiBCse7XS6afj/GV7I3fmq/baPA6FVWhEX
         CyoOCep6LQ0PyZ5GUkWor0jGulvNDSm7AmpcVWJrGG14l2gKN+HlqRUgRi7/JhLqCKMW
         OJVDFj1ImKNDD92NcdAU0THHIlKkBRj/d8h40nAUxMtHggg1oCnhYrd77SepnZbxcugN
         Ln/Q==
X-Gm-Message-State: AOAM530tYg9VDfJtBa72Qiw+aCSPVrztOdMdRIbB1hSeSUvywuRBnM7c
        ryNOZR946+Z7HTU74XW4J9k=
X-Google-Smtp-Source: ABdhPJwXbbidik9cEAFSs0JIKO3dBawtPiIWA3QhnPjzLKhfk5acNXm4a1lU3wtDLr/Nxl3QRE9j2Q==
X-Received: by 2002:a05:6a00:c85:b029:311:bfe1:e407 with SMTP id a5-20020a056a000c85b0290311bfe1e407mr10217304pfv.77.1625414366261;
        Sun, 04 Jul 2021 08:59:26 -0700 (PDT)
Received: from ojas ([182.69.223.21])
        by smtp.gmail.com with ESMTPSA id l189sm5613360pgl.41.2021.07.04.08.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 08:59:26 -0700 (PDT)
Date:   Sun, 4 Jul 2021 21:29:16 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     gregkh@linuxfoundation.org, stefan.wahren@i2se.com, arnd@arndb.de,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] staging: vchiq: Make creation of vchiq cdev optional
Message-ID: <03cbe3fc1d9d7dbf9b0a3844b700eb9bf5459088.1625401928.git.ojaswin98@gmail.com>
References: <cover.1625401927.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1625401927.git.ojaswin98@gmail.com>
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

