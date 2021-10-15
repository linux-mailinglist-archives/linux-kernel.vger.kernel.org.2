Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D842F0F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhJOMbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhJOMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:30:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79A8C061570;
        Fri, 15 Oct 2021 05:28:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e3so25990356wrc.11;
        Fri, 15 Oct 2021 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvpvriDjktmuhTTAKKGqAIEOr/xDM6cpw+0a0Lp9KwU=;
        b=en0QVqk8y80StirBCzqGqs4Pmk1lsYCrq/kx2FEMBPpjONDRa3JyF0NNNfsKVuQa5Z
         FTmIjVqmOaeA3Iyj+CEyZKt+2jAyPBs/qCrBpWTBSoYd0UJj5a7PdpfjCr1Sext3JXnc
         oMob3B7r+wCrYyZz/eMgBiosfjO38WDe7iLRoeIWhAMln1X0+qk4dwAgyEbBUMcRZEsi
         Zkb9PUMPD0WDxLPOylzr5+Ndsg1B1SMtsN3MNHjscTzPcgyXgBM/rgQGuk/BmCOLJFKz
         NpJwv8i7NXo9Oe9hyqdUQ5LP1ftnGc5hc/ytq2IQLSLG7tohOfQp1Wsc/VvgbV/KFHBu
         KBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvpvriDjktmuhTTAKKGqAIEOr/xDM6cpw+0a0Lp9KwU=;
        b=fY1GEjBU531u04NDWttYWQc6LniMfNb4KVQ5+enLLkuL9VHo387n9hkovvxrJEYvCt
         METk9VMpJDCkI+rMGDBHFODcx8EGhFK8vwVvSEVC+xGcY9+GGxOX636LaoFa+LJ6IB9k
         VJRz1WEYM5MUj6QhbD2SjZNgcM76CcUviMiEK0P1vklSQ6ktCB8J0wlmkO3kvj4cIg5z
         HbuL6SiVz4X59o+vyyi97obu9SIQtzE58invycpTEISwRnT7XjsGvEB7q4ynyzu7DUwm
         kxX/EgBlSfWQGXrERQM48Ufyd3eCigs6ux+CIp1mL+c38Lzs39a/TKgM++YcDacAh1bo
         0FEA==
X-Gm-Message-State: AOAM530p9ktO3AXZMODwRNA1S38qNyIxnFQGOZuGFgXsWKXAopNN0N6f
        x1F7B5Y1z1RF67y7xbADcpxfEqp41D0=
X-Google-Smtp-Source: ABdhPJyPbM3kbJCvEy3jtyppF5yviAaityKCGZhTN9LIdZLxrgoRRlbzQzg9oA0B2tA3XZ3ytmNAXA==
X-Received: by 2002:adf:9bd3:: with SMTP id e19mr14488511wrc.167.1634300925432;
        Fri, 15 Oct 2021 05:28:45 -0700 (PDT)
Received: from localhost.localdomain ([197.49.234.11])
        by smtp.gmail.com with ESMTPSA id d8sm5002267wrv.80.2021.10.15.05.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:28:45 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (ad7414) cleanup codestyle
Date:   Fri, 15 Oct 2021 14:28:43 +0200
Message-Id: <20211015122843.135814-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a blank line after declarations
- Prefer using '"%s...", __func__' to using 'ad7414_probe'
- Don't split strings across lines

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 drivers/hwmon/ad7414.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index 0afb89c4629d..52df6005812c 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -107,6 +107,7 @@ static ssize_t temp_input_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct ad7414_data *data = ad7414_update_device(dev);
+
 	return sprintf(buf, "%d\n", ad7414_temp_from_reg(data->temp_input));
 }
 static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
@@ -116,6 +117,7 @@ static ssize_t max_min_show(struct device *dev, struct device_attribute *attr,
 {
 	int index = to_sensor_dev_attr(attr)->index;
 	struct ad7414_data *data = ad7414_update_device(dev);
+
 	return sprintf(buf, "%d\n", data->temps[index] * 1000);
 }
 
@@ -152,6 +154,7 @@ static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct ad7414_data *data = ad7414_update_device(dev);
 	int value = (data->temp_input >> bitnr) & 1;
+
 	return sprintf(buf, "%d\n", value);
 }
 
@@ -192,7 +195,7 @@ static int ad7414_probe(struct i2c_client *client)
 	/* Make sure the chip is powered up. */
 	conf = i2c_smbus_read_byte_data(client, AD7414_REG_CONF);
 	if (conf < 0)
-		dev_warn(dev, "ad7414_probe unable to read config register.\n");
+		dev_warn(dev, "%s unable to read config register.\n", __func__);
 	else {
 		conf &= ~(1 << 7);
 		i2c_smbus_write_byte_data(client, AD7414_REG_CONF, conf);
@@ -227,8 +230,7 @@ static struct i2c_driver ad7414_driver = {
 
 module_i2c_driver(ad7414_driver);
 
-MODULE_AUTHOR("Stefan Roese <sr at denx.de>, "
-	      "Frank Edelhaeuser <frank.edelhaeuser at spansion.com>");
+MODULE_AUTHOR("Stefan Roese <sr at denx.de>, Frank Edelhaeuser <frank.edelhaeuser at spansion.com>");
 
 MODULE_DESCRIPTION("AD7414 driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

