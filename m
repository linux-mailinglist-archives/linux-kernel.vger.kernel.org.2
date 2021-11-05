Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ABD44629A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhKELZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232115AbhKELZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:25:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62AB96124F;
        Fri,  5 Nov 2021 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636111391;
        bh=2iXLKsU1kgBMiFQPc8UDVzfzjXZkOHioGnb4880emKw=;
        h=Date:From:To:cc:Subject:From;
        b=cYU+1Mnz9XeamLyv95ZBD8ImQTbvYdw4vfgaCwLhnXRslHc+x6k3p3lLh17/B41yb
         sF0LzgcOtjGv8R/XbvOb001lXVuijfja3xy5tlkJGc8zF/OkvnlxMjnLYyHx4W2DV3
         mMi+nMFAIUfV4B5mwmElUnEqBGum7A0gjaXvmKzl8uNkLanY0p8slrFX88qmvHKzrG
         0QaakCwYN/WAwSUSg+MZp0H4khj8vUUu/spJWnZCZgzBPuI8qTXNxip4YQ37hLL/cv
         bNDauOCHLebD8hYSoI6kg5tnLLgnOsRKns9pwKqvcL/lHn5KpFb4K1HATTqAo5vDpw
         1yIl9LraYrrqA==
Date:   Fri, 5 Nov 2021 12:23:08 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.16
Message-ID: <nycvar.YFH.7.76.2111051220020.12554@cbobk.fhfr.pm>
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

to receive HID subsystem updates for 5.16 merge window.

=====
- support for Nintendo Switch Pro Controllers and Joy-Cons (Daniel J. 
  Ogorchock)
- support for new revision of the NitroKey U2F device firmware (Andrej 
  Shadura)
- LED handling improvements for Sony Playstation5 controllers (Roderick 
  Colenbrander)
- support for Apple 2021 Magic Keyboard (Alex Henrie)
- other assorted code cleanups and new device ID additions
=====

Thanks.

----------------------------------------------------------------
Alex Henrie (3):
      HID: apple: Rename MAGIC_KEYBOARD_ANSI to MAGIC_KEYBOARD_2015
      HID: apple: Add support for the 2021 Magic Keyboard
      HID: apple: Bring back flag for Apple tilde key quirk

Alexander F. Lent (1):
      HID: apple: Eliminate obsolete IR receiver quirks

Andrej Shadura (3):
      HID: u2fzero: Support NitroKey U2F revision of the device
      HID: u2fzero: clarify error check and length calculations
      HID: u2fzero: properly handle timeouts in usb_submit_urb

Basavaraj Natikar (3):
      HID: amd_sfh: Use dma_set_mask_and_coherent()
      HID: amd_sfh: switch from 'pci_' to 'dev_' API
      HID: amd_sfh: Update Copyright details

Cai Huoqing (2):
      HID: cougar: Make use of the helper function devm_add_action_or_reset()
      HID: wacom: Make use of the helper function devm_add_action_or_reset()

Christophe JAILLET (1):
      HID: amd_sfh: switch from 'pci_' to 'dma_' API

Dan Carpenter (1):
      HID: hid-debug: clean up snprintf() checks in hid_resolv_usage()

Daniel J. Ogorchock (16):
      HID: nintendo: add nintendo switch controller driver
      HID: nintendo: add player led support
      HID: nintendo: add power supply support
      HID: nintendo: add home led support
      HID: nintendo: add rumble support
      HID: nintendo: improve subcommand reliability
      HID: nintendo: send subcommands after receiving input report
      HID: nintendo: patch hw version for userspace HID mappings
      HID: nintendo: reduce device removal subcommand errors
      HID: nintendo: set controller uniq to MAC
      HID: nintendo: add support for charging grip
      HID: nintendo: add support for reading user calibration
      HID: nintendo: add IMU support
      HID: nintendo: improve rumble performance and stability
      HID: nintendo: ratelimit subcommands and rumble
      HID: nintendo: prevent needless queueing of the rumble worker

Felipe Balbi (1):
      HID: core: add TransducerSerialNumber2

Ilya Skriblovsky (1):
      HID: Add support for side buttons of Xiaomi Mi Dual Mode Wireless Mouse Silent

Jason Gerecke (1):
      HID: wacom: Shrink critical section in `wacom_add_shared_data`

Jiri Kosina (3):
      HID: playstation: fix return from dualsense_player_led_set_brightness()
      HID: playstation: require multicolor LED functionality
      HID: nintendo: fix -Werror build

José Expósito (1):
      HID: multitouch: disable sticky fingers for UPERFECT Y

Roderick Colenbrander (3):
      HID: playstation: expose DualSense lightbar through a multi-color LED.
      leds: add new LED_FUNCTION_PLAYER for player LEDs for game controllers.
      HID: playstation: expose DualSense player LEDs through LED class.

Vinícius Angiolucci Reis (1):
      HID: hid-asus.c: Maps key 0x35 (display off) to KEY_SCREENLOCK

 Documentation/leds/well-known-leds.txt             |   14 +
 MAINTAINERS                                        |    6 +
 drivers/hid/Kconfig                                |   32 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           |    3 +-
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c              |    2 +
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h              |    2 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |   21 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h             |    3 +-
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  |    3 +-
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  |    3 +-
 .../hid_descriptor/amd_sfh_hid_report_desc.h       |    3 +-
 drivers/hid/hid-apple.c                            |   66 +-
 drivers/hid/hid-asus.c                             |    2 +-
 drivers/hid/hid-cougar.c                           |    3 +-
 drivers/hid/hid-debug.c                            |   10 +-
 drivers/hid/hid-ids.h                              |   18 +-
 drivers/hid/hid-input.c                            |    1 +
 drivers/hid/hid-multitouch.c                       |   13 +
 drivers/hid/hid-nintendo.c                         | 2319 ++++++++++++++++++++
 drivers/hid/hid-playstation.c                      |  159 +-
 drivers/hid/hid-quirks.c                           |    3 +-
 drivers/hid/hid-u2fzero.c                          |   55 +-
 drivers/hid/hid-xiaomi.c                           |   94 +
 drivers/hid/wacom_sys.c                            |   15 +-
 drivers/input/joydev.c                             |   10 +
 include/dt-bindings/leds/common.h                  |    7 +
 27 files changed, 2788 insertions(+), 81 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.c
 create mode 100644 drivers/hid/hid-xiaomi.c

-- 
Jiri Kosina
SUSE Labs

