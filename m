Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB0440E4F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 13:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhJaMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 08:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhJaMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 08:24:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C178EC061767
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:22:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g8so55261633edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LNl1brM/0oXFKhQmO4fHWOzGU7TOB+zbc6A9TEvFH+g=;
        b=Mt4GxUwluXo6qfBzqJMCobzIh/e7NlPjR790yx6wBKljB2HMFxyT7ed8dNUBNwYMid
         Ruxtc072sOhL/BHpKkDoqR8HiMNg3zYpqbIMIlsIixVI3xjgWTmtOjTJQX/VFivOGE17
         12RRSAqhQ6gIHBH7/HMSzFfIQflHwIhbt6QbFu6F8kyZyVGUiWhR7b8p0bpUMEXgKV/R
         yX6Tu1D9pRFMz4QTRFgksACTUvj2/jQ9bCqXg3Ro1CzswG326XRVp7efQqhVbord/cIv
         dmYn2evhkTa34BXF6wcbHrmmat8kIGiUGfIMud3UsS9Y5lNDqZsRyCLUU2ZsydSKgp69
         D2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNl1brM/0oXFKhQmO4fHWOzGU7TOB+zbc6A9TEvFH+g=;
        b=TvEH90kZ41YZXmZhqXy3U1H3MorYfCjvXUjX5OEYTLkQPcFRy65j3576xAQLGPdFZc
         KfKCcGjbk9TWSOPZjShcKSnYwEQebV0aS18lHQo6Mc4yS+oxzsXOi96KliOyr5yFCJ9j
         vReo+8EK9VGAI4huu3aFz0WUu7DujTRlXHL77fc3a0yDDtrMCVJrxkrojs2U9m+4wUrz
         JAtwMEs39U3Jbx31dOmCkYmJjq7DgNUrhIw0w7vKswGcgH356AIgupAzW4xKs8MMPMeu
         tuJbkgxZ0GC07anX3THO60ROtlKbqGyeM1SLux7i04tfvULzdw1IT6AfXSwTeZDgUHDO
         Bn1Q==
X-Gm-Message-State: AOAM533v0a//Ce2BdtvuTouYTbho+ZC/aZggJVENQN7JsuROYCDUo/m9
        bA5yHO3/RENRA4QJFMQHtX3H3Q==
X-Google-Smtp-Source: ABdhPJyJ0+tkYyi6vFJFEgzcRpei2xggOdrZBJZMRcg/vJFYotRsaVbIQq2Qbf0/XD5FsOzRz95udw==
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr3212732edx.395.1635682944363;
        Sun, 31 Oct 2021 05:22:24 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id u23sm6983345edr.97.2021.10.31.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 05:22:23 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 04/12] watchdog: s3c2410: Let kernel kick watchdog
Date:   Sun, 31 Oct 2021 14:22:08 +0200
Message-Id: <20211031122216.30212-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211031122216.30212-1-semen.protsenko@linaro.org>
References: <20211031122216.30212-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "tmr_atboot" module param is set, the watchdog is started in
driver's probe. In that case, also set WDOG_HW_RUNNING bit to let
watchdog core driver know it's running. This way watchdog core can kick
the watchdog for us (if CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED option is
enabled), until user space takes control.

WDOG_HW_RUNNING bit must be set before registering the watchdog. So the
"tmr_atboot" handling code is moved before watchdog registration, to
avoid performing the same check twice. This is also logical because
WDOG_HW_RUNNING bit makes WDT core expect actually running watchdog.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Added explanation on moving the code block to commit message
  - [PATCH 03/12] handles the case when tmr_atboot is present but valid
    timeout wasn't found

 drivers/watchdog/s3c2410_wdt.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 00421cf22556..0845c05034a1 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -604,6 +604,21 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	wdt->wdt_device.bootstatus = s3c2410wdt_get_bootstatus(wdt);
 	wdt->wdt_device.parent = dev;
 
+	/*
+	 * If "tmr_atboot" param is non-zero, start the watchdog right now. Also
+	 * set WDOG_HW_RUNNING bit, so that watchdog core can kick the watchdog.
+	 *
+	 * If we're not enabling the watchdog, then ensure it is disabled if it
+	 * has been left running from the bootloader or other source.
+	 */
+	if (tmr_atboot) {
+		dev_info(dev, "starting watchdog timer\n");
+		s3c2410wdt_start(&wdt->wdt_device);
+		set_bit(WDOG_HW_RUNNING, &wdt->wdt_device.status);
+	} else {
+		s3c2410wdt_stop(&wdt->wdt_device);
+	}
+
 	ret = watchdog_register_device(&wdt->wdt_device);
 	if (ret)
 		goto err_cpufreq;
@@ -612,17 +627,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_unregister;
 
-	if (tmr_atboot) {
-		dev_info(dev, "starting watchdog timer\n");
-		s3c2410wdt_start(&wdt->wdt_device);
-	} else {
-		/* if we're not enabling the watchdog, then ensure it is
-		 * disabled if it has been left running from the bootloader
-		 * or other source */
-
-		s3c2410wdt_stop(&wdt->wdt_device);
-	}
-
 	platform_set_drvdata(pdev, wdt);
 
 	/* print out a statement of readiness */
-- 
2.30.2

