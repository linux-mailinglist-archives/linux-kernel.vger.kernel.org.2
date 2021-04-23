Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC4369570
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243393AbhDWPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242967AbhDWPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED94C061361
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so1406941wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+j7lRegxzNVtgM/b7Sy9jh8N/GGtG6h5FSr8oPr7oJ4=;
        b=qxo/PTIF85lLgEg4lYW4gRt1e/iyQjhNRbgA99W4Q/M/og4zHxymfxOQgPz2NyhI2T
         QPp9E6+27qNJ8zUq1OZQ3Qsqpx9+C4xrhMMETWQp0NgO4JtitrfLxAkhvVO2okBaMU22
         3mWeyu55x6GTv2zSo0PY2Qm03glCXzD3w5Os+eABAxxY4S5uUllc1vCxFbNrMaMQZYZ3
         Z+HpQUJQBiJ4qh2+JtvsN/B5sKzgJ+Ekb5D8cU0kndKMznI2096chsix6nK86ln/sLpa
         anxMwXyjQvNbHenmnoiiwqVzGvUM5vNzrK99XQuyT+I3aP/FBHIcGeqIJkqAwE+Tbo7L
         NqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+j7lRegxzNVtgM/b7Sy9jh8N/GGtG6h5FSr8oPr7oJ4=;
        b=gDEwIZQit684VaPLvK5s3PVi4Gaqkqvp4z9vDyAVtbY30PlOOYSnmLizcxDQ/NeTCl
         4nZstYLJyHFzjg2kaKJNgB0y1OOe2jaoDTTuviz7wPnJOuGBcv7YD6VNT1k9vPPD6qu1
         QbupWKZl9DqbbZOzKon0fIokrIM3M1PLaFNsHZX0ouqrzdRpyKrfxODoBITdekA4w5zW
         4tqF8JzlwUWs53aBMllaXbMsPpzQOjt9RNzbp8m+ISk+u9N/f11KR23hNJcYRiIP1gDs
         ynN1aiGAozG8JxL1KQiL4nqAxIvxt1EQ7JICouqQiIx4wyknSdCJbdZ/fkbV+KkIhPx/
         0rJQ==
X-Gm-Message-State: AOAM530rFnBUGUhRJWu819zewqzEEiHwFsfTsrCZZRouEi8LJpg4BPdc
        nfhzcSKQVfwMLiStlKNx2bergCs0cYU=
X-Google-Smtp-Source: ABdhPJzPuG0XtlVxSEWjPfZOdCnfzAoRIpjKRGdiorgLkxNVGjgjIPM4R+e6Xr8/EbwY9OGqZ9sevw==
X-Received: by 2002:a1c:9853:: with SMTP id a80mr4724814wme.44.1619189984763;
        Fri, 23 Apr 2021 07:59:44 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id z14sm9258507wrs.96.2021.04.23.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 38/49] staging: rtl8723bs: remove unused debug macros tied to hal/sdio_ops.c debug
Date:   Fri, 23 Apr 2021 16:58:29 +0200
Message-Id: <6789381e398082317ba9d442091439db74f52626.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
hal/sdio_ops.c debug.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c      | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index a31694525bc1..b5434ab71578 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  *******************************************************************************/
-#define _SDIO_OPS_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 3becb1b8d15e..c061d874f4e6 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -21,9 +21,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _SDIO_OPS_C_
-	#define	_MODULE_DEFINE_ 1
-#elif defined _OSDEP_SERVICE_C_
+#if defined _OSDEP_SERVICE_C_
 	#define	_MODULE_DEFINE_	_module_osdep_service_c_
 #elif defined _HCI_OPS_OS_C_
 	#define	_MODULE_DEFINE_	_module_hci_ops_os_c_
-- 
2.20.1

