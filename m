Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B398F3080DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhA1V61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:58:27 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33357 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA1V6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:58:25 -0500
Received: by mail-oi1-f170.google.com with SMTP id j25so7762936oii.0;
        Thu, 28 Jan 2021 13:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oi+jj4jyM6o4x4t/G9Vfw4M3TkZ0bSPXjbhpoD8d3As=;
        b=AXWA4czM6aY+3iEAEkWOweT+DsGAIWZTpK3v2c2igRJB4l0iVa8RgLH/xtOH1rQvO3
         9FNne6ydrq5efJobXv1p/5IpD/n5uNxxRLru5WRk0pyUW+p0gdpb+CO1BGCQ5VYgLJ1k
         NCOL1/apadIrndfAzeLpP1PeAYH4yJ9am4o2xiiL4gIK3SfYdUwpFyEGpYmJ4JwG2vXf
         76sR1QmxDWAlBC51LILolfVZgF+tamEW6vFA1eHFqjytc0lMzYShk7YNYFyvzUfIfMHf
         YXiWJU+7uI+RN8D1uHW+qx3Fe3hZirLMlAOgtRlSX6087WM6vIaPrKJiZ2EZlF43HXhW
         hXPQ==
X-Gm-Message-State: AOAM5327KTzONpCSuihL1yF9bo82cWJrCX12CL/XbOxj6qNFLvouZEFK
        NmMMEDaHphdk4eOKP1h32hDtmyQZTw==
X-Google-Smtp-Source: ABdhPJztO2dc4PKkvUTvLMfZF+OFO3v0shgbf9P3mksl//11WLkSKf1juvWwARIjm563fpCwJ4H2Pg==
X-Received: by 2002:aca:cc15:: with SMTP id c21mr877619oig.154.1611871064310;
        Thu, 28 Jan 2021 13:57:44 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t16sm1312777otq.17.2021.01.28.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 13:57:43 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3] hwmon: (lm70) Use device_get_match_data()
Date:   Thu, 28 Jan 2021 15:57:42 -0600
Message-Id: <20210128215742.983036-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

Use the more modern API to get the match data out of the of match table.
This saves some code, lines, and nicely avoids referencing the match
table when it is undefined with configurations where CONFIG_OF=n.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-hwmon@vger.kernel.org>
[robh: rework to use device_get_match_data()]
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- Reworked to use device_get_match_data(). Lifted Stephen's commit 
  message from another patch. :)

Please ack and I'll add to the rest of the series.

 drivers/hwmon/lm70.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index ae2b84263a44..40eab3349904 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -22,9 +22,9 @@
 #include <linux/hwmon.h>
 #include <linux/mutex.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/of_device.h>
 #include <linux/acpi.h>
 
 #define DRVNAME		"lm70"
@@ -173,25 +173,15 @@ MODULE_DEVICE_TABLE(acpi, lm70_acpi_ids);
 
 static int lm70_probe(struct spi_device *spi)
 {
-	const struct of_device_id *of_match;
 	struct device *hwmon_dev;
 	struct lm70 *p_lm70;
 	int chip;
 
-	of_match = of_match_device(lm70_of_ids, &spi->dev);
-	if (of_match)
-		chip = (int)(uintptr_t)of_match->data;
-	else {
-#ifdef CONFIG_ACPI
-		const struct acpi_device_id *acpi_match;
+	if (dev_fwnode(&spi->dev))
+		chip = (int)(uintptr_t)device_get_match_data(&spi->dev);
+	else
+		chip = spi_get_device_id(spi)->driver_data;
 
-		acpi_match = acpi_match_device(lm70_acpi_ids, &spi->dev);
-		if (acpi_match)
-			chip = (int)(uintptr_t)acpi_match->driver_data;
-		else
-#endif
-			chip = spi_get_device_id(spi)->driver_data;
-	}
 
 	/* signaling is SPI_MODE_0 */
 	if (spi->mode & (SPI_CPOL | SPI_CPHA))
-- 
2.27.0

