Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D64475B8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhKGUck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhKGUcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:32:36 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398A2C061208
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 12:29:52 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id i63so206026lji.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 12:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lj9NeaWb79mXFwj71iu93EU8KXH6mdMUVf2fcebYSxI=;
        b=ymRvvAXWIhYda+K0PwHaihL31QnlqkaRxA9dkSTpncZWtiXOf7CbLCOmPJwkyPe2cc
         3Lx7gi4rkrVnV4PTzs8eG7tpcQpMtny/ZX97Zzr0cmcmaKulesL0BFI5b8z9R1/BM5G3
         DhyXH4LwV+2H9OxvaGmPsmA8J0wpNysfgmPw6bbLpRie3DWOcP7RuDSrvDJ2p64KUIA8
         2mCe3K0QIaGzY2jlRYD4P2gKq2DCOCxObCocNKb08t6TwIZdlsjTrCjb42UcRUMVYy9G
         q9xZsMKHzlo4S+bRQNlNplY04Is1FbmHqIyNygWc1xmvOqY7z8Yy0h/6je15YdEmlT/F
         Nkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lj9NeaWb79mXFwj71iu93EU8KXH6mdMUVf2fcebYSxI=;
        b=7HAxvzDyw/LfE5kmlSmEarM7zMJpau2AH9APYHmfTX60rOapxt1jQc00sbVK8Qtm86
         IJZJtgOV9KPm2xHhZSUlp1oyGCe/01L/4uHF2r49gz1VQWDyMTFSNonlNINQAlY2ZenP
         /LuR53M0nFwpiXcLONC7wOSBdZyxX6Yqr1jL4WNjheTUFp2JXrhArShTBnRALXv1V1zN
         jo9GSn6W0Hl/caU16EqlwhaPX0bcg+kap2Uv7IMZIuOPUZSIYJDyhPTn8Wzp55ZOjYYP
         nuYrTqEPq9nAMP1bOYNgIPriKa7KmV9m3JK4B23q1aErI0BM8KtgP2Rx/d5588GIIVSu
         N/mQ==
X-Gm-Message-State: AOAM533FAp6J5p/DmzUpzzno9JUb5Vy3W8GraordiJoNZZ0KZ/xF4WG0
        ENmklQZfpQ7JBh2Ldi5tlF7XNg==
X-Google-Smtp-Source: ABdhPJz26YA3soNYgOodYqUw5+Hg3uqwT4KvuIYqs+qWfXgJk3TLTWBNXEqhmPprqZUpkNNw8b8YuQ==
X-Received: by 2002:a2e:9a8c:: with SMTP id p12mr10186084lji.526.1636316990633;
        Sun, 07 Nov 2021 12:29:50 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id bq3sm1572994lfb.173.2021.11.07.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 12:29:50 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 03/12] watchdog: s3c2410: Fail probe if can't find valid timeout
Date:   Sun,  7 Nov 2021 22:29:34 +0200
Message-Id: <20211107202943.8859-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107202943.8859-1-semen.protsenko@linaro.org>
References: <20211107202943.8859-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver can't work properly if there no valid timeout was found in
s3c2410wdt_set_heartbeat(). Ideally, that function should be reworked in
a way that it's always able to find some valid timeout. As a temporary
solution let's for now just fail the driver probe in case the valid
timeout can't be found in s3c2410wdt_set_heartbeat() function.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
Changes in v3:
  - Added R-b tag by Krzysztof Kozlowski

Changes in v2:
  - (none): it's a new patch

 drivers/watchdog/s3c2410_wdt.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 2395f353e52d..00421cf22556 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -515,7 +515,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	struct s3c2410_wdt *wdt;
 	struct resource *wdt_irq;
 	unsigned int wtcon;
-	int started = 0;
 	int ret;
 
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
@@ -581,15 +580,15 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	ret = s3c2410wdt_set_heartbeat(&wdt->wdt_device,
 					wdt->wdt_device.timeout);
 	if (ret) {
-		started = s3c2410wdt_set_heartbeat(&wdt->wdt_device,
-					S3C2410_WATCHDOG_DEFAULT_TIME);
-
-		if (started == 0)
-			dev_info(dev,
-				 "tmr_margin value out of range, default %d used\n",
+		ret = s3c2410wdt_set_heartbeat(&wdt->wdt_device,
+					       S3C2410_WATCHDOG_DEFAULT_TIME);
+		if (ret == 0) {
+			dev_warn(dev, "tmr_margin value out of range, default %d used\n",
 				 S3C2410_WATCHDOG_DEFAULT_TIME);
-		else
-			dev_info(dev, "default timer value is out of range, cannot start\n");
+		} else {
+			dev_err(dev, "failed to use default timeout\n");
+			goto err_cpufreq;
+		}
 	}
 
 	ret = devm_request_irq(dev, wdt_irq->start, s3c2410wdt_irq, 0,
@@ -613,10 +612,10 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_unregister;
 
-	if (tmr_atboot && started == 0) {
+	if (tmr_atboot) {
 		dev_info(dev, "starting watchdog timer\n");
 		s3c2410wdt_start(&wdt->wdt_device);
-	} else if (!tmr_atboot) {
+	} else {
 		/* if we're not enabling the watchdog, then ensure it is
 		 * disabled if it has been left running from the bootloader
 		 * or other source */
-- 
2.30.2

