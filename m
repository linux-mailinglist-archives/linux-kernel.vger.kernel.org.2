Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6850E39120D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhEZIMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhEZIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE7AC061761
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v12so82681wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5Uj5Rjjm4ZKYV7rpwdmoSf7YzKkWMegnA41y5gkr6w=;
        b=mG3GfbOWVxf50knzK1KMfu8LhDH6iR6fdHvVmkJARZTpUWHGV3oCywGDYS+ZRuTU/G
         u0ZjX+bWU73XSbLISTzscDGcZE1lczfUERZpIpHA8wcsc+XkohXIAyeUzdWKzdiSsFWa
         0b4npdadFPkilGMnjyYzdK3l++v94gYNiiFO/egFvjpQ5dkc890ELnjim9YSoFibRseh
         LgzNJaG9XIvxAZm6Eq5TmKBHsiaTHZqpCGsoIVrYL2ATfhGTtoRGVBqC+fXWQ7TZQ/K5
         3/wELfhpv5YRQNT9KTxBm4rz9SYH49+Qq17aloTvwsxksEAQ5lSfvUbIHfIAUbYbacSo
         bKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5Uj5Rjjm4ZKYV7rpwdmoSf7YzKkWMegnA41y5gkr6w=;
        b=qbU1A9pP+aydhjc1eqVDiFrci+d3D1e9FRVT7tYS04ACdnVzSIZLN7YoZtOSrScth1
         xnPjgujNpGLF2dr0TqH7aUHfu0a2G/pYxQAkGFMipTNqHLc3fsHOGA2/DDpLUXOHKxha
         YDUAdIKngJLPT3tVa0HEAaDDbOp5s1asMS8BG3CsEdF+lZIX5S7nMevW0Cam5kLLuRoN
         6sRjhVP++Cj/OKLZCIkd7RdxZenZhOvqag5GA0vE4zMXEapKThfRXnNnHhNsIM4/zEWJ
         OY3DKn8V+imaIPzKtsLNqtGypTWreZRZhWCslV40hk1YVSzt9+K/phQ/OGCcfYvN7WKb
         mpQw==
X-Gm-Message-State: AOAM5339mo0wmyICfi+ytwy4/MGhiwQo2C/6GGMGvLd03Fi5HXTef7Dv
        CNvHA40j71j8CVardXpU/XF23A==
X-Google-Smtp-Source: ABdhPJy6DJWNL29M//luo66JTJZk5k9MUAPbrScm4tpyyvTs0KUkTd5jSvIsBhyKhvj24CsMweoDvw==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr32599957wru.396.1622016651730;
        Wed, 26 May 2021 01:10:51 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id v11sm22628319wrs.9.2021.05.26.01.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:10:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 06/10] bus: fsl-mc: fsl-mc-allocator: Fix misspelling of 'new_mc_adev' and demote non-kernel-doc headers
Date:   Wed, 26 May 2021 09:10:34 +0100
Message-Id: <20210526081038.544942-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526081038.544942-1-lee.jones@linaro.org>
References: <20210526081038.544942-1-lee.jones@linaro.org>
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
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
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
2.31.1

