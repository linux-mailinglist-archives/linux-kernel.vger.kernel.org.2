Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE173B7DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhF3HYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhF3HX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:23:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B197561CC9;
        Wed, 30 Jun 2021 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625037690;
        bh=FN/meNLvDmOu6pyfurfTWAQRf673LlfAXWSqmwocKnw=;
        h=Date:From:To:cc:Subject:From;
        b=pXtBfVWKz6oWQNQv5un1lO3KPe7+0rMshcDnLiQFqI3oyTm6C4Nb1ZseP+lHII74F
         0QzaqK2CHK2MNmU6lxiySZKJKvhjUtTQM1gSwuLVQcwb+4JWil43Ap8D5jWgvbuusX
         76+b4G64RyWZat6jZMu5TsGlSQwT5b4/VjFl/nTdLC0kfuIC0mjfskI1Z8QRZ93lnv
         Ib+UPKpjFg/A7AwEVZ/w+YqVyH8Q94Q9Oyu3klxSEzk/ao0Oww6R2ke3C9LA6RRSzN
         kOF6qS0QqrUwGM7Nnq5D6TyerrGVHsFkUWwiAuqMPFdCcfz0EAysxV4FJ2AHyg3+Ox
         iHmjDV83YgPog==
Date:   Wed, 30 Jun 2021 09:21:27 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 5.14
Message-ID: <nycvar.YFH.7.76.2106300918230.18969@cbobk.fhfr.pm>
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

to receive HID subsystem changes queued for 5.14 merge window. Highlights:

=====
- patch series that ensures that hid-multitouch driver disables touch 
  and button-press reporting on hid-mt devices during suspend when the 
  device is not configured as a wakeup-source, from Hans de Goede
- support for ISH DMA on Intel EHL platform, from Even Xu
- support for Renoir and Cezanne SoCs, Ambient Light Sensor and Human 
  Presence Detection sensor for amd-sfh driver, from Basavaraj Natikar
- other assorted code cleanups and device-specific fixes/quirks
=====

Thanks.

----------------------------------------------------------------
Ahelenia Ziemiañska (1):
      HID: input: replace outdated HID numbers+comments with macros

Austin Kim (1):
      HID: intel-ish-hid: Fix minor typos in comments

Basavaraj Natikar (4):
      HID: amd_sfh: change in maintainer
      HID: amd_sfh: Extend driver capabilities for multi-generation support
      HID: amd_sfh: Extend ALS support for newer AMD platform
      HID: amd_sfh: Add initial support for HPD sensor

Dmitry Torokhov (1):
      HID: do not use down_interruptible() when unbinding devices

Even Xu (3):
      HID: intel-ish-hid: Set ISH driver depends on x86
      HID: intel-ish-hid: ishtp: Add dma_no_cache_snooping() callback
      HID: intel-ish-hid: ipc: Specify that EHL no cache snooping

Hans de Goede (11):
      HID: logitech-dj/hidpp: Add info/warn/err messages about 27 MHz keyboard encryption
      HID: lg-g15: Remove unused size argument from lg_*_event() functions
      HID: lg-g15: Add a lg_g15_handle_lcd_menu_keys() helper function
      HID: lg-g15: Add a lg_g15_init_input_dev() helper function
      HID: lg-g15: Make the LED-name used by lg_g15_register_led() a parameter
      HID: lg-g15: Add support for the Logitech Z-10 speakers
      HID: lg-g15 + ite: Add MODULE_AUTHOR
      HID: core: Add hid_hw_may_wakeup() function
      HID: usbhid: Implement may_wakeup ll-driver callback
      HID: logitech-dj: Implement may_wakeup ll-driver callback
      HID: multitouch: Disable event reporting on suspend when the device is not a wakeup-source

Hyeonggon Yoo (2):
      HID: usbmouse: Avoid GFP_ATOMIC when GFP_KERNEL is possible
      HID: usbkbd: Avoid GFP_ATOMIC when GFP_KERNEL is possible

Ikjoon Jang (1):
      HID: google: Add of_match table to Whiskers switch device.

Jason Gerecke (1):
      HID: wacom: Correct base usage for capacitive ExpressKey status bits

Lee Jones (11):
      HID: intel-ish-hid: Remove unused variable 'err'
      HID: ishtp-hid-client: Move variable to where it's actually used
      HID: intel-ish-hid: pci-ish: Remove unused variable 'ret'
      HID: intel-ish: Supply some missing param descriptions
      HID: intel-ish: Fix a naming disparity and a formatting error
      HID: intel-ish-hid: Fix a little doc-rot
      HID: intel-ish-hid: Fix potential copy/paste error
      HID: intel-ish-hid: ipc: Correct fw_reset_work_fn() function name in header
      HID: ishtp-hid-client: Fix incorrect function name report_bad_packet()
      HID: intel-ish-hid: ishtp-fw-loader: Fix a bunch of formatting issues
      HID: ishtp-hid-client: Fix 'suggest-attribute=format' compiler warning

Maximilian Luz (1):
      HID: surface-hid: Fix get-report request

Pascal Giard (1):
      HID: sony: fix freeze when inserting ghlive ps3/wii dongles

Thomas Weißschuh (1):
      HID: input: Add support for Programmable Buttons

Uwe Kleine-König (3):
      HID: intel-ish-hid: Drop if block with an always false condition
      HID: intel-ish-hid: Simplify logic in ishtp_cl_device_remove()
      HID: intel-ish-hid: Make remove callback return void

Yang Yingliang (1):
      HID: thrustmaster: Switch to kmemdup() when allocate change_request

Ye Xiang (1):
      HID: intel_ish-hid: HBM: Use connected standby state bit during suspend/resume

Zoltan Tamas Vajda (1):
      HID: hid-input: add Surface Go battery quirk

 MAINTAINERS                                        |   2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           |  43 +++----
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h              |  12 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |  89 ++++++++++++-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h             |  43 +++++++
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  |  48 ++++++-
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  |  11 +-
 .../hid_descriptor/amd_sfh_hid_report_desc.h       | 112 ++++++++++++++++
 drivers/hid/hid-core.c                             |  10 +-
 drivers/hid/hid-debug.c                            |  11 ++
 drivers/hid/hid-google-hammer.c                    |  10 ++
 drivers/hid/hid-ids.h                              |   2 +
 drivers/hid/hid-input.c                            |  30 ++++-
 drivers/hid/hid-ite.c                              |   1 +
 drivers/hid/hid-lg-g15.c                           | 141 ++++++++++++++-------
 drivers/hid/hid-logitech-dj.c                      |  16 +++
 drivers/hid/hid-logitech-hidpp.c                   |  12 ++
 drivers/hid/hid-multitouch.c                       |   3 +-
 drivers/hid/hid-sony.c                             |  98 +++++++-------
 drivers/hid/hid-thrustmaster.c                     |   5 +-
 drivers/hid/intel-ish-hid/Kconfig                  |   1 +
 drivers/hid/intel-ish-hid/ipc/ipc.c                |  28 +++-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   3 +-
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c        |  51 ++++----
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |  15 ++-
 drivers/hid/intel-ish-hid/ishtp-hid.c              |   2 +-
 drivers/hid/intel-ish-hid/ishtp-hid.h              |   9 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c              |  24 ++--
 drivers/hid/intel-ish-hid/ishtp/client.c           |  23 +++-
 drivers/hid/intel-ish-hid/ishtp/hbm.c              |  10 +-
 drivers/hid/intel-ish-hid/ishtp/hbm.h              |   1 +
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |   5 +-
 drivers/hid/surface-hid/surface_hid.c              |   2 +-
 drivers/hid/usbhid/hid-core.c                      |   8 ++
 drivers/hid/usbhid/usbkbd.c                        |   4 +-
 drivers/hid/usbhid/usbmouse.c                      |   2 +-
 drivers/hid/wacom_wac.h                            |   2 +-
 drivers/platform/chrome/cros_ec_ishtp.c            |   4 +-
 include/linux/hid.h                                |  19 +++
 include/linux/intel-ish-client-if.h                |  10 +-
 40 files changed, 703 insertions(+), 219 deletions(-)

-- 
Jiri Kosina
SUSE Labs

