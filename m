Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197DD3D8AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhG1Jid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:38:33 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:50073 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231576AbhG1Ji2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:38:28 -0400
Received: from ersatz.molgen.mpg.de (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B474561E5FE00;
        Wed, 28 Jul 2021 11:38:25 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Guohan Lu <lguohan@gmail.com>,
        Madhava Reddy Siddareddygari <msiddare@cisco.com>,
        Venkat Garigipati <venkatg@cisco.com>,
        Billie Alsup <balsup@cisco.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] hwmon: (pmbus) Support 4th PSU temperature sensor
Date:   Wed, 28 Jul 2021 11:38:14 +0200
Message-Id: <20210728093815.8395-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhava Reddy Siddareddygari <msiddare@cisco.com>

PSU650W has four temperature sensors, while the pmbus driver currently
only support three temperature sensors.

So, support a fourth temp sensor, i. e. PSU outlet temperature sensor,
by copying what is done for temperature sensor 3, and use register 0xDF.

PSU650W is based on LITE-ON vendor.
LITE-ON MFG part numbers for the PSU are PS-2651-3SB5 Z and PS-2651-3SA5 Z.

Signed-off-by: Madhava Reddy Siddareddygari <msiddare@cisco.com>
Signed-off-by: Venkat Garigipati <venkatg@cisco.com>
Cc: Billie Alsup <balsup@cisco.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
This as a RFC, as we know 0xDF is a manufacturer specific register, and
cannot be added to the PMBus core driver. It was submitted to SONiC [1]
by Cisco engineers.

It’d be great if the maintainers good suggest how to easily implement a
custom driver for that PSU?

[1]: https://github.com/Azure/sonic-linux-kernel/pull/214

 drivers/hwmon/pmbus/pmbus.c      |  4 +++-
 drivers/hwmon/pmbus/pmbus.h      |  3 +++
 drivers/hwmon/pmbus/pmbus_core.c | 38 ++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index d0d386990af5..df2a782a1105 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -60,8 +60,10 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
 		info->func[0] |= PMBUS_HAVE_TEMP2;
 	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_3))
 		info->func[0] |= PMBUS_HAVE_TEMP3;
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_4))
+		info->func[0] |= PMBUS_HAVE_TEMP4;
 	if (info->func[0] & (PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
-			     | PMBUS_HAVE_TEMP3)
+			     | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_TEMP4)
 	    && pmbus_check_byte_register(client, 0,
 					 PMBUS_STATUS_TEMPERATURE))
 			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index e0aa8aa46d8c..1522c8c7cade 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -135,6 +135,8 @@ enum pmbus_regs {
 	PMBUS_MFR_MAX_TEMP_2		= 0xC1,
 	PMBUS_MFR_MAX_TEMP_3		= 0xC2,
 
+	PMBUS_READ_TEMPERATURE_4	= 0xDF,
+
 /*
  * Virtual registers.
  * Useful to support attributes which are not supported by standard PMBus
@@ -401,6 +403,7 @@ enum pmbus_sensor_classes {
 #define PMBUS_HAVE_PWM12	BIT(20)
 #define PMBUS_HAVE_PWM34	BIT(21)
 #define PMBUS_HAVE_SAMPLES	BIT(22)
+#define PMBUS_HAVE_TEMP4	BIT(23)
 
 #define PMBUS_PHASE_VIRTUAL	BIT(30)	/* Phases on this page are virtual */
 #define PMBUS_PAGE_VIRTUAL	BIT(31)	/* Page is virtual */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 776ee2237be2..b084b5ba6d45 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1810,6 +1810,32 @@ static const struct pmbus_limit_attr temp_limit_attrs3[] = {
 	},
 };
 
+static const struct pmbus_limit_attr temp_limit_attrs4[] = {
+	{
+		.reg = PMBUS_UT_WARN_LIMIT,
+		.low = true,
+		.attr = "min",
+		.alarm = "min_alarm",
+		.sbit = PB_TEMP_UT_WARNING,
+	}, {
+		.reg = PMBUS_UT_FAULT_LIMIT,
+		.low = true,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_TEMP_UT_FAULT,
+	}, {
+		.reg = PMBUS_OT_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_TEMP_OT_WARNING,
+	}, {
+		.reg = PMBUS_OT_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_TEMP_OT_FAULT,
+	}
+};
+
 static const struct pmbus_sensor_attr temp_attributes[] = {
 	{
 		.reg = PMBUS_READ_TEMPERATURE_1,
@@ -1847,6 +1873,18 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
 		.gbit = PB_STATUS_TEMPERATURE,
 		.limit = temp_limit_attrs3,
 		.nlimit = ARRAY_SIZE(temp_limit_attrs3),
+	}, {
+		.reg = PMBUS_READ_TEMPERATURE_4,
+		.class = PSC_TEMPERATURE,
+		.paged = true,
+		.update = true,
+		.compare = true,
+		.func = PMBUS_HAVE_TEMP4,
+		.sfunc = PMBUS_HAVE_STATUS_TEMP,
+		.sbase = PB_STATUS_TEMP_BASE,
+		.gbit = PB_STATUS_TEMPERATURE,
+		.limit = temp_limit_attrs4,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs4),
 	}
 };
 
-- 
2.32.0

