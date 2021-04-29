Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C890B36F0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhD2T4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235681AbhD2T4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:56:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DCF6613DA;
        Thu, 29 Apr 2021 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619726125;
        bh=nVfOsVBJi1e1cG+InxDTXefitDRQvJrcHelurcvqkMU=;
        h=Date:From:To:cc:Subject:From;
        b=ZmvDW6/R2opv6haf/h3J/3VtzXXniDw7qZ1bxcsbX7eqDQel9dCG2vQIFMOWpN7gS
         MB3rVaoHF3GXmhxqCZHDxu8ajSmN+0I+cxT7M5TB7N40C9hQmA4Jv4YBSByP/gGwir
         340Fbca0iroatEFYj1jcVidelzEXvjTl6SPx3mv5hWYVGRFE1cSz0V/opzHnf+PWRY
         bf4kXs10IfCxpG6PeE9FKJDQj8idfl5yQghs4wm4pDM1zwKKd7dxeNdMprx+4O3Fwt
         SSO34gUBwyr1xjRqbMnO0N9pvbZNbIjai8Pj8ckw/F1+5PHR1Kxo6nraIrCVtISPaH
         eRh8FZxJJH4mg==
Date:   Thu, 29 Apr 2021 21:55:21 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.13
Message-ID: <nycvar.YFH.7.76.2104292151220.18270@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem updates for 5.13. Highlights:

=====
- Surface Aggregator Module support from Maximilian Luz
- Apple Magic Mouse 2 support from John Chen
- Support for newer Quad/BT 2.0 Logitech receivers in HID proxy mode from 
  Hans de Goede
- Thinkpad X1 Tablet keyboard support from Hans de Goede
- Support for FTDI FT260 I2C host adapter from Michael Zaidman
- other various small device-specific quirks, fixes and cleanups
=====

Thanks.

----------------------------------------------------------------
Andy Shevchenko (4):
      HID: i2c-hid: acpi: Get ACPI companion only once and reuse it
      HID: i2c-hid: acpi: Switch to new style i2c-driver probe function
      HID: i2c-hid: acpi: Move GUID out of function and described it
      HID: i2c-hid: acpi: Drop redundant ACPI_PTR()

Dan Carpenter (1):
      HID: ft260: fix an error message in ft260_i2c_write_read()

Dario Pagani (1):
      HID: support for initialization of some Thrustmaster wheels

Hans de Goede (14):
      HID: logitech-dj: Use hid-ids.h defines for USB device-ids for all supported devices
      HID: logitech-dj: Handle newer quad/bt2.0 receivers in HID proxy mode
      HID: elan: Silence mute LED errors being logged when the device is unplugged
      HID: elan: Set default_trigger for the mute LED
      HID: elan: Remove elan_mute_led_get_brigtness()
      HID: lenovo: Use brightness_set_blocking callback for setting LEDs brightness
      HID: lenovo: Fix lenovo_led_set_tp10ubkbd() error handling
      HID: lenovo: Check hid_get_drvdata() returns non NULL in lenovo_event()
      HID: lenovo: Remove lenovo_led_brightness_get()
      HID: lenovo: Set LEDs max_brightness value
      HID: lenovo: Map mic-mute button to KEY_F20 instead of KEY_MICMUTE
      HID: lenovo: Set default_triggers for the mute and micmute LEDs
      HID: lenovo: Rework how the tp10ubkbd code decides which USB interface to use
      HID: lenovo: Add support for Thinkpad X1 Tablet Thin keyboard

Jason Gerecke (1):
      HID: hiddev: Return specific error codes on connect failure

Jiri Kosina (1):
      HID: thrustmaster: introduce proper USB dependency

John Chen (4):
      HID: magicmouse: add Apple Magic Mouse 2 support
      HID: magicmouse: fix 3 button emulation of Mouse 2
      HID: magicmouse: fix reconnection of Magic Mouse 2
      HID: input: map battery capacity (00850065)

Lee Jones (14):
      HID: hid-thrustmaster: Demote a bunch of kernel-doc abuses
      HID: usbhid: Repair a formatting issue in a struct description
      HID: usbhid: hid-pidff: Demote a couple kernel-doc abuses
      HID: hid-alps: Correct struct misnaming
      HID: hid-core: Fix incorrect function name in header
      HID: hid-kye: Fix incorrect function name for kye_tablet_enable()
      HID: hid-picolcd_core: Remove unused variable 'ret'
      HID: hid-logitech-hidpp: Fix conformant kernel-doc header and demote abuses
      HID: hid-uclogic-rdesc: Kernel-doc is for functions and structs
      HID: hid-uclogic-params: Ensure function names are present and correct in kernel-doc headers
      HID: hid-sensor-custom: Remove unused variable 'ret'
      HID: wacom_sys: Demote kernel-doc abuse
      HID: hid-sensor-hub: Remove unused struct member 'quirks'
      HID: hid-sensor-hub: Move 'hsdev' description to correct struct definition

Maxim Mikityanskiy (1):
      HID: plantronics: Workaround for double volume key presses

Maximilian Luz (2):
      HID: Add support for Surface Aggregator Module HID transport
      HID: surface-hid: Add support for legacy keyboard interface

Michael Zaidman (1):
      HID: ft260: add usb hid to i2c host bridge driver

Ping Cheng (1):
      HID: wacom: Setup pen input capabilities to the targeted tools

kernel test robot (1):
      HID: fix memdup.cocci warnings

 MAINTAINERS                                |   14 +
 drivers/hid/Kconfig                        |   20 +-
 drivers/hid/Makefile                       |    6 +-
 drivers/hid/hid-alps.c                     |    2 +-
 drivers/hid/hid-core.c                     |    2 +-
 drivers/hid/hid-debug.c                    |    1 +
 drivers/hid/hid-elan.c                     |   17 +-
 drivers/hid/hid-ft260.c                    | 1054 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h                      |   14 +-
 drivers/hid/hid-input.c                    |   22 +-
 drivers/hid/hid-kye.c                      |    2 +-
 drivers/hid/hid-lenovo.c                   |  147 +++++++---
 drivers/hid/hid-lg.c                       |   24 --
 drivers/hid/hid-logitech-dj.c              |  131 +++++++--
 drivers/hid/hid-logitech-hidpp.c           |    7 +-
 drivers/hid/hid-magicmouse.c               |  158 +++++++---
 drivers/hid/hid-picolcd_core.c             |    5 +-
 drivers/hid/hid-plantronics.c              |   60 +++-
 drivers/hid/hid-quirks.c                   |    5 +-
 drivers/hid/hid-sensor-custom.c            |    5 +-
 drivers/hid/hid-sensor-hub.c               |    4 +-
 drivers/hid/hid-thrustmaster.c             |  371 ++++++++++++++++++++++++
 drivers/hid/hid-uclogic-params.c           |    8 +-
 drivers/hid/hid-uclogic-rdesc.c            |    2 +-
 drivers/hid/i2c-hid/i2c-hid-acpi.c         |   52 ++--
 drivers/hid/surface-hid/Kconfig            |   42 +++
 drivers/hid/surface-hid/Makefile           |    7 +
 drivers/hid/surface-hid/surface_hid.c      |  253 ++++++++++++++++
 drivers/hid/surface-hid/surface_hid_core.c |  272 ++++++++++++++++++
 drivers/hid/surface-hid/surface_hid_core.h |   77 +++++
 drivers/hid/surface-hid/surface_kbd.c      |  300 +++++++++++++++++++
 drivers/hid/usbhid/hid-pidff.c             |    4 +-
 drivers/hid/usbhid/hiddev.c                |    6 +-
 drivers/hid/usbhid/usbkbd.c                |   18 +-
 drivers/hid/wacom_sys.c                    |    2 +-
 drivers/hid/wacom_wac.c                    |   50 ++--
 drivers/hid/wacom_wac.h                    |    1 +
 include/linux/hid.h                        |    5 +
 38 files changed, 2948 insertions(+), 222 deletions(-)
 create mode 100644 drivers/hid/hid-ft260.c
 create mode 100644 drivers/hid/hid-thrustmaster.c
 create mode 100644 drivers/hid/surface-hid/Kconfig
 create mode 100644 drivers/hid/surface-hid/Makefile
 create mode 100644 drivers/hid/surface-hid/surface_hid.c
 create mode 100644 drivers/hid/surface-hid/surface_hid_core.c
 create mode 100644 drivers/hid/surface-hid/surface_hid_core.h
 create mode 100644 drivers/hid/surface-hid/surface_kbd.c

-- 
Jiri Kosina
SUSE Labs

