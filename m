Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4210D3AB1E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhFQLIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhFQLHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:07:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEC4C061767
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so3469698wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1RR6CZj/d7JcgES5MvdJl7fNX/949Tgd+9gW6JVp+0=;
        b=OoG/dHC8i9zYX/2/eCwISe7t4186Saaijvbatwu8F2jS+AMZu1Ylx6L4U0nUWQzd4T
         Mdhh62VdD31r8qsfb4Q6g+GnD3ujAvF1Sl9ZLCi2Xz4WS389KRbaIqBrIwOcdkO1UMUS
         KWFynFdzTmu43Pmiue5oEcFyWtOztgSHk5Oq7r8dMG/oDVBpyLzC9kSRkKbQlFuI6UL+
         +guR04m1Ija1kMAOZegdLrYGfNBQbFRcuwy5qcYR2QNZ1jA2g72RvGoPWio3DrLmL6z5
         8tFmrcck64ysShKHAPr65ajDrRpeVFTIbrwiM+7HKePRA30OsBXDuslSwI1KvEPc3+kV
         e6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1RR6CZj/d7JcgES5MvdJl7fNX/949Tgd+9gW6JVp+0=;
        b=GlParoJTuVgnNS07FtCvhC/bSqr1UNMnuBuoOHXanWw2gX/FIyLuINLl8KVq5FCPWG
         AoUh3FiXZwBNJ/p1BVq72Vo8b4uUar61orIxkQxxtH5bh6d0bR5rgcv/BIteSVbCpVO7
         KKX1mhXHYuScg3t22yyw31J32z275GZ+vh3yXFYf+Zeto/SriyPfJJcFExUMCy0hX5FV
         Jn7tgLb2RO35svvEyrSB4kPw2Egd+loytaAHno3dNOGXIx9qI/HggK/CePCS9D23IeMS
         xIOR3907Z4pcSTyjpQWzRE2QbWkYL5gY8osEzcHF2V4Cf48Gth00hQ3UGrSYKmgu72sA
         Ydaw==
X-Gm-Message-State: AOAM532YSYvMoZuaHnYAyY9nLarigTH4cDUmVy7+7v1U/c3Uw8rmYdZh
        Vt4l+uq1X7L3MHpkea08mIubsQ==
X-Google-Smtp-Source: ABdhPJxu/cDD0kjC5EcqshZA/dx9hrUHiDjRakiBX7xhwQj+MlLdYM734OR325VQq/gwK7TOA8TIUA==
X-Received: by 2002:a05:600c:3ba2:: with SMTP id n34mr4400485wms.120.1623927930826;
        Thu, 17 Jun 2021 04:05:30 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id v18sm5249487wrb.10.2021.06.17.04.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:05:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 6/8] bus: fsl-mc: fsl-mc-allocator: Fix misspelling of 'new_mc_adev' and demote non-kernel-doc headers
Date:   Thu, 17 Jun 2021 12:04:58 +0100
Message-Id: <20210617110500.15907-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617110500.15907-1-lee.jones@linaro.org>
References: <20210617110500.15907-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/fsl-mc-allocator.c:271: warning: Function parameter or member 'new_mc_adev' not described in 'fsl_mc_object_allocate'
 drivers/bus/fsl-mc/fsl-mc-allocator.c:271: warning: Excess function parameter 'new_mc_dev' description in 'fsl_mc_object_allocate'
 drivers/bus/fsl-mc/fsl-mc-allocator.c:417: warning: Function parameter or member 'mc_bus_dev' not described in 'fsl_mc_cleanup_irq_pool'
 drivers/bus/fsl-mc/fsl-mc-allocator.c:417: warning: expecting prototype for Teardown the interrupt pool associated with an fsl(). Prototype was for fsl_mc_cleanup_irq_pool() instead
 drivers/bus/fsl-mc/fsl-mc-allocator.c:443: warning: Function parameter or member 'mc_dev' not described in 'fsl_mc_allocate_irqs'
 drivers/bus/fsl-mc/fsl-mc-allocator.c:443: warning: expecting prototype for Allocate the IRQs required by a given fsl(). Prototype was for fsl_mc_allocate_irqs() instead
 drivers/bus/fsl-mc/fsl-mc-allocator.c:586: warning: Function parameter or member 'mc_dev' not described in 'fsl_mc_allocator_probe'
 drivers/bus/fsl-mc/fsl-mc-allocator.c:618: warning: Function parameter or member 'mc_dev' not described in 'fsl_mc_allocator_remove'

Cc: Stuart Yoder <stuyoder@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index 2d7c764bb7dcf..6c513556911e3 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -254,7 +254,7 @@ EXPORT_SYMBOL_GPL(fsl_mc_resource_free);
  * @mc_dev: fsl-mc device which is used in conjunction with the
  * allocated object
  * @pool_type: pool type
- * @new_mc_dev: pointer to area where the pointer to the allocated device
+ * @new_mc_adev: pointer to area where the pointer to the allocated device
  * is to be returned
  *
  * Allocatable objects are always used in conjunction with some functional
@@ -409,7 +409,7 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_device *mc_bus_dev,
 }
 EXPORT_SYMBOL_GPL(fsl_mc_populate_irq_pool);
 
-/**
+/*
  * Teardown the interrupt pool associated with an fsl-mc bus.
  * It frees the IRQs that were allocated to the pool, back to the GIC-ITS.
  */
@@ -436,7 +436,7 @@ void fsl_mc_cleanup_irq_pool(struct fsl_mc_device *mc_bus_dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_cleanup_irq_pool);
 
-/**
+/*
  * Allocate the IRQs required by a given fsl-mc device.
  */
 int __must_check fsl_mc_allocate_irqs(struct fsl_mc_device *mc_dev)
@@ -578,7 +578,7 @@ void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev)
 		fsl_mc_cleanup_resource_pool(mc_bus_dev, pool_type);
 }
 
-/**
+/*
  * fsl_mc_allocator_probe - callback invoked when an allocatable device is
  * being added to the system
  */
@@ -610,7 +610,7 @@ static int fsl_mc_allocator_probe(struct fsl_mc_device *mc_dev)
 	return 0;
 }
 
-/**
+/*
  * fsl_mc_allocator_remove - callback invoked when an allocatable device is
  * being removed from the system
  */
-- 
2.32.0

