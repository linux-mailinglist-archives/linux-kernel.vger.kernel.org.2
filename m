Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001443DD73B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhHBNf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:35:59 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41368 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhHBNf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:35:56 -0400
X-Greylist: delayed 1180 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 09:35:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=fpzHzOgb2FZjPrS+PEZ6zZ/AvzAw7jgjSdIsGJX7H8U=;
        b=F+dhpVbqJxjOgwYB+uNEKP8zlopKAt3XrenCUhacGZylWVWb5m7GSirgA20/RwN9Iqsypr1azcvGtZnSfZ079rtqsmNoehjPPDZ5fgoiWhVXQev/NwgULxAWLcn3IQDOespHjXysjam/QSatVYLqXIHxrbY0JaJ+mKlLJ0hfXot2vQ+WTLaY/gLbGT/j3pZPhuQjfcZNnElTcm+qy94oUWZZ6kdYYm2hr49snMiu9RUkQThvlppksr6oIjJQ/idv0C23wy8GKj0zqQTCWJqL+li52MQkJGHD1PaF2T/krS4PeFgWq8pk3A0GRBYnSYz9/djB8o1WuMtJHImIhbZSeg==;
Received: from bl23-140-245.dsl.telepac.pt ([144.64.140.245] helo=trinity.bot.igalia.com)
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
        id 1mAXnX-0000VB-Lo; Mon, 02 Aug 2021 15:16:03 +0200
From:   Carlos Alberto Lopez Perez <clopez@igalia.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, Pali Rohar <pali@kernel.org>,
        Carlos Alberto Lopez Perez <clopez@igalia.com>
Subject: [PATCH] hwmon: (dell-smm) Add Dell Precision 7510 to fan control whitelist
Date:   Mon,  2 Aug 2021 14:15:38 +0100
Message-Id: <20210802131538.8660-1-clopez@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows manual PWM control without the BIOS fighting back on Dell
Precision 7510. Meanwhile at it, also sort alphabetically the entries
of the i8k_whitelist_fan_control struct.

Signed-off-by: Carlos Alberto Lopez Perez <clopez@igalia.com>
---
 drivers/hwmon/dell-smm-hwmon.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index f2221ca0aa7b..a677c8a4ef29 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1186,14 +1186,6 @@ static const struct i8k_fan_control_data i8k_fan_control_data[] = {
 };
 
 static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
-	{
-		.ident = "Dell Precision 5530",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
-		},
-		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
-	},
 	{
 		.ident = "Dell Latitude 5480",
 		.matches = {
@@ -1218,6 +1210,22 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
 		},
 		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
 	},
+	{
+		.ident = "Dell Precision 5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
+		},
+		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+	},
+	{
+		.ident = "Dell Precision 7510",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
+		},
+		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+	},
 	{ }
 };
 
-- 
2.20.1

