Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C143AB1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhFQLHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhFQLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:07:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D9C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o3so6284462wri.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jO5VQoWBusETJGbFTxmd62QEkgpQgEXWdlV0lQzbvvI=;
        b=n8ppWlESDAkPVRl2Qggsuxtj3j/j+ojQCqbJfwaUXU/2KGUpJc0KOmFrUIaCUxPznV
         Or1eximt8PtjpzuxQgx6E4io6kh6ChfORo8C8qdCVSvJCxqnBjzrDfNbnPCAT6RT6DSS
         UNhw42tKs8xKUvm9Fl4oK5lcK8hYFT/3sxJ3Q751dhlepoUbHVrOmrr6zWRgMIfU13l4
         qy6YUfL0kQPnIWpHeXz7cClHrpokB590QvUD+qahKaCPnGj/n7mUXUOvyKFcWNtsWlTX
         s/hXQgA6nUKo0qB4cQZW5TcgsT37N9RWMufmFLi/lakCooNteWKa8X+fFGo9o0222diS
         ylxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jO5VQoWBusETJGbFTxmd62QEkgpQgEXWdlV0lQzbvvI=;
        b=X06gRDClx+hSSVgZfgWc20H3QBy7Auy1lPVx37hr5f2axxM///iJryJiT/F50Zn4D7
         yk8iznJSNX5J5B9b3YBkqQWuDAZwfCGp1EnGu7ky2UbMJEKEhmhuLSKt2xRhsIrNsMgf
         B8nnY8yzambGbCR7YJtzwFZhM38AgchCWFDizvZpC0XNRUdNNl6AmDRkpkUNVOmbyW/U
         +CumNXUqJNDS5e63ri88Z9UfAqP9hxzUdy0wozW0vyFhJz/34hRFa9QCddAjukPb3qPp
         38UOULal8Lm1uwPSVZYs+p0CfTnE+kAwPkWcjpXoI7K2kUkWpWsuc+wTENIB/hNQDFrm
         qjeg==
X-Gm-Message-State: AOAM533muHVBB5fAfwxqPYAFZOyPx16ix92E0+MpjMRdBgalWJQQhzNp
        6r1EG88RKtzTzZs94fpDlojylw==
X-Google-Smtp-Source: ABdhPJxLwTQDKPNNUxGYYpPim6mGNc+i5bFdI/k1Sn3s658qIoc9gmJdGbAmJA0v65MXuTh6ij7cfw==
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr4954314wrt.269.1623927916105;
        Thu, 17 Jun 2021 04:05:16 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id v18sm5249487wrb.10.2021.06.17.04.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:05:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        German Rivera <German.Rivera@freescale.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 3/8] bus: fsl-mc: fsl-mc-bus: Demote a bunch of non-conformant kernel-doc headers and help others
Date:   Thu, 17 Jun 2021 12:04:55 +0100
Message-Id: <20210617110500.15907-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617110500.15907-1-lee.jones@linaro.org>
References: <20210617110500.15907-1-lee.jones@linaro.org>
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
Cc: German Rivera <German.Rivera@freescale.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
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
2.32.0

