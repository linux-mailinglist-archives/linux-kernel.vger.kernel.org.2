Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4E30F3DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhBDN3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:29:16 -0500
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:18258 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhBDN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:29:12 -0500
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 39246246E8DB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:21:02 +0100 (CET)
Received: from s498.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 18DF62E2B85F;
        Thu,  4 Feb 2021 14:21:02 +0100 (CET)
Received: from s473.loopia.se (unknown [172.22.191.5])
        by s498.loopia.se (Postfix) with ESMTP id 061D148943E;
        Thu,  4 Feb 2021 14:21:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s499.loopia.se ([172.22.191.6])
        by s473.loopia.se (s473.loopia.se [172.22.190.13]) (amavisd-new, port 10024)
        with LMTP id LRAnSmbQMixu; Thu,  4 Feb 2021 14:21:01 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.176
Received: from localhost.localdomain (h-155-4-131-176.NA.cust.bahnhof.se [155.4.131.176])
        (Authenticated sender: carl@hgsystem.se)
        by s499.loopia.se (Postfix) with ESMTPSA id 02EA11CE601B;
        Thu,  4 Feb 2021 14:21:00 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v2 1/2] hwmon: (pmbus) Add pmbus_set_update() function to set update flag
Date:   Thu,  4 Feb 2021 14:20:39 +0100
Message-Id: <20210204132040.3868-2-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210204132040.3868-1-erik.rosen@metormote.com>
References: <20210204132040.3868-1-erik.rosen@metormote.com>
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
2.30.0

