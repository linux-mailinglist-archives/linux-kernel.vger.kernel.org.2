Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB16531EAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhBRN6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:58:01 -0500
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:58110 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhBRMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:02:54 -0500
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 8B8946FF30F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:53:17 +0100 (CET)
Received: from s500.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 6B1A92E275A0;
        Thu, 18 Feb 2021 12:53:17 +0100 (CET)
Received: from s476.loopia.se (unknown [172.22.191.6])
        by s500.loopia.se (Postfix) with ESMTP id 5D5BC1E32E76;
        Thu, 18 Feb 2021 12:53:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s630.loopia.se ([172.22.191.6])
        by s476.loopia.se (s476.loopia.se [172.22.190.16]) (amavisd-new, port 10024)
        with LMTP id rprKM0USkGVl; Thu, 18 Feb 2021 12:53:16 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 94.234.46.141
Received: from localhost.localdomain (c-5eea2e8d-74736162.cust.telenor.se [94.234.46.141])
        (Authenticated sender: carl@hgsystem.se)
        by s630.loopia.se (Postfix) with ESMTPSA id 1BDA413B939F;
        Thu, 18 Feb 2021 12:53:15 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v3 1/2] hwmon: (pmbus) Add pmbus_set_update() function to set update flag
Date:   Thu, 18 Feb 2021 12:52:48 +0100
Message-Id: <20210218115249.28513-2-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210218115249.28513-1-erik.rosen@metormote.com>
References: <20210218115249.28513-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the STPDDC60 chip, the vout alarm-limits are represented as an offset
relative to the commanded output voltage. This means that the limits are
dynamic and must not be cached by the pmbus driver. This patch adds a
pmbus_set_sensor() function to pmbus_core to be able to set the update flag
on selected sensors after auto-detection of limit attributes.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/pmbus.h      |  1 +
 drivers/hwmon/pmbus/pmbus_core.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 4c30ec89f5bf..3968924f8533 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -475,6 +475,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
 /* Function declarations */
 
 void pmbus_clear_cache(struct i2c_client *client);
+void pmbus_set_update(struct i2c_client *client, u8 reg, bool update);
 int pmbus_set_page(struct i2c_client *client, int page, int phase);
 int pmbus_read_word_data(struct i2c_client *client, int page, int phase,
 			 u8 reg);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 192442b3b7a2..a8f910826a18 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -141,6 +141,17 @@ void pmbus_clear_cache(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(pmbus_clear_cache);
 
+void pmbus_set_update(struct i2c_client *client, u8 reg, bool update)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	struct pmbus_sensor *sensor;
+
+	for (sensor = data->sensors; sensor; sensor = sensor->next)
+		if (sensor->reg == reg)
+			sensor->update = update;
+}
+EXPORT_SYMBOL_GPL(pmbus_set_update);
+
 int pmbus_set_page(struct i2c_client *client, int page, int phase)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
-- 
2.20.1

