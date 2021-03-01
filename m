Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34AD3281D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhCAPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbhCAPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:08:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90599C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:07:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lGk8j-00AJOK-CA; Mon, 01 Mar 2021 16:07:17 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/8] um: allow disabling NO_IOMEM
Date:   Mon,  1 Mar 2021 16:07:01 +0100
Message-Id: <20210301160501.0d0898834452.I7b2fad8378e4fde7f26ef06a03980ae2807d81c9@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210301150708.244970-1-johannes@sipsolutions.net>
References: <20210301150708.244970-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Adjust the kconfig a little to allow disabling NO_IOMEM in UML. To
make an "allyesconfig" with CONFIG_NO_IOMEM=n build, adjust a few
Kconfig things elsewhere and add dummy asm/fb.h and asm/vga.h files.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: use asm-generic for fb.h and vga.h
---
 arch/um/Kconfig                | 4 ++++
 arch/um/include/asm/Kbuild     | 2 ++
 drivers/input/Kconfig          | 1 -
 drivers/input/gameport/Kconfig | 1 +
 drivers/input/joystick/Kconfig | 1 +
 drivers/tty/Kconfig            | 5 ++---
 drivers/video/console/Kconfig  | 2 +-
 7 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c3030db3325f..20b0640e01b8 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -26,6 +26,10 @@ config MMU
 	default y
 
 config NO_IOMEM
+	bool "disable IOMEM" if EXPERT
+	default y
+
+config NO_IOPORT_MAP
 	def_bool y
 
 config ISA
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index d7492e5a1bbb..10b7228b3aee 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += device.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
+generic-y += fb.h
 generic-y += ftrace.h
 generic-y += futex.h
 generic-y += hw_irq.h
@@ -27,3 +28,4 @@ generic-y += trace_clock.h
 generic-y += word-at-a-time.h
 generic-y += kprobes.h
 generic-y += mm_hooks.h
+generic-y += vga.h
diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index ec0e861f185f..5baebf62df33 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -4,7 +4,6 @@
 #
 
 menu "Input device support"
-	depends on !UML
 
 config INPUT
 	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EXPERT
diff --git a/drivers/input/gameport/Kconfig b/drivers/input/gameport/Kconfig
index 4761795cb49f..5a2c2fb3217d 100644
--- a/drivers/input/gameport/Kconfig
+++ b/drivers/input/gameport/Kconfig
@@ -4,6 +4,7 @@
 #
 config GAMEPORT
 	tristate "Gameport support"
+	depends on !UML
 	help
 	  Gameport support is for the standard 15-pin PC gameport. If you
 	  have a joystick, gamepad, gameport card, a soundcard with a gameport
diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 5e38899058c1..b10948bf9551 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -4,6 +4,7 @@
 #
 menuconfig INPUT_JOYSTICK
 	bool "Joysticks/Gamepads"
+	depends on !UML
 	help
 	  If you have a joystick, 6dof controller, gamepad, steering wheel,
 	  weapon control system or something like that you can say Y here
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index e15cd6b5bb99..26648daaaee2 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -12,9 +12,8 @@ if TTY
 
 config VT
 	bool "Virtual terminal" if EXPERT
-	depends on !UML
 	select INPUT
-	default y
+	default y if !UML
 	help
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you
@@ -78,7 +77,7 @@ config VT_CONSOLE_SLEEP
 
 config HW_CONSOLE
 	bool
-	depends on VT && !UML
+	depends on VT
 	default y
 
 config VT_HW_CONSOLE_BINDING
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index ee33b8ec62bb..840d9813b0bc 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && !S390
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && !S390 && !UML
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
2.26.2

