Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB26F4584FB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 17:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhKURAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbhKURAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:00:03 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B25FC061756
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 08:56:57 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id t26so68943651lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tE2PiK+QMQdzrBf8Dn3otgisMDlF9CZ6ayfu9Pqan/0=;
        b=wJJjrI9KQ1gy1JLj2pqrhYhpVx2I4yCGCfCY1iXFWeKef6mhs2XYqYDn2ZqIzEEhxn
         0T+JG0jQ+iDiILi9nQNWvVbwoxWSvBgYpn9fYJP3/su1EvmLDCePDfTw1TF7CZ/AxW8a
         kOuZSlMjf5kKegAByRENXn46VmOkdXZWvRB8uh2b/IqjPy5crxVXtQGd9MEL6AT5IsAm
         +QJIOAD9Z+660bLSRACt7dytw43M8er13Lo2OATzLKLZT5AazBTRgLTx4iZ4qwmIiWIm
         e5EGvB9bK3lob1Df34SVbQS1mK24pxlQqI22prqpc2zGZNSwZAiupGHwGFtUlYkRwpq5
         ZBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tE2PiK+QMQdzrBf8Dn3otgisMDlF9CZ6ayfu9Pqan/0=;
        b=Bzb5VLCCN78R4jNZYngaroP61CFCiNPBZ3a4NjchH8x2DuXvQQP2goqC43G8XfmVIB
         69tOd3D0mgPhCex/pu+ZzxUvUugdNhOmf+OjUJdekqCm/M349xzkF37zDqONEDG2HYc4
         yb6SaOVO2cNNKikSQQn3d8Lddy8nXbUUHCLHAMC1ftoaEHnoMgcdXGnRhLWGp15gW1xf
         JlP14EvOrz8QGw9n62UwxevlgWGifvuZeFt8b/eO4EUgiZSINQ/qjqsvw5t0rIgW6B6l
         sLdiZAB2IICkCHWMAk+u81LaqVuIFVx/+/GWWTy/s58oetCIV4wT7eYcvI39FJ7HwR+e
         6UNg==
X-Gm-Message-State: AOAM532r7IxONJMod6FhXfq8LX2uRBIa6Bh7XzzY096qVYzge7ycQofB
        tDrpCyyoFHN09CSYXbXtEcgeoQ==
X-Google-Smtp-Source: ABdhPJz+n0rvNN4I1ZmBuqTiIEefxy+ISO/6NkZz+svWmRjzF7gYCrkFN1SmNxZjkbYdqbiaPXQ7ug==
X-Received: by 2002:ac2:4e0d:: with SMTP id e13mr49222025lfr.388.1637513815870;
        Sun, 21 Nov 2021 08:56:55 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id b43sm601297ljr.64.2021.11.21.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 08:56:55 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v4 04/12] watchdog: s3c2410: Let kernel kick watchdog
Date:   Sun, 21 Nov 2021 18:56:39 +0200
Message-Id: <20211121165647.26706-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211121165647.26706-1-semen.protsenko@linaro.org>
References: <20211121165647.26706-1-semen.protsenko@linaro.org>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v4:
  - Added R-b tag by Guenter Roeck

Changes in v3:
  - Added R-b tag by Krzysztof Kozlowski

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

