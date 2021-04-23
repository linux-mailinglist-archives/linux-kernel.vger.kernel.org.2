Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7107736963E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbhDWPea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:34:30 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:44939 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhDWPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:34:28 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 8B75B1A97341
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:33:49 +0200 (CEST)
Received: from s499.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 7A9C42E3A4DD;
        Fri, 23 Apr 2021 17:33:49 +0200 (CEST)
Received: from s474.loopia.se (unknown [172.22.191.5])
        by s499.loopia.se (Postfix) with ESMTP id 671AB1CE6226;
        Fri, 23 Apr 2021 17:33:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.5])
        by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
        with LMTP id cgvyipax-DqF; Fri, 23 Apr 2021 17:33:48 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.157
Received: from localhost.localdomain (h-155-4-131-157.NA.cust.bahnhof.se [155.4.131.157])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id 51B69157A03B;
        Fri, 23 Apr 2021 17:33:48 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 2/2] hwmon: (pmbus/zl6100) Update documentation for zl6100 driver
Date:   Fri, 23 Apr 2021 17:33:29 +0200
Message-Id: <20210423153329.33457-3-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210423153329.33457-1-erik.rosen@metormote.com>
References: <20210423153329.33457-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation for zl6100 driver and fix dead links to technical
specifications

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 Documentation/hwmon/zl6100.rst | 132 ++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 43 deletions(-)

diff --git a/Documentation/hwmon/zl6100.rst b/Documentation/hwmon/zl6100.rst
index 968aff10ce0a..d42ed9d3ac69 100644
--- a/Documentation/hwmon/zl6100.rst
+++ b/Documentation/hwmon/zl6100.rst
@@ -3,87 +3,103 @@ Kernel driver zl6100
 
 Supported chips:
 
-  * Intersil / Zilker Labs ZL2004
+  * Renesas / Intersil / Zilker Labs ZL2004
 
     Prefix: 'zl2004'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn6847.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl2004-datasheet.pdf
 
-  * Intersil / Zilker Labs ZL2005
+  * Renesas / Intersil / Zilker Labs ZL2005
 
     Prefix: 'zl2005'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn6848.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl2005-datasheet.pdf
 
-  * Intersil / Zilker Labs ZL2006
+  * Renesas / Intersil / Zilker Labs ZL2006
 
     Prefix: 'zl2006'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn6850.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl2006-datasheet.pdf
 
-  * Intersil / Zilker Labs ZL2008
+  * Renesas / Intersil / Zilker Labs ZL2008
 
     Prefix: 'zl2008'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn6859.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl2008-datasheet.pdf
 
-  * Intersil / Zilker Labs ZL2105
+  * Renesas / Intersil / Zilker Labs ZL2105
 
     Prefix: 'zl2105'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn6851.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl2105-datasheet.pdf
 
-  * Intersil / Zilker Labs ZL2106
+  * Renesas / Intersil / Zilker Labs ZL2106
 
     Prefix: 'zl2106'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn6852.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl2106-datasheet.pdf
 
-  * Intersil / Zilker Labs ZL6100
+  * Renesas / Intersil / Zilker Labs ZL6100
 
     Prefix: 'zl6100'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn6876.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl6100-datasheet.pdf
 
-  * Intersil / Zilker Labs ZL6105
+  * Renesas / Intersil / Zilker Labs ZL6105
 
     Prefix: 'zl6105'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn6906.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl6105-datasheet.pdf
 
-  * Intersil / Zilker Labs ZL9101M
+  * Renesas / Intersil / Zilker Labs ZL8802
+
+    Prefix: 'zl8802'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl8802-datasheet
+
+  * Renesas / Intersil / Zilker Labs ZL9101M
 
     Prefix: 'zl9101'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn7669.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl9101m-datasheet
 
-  * Intersil / Zilker Labs ZL9117M
+  * Renesas / Intersil / Zilker Labs ZL9117M
 
     Prefix: 'zl9117'
 
     Addresses scanned: -
 
-    Datasheet: http://www.intersil.com/data/fn/fn7914.pdf
+    Datasheet: https://www.renesas.com/us/en/document/dst/zl9117m-datasheet
+
+  * Renesas / Intersil / Zilker Labs ZLS1003, ZLS4009
+
+    Prefix: 'zls1003', zls4009
+
+    Addresses scanned: -
+
+    Datasheet: Not published
 
-  * Ericsson BMR450, BMR451
+  * Flex BMR450, BMR451
 
     Prefix: 'bmr450', 'bmr451'
 
@@ -91,17 +107,39 @@ Supported chips:
 
     Datasheet:
 
-http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146401
+https://flexpowermodules.com/resources/fpm-techspec-bmr450-digital-pol-regulators-20a
 
-  * Ericsson BMR462, BMR463, BMR464
+  * Flex BMR462, BMR463, BMR464
 
     Prefixes: 'bmr462', 'bmr463', 'bmr464'
 
     Addresses scanned: -
 
-    Datasheet:
+    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-bmr462
+
+  * Flex BMR465, BMR467
+
+    Prefixes: 'bmr465', 'bmr467'
+
+    Addresses scanned: -
+
+    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-bmr465-digital-pol
+
+  * Flex BMR466
+
+    Prefixes: 'bmr466'
+
+    Addresses scanned: -
+
+    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-bmr466-8x12
 
-	http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146256
+  * Flex BMR469
+
+    Prefixes: 'bmr469'
+
+    Addresses scanned: -
+
+    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-bmr4696001
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -109,8 +147,8 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-This driver supports hardware monitoring for Intersil / Zilker Labs ZL6100 and
-compatible digital DC-DC controllers.
+This driver supports hardware monitoring for Renesas / Intersil / Zilker Labs
+ZL6100 and compatible digital DC-DC controllers.
 
 The driver is a client driver to the core PMBus driver. Please see
 Documentation/hwmon/pmbus.rst and Documentation.hwmon/pmbus-core for details
@@ -147,12 +185,12 @@ Module parameters
 delay
 -----
 
-Intersil/Zilker Labs DC-DC controllers require a minimum interval between I2C
-bus accesses. According to Intersil, the minimum interval is 2 ms, though 1 ms
-appears to be sufficient and has not caused any problems in testing. The problem
-is known to affect all currently supported chips. For manual override, the
-driver provides a writeable module parameter, 'delay', which can be used to set
-the interval to a value between 0 and 65,535 microseconds.
+Renesas/Intersil/Zilker Labs DC-DC controllers require a minimum interval
+between I2C bus accesses. According to Intersil, the minimum interval is 2 ms,
+though 1 ms appears to be sufficient and has not caused any problems in testing.
+The problem is known to affect all currently supported chips. For manual override,
+the driver provides a writeable module parameter, 'delay', which can be used
+to set the interval to a value between 0 and 65,535 microseconds.
 
 
 Sysfs entries
@@ -182,24 +220,32 @@ in2_crit		Critical maximum VMON/VDRV voltage.
 in2_lcrit_alarm		VMON/VDRV voltage critical low alarm.
 in2_crit_alarm		VMON/VDRV voltage critical high alarm.
 
-			vmon attributes are supported on ZL2004, ZL9101M,
-			and ZL9117M only.
+			vmon attributes are supported on ZL2004, ZL8802,
+			ZL9101M, ZL9117M and ZLS4009 only.
 
-inX_label		"vout1"
+inX_label		"vout[12]"
 inX_input		Measured output voltage.
 inX_lcrit		Critical minimum output Voltage.
 inX_crit		Critical maximum output voltage.
 inX_lcrit_alarm		Critical output voltage critical low alarm.
 inX_crit_alarm		Critical output voltage critical high alarm.
 
-			X is 3 for ZL2004, ZL9101M, and ZL9117M, 2 otherwise.
+			X is 3 for ZL2004, ZL9101M, and ZL9117M,
+			3, 4 for ZL8802 and 2 otherwise.
+
+curr1_label		"iin"
+curr1_input		Measured input current.
+
+			iin attributes are supported on ZL8802 only
+
+currY_label		"iout[12]"
+currY_input		Measured output current.
+currY_lcrit		Critical minimum output current.
+currY_crit		Critical maximum output current.
+currY_lcrit_alarm	Output current critical low alarm.
+currY_crit_alarm	Output current critical high alarm.
 
-curr1_label		"iout1"
-curr1_input		Measured output current.
-curr1_lcrit		Critical minimum output current.
-curr1_crit		Critical maximum output current.
-curr1_lcrit_alarm	Output current critical low alarm.
-curr1_crit_alarm	Output current critical high alarm.
+			Y is 2, 3 for ZL8802, 1 otherwise
 
 temp[12]_input		Measured temperature.
 temp[12]_min		Minimum temperature.
-- 
2.20.1

