Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4EA440E5B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 13:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhJaMZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 08:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhJaMZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 08:25:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA16C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:22:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w1so1029271edd.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s77d0wvzKKrSJpucHvgANP4+TsflGbcPJf8/uZ/lNKk=;
        b=jRMbi4nqcs9a5JQkI0Cr9Cklz6leEzR3ZhtfiU9GMAHWdeGvXJIMuRdYU/fnXpL+Vv
         LDP1eoAXkY7FDTmwLwg7elB55SlOr2CQMd9O9rJEOA0UVuoHOEGuhhLzHPhmDoKOz3LS
         I4QBIWt7fbZUKyqjokfgEB4K8pL6di70v798gNlU4ZMJXCXak5cYE+qFpMraUW9HoKVs
         c6k5D2eoeZIBmvH0lWloBC1GXt1zeMnsptfLyHtp9hi9rR9E4/zd9Jw7nAZBNATj0KJV
         Y6CapdZrftViMNJUU0RBIP7aeTKhHyh//kDhuVFSgXqbRtF3Hi9mZhum1NCXf+hvehd9
         ch3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s77d0wvzKKrSJpucHvgANP4+TsflGbcPJf8/uZ/lNKk=;
        b=PV4SIAdkXREA4MghvPhNQPHtVFYf2xpANxTIilO9JiuOreUEfQm27NL0z6LUaHzhZy
         QY5Zma8UosRmMkpZeo8cVKN00vtKOr2pDgb0AVKoDFKjGMrEX1AL24sY88svJmetnz0R
         YgQDpiuiYfIUuu8FQTyw8qJnBBFKBm/yeKQsWECn0GeoeceoKnKsGxSgnI3Zngbt6+AZ
         +ih3XxIZ9c7iNYLAWmu81siRvK9m/wjqPznLCeHbdPFV9ewyyaql5ldSd0oAFNuztoPC
         CPP9XYNEzooOolf4iG+x9U7vLLFlmtKfg0kpFbasA09Gq3wDfyZzzthvbxZUaNt3CyIT
         iv5A==
X-Gm-Message-State: AOAM533/XQagbBkYVq/fC9QAgWKIQieJlP19IIt3pl2laarBqfcDu2EL
        0lkKjchI7fdpQqo4nXjccfY+Kg==
X-Google-Smtp-Source: ABdhPJz2UmDtjEDIFiKJVzl050VIheNsVtvLNBcQI6PpUy99DNfQmJS/VNOCYC0lRtZRsIXma21NUA==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr31049774edd.129.1635682949333;
        Sun, 31 Oct 2021 05:22:29 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id cw20sm3842945ejc.32.2021.10.31.05.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 05:22:28 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 07/12] watchdog: s3c2410: Implement a way to invert mask reg value
Date:   Sun, 31 Oct 2021 14:22:11 +0200
Message-Id: <20211031122216.30212-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211031122216.30212-1-semen.protsenko@linaro.org>
References: <20211031122216.30212-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On new Exynos chips (like Exynos850) the MASK_WDT_RESET_REQUEST register
is replaced with CLUSTERx_NONCPU_INT_EN, and its mask bit value meaning
was reversed: for new register the bit value "1" means "Interrupt
enabled", while for MASK_WDT_RESET_REQUEST register "1" means "Mask the
interrupt" (i.e. "Interrupt disabled").

Introduce "mask_reset_inv" boolean field in driver data structure; when
that field is "true", mask register handling function will invert the
value before setting it to the register.

This commit doesn't bring any functional change to existing devices, but
merely provides an infrastructure for upcoming chips support.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none): it's a new patch

 drivers/watchdog/s3c2410_wdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 4ac0a30e835e..2a61b6ea5602 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -92,6 +92,7 @@ MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, 0 to
  * timer reset functionality.
  * @mask_reset_reg: Offset in pmureg for the register that masks the watchdog
  * timer reset functionality.
+ * @mask_reset_inv: If set, mask_reset_reg value will have inverted meaning.
  * @mask_bit: Bit number for the watchdog timer in the disable register and the
  * mask reset register.
  * @rst_stat_reg: Offset in pmureg for the register that has the reset status.
@@ -103,6 +104,7 @@ MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, 0 to
 struct s3c2410_wdt_variant {
 	int disable_reg;
 	int mask_reset_reg;
+	bool mask_reset_inv;
 	int mask_bit;
 	int rst_stat_reg;
 	int rst_stat_bit;
@@ -219,7 +221,8 @@ static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
 static int s3c2410wdt_mask_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
 {
 	const u32 mask_val = BIT(wdt->drv_data->mask_bit);
-	const u32 val = mask ? mask_val : 0;
+	const bool val_inv = wdt->drv_data->mask_reset_inv;
+	const u32 val = (mask ^ val_inv) ? mask_val : 0;
 	int ret;
 
 	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->mask_reset_reg,
-- 
2.30.2

