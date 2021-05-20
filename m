Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6538AF15
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhETMut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbhETMsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:48:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F4C05A987
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c14so15622049wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyUyvkWuivxw9i+qeaOF+fHwJvasLJtrCwBlaujeHnI=;
        b=phk7StCn27NCqHvMZsSU8b01cTn8UgRmTvpxYCeQACzojFZ+iawJ96f6IPE1R8iNbc
         ewlfUrxbLkl2gkf4+V4GKPJbSN7L6w+MT5R3tKMO7SDQG3VCGXYl01pqrruLcfabsnX6
         sVzb37UIKEcjTuRnWo4JDFxcGl6W57WxltZMrnld6BJMy3MEtkGrggJblIx/iZbM5BRr
         NaJoj4Oq+Wv3UBFOcC3BXR43RHDqwWgea2grnaRkreapmRQQNKTf6jnoYy91e/o+RW2D
         SZxOW2vG4YqZ5CbKgrCoH95ZYHRJNFKXNtIclhmXKUjB0b+yRnqcfhFLweKdyusKwQoT
         znLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyUyvkWuivxw9i+qeaOF+fHwJvasLJtrCwBlaujeHnI=;
        b=J/kWoprqGP962ALbu637kmK8kZyVRvG3O1/cF9/s3l6zzh2G6Xtawk/8di+KTo6KA4
         gie7et0RimBGoxK7c22EhD02VDBYa1YX1ufnv+2ypBYSACJrLTLPES8zK3YkAyLfR1qc
         aH02YKPEPIhFdzJlV3VYVVzMl6Iog2NaNZgiOSebJl7f/gA0qpn3M+h8XOrEQLnkP3IK
         6DuRVXYMeaLNjif7X9+T19VFZ6nKV86VWgDuN2alUr5ho71Z6RYRkux7W9yAJKiyLVMZ
         iqbDUd1Wotu791FZ0GJLEFwFCgiHjpD3uFN0jhSdVnCu0jOdSnTOBlf0iorkqVSYTDUd
         RiAw==
X-Gm-Message-State: AOAM531MmjxAj9wbymSaw1KgSL6vSETvYn8n5uQ3lo5usqYuG6KkQCss
        E7VB4bIWaqtSJJtjzP/2QDAylA==
X-Google-Smtp-Source: ABdhPJzjlR+LYGD37K92PFXuPL/scEGkgU3Dp+Bz+kzkL7RN9xEC53URbdJZJXexaKH3AbllkfL/JA==
X-Received: by 2002:a05:6000:2cb:: with SMTP id o11mr3943077wry.326.1621512509630;
        Thu, 20 May 2021 05:08:29 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id r7sm2237170wmq.18.2021.05.20.05.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:08:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 7/7] mfd: si476x-i2c: Fix incorrectly documented function names
Date:   Thu, 20 May 2021 13:08:20 +0100
Message-Id: <20210520120820.3465562-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120820.3465562-1-lee.jones@linaro.org>
References: <20210520120820.3465562-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mfd/si476x-i2c.c:360: warning: expecting prototype for si476x_drain_rds_fifo(). Prototype was for si476x_core_drain_rds_fifo() instead
 drivers/mfd/si476x-i2c.c:467: warning: expecting prototype for si476x_get_status(). Prototype was for si476x_core_get_status() instead
 drivers/mfd/si476x-i2c.c:484: warning: expecting prototype for si476x_get_and_signal_status(). Prototype was for si476x_core_get_and_signal_status() instead
 drivers/mfd/si476x-i2c.c:555: warning: expecting prototype for si476x_firmware_version_to_revision(). Prototype was for si476x_core_fwver_to_revision() instead
 drivers/mfd/si476x-i2c.c:619: warning: expecting prototype for si476x_get_revision_info(). Prototype was for si476x_core_get_revision_info() instead

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/si476x-i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/si476x-i2c.c b/drivers/mfd/si476x-i2c.c
index c1d7b845244ed..a2635c2d9d1a9 100644
--- a/drivers/mfd/si476x-i2c.c
+++ b/drivers/mfd/si476x-i2c.c
@@ -350,7 +350,7 @@ static inline void si476x_core_start_rds_drainer_once(struct si476x_core *core)
 	mutex_unlock(&core->rds_drainer_status_lock);
 }
 /**
- * si476x_drain_rds_fifo() - RDS buffer drainer.
+ * si476x_core_drain_rds_fifo() - RDS buffer drainer.
  * @work: struct work_struct being ppassed to the function by the
  * kernel.
  *
@@ -454,7 +454,7 @@ int si476x_core_i2c_xfer(struct si476x_core *core,
 EXPORT_SYMBOL_GPL(si476x_core_i2c_xfer);
 
 /**
- * si476x_get_status()
+ * si476x_core_get_status()
  * @core: Core device structure
  *
  * Get the status byte of the core device by berforming one byte I2C
@@ -473,7 +473,7 @@ static int si476x_core_get_status(struct si476x_core *core)
 }
 
 /**
- * si476x_get_and_signal_status() - IRQ dispatcher
+ * si476x_core_get_and_signal_status() - IRQ dispatcher
  * @core: Core device structure
  *
  * Dispatch the arrived interrupt request based on the value of the
@@ -532,7 +532,7 @@ static irqreturn_t si476x_core_interrupt(int irq, void *dev)
 }
 
 /**
- * si476x_firmware_version_to_revision()
+ * si476x_core_fwver_to_revision()
  * @core: Core device structure
  * @func: Selects the boot function of the device:
  *         *_BOOTLOADER  - Boot loader
@@ -603,7 +603,7 @@ static int si476x_core_fwver_to_revision(struct si476x_core *core,
 }
 
 /**
- * si476x_get_revision_info()
+ * si476x_core_get_revision_info()
  * @core: Core device structure
  *
  * Get the firmware version number of the device. It is done in
-- 
2.31.1

