Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34743FE394
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbhIAURa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhIAUR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:17:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C08C60231;
        Wed,  1 Sep 2021 20:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630527391;
        bh=2SbKyxkBrfrXrLn+MbuR9308vA1cxEVrgEwOtCfbz5M=;
        h=Date:From:To:cc:Subject:From;
        b=ifi5fW8uV2dq4EWdfWIPBK7sivJ8Vc2Cj/RdilMDQt9WhvDlc90biYmDNUJD2C5jf
         OJ/2GnSWZfyfQrpD2KvPLHhMAfC7+mCun0EwJSd9o4gFKZ69z7NV5YnLf2MgD9EUI9
         oSCBuYUOzd6Wq6r/oEPpPzqbiTfVFYIEvjKMH33DTtQPm8OI0OQeqStfYqaySN5jPD
         +75G/8WNlxJN41dC8F0lJjxu7ZXjEmpCs06emMwD4UJUgF2FhyKX8cFwu8Ohk2soaB
         kCGPgmAkgQNDOdLsJZUOPPf4+k5wOq6LrRMWqiWwRRr1UBE+dtEnhCx7xlLDguzgb7
         7WNyff/SEVMfQ==
Date:   Wed, 1 Sep 2021 22:16:29 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.15
Message-ID: <nycvar.YFH.7.76.2109012214370.15944@cbobk.fhfr.pm>
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

to receive HID subsystem patches queued for 5.15. Highlights:

=====
- Fix in i2c-hid driver for Elan touchpad quirk regression (Jim Broadus)
- Quirk preventing ASUS Claymore from accidentally suspending whole system 
  (Luke D. Jones)
- Updates to the existing FW reporting mechanism, MP2 FW
  status checks, adding proper power management support for amd-sfh 
  (Basavaraj Natikar)
- Regression fix for an issue in HID core that got uncovered by recent USB 
  core cleanup leading to issues when transfer_buffer_length is not in 
  line with wLength (Alan Stern)
- Memory leak fix in USB HID core (Anirudh Rayabharam)
- Improvement of stylus battery reporting (Dmitry Torokhov)
- Power management improvement for Goodix driver (Douglas Anderson)
- High-resolution scroll support for Magicmouse devices (José Expósito)
- Support for GHLive PS4 dongles (Daniel Nguyen)
- Support proper EV_MSC emissions to hid-apple (Vincent Lefevre)
=====

----------------------------------------------------------------
Alan Stern (2):
      HID: usbhid: Fix warning caused by 0-length input reports
      HID: usbhid: Simplify code in hid_submit_ctrl()

Anirudh Rayabharam (1):
      HID: usbhid: free raw_report buffers in usbhid_stop

Basavaraj Natikar (5):
      HID: amd_sfh: Fix period data field to enable sensor
      HID: amd_sfh: Add command response to check command status
      HID: amd_sfh: Move hid probe after sensor is enabled
      HID: amd_sfh: Add support for PM suspend and resume
      HID: amd_sfh: Add dyndbg prints for debugging

Christophe JAILLET (1):
      HID: logitech-hidpp: Use 'atomic_inc_return' instead of hand-writing it

Daniel Nguyen (1):
      HID: sony: support for the ghlive ps4 dongles

Dmitry Torokhov (1):
      HID: input: do not report stylus battery state as "full"

Douglas Anderson (2):
      HID: i2c-hid: goodix: Tie the reset line to true state of the regulator
      HID: i2c-hid: goodix: Use the devm variant of regulator_register_notifier()

Evgeny Novikov (3):
      HID: thrustmaster: Fix memory leaks in probe
      HID: thrustmaster: Fix memory leak in remove
      HID: thrustmaster: Fix memory leak in thrustmaster_interrupts()

Hamza Mahfooz (1):
      HID: logitech-hidpp: battery: provide CAPACITY property for newer devices

Jason Gerecke (3):
      HID: wacom: Short-circuit processing of touch when it is disabled
      HID: wacom: Avoid sending empty sync events
      HID: wacom: Refactor touch input mute checks into a common function

Jim Broadus (1):
      HID: i2c-hid: Fix Elan touchpad regression

José Expósito (2):
      HID: magicmouse: enable high-resolution scroll
      HID: magicmouse: high-resolution scroll threshold

Lukas Bulwahn (1):
      HID: thrustmaster: clean up Makefile and adapt quirks

Luke D. Jones (1):
      HID: asus: Prevent Claymore sending suspend event

Michal Kubecek (1):
      HID: usbhid: Fix flood of "control queue full" messages

Ping Cheng (1):
      HID: wacom: set initial hardware touch switch state to 'off'

Salah Triki (1):
      HID: elo: update the reference count of the usb device structure

Thomas Weißschuh (1):
      HID: cmedia: add support for HS-100B mute button

Ulrich Spörlein (1):
      HID: sony: Fix more ShanWan clone gamepads to not rumble when plugged in.

Vincent Lefevre (1):
      HID: apple: Add missing scan code event for keys handled by hid-apple

 drivers/hid/Kconfig                      |  7 +--
 drivers/hid/Makefile                     |  1 -
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 62 +++++++++++++++------
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 69 ++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h   | 23 ++++++++
 drivers/hid/hid-apple.c                  | 32 +++++++----
 drivers/hid/hid-asus.c                   | 15 ++++++
 drivers/hid/hid-cmedia.c                 | 90 ++++++++++++++++++++++++++++++-
 drivers/hid/hid-elo.c                    |  6 ++-
 drivers/hid/hid-ids.h                    |  9 ++--
 drivers/hid/hid-input.c                  |  2 -
 drivers/hid/hid-logitech-hidpp.c         | 47 ++++++++++++++--
 drivers/hid/hid-magicmouse.c             | 52 ++++++++++++++++++
 drivers/hid/hid-quirks.c                 |  2 -
 drivers/hid/hid-sony.c                   | 49 ++++++++++++-----
 drivers/hid/hid-thrustmaster.c           |  7 ++-
 drivers/hid/i2c-hid/i2c-hid-core.c       |  5 +-
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c  | 92 +++++++++++++++++++++++++++-----
 drivers/hid/usbhid/hid-core.c            | 29 ++++++----
 drivers/hid/wacom_sys.c                  |  9 +++-
 drivers/hid/wacom_wac.c                  | 50 ++++++++++++-----
 drivers/hid/wacom_wac.h                  |  2 +
 22 files changed, 564 insertions(+), 96 deletions(-)

-- 
Jiri Kosina
SUSE Labs

