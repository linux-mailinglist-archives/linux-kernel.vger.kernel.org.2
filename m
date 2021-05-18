Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1C7387C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350116AbhERPMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344627AbhERPKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:10:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13838611CC;
        Tue, 18 May 2021 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621350550;
        bh=82XffmYo0cA66yCWYBV/J5xp5EBADo2oA0FQHMi2s38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJZkE1cMdTzTYatBd5+Lm3igisdnS4KHQbP66mU1UNcLylzmpkbjQrPD+AAmzuF64
         gAB3gnSKXMekKC7+d79DdqSKC3MnUc2iMYM7R/1/qW01NNCvUTEHVwKg1cVX4GMIoX
         KROkULk0XziHoTDk11d5sFwtY6WKo19PcoZjVxn8wYIZEQH5FZp3+1HDr6kYL/JOxz
         1zKfjjS/J+RZbayoh3h41geBOmZq+yAhyhrMGf+JEn1db0djdLHPyFI2OppFle8Mif
         S5KYDz33FXFpuP3EjEb8GQ0nc9dwNYhVNTb4klo67gXXqBTEvVEgzAXQmb/9dt8Uzo
         DNXd7Cal8YNww==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lj1LH-007HNy-V1; Tue, 18 May 2021 17:09:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/17] docs: describe the API used to set NUC LEDs
Date:   Tue, 18 May 2021 17:08:50 +0200
Message-Id: <176a87ffb738ec7fd650d85ec19ede882cd82772.1621349813.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621349813.git.mchehab+huawei@kernel.org>
References: <cover.1621349813.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NUC6 have LEDs that can be configurated dynamically from
the operational system, via WMI.

Describe how the API for such devices should work.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/leds/index.rst    |   1 +
 Documentation/leds/leds-nuc.rst | 447 ++++++++++++++++++++++++++++++++
 2 files changed, 448 insertions(+)
 create mode 100644 Documentation/leds/leds-nuc.rst

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index e5d63b940045..4fdf9b60bb86 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -25,4 +25,5 @@ LEDs
    leds-lp5562
    leds-lp55xx
    leds-mlxcpld
+   leds-nuc
    leds-sc27xx
diff --git a/Documentation/leds/leds-nuc.rst b/Documentation/leds/leds-nuc.rst
new file mode 100644
index 000000000000..02e1c2602dd3
--- /dev/null
+++ b/Documentation/leds/leds-nuc.rst
@@ -0,0 +1,447 @@
+==================
+Intel NUC WMI LEDs
+==================
+
+Some models of the Intel Next Unit of Computing (NUC) may have programmable
+LEDs. Those can be partially programmed by opening the BIOS configuration.
+
+Among those models, some of them also allows the Operational System to
+adjust the LED parameters via a firmware interface, called Windows Management
+Interface - WMI.
+
+There are currently three different versions of WMI API for NUC, depending
+on the NUC generation:
+
+For NUC 6 and 7, the WMI API is defined at:
+
+   - https://www.intel.com/content/www/us/en/support/articles/000023426/intel-nuc/intel-nuc-kits.html
+
+For NUC 8 and 8, the WMI API is defined at:
+
+  - https://raw.githubusercontent.com/nomego/intel_nuc_led/master/specs/INTEL_WMI_LED_0.64.pdf
+
+For NUC 10 and newer generations, the WMI API is defined at:
+  - https://www.intel.com/content/dam/support/us/en/documents/intel-nuc/WMI-Spec-Intel-NUC-NUC10ixFNx.pdf
+
+The nuc-wmi driver provides userspace support for changing the LED
+configuration, and supports WMI API since NUC 6. Yet, the NUC6 WMI API
+functionality is limited when compared with the newer NUC generations.
+
+Although there are some internal differences, the features supported for
+NUC 10 WMI API are almost identical to the ones supported by NUC 8 WMI API.
+
+.. note::
+
+   Even when the firmware supports setting LEDs via WMI API, the
+   BIOS configuration has some parameters to either allow the Operational
+   System to also control them. Instructions about how to enable it can
+   be found at the manual of each specific NUC model.
+
+NUC 6 and NUC 7
+===============
+
+When the driver detects NUC LEDs, up to two directories will be created
+under sysfs. They're asocciated with the button(s) named "Power" and "Ring".
+
+Assuming that sysfs is mounted under ``/sys``, those are the
+directories:
+
+=============	==============================
+LED name	sysfs device directory
+=============	==============================
+Power		``/sys/class/leds/nuc::power``
+Ring		``/sys/class/leds/nuc::ring``
+=============	==============================
+
+For each of the above directory, some sysfs nodes will allow to control the
+functionality for each button::
+
+    .
+    |-- blink_behavior
+    |-- blink_frequency
+    |-- brightness
+    |-- color
+    |-- device -> ../../../8C5DA44C-CDC3-46B3-8619-4E26D34390B7
+    `-- max_brightness
+
+.. note::
+
+   1. any user can read the LEDs parameter;
+   2. changing a LED parameter is limited to the owner of the sysfs device
+      nodes (usually, the ``root`` user);
+   3. changing a LED parameter is case-insensitive
+
+Brightness
+----------
+
+The ``brightness`` adjusts the LED brightness, and can be set from
+0 to ``max_brightness``.
+
+So, for instance, in order to put the power LED with 50% of the bright::
+
+    $ cat /sys/class/leds/nuc::power/max_brightness
+    100
+    # echo 50 > /sys/class/leds/nuc::power/max_brightness
+
+Color
+-----
+
+On NUC6 API, the power LED color can be be dual colored. Those are
+the valid color values:
+
+    +---------+
+    | disable |
+    +---------+
+    | blue    |
+    +---------+
+    | amber   |
+    +---------+
+
+And the ring LED color can be multi colored. Those are the valid color
+values:
+
+    +---------+
+    | disable |
+    +---------+
+    | cyan    |
+    +---------+
+    | pink    |
+    +---------+
+    | yellow  |
+    +---------+
+    | blue    |
+    +---------+
+    | red     |
+    +---------+
+    | green   |
+    +---------+
+    | white   |
+    +---------+
+
+Changing the ring color of the ring LED can be done with::
+
+    $ cat /sys/class/leds/nuc::ring/color
+    [disable]  cyan  pink  yellow  blue  red  green  white
+    # echo "cyan" > /sys/class/leds/nuc::ring/color
+
+Blink behavior and frequency
+----------------------------
+
+The NUC6 API supports those blink behaviors:
+
+    +-------+
+    | Solid |
+    +-------+
+    | Blink |
+    +-------+
+    | Fade  |
+    +-------+
+
+
+When in blink and/or fade mode, it supports the following frequencies:
+
+    +---------+
+    | 1 Hz    |
+    +---------+
+    | 0.5 Hz  |
+    +---------+
+    | 0.25 Hz |
+    +---------+
+
+Changing the blink behavior of the power LED, for instance, can be done
+with::
+
+    $ cat /sys/class/leds/nuc::power/blink_behavior
+    [solid] blink  fade
+    $ cat /sys/class/leds/nuc::power/blink_frequency
+    [1]  0.5  0.25
+    # echo "blink" > /sys/class/leds/nuc::power/blink_behavior
+    # echo 0.5 > /sys/class/leds/nuc::power/blink_frequency
+
+.. note::
+
+   The blink/fade behavior and frequencies can support only a subset of
+   the above values on old BIOS.
+
+NUC 8 and newer generations
+===========================
+
+When the driver detects NUC LEDs,  up to seven directories will be
+created under sysfs. Each one for each different LED.
+
+Assuming that sysfs is mounted under ``/sys``, those are the
+directories:
+
+=============	===============================
+LED name	sysfs device node
+=============	===============================
+Skull		``/sys/class/leds/nuc::skull``
+Skull eyes	``/sys/class/leds/nuc::eyes``
+Power		``/sys/class/leds/nuc::power``
+HDD		``/sys/class/leds/nuc::hdd``
+Front1		``/sys/class/leds/nuc::front1``
+Front2		``/sys/class/leds/nuc::front2``
+Front3		``/sys/class/leds/nuc::front3``
+=============	===============================
+
+For each of the above directory, some sysfs nodes will allow to control the
+functionality for each button::
+
+    /sys/class/leds/nuc::front1
+    |-- blink_behavior
+    |-- blink_frequency
+    |-- brightness
+    |-- color
+    |-- ethernet_type
+    |-- hdd_default
+    |-- indicator
+    |-- max_brightness
+    |-- power_limit_scheme
+    |-- ready_mode_blink_behavior
+    |-- ready_mode_blink_frequency
+    |-- ready_mode_brightness
+    |-- s0_blink_behavior
+    |-- s0_blink_frequency
+    |-- s0_brightness
+    |-- s3_blink_behavior
+    |-- s3_blink_frequency
+    |-- s3_brightness
+    |-- s5_blink_behavior
+    |-- s5_blink_frequency
+    `-- s5_brightness
+
+The sessions below will explain the meaning of each aspect of the API.
+
+.. note::
+
+   1. any user can read the LEDs parameter;
+   2. changing a LED parameter is limited to the owner of the sysfs device
+      nodes (usually, the ``root`` user);
+   3. changing a LED parameter is case-insensitive;
+   4. The LED ``indicator`` parameter controls the function of the LED.
+      All other parameters can be enabled or disabled in runtime, depending
+      on it. When a certain parameter is disabled, an error code will be
+      returned;
+   5. The hardware and its firmware actually controls the LED. The interface
+      provided by the driver just changes the LED settings in runtime.
+      Such changes can persist even after rebooting.
+
+LED indicator
+-------------
+
+Despite the LED's name, the LED API may allow them to indicate different
+hardware events.
+
+This is controlled via the ``indicator`` device node. Reading from it displays
+all the supported events for a giving LED, and the currently ative one::
+
+    $ cat /sys/class/leds/nuc::front1/indicator
+    Power State  [HDD Activity]  Ethernet  WiFi  Software  Power Limit  Disable
+
+Each LED may support the following indicator types:
+
+	==============	=======================================================
+	Indicator type	Meaning
+	==============	=======================================================
+	Power State	Shows if the device is powered and what power level
+			it is (e. g. if the device is suspended or not, and
+			on which kind of suspended level).
+	HDD Activity	Indicates if the LED is measuring the hard disk (or
+			SDD) activity.
+	Ethernet	Indicates the activity Ethernet adapter(s)
+	WiFi		Indicates if WiFi is enabled
+	Software	Doesn't indicate any hardware level. Instead, the LED
+			status is controlled via software.
+	Power Limit	Changes the LED color when the computer is throttling
+			its power limits.
+	Disable		The LED was disabled.
+	==============	=======================================================
+
+In order to change the type of indicator, you should
+just write a new value to the indicator type::
+
+    # echo "wifi" > /sys/class/leds/nuc::front1/indicator
+
+    $ cat /sys/class/leds/nuc::front1/indicator
+    Power State  HDD Activity  Ethernet  [WiFi]  Software  Power Limit  Disable
+
+
+Power State parameters
+----------------------
+
+When the LED indicator is measuring *Power State*, the following parameters
+may be available:
+
+    =================================	=======================================
+    Parameter				Meaning
+    =================================	=======================================
+    <power_state>_brightness		Brightness in percent (from 0 to 100)
+    <power_state>_blink_behavior	type of blink.
+					See :ref:`nuc_blink_behavior`.
+    <power_state>_blink_frequency	Blink frequency.
+					See :ref:`nuc_blink_behavior`.
+    <power_state>_color			LED color
+					See :ref:`nuc_color`.
+    =================================	=======================================
+
+Where <power_state> can be:
+
+On NUC8/9 API:
+
+    +------------+
+    | S0	 |
+    +------------+
+    | S3	 |
+    +------------+
+    | S5	 |
+    +------------+
+    | Ready mode |
+    +------------+
+
+On NUC10 API:
+
+    +------------+
+    | S0	 |
+    +------------+
+    | S3	 |
+    +------------+
+    | Standby	 |
+    +------------+
+
+HDD Activity parameters
+-----------------------
+
+When the LED indicator is measuring *HDD Activity*, the following parameters
+may be available:
+
+    =================================	=======================================
+    Parameter				Meaning
+    =================================	=======================================
+    brightness				Brightness in percent (from 0 to 100)
+    color				LED color.
+					See :ref:`nuc_color`.
+    hdd_default				Default is LED turned ON or OFF.
+					When set toOFF, the LED will turn on
+					at disk activity.
+					When set to ON, the LED will be turned
+					on by default, turning off at disk
+					activity.
+    =================================	=======================================
+
+Ethernet parameters
+-------------------
+
+When the LED indicator is measuring *Ethernet*, the following parameters
+may be available:
+
+    =================================	=======================================
+    Parameter				Meaning
+    =================================	=======================================
+    brightness				Brightness in percent (from 0 to 100)
+    color				LED color.
+					See :ref:`nuc_color`.
+    ethernet_type			What Ethernet interface is monitored.
+					Can be:
+					LAN1, LAN2 or LAN1+LAN2.
+    =================================	=======================================
+
+Power limit parameters
+----------------------
+
+When the LED indicator is measuring *Power limit*, the following parameters
+may be available:
+
+    =================================	=======================================
+    Parameter				Meaning
+    =================================	=======================================
+    brightness				Brightness in percent (from 0 to 100)
+    color				LED color.
+					See :ref:`nuc_color`.
+    power_limit_scheme			Indication scheme can be either:
+					- green to red
+					- single color
+    =================================	=======================================
+
+
+.. _nuc_color:
+
+NUC LED colors
+--------------
+
+The NUC LED API may support 3 types of LEDs:
+
+- Mono-colored LEDs;
+- Dual-colored LEDs;
+- multi-colored LEDs (only on NUC6/7);
+- RGB LEDs.
+
+Also, when a let is set to be a *Power limit* indicator, despite the
+physical device's LED color, the API may limit it to be a led that
+can display only green and red, or just a single color.
+
+The ``color`` and ``<power_state>_color`` parameter supports all those
+different settings.
+
+The color parameter can be set to those values:
+
+    ============	======	=====	=====
+    Color name		Red	Green	Blue
+    ============	======	=====	=====
+    blue		0	0	255
+    amber		255	191	0
+    white		255	255	255
+    red			255	0	0
+    green		0	255	0
+    yellow		255	255	0
+    cyan		0	255	255
+    magenta		255	0	255
+    <r>,<g>,<b>		<r>	<g>	<b>
+    ============	======	=====	=====
+
+The color parameter will refuse to set a LED on a color that it is not
+supported by the hardware or when the setting is incompatible with the
+indicator type. So, when the indicator is set to *Power limit*, and
+the  ``power_limit_scheme`` is set to ``green to red``, it doesn't
+let to set the LED's color.
+
+On the other hand, the behavior is identical if a color is written using
+the color's name or its RGB value.
+
+So::
+
+   $ cat /sys/class/leds/nuc::front1/color
+   red
+   # echo "green" > /sys/class/leds/nuc::front1/color
+   $ cat /sys/class/leds/nuc::front1/color
+   green
+   # echo "255,0,0" > /sys/class/leds/nuc::front1/color
+   $ cat /sys/class/leds/nuc::front1/color
+   red
+
+.. _nuc_blink_behavior:
+
+NUC Blink behavior
+------------------
+
+The NUC LEDs hardware supports the following types of blink behavior:
+
+    +------------+
+    | Solid      |
+    +------------+
+    | Breathing  |
+    +------------+
+    | Pulsing    |
+    +------------+
+    | Strobing   |
+    +------------+
+
+Changing the blink behavior will change how the led will be turning
+on and off when blinking. Setting it to ``Solid`` disables blinking.
+
+Please notice that not all types of indicator supports blinking.
+
+When blinking, the blink frequency can be changed via ``blink_frequency``
+or ``<power_state>_blink_frequency``, depending on the indicator.
+
+Setting it allows to change the blink frequency in Hz, ranging from 0.1 Hz
+to 1.0 Hz, in multiples of 0.1 Hz.
-- 
2.31.1

