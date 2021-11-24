Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5581845B4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbhKXHNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239430AbhKXHNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:13:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D82960231;
        Wed, 24 Nov 2021 07:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637737811;
        bh=qk2Nmh3d2L0UwyvY0X5KzivmrSFpLOMneAOr9Z7FqoE=;
        h=Date:From:To:cc:Subject:From;
        b=Fcba3ldX1bHitsZljwD4FhV445soUNyyTvCmxLIumct76eiFBD2zNGAxZjkQJE7mK
         9SNCmJ5bcllTZWKA1wiakZj/a71sZTATxtfu7eIf72NaBvE52oPfjVH8a1bOSfGcsP
         cx8PUVilYXO7Ja/Vof6lhuUskrhTCl+5oSDa3yxUaELFiBgtco2f2NheV8LgxYXnb8
         CHDSNs3LlvvEhhxH/E+OF52az4gm7bEnea5SYCvwK1mqDB5SnEm9XN4vD7NJa+AQ3Q
         VTVoDzpNLPeVZCHU7V422+175h9zetgaB5tclLTMgjhPPNH3YEfUbkhR0UHpEB9JHM
         ZH+7jRMBMNA8Q==
Date:   Wed, 24 Nov 2021 08:10:08 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2111240804370.16505@cbobk.fhfr.pm>
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

to receive 5.16-rc fixes for HID subsystem.

=====
- fix for Intel-ISH driver to make sure it gets aoutoloaded only on 
  matching devices and not universally (Thomas Weiﬂschuh)
- fix for Wacom driver reporting invalid contact under certain 
  circumstances (Jason Gerecke)
- probing fix for ft260 dirver (Michael Zaidman)
- fix for generic keycode remapping (Thomas Weiﬂschuh)
- fix for division by zero in hid-magicmouse (Claudia Pellegrino)
- other tiny assorted fixes and new device IDs
=====

Thanks.

----------------------------------------------------------------
Arnd Bergmann (1):
      HID: intel-ish-hid: fix module device-id handling

Claudia Pellegrino (1):
      HID: magicmouse: prevent division by 0 on scroll

Dan Carpenter (1):
      HID: nintendo: unlock on error in joycon_leds_create()

Hans de Goede (1):
      HID: input: Fix parsing of HID_CP_CONSUMER_CONTROL fields

Jason Gerecke (1):
      HID: wacom: Use "Confidence" flag to prevent reporting invalid contacts

Jiri Kosina (1):
      HID: nintendo: eliminate dead datastructures in !CONFIG_NINTENDO_FF case

Michael Zaidman (1):
      HID: ft260: fix i2c probing for hwmon devices

Ondrej Zary (1):
      HID: multitouch: Fix Iiyama ProLite T1931SAW (0eef:0001 again!)

Thomas Weiﬂschuh (8):
      HID: intel-ish-hid: add support for MODULE_DEVICE_TABLE()
      HID: intel-ish-hid: use constants for modaliases
      HID: intel-ish-hid: fw-loader: only load for matching devices
      HID: intel-ish-hid: hid-client: only load for matching devices
      platform/chrome: chros_ec_ishtp: only load for matching devices
      platform/x86: isthp_eclite: only load for matching devices
      mod_devicetable: fix kdocs for ishtp_device_id
      HID: input: set usage type to key on keycode remap

Trevor Davenport (1):
      HID: Ignore battery for Elan touchscreen on HP Envy X360 15-eu0xxx

Vihas Mak (1):
      HID: thrustmaster: fix sparse warnings

VinÌcius Angiolucci Reis (1):
      Revert "HID: hid-asus.c: Maps key 0x35 (display off) to KEY_SCREENLOCK"

 drivers/hid/hid-asus.c                       |  2 +-
 drivers/hid/hid-ft260.c                      | 11 +++++------
 drivers/hid/hid-ids.h                        |  1 +
 drivers/hid/hid-input.c                      |  8 +++++---
 drivers/hid/hid-magicmouse.c                 |  7 +++++--
 drivers/hid/hid-multitouch.c                 |  5 +++++
 drivers/hid/hid-nintendo.c                   | 13 +++++++++----
 drivers/hid/hid-thrustmaster.c               |  6 +++---
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c  | 14 ++++++++------
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 14 ++++++++------
 drivers/hid/intel-ish-hid/ishtp/bus.c        |  6 +++---
 drivers/hid/wacom_wac.c                      |  8 +++++++-
 drivers/hid/wacom_wac.h                      |  1 +
 drivers/platform/chrome/cros_ec_ishtp.c      | 14 ++++++++------
 drivers/platform/x86/intel/ishtp_eclite.c    | 14 ++++++++------
 include/linux/intel-ish-client-if.h          |  4 ++--
 include/linux/mod_devicetable.h              | 14 ++++++++++++++
 scripts/mod/devicetable-offsets.c            |  3 +++
 scripts/mod/file2alias.c                     | 24 ++++++++++++++++++++++++
 19 files changed, 120 insertions(+), 49 deletions(-)

-- 
Jiri Kosina
SUSE Labs

