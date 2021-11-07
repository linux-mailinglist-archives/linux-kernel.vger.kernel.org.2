Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D944475D4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhKGUdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbhKGUdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:33:00 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED90FC079782
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 12:30:03 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id e9so4997048ljl.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 12:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYPbwCTdXSeLj2E8hNZ5xJvTX/oX1QKrup+rCI0n0GU=;
        b=l7XIsIat7cITBgnm4maENgKMC+Y7J7fJ/mK/sH2dl3eA3h4R/EeX/SuFgaSEJxaJxr
         B/94BP9ZRfWomvUvwJc1KeJJ8jFd2s32fCyHr8AgLjvXZExUqOP7hDbuzWIsdjlURt13
         qLPti768pihZbETdBk9U0f8byDfRE2UcsNH5s4OAQ5fgi7wy9Hx8bzXlEbarj+03/rwN
         buxJ+oHffolblZ7ORH24pah1AhHVWUz+z8Mqh/obQyn88ao9Efc2f9iRqyFkEVneMd5I
         jM+qBnv2Tz7SikrDz6SgI4nazYLMpbf3llvvf/gmHC2mB9L4RlvhliwCugycZWUEY4so
         +fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYPbwCTdXSeLj2E8hNZ5xJvTX/oX1QKrup+rCI0n0GU=;
        b=kiGASzDWD/ztyiRr4aGvTc5J58SdmyvyM9hVE3RHKxx5S+0CJFZ2fOfn7C0VoSoWpT
         oiu9mkCn3oC8s1iK5FEard1bb+93dy+88iqNrvhLFrdlv1+9pWHck+N0COObguoH77H/
         0jGU9t67CbGsJ0dVMbfzqmEHwZcsLVHC7FzFPqWFKPiqwyaf5eKJYoGeZNOsjBrvoyf6
         EUgWBrhFwADUoh3AAGeCWxLdpxB+eWcG5Zt9uRTWijtZeEN2f6l1pHOU7B38jZVoafyI
         mFY+K7iOjMQrQGCOOJErWle1JUvBEkOmu9nWnNZjPQPqfohTfn8ESa4nzkCrbg+Ggu6X
         y9uA==
X-Gm-Message-State: AOAM531ymOm2Q34Id6Xnbck+BxP12VbQCh1ksbe0pXxhnJZuLNh96Kly
        Vzc8DL+jYAnsSxugoZaaoj9Lng==
X-Google-Smtp-Source: ABdhPJwTu42tk2TANGEmYJGt/w4gPIfSQ4+LZa/SlLrThYgnXPaXbWuuGN+wsh0Z9MIecE13uJhsXg==
X-Received: by 2002:a05:651c:1605:: with SMTP id f5mr74693331ljq.232.1636317002197;
        Sun, 07 Nov 2021 12:30:02 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id 13sm1571159lfq.285.2021.11.07.12.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 12:30:01 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 10/12] watchdog: s3c2410: Support separate source clock
Date:   Sun,  7 Nov 2021 22:29:41 +0200
Message-Id: <20211107202943.8859-11-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107202943.8859-1-semen.protsenko@linaro.org>
References: <20211107202943.8859-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now all devices supported in the driver have the single clock: it
acts simultaneously as a bus clock (providing register interface
clocking) and source clock (driving watchdog counter). Some newer Exynos
chips, like Exynos850, have two separate clocks for that. In that case
two clocks will be passed to the driver from the resource provider, e.g.
Device Tree. Provide necessary infrastructure to support that case:
  - use source clock's rate for all timer related calculations
  - use bus clock to gate/ungate the register interface

All devices that use the single clock are kept intact: if only one clock
is passed from Device Tree, it will be used for both purposes as before.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - Removed has_src_clk field: clk framework can handle NULL clk; added
    s3c2410wdt_get_freq() function instead, to figure out which clock to
    use for getting the rate

Changes in v2:
  - Reworded commit message to be more formal
  - Used separate "has_src_clk" trait to tell if source clock is present
  - Renamed clock variables to match their purpose
  - Removed caching source clock rate, obtaining it in place each time
    instead
  - Renamed err labels for more consistency

 drivers/watchdog/s3c2410_wdt.c | 56 +++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index f211be8bf976..f31bc765a8a5 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -153,7 +153,8 @@ struct s3c2410_wdt_variant {
 
 struct s3c2410_wdt {
 	struct device		*dev;
-	struct clk		*clock;
+	struct clk		*bus_clk; /* for register interface (PCLK) */
+	struct clk		*src_clk; /* for WDT counter */
 	void __iomem		*reg_base;
 	unsigned int		count;
 	spinlock_t		lock;
@@ -231,9 +232,14 @@ MODULE_DEVICE_TABLE(platform, s3c2410_wdt_ids);
 
 /* functions */
 
-static inline unsigned int s3c2410wdt_max_timeout(struct clk *clock)
+static inline unsigned long s3c2410wdt_get_freq(struct s3c2410_wdt *wdt)
 {
-	unsigned long freq = clk_get_rate(clock);
+	return clk_get_rate(wdt->src_clk ? wdt->src_clk : wdt->bus_clk);
+}
+
+static inline unsigned int s3c2410wdt_max_timeout(struct s3c2410_wdt *wdt)
+{
+	const unsigned long freq = s3c2410wdt_get_freq(wdt);
 
 	return S3C2410_WTCNT_MAXCNT / (freq / (S3C2410_WTCON_PRESCALE_MAX + 1)
 				       / S3C2410_WTCON_MAXDIV);
@@ -383,7 +389,7 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd,
 				    unsigned int timeout)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
-	unsigned long freq = clk_get_rate(wdt->clock);
+	unsigned long freq = s3c2410wdt_get_freq(wdt);
 	unsigned int count;
 	unsigned int divisor = 1;
 	unsigned long wtcon;
@@ -632,26 +638,42 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	wdt->clock = devm_clk_get(dev, "watchdog");
-	if (IS_ERR(wdt->clock)) {
-		dev_err(dev, "failed to find watchdog clock source\n");
-		ret = PTR_ERR(wdt->clock);
+	wdt->bus_clk = devm_clk_get(dev, "watchdog");
+	if (IS_ERR(wdt->bus_clk)) {
+		dev_err(dev, "failed to find bus clock\n");
+		ret = PTR_ERR(wdt->bus_clk);
 		goto err;
 	}
 
-	ret = clk_prepare_enable(wdt->clock);
+	ret = clk_prepare_enable(wdt->bus_clk);
 	if (ret < 0) {
-		dev_err(dev, "failed to enable clock\n");
+		dev_err(dev, "failed to enable bus clock\n");
 		return ret;
 	}
 
+	/*
+	 * "watchdog_src" clock is optional; if it's not present -- just skip it
+	 * and use "watchdog" clock as both bus and source clock.
+	 */
+	wdt->src_clk = devm_clk_get(dev, "watchdog_src");
+	if (!IS_ERR(wdt->src_clk)) {
+		ret = clk_prepare_enable(wdt->src_clk);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable source clock\n");
+			ret = PTR_ERR(wdt->src_clk);
+			goto err_bus_clk;
+		}
+	} else {
+		wdt->src_clk = NULL;
+	}
+
 	wdt->wdt_device.min_timeout = 1;
-	wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt->clock);
+	wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt);
 
 	ret = s3c2410wdt_cpufreq_register(wdt);
 	if (ret < 0) {
 		dev_err(dev, "failed to register cpufreq\n");
-		goto err_clk;
+		goto err_src_clk;
 	}
 
 	watchdog_set_drvdata(&wdt->wdt_device, wdt);
@@ -729,8 +751,11 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
  err_cpufreq:
 	s3c2410wdt_cpufreq_deregister(wdt);
 
- err_clk:
-	clk_disable_unprepare(wdt->clock);
+ err_src_clk:
+	clk_disable_unprepare(wdt->src_clk);
+
+ err_bus_clk:
+	clk_disable_unprepare(wdt->bus_clk);
 
  err:
 	return ret;
@@ -749,7 +774,8 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 
 	s3c2410wdt_cpufreq_deregister(wdt);
 
-	clk_disable_unprepare(wdt->clock);
+	clk_disable_unprepare(wdt->src_clk);
+	clk_disable_unprepare(wdt->bus_clk);
 
 	return 0;
 }
-- 
2.30.2

