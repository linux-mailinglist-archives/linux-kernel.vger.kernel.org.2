Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FE93ED356
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbhHPLsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbhHPLsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AFFC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso14781307wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRmCMATe/oD05X1KdUrQSITNGsBYj3Mxrh6vNjKJG7Y=;
        b=JqPrGCNX6n/om4MXpDKHm3Mof2cvg+hq24DLGKjOPQ13HG9LOVhrUPKApQPi8H6lGE
         LeNwF4931opGVL5GSMezw/159gUh+/AmCar2eDFRi/xkvHkVD93wuFsAKztIMVOl1Dbw
         fMBolZl90hm8cP5uj0kjr/Hkdlxo57yHvv/U8hk3zQvt0hgOpmhnow3vQ1riiM+JACja
         yszIHf/bD7b7qCBX6kR/6cgz8PiYqtPc3GqvakvCgfbHXE3+9CG55YmVsHczU+VBpzou
         gNi3i9exCjKdoAmse5/dE75upyPswOWPZ/qY87SjbaxVayfxfO+LetqcUOJn0tjkSaVi
         XLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRmCMATe/oD05X1KdUrQSITNGsBYj3Mxrh6vNjKJG7Y=;
        b=J6sbERryutENOSax09zUrutmk063XGBEKisdztsZ7+uoBiodJtBOhPR36ezO9XkWsD
         4QyomH4LKZnbXEUCD8JZ1/J/9WNP+lhRb/NAFs/Q01oxEbCnwoxRzmHgxV/seXEGQSfH
         0DaevUtnduKUOUM07skU5h8grtNXsNCs4TOB3wPn/CPHMYS4r6BhPVwh+uyq0TwJQRPi
         2SmR4KB95FvG0TrsOkLzivdEMcclsS4YXsewpq5/TdPtGq4KnrppbXw+mRSJgq62sYsX
         pogW7W+SWZ3MNyrc2p0W10HWQols/A778tAvSa1KOlVDyTmnkg+OOZkrfcUp6SY/r7Nc
         6yLQ==
X-Gm-Message-State: AOAM531Se2smjpUjDRIKIgMxtkoncfUvrenrTtdyd8JymXf154vJbhcv
        CoKea2amX2AMHGi/o2SSJONQGQ==
X-Google-Smtp-Source: ABdhPJyhD/uyuYJ5KWdJ3NLLs5jyrZmARQkoHZtrXoZx3vcL7K/GB4wM/TBefqvPWykrckitM7+/4g==
X-Received: by 2002:a1c:39c4:: with SMTP id g187mr14874138wma.163.1629114468679;
        Mon, 16 Aug 2021 04:47:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:48 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 08/10] i2c/drivers/ov02q10: Use HZ macros
Date:   Mon, 16 Aug 2021 13:47:30 +0200
Message-Id: <20210816114732.1834145-9-daniel.lezcano@linaro.org>
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
---
 drivers/media/i2c/ov02a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov02a10.c b/drivers/media/i2c/ov02a10.c
index a3ce5500d355..0f08c05333ea 100644
--- a/drivers/media/i2c/ov02a10.c
+++ b/drivers/media/i2c/ov02a10.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/units.h>
 #include <media/media-entity.h>
 #include <media/v4l2-async.h>
 #include <media/v4l2-ctrls.h>
@@ -64,7 +65,6 @@
 /* Test pattern control */
 #define OV02A10_REG_TEST_PATTERN			0xb6
 
-#define HZ_PER_MHZ					1000000L
 #define OV02A10_LINK_FREQ_390MHZ			(390 * HZ_PER_MHZ)
 #define OV02A10_ECLK_FREQ				(24 * HZ_PER_MHZ)
 
-- 
2.25.1

