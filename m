Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA86337480C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhEESd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:33:59 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:14990 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbhEESd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:33:58 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 6D8A31A9F23B
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 20:32:58 +0200 (CEST)
Received: from s630.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 5CF072E2C5C8;
        Wed,  5 May 2021 20:32:58 +0200 (CEST)
Received: from s475.loopia.se (unknown [172.22.191.6])
        by s630.loopia.se (Postfix) with ESMTP id 432F813B943F;
        Wed,  5 May 2021 20:32:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.5])
        by s475.loopia.se (s475.loopia.se [172.22.190.15]) (amavisd-new, port 10024)
        with LMTP id RfyVS_tiCRuC; Wed,  5 May 2021 20:32:57 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 98.128.181.169
Received: from localhost.localdomain (h-98-128-181-169.NA.cust.bahnhof.se [98.128.181.169])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id 52AC5157A057;
        Wed,  5 May 2021 20:32:57 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 1/3] hwmon: (pmbus) Add new flag PMBUS_READ_STATUS_AFTER_FAILED_CHECK
Date:   Wed,  5 May 2021 20:32:46 +0200
Message-Id: <20210505183248.57082-2-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210505183248.57082-1-erik.rosen@metormote.com>
References: <20210505183248.57082-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMBus chips end up in an undefined state when trying to read an
unsupported register. For such chips, it is necessary to reset the
chip pmbus controller to a known state after a failed register check.
This can be done by reading a known register. By setting this flag the
driver will try to read the STATUS register after each failed
register check. This read may fail, but it will put the chip into a
known state.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/pmbus_core.c |  2 ++
 include/linux/pmbus.h            | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index aadea85fe630..cb0b3c7c3434 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -512,6 +512,8 @@ static bool pmbus_check_register(struct i2c_client *client,
 	rv = func(client, page, reg);
 	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
 		rv = pmbus_check_status_cml(client);
+	if (rv < 0 && (data->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK))
+		data->read_status(client, -1);
 	pmbus_clear_fault_page(client, -1);
 	return rv >= 0;
 }
diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
index 12cbbf305969..edd7c84fef65 100644
--- a/include/linux/pmbus.h
+++ b/include/linux/pmbus.h
@@ -43,6 +43,19 @@
  */
 #define PMBUS_NO_CAPABILITY			BIT(2)
 
+/*
+ * PMBUS_READ_STATUS_AFTER_FAILED_CHECK
+ *
+ * Some PMBus chips end up in an undefined state when trying to read an
+ * unsupported register. For such chips, it is necessary to reset the
+ * chip pmbus controller to a known state after a failed register check.
+ * This can be done by reading a known register. By setting this flag the
+ * driver will try to read the STATUS register after each failed
+ * register check. This read may fail, but it will put the chip in a
+ * known state.
+ */
+#define PMBUS_READ_STATUS_AFTER_FAILED_CHECK	BIT(3)
+
 struct pmbus_platform_data {
 	u32 flags;		/* Device specific flags */
 
-- 
2.20.1

