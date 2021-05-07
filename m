Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FBA37688E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhEGQWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:22:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51203 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhEGQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:22:34 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lf3EL-00088Y-QK
        for linux-kernel@vger.kernel.org; Fri, 07 May 2021 16:21:33 +0000
Received: by mail-qk1-f200.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so6424292qkj.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 09:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XW/9mYiVYyeTStSYaXn6R4LsQC+ZiyYHwHd014oNij8=;
        b=OFkt3gSft4mr64hxLQCCtkGoeB2r9s4LaG1M+nNPq6Ck0XhnDuWiZ5enyMqcq0VhX1
         /AJKmu9lNr029/oMjRoqu6fiNpEW/VBBZeVhiG/BFQ56HdWY4q+fvhVZPSSBlpZ+C1nS
         whY8r3pNts/tgshQ1RajGhRrCBLMRkMF0/UvPT5zjr0kCyyAyr0dCGd4EVvw0qag9w5w
         UG2y9cokZGz1PL7tRP9jVQ6omGWRRp+widqB5s6jHh5qrOmfvAM0sn0o1FY8GZpH+/AA
         tSJyTX+NcR1kJjbLdO1WQYlAeWxMCNfBKYi+Aab7GL0nTWm4msx7r9G0mS1777m4/R4k
         zXSw==
X-Gm-Message-State: AOAM533134Vf2zfnuKCZ7mzB2o5uFIGPdbSDRD4mPeL4FDbYEyL3lQ7i
        ACJPAoI1ARhNm13dnaQrBNyqfxosdjqGt9HsALk4BKsTZ8muilPiIZBAQxgXfi+EMR65yZCrkel
        Bz1YIFYTdHQo1IH/d3gMMwospYTahbBs8yk4LGKZkwA==
X-Received: by 2002:a0c:bd13:: with SMTP id m19mr10619800qvg.29.1620404492932;
        Fri, 07 May 2021 09:21:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeTLsueDZAjedoM9qmR/TUIHVoHbW8SOlMK0023BrwGcAAfGdKnlBWj8QNSJ6uU2+0QlqFJQ==
X-Received: by 2002:a0c:bd13:: with SMTP id m19mr10619784qvg.29.1620404492706;
        Fri, 07 May 2021 09:21:32 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.1])
        by smtp.gmail.com with ESMTPSA id i5sm4991869qki.115.2021.05.07.09.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:21:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Matheus Castello <matheus@castello.eng.br>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RFT PATCH 1/3] power: supply: max17040: remove non-working POWER_SUPPLY_PROP_STATUS
Date:   Fri,  7 May 2021 12:19:25 -0400
Message-Id: <20210507161927.105862-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was reporting POWER_SUPPLY_PROP_STATUS via platform data
functions.  Without platform data, the max17040_get_status() functions
returns early with POWER_SUPPLY_STATUS_UNKNOWN.  Since there are no
platforms using the driver with platform data (no board files with the
driver), the status property was always unknown.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max17040_battery.c | 32 +++----------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 1aab868adabf..12854c87df53 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -147,8 +147,6 @@ struct max17040_chip {
 
 	/* battery capacity */
 	int soc;
-	/* State Of Charge */
-	int status;
 	/* Low alert threshold from 32% to 1% of the State of Charge */
 	u32 low_soc_alert;
 	/* some devices return twice the capacity */
@@ -225,24 +223,6 @@ static int max17040_get_online(struct max17040_chip *chip)
 		chip->pdata->battery_online() : 1;
 }
 
-static int max17040_get_status(struct max17040_chip *chip)
-{
-	if (!chip->pdata || !chip->pdata->charger_online
-			|| !chip->pdata->charger_enable)
-		return POWER_SUPPLY_STATUS_UNKNOWN;
-
-	if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
-		return POWER_SUPPLY_STATUS_FULL;
-
-	if (chip->pdata->charger_online())
-		if (chip->pdata->charger_enable())
-			return POWER_SUPPLY_STATUS_CHARGING;
-		else
-			return POWER_SUPPLY_STATUS_NOT_CHARGING;
-	else
-		return POWER_SUPPLY_STATUS_DISCHARGING;
-}
-
 static int max17040_get_of_data(struct max17040_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
@@ -283,7 +263,6 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 static void max17040_check_changes(struct max17040_chip *chip)
 {
 	chip->soc = max17040_get_soc(chip);
-	chip->status = max17040_get_status(chip);
 }
 
 static void max17040_queue_work(struct max17040_chip *chip)
@@ -302,17 +281,16 @@ static void max17040_stop_work(void *data)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
-	int last_soc, last_status;
+	int last_soc;
 
 	chip = container_of(work, struct max17040_chip, work.work);
 
-	/* store SOC and status to check changes */
+	/* store SOC to check changes */
 	last_soc = chip->soc;
-	last_status = chip->status;
 	max17040_check_changes(chip);
 
 	/* check changes and send uevent */
-	if (last_soc != chip->soc || last_status != chip->status)
+	if (last_soc != chip->soc)
 		power_supply_changed(chip->battery);
 
 	max17040_queue_work(chip);
@@ -415,9 +393,6 @@ static int max17040_get_property(struct power_supply *psy,
 	struct max17040_chip *chip = power_supply_get_drvdata(psy);
 
 	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = max17040_get_status(chip);
-		break;
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = max17040_get_online(chip);
 		break;
@@ -444,7 +419,6 @@ static const struct regmap_config max17040_regmap = {
 };
 
 static enum power_supply_property max17040_battery_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
-- 
2.25.1

