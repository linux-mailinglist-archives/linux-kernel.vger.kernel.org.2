Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60083376ACF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhEGTlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:41:39 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:31231 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhEGTld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:41:33 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id CF8822E6246B
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 21:40:29 +0200 (CEST)
Received: from s934.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id BEE002E36757;
        Fri,  7 May 2021 21:40:29 +0200 (CEST)
Received: from s898.loopia.se (unknown [172.22.191.6])
        by s934.loopia.se (Postfix) with ESMTP id B2E457CE9E9;
        Fri,  7 May 2021 21:40:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.6])
        by s898.loopia.se (s898.loopia.se [172.22.190.17]) (amavisd-new, port 10024)
        with LMTP id tSUFz-_153_N; Fri,  7 May 2021 21:40:29 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id 04998157A050;
        Fri,  7 May 2021 21:40:28 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v2 2/3] hwmon: (pmbus) Add documentation for new flags
Date:   Fri,  7 May 2021 21:40:22 +0200
Message-Id: <20210507194023.61138-3-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210507194023.61138-1-erik.rosen@metormote.com>
References: <20210507194023.61138-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the new pmbus flags PMBUS_WRITE_PROTECTED,
PMBUS_NO_CAPABILITY and PMBUS_READ_STATUS_AFTER_FAILED_CHECK

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 Documentation/hwmon/pmbus-core.rst | 42 +++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
index 73e23ab42cc3..102c50e2be3d 100644
--- a/Documentation/hwmon/pmbus-core.rst
+++ b/Documentation/hwmon/pmbus-core.rst
@@ -289,12 +289,22 @@ PMBus driver platform data
 ==========================
 
 PMBus platform data is defined in include/linux/pmbus.h. Platform data
-currently only provides a flag field with a single bit used::
+currently provides a flags field with four bits used::
 
-	#define PMBUS_SKIP_STATUS_CHECK (1 << 0)
+	#define PMBUS_SKIP_STATUS_CHECK			BIT(0)
+
+	#define PMBUS_WRITE_PROTECTED			BIT(1)
+
+	#define PMBUS_NO_CAPABILITY			BIT(2)
+
+	#define PMBUS_READ_STATUS_AFTER_FAILED_CHECK	BIT(3)
 
 	struct pmbus_platform_data {
 		u32 flags;              /* Device specific flags */
+
+		/* regulator support */
+		int num_regulators;
+		struct regulator_init_data *reg_init_data;
 	};
 
 
@@ -302,8 +312,9 @@ Flags
 -----
 
 PMBUS_SKIP_STATUS_CHECK
-	During register detection, skip checking the status register for
-	communication or command errors.
+
+During register detection, skip checking the status register for
+communication or command errors.
 
 Some PMBus chips respond with valid data when trying to read an unsupported
 register. For such chips, checking the status register is mandatory when
@@ -315,3 +326,26 @@ status register must be disabled.
 Some i2c controllers do not support single-byte commands (write commands with
 no data, i2c_smbus_write_byte()). With such controllers, clearing the status
 register is impossible, and the PMBUS_SKIP_STATUS_CHECK flag must be set.
+
+PMBUS_WRITE_PROTECTED
+
+Set if the chip is write protected and write protection is not determined
+by the standard WRITE_PROTECT command.
+
+PMBUS_NO_CAPABILITY
+
+Some PMBus chips don't respond with valid data when reading the CAPABILITY
+register. For such chips, this flag should be set so that the PMBus core
+driver doesn't use CAPABILITY to determine it's behavior.
+
+PMBUS_READ_STATUS_AFTER_FAILED_CHECK
+
+Read the STATUS register after each failed register check.
+
+Some PMBus chips end up in an undefined state when trying to read an
+unsupported register. For such chips, it is necessary to reset the
+chip pmbus controller to a known state after a failed register check.
+This can be done by reading a known register. By setting this flag the
+driver will try to read the STATUS register after each failed
+register check. This read may fail, but it will put the chip into a
+known state.
\ No newline at end of file
-- 
2.20.1

