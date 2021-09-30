Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C241D6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349514AbhI3JrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349521AbhI3Jqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:46:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4A5961880;
        Thu, 30 Sep 2021 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995102;
        bh=nOlAgv7jfacXo1OKQpccUMgigHCAZh4y0MMt4Cmh/X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+ZhkBkt3L7k6wsRKNoh8ugy3zRbg0zXhO5g91ZDVkxPGeHuA0Pv4B+W3xeP/vshd
         70cYMkGiDbC5Hfh6xU9wn/UZ2gxWqNcXuWKfm9VvG/e/JG3ftkVjC9nRcuomFa9J0y
         V5jyAu2PD/tlqIjMmriAXtIg0Xry0RuNBoELtSXxgSbGwNRtBuSJmDvGSWwkre6Vz6
         cMkU7vteba6SKt1zqWk6IbMV7CSSG4XOeTzSTMohSQfxYzll0NDZKav2Tl3279V/Ym
         itAOpD8EfM8yGkJ9z3IOZGi2CBvDEzOz0ctn2TH/th6bTxqe9G8uP6iukXXUeMq5y9
         LY2e5cVFc85Bw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVscd-002AT8-LM; Thu, 30 Sep 2021 11:44:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] ABI: sysfs-class-hwmon: add ABI documentation for it
Date:   Thu, 30 Sep 2021 11:44:49 +0200
Message-Id: <5f47619ed882b0b8d1c84b56f7ea17bac0854b77.1632994837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632994837.git.mchehab+huawei@kernel.org>
References: <cover.1632994837.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the ABI attributes documentation from:
	Documentation/hwmon/sysfs-interface.rst

in order for it to follow the usual ABI documentation. That
allows script/get_abi.pl to properly handle it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1632994837.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-class-hwmon | 918 ++++++++++++++++++++
 Documentation/hwmon/sysfs-interface.rst     | 596 +------------
 MAINTAINERS                                 |   1 +
 3 files changed, 961 insertions(+), 554 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-hwmon

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
new file mode 100644
index 000000000000..ea5a129ae082
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -0,0 +1,918 @@
+What:		/sys/class/hwmon/hwmonX/name
+Description:
+		The chip name.
+		This should be a short, lowercase string, not containing
+		whitespace, dashes, or the wildcard character '*'.
+		This attribute represents the chip name. It is the only
+		mandatory attribute.
+		I2C devices get this attribute created automatically.
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/update_interval
+Description:
+		The interval at which the chip will update readings.
+		Unit: millisecond
+
+		RW
+
+		Some devices have a variable update rate or interval.
+		This attribute can be used to change it to the desired value.
+
+What:		/sys/class/hwmon/hwmonX/inY_min
+Description:
+		Voltage min value.
+
+		Unit: millivolt
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/inY_lcrit
+Description:
+		Voltage critical min value.
+
+		Unit: millivolt
+
+		RW
+
+		If voltage drops to or below this limit, the system may
+		take drastic action such as power down or reset. At the very
+		least, it should report a fault.
+
+What:		/sys/class/hwmon/hwmonX/inY_max
+Description:
+		Voltage max value.
+
+		Unit: millivolt
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/inY_crit
+Description:
+		Voltage critical max value.
+
+		Unit: millivolt
+
+		RW
+
+		If voltage reaches or exceeds this limit, the system may
+		take drastic action such as power down or reset. At the very
+		least, it should report a fault.
+
+What:		/sys/class/hwmon/hwmonX/inY_input
+Description:
+		Voltage input value.
+
+		Unit: millivolt
+
+		RO
+
+		Voltage measured on the chip pin.
+
+		Actual voltage depends on the scaling resistors on the
+		motherboard, as recommended in the chip datasheet.
+
+		This varies by chip and by motherboard.
+		Because of this variation, values are generally NOT scaled
+		by the chip driver, and must be done by the application.
+		However, some drivers (notably lm87 and via686a)
+		do scale, because of internal resistors built into a chip.
+		These drivers will output the actual voltage. Rule of
+		thumb: drivers should report the voltage values at the
+		"pins" of the chip.
+
+What:		/sys/class/hwmon/hwmonX/inY_average
+Description:
+		Average voltage
+
+		Unit: millivolt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_lowest
+Description:
+		Historical minimum voltage
+
+		Unit: millivolt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_highest
+Description:
+		Historical maximum voltage
+
+		Unit: millivolt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_reset_history
+Description:
+		Reset inX_lowest and inX_highest
+
+		WO
+
+What:		/sys/class/hwmon/hwmonX/in_reset_history
+Description:
+		Reset inX_lowest and inX_highest for all sensors
+
+		WO
+
+What:		/sys/class/hwmon/hwmonX/inY_label
+Description:
+		Suggested voltage channel label.
+
+		Text string
+
+		Should only be created if the driver has hints about what
+		this voltage channel is being used for, and user-space
+		doesn't. In all other cases, the label is provided by
+		user-space.
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_enable
+Description:
+		Enable or disable the sensors.
+
+		When disabled the sensor read will return -ENODATA.
+
+		- 1: Enable
+		- 0: Disable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/cpuY_vid
+Description:
+		CPU core reference voltage.
+
+		Unit: millivolt
+
+		RO
+
+		Not always correct.
+
+What:		/sys/class/hwmon/hwmonX/vrm
+Description:
+		Voltage Regulator Module version number.
+
+		RW (but changing it should no more be necessary)
+
+		Originally the VRM standard version multiplied by 10, but now
+		an arbitrary number, as not all standards have a version
+		number.
+
+		Affects the way the driver calculates the CPU core reference
+		voltage from the vid pins.
+
+What:		/sys/class/hwmon/hwmonX/inY_rated_min
+Description:
+		Minimum rated voltage.
+
+		Unit: millivolt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_rated_max
+Description:
+		Maximum rated voltage.
+
+		Unit: millivolt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/fanY_min
+Description:
+		Fan minimum value
+
+		Unit: revolution/min (RPM)
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/fanY_max
+Description:
+		Fan maximum value
+
+		Unit: revolution/min (RPM)
+
+		Only rarely supported by the hardware.
+		RW
+
+What:		/sys/class/hwmon/hwmonX/fanY_input
+Description:
+		Fan input value.
+
+		Unit: revolution/min (RPM)
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/fanY_div
+Description:
+		Fan divisor.
+
+		Integer value in powers of two (1, 2, 4, 8, 16, 32, 64, 128).
+
+		RW
+
+		Some chips only support values 1, 2, 4 and 8.
+		Note that this is actually an internal clock divisor, which
+		affects the measurable speed range, not the read value.
+
+What:		/sys/class/hwmon/hwmonX/fanY_pulses
+Description:
+		Number of tachometer pulses per fan revolution.
+
+		Integer value, typically between 1 and 4.
+
+		RW
+
+		This value is a characteristic of the fan connected to the
+		device's input, so it has to be set in accordance with the fan
+		model.
+
+		Should only be created if the chip has a register to configure
+		the number of pulses. In the absence of such a register (and
+		thus attribute) the value assumed by all devices is 2 pulses
+		per fan revolution.
+
+What:		/sys/class/hwmon/hwmonX/fanY_target
+Description:
+		Desired fan speed
+
+		Unit: revolution/min (RPM)
+
+		RW
+
+		Only makes sense if the chip supports closed-loop fan speed
+		control based on the measured fan speed.
+
+What:		/sys/class/hwmon/hwmonX/fanY_label
+Description:
+		Suggested fan channel label.
+
+		Text string
+
+		Should only be created if the driver has hints about what
+		this fan channel is being used for, and user-space doesn't.
+		In all other cases, the label is provided by user-space.
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/fanY_enable
+Description:
+		Enable or disable the sensors.
+
+		When disabled the sensor read will return -ENODATA.
+
+		- 1: Enable
+		- 0: Disable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/pwmY
+Description:
+		Pulse width modulation fan control.
+
+		Integer value in the range 0 to 255
+
+		RW
+
+		255 is max or 100%.
+
+What:		/sys/class/hwmon/hwmonX/pwmY_enable
+Description:
+		Fan speed control method:
+
+		- 0: no fan speed control (i.e. fan at full speed)
+		- 1: manual fan speed control enabled (using `pwmY`)
+		- 2+: automatic fan speed control enabled
+
+		Check individual chip documentation files for automatic mode
+		details.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/pwmY_mode
+Description:
+		- 0: DC mode (direct current)
+		- 1: PWM mode (pulse-width modulation)
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/pwmY_freq
+Description:
+		Base PWM frequency in Hz.
+
+		Only possibly available when pwmN_mode is PWM, but not always
+		present even then.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/pwmY_auto_channels_temp
+Description:
+		Select which temperature channels affect this PWM output in
+		auto mode.
+
+		Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
+		Which values are possible depend on the chip used.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/pwmY_auto_pointZ_pwm
+What:		/sys/class/hwmon/hwmonX/pwmY_auto_pointZ_temp
+What:		/sys/class/hwmon/hwmonX/pwmY_auto_pointZ_temp_hyst
+Description:
+		Define the PWM vs temperature curve.
+
+		Number of trip points is chip-dependent. Use this for chips
+		which associate trip points to PWM output channels.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_auto_pointZ_pwm
+What:		/sys/class/hwmon/hwmonX/tempY_auto_pointZ_temp
+What:		/sys/class/hwmon/hwmonX/tempY_auto_pointZ_temp_hyst
+Description:
+		Define the PWM vs temperature curve.
+
+		Number of trip points is chip-dependent. Use this for chips
+		which associate trip points to temperature channels.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_type
+Description:
+		Sensor type selection.
+
+		Integers 1 to 6
+
+		RW
+
+		- 1: CPU embedded diode
+		- 2: 3904 transistor
+		- 3: thermal diode
+		- 4: thermistor
+		- 5: AMD AMDSI
+		- 6: Intel PECI
+
+		Not all types are supported by all chips
+
+What:		/sys/class/hwmon/hwmonX/tempY_max
+Description:
+		Temperature max value.
+
+		Unit: millidegree Celsius (or millivolt, see below)
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_min
+Description:
+		Temperature min value.
+
+		Unit: millidegree Celsius
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_max_hyst
+Description:
+		Temperature hysteresis value for max limit.
+
+		Unit: millidegree Celsius
+
+		Must be reported as an absolute temperature, NOT a delta
+		from the max value.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_min_hyst
+Description:
+		Temperature hysteresis value for min limit.
+		Unit: millidegree Celsius
+
+		Must be reported as an absolute temperature, NOT a delta
+		from the min value.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_input
+Description:
+		Temperature input value.
+
+		Unit: millidegree Celsius
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_crit
+Description:
+		Temperature critical max value, typically greater than
+		corresponding temp_max values.
+
+		Unit: millidegree Celsius
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_crit_hyst
+Description:
+		Temperature hysteresis value for critical limit.
+
+		Unit: millidegree Celsius
+
+		Must be reported as an absolute temperature, NOT a delta
+		from the critical value.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_emergency
+Description:
+		Temperature emergency max value, for chips supporting more than
+		two upper temperature limits. Must be equal or greater than
+		corresponding temp_crit values.
+
+		Unit: millidegree Celsius
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_emergency_hyst
+Description:
+		Temperature hysteresis value for emergency limit.
+
+		Unit: millidegree Celsius
+
+		Must be reported as an absolute temperature, NOT a delta
+		from the emergency value.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_lcrit
+Description:
+		Temperature critical min value, typically lower than
+		corresponding temp_min values.
+
+		Unit: millidegree Celsius
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_lcrit_hyst
+Description:
+		Temperature hysteresis value for critical min limit.
+
+		Unit: millidegree Celsius
+
+		Must be reported as an absolute temperature, NOT a delta
+		from the critical min value.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_offset
+Description:
+		Temperature offset which is added to the temperature reading
+		by the chip.
+
+		Unit: millidegree Celsius
+
+		Read/Write value.
+
+What:		/sys/class/hwmon/hwmonX/tempY_label
+Description:
+		Suggested temperature channel label.
+
+		Text string
+
+		Should only be created if the driver has hints about what
+		this temperature channel is being used for, and user-space
+		doesn't. In all other cases, the label is provided by
+		user-space.
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_lowest
+Description:
+		Historical minimum temperature
+
+		Unit: millidegree Celsius
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_highest
+Description:
+		Historical maximum temperature
+
+		Unit: millidegree Celsius
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_reset_history
+Description:
+		Reset temp_lowest and temp_highest
+
+		WO
+
+What:		/sys/class/hwmon/hwmonX/temp_reset_history
+Description:
+		Reset temp_lowest and temp_highest for all sensors
+
+		WO
+
+What:		/sys/class/hwmon/hwmonX/tempY_enable
+Description:
+		Enable or disable the sensors.
+
+		When disabled the sensor read will return -ENODATA.
+
+		- 1: Enable
+		- 0: Disable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_rated_min
+Description:
+		Minimum rated temperature.
+
+		Unit: millidegree Celsius
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_rated_max
+Description:
+		Maximum rated temperature.
+
+		Unit: millidegree Celsius
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_max
+Description:
+		Current max value
+
+		Unit: milliampere
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/currY_min
+Description:
+		Current min value.
+
+		Unit: milliampere
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/currY_lcrit
+Description:
+		Current critical low value
+
+		Unit: milliampere
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/currY_crit
+Description:
+		Current critical high value.
+
+		Unit: milliampere
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/currY_input
+Description:
+		Current input value
+
+		Unit: milliampere
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_average
+Description:
+		Average current use
+
+		Unit: milliampere
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_lowest
+Description:
+		Historical minimum current
+
+		Unit: milliampere
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_highest
+Description:
+		Historical maximum current
+		Unit: milliampere
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_reset_history
+Description:
+		Reset currX_lowest and currX_highest
+
+		WO
+
+What:		/sys/class/hwmon/hwmonX/curr_reset_history
+Description:
+		Reset currX_lowest and currX_highest for all sensors
+
+		WO
+
+What:		/sys/class/hwmon/hwmonX/currY_enable
+Description:
+		Enable or disable the sensors.
+
+		When disabled the sensor read will return -ENODATA.
+
+		- 1: Enable
+		- 0: Disable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/currY_rated_min
+Description:
+		Minimum rated current.
+
+		Unit: milliampere
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_rated_max
+Description:
+		Maximum rated current.
+
+		Unit: milliampere
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_average
+Description:
+		Average power use
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_average_interval
+Description:
+		Power use averaging interval.  A poll
+		notification is sent to this file if the
+		hardware changes the averaging interval.
+
+		Unit: milliseconds
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/powerY_average_interval_max
+Description:
+		Maximum power use averaging interval
+
+		Unit: milliseconds
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_average_interval_min
+Description:
+		Minimum power use averaging interval
+
+		Unit: milliseconds
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_average_highest
+Description:
+		Historical average maximum power use
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_average_lowest
+Description:
+		Historical average minimum power use
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_average_max
+Description:
+		A poll notification is sent to
+		`powerY_average` when power use
+		rises above this value.
+
+		Unit: microWatt
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/powerY_average_min
+Description:
+		A poll notification is sent to
+		`powerY_average` when power use
+		sinks below this value.
+
+		Unit: microWatt
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/powerY_input
+Description:
+		Instantaneous power use
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_input_highest
+Description:
+		Historical maximum power use
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_input_lowest
+Description:
+		Historical minimum power use
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_reset_history
+Description:
+		Reset input_highest, input_lowest,
+		average_highest and average_lowest.
+
+		WO
+
+What:		/sys/class/hwmon/hwmonX/powerY_accuracy
+Description:
+		Accuracy of the power meter.
+
+		Unit: Percent
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_cap
+Description:
+		If power use rises above this limit, the
+		system should take action to reduce power use.
+		A poll notification is sent to this file if the
+		cap is changed by the hardware.  The `*_cap`
+		files only appear if the cap is known to be
+		enforced by hardware.
+
+		Unit: microWatt
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/powerY_cap_hyst
+Description:
+		Margin of hysteresis built around capping and
+		notification.
+
+		Unit: microWatt
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/powerY_cap_max
+Description:
+		Maximum cap that can be set.
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_cap_min
+Description:
+		Minimum cap that can be set.
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_max
+Description:
+		Maximum power.
+
+		Unit: microWatt
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/powerY_crit
+Description:
+		Critical maximum power.
+
+		If power rises to or above this limit, the
+		system is expected take drastic action to reduce
+		power consumption, such as a system shutdown or
+		a forced powerdown of some devices.
+
+		Unit: microWatt
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/powerY_enable
+Description:
+		Enable or disable the sensors.
+
+		When disabled the sensor read will return
+		-ENODATA.
+
+		- 1: Enable
+		- 0: Disable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/powerY_rated_min
+Description:
+		Minimum rated power.
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_rated_max
+Description:
+		Maximum rated power.
+
+		Unit: microWatt
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/energyY_input
+Description:
+		Cumulative energy use
+
+		Unit: microJoule
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/energyY_enable
+Description:
+		Enable or disable the sensors.
+
+		When disabled the sensor read will return
+		-ENODATA.
+
+		- 1: Enable
+		- 0: Disable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/humidityY_input
+Description:
+		Humidity
+
+		Unit: milli-percent (per cent mille, pcm)
+
+		RO
+
+
+What:		/sys/class/hwmon/hwmonX/humidityY_enable
+Description:
+		Enable or disable the sensors
+
+		When disabled the sensor read will return
+		-ENODATA.
+
+		- 1: Enable
+		- 0: Disable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/humidityY_rated_min
+Description:
+		Minimum rated humidity.
+
+		Unit: milli-percent (per cent mille, pcm)
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/humidityY_rated_max
+Description:
+		Maximum rated humidity.
+
+		Unit: milli-percent (per cent mille, pcm)
+
+		RO
+
+
+What:		/sys/class/hwmon/hwmonX/intrusionY_alarm
+Description:
+		Chassis intrusion detection
+
+		- 0: OK
+		- 1: intrusion detected
+
+		RW
+
+		Contrary to regular alarm flags which clear themselves
+		automatically when read, this one sticks until cleared by
+		the user. This is done by writing 0 to the file. Writing
+		other values is unsupported.
+
+What:		/sys/class/hwmon/hwmonX/intrusionY_beep
+Description:
+		Chassis intrusion beep
+
+		- 0: disable
+		- 1: enable
+
+		RW
diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon/sysfs-interface.rst
index 13c5acb72d63..85652a6aaa3e 100644
--- a/Documentation/hwmon/sysfs-interface.rst
+++ b/Documentation/hwmon/sysfs-interface.rst
@@ -89,6 +89,8 @@ hardware implementation.
 All entries (except name) are optional, and should only be created in a
 given driver if the chip has the feature.
 
+See Documentation/ABI/testing/sysfs-class-hwmon for a complete description
+of the attributes.
 
 *****************
 Global attributes
@@ -96,22 +98,9 @@ Global attributes
 
 `name`
 		The chip name.
-		This should be a short, lowercase string, not containing
-		whitespace, dashes, or the wildcard character '*'.
-		This attribute represents the chip name. It is the only
-		mandatory attribute.
-		I2C devices get this attribute created automatically.
-
-		RO
 
 `update_interval`
 		The interval at which the chip will update readings.
-		Unit: millisecond
-
-		RW
-
-		Some devices have a variable update rate or interval.
-		This attribute can be used to change it to the desired value.
 
 
 ********
@@ -121,148 +110,51 @@ Voltages
 `in[0-*]_min`
 		Voltage min value.
 
-		Unit: millivolt
-
-		RW
-
 `in[0-*]_lcrit`
 		Voltage critical min value.
 
-		Unit: millivolt
-
-		RW
-
-		If voltage drops to or below this limit, the system may
-		take drastic action such as power down or reset. At the very
-		least, it should report a fault.
-
 `in[0-*]_max`
 		Voltage max value.
 
-		Unit: millivolt
-
-		RW
-
 `in[0-*]_crit`
 		Voltage critical max value.
 
-		Unit: millivolt
-
-		RW
-
-		If voltage reaches or exceeds this limit, the system may
-		take drastic action such as power down or reset. At the very
-		least, it should report a fault.
-
 `in[0-*]_input`
 		Voltage input value.
 
-		Unit: millivolt
-
-		RO
-
-		Voltage measured on the chip pin.
-
-		Actual voltage depends on the scaling resistors on the
-		motherboard, as recommended in the chip datasheet.
-
-		This varies by chip and by motherboard.
-		Because of this variation, values are generally NOT scaled
-		by the chip driver, and must be done by the application.
-		However, some drivers (notably lm87 and via686a)
-		do scale, because of internal resistors built into a chip.
-		These drivers will output the actual voltage. Rule of
-		thumb: drivers should report the voltage values at the
-		"pins" of the chip.
-
 `in[0-*]_average`
 		Average voltage
 
-		Unit: millivolt
-
-		RO
-
 `in[0-*]_lowest`
 		Historical minimum voltage
 
-		Unit: millivolt
-
-		RO
-
 `in[0-*]_highest`
 		Historical maximum voltage
 
-		Unit: millivolt
-
-		RO
-
 `in[0-*]_reset_history`
 		Reset inX_lowest and inX_highest
 
-		WO
-
 `in_reset_history`
 		Reset inX_lowest and inX_highest for all sensors
 
-		WO
-
 `in[0-*]_label`
 		Suggested voltage channel label.
 
-		Text string
-
-		Should only be created if the driver has hints about what
-		this voltage channel is being used for, and user-space
-		doesn't. In all other cases, the label is provided by
-		user-space.
-
-		RO
-
 `in[0-*]_enable`
 		Enable or disable the sensors.
 
-		When disabled the sensor read will return -ENODATA.
-
-		- 1: Enable
-		- 0: Disable
-
-		RW
-
 `cpu[0-*]_vid`
 		CPU core reference voltage.
 
-		Unit: millivolt
-
-		RO
-
-		Not always correct.
-
 `vrm`
 		Voltage Regulator Module version number.
 
-		RW (but changing it should no more be necessary)
-
-		Originally the VRM standard version multiplied by 10, but now
-		an arbitrary number, as not all standards have a version
-		number.
-
-		Affects the way the driver calculates the CPU core reference
-		voltage from the vid pins.
-
 `in[0-*]_rated_min`
 		Minimum rated voltage.
 
-		Unit: millivolt
-
-		RO
-
 `in[0-*]_rated_max`
 		Maximum rated voltage.
 
-		Unit: millivolt
-
-		RO
-
 Also see the Alarms section for status flags associated with voltages.
 
 
@@ -273,83 +165,27 @@ Fans
 `fan[1-*]_min`
 		Fan minimum value
 
-		Unit: revolution/min (RPM)
-
-		RW
-
 `fan[1-*]_max`
 		Fan maximum value
 
-		Unit: revolution/min (RPM)
-
-		Only rarely supported by the hardware.
-		RW
-
 `fan[1-*]_input`
 		Fan input value.
 
-		Unit: revolution/min (RPM)
-
-		RO
-
 `fan[1-*]_div`
 		Fan divisor.
 
-		Integer value in powers of two (1, 2, 4, 8, 16, 32, 64, 128).
-
-		RW
-
-		Some chips only support values 1, 2, 4 and 8.
-		Note that this is actually an internal clock divisor, which
-		affects the measurable speed range, not the read value.
-
 `fan[1-*]_pulses`
 		Number of tachometer pulses per fan revolution.
 
-		Integer value, typically between 1 and 4.
-
-		RW
-
-		This value is a characteristic of the fan connected to the
-		device's input, so it has to be set in accordance with the fan
-		model.
-
-		Should only be created if the chip has a register to configure
-		the number of pulses. In the absence of such a register (and
-		thus attribute) the value assumed by all devices is 2 pulses
-		per fan revolution.
-
 `fan[1-*]_target`
 		Desired fan speed
 
-		Unit: revolution/min (RPM)
-
-		RW
-
-		Only makes sense if the chip supports closed-loop fan speed
-		control based on the measured fan speed.
-
 `fan[1-*]_label`
 		Suggested fan channel label.
 
-		Text string
-
-		Should only be created if the driver has hints about what
-		this fan channel is being used for, and user-space doesn't.
-		In all other cases, the label is provided by user-space.
-
-		RO
-
 `fan[1-*]_enable`
 		Enable or disable the sensors.
 
-		When disabled the sensor read will return -ENODATA.
-
-		- 1: Enable
-		- 0: Disable
-
-		RW
-
 Also see the Alarms section for status flags associated with fans.
 
 
@@ -360,63 +196,25 @@ PWM
 `pwm[1-*]`
 		Pulse width modulation fan control.
 
-		Integer value in the range 0 to 255
-
-		RW
-
-		255 is max or 100%.
-
 `pwm[1-*]_enable`
 		Fan speed control method:
 
-		- 0: no fan speed control (i.e. fan at full speed)
-		- 1: manual fan speed control enabled (using `pwm[1-*]`)
-		- 2+: automatic fan speed control enabled
-
-		Check individual chip documentation files for automatic mode
-		details.
-
-		RW
-
 `pwm[1-*]_mode`
-		- 0: DC mode (direct current)
-		- 1: PWM mode (pulse-width modulation)
-
-		RW
+		direct current or pulse-width modulation.
 
 `pwm[1-*]_freq`
 		Base PWM frequency in Hz.
 
-		Only possibly available when pwmN_mode is PWM, but not always
-		present even then.
-
-		RW
-
 `pwm[1-*]_auto_channels_temp`
 		Select which temperature channels affect this PWM output in
 		auto mode.
 
-		Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
-		Which values are possible depend on the chip used.
-
-		RW
-
 `pwm[1-*]_auto_point[1-*]_pwm` / `pwm[1-*]_auto_point[1-*]_temp` / `pwm[1-*]_auto_point[1-*]_temp_hyst`
 		Define the PWM vs temperature curve.
 
-		Number of trip points is chip-dependent. Use this for chips
-		which associate trip points to PWM output channels.
-
-		RW
-
 `temp[1-*]_auto_point[1-*]_pwm` / `temp[1-*]_auto_point[1-*]_temp` / `temp[1-*]_auto_point[1-*]_temp_hyst`
 		Define the PWM vs temperature curve.
 
-		Number of trip points is chip-dependent. Use this for chips
-		which associate trip points to temperature channels.
-
-		RW
-
 There is a third case where trip points are associated to both PWM output
 channels and temperature channels: the PWM values are associated to PWM
 output channels while the temperature values are associated to temperature
@@ -434,182 +232,70 @@ Temperatures
 `temp[1-*]_type`
 		Sensor type selection.
 
-		Integers 1 to 6
-
-		RW
-
-		- 1: CPU embedded diode
-		- 2: 3904 transistor
-		- 3: thermal diode
-		- 4: thermistor
-		- 5: AMD AMDSI
-		- 6: Intel PECI
-
-		Not all types are supported by all chips
-
 `temp[1-*]_max`
 		Temperature max value.
 
-		Unit: millidegree Celsius (or millivolt, see below)
-
-		RW
-
 `temp[1-*]_min`
 		Temperature min value.
 
-		Unit: millidegree Celsius
-
-		RW
-
 `temp[1-*]_max_hyst`
 		Temperature hysteresis value for max limit.
 
-		Unit: millidegree Celsius
-
-		Must be reported as an absolute temperature, NOT a delta
-		from the max value.
-
-		RW
-
 `temp[1-*]_min_hyst`
 		Temperature hysteresis value for min limit.
-		Unit: millidegree Celsius
-
-		Must be reported as an absolute temperature, NOT a delta
-		from the min value.
-
-		RW
 
 `temp[1-*]_input`
-	 Temperature input value.
-
-		Unit: millidegree Celsius
-
-		RO
+		Temperature input value.
 
 `temp[1-*]_crit`
 		Temperature critical max value, typically greater than
 		corresponding temp_max values.
 
-		Unit: millidegree Celsius
-
-		RW
-
 `temp[1-*]_crit_hyst`
 		Temperature hysteresis value for critical limit.
 
-		Unit: millidegree Celsius
-
-		Must be reported as an absolute temperature, NOT a delta
-		from the critical value.
-
-		RW
-
 `temp[1-*]_emergency`
 		Temperature emergency max value, for chips supporting more than
-		two upper temperature limits. Must be equal or greater than
-		corresponding temp_crit values.
-
-		Unit: millidegree Celsius
-
-		RW
+		two upper temperature limits.
 
 `temp[1-*]_emergency_hyst`
 		Temperature hysteresis value for emergency limit.
 
-		Unit: millidegree Celsius
-
-		Must be reported as an absolute temperature, NOT a delta
-		from the emergency value.
-
-		RW
-
 `temp[1-*]_lcrit`
 		Temperature critical min value, typically lower than
 		corresponding temp_min values.
 
-		Unit: millidegree Celsius
-
-		RW
-
 `temp[1-*]_lcrit_hyst`
 		Temperature hysteresis value for critical min limit.
 
-		Unit: millidegree Celsius
-
-		Must be reported as an absolute temperature, NOT a delta
-		from the critical min value.
-
-		RW
-
 `temp[1-*]_offset`
 		Temperature offset which is added to the temperature reading
 		by the chip.
 
-		Unit: millidegree Celsius
-
-		Read/Write value.
-
 `temp[1-*]_label`
 		Suggested temperature channel label.
 
-		Text string
-
-		Should only be created if the driver has hints about what
-		this temperature channel is being used for, and user-space
-		doesn't. In all other cases, the label is provided by
-		user-space.
-
-		RO
-
 `temp[1-*]_lowest`
 		Historical minimum temperature
 
-		Unit: millidegree Celsius
-
-		RO
-
 `temp[1-*]_highest`
 		Historical maximum temperature
 
-		Unit: millidegree Celsius
-
-		RO
-
 `temp[1-*]_reset_history`
 		Reset temp_lowest and temp_highest
 
-		WO
-
 `temp_reset_history`
 		Reset temp_lowest and temp_highest for all sensors
 
-		WO
-
 `temp[1-*]_enable`
 		Enable or disable the sensors.
 
-		When disabled the sensor read will return -ENODATA.
-
-		- 1: Enable
-		- 0: Disable
-
-		RW
-
 `temp[1-*]_rated_min`
 		Minimum rated temperature.
 
-		Unit: millidegree Celsius
-
-		RO
-
 `temp[1-*]_rated_max`
 		Maximum rated temperature.
 
-		Unit: millidegree Celsius
-
-		RO
-
 Some chips measure temperature using external thermistors and an ADC, and
 report the temperature measurement as a voltage. Converting this voltage
 back to a temperature (or the other way around for limits) requires
@@ -627,58 +313,28 @@ Currents
 ********
 
 `curr[1-*]_max`
-		Current max value
-
-		Unit: milliampere
-
-		RW
+		Current max value.
 
 `curr[1-*]_min`
 		Current min value.
 
-		Unit: milliampere
-
-		RW
-
 `curr[1-*]_lcrit`
 		Current critical low value
 
-		Unit: milliampere
-
-		RW
-
 `curr[1-*]_crit`
 		Current critical high value.
 
-		Unit: milliampere
-
-		RW
-
 `curr[1-*]_input`
-		Current input value
-
-		Unit: milliampere
-
-		RO
+		Current input value.
 
 `curr[1-*]_average`
-		Average current use
-
-		Unit: milliampere
-
-		RO
+		Average current use.
 
 `curr[1-*]_lowest`
-		Historical minimum current
-
-		Unit: milliampere
-
-		RO
+		Historical minimum current.
 
 `curr[1-*]_highest`
-		Historical maximum current
-		Unit: milliampere
-		RO
+		Historical maximum current.
 
 `curr[1-*]_reset_history`
 		Reset currX_lowest and currX_highest
@@ -686,34 +342,17 @@ Currents
 		WO
 
 `curr_reset_history`
-		Reset currX_lowest and currX_highest for all sensors
-
-		WO
+		Reset currX_lowest and currX_highest for all sensors.
 
 `curr[1-*]_enable`
 		Enable or disable the sensors.
 
-		When disabled the sensor read will return -ENODATA.
-
-		- 1: Enable
-		- 0: Disable
-
-		RW
-
 `curr[1-*]_rated_min`
 		Minimum rated current.
 
-		Unit: milliampere
-
-		RO
-
 `curr[1-*]_rated_max`
 		Maximum rated current.
 
-		Unit: milliampere
-
-		RO
-
 Also see the Alarms section for status flags associated with currents.
 
 *****
@@ -721,141 +360,62 @@ Power
 *****
 
 `power[1-*]_average`
-				Average power use
-
-				Unit: microWatt
-
-				RO
+		Average power use.
 
 `power[1-*]_average_interval`
-				Power use averaging interval.  A poll
-				notification is sent to this file if the
-				hardware changes the averaging interval.
-
-				Unit: milliseconds
-
-				RW
+		Power use averaging interval.
 
 `power[1-*]_average_interval_max`
-				Maximum power use averaging interval
-
-				Unit: milliseconds
-
-				RO
+		Maximum power use averaging interval.
 
 `power[1-*]_average_interval_min`
-				Minimum power use averaging interval
-
-				Unit: milliseconds
-
-				RO
+		Minimum power use averaging interval.
 
 `power[1-*]_average_highest`
-				Historical average maximum power use
-
-				Unit: microWatt
-
-				RO
+		Historical average maximum power use
 
 `power[1-*]_average_lowest`
-				Historical average minimum power use
-
-				Unit: microWatt
-
-				RO
+		Historical average minimum power use
 
 `power[1-*]_average_max`
-				A poll notification is sent to
-				`power[1-*]_average` when power use
-				rises above this value.
-
-				Unit: microWatt
-
-				RW
+		A poll notification is sent to `power[1-*]_average` when
+		power use rises above this value.
 
 `power[1-*]_average_min`
-				A poll notification is sent to
-				`power[1-*]_average` when power use
-				sinks below this value.
-
-				Unit: microWatt
-
-				RW
+		A poll notification is sent to `power[1-*]_average` when
+		power use sinks below this value.
 
 `power[1-*]_input`
-				Instantaneous power use
-
-				Unit: microWatt
-
-				RO
+		Instantaneous power use.
 
 `power[1-*]_input_highest`
-				Historical maximum power use
-
-				Unit: microWatt
-
-				RO
+		Historical maximum power use
 
 `power[1-*]_input_lowest`
-				Historical minimum power use
-
-				Unit: microWatt
-
-				RO
+		Historical minimum power use.
 
 `power[1-*]_reset_history`
-				Reset input_highest, input_lowest,
-				average_highest and average_lowest.
-
-				WO
+		Reset input_highest, input_lowest, average_highest and
+		average_lowest.
 
 `power[1-*]_accuracy`
-				Accuracy of the power meter.
-
-				Unit: Percent
-
-				RO
+		Accuracy of the power meter.
 
 `power[1-*]_cap`
-				If power use rises above this limit, the
-				system should take action to reduce power use.
-				A poll notification is sent to this file if the
-				cap is changed by the hardware.  The `*_cap`
-				files only appear if the cap is known to be
-				enforced by hardware.
-
-				Unit: microWatt
-
-				RW
+		If power use rises above this limit, the
+		system should take action to reduce power use.
 
 `power[1-*]_cap_hyst`
-				Margin of hysteresis built around capping and
-				notification.
-
-				Unit: microWatt
-
-				RW
+		Margin of hysteresis built around capping and notification.
 
 `power[1-*]_cap_max`
-				Maximum cap that can be set.
-
-				Unit: microWatt
-
-				RO
+		Maximum cap that can be set.
 
 `power[1-*]_cap_min`
-				Minimum cap that can be set.
-
-				Unit: microWatt
-
-				RO
+		Minimum cap that can be set.
 
 `power[1-*]_max`
-				Maximum power.
-
-				Unit: microWatt
-
-				RW
+		Maximum power.
 
 `power[1-*]_crit`
 				Critical maximum power.
@@ -923,37 +483,16 @@ Humidity
 ********
 
 `humidity[1-*]_input`
-				Humidity
-
-				Unit: milli-percent (per cent mille, pcm)
-
-				RO
-
+		Humidity.
 
 `humidity[1-*]_enable`
-				Enable or disable the sensors
-
-				When disabled the sensor read will return
-				-ENODATA.
-
-				- 1: Enable
-				- 0: Disable
-
-				RW
+		Enable or disable the sensors.
 
 `humidity[1-*]_rated_min`
-				Minimum rated humidity.
-
-				Unit: milli-percent (per cent mille, pcm)
-
-				RO
+		Minimum rated humidity.
 
 `humidity[1-*]_rated_max`
-				Maximum rated humidity.
-
-				Unit: milli-percent (per cent mille, pcm)
-
-				RO
+		Maximum rated humidity.
 
 ******
 Alarms
@@ -1004,30 +543,15 @@ supports it. When this boolean has value 1, the measurement for that
 channel should not be trusted.
 
 `fan[1-*]_fault` / `temp[1-*]_fault`
-		Input fault condition
-
-		- 0: no fault occurred
-		- 1: fault condition
-
-		RO
+		Input fault condition.
 
 Some chips also offer the possibility to get beeped when an alarm occurs:
 
 `beep_enable`
-		Master beep enable
-
-		- 0: no beeps
-		- 1: beeps
-
-		RW
+		Master beep enable.
 
 `in[0-*]_beep`, `curr[1-*]_beep`, `fan[1-*]_beep`, `temp[1-*]_beep`,
-		Channel beep
-
-		- 0: disable
-		- 1: enable
-
-		RW
+		Channel beep.
 
 In theory, a chip could provide per-limit beep masking, but no such chip
 was seen so far.
@@ -1039,29 +563,8 @@ for compatibility reasons:
 `alarms`
 		Alarm bitmask.
 
-		RO
-
-		Integer representation of one to four bytes.
-
-		A '1' bit means an alarm.
-
-		Chips should be programmed for 'comparator' mode so that
-		the alarm will 'come back' after you read the register
-		if it is still valid.
-
-		Generally a direct representation of a chip's internal
-		alarm registers; there is no standard for the position
-		of individual bits. For this reason, the use of this
-		interface file for new drivers is discouraged. Use
-		`individual *_alarm` and `*_fault` files instead.
-		Bits are defined in kernel/include/sensors.h.
-
 `beep_mask`
 		Bitmask for beep.
-		Same format as 'alarms' with the same bit locations,
-		use discouraged for the same reason. Use individual
-		`*_beep` files instead.
-		RW
 
 
 *******************
@@ -1069,25 +572,10 @@ Intrusion detection
 *******************
 
 `intrusion[0-*]_alarm`
-		Chassis intrusion detection
-
-		- 0: OK
-		- 1: intrusion detected
-
-		RW
-
-		Contrary to regular alarm flags which clear themselves
-		automatically when read, this one sticks until cleared by
-		the user. This is done by writing 0 to the file. Writing
-		other values is unsupported.
+		Chassis intrusion detection.
 
 `intrusion[0-*]_beep`
-		Chassis intrusion beep
-
-		0: disable
-		1: enable
-
-		RW
+		Chassis intrusion beep.
 
 ****************************
 Average sample configuration
diff --git a/MAINTAINERS b/MAINTAINERS
index 179eadaebe76..e9fd362ef4d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8274,6 +8274,7 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 W:	http://hwmon.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
+F:	Documentation/ABI/testing/sysfs-class-hwmon
 F:	Documentation/devicetree/bindings/hwmon/
 F:	Documentation/hwmon/
 F:	drivers/hwmon/
-- 
2.31.1

