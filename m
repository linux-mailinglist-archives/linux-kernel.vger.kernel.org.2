Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41A43ED352
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhHPLs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbhHPLsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95565C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a201-20020a1c7fd2000000b002e6d33447f9so3104744wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlWH3BSct2KUqU9ufDLwEV++othm2QSAMFfIk7cec2c=;
        b=Wm4d2OasJTj82Yg4wJb/Izv2KenPhSmSCh81YhqVvtDDVNyLwa0jbQk6sh9xb2JtYY
         xm+K5XKKwSczvbvs5SSKo+mG9rgMsk688lZGcMln8KkmxpEnh6MbCdt7hSZojNTIjWi0
         MZQFMdMQb/YiFxDa2kov2Ojg3uzi+pphpbzHv0GJ7sJaAtdefwrx65GUn5ccjFFz7SOY
         H9n0q4UIrtPQLaz6slqiALp8xG1otG6CNWnkHbtseCFPeW7dlgSaHOlOyPVqaddwV1Mu
         qTIkDMxctHwG1758J2KoT+oepZ+CZ6+4L3RoRF+Jc6+u+p5ExNS7fOfg+L0CLGDMmKmu
         jrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlWH3BSct2KUqU9ufDLwEV++othm2QSAMFfIk7cec2c=;
        b=DZom3VzhCmzOjwxV8k2/xeusxlxijpLAaFY/WPr9vBmM8t3+HJcEnvfZapGHfPVOwh
         QIqJ4u9KZQ/07c9iff8qpmK59kv1+Q5dAJUB4IQJ2bdhzTxQzbqOs8JUAcCVicFAx1rV
         cX0sUYNuoreLrmSTttRae6PQplxIqJFv+ZKxTNToMbkQRcXSrBfS5ocme+tOyGCWHczD
         i7/AOSAsVe7VFy5UQKT717jdzwN3YRbR9uaL0CH/gGhe10EZqhknTyzszM21XSH6B1v4
         Zbl6yc/XsrfylUShrh6qU2KV6twsk+tLgpPUYoD+xO5XAzb2WMpsHJr/pUVYPQOpg8zS
         zy1A==
X-Gm-Message-State: AOAM530Md4D7hRwKAqlJ7KZepnzH7kl8Vic1AlaDsqBGnmNXzBM+DhNi
        dPlnI7iWTh0vZz+7UgM51Nr8Qw==
X-Google-Smtp-Source: ABdhPJxPgnY+56N8ZHvQXcuqImDBnWeniuatJIVNFXFjvVs+YYDJrlpIIN6+rH4sDj9aTpudYVxN4g==
X-Received: by 2002:a1c:7408:: with SMTP id p8mr15006717wmc.24.1629114467138;
        Mon, 16 Aug 2021 04:47:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 07/10] iio/drivers/hid-sensor: Use HZ macros
Date:   Mon, 16 Aug 2021 13:47:29 +0200
Message-Id: <20210816114732.1834145-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
References: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 043f199e7bc6..9b279937a24e 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -6,12 +6,11 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
+#include <linux/units.h>
 
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 
-#define HZ_PER_MHZ	1000000L
-
 static struct {
 	u32 usage_id;
 	int unit; /* 0 for default others from HID sensor spec */
-- 
2.25.1

