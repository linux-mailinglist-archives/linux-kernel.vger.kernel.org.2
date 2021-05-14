Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB738059D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhENI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhENI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:56:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8248C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:55:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t15so6202305edr.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8hS70I1OP3BGBi55KMUKhZ8NUqBfuKwEk/1jKvD89Tc=;
        b=sNDt00YtYYATKB+/+HmFsyPqLmPazpMGXY8lo+0xQbxa/CP3DCupoZDw8xzBpIcoVi
         gHWh5BIUqoj+baT7E0578NQu2/m5QqetCzHL7UUkjvYCR7NI/SoiFx2gddfhmQE5NClm
         F9RJXMInhU+jtgrm9iQKDT/6bVAzDNaXxBnc+b0VmsF+99HKyBjEOefVEHKbsc2gLNbR
         oo1Tk3P3YWf7zQTH4lH8UNMIE0q8Jl3yxAZjT1ZXtaHqtIllY0qCqxVSjqTtzSiLNyfV
         UTeK5Fs3c7Z0NpnYelQVN1dGFePHz+C3DgSRuDKmWwm+JOPEEfgTPRuyG1+D/oYWepj+
         Mohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8hS70I1OP3BGBi55KMUKhZ8NUqBfuKwEk/1jKvD89Tc=;
        b=YRtHNt3u7454kggHwE4ca7gs5TBtLFHm2AAylEynK3YxLdX98vFDAafoB45R07zsf0
         Jz2lA73MJKIYqCQXYYYvA7tdrKkCOssiDCgcY+ZaGPobhJEPHtLlN0YuoqPu940/53zf
         GYlRjIxSbCUPLxXDwaaV+f/d9asS4uiumBItrSc5eKbkRboSOoAiGuWf6UGdqY58WSj+
         1K3C3/btD7XHD1rqaLAFYxoRdDBuoplbpkjcxXAofcH7ev8nmDPsw1yu+wRDo15zQDJQ
         toJSxxEeDtOCCOieE/5iIJWmnkoEXxvkXps8iCiAMEnFmqys4QsEp+MnqWxRyJ+22CoS
         aTaQ==
X-Gm-Message-State: AOAM5326FEOTxZyWcY5W56wx9su18BaMeIDem3NQZQv8MVnwLKUc3tqO
        JSmyR9pMLYt7Uo/HDM+R3lunpA==
X-Google-Smtp-Source: ABdhPJxFPTzi70JPIGbujAw6X1JyfuQW/pbecxxq2Sz/l2U3aJ5OtSKv15VeGC8aBFUwXOXbb5dRXg==
X-Received: by 2002:a05:6402:cb0:: with SMTP id cn16mr54456013edb.15.1620982510375;
        Fri, 14 May 2021 01:55:10 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id p4sm3249329ejr.81.2021.05.14.01.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 01:55:09 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        nobuhiro1.iwamatsu@toshiba.co.jp,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-visconti: remove platform_set_drvdata() + cleanup probe
Date:   Fri, 14 May 2021 11:55:00 +0300
Message-Id: <20210514085500.10761-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_set_drvdata() call is only useful if we need to retrieve back
the private information.
Since the driver doesn't do that, it's not useful to have it.

If this is removed, we can also just do a direct return on
devm_gpiochip_add_data(). We don't need to print that this call failed as
there are other ways to log/see this during probe.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/gpio/gpio-visconti.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-visconti.c b/drivers/gpio/gpio-visconti.c
index 0e3d19828eb1..47455810bdb9 100644
--- a/drivers/gpio/gpio-visconti.c
+++ b/drivers/gpio/gpio-visconti.c
@@ -187,15 +187,7 @@ static int visconti_gpio_probe(struct platform_device *pdev)
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
 
-	ret = devm_gpiochip_add_data(dev, &priv->gpio_chip, priv);
-	if (ret) {
-		dev_err(dev, "failed to add GPIO chip\n");
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, priv);
-
-	return ret;
+	return devm_gpiochip_add_data(dev, &priv->gpio_chip, priv);
 }
 
 static const struct of_device_id visconti_gpio_of_match[] = {
-- 
2.31.1

