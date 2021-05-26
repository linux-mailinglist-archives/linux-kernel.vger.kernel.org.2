Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9D39120B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhEZIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhEZIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AABC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x8so66496wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDw4RKIZ9Jhtvl+OLRUM88EPXGZJSlhMoA/WtRN8Jeg=;
        b=mxbewkS1y0ZY64oQpit8WnxaBBeTQo/oFDiBnYRe9ZRACtayNHUAEUF3AI7i0IEG09
         rn6/IXPlQ4OqesOaflyQXi96SZa/P5ckENcyQd1UW2P2p5JN0cwYpVI3PoClGzh8uPa5
         gAwW6cnlNiBfYglJzSTp6YdWIeQWuJYhQ85CRIan+cYszdwi+C1eyTRzfU5kaaJBhohN
         CztDmvkQlyHiySjDl87n3f9S6OYqozGXsvq3g2y6SRHKmPqhhG2h8NXFXbLpAfKsVZlZ
         kXbov7Ru11tMG93G1F7ghDqSP/ewpCSjx3QqtQa4QXgabRaci7L9TMJ9y8BNBp9mKJ6T
         RwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDw4RKIZ9Jhtvl+OLRUM88EPXGZJSlhMoA/WtRN8Jeg=;
        b=oMVeu6z1iVA5QIA7HgOCmFNx5gKCVWB9OrXIEilUdVxDvjODItds21xKZhX5YZusn4
         AdtXyd6KivgFcEZcjFsi211ZXwrrno68bMh9H1mHg/nxj/0nBely0cOYo7vJrBevEBEr
         GWJHaWB/im30HNnUV+yoDfeLFWBkeXsboCGPCrt2PBbzNLFfP9xHF9YG0kPY1QRUdDLA
         mh19mVq/hrqJfOk5+QWfYwc9ax1+bUV5zm6LWovDZAcDjOX/BfqUKotDANSv+3cmJ/Gq
         dA6JRVqHD5FvPLt532mp+X6/X1DGZOZeRMwoXWFQZ5TJ7WHkOTVQAN5zajoHgnwYkIuN
         xXwg==
X-Gm-Message-State: AOAM533CSHtv8s9D347V2voGtYXM1p8IWvilv/0/d5sKmK3zT/iPICVP
        SDcpUh65i/jz7Q3y1fSpKyKAoQ==
X-Google-Smtp-Source: ABdhPJwVWpm8wFCGhllFIpcKcMW7iuh86DDucBgkzBuo9PN4nSX8LA1vuVtbiVWJqvrGdms3V1nWdQ==
X-Received: by 2002:a05:6000:1001:: with SMTP id a1mr30725441wrx.59.1622016648926;
        Wed, 26 May 2021 01:10:48 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id v11sm22628319wrs.9.2021.05.26.01.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:10:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        German Rivera <German.Rivera@freescale.com>
Subject: [PATCH 03/10] bus: fsl-mc: fsl-mc-bus: Demote a bunch of non-conformant kernel-doc headers and help others
Date:   Wed, 26 May 2021 09:10:31 +0100
Message-Id: <20210526081038.544942-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526081038.544942-1-lee.jones@linaro.org>
References: <20210526081038.544942-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/fsl-mc-bus.c:30: warning: expecting prototype for Default DMA mask for devices on a fsl(). Prototype was for FSL_MC_DEFAULT_DMA_MASK() instead
 drivers/bus/fsl-mc/fsl-mc-bus.c:45: warning: Function parameter or member 'fsl_mc_regs' not described in 'fsl_mc'
 drivers/bus/fsl-mc/fsl-mc-bus.c:124: warning: Function parameter or member 'dev' not described in 'fsl_mc_bus_uevent'
 drivers/bus/fsl-mc/fsl-mc-bus.c:124: warning: Function parameter or member 'env' not described in 'fsl_mc_bus_uevent'
 drivers/bus/fsl-mc/fsl-mc-bus.c:480: warning: Function parameter or member 'mc_driver' not described in '__fsl_mc_driver_register'
 drivers/bus/fsl-mc/fsl-mc-bus.c:480: warning: Function parameter or member 'owner' not described in '__fsl_mc_driver_register'
 drivers/bus/fsl-mc/fsl-mc-bus.c:511: warning: Function parameter or member 'mc_driver' not described in 'fsl_mc_driver_unregister'
 drivers/bus/fsl-mc/fsl-mc-bus.c:571: warning: Function parameter or member 'dev' not described in 'fsl_mc_get_root_dprc'
 drivers/bus/fsl-mc/fsl-mc-bus.c:571: warning: Function parameter or member 'root_dprc_dev' not described in 'fsl_mc_get_root_dprc'
 drivers/bus/fsl-mc/fsl-mc-bus.c:739: warning: Function parameter or member 'dev' not described in 'fsl_mc_is_root_dprc'
 drivers/bus/fsl-mc/fsl-mc-bus.c:767: warning: Function parameter or member 'obj_desc' not described in 'fsl_mc_device_add'
 drivers/bus/fsl-mc/fsl-mc-bus.c:767: warning: Function parameter or member 'mc_io' not described in 'fsl_mc_device_add'
 drivers/bus/fsl-mc/fsl-mc-bus.c:767: warning: Function parameter or member 'parent_dev' not described in 'fsl_mc_device_add'
 drivers/bus/fsl-mc/fsl-mc-bus.c:767: warning: Function parameter or member 'new_mc_dev' not described in 'fsl_mc_device_add'
 drivers/bus/fsl-mc/fsl-mc-bus.c:767: warning: expecting prototype for Add a newly discovered fsl(). Prototype was for fsl_mc_device_add() instead
 drivers/bus/fsl-mc/fsl-mc-bus.c:1066: warning: Function parameter or member 'pdev' not described in 'fsl_mc_bus_probe'
 drivers/bus/fsl-mc/fsl-mc-bus.c:1190: warning: Function parameter or member 'pdev' not described in 'fsl_mc_bus_remove'

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: German Rivera <German.Rivera@freescale.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 380ad1fdb7456..09c8ab5e0959e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -24,7 +24,7 @@
 
 #include "fsl-mc-private.h"
 
-/**
+/*
  * Default DMA mask for devices on a fsl-mc bus
  */
 #define FSL_MC_DEFAULT_DMA_MASK	(~0ULL)
@@ -36,6 +36,7 @@ static struct fsl_mc_version mc_version;
  * @root_mc_bus_dev: fsl-mc device representing the root DPRC
  * @num_translation_ranges: number of entries in addr_translation_ranges
  * @translation_ranges: array of bus to system address translation ranges
+ * @fsl_mc_regs: base address of register bank
  */
 struct fsl_mc {
 	struct fsl_mc_device *root_mc_bus_dev;
@@ -117,7 +118,7 @@ static int fsl_mc_bus_match(struct device *dev, struct device_driver *drv)
 	return found;
 }
 
-/**
+/*
  * fsl_mc_bus_uevent - callback invoked when a device is added
  */
 static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
@@ -467,7 +468,7 @@ static void fsl_mc_driver_shutdown(struct device *dev)
 	mc_drv->shutdown(mc_dev);
 }
 
-/**
+/*
  * __fsl_mc_driver_register - registers a child device driver with the
  * MC bus
  *
@@ -503,7 +504,7 @@ int __fsl_mc_driver_register(struct fsl_mc_driver *mc_driver,
 }
 EXPORT_SYMBOL_GPL(__fsl_mc_driver_register);
 
-/**
+/*
  * fsl_mc_driver_unregister - unregisters a device driver from the
  * MC bus
  */
@@ -563,7 +564,7 @@ struct fsl_mc_version *fsl_mc_get_version(void)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_get_version);
 
-/**
+/*
  * fsl_mc_get_root_dprc - function to traverse to the root dprc
  */
 void fsl_mc_get_root_dprc(struct device *dev,
@@ -732,7 +733,7 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_mc_device *mc_dev,
 	return error;
 }
 
-/**
+/*
  * fsl_mc_is_root_dprc - function to check if a given device is a root dprc
  */
 bool fsl_mc_is_root_dprc(struct device *dev)
@@ -757,7 +758,7 @@ static void fsl_mc_device_release(struct device *dev)
 		kfree(mc_dev);
 }
 
-/**
+/*
  * Add a newly discovered fsl-mc device to be visible in Linux
  */
 int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
@@ -1058,7 +1059,7 @@ static int get_mc_addr_translation_ranges(struct device *dev,
 	return 0;
 }
 
-/**
+/*
  * fsl_mc_bus_probe - callback invoked when the root MC bus is being
  * added
  */
@@ -1182,7 +1183,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	return error;
 }
 
-/**
+/*
  * fsl_mc_bus_remove - callback invoked when the root MC bus is being
  * removed
  */
-- 
2.31.1

