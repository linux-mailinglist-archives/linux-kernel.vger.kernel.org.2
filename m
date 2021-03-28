Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B5534BCED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC1P3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 11:29:04 -0400
Received: from mout02.posteo.de ([185.67.36.66]:45921 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhC1P3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 11:29:03 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 292082400FD
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 17:29:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1616945341; bh=8mi09Rx1C6p0vrdpYJiMwlPPYaMYUrw/IsAC+AOdZ3o=;
        h=From:To:Cc:Subject:Date:From;
        b=JQ6E+OKX1vM67tdNoYt9F/KUS+9BbhmPdrbZQRf6Z1P4EBDNaSKutOXMCQd6aAeuQ
         FxX+huL/2oSr6HABIWpVzPSS20+7lHK4XIpNYpcCbMNr+aM08Ecmn7rOSghknrrWYh
         20oPK4X6MixjV+VwPRES3ooU3Y6C6x+mdqB0FD+R5wMCNf2zrTyVi5/JJZB/Q/agid
         vLQkRjYQOAEM4ouneuTMM+/ta/G/J0teFUrZ+GNr6/Y+EZziK2QixX87ghgGvYMI0O
         p/Ux6fkXlu0UqF8StHHvbq7zdsFiiN8EjKaJ6TjAwF62oDDMV+ShQ03WZUHzWw2svc
         836LGFyPtJz4A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4F7fkg6VkRz6tmG;
        Sun, 28 Mar 2021 17:28:59 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH] Documentation: Add leading slash to some paths
Date:   Sun, 28 Mar 2021 16:28:37 +0100
Message-Id: <20210328152837.73347-1-shiftee@posteo.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change multiple sys/xyz to /sys/xyz

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 Documentation/admin-guide/mm/numaperf.rst |  2 +-
 Documentation/fb/fbcon.rst                |  4 ++--
 Documentation/hid/intel-ish-hid.rst       |  2 +-
 Documentation/leds/leds-lm3556.rst        | 28 +++++++++++------------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
index c2f826409bf0..166697325947 100644
--- a/Documentation/admin-guide/mm/numaperf.rst
+++ b/Documentation/admin-guide/mm/numaperf.rst
@@ -151,7 +151,7 @@ Each cache level's directory provides its attributes. For example, the
 following shows a single cache level and the attributes available for
 software to query::
 
-	# tree sys/devices/system/node/node0/memory_side_cache/
+	# tree /sys/devices/system/node/node0/memory_side_cache/
 	/sys/devices/system/node/node0/memory_side_cache/
 	|-- index1
 	|   |-- indexing
diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 57f66de2f7e1..212f7003cfba 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -207,9 +207,9 @@ Documentation/driver-api/console.rst. To summarize:
 Echo a value to the bind file that represents the framebuffer console
 driver. So assuming vtcon1 represents fbcon, then::
 
-  echo 1 > sys/class/vtconsole/vtcon1/bind - attach framebuffer console to
+  echo 1 > /sys/class/vtconsole/vtcon1/bind - attach framebuffer console to
 					     console layer
-  echo 0 > sys/class/vtconsole/vtcon1/bind - detach framebuffer console from
+  echo 0 > /sys/class/vtconsole/vtcon1/bind - detach framebuffer console from
 					     console layer
 
 If fbcon is detached from the console layer, your boot console driver (which is
diff --git a/Documentation/hid/intel-ish-hid.rst b/Documentation/hid/intel-ish-hid.rst
index f6ce44ff611d..7a851252267a 100644
--- a/Documentation/hid/intel-ish-hid.rst
+++ b/Documentation/hid/intel-ish-hid.rst
@@ -345,7 +345,7 @@ Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space.
 To debug ISH, event tracing mechanism is used. To enable debug logs::
 
   echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
-  cat sys/kernel/debug/tracing/trace
+  cat /sys/kernel/debug/tracing/trace
 
 3.8 ISH IIO sysfs Example on Lenovo thinkpad Yoga 260
 -----------------------------------------------------
diff --git a/Documentation/leds/leds-lm3556.rst b/Documentation/leds/leds-lm3556.rst
index 1ef17d7d800e..32e3983473ba 100644
--- a/Documentation/leds/leds-lm3556.rst
+++ b/Documentation/leds/leds-lm3556.rst
@@ -23,7 +23,7 @@ from 93.75 mA to 1500 mA.The Flash currents are adjusted via the CURRENT
 CONTROL REGISTER(0x09).Flash mode is activated by the ENABLE REGISTER(0x0A),
 or by pulling the STROBE pin HIGH.
 
-LM3556 Flash can be controlled through sys/class/leds/flash/brightness file
+LM3556 Flash can be controlled through /sys/class/leds/flash/brightness file
 
 * if STROBE pin is enabled, below example control brightness only, and
   ON / OFF will be controlled by STROBE pin.
@@ -32,17 +32,17 @@ Flash Example:
 
 OFF::
 
-	#echo 0 > sys/class/leds/flash/brightness
+	#echo 0 > /sys/class/leds/flash/brightness
 
 93.75 mA::
 
-	#echo 1 > sys/class/leds/flash/brightness
+	#echo 1 > /sys/class/leds/flash/brightness
 
 ...
 
 1500  mA::
 
-	#echo 16 > sys/class/leds/flash/brightness
+	#echo 16 > /sys/class/leds/flash/brightness
 
 Torch Mode
 ^^^^^^^^^^
@@ -51,7 +51,7 @@ In Torch Mode, the current source(LED) is programmed via the CURRENT CONTROL
 REGISTER(0x09).Torch Mode is activated by the ENABLE REGISTER(0x0A) or by the
 hardware TORCH input.
 
-LM3556 torch can be controlled through sys/class/leds/torch/brightness file.
+LM3556 torch can be controlled through /sys/class/leds/torch/brightness file.
 * if TORCH pin is enabled, below example control brightness only,
 and ON / OFF will be controlled by TORCH pin.
 
@@ -59,22 +59,22 @@ Torch Example:
 
 OFF::
 
-	#echo 0 > sys/class/leds/torch/brightness
+	#echo 0 > /sys/class/leds/torch/brightness
 
 46.88 mA::
 
-	#echo 1 > sys/class/leds/torch/brightness
+	#echo 1 > /sys/class/leds/torch/brightness
 
 ...
 
 375 mA::
 
-	#echo 8 > sys/class/leds/torch/brightness
+	#echo 8 > /sys/class/leds/torch/brightness
 
 Indicator Mode
 ^^^^^^^^^^^^^^
 
-Indicator pattern can be set through sys/class/leds/indicator/pattern file,
+Indicator pattern can be set through /sys/class/leds/indicator/pattern file,
 and 4 patterns are pre-defined in indicator_pattern array.
 
 According to N-lank, Pulse time and N Period values, different pattern wiill
@@ -87,13 +87,13 @@ Indicator pattern example:
 
 pattern 0::
 
-	#echo 0 > sys/class/leds/indicator/pattern
+	#echo 0 > /sys/class/leds/indicator/pattern
 
 ...
 
 pattern 3::
 
-	#echo 3 > sys/class/leds/indicator/pattern
+	#echo 3 > /sys/class/leds/indicator/pattern
 
 Indicator brightness can be controlled through
 sys/class/leds/indicator/brightness file.
@@ -102,17 +102,17 @@ Example:
 
 OFF::
 
-	#echo 0 > sys/class/leds/indicator/brightness
+	#echo 0 > /sys/class/leds/indicator/brightness
 
 5.86 mA::
 
-	#echo 1 > sys/class/leds/indicator/brightness
+	#echo 1 > /sys/class/leds/indicator/brightness
 
 ...
 
 46.875mA::
 
-	#echo 8 > sys/class/leds/indicator/brightness
+	#echo 8 > /sys/class/leds/indicator/brightness
 
 Notes
 -----
-- 
2.25.1

