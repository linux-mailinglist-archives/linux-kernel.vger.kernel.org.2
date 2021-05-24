Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15A938ECA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhEXPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 11:20:56 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:41082 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhEXPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:08:35 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 3B6512E6CBDD
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:02:58 +0200 (CEST)
Received: from s934.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 2ADD72E2B91C;
        Mon, 24 May 2021 17:02:58 +0200 (CEST)
Received: from s472.loopia.se (unknown [172.22.191.6])
        by s934.loopia.se (Postfix) with ESMTP id 26AFD7CE98E;
        Mon, 24 May 2021 17:02:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s934.loopia.se ([172.22.191.5])
        by s472.loopia.se (s472.loopia.se [172.22.190.12]) (amavisd-new, port 10024)
        with LMTP id 3HD0lamuAO5j; Mon, 24 May 2021 17:02:57 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s934.loopia.se (Postfix) with ESMTPSA id 685327CE996;
        Mon, 24 May 2021 17:02:57 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v3 6/6] hwmon: (pmbus/pim4328) Add documentation for the pim4328 PMBus driver
Date:   Mon, 24 May 2021 17:02:46 +0200
Message-Id: <20210524150246.90546-7-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210524150246.90546-1-erik.rosen@metormote.com>
References: <20210524150246.90546-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation and index link for pim4328 PMBus driver.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/pim4328.rst | 105 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |   7 +++
 3 files changed, 113 insertions(+)
 create mode 100644 Documentation/hwmon/pim4328.rst

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 9ed60fa84cbe..719625f8f755 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -150,6 +150,7 @@ Hardware Monitoring Kernel Drivers
    pc87360
    pc87427
    pcf8591
+   pim4328
    pm6764tr
    pmbus
    powr1220
diff --git a/Documentation/hwmon/pim4328.rst b/Documentation/hwmon/pim4328.rst
new file mode 100644
index 000000000000..70c9e7a6882c
--- /dev/null
+++ b/Documentation/hwmon/pim4328.rst
@@ -0,0 +1,105 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver pim4328
+=====================
+
+Supported chips:
+
+  * Flex PIM4328
+
+    Prefix: 'pim4328', 'bmr455'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+https://flexpowermodules.com/resources/fpm-techspec-pim4328
+
+  * Flex PIM4820
+
+    Prefixes: 'pim4820'
+
+    Addresses scanned: -
+
+    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-pim4820
+
+  * Flex PIM4006, PIM4106, PIM4206, PIM4306, PIM4406
+
+    Prefixes: 'pim4006', 'pim4106', 'pim4206', 'pim4306', 'pim4406'
+
+    Addresses scanned: -
+
+    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-pim4006
+
+Author: Erik Rosen <erik.rosen@metormote.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for Flex PIM4328 and
+compatible digital power interface modules.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus.rst and Documentation.hwmon/pmbus-core for details
+on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
+details.
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. All attributes are read-only.
+
+======================= ========================================================
+in1_label		"vin"
+in1_input		Measured input voltage.
+in1_alarm		Input voltage alarm.
+
+in2_label		"vin.0"
+in2_input		Measured input voltage on input A.
+
+			PIM4328 and PIM4X06
+
+in3_label		"vin.1"
+in3_input		Measured input voltage on input B.
+
+			PIM4328 and PIM4X06
+
+in4_label		"vcap"
+in4_input		Measured voltage on holdup capacitor.
+
+			PIM4328
+
+curr1_label		"iin.0"
+curr1_input		Measured input current on input A.
+
+			PIM4X06
+
+curr2_label		"iin.1"
+curr2_input		Measured input current on input B.
+
+			PIM4X06
+
+currX_label		"iout1"
+currX_input		Measured output current.
+currX_alarm		Output current alarm.
+
+			X is 1 for PIM4820, 3 otherwise.
+
+temp1_input		Measured temperature.
+temp1_alarm		High temperature alarm.
+======================= ========================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..378a121d80f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14416,6 +14416,13 @@ K:	(?i)pidfd
 K:	(?i)clone3
 K:	\b(clone_args|kernel_clone_args)\b
 
+PIM4328 DRIVER
+M:	Daniel Nilsson <daniel.nilsson@flex.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/pim4328.rst
+F:	drivers/hwmon/pmbus/pim4328.c
+
 PIN CONTROL SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-gpio@vger.kernel.org
-- 
2.20.1

