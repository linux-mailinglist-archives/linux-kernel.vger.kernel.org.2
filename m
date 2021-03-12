Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278C338ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhCLK4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbhCLKzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f12so4537424wrx.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/WYLYLqmQFWxlr9WoVnLBGdoC49pGhDOWKpOODCm24=;
        b=OuQeMCfTT4DatgyvzMVQDGeeb5cw3kg6EcS8gxT0b9bi0EC0YubnFpjF9nNaWKZHgc
         QdXmiRwI/ZD6uDY8J9puCjAmJJfsbyIKB31Ed+8S/4kY32MFrgGJA8dQek3l3TZroSaj
         LL3NP4zewqLYp4qjM7gvay4NKq4zrqXasmNsyidm1eIpkYCYoJlwkMWP2m/adoAF0u+S
         noDM1gQxWUaKB8u7Hr/CcnVOq5gbjcEXe4MOZTgHhSUiBAWrd6v6DR6Kc0x8MDXzVN6k
         kF9u7zGq3JBrnKmIZN0MPZmFMR2NrT2iq9eiifs7MMewPrD9YNvMBmvmHz/YK3mEQldv
         s7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/WYLYLqmQFWxlr9WoVnLBGdoC49pGhDOWKpOODCm24=;
        b=i+oQQMz1HTA6jO8Mk0vdkksctJstCKhhKKQ0bazMG5FXVwmG08NfALmLbfZ0vD+4Bs
         tummPpp9UlMLFD+HfiNVM+4lryXpbwR5kDAiACJBIJ4/HF8Y+hk1Ehh7GDniBlx0109t
         zjdRMjmDHhO1PEfV9Sd01n/rcQIy8ismMnA0j5yVwLNsu7A8Jl3O4VfL7Y0FGLn6nis0
         z/I4D/Nm34iOVKI5a6oSGwmSNmyCU3ElGtmbvEWied9BYGHphItIV+LFmdGJuOU6wgP/
         aeai1qGPbXfT3H+oLcb1yOe7t2xWvEUoTbXjsSaI/Gw4GzDaGBuIbkUfW+2fajL/I5Gn
         ODqA==
X-Gm-Message-State: AOAM530gySR9JHvdn3l932pnnHfheluDSIKVowyBCLdGd6zc62cZdHEq
        1plOAYqd44ZNtJC5tXmcOw7F6v+F66Q16g==
X-Google-Smtp-Source: ABdhPJy+LSfk15aIBYGicZ5iq8PFrPFac51w86XE4skIkuw+WVP7ywQfAlsxnz2II7j14s8zrlbb4Q==
X-Received: by 2002:adf:a703:: with SMTP id c3mr13132259wrd.379.1615546536734;
        Fri, 12 Mar 2021 02:55:36 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH 02/11] block: drbd: drbd_interval: Demote some kernel-doc abuses and fix another header
Date:   Fri, 12 Mar 2021 10:55:21 +0000
Message-Id: <20210312105530.2219008-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/block/drbd/drbd_interval.c:11: warning: Function parameter or member 'node' not described in 'interval_end'
 drivers/block/drbd/drbd_interval.c:26: warning: Function parameter or member 'root' not described in 'drbd_insert_interval'
 drivers/block/drbd/drbd_interval.c:26: warning: Function parameter or member 'this' not described in 'drbd_insert_interval'
 drivers/block/drbd/drbd_interval.c:70: warning: Function parameter or member 'root' not described in 'drbd_contains_interval'
 drivers/block/drbd/drbd_interval.c:96: warning: Function parameter or member 'root' not described in 'drbd_remove_interval'
 drivers/block/drbd/drbd_interval.c:96: warning: Function parameter or member 'this' not described in 'drbd_remove_interval'
 drivers/block/drbd/drbd_interval.c:113: warning: Function parameter or member 'root' not described in 'drbd_find_overlap'

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_interval.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 651bd0236a996..f07b4378388b0 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -3,7 +3,7 @@
 #include <linux/rbtree_augmented.h>
 #include "drbd_interval.h"
 
-/**
+/*
  * interval_end  -  return end of @node
  */
 static inline
@@ -18,7 +18,7 @@ sector_t interval_end(struct rb_node *node)
 RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
 			 struct drbd_interval, rb, sector_t, end, NODE_END);
 
-/**
+/*
  * drbd_insert_interval  -  insert a new interval into a tree
  */
 bool
@@ -56,6 +56,7 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
 
 /**
  * drbd_contains_interval  -  check if a tree contains a given interval
+ * @root:	red black tree root
  * @sector:	start sector of @interval
  * @interval:	may not be a valid pointer
  *
@@ -88,7 +89,7 @@ drbd_contains_interval(struct rb_root *root, sector_t sector,
 	return false;
 }
 
-/**
+/*
  * drbd_remove_interval  -  remove an interval from a tree
  */
 void
@@ -99,6 +100,7 @@ drbd_remove_interval(struct rb_root *root, struct drbd_interval *this)
 
 /**
  * drbd_find_overlap  - search for an interval overlapping with [sector, sector + size)
+ * @root:	red black tree root
  * @sector:	start sector
  * @size:	size, aligned to 512 bytes
  *
-- 
2.27.0

