Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83DB32291B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhBWKzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232244AbhBWKyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:54:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E9E964DF5;
        Tue, 23 Feb 2021 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614077634;
        bh=+tBz8oJlO1Afoq1OewvlE2bsdP89xKUuzW7SMxAPGVo=;
        h=Date:From:To:cc:Subject:From;
        b=dyhOTtNSuwq4+dEJ9gl1dbyBprffuBsTeDR9Xw99xxmRlyv6lKGyc7sj0Gdw06qKc
         DJ1MzarQ2KVRAyDd3Rtwd0XQVhDh/dfHXYsk5HGaLhRzUcM4LhpqZIQvaZSqnigoTc
         dbkkwLDqcxPJwCtVsGbFMO5GlASIjF4JxL/Fm6lQSF8EV4clwbLeW7R3Eb+csGnk19
         PFsHnXzF3jade+iUHzSgFmJBXO+e8zOkLCONVy/rMYdkj+PJZjGm5dnfTq3yclT2pV
         ZBjtnOe+8Rtu8GxsOLn1PKeLBFPM9Pa8eFsKgjaZ/wP+0DLXxOL7ExCwjqTRniFyof
         xqJjlFUJ0R/KA==
Date:   Tue, 23 Feb 2021 11:53:51 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 5.12
Message-ID: <nycvar.YFH.7.76.2102231147510.28696@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID susbsytem updates scheduled for 5.12. Highlights:

=====
- support for "Unified Battery" feature on Logitech devices from Filipe 
  Laíns
- power management improvements for intel-ish driver from Zhang Lixu
- support for Goodix devices from Douglas Anderson
- improved handling of generic HID keyboard in order to make it easier for 
  userspace to figure out the details of the device, from Dmitry Torokhov
- Playstation DualSense support from Roderick Colenbrander
- other assorted small fixes and device ID additions.
=====

You are going to get a trivial conflict in arch/arm64/configs/defconfig 
which is documented here:

	https://lore.kernel.org/linux-next/20210119104536.50e08bac@canb.auug.org.au/

Please let me know in case you'd like me to fix it and prepare merged 
branch for you.

Thanks.

----------------------------------------------------------------
Bla¸ Hrastnik (1):
      HID: multitouch: Set to high latency mode on suspend.

Colin Ian King (2):
      HID: lg-g15: make a const array static, makes object smaller
      HID: playstation: fix array size comparison (off-by-one)

Cristian Klein (1):
      HID: uclogic: Improve support for Trust Panora

Dmitry Torokhov (1):
      HID: hid-input: avoid splitting keyboard, system and consumer controls

Douglas Anderson (4):
      HID: i2c-hid: Reorganize so ACPI and OF are separate modules
      arm64: defconfig: Update config names for i2c-hid rejigger
      dt-bindings: input: HID: i2c-hid: Introduce bindings for the Goodix GT7375P
      HID: i2c-hid: Introduce goodix-i2c-hid using i2c-hid core

Elia Devito (1):
      HID: Ignore battery for Elan touchscreen on HP Spectre X360 15-df0xxx

Filipe Laíns (3):
      HID: logitech-hidpp: add support for Unified Battery (1004) feature
      HID: logitech-dj: add support for keyboard events in eQUAD step 4 Gaming
      HID: logitech-dj: add support for the new lightspeed connection iteration

Hans de Goede (2):
      HID: i2c-hid: Add I2C_HID_QUIRK_NO_IRQ_AFTER_RESET for ITE8568 EC on Voyo Winpad A15
      HID: ite: Enable QUIRK_TOUCHPAD_ON_OFF_REPORT on Acer Aspire Switch 10E

Jason Gerecke (1):
      HID: wacom: Ignore attempts to overwrite the touch_max value from HID

Jian-Hong Pan (1):
      HID: chicony: Add Wireless Radio Control feature for Chicony devices

Jiapeng Chong (2):
      HID: wacom: convert sysfs sprintf/snprintf family to sysfs_emit
      HID: displays: convert sysfs sprintf/snprintf family to sysfs_emit

Nicolas Boichat (1):
      HID: google: Get HID report on probe to confirm tablet switch state

Randy Dunlap (11):
      Documentation: HID: hid-alps editing & corrections
      Documentation: HID: amd-sfh-hid editing & corrections
      Documentation: HID: hiddev editing & corrections
      Documentation: HID: intel-ish-hid editing & corrections
      Documentation: HID: hidraw editing & corrections
      Documentation: HID: hid-sensor editing & corrections
      Documentation: HID: hid-transport editing & corrections
      Documentation: HID: uhid editing & corrections
      HID: core: detect and skip invalid inputs to snto32()
      HID: correct kernel-doc notation in <linux/hid*.h>
      HID: correct kernel-doc notation in hid-quirks.c

Roderick Colenbrander (13):
      HID: playstation: initial DualSense USB support.
      HID: playstation: use DualSense MAC address as unique identifier.
      HID: playstation: add DualSense battery support.
      HID: playstation: add DualSense touchpad support.
      HID: playstation: add DualSense accelerometer and gyroscope support.
      HID: playstation: track devices in list.
      HID: playstation: add DualSense Bluetooth support.
      HID: playstation: add DualSense classic rumble support.
      HID: playstation: report DualSense hardware and firmware version.
      HID: playstation: fix unused variable in ps_battery_get_property.
      HID: playstation: add initial DualSense lightbar support.
      HID: playstation: add microphone mute support for DualSense.
      HID: playstation: add DualSense player LED support.

Sanjay Govind (1):
      HID: sony: Add support for tilt on guitar hero guitars

Will McVicker (1):
      HID: make arrays usage and value to be the same

You-Sheng Yang (1):
      HID: intel-ish-hid: ipc: Add Tiger Lake H PCI device ID

Zhang Lixu (2):
      HID: intel-ish-hid: ipc: finish power flow for EHL OOB
      HID: intel-ish-hid: ipc: Address EHL Sx resume issues

 .../devicetree/bindings/input/goodix,gt7375p.yaml  |   65 +
 Documentation/hid/amd-sfh-hid.rst                  |   22 +-
 Documentation/hid/hid-alps.rst                     |    4 +-
 Documentation/hid/hid-sensor.rst                   |   18 +-
 Documentation/hid/hid-transport.rst                |   12 +-
 Documentation/hid/hiddev.rst                       |   10 +-
 Documentation/hid/hidraw.rst                       |    5 +-
 Documentation/hid/intel-ish-hid.rst                |   78 +-
 Documentation/hid/uhid.rst                         |   34 +-
 MAINTAINERS                                        |    6 +
 arch/arm64/configs/defconfig                       |    3 +-
 drivers/hid/Kconfig                                |   19 +
 drivers/hid/Makefile                               |    3 +-
 drivers/hid/hid-chicony.c                          |   55 +
 drivers/hid/hid-core.c                             |    9 +-
 drivers/hid/hid-google-hammer.c                    |   85 +-
 drivers/hid/hid-ids.h                              |   11 +-
 drivers/hid/hid-input.c                            |   12 +
 drivers/hid/hid-ite.c                              |   12 +-
 drivers/hid/hid-lg-g15.c                           |    2 +-
 drivers/hid/hid-logitech-dj.c                      |    8 +-
 drivers/hid/hid-logitech-hidpp.c                   |  246 +++-
 drivers/hid/hid-multitouch.c                       |   10 +
 drivers/hid/hid-playstation.c                      | 1351 ++++++++++++++++++++
 drivers/hid/hid-quirks.c                           |   26 +-
 drivers/hid/hid-roccat-arvo.c                      |    6 +-
 drivers/hid/hid-sony.c                             |   20 +-
 drivers/hid/hid-uclogic-core.c                     |    2 +
 drivers/hid/hid-uclogic-params.c                   |    2 +
 drivers/hid/i2c-hid/Kconfig                        |   47 +-
 drivers/hid/i2c-hid/Makefile                       |    6 +-
 drivers/hid/i2c-hid/i2c-hid-acpi.c                 |  143 +++
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  254 +---
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c            |  116 ++
 drivers/hid/i2c-hid/i2c-hid-of.c                   |  143 +++
 drivers/hid/i2c-hid/i2c-hid.h                      |   22 +
 drivers/hid/intel-ish-hid/ipc/hw-ish.h             |    2 +
 drivers/hid/intel-ish-hid/ipc/ipc.c                |   27 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   55 +-
 drivers/hid/wacom_sys.c                            |    2 +-
 drivers/hid/wacom_wac.c                            |    7 +-
 include/linux/hid-sensor-hub.h                     |    9 +-
 include/linux/hid.h                                |   15 +-
 include/linux/platform_data/i2c-hid.h              |   41 -
 44 files changed, 2606 insertions(+), 419 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
 create mode 100644 drivers/hid/hid-playstation.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-goodix.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of.c
 delete mode 100644 include/linux/platform_data/i2c-hid.h

-- 
Jiri Kosina
SUSE Labs

