Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB543ED353
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhHPLsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbhHPLsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EE1C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q10so23206475wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17EpINVa4CB/eJ4Kknx1C227Qq0tdJtSvQoPuuMa8aA=;
        b=x6+GLnbfF09aFZ/GOYE2Czl9UBFbZCflENw/DNqp30rHBbvY7RyvtnoDegI7umsig4
         ubxlZjkdK6N72aj2AlPGcBLmknxa/NTFva/Sn+6hlMp7tttzXG3qdT3pqxePrE2jqb5B
         P23a5uCwJmy8zUL3D0ZeIl8dfg3Z0J9R17KByhQDvEwWyuTp5OIEA6Fm+4rv5nLe0pHc
         ngyv7+uXktgICDS6SA3BtN7UG7M8hJG5BYxaG6+FxE9U/riY3OsvdkaMuBRsF4Gf7qTd
         /K0p8i1dcwOl7AO7veN3p7mhpXfD+ec970+B/x88zDzv9rtYIDs0L9BNiTK9YbrC9u2v
         89UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17EpINVa4CB/eJ4Kknx1C227Qq0tdJtSvQoPuuMa8aA=;
        b=ICkD5F5U71FHH3IyEarxqElti+hgt0Xg9AWnCuBONptnq8nD3lbOFUWWYRXs1XNF0v
         37I0/aP12xyJQy1mASzwUrdNnZ0NTJttYjTi5KZtm/72/HSaUNLV5FRmcx1QvZUu6Aws
         zu5oeEKGLbOxuUMXOiHXc2kOoPt5s2uuk5Ju4Jc2xg6lwcHW2njwU7FJVrzGEGb/Oo7T
         fhLyQ3yIcjKblKELKDObOfrylQcD4hO/jtEzMaOHdwo3bY7+mH7YiSBEYXOvy3avjimV
         zXbdcMSEISm7uH5QEBrTgHBYJnH/PZrHEd4gTMxwTUB9+YmJlv0A9o1eBKi8rT8afZaB
         E7uw==
X-Gm-Message-State: AOAM533SyGGJJOV6ihUARX0DeQ4220mVd5JrVax5RnDFX3h4z+ohX/y2
        Sb3ual8RGkeBxaggKprJ3P/Ubg==
X-Google-Smtp-Source: ABdhPJzvNMXNJsLyAUZbKPoGyCi4xx6M3na2JgXhTHIn9/GSMosn8aBzlxOkkKH15cG07I98NhyV/g==
X-Received: by 2002:a5d:6d0f:: with SMTP id e15mr17926765wrq.373.1629114471572;
        Mon, 16 Aug 2021 04:47:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 10/10] phy/drivers/stm32: Use HZ macros
Date:   Mon, 16 Aug 2021 13:47:32 +0200
Message-Id: <20210816114732.1834145-11-daniel.lezcano@linaro.org>
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
 drivers/phy/st/phy-stm32-usbphyc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 3e491dfb2525..937a14fa7448 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 
 #define STM32_USBPHYC_PLL	0x0
 #define STM32_USBPHYC_MISC	0x8
@@ -47,7 +48,6 @@
 #define PLL_FVCO_MHZ		2880
 #define PLL_INFF_MIN_RATE_HZ	19200000
 #define PLL_INFF_MAX_RATE_HZ	38400000
-#define HZ_PER_MHZ		1000000L
 
 struct pll_params {
 	u8 ndiv;
-- 
2.25.1

