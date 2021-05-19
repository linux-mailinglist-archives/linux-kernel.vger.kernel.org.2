Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04C1388C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbhESLEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:04:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54981 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbhESLEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:04:37 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljJyu-0001DT-1T
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 11:03:16 +0000
Received: by mail-wm1-f72.google.com with SMTP id f8-20020a1c1f080000b0290169855914dfso1396867wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwXLnF7rWDVcwlt7Q5T7XhtjUkElmGn6H/9Zlr+sBJo=;
        b=tfO9AnvAcQBS7nBW05j6+QvEbLSccoa/srVas/9L2irb4MEtWwCIzGf6D/24Y0o0HK
         6iExFQJNv7WnAs51YClfg2zyXikp3d1BhH2Tb79k6NZmYiK5DFExXQsi5VY9FAV1YHS+
         B1C1XiVwJ7pIkPCcYoEjDEvQhM9UdVdrKf3IajBshkSmkIhqpfa4OoQaNvpZVs3z35cI
         lPYkBCzYQct8jwaIvAMQtfYb19DSgpr2cUIxPdKCr0N5W3DRJd0nfe/Gw/ku945X8UyO
         VR5smPZognb1jcVPklkizGNvaAtXjWVp1yuvOPdtaoG/6drHFRSPVPJpURMgso1HhEFn
         BRnA==
X-Gm-Message-State: AOAM532X05Tp4myhjWTLFkn88IylQvRj0TSaeI6J5N2z4wGCxQy4k1k/
        eu9gPWI1IMjeTz/xDE05gJ0MsCzjc3+FzstPEVRw1d7rfeLFJM+I2hzSeX4hgfhuGaPvsPY+Huw
        FrEjScj+jTlYagQR0ANaNhWAohabt+mKLPedvnKU/HQ==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr13878355wrx.82.1621422195791;
        Wed, 19 May 2021 04:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6tC845fEuilnb4EmT7sQDtVzUIm15hK+X9ZytOkjmm3/ZcdO7CqysCBMbe2jUpyaFX/npoQ==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr13878336wrx.82.1621422195616;
        Wed, 19 May 2021 04:03:15 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id r5sm23682357wmh.23.2021.05.19.04.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:03:15 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2] backlight: Kconfig whitespace and indentation cleanups
Date:   Wed, 19 May 2021 13:03:00 +0200
Message-Id: <20210519110300.17918-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517095839.81833-1-juergh@canonical.com>
References: <20210517095839.81833-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading whitespaces, replace multi spaces with tabs, and fix help
text indentation.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/video/backlight/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index d83c87b902c1..c887338de386 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -128,12 +128,12 @@ config LCD_HX8357
 	  If you have a HX-8357 LCD panel, say Y to enable its LCD control
 	  driver.
 
-  config LCD_OTM3225A
-  	tristate "ORISE Technology OTM3225A support"
-  	depends on SPI
-  	help
-  	  If you have a panel based on the OTM3225A controller
-  	  chip then say y to include a driver for it.
+config LCD_OTM3225A
+	tristate "ORISE Technology OTM3225A support"
+	depends on SPI
+	help
+	  If you have a panel based on the OTM3225A controller
+	  chip then say y to include a driver for it.
 
 endif # LCD_CLASS_DEVICE
 
@@ -269,11 +269,11 @@ config BACKLIGHT_MAX8925
 	  WLED output, say Y here to enable this driver.
 
 config BACKLIGHT_APPLE
-       tristate "Apple Backlight Driver"
-       depends on X86 && ACPI
-       help
-	 If you have an Intel-based Apple say Y to enable a driver for its
-	 backlight.
+	tristate "Apple Backlight Driver"
+	depends on X86 && ACPI
+	help
+	  If you have an Intel-based Apple say Y to enable a driver for its
+	  backlight.
 
 config BACKLIGHT_TOSA
 	tristate "Sharp SL-6000 Backlight Driver"
-- 
2.27.0

