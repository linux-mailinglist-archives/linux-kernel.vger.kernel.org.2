Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F00238D562
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhEVK5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:57:04 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:28530 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhEVK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:57:00 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 3B08524630F6
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 12:55:33 +0200 (CEST)
Received: from s645.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 2AFF42E2B88F;
        Sat, 22 May 2021 12:55:33 +0200 (CEST)
Received: from s472.loopia.se (unknown [172.22.191.5])
        by s645.loopia.se (Postfix) with ESMTP id 1A2D11579F72;
        Sat, 22 May 2021 12:55:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s934.loopia.se ([172.22.191.5])
        by s472.loopia.se (s472.loopia.se [172.22.190.12]) (amavisd-new, port 10024)
        with LMTP id LwSQLGW4LCWE; Sat, 22 May 2021 12:55:32 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s934.loopia.se (Postfix) with ESMTPSA id 0A8F37CE95D;
        Sat, 22 May 2021 12:55:32 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v2 1/6] hwmon: (pmbus/pim4328) Add new pmbus flag NO_WRITE_PROTECT
Date:   Sat, 22 May 2021 12:55:23 +0200
Message-Id: <20210522105528.87629-2-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210522105528.87629-1-erik.rosen@metormote.com>
References: <20210522105528.87629-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMBus chips respond with invalid data when reading the WRITE_PROTECT
register. For such chips, this flag should be set so that the PMBus core
driver doesn't use the WRITE_PROTECT command to determine it's behavior.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 9 ++++++---
 include/linux/pmbus.h            | 9 +++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index bbd745178147..cb885efc4fba 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2226,9 +2226,12 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	 * faults, and we should not try it. Also, in that case, writes into
 	 * limit registers need to be disabled.
 	 */
-	ret = i2c_smbus_read_byte_data(client, PMBUS_WRITE_PROTECT);
-	if (ret > 0 && (ret & PB_WP_ANY))
-		data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
+	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
+		ret = i2c_smbus_read_byte_data(client, PMBUS_WRITE_PROTECT);
+		if (ret > 0 && (ret & PB_WP_ANY))
+			data->flags |= PMBUS_WRITE_PROTECTED
+				    | PMBUS_SKIP_STATUS_CHECK;
+	}
 
 	if (data->info->pages)
 		pmbus_clear_faults(client);
diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
index 12cbbf305969..f720470b1bab 100644
--- a/include/linux/pmbus.h
+++ b/include/linux/pmbus.h
@@ -43,6 +43,15 @@
  */
 #define PMBUS_NO_CAPABILITY			BIT(2)
 
+/*
+ * PMBUS_NO_WRITE_PROTECT
+ *
+ * Some PMBus chips respond with invalid data when reading the WRITE_PROTECT
+ * register. For such chips, this flag should be set so that the PMBus core
+ * driver doesn't use the WRITE_PROTECT command to determine it's behavior.
+ */
+#define PMBUS_NO_WRITE_PROTECT			BIT(4)
+
 struct pmbus_platform_data {
 	u32 flags;		/* Device specific flags */
 
-- 
2.20.1

