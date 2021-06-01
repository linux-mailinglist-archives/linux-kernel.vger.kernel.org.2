Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29592397BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhFAWAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234891AbhFAWAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:00:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57D866139A;
        Tue,  1 Jun 2021 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622584739;
        bh=1ipmnfdO6Hi7qxTsCbmvEtxhv4XzJUpASTDnvhYn4wQ=;
        h=Date:From:To:cc:Subject:From;
        b=Ri6MeA4bB64AZRkRXRKAFuZRjEMw0I1di8znG6gKdBkGVjDhYGJwfTc0lB4gpn+ua
         soYIFovH9y4L7S6HGhX2MKSkUcN0v0RpHgf8/wKnRQNOanXbw1BG8QRFjafbQcVBML
         4EuUAm/uM9xx3bWwh1DDKE45tdcukR4jh8dOWMfnEolGOWEl6cFdVpUcKu4i9TvgET
         10vNmyepAoJEvjpqSwZW0oBCDypN4u1ZQpDVNaCNFz4oMugM+flJCi/sxNgY0phLk/
         h7iL9j7AhvmYs01Th1D833DK4NXn/tr8aezWCONRcvnr2N99gHOF2LFSsNcj1hhO+m
         z617bdIhWo4SA==
Date:   Tue, 1 Jun 2021 23:58:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2106012353210.28378@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive fixes for HID subsystem.

=====
- memory leak fix in usbhid from Anirudh Rayabharam
- additions for a few new recognized generic key IDs from Dmitry Torokhov
- Asus T101HA and Dell K15A quirks from Hans de Goede
- memory leak fix in amd_sfh from Basavaraj Natikar
- Win8 compatibility and Stylus fixes in multitouch driver from Ahelenia 
  Ziemiañska
- NULL pointer dereference fix in hid-magicmouse from Johan Hovold
- assorted other small fixes and device ID additions
=====

Thanks.

----------------------------------------------------------------
Ahelenia Ziemiañska (2):
      HID: multitouch: require Finger field to mark Win8 reports as MT
      HID: multitouch: set Stylus suffix for Stylus-application devices, too

Anirudh Rayabharam (1):
      HID: usbhid: fix info leak in hid_submit_ctrl

Arnd Bergmann (1):
      HID: i2c-hid: fix format string mismatch

Basavaraj Natikar (2):
      HID: amd_sfh: Use devm_kzalloc() instead of kzalloc()
      HID: amd_sfh: Fix memory leak in amd_sfh_work

Benjamin Moody (1):
      HID: semitek: new driver for GK6X series keyboards

Bixuan Cui (1):
      HID: gt683r: add missing MODULE_DEVICE_TABLE

Dmitry Torokhov (2):
      HID: hid-input: add mapping for emoji picker key
      HID: hid-debug: recognize KEY_ASSISTANT and KEY_KBD_LAYOUT_NEXT

Hamza Mahfooz (1):
      HID: remove the unnecessary redefinition of a macro

Hans de Goede (4):
      HID: quirks: Add HID_QUIRK_NO_INIT_REPORTS quirk for Dell K15A keyboard-dock
      HID: core: Remove extraneous empty line before EXPORT_SYMBOL_GPL(hid_check_keys_pressed)
      HID: multitouch: Disable event reporting on suspend on the Asus T101HA touchpad
      HID: asus: Cleanup Asus T101HA keyboard-dock handling

Johan Hovold (1):
      HID: magicmouse: fix NULL-deref on disconnect

Johnny Chuang (1):
      HID: i2c-hid: Skip ELAN power-on command after reset

José Expósito (1):
      HID: magicmouse: fix crash when disconnecting Magic Trackpad 2

Luke D Jones (2):
      HID: asus: Filter keyboard EC for old ROG keyboard
      HID: asus: filter G713/G733 key event to prevent shutdown

Mark Bolhuis (1):
      HID: Add BUS_VIRTUAL to hid_connect logging

Mateusz Joñczyk (1):
      HID: a4tech: use A4_2WHEEL_MOUSE_HACK_B8 for A4TECH NB-95

Maximilian Luz (1):
      HID: surface-hid: Fix integer endian conversion

Michael Zaidman (2):
      HID: ft260: check data size in ft260_smbus_write()
      HID: ft260: improve error handling of ft260_hid_feature_report_get()

Nirenjan Krishnan (1):
      HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for Saitek X65

Saeed Mirzamohammadi (1):
      HID: quirks: Add quirk for Lenovo optical mouse

Srinivas Pandruvada (2):
      HID: hid-sensor-hub: Return error for hid_set_field() failure
      HID: hid-sensor-custom: Process failure of sensor_hub_set_feature()

Tom Rix (1):
      HID: logitech-hidpp: initialize level variable

Wei Yongjun (1):
      HID: thrustmaster: fix return value check in thrustmaster_probe()

Ye Xiang (1):
      HID: intel-ish-hid: ipc: Add Alder Lake device IDs

Zhen Lei (1):
      HID: pidff: fix error return code in hid_pidff_init()

 drivers/hid/Kconfig                        | 19 ++++++++++--
 drivers/hid/Makefile                       |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c   | 19 ++++++------
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c      |  3 --
 drivers/hid/hid-a4tech.c                   |  2 ++
 drivers/hid/hid-asus.c                     | 32 +++++++++++++--------
 drivers/hid/hid-core.c                     |  4 ++-
 drivers/hid/hid-debug.c                    |  3 ++
 drivers/hid/hid-ft260.c                    | 29 ++++++++++---------
 drivers/hid/hid-gt683r.c                   |  1 +
 drivers/hid/hid-ids.h                      |  9 ++++--
 drivers/hid/hid-input.c                    |  3 ++
 drivers/hid/hid-logitech-hidpp.c           |  1 +
 drivers/hid/hid-magicmouse.c               |  7 +++--
 drivers/hid/hid-multitouch.c               | 46 ++++++++++++++++++++++++------
 drivers/hid/hid-quirks.c                   |  4 +++
 drivers/hid/hid-semitek.c                  | 40 ++++++++++++++++++++++++++
 drivers/hid/hid-sensor-custom.c            |  8 ++++--
 drivers/hid/hid-sensor-hub.c               | 13 ++++++---
 drivers/hid/hid-thrustmaster.c             |  2 +-
 drivers/hid/i2c-hid/i2c-hid-core.c         | 13 +++++++--
 drivers/hid/intel-ish-hid/ipc/hw-ish.h     |  2 ++
 drivers/hid/intel-ish-hid/ipc/pci-ish.c    |  2 ++
 drivers/hid/surface-hid/surface_hid_core.c |  6 ++--
 drivers/hid/usbhid/hid-core.c              |  2 +-
 drivers/hid/usbhid/hid-pidff.c             |  1 +
 include/linux/hid.h                        |  3 +-
 include/uapi/linux/input-event-codes.h     |  1 +
 28 files changed, 206 insertions(+), 70 deletions(-)
 create mode 100644 drivers/hid/hid-semitek.c

-- 
Jiri Kosina
SUSE Labs

