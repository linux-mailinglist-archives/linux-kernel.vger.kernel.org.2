Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17231BAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBOODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:03:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229908AbhBOODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613397737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bdy4Ck9HumbCnFCknmPZKyEjiJQSsH7EMh++y94G+CQ=;
        b=BlhT4HBxvJJZ444nxJvWqd0J+tL6j/U8V1vp9LaA3se8Ds0LhRry3m59t/cMgPRycS/ZHP
        QseuvyM+856/JTZZrxwNtMKV0+PGY/YHMmpA7k3arcFLLIGeC88yIxWyASFaGVHPtekh2a
        PByK/3b5zhbKBjO8YiSbYECUochRSvo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-ChPJyuLgM2uTzb7s_FfKxA-1; Mon, 15 Feb 2021 09:02:14 -0500
X-MC-Unique: ChPJyuLgM2uTzb7s_FfKxA-1
Received: by mail-ed1-f71.google.com with SMTP id x13so5062707edi.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Bdy4Ck9HumbCnFCknmPZKyEjiJQSsH7EMh++y94G+CQ=;
        b=irxxDPZ1UUvj7KO1g9kuV1GTS57nqFGFtO/ZwBDhzxvEgp34H6yA8LNtSQ2nsuymVp
         HRi7cuX+wTgmvNingKJpTVc0aYDxRzqL8Onv5EiBPHIIzXb6CB6+oBVqWWdFfwVJ77O2
         YgYny2bUOZqXzjZdEe+rMQ65R5Z/EZ90955Aa4gWRGi1DbdhpiFQpvCeJ1yZF1uNmtI0
         sUUe44nnPWaT023zwBRlDiiwyEjp+5I//yg1NdejmzF44CFI3qKXK/O5pRk9pMu0LKbr
         yo85McJTAd03S9/5eOnQ7B1RzTc3HzxC504zclwUlsjogrfLHXqnhSQtyvbSSmBYEo4j
         j/+A==
X-Gm-Message-State: AOAM530sNL5Htf7GbxMYV+0mUdCStnCpRN2dzeqLFSs0BlwyeuVDbhhV
        uZ1qPRLe8I0GQopLjxPCHy5xAe/jN8s0lw4RAl8/jSjqu6dpE75QCUtAUIHjjc/Yg9eEf/jJivl
        azmK1lS31A3lzfGbbLp4niGof3a2TjlFUbGzpX5yMdJdX9vNMpRdGg1ZJgYsPHyW0Rnn7/VhSZ2
        4f
X-Received: by 2002:a05:6402:20e:: with SMTP id t14mr15740733edv.178.1613397733153;
        Mon, 15 Feb 2021 06:02:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy94pAcz5VcQv1c/zSPQpegDKamIDAw3zo2wolcUE4c6/fRpyEUPBFXUQ0pPnqv2M2MQDnAug==
X-Received: by 2002:a05:6402:20e:: with SMTP id t14mr15740697edv.178.1613397732805;
        Mon, 15 Feb 2021 06:02:12 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s16sm4974624edr.14.2021.02.15.06.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 06:02:11 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.12-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <91563e42-94a5-95cd-25df-68e85307250f@redhat.com>
Date:   Mon, 15 Feb 2021 15:02:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.12.

Highlights:
- Microsoft Surface devices System Aggregator Module support
- SW_TABLET_MODE reporting improvements
- thinkpad_acpi keyboard language setting support
- platform / DPTF profile settings support
 - Base / userspace API parts merged from Rafael's acpi-platform branch
 - thinkpad_acpi and ideapad-laptop support through pdx86
- Remove support for some obsolete Intel MID platforms through merging
  of the shared intel-mid-removal branch
- Big cleanup of the ideapad-laptop driver
- Misc. other fixes / new hw support / quirks

Unfortunately there are a number of conflicts this time around:

1. The ideapad-laptop driver cleanup work conflicts with the
   "Disable touchpad_switch for ELAN0634" fix which went into 5.11 after rc1
   To resolve this just take ideapad-laptop.c from this pull-req as is.
   I've done an example merge of this here:
   git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git v5.12-ideapad-laptop-merge

2. The obsolete Intel MID platform removal was done through a shared branch
   which was pulled into multiple subsystems. Unfortunately something went
   wrong with the coordination and matching changes to drivers/gpu/drm/gma500
   also removing support for the GPUs on these platform landed in drm-misc
   without the shared branch being merged first.

   Depending on in which order you pull things you may have already resolved
   this.

   This causes the following files which are changed in this pull-req to be
   deleted in the drm pull-req:
   drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
   drivers/gpu/drm/gma500/mdfld_output.c
   drivers/gpu/drm/gma500/mdfld_dsi_output.c
   drivers/gpu/drm/gma500/mdfld_device.c
   This should (obviously) be resolved by deleting these files.
   There also is a conflict in the Kconfig file, the DRM_GMA3600 and
   DRM_MEDFIELD config options should both be removed.

3. The "Microsoft Surface devices System Aggregator Module support" comes
   with new mod_devicetable entries. This is causing the usual mod_devicetable
   related conflicts. Resolving this is straight forward.

Regards,

Hans


The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.12-1

for you to fetch changes up to a7d53dbbc70a81d5781da7fc905b656f41ad2381:

  platform/x86: intel_scu_ipc: Increase virtual timeout from 3 to 5 seconds (2021-02-11 16:49:10 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.12-1

- Microsoft Surface devices System Aggregator Module support
- SW_TABLET_MODE reporting improvements
- thinkpad_acpi keyboard language setting support
- platform / DPTF profile settings support
 - Base / userspace API parts merged from Rafael's acpi-platform branch
 - thinkpad_acpi and ideapad-laptop support through pdx86
- Remove support for some obsolete Intel MID platforms through merging
  of the shared intel-mid-removal branch
- Big cleanup of the ideapad-laptop driver
- Misc. other fixes / new hw support / quirks

The following is an automated git shortlog grouped by driver:

ACPI:
 -  platform-profile: Fix possible deadlock in platform_profile_remove()
 -  platform-profile: Introduce object pointers to callbacks
 -  platform-profile: Drop const qualifier for cur_profile
 -  platform: Add platform profile support

Documentation:
 -  Add documentation for new platform_profile sysfs attribute

Documentation/ABI:
 -  sysfs-platform-ideapad-laptop: conservation_mode attribute
 -  sysfs-platform-ideapad-laptop: update device attribute paths

Kconfig:
 -  add missing selects for ideapad-laptop

MAINTAINERS:
 -  update email address for Henrique de Moraes Holschuh

Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans:
 - Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans

Merge remote-tracking branch 'linux-pm/acpi-platform' into review-hans:
 - Merge remote-tracking branch 'linux-pm/acpi-platform' into review-hans

Merge tag 'ib-drm-gpio-pdx86-rtc-wdt-v5.12-1' into for-next:
 - Merge tag 'ib-drm-gpio-pdx86-rtc-wdt-v5.12-1' into for-next

Move all dell drivers to their own subdirectory:
 - Move all dell drivers to their own subdirectory

Platform:
 -  OLPC: Constify static struct regulator_ops
 -  OLPC: Specify the enable time
 -  OLPC: Remove dcon_rdev from olpc_ec_priv
 -  OLPC: Fix probe error handling

Revert "platform/x86:
 -  ideapad-laptop: Switch touchpad attribute to be RO"

acer-wmi:
 -  Don't use ACPI_EXCEPTION()

amd-pmc:
 -  put device on error paths
 -  Fix CONFIG_DEBUG_FS check

dell-wmi-sysman:
 -  fix a NULL pointer dereference

docs:
 -  driver-api: Add Surface Aggregator subsystem documentation

drm/gma500:
 -  Get rid of duplicate NULL checks
 -  Convert to use new SCU IPC API

gpio:
 -  msic: Remove driver for deprecated platform
 -  intel-mid: Remove driver for deprecated platform

hp-wmi:
 -  Disable tablet-mode reporting by default
 -  Don't log a warning on HPWMI_RET_UNKNOWN_COMMAND errors

i2c-multi-instantiate:
 -  Don't create platform device for INT3515 ACPI nodes

ideapad-laptop:
 -  add "always on USB charging" control support
 -  add keyboard backlight control support
 -  send notification about touchpad state change to sysfs
 -  fix checkpatch warnings, more consistent style
 -  change 'cfg' debugfs file format
 -  change 'status' debugfs file format
 -  check for touchpad support in _CFG
 -  check for Fn-lock support in HALS
 -  rework is_visible() logic
 -  rework and create new ACPI helpers
 -  group and separate (un)related constants into enums
 -  misc. device attribute changes
 -  always propagate error codes from device attributes' show() callback
 -  convert ACPI helpers to return -EIO in case of failure
 -  use dev_{err,warn} or appropriate variant to display log messages
 -  use msecs_to_jiffies() helper instead of hand-crafted formula
 -  use for_each_set_bit() helper to simplify event processing
 -  use kobj_to_dev()
 -  use device_{add,remove}_group
 -  use sysfs_emit()
 -  add missing call to submodule destructor
 -  sort includes lexicographically
 -  use appropriately typed variable to store the return value of ACPI methods
 -  remove unnecessary NULL checks
 -  remove unnecessary dev_set_drvdata() call
 -  DYTC Platform profile support
 -  Disable touchpad_switch for ELAN0634

intel-vbtn:
 -  Eval VBDL after registering our notifier
 -  Add alternative method to enable switches
 -  Create 2 separate input-devs for buttons and switches
 -  Rework wakeup handling in notify_handler()
 -  Drop HP Stream x360 Convertible PC 11 from allow-list
 -  Support for tablet mode on Dell Inspiron 7352

intel_mid_powerbtn:
 -  Remove driver for deprecated platform
 -  Remove driver for deprecated platform

intel_mid_thermal:
 -  Remove driver for deprecated platform
 -  Remove driver for deprecated platform

intel_pmt:
 -  Make INTEL_PMT_CLASS non-user-selectable

intel_pmt_crashlog:
 -  Add dependency on MFD_INTEL_PMT

intel_pmt_telemetry:
 -  Add dependency on MFD_INTEL_PMT

intel_scu_ipc:
 -  Increase virtual timeout from 3 to 5 seconds

intel_scu_wdt:
 -  Drop mistakenly added const
 -  Get rid of custom x86 model comparison
 -  Drop SCU notification
 -  Move driver from arch/x86

msi-wmi:
 -  Fix variable 'status' set but not used compiler warning

platform/surface:
 -  aggregator: Fix access of unaligned value
 -  Add Surface Hot-Plug driver
 -  surface3-wmi: Fix variable 'status' set but not used compiler warning
 -  aggregator: Fix braces in if condition with unlikely() macro
 -  aggregator: Fix kernel-doc references
 -  aggregator: fix a kernel-doc markup
 -  aggregator_cdev: Add comments regarding unchecked allocation size
 -  aggregator_cdev: Fix access of uninitialized variables
 -  fix potential integer overflow on shift of a int
 -  Add Surface ACPI Notify driver
 -  Add Surface Aggregator user-space interface
 -  aggregator: Add dedicated bus and device type
 -  aggregator: Add error injection capabilities
 -  aggregator: Add trace points
 -  aggregator: Add event item allocation caching
 -  aggregator: Add control packet allocation caching
 -  Add Surface Aggregator subsystem
 -  SURFACE_PLATFORMS should depend on ACPI
 -  surface_gpe: Fix non-PM_SLEEP build warnings

platform/x86/intel-uncore-freq:
 -  Add Sapphire Rapids server support

rtc:
 -  mrst: Remove driver for deprecated platform

sony-laptop:
 -  Remove unneeded semicolon

thinkpad_acpi:
 -  Replace ifdef CONFIG_ACPI_PLATFORM_PROFILE with depends on
 -  Fix 'warning: no previous prototype for' warnings
 -  Add platform profile support
 -  fixed warning and incorporated review comments
 -  rectify length of title underline
 -  Don't register keyboard_lang unnecessarily
 -  set keyboard language
 -  Add P53/73 firmware to fan_quirk_table for dual fan control
 -  correct palmsensor error checking

tools/power/x86/intel-speed-select:
 -  Update version to 1.8
 -  Add new command to get/set TRL
 -  Add new command turbo-mode
 -  Set higher of cpuinfo_max_freq or base_frequency
 -  Set scaling_max_freq to base_frequency

touchscreen_dmi:
 -  Add info for the Jumper EZpad 7 tablet
 -  Add swap-x-y quirk for Goodix touchscreen on Estar Beauty HD tablet

watchdog:
 -  intel-mid_wdt: Postpone IRQ handler registration till SCU is ready
 -  intel_scu_watchdog: Remove driver for deprecated platform

----------------------------------------------------------------
Andy Shevchenko (15):
      drm/gma500: Convert to use new SCU IPC API
      drm/gma500: Get rid of duplicate NULL checks
      gpio: intel-mid: Remove driver for deprecated platform
      gpio: msic: Remove driver for deprecated platform
      platform/x86: intel_mid_thermal: Remove driver for deprecated platform
      platform/x86: intel_mid_powerbtn: Remove driver for deprecated platform
      rtc: mrst: Remove driver for deprecated platform
      watchdog: intel_scu_watchdog: Remove driver for deprecated platform
      watchdog: intel-mid_wdt: Postpone IRQ handler registration till SCU is ready
      platform/x86: intel_scu_wdt: Move driver from arch/x86
      platform/x86: intel_scu_wdt: Drop SCU notification
      platform/x86: intel_scu_wdt: Get rid of custom x86 model comparison
      platform/x86: intel_mid_thermal: Remove driver for deprecated platform
      platform/x86: intel_mid_powerbtn: Remove driver for deprecated platform
      platform/x86: intel_scu_wdt: Drop mistakenly added const

Arnold Gozum (1):
      platform/x86: intel-vbtn: Support for tablet mode on Dell Inspiron 7352

Artem Bityutskiy (1):
      platform/x86/intel-uncore-freq: Add Sapphire Rapids server support

Barnabás Pőcze (29):
      platform/x86: ideapad-laptop: remove unnecessary dev_set_drvdata() call
      platform/x86: ideapad-laptop: remove unnecessary NULL checks
      platform/x86: ideapad-laptop: use appropriately typed variable to store the return value of ACPI methods
      platform/x86: ideapad-laptop: sort includes lexicographically
      platform/x86: ideapad-laptop: add missing call to submodule destructor
      platform/x86: ideapad-laptop: use sysfs_emit()
      platform/x86: ideapad-laptop: use device_{add,remove}_group
      platform/x86: ideapad-laptop: use kobj_to_dev()
      platform/x86: ideapad-laptop: use for_each_set_bit() helper to simplify event processing
      platform/x86: ideapad-laptop: use msecs_to_jiffies() helper instead of hand-crafted formula
      platform/x86: ideapad-laptop: use dev_{err,warn} or appropriate variant to display log messages
      platform/x86: ideapad-laptop: convert ACPI helpers to return -EIO in case of failure
      platform/x86: ideapad-laptop: always propagate error codes from device attributes' show() callback
      platform/x86: ideapad-laptop: misc. device attribute changes
      platform/x86: ideapad-laptop: group and separate (un)related constants into enums
      platform/x86: ideapad-laptop: rework and create new ACPI helpers
      platform/x86: ideapad-laptop: rework is_visible() logic
      platform/x86: ideapad-laptop: check for Fn-lock support in HALS
      platform/x86: ideapad-laptop: check for touchpad support in _CFG
      platform/x86: ideapad-laptop: change 'status' debugfs file format
      platform/x86: ideapad-laptop: change 'cfg' debugfs file format
      Revert "platform/x86: ideapad-laptop: Switch touchpad attribute to be RO"
      platform/x86: ideapad-laptop: fix checkpatch warnings, more consistent style
      platform/x86: ideapad-laptop: send notification about touchpad state change to sysfs
      platform/x86: ideapad-laptop: add keyboard backlight control support
      platform/x86: ideapad-laptop: add "always on USB charging" control support
      Documentation/ABI: sysfs-platform-ideapad-laptop: update device attribute paths
      Documentation/ABI: sysfs-platform-ideapad-laptop: conservation_mode attribute
      platform/x86: Kconfig: add missing selects for ideapad-laptop

Casey Bowman (1):
      platform/x86: intel_scu_ipc: Increase virtual timeout from 3 to 5 seconds

Colin Ian King (1):
      platform/surface: fix potential integer overflow on shift of a int

David E. Box (3):
      platform/x86: intel_pmt: Make INTEL_PMT_CLASS non-user-selectable
      platform/x86: intel_pmt_telemetry: Add dependency on MFD_INTEL_PMT
      platform/x86: intel_pmt_crashlog: Add dependency on MFD_INTEL_PMT

Geert Uytterhoeven (1):
      platform/surface: SURFACE_PLATFORMS should depend on ACPI

Hans de Goede (19):
      platform/x86: touchscreen_dmi: Add swap-x-y quirk for Goodix touchscreen on Estar Beauty HD tablet
      platform/x86: intel-vbtn: Drop HP Stream x360 Convertible PC 11 from allow-list
      platform/x86: hp-wmi: Don't log a warning on HPWMI_RET_UNKNOWN_COMMAND errors
      platform/x86: intel-vbtn: Rework wakeup handling in notify_handler()
      platform/x86: intel-vbtn: Create 2 separate input-devs for buttons and switches
      platform/x86: intel-vbtn: Add alternative method to enable switches
      platform/x86: intel-vbtn: Eval VBDL after registering our notifier
      platform/x86: hp-wmi: Disable tablet-mode reporting by default
      ACPI: platform-profile: Fix possible deadlock in platform_profile_remove()
      platform/x86: thinkpad_acpi: Don't register keyboard_lang unnecessarily
      Merge remote-tracking branch 'linux-pm/acpi-platform' into review-hans
      Merge tag 'ib-drm-gpio-pdx86-rtc-wdt-v5.12-1' into for-next
      platform/x86: touchscreen_dmi: Add info for the Jumper EZpad 7 tablet
      platform/surface: surface3-wmi: Fix variable 'status' set but not used compiler warning
      platform/x86: msi-wmi: Fix variable 'status' set but not used compiler warning
      platform/x86: thinkpad_acpi: Fix 'warning: no previous prototype for' warnings
      platform/x86: thinkpad_acpi: Replace ifdef CONFIG_ACPI_PLATFORM_PROFILE with depends on
      platform/x86: acer-wmi: Don't use ACPI_EXCEPTION()
      Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans

Heikki Krogerus (1):
      platform/x86: i2c-multi-instantiate: Don't create platform device for INT3515 ACPI nodes

Henrique de Moraes Holschuh (1):
      MAINTAINERS: update email address for Henrique de Moraes Holschuh

Jeannie Stevenson (1):
      platform/x86: thinkpad_acpi: Add P53/73 firmware to fan_quirk_table for dual fan control

Jiaxun Yang (4):
      platform/x86: ideapad-laptop: Disable touchpad_switch for ELAN0634
      ACPI: platform-profile: Drop const qualifier for cur_profile
      ACPI: platform-profile: Introduce object pointers to callbacks
      platform/x86: ideapad-laptop: DYTC Platform profile support

Lubomir Rintel (3):
      Platform: OLPC: Fix probe error handling
      Platform: OLPC: Remove dcon_rdev from olpc_ec_priv
      Platform: OLPC: Specify the enable time

Lukas Bulwahn (1):
      platform/x86: thinkpad_acpi: rectify length of title underline

Mario Limonciello (2):
      platform/x86: dell-wmi-sysman: fix a NULL pointer dereference
      platform/x86: Move all dell drivers to their own subdirectory

Mark Pearson (4):
      Documentation: Add documentation for new platform_profile sysfs attribute
      ACPI: platform: Add platform profile support
      platform/x86: thinkpad_acpi: correct palmsensor error checking
      platform/x86: thinkpad_acpi: Add platform profile support

Mauro Carvalho Chehab (1):
      platform/surface: aggregator: fix a kernel-doc markup

Maximilian Luz (15):
      platform/surface: Add Surface Aggregator subsystem
      platform/surface: aggregator: Add control packet allocation caching
      platform/surface: aggregator: Add event item allocation caching
      platform/surface: aggregator: Add trace points
      platform/surface: aggregator: Add error injection capabilities
      platform/surface: aggregator: Add dedicated bus and device type
      docs: driver-api: Add Surface Aggregator subsystem documentation
      platform/surface: Add Surface Aggregator user-space interface
      platform/surface: Add Surface ACPI Notify driver
      platform/surface: aggregator_cdev: Fix access of uninitialized variables
      platform/surface: aggregator_cdev: Add comments regarding unchecked allocation size
      platform/surface: aggregator: Fix kernel-doc references
      platform/surface: aggregator: Fix braces in if condition with unlikely() macro
      platform/surface: Add Surface Hot-Plug driver
      platform/surface: aggregator: Fix access of unaligned value

Nitin Joshi (2):
      platform/x86: thinkpad_acpi: set keyboard language
      platform/x86: thinkpad_acpi: fixed warning and incorporated review comments

Pan Bian (1):
      platform/x86: amd-pmc: put device on error paths

Randy Dunlap (1):
      platform/surface: surface_gpe: Fix non-PM_SLEEP build warnings

Rikard Falkeborn (1):
      Platform: OLPC: Constify static struct regulator_ops

Shyam Sundar S K (1):
      platform/x86: amd-pmc: Fix CONFIG_DEBUG_FS check

Srinivas Pandruvada (5):
      tools/power/x86/intel-speed-select: Set scaling_max_freq to base_frequency
      tools/power/x86/intel-speed-select: Set higher of cpuinfo_max_freq or base_frequency
      tools/power/x86/intel-speed-select: Add new command turbo-mode
      tools/power/x86/intel-speed-select: Add new command to get/set TRL
      tools/power/x86/intel-speed-select: Update version to 1.8

Yue Zou (1):
      sony-laptop: Remove unneeded semicolon

 .../ABI/testing/sysfs-platform-ideapad-laptop      |   26 +-
 Documentation/ABI/testing/sysfs-platform_profile   |   24 +
 .../admin-guide/laptops/thinkpad-acpi.rst          |   25 +
 Documentation/driver-api/index.rst                 |    1 +
 .../driver-api/surface_aggregator/client-api.rst   |   38 +
 .../driver-api/surface_aggregator/client.rst       |  393 +++
 .../driver-api/surface_aggregator/clients/cdev.rst |   87 +
 .../surface_aggregator/clients/index.rst           |   21 +
 .../driver-api/surface_aggregator/clients/san.rst  |   44 +
 .../driver-api/surface_aggregator/index.rst        |   21 +
 .../driver-api/surface_aggregator/internal-api.rst |   67 +
 .../driver-api/surface_aggregator/internal.rst     |  577 +++++
 .../driver-api/surface_aggregator/overview.rst     |   77 +
 .../driver-api/surface_aggregator/ssh.rst          |  344 +++
 Documentation/userspace-api/index.rst              |    1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 +
 .../userspace-api/sysfs-platform_profile.rst       |   42 +
 MAINTAINERS                                        |   45 +-
 arch/x86/platform/intel-mid/device_libs/Makefile   |    1 -
 drivers/acpi/Kconfig                               |   17 +
 drivers/acpi/Makefile                              |    1 +
 drivers/acpi/platform_profile.c                    |  177 ++
 drivers/gpio/Kconfig                               |   14 -
 drivers/gpio/Makefile                              |    1 -
 drivers/gpio/TODO                                  |    2 +-
 drivers/gpio/gpio-intel-mid.c                      |  414 ----
 drivers/gpio/gpio-msic.c                           |  314 ---
 drivers/gpu/drm/gma500/Kconfig                     |    1 +
 drivers/gpu/drm/gma500/mdfld_device.c              |    2 -
 drivers/gpu/drm/gma500/mdfld_dsi_output.c          |    2 -
 drivers/gpu/drm/gma500/mdfld_output.c              |    8 +-
 drivers/gpu/drm/gma500/oaktrail_device.c           |    3 -
 drivers/gpu/drm/gma500/psb_drv.h                   |    3 +
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c         |   30 +-
 drivers/platform/olpc/olpc-ec.c                    |   37 +-
 drivers/platform/surface/Kconfig                   |   65 +-
 drivers/platform/surface/Makefile                  |    4 +
 drivers/platform/surface/aggregator/Kconfig        |   68 +
 drivers/platform/surface/aggregator/Makefile       |   17 +
 drivers/platform/surface/aggregator/bus.c          |  415 ++++
 drivers/platform/surface/aggregator/bus.h          |   27 +
 drivers/platform/surface/aggregator/controller.c   | 2579 ++++++++++++++++++++
 drivers/platform/surface/aggregator/controller.h   |  285 +++
 drivers/platform/surface/aggregator/core.c         |  839 +++++++
 drivers/platform/surface/aggregator/ssh_msgb.h     |  205 ++
 .../platform/surface/aggregator/ssh_packet_layer.c | 2074 ++++++++++++++++
 .../platform/surface/aggregator/ssh_packet_layer.h |  190 ++
 drivers/platform/surface/aggregator/ssh_parser.c   |  228 ++
 drivers/platform/surface/aggregator/ssh_parser.h   |  154 ++
 .../surface/aggregator/ssh_request_layer.c         | 1263 ++++++++++
 .../surface/aggregator/ssh_request_layer.h         |  143 ++
 drivers/platform/surface/aggregator/trace.h        |  632 +++++
 drivers/platform/surface/surface3-wmi.c            |    6 +-
 drivers/platform/surface/surface_acpi_notify.c     |  886 +++++++
 drivers/platform/surface/surface_aggregator_cdev.c |  322 +++
 drivers/platform/surface/surface_gpe.c             |    4 +-
 drivers/platform/surface/surface_hotplug.c         |  282 +++
 drivers/platform/x86/Kconfig                       |  207 +-
 drivers/platform/x86/Makefile                      |   19 +-
 drivers/platform/x86/acer-wmi.c                    |    4 +-
 drivers/platform/x86/amd-pmc.c                     |   16 +-
 drivers/platform/x86/dell/Kconfig                  |  207 ++
 drivers/platform/x86/dell/Makefile                 |   21 +
 drivers/platform/x86/{ => dell}/alienware-wmi.c    |    0
 drivers/platform/x86/{ => dell}/dcdbas.c           |    0
 drivers/platform/x86/{ => dell}/dcdbas.h           |    0
 drivers/platform/x86/{ => dell}/dell-laptop.c      |    0
 drivers/platform/x86/{ => dell}/dell-rbtn.c        |    0
 drivers/platform/x86/{ => dell}/dell-rbtn.h        |    0
 drivers/platform/x86/{ => dell}/dell-smbios-base.c |    0
 drivers/platform/x86/{ => dell}/dell-smbios-smm.c  |    0
 drivers/platform/x86/{ => dell}/dell-smbios-wmi.c  |    0
 drivers/platform/x86/{ => dell}/dell-smbios.h      |    0
 drivers/platform/x86/{ => dell}/dell-smo8800.c     |    0
 drivers/platform/x86/{ => dell}/dell-wmi-aio.c     |    0
 .../platform/x86/{ => dell}/dell-wmi-descriptor.c  |    0
 .../platform/x86/{ => dell}/dell-wmi-descriptor.h  |    0
 drivers/platform/x86/{ => dell}/dell-wmi-led.c     |    0
 .../x86/{ => dell}/dell-wmi-sysman/Makefile        |    0
 .../dell-wmi-sysman/biosattr-interface.c           |    0
 .../{ => dell}/dell-wmi-sysman/dell-wmi-sysman.h   |    0
 .../{ => dell}/dell-wmi-sysman/enum-attributes.c   |    0
 .../{ => dell}/dell-wmi-sysman/int-attributes.c    |    0
 .../dell-wmi-sysman/passobj-attributes.c           |    0
 .../dell-wmi-sysman/passwordattr-interface.c       |    0
 .../{ => dell}/dell-wmi-sysman/string-attributes.c |    0
 .../x86/{ => dell}/dell-wmi-sysman/sysman.c        |    6 +-
 drivers/platform/x86/{ => dell}/dell-wmi.c         |    0
 drivers/platform/x86/{ => dell}/dell_rbu.c         |    0
 drivers/platform/x86/hp-wmi.c                      |   17 +-
 drivers/platform/x86/i2c-multi-instantiate.c       |   31 +-
 drivers/platform/x86/ideapad-laptop.c              | 1455 +++++++----
 drivers/platform/x86/intel-uncore-frequency.c      |    1 +
 drivers/platform/x86/intel-vbtn.c                  |  148 +-
 drivers/platform/x86/intel_mid_powerbtn.c          |  233 --
 drivers/platform/x86/intel_mid_thermal.c           |  560 -----
 drivers/platform/x86/intel_scu_ipc.c               |    2 +-
 .../platform/x86/intel_scu_wdt.c                   |   41 +-
 drivers/platform/x86/msi-wmi.c                     |    2 +
 drivers/platform/x86/thinkpad_acpi.c               |  469 +++-
 drivers/platform/x86/touchscreen_dmi.c             |   45 +
 drivers/rtc/Kconfig                                |   12 -
 drivers/rtc/Makefile                               |    1 -
 drivers/rtc/rtc-mrst.c                             |  521 ----
 drivers/watchdog/Kconfig                           |    9 -
 drivers/watchdog/Makefile                          |    1 -
 drivers/watchdog/intel-mid_wdt.c                   |    8 +-
 drivers/watchdog/intel_scu_watchdog.c              |  533 ----
 drivers/watchdog/intel_scu_watchdog.h              |   50 -
 include/linux/mod_devicetable.h                    |   18 +
 include/linux/platform_profile.h                   |   41 +
 include/linux/sony-laptop.h                        |    2 +-
 include/linux/surface_acpi_notify.h                |   39 +
 include/linux/surface_aggregator/controller.h      |  824 +++++++
 include/linux/surface_aggregator/device.h          |  423 ++++
 include/linux/surface_aggregator/serial_hub.h      |  672 +++++
 include/uapi/linux/surface_aggregator/cdev.h       |   78 +
 scripts/mod/devicetable-offsets.c                  |    8 +
 scripts/mod/file2alias.c                           |   23 +
 tools/power/x86/intel-speed-select/isst-config.c   |  147 +-
 tools/power/x86/intel-speed-select/isst-core.c     |   11 +
 tools/power/x86/intel-speed-select/isst-display.c  |   18 +
 tools/power/x86/intel-speed-select/isst.h          |    2 +
 123 files changed, 16979 insertions(+), 3496 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
 create mode 100644 Documentation/driver-api/surface_aggregator/client-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/client.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/cdev.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/san.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/overview.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/ssh.rst
 create mode 100644 Documentation/userspace-api/sysfs-platform_profile.rst
 create mode 100644 drivers/acpi/platform_profile.c
 delete mode 100644 drivers/gpio/gpio-intel-mid.c
 delete mode 100644 drivers/gpio/gpio-msic.c
 create mode 100644 drivers/platform/surface/aggregator/Kconfig
 create mode 100644 drivers/platform/surface/aggregator/Makefile
 create mode 100644 drivers/platform/surface/aggregator/bus.c
 create mode 100644 drivers/platform/surface/aggregator/bus.h
 create mode 100644 drivers/platform/surface/aggregator/controller.c
 create mode 100644 drivers/platform/surface/aggregator/controller.h
 create mode 100644 drivers/platform/surface/aggregator/core.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_msgb.h
 create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.h
 create mode 100644 drivers/platform/surface/aggregator/ssh_parser.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_parser.h
 create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.h
 create mode 100644 drivers/platform/surface/aggregator/trace.h
 create mode 100644 drivers/platform/surface/surface_acpi_notify.c
 create mode 100644 drivers/platform/surface/surface_aggregator_cdev.c
 create mode 100644 drivers/platform/surface/surface_hotplug.c
 create mode 100644 drivers/platform/x86/dell/Kconfig
 create mode 100644 drivers/platform/x86/dell/Makefile
 rename drivers/platform/x86/{ => dell}/alienware-wmi.c (100%)
 rename drivers/platform/x86/{ => dell}/dcdbas.c (100%)
 rename drivers/platform/x86/{ => dell}/dcdbas.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-laptop.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-rbtn.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-rbtn.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-smbios-base.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-smbios-smm.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-smbios-wmi.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-smbios.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-smo8800.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-aio.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-descriptor.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-descriptor.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-led.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/Makefile (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/biosattr-interface.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/dell-wmi-sysman.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/enum-attributes.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/int-attributes.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/passobj-attributes.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/passwordattr-interface.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/string-attributes.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/sysman.c (98%)
 rename drivers/platform/x86/{ => dell}/dell-wmi.c (100%)
 rename drivers/platform/x86/{ => dell}/dell_rbu.c (100%)
 delete mode 100644 drivers/platform/x86/intel_mid_powerbtn.c
 delete mode 100644 drivers/platform/x86/intel_mid_thermal.c
 rename arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.c => drivers/platform/x86/intel_scu_wdt.c (69%)
 delete mode 100644 drivers/rtc/rtc-mrst.c
 delete mode 100644 drivers/watchdog/intel_scu_watchdog.c
 delete mode 100644 drivers/watchdog/intel_scu_watchdog.h
 create mode 100644 include/linux/platform_profile.h
 create mode 100644 include/linux/surface_acpi_notify.h
 create mode 100644 include/linux/surface_aggregator/controller.h
 create mode 100644 include/linux/surface_aggregator/device.h
 create mode 100644 include/linux/surface_aggregator/serial_hub.h
 create mode 100644 include/uapi/linux/surface_aggregator/cdev.h

