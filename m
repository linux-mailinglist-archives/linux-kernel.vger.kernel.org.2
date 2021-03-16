Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3033CF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhCPIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:10:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38079 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhCPIKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:10:17 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lM4mO-0007Km-JM
        for linux-kernel@vger.kernel.org; Tue, 16 Mar 2021 08:10:16 +0000
Received: by mail-wr1-f71.google.com with SMTP id o11so281216wrc.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VhxDXmiLj12/e6HOVlG9MXc4OCMTGYO3uqj5EV5VPF8=;
        b=NVRWw6evbAA3Yf61/mkAr1pmO1haBgXTaVi3Wzt4gTh0Sgr7yEf3hOPV9uEK9B5d3i
         RtwRLBZK/OUGeYaNuB25MKH3hUvNQD1AmBGoeXow226/cAF38I/zBLgj876aH1A0Ciux
         tiKvuigEmCgiyAAm4kZK0aJaOUMkFzEdX5Ig4rfi4HI9JWz7gbPmM9nWz2DWubb0s8El
         +SwwJb+0QArlyOtegVqKj3N/RiDL6hBW5Qzdvjn3ahnGmpky9fkOdWlD6j59nxbkqYGj
         ajR5xQJgVdjenLoDewPlthPrAN+5sva/KDxJlY3kfS6M07XCQQD0XmjnXarb4ZNJK4Pm
         jq9g==
X-Gm-Message-State: AOAM530FZQeyqU1YjytdtdXwKU7ZgedGap2QUIrQr54fDLi1TWUtXxbb
        0FqSHgw2dc50MbW+UFW6Ld+By5P5vtvWSgw61VQRrQlCXyr07NWQD0MDXWIw5N4iIH8m59RCbBJ
        jR+xy1i5xRuldsr3CrQZBkbGAA3RRz1sWaECWOai68w==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr3364540wmj.124.1615882216373;
        Tue, 16 Mar 2021 01:10:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykrT2YWPh2PVwGZoqeb/zUzcw0Voe2XMvZOLfWl+9hVESXKoGtOq/hUYrOOVG++VMqgupSQg==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr3364507wmj.124.1615882216211;
        Tue, 16 Mar 2021 01:10:16 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id a75sm2324104wme.10.2021.03.16.01.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 01:10:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH RESEND v4] MAINTAINERS: move Milo Kim to credits
Date:   Tue, 16 Mar 2021 09:10:00 +0100
Message-Id: <20210316081000.12596-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Milo Kim's email in TI bounces with permanent error (550: Invalid
recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
credits and remove the separate driver entries for:
 - TI LP855x backlight driver,
 - TI LP8727 charger driver,
 - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Sebastian Reichel <sre@kernel.org>

---

Dear Lee,

Could you take care about this patch?

Best regards,
Krzysztof

Changes since v3:
1. Remove the entries as Dan Murphy won't be mainaining them.

Changes since v2:
1. Fix subject (TP -> TI).

Changes since v1:
1. Add Dan Murphy, do not remove the entries.
---
 CREDITS     |  3 +++
 MAINTAINERS | 23 -----------------------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/CREDITS b/CREDITS
index cf8e23498a34..00d7b2b2f92c 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1933,6 +1933,9 @@ N: Kukjin Kim
 E: kgene@kernel.org
 D: Samsung S3C, S5P and Exynos ARM architectures
 
+N: Milo Kim
+D: TI LP855x, LP8727 and LP8788 drivers
+
 N: Sangbeom Kim
 E: sbkim73@samsung.com
 D: Samsung SoC Audio (ASoC) drivers
diff --git a/MAINTAINERS b/MAINTAINERS
index 4cf10cb2b858..a40200b33015 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17991,29 +17991,6 @@ S:	Maintained
 F:	sound/soc/codecs/isabelle*
 F:	sound/soc/codecs/lm49453*
 
-TI LP855x BACKLIGHT DRIVER
-M:	Milo Kim <milo.kim@ti.com>
-S:	Maintained
-F:	Documentation/driver-api/backlight/lp855x-driver.rst
-F:	drivers/video/backlight/lp855x_bl.c
-F:	include/linux/platform_data/lp855x.h
-
-TI LP8727 CHARGER DRIVER
-M:	Milo Kim <milo.kim@ti.com>
-S:	Maintained
-F:	drivers/power/supply/lp8727_charger.c
-F:	include/linux/platform_data/lp8727.h
-
-TI LP8788 MFD DRIVER
-M:	Milo Kim <milo.kim@ti.com>
-S:	Maintained
-F:	drivers/iio/adc/lp8788_adc.c
-F:	drivers/leds/leds-lp8788.c
-F:	drivers/mfd/lp8788*.c
-F:	drivers/power/supply/lp8788-charger.c
-F:	drivers/regulator/lp8788-*.c
-F:	include/linux/mfd/lp8788*.h
-
 TI NETCP ETHERNET DRIVER
 M:	Wingman Kwok <w-kwok2@ti.com>
 M:	Murali Karicheri <m-karicheri2@ti.com>
-- 
2.25.1

