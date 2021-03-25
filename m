Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428B53497AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCYRMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhCYRL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:11:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C3A461A28;
        Thu, 25 Mar 2021 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616692317;
        bh=y6zLbPcyEVvhtg21rb9MrFdi1B6TTMd2WOeytxfT9NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoTBoSQYGbyXwj1tZJwuOrtwLd3+fk/ndxemCb09N3qCgWlZoCKRAQuvdc3KYkTPK
         j6r8DM1K9LeqTFUyY1vRT+YKCJL8gCiIvUNSyMicaT4Ky81zLNzTlHFDzLiaU9KMwb
         BNVDYWsIKzYXVpOJbf4gEaYrcCb927ncIrSZ+OorA97HeewxaCxKwxYJNJ6661DHH8
         BbBvzghbJIJoFV1HzT0X7CGhAWoMuer59WV4qr9jxm8WaiT3IZs0wiQDo92eERiulb
         GIhIaY8seFGDKF/CGXucCgrMCSFMWZmuIPYodReXX3TdxH/voKMKxUWNVWkbrLUnNt
         R0m8Z3PxXTmaw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 2/2] treewide: change my e-mail address, fix my name
Date:   Thu, 25 Mar 2021 18:11:23 +0100
Message-Id: <20210325171123.28093-2-kabel@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210325171123.28093-1-kabel@kernel.org>
References: <20210325171123.28093-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change my e-mail address to kabel@kernel.org, and fix my name in
non-code parts (add diacritical mark).

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 Documentation/ABI/testing/debugfs-moxtet               |  4 ++--
 Documentation/ABI/testing/debugfs-turris-mox-rwtm      |  2 +-
 Documentation/ABI/testing/sysfs-bus-moxtet-devices     |  6 +++---
 .../ABI/testing/sysfs-class-led-driver-turris-omnia    |  2 +-
 .../ABI/testing/sysfs-firmware-turris-mox-rwtm         | 10 +++++-----
 .../bindings/leds/cznic,turris-omnia-leds.yaml         |  2 +-
 MAINTAINERS                                            |  2 +-
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts |  2 +-
 drivers/bus/moxtet.c                                   |  4 ++--
 drivers/firmware/turris-mox-rwtm.c                     |  4 ++--
 drivers/gpio/gpio-moxtet.c                             |  4 ++--
 drivers/leds/leds-turris-omnia.c                       |  4 ++--
 drivers/mailbox/armada-37xx-rwtm-mailbox.c             |  4 ++--
 drivers/watchdog/armada_37xx_wdt.c                     |  4 ++--
 include/dt-bindings/bus/moxtet.h                       |  2 +-
 include/linux/armada-37xx-rwtm-mailbox.h               |  2 +-
 include/linux/moxtet.h                                 |  2 +-
 17 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-moxtet b/Documentation/ABI/testing/debugfs-moxtet
index 6eee10c3d5a1..637d8587d03d 100644
--- a/Documentation/ABI/testing/debugfs-moxtet
+++ b/Documentation/ABI/testing/debugfs-moxtet
@@ -1,7 +1,7 @@
 What:		/sys/kernel/debug/moxtet/input
 Date:		March 2019
 KernelVersion:	5.3
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(Read) Read input from the shift registers, in hexadecimal.
 		Returns N+1 bytes, where N is the number of Moxtet connected
 		modules. The first byte is from the CPU board itself.
@@ -19,7 +19,7 @@ Description:	(Read) Read input from the shift registers, in hexadecimal.
 What:		/sys/kernel/debug/moxtet/output
 Date:		March 2019
 KernelVersion:	5.3
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(RW) Read last written value to the shift registers, in
 		hexadecimal, or write values to the shift registers, also
 		in hexadecimal.
diff --git a/Documentation/ABI/testing/debugfs-turris-mox-rwtm b/Documentation/ABI/testing/debugfs-turris-mox-rwtm
index 326df1b74707..813987d5de4e 100644
--- a/Documentation/ABI/testing/debugfs-turris-mox-rwtm
+++ b/Documentation/ABI/testing/debugfs-turris-mox-rwtm
@@ -1,7 +1,7 @@
 What:		/sys/kernel/debug/turris-mox-rwtm/do_sign
 Date:		Jun 2020
 KernelVersion:	5.8
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:
 
 		======= ===========================================================
diff --git a/Documentation/ABI/testing/sysfs-bus-moxtet-devices b/Documentation/ABI/testing/sysfs-bus-moxtet-devices
index 4a6d61b44f3f..32dccc00d57d 100644
--- a/Documentation/ABI/testing/sysfs-bus-moxtet-devices
+++ b/Documentation/ABI/testing/sysfs-bus-moxtet-devices
@@ -1,17 +1,17 @@
 What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_description
 Date:		March 2019
 KernelVersion:	5.3
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(Read) Moxtet module description. Format: string
 
 What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_id
 Date:		March 2019
 KernelVersion:	5.3
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(Read) Moxtet module ID. Format: %x
 
 What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_name
 Date:		March 2019
 KernelVersion:	5.3
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(Read) Moxtet module name. Format: string
diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-turris-omnia b/Documentation/ABI/testing/sysfs-class-led-driver-turris-omnia
index 795a5de12fc1..c4d46970c1cf 100644
--- a/Documentation/ABI/testing/sysfs-class-led-driver-turris-omnia
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-turris-omnia
@@ -1,7 +1,7 @@
 What:		/sys/class/leds/<led>/device/brightness
 Date:		July 2020
 KernelVersion:	5.9
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(RW) On the front panel of the Turris Omnia router there is also
 		a button which can be used to control the intensity of all the
 		LEDs at once, so that if they are too bright, user can dim them.
diff --git a/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm b/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
index b8631f5a29c4..ea5e5b489bc7 100644
--- a/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
+++ b/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
@@ -1,21 +1,21 @@
 What:		/sys/firmware/turris-mox-rwtm/board_version
 Date:		August 2019
 KernelVersion:	5.4
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(Read) Board version burned into eFuses of this Turris Mox board.
 		Format: %i
 
 What:		/sys/firmware/turris-mox-rwtm/mac_address*
 Date:		August 2019
 KernelVersion:	5.4
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(Read) MAC addresses burned into eFuses of this Turris Mox board.
 		Format: %pM
 
 What:		/sys/firmware/turris-mox-rwtm/pubkey
 Date:		August 2019
 KernelVersion:	5.4
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(Read) ECDSA public key (in pubkey hex compressed form) computed
 		as pair to the ECDSA private key burned into eFuses of this
 		Turris Mox Board.
@@ -24,7 +24,7 @@ Description:	(Read) ECDSA public key (in pubkey hex compressed form) computed
 What:		/sys/firmware/turris-mox-rwtm/ram_size
 Date:		August 2019
 KernelVersion:	5.4
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(Read) RAM size in MiB of this Turris Mox board as was detected
 		during manufacturing and burned into eFuses. Can be 512 or 1024.
 		Format: %i
@@ -32,6 +32,6 @@ Description:	(Read) RAM size in MiB of this Turris Mox board as was detected
 What:		/sys/firmware/turris-mox-rwtm/serial_number
 Date:		August 2019
 KernelVersion:	5.4
-Contact:	Marek Behún <marek.behun@nic.cz>
+Contact:	Marek Behún <kabel@kernel.org>
 Description:	(Read) Serial number burned into eFuses of this Turris Mox device.
 		Format: %016X
diff --git a/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml b/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
index fe7fa25877fd..c7ed2871da06 100644
--- a/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
+++ b/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: CZ.NIC's Turris Omnia LEDs driver
 
 maintainers:
-  - Marek Behún <marek.behun@nic.cz>
+  - Marek Behún <kabel@kernel.org>
 
 description:
   This module adds support for the RGB LEDs found on the front panel of the
diff --git a/MAINTAINERS b/MAINTAINERS
index 2cf388c89196..91078690dac5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1791,7 +1791,7 @@ F:	drivers/pinctrl/pinctrl-gemini.c
 F:	drivers/rtc/rtc-ftrtc010.c
 
 ARM/CZ.NIC TURRIS SUPPORT
-M:	Marek Behun <marek.behun@nic.cz>
+M:	Marek Behun <kabel@kernel.org>
 S:	Maintained
 W:	https://www.turris.cz/
 F:	Documentation/ABI/testing/debugfs-moxtet
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index d239ab70ed99..53e817c5f6f3 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Device Tree file for CZ.NIC Turris Mox Board
- * 2019 by Marek Behun <marek.behun@nic.cz>
+ * 2019 by Marek Behún <kabel@kernel.org>
  */
 
 /dts-v1/;
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index b20fdcbd035b..fd87a59837fa 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -2,7 +2,7 @@
 /*
  * Turris Mox module configuration bus driver
  *
- * Copyright (C) 2019 Marek Behun <marek.behun@nic.cz>
+ * Copyright (C) 2019 Marek Behún <kabel@kernel.org>
  */
 
 #include <dt-bindings/bus/moxtet.h>
@@ -879,6 +879,6 @@ static void __exit moxtet_exit(void)
 }
 module_exit(moxtet_exit);
 
-MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_AUTHOR("Marek Behun <kabel@kernel.org>");
 MODULE_DESCRIPTION("CZ.NIC's Turris Mox module configuration bus");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 50bb2a6d6ccf..62f0d1a5dd32 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -2,7 +2,7 @@
 /*
  * Turris Mox rWTM firmware driver
  *
- * Copyright (C) 2019 Marek Behun <marek.behun@nic.cz>
+ * Copyright (C) 2019 Marek Behún <kabel@kernel.org>
  */
 
 #include <linux/armada-37xx-rwtm-mailbox.h>
@@ -547,4 +547,4 @@ module_platform_driver(turris_mox_rwtm_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Turris Mox rWTM firmware driver");
-MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_AUTHOR("Marek Behun <kabel@kernel.org>");
diff --git a/drivers/gpio/gpio-moxtet.c b/drivers/gpio/gpio-moxtet.c
index 8299909318f4..61f9efd6c64f 100644
--- a/drivers/gpio/gpio-moxtet.c
+++ b/drivers/gpio/gpio-moxtet.c
@@ -2,7 +2,7 @@
 /*
  *  Turris Mox Moxtet GPIO expander
  *
- *  Copyright (C) 2018 Marek Behun <marek.behun@nic.cz>
+ *  Copyright (C) 2018 Marek Behún <kabel@kernel.org>
  */
 
 #include <linux/bitops.h>
@@ -174,6 +174,6 @@ static struct moxtet_driver moxtet_gpio_driver = {
 };
 module_moxtet_driver(moxtet_gpio_driver);
 
-MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_AUTHOR("Marek Behun <kabel@kernel.org>");
 MODULE_DESCRIPTION("Turris Mox Moxtet GPIO expander");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/leds/leds-turris-omnia.c b/drivers/leds/leds-turris-omnia.c
index 7b2f4d0ae3fe..2f9a289ab245 100644
--- a/drivers/leds/leds-turris-omnia.c
+++ b/drivers/leds/leds-turris-omnia.c
@@ -2,7 +2,7 @@
 /*
  * CZ.NIC's Turris Omnia LEDs driver
  *
- * 2020 by Marek Behun <marek.behun@nic.cz>
+ * 2020 by Marek Behún <kabel@kernel.org>
  */
 
 #include <linux/i2c.h>
@@ -287,6 +287,6 @@ static struct i2c_driver omnia_leds_driver = {
 
 module_i2c_driver(omnia_leds_driver);
 
-MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_AUTHOR("Marek Behun <kabel@kernel.org>");
 MODULE_DESCRIPTION("CZ.NIC's Turris Omnia LEDs");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mailbox/armada-37xx-rwtm-mailbox.c b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
index 9f2ce7f03c67..456a117a65fd 100644
--- a/drivers/mailbox/armada-37xx-rwtm-mailbox.c
+++ b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
@@ -2,7 +2,7 @@
 /*
  * rWTM BIU Mailbox driver for Armada 37xx
  *
- * Author: Marek Behun <marek.behun@nic.cz>
+ * Author: Marek Behún <kabel@kernel.org>
  */
 
 #include <linux/device.h>
@@ -203,4 +203,4 @@ module_platform_driver(armada_37xx_mbox_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("rWTM BIU Mailbox driver for Armada 37xx");
-MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_AUTHOR("Marek Behun <kabel@kernel.org>");
diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
index e5dcb26d85f0..1635f421ef2c 100644
--- a/drivers/watchdog/armada_37xx_wdt.c
+++ b/drivers/watchdog/armada_37xx_wdt.c
@@ -2,7 +2,7 @@
 /*
  * Watchdog driver for Marvell Armada 37xx SoCs
  *
- * Author: Marek Behun <marek.behun@nic.cz>
+ * Author: Marek Behún <kabel@kernel.org>
  */
 
 #include <linux/clk.h>
@@ -366,7 +366,7 @@ static struct platform_driver armada_37xx_wdt_driver = {
 
 module_platform_driver(armada_37xx_wdt_driver);
 
-MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_AUTHOR("Marek Behun <kabel@kernel.org>");
 MODULE_DESCRIPTION("Armada 37xx CPU Watchdog");
 
 MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/bus/moxtet.h b/include/dt-bindings/bus/moxtet.h
index dc9345440ebe..10528de7b3ef 100644
--- a/include/dt-bindings/bus/moxtet.h
+++ b/include/dt-bindings/bus/moxtet.h
@@ -2,7 +2,7 @@
 /*
  * Constant for device tree bindings for Turris Mox module configuration bus
  *
- * Copyright (C) 2019 Marek Behun <marek.behun@nic.cz>
+ * Copyright (C) 2019 Marek Behún <kabel@kernel.org>
  */
 
 #ifndef _DT_BINDINGS_BUS_MOXTET_H
diff --git a/include/linux/armada-37xx-rwtm-mailbox.h b/include/linux/armada-37xx-rwtm-mailbox.h
index 57bb54f6767a..ef4bd705eb65 100644
--- a/include/linux/armada-37xx-rwtm-mailbox.h
+++ b/include/linux/armada-37xx-rwtm-mailbox.h
@@ -2,7 +2,7 @@
 /*
  * rWTM BIU Mailbox driver for Armada 37xx
  *
- * Author: Marek Behun <marek.behun@nic.cz>
+ * Author: Marek Behún <kabel@kernel.org>
  */
 
 #ifndef _LINUX_ARMADA_37XX_RWTM_MAILBOX_H_
diff --git a/include/linux/moxtet.h b/include/linux/moxtet.h
index 490db6886dcc..79184948fab4 100644
--- a/include/linux/moxtet.h
+++ b/include/linux/moxtet.h
@@ -2,7 +2,7 @@
 /*
  * Turris Mox module configuration bus driver
  *
- * Copyright (C) 2019 Marek Behun <marek.behun@nic.cz>
+ * Copyright (C) 2019 Marek Behún <kabel@kernel.org>
  */
 
 #ifndef __LINUX_MOXTET_H
-- 
2.26.2

