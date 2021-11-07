Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F84475C5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhKGUcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236521AbhKGUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:32:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEABFC061746
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 12:29:57 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi35so31555465lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 12:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WvSdbDOGkJMWFwlueKJ7OSnxuu3S90DVplyKp+a4Js=;
        b=OB6JCw3XmoDqOjnlMDJkbVgti6ueJnByCDUtaZnVZv92Goc+QJLtn/vr6QCdjb17mZ
         z7+/6ghtTVY5NEKgKqp5rGORTCjMVLuUMCNkb8NKu8Ra1Cd3QrlFsUkuWiVb08MqEIvZ
         11sE5Xro5Yyq+Zw0jktwSFnCgMJmxLHeFd7w9GcIJSmvX/Abuo8nminRK74nkRSkbKQy
         fqJXqIuV3xMqPvPJgj0IvkMtCnpNWyRm5L0PaTy0Hzl/EeMnex6o2P+3cIlCVjuc0Zaq
         8cIWT5pJScvwa4zH6PJqaM3wRpCcSW84EqjoCb5t3unfykCorAepYxFlGMEequ8sCfoX
         6xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WvSdbDOGkJMWFwlueKJ7OSnxuu3S90DVplyKp+a4Js=;
        b=XBRTuUHXWH0YKYmUKVI9iip0lmt+z1r5lxJ1snNY33r7FDN8sIgb320W5IEnBmMUYH
         MTfcTuNYkmCxgX6vkBeT0hOTB9qPJgBSR6FD/0PZsZU9eAV1r5EPCqVHtgF7bMP4CEfB
         hFY34EevRv1If2rdf/L0lBAsgy//498ZrfIHN4yShAkSg4igN8AN07OeBZnO5LAVquJU
         BJDS1M5XG1ctXoikTKwH0TJnWwEB3ILtcO53jf5tTtw7H3WlylXFRsJefWHAcMqlD2T1
         pjatUW6Ncg/kloN0pAL0SAKQ1zWABZMBsBK9I5UlBj9X4AC6bueXMa9oqZrbX6avsg0i
         mwMg==
X-Gm-Message-State: AOAM532DVGaAIVmc0B/AM3caEdfAIi9xUgilAGsoOSVniE4T3zY4evrJ
        egiTrbt4SFMaHXLHq+MqLLq/aA==
X-Google-Smtp-Source: ABdhPJyMqo5JVtbOKHlcu+SXEbG0CiLH2F8CqaGM+3Zy8I90GVOq0Cfjc9m9GFiRm47l894XIR6Xgw==
X-Received: by 2002:a05:6512:104e:: with SMTP id c14mr7626046lfb.30.1636316996150;
        Sun, 07 Nov 2021 12:29:56 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id b12sm1575370lfb.212.2021.11.07.12.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 12:29:55 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 06/12] watchdog: s3c2410: Extract disable and mask code into separate functions
Date:   Sun,  7 Nov 2021 22:29:37 +0200
Message-Id: <20211107202943.8859-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107202943.8859-1-semen.protsenko@linaro.org>
References: <20211107202943.8859-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s3c2410wdt_mask_and_disable_reset() function content is bound to be
changed further. Prepare it for upcoming changes by splitting into
separate "mask reset" and "disable reset" functions. But keep
s3c2410wdt_mask_and_disable_reset() function present as a facade.

This commit doesn't bring any functional change to existing devices, but
merely provides an infrastructure for upcoming chips support.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
Changes in v3:
  - Added R-b tag by Krzysztof Kozlowski

Changes in v2:
  - (none): it's a new patch

 drivers/watchdog/s3c2410_wdt.c | 54 ++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 2cc4923a98a5..4ac0a30e835e 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -202,37 +202,53 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
 	return container_of(nb, struct s3c2410_wdt, freq_transition);
 }
 
-static int s3c2410wdt_mask_and_disable_reset(struct s3c2410_wdt *wdt, bool mask)
+static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
 {
+	const u32 mask_val = BIT(wdt->drv_data->mask_bit);
+	const u32 val = mask ? mask_val : 0;
 	int ret;
-	u32 mask_val = 1 << wdt->drv_data->mask_bit;
-	u32 val = 0;
 
-	/* No need to do anything if no PMU CONFIG needed */
-	if (!(wdt->drv_data->quirks & QUIRK_HAS_PMU_CONFIG))
-		return 0;
+	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->disable_reg,
+				 mask_val, val);
+	if (ret < 0)
+		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
 
-	if (mask)
-		val = mask_val;
+	return ret;
+}
 
-	if (wdt->drv_data->quirks & QUIRK_HAS_PMU_AUTO_DISABLE) {
-		ret = regmap_update_bits(wdt->pmureg,
-					 wdt->drv_data->disable_reg, mask_val,
-					 val);
-		if (ret < 0)
-			goto error;
-	}
+static int s3c2410wdt_mask_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
+{
+	const u32 mask_val = BIT(wdt->drv_data->mask_bit);
+	const u32 val = mask ? mask_val : 0;
+	int ret;
 
-	ret = regmap_update_bits(wdt->pmureg,
-			wdt->drv_data->mask_reset_reg,
-			mask_val, val);
- error:
+	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->mask_reset_reg,
+				 mask_val, val);
 	if (ret < 0)
 		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
 
 	return ret;
 }
 
+static int s3c2410wdt_mask_and_disable_reset(struct s3c2410_wdt *wdt, bool mask)
+{
+	int ret;
+
+	if (wdt->drv_data->quirks & QUIRK_HAS_PMU_AUTO_DISABLE) {
+		ret = s3c2410wdt_disable_wdt_reset(wdt, mask);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (wdt->drv_data->quirks & QUIRK_HAS_PMU_CONFIG) {
+		ret = s3c2410wdt_mask_wdt_reset(wdt, mask);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
-- 
2.30.2

