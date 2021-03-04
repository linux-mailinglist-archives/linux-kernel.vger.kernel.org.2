Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C008E32DCC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhCDWM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhCDWMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:12:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E71C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 14:12:54 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id d13so32020187edp.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 14:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCo3mKQIbcpollGcJ9PYHtksoboB7Ro207jOYrCfzdo=;
        b=g1Zn6sewFIleBOXnOHM71n+XqDprG9IKVcU3vrwC/LmP7RiEYZWioiuOo6u8eay8rp
         1efpcjma6Y7hUyfQyOqliLwpMX7YVcRtMkHFwd4IttHF9G22LrA/mMggvqUZaqDgqmU1
         133cDV7S24kpbxsZu8wG18e2IJ81VwzKnsak4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCo3mKQIbcpollGcJ9PYHtksoboB7Ro207jOYrCfzdo=;
        b=mftD3rgzCDUG8FczhvsY5Ckxem7tpTdhRlIazzD4FAFNXm+e+io+yMEaPRZcXJohNt
         rgD4kPHkzqHm02zhPlQlTcKPO8lzlAbJxougjJYSziWjZPL/jJQ8BAXy0S0FqLyI2aos
         xfhdKiUfCybqUCiLNlYB6H7HUbcL1WvpeG1d3b9y09iyxyChiWfUqfdfo7o+r8AzIlY3
         IXxSJbSyWxGByuQrgsJFjn+PN7NJEywI5MvYqGtyNOSniT50EFJeMghGrbKffb73Llmq
         S62fL5p3PsP0Ot1AarCjcrB2dRDJm5CKh1Ts4VSkHQ2Etlw+eD6f5KlbpNYY1lbyp4bz
         +xVg==
X-Gm-Message-State: AOAM5333jUGLLYADnNImhkHUUFqOcJ7AWz4jd93lg34b8mAlUvs2y8cF
        Z4fyrdHckuEEHMFx7k/uZ8YTfAD+1Ep/lA==
X-Google-Smtp-Source: ABdhPJzme5MAAWpf/zramDLF/Q+YNk0uNjfX+zRiBm3mY5cw1s0ZQPbrq+hYw2HTPbmIl+2U4okoLg==
X-Received: by 2002:aa7:cd8c:: with SMTP id x12mr6809476edv.355.1614895972903;
        Thu, 04 Mar 2021 14:12:52 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id q22sm362099ejy.5.2021.03.04.14.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 14:12:52 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 3/3] watchdog: gpio_wdt: implement support for optional "delay" clock
Date:   Thu,  4 Mar 2021 23:12:47 +0100
Message-Id: <20210304221247.488173-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304221247.488173-1-linux@rasmusvillemoes.dk>
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210304221247.488173-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[DO NOT MERGE - see cover letter]

We have a board where the reset output from the ADM706S is split in
two: directly routed to an interrupt, and also to start a ripple
counter, which 64 ms later than pulls the SOC's reset pin. That ripple
counter only works if the RTC's 32kHz output is enabled, and since
linux by default disables unused clocks, that effectively renders the
watchdog useless.

Add driver support for an optional "delay" clock, as documented in the
preceding patch.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/watchdog/gpio_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 0923201ce874..f812c39bc1e8 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/gpio/consumer.h>
@@ -111,6 +112,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	enum gpiod_flags gflags;
 	unsigned int hw_margin;
 	const char *algo;
+	struct clk *clk;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -164,6 +166,13 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (priv->always_running)
 		gpio_wdt_start(&priv->wdd);
 
+	clk = devm_clk_get_optional(dev, "delay");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	ret = devm_clk_prepare_enable(dev, clk);
+	if (ret)
+		return ret;
+
 	return devm_watchdog_register_device(dev, &priv->wdd);
 }
 
-- 
2.29.2

