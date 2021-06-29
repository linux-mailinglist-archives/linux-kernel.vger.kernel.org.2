Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522163B7281
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhF2Myd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233955AbhF2Mxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624971070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J9stpp4iYMCmXYdkgLWZaTqr7wvyQN++9pwYVWQa88A=;
        b=HmljdXy58Typ2tqOxfIzZ9X+PfeIbQr2UWRPX8ZJY69djUPyvWGL6/d7CCdjoFvNNa6F1X
        pISpTsNZAeR4K43Xnbuy57ZDvpJmUnVFVlk1OiOkPSRmbgEjpKdiY3+67WvpE5vvneBigb
        JT8nH7NAxBRg8kHiE9Br5wONc0VRysU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Y5UAtTrIPZqaRhIoO8c1TQ-1; Tue, 29 Jun 2021 08:51:08 -0400
X-MC-Unique: Y5UAtTrIPZqaRhIoO8c1TQ-1
Received: by mail-ed1-f70.google.com with SMTP id p19-20020aa7c4d30000b0290394bdda6d9cso11368995edr.21
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 05:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J9stpp4iYMCmXYdkgLWZaTqr7wvyQN++9pwYVWQa88A=;
        b=ORsHBFLz3SVIi1l0nNOLvyY/qQAdIUlktytlZwmw5UP3xRqoCv7LnSrJEGWnz5mzkw
         jc6ZKqkp9xMN2h+WeeeEVlA7/mOAvOhUB3cra6StwVKMIXpnty/AALacy2g/lmPUga5d
         oXui1jDT2W0cGUDJhf7wBrKRlmtPV0edexwEvg3X3UsUNAlQtO1xVp/X+Aj8kuY3cVxc
         beE+RPaUDMKhsqzvDp/kGJ2+CA7Nf5+U9FOHNZ2Z3bLPgpMhQySlkxjvrAbOYghXqwr+
         FnzEnyA7ZIRT0JFLbPsMFo9Fgs0nxB283izVKg0EZqwXwOjsU7TMnpcF9MNdIGlzhJgH
         mDsw==
X-Gm-Message-State: AOAM530Ns+D519li/kdutkwkrUYL11vc91Qp1abJnvZNyD4tPLw3U6wz
        U7CXL0X8RETlnpU8/6Mf8rqSdP1/ZdslU2Bj3rpgbFLLXuN9Mific6fcNP2DQwFi+qTCMfOkqWW
        q6bvAEkgdOFspxsxf5YbBkR/2
X-Received: by 2002:a17:906:3a53:: with SMTP id a19mr15523361ejf.88.1624971067239;
        Tue, 29 Jun 2021 05:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+XKV1leFKDZl0ryoiN+yOEAb97gM2dISVZazaCN5EGfqZjsQoq3/x0zIuUPtTbkK785AuPg==
X-Received: by 2002:a17:906:3a53:: with SMTP id a19mr15523337ejf.88.1624971066941;
        Tue, 29 Jun 2021 05:51:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t17sm11238058edv.75.2021.06.29.05.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 05:51:03 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.14-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <c2fbb9bc-4443-ac00-d4b7-5b2305100545@redhat.com>
Date:   Tue, 29 Jun 2021 14:51:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.14.

Highlights:
 - New think-lmi driver adding support for changing BIOS settings from
   within Linux using the standard firmware-attributes class sysfs API
 - MS Surface aggregator-cdev now also supports forwarding events to
   user-space (for debugging / new driver development purposes only)
 - New intel_skl_int3472 driver this provides the necessary glue to
   translate ACPI table information to GPIOs, regulators, etc. for
   camera sensors on Intel devices with IPU3 attached MIPI cameras
 - A whole bunch of other fixes + device-specific quirk additions
 - New devm_work_autocancel() devm-helpers.h function (1)

Note this also contains merges of the following immutable branches/tags
shared with other subsystems:
 - platform-drivers-x86-goodix-v5.14-1
 - intel-gpio-v5.14-1
 - linux-pm/acpi-scan
 - devm-helpers-v5.14-1

1) linux/include/devm-helpers.h is a new file in 5.13, when this was
being reviewed Greg indicated that he would rather not add this to all
the other stuff which he already maintains, so I volunteered and I'm
maintaining this now, which is why the devm-helper changes are part of
this pull-req.

Regards,

Hans


The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.14-1

for you to fetch changes up to 0e695c3f7f66c66e0a1da90cc5378198a656d494:

  platform/x86: dell-wmi-sysman: Change user experience when Admin/System Password is modified (2021-06-28 11:53:24 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.14-1

Highlights:
 - New think-lmi driver adding support for changing BIOS settings from
   within Linux using the standard firmware-attributes class sysfs API
 - MS Surface aggregator-cdev now also supports forwarding events to
   user-space (for debugging / new driver development purposes only)
 - New intel_skl_int3472 driver this provides the necessary glue to
   translate ACPI table information to GPIOs, regulators, etc. for
   camera sensors on Intel devices with IPU3 attached MIPI cameras
 - A whole bunch of other fixes + device-specific quirk additions
 - New devm_work_autocancel() devm-helpers.h function

Note this also contains merges of the following immutable branches/tags
shared with other subsystems:
 - platform-drivers-x86-goodix-v5.14-1
 - intel-gpio-v5.14-1
 - linux-pm/acpi-scan
 - devm-helpers-v5.14-1

The following is an automated git shortlog grouped by driver:

ACPI:
 -  scan: initialize local variable to avoid garbage being returned
 -  scan: Add function to fetch dependent of ACPI device
 -  scan: Extend acpi_walk_dep_device_list()
 -  scan: Rearrange dep_unmet initialization

Add intel_skl_int3472 driver:
 - Add intel_skl_int3472 driver

ISST:
 -  Use numa node id for cpu pci dev mapping
 -  Optimize CPU to PCI device mapping

Input:
 -  goodix - platform/x86: touchscreen_dmi - Move upside down quirks to touchscreen_dmi.c

MAINTAINERS:
 -  Update IRC link for Surface System Aggregator subsystem
 -  Update info for telemetry

Merge remote-tracking branch 'linux-pm/acpi-scan' into review-hans:
 - Merge remote-tracking branch 'linux-pm/acpi-scan' into review-hans

Merge tag 'devm-helpers-v5.14-1' into review-hans:
 - Merge tag 'devm-helpers-v5.14-1' into review-hans

Merge tag 'intel-gpio-v5.14-1' into review-hans:
 - Merge tag 'intel-gpio-v5.14-1' into review-hans

Merge tag 'platform-drivers-x86-goodix-v5.14-1' into review-hans:
 - Merge tag 'platform-drivers-x86-goodix-v5.14-1' into review-hans

Remove "default n" entries:
 - Remove "default n" entries

Rename hp-wireless to wireless-hotkey:
 - Rename hp-wireless to wireless-hotkey

asus-nb-wmi:
 -  Revert "add support for ASUS ROG Zephyrus G14 and G15"
 -  Revert "Drop duplicate DMI quirk structures"

dcdbas:
 -  drop unneeded assignment in host_control_smi()

dell-privacy:
 -  Add support for Dell hardware privacy

dell-wmi:
 -  Rename dell-wmi.c to dell-wmi-base.c

dell-wmi-sysman:
 -  Change user experience when Admin/System Password is modified
 -  fw_attr_inuse can be static
 -  Use firmware_attributes_class helper
 -  Make populate_foo_data functions more robust

dell-wmi-sysman/think-lmi:
 -  Make fw_attr_class global static

devm-helpers:
 -  Add resource managed version of work init

docs:
 -  driver-api: Update Surface Aggregator user-space interface documentation

extcon:
 -  extcon-max8997: Simplify driver using devm
 -  extcon-max8997: Fix IRQ freeing at error path
 -  extcon-max77693.c: Fix potential work-queue cancellation race
 -  extcon-max14577: Fix potential work-queue cancellation race

firmware_attributes_class:
 -  Create helper file for handling firmware-attributes class registration events

gpio:
 -  wcove: Split error handling for CTRL and IRQ registers
 -  wcove: Unify style of to_reg() with to_ireg()
 -  wcove: Use IRQ hardware number getter instead of direct access
 -  crystalcove: remove platform_set_drvdata() + cleanup probe

gpiolib:
 -  acpi: Add acpi_gpio_get_io_resource()
 -  acpi: Introduce acpi_get_and_request_gpiod() helper

hdaps:
 -  Constify static attribute_group struct

ideapad-laptop:
 -  Ignore VPC event bit 10

intel_cht_int33fe:
 -  Move to its own subfolder
 -  Correct "displayport" fwnode reference

intel_ips:
 -  fix set but unused warning in read_mgtv

intel_pmt_crashlog:
 -  Constify static attribute_group struct

intel_skl_int3472:
 -  Uninitialized variable in skl_int3472_handle_gpio_resources()
 -  Move to intel/ subfolder
 -  Provide skl_int3472_unregister_clock()
 -  Provide skl_int3472_unregister_regulator()
 -  Use ACPI GPIO resource directly
 -  Fix dependencies (drop CLKDEV_LOOKUP)
 -  Free ACPI device resources after use

mfd:
 -  tps68470: Remove tps68470 MFD driver

platform/mellanox:
 -  mlxreg-hotplug: Revert "move to use request_irq by IRQF_NO_AUTOEN flag"

platform/surface:
 -  aggregator: Use list_move_tail instead of list_del/list_add_tail in ssh_packet_layer.c
 -  aggregator: Use list_move_tail instead of list_del/list_add_tail in ssh_request_layer.c
 -  aggregator: Drop unnecessary variable initialization
 -  aggregator: Do not return uninitialized value
 -  aggregator_cdev: Add lockdep support
 -  aggregator_cdev: Allow enabling of events from user-space
 -  aggregator_cdev: Add support for forwarding events to user-space
 -  aggregator: Update copyright
 -  aggregator: Allow enabling of events without notifiers
 -  aggregator: Allow registering notifiers without enabling events
 -  dtx: Add missing mutex_destroy() call in failure path
 -  aggregator: Fix event disable function
 -  aggregator_registry: Consolidate node groups for 5th- and 6th-gen devices
 -  aggregator_registry: Add support for 13" Intel Surface Laptop 4
 -  aggregator_registry: Update comments for 15" AMD Surface Laptop 4

samsung-laptop:
 -  set debugfs blobs to read only
 -  use octal numbers for rwx file permissions

tc1100-wmi:
 -  Constify static attribute_group struct

think-lmi:
 -  Move kfree(setting->possible_values) to tlmi_attr_setting_release()
 -  Split current_value to reflect only the value
 -  Fix issues with duplicate attributes
 -  Return EINVAL when kbdlang gets set to a 0 length string
 -  Add missing MODULE_DEVICE_TABLE
 -  Avoid potential read before start of the buffer
 -  Fix check for admin password being set
 -  Add WMI interface support on Lenovo platforms

thinkpad-lmi:
 -  Remove unused display_name member from struct tlmi_pwd_setting

thinkpad_acpi:
 -  Add X1 Carbon Gen 9 second fan support
 -  Fix inconsistent indenting

tools/power/x86/intel-speed-select:
 -  v1.10 release
 -  Fix uncore memory frequency display

toshiba_acpi:
 -  Fix missing error code in toshiba_acpi_setup_keyboard()

toshiba_haps:
 -  Fix missing newline in pr_debug call in toshiba_haps_notify

touchscreen_dmi:
 -  Fix Chuwi Hi10 Pro comment
 -  Add info for the Goodix GT912 panel of TM800A550L tablets
 -  Add an extra entry for the upside down Goodix touchscreen on Teclast X89 tablets

x86/platform/uv:
 -  Constify static attribute_group struct

----------------------------------------------------------------
Alexandru Ardelean (1):
      gpio: crystalcove: remove platform_set_drvdata() + cleanup probe

Andy Shevchenko (11):
      gpio: wcove: Use IRQ hardware number getter instead of direct access
      gpio: wcove: Unify style of to_reg() with to_ireg()
      gpio: wcove: Split error handling for CTRL and IRQ registers
      platform/x86: Remove "default n" entries
      platform/x86: intel_skl_int3472: Free ACPI device resources after use
      platform/x86: intel_skl_int3472: Fix dependencies (drop CLKDEV_LOOKUP)
      platform/x86: intel_skl_int3472: Use ACPI GPIO resource directly
      platform/x86: intel_skl_int3472: Provide skl_int3472_unregister_regulator()
      platform/x86: intel_skl_int3472: Provide skl_int3472_unregister_clock()
      platform/x86: intel_skl_int3472: Move to intel/ subfolder
      platform/x86: intel_cht_int33fe: Move to its own subfolder

Baokun Li (2):
      platform/surface: aggregator: Use list_move_tail instead of list_del/list_add_tail in ssh_request_layer.c
      platform/surface: aggregator: Use list_move_tail instead of list_del/list_add_tail in ssh_packet_layer.c

Colin Ian King (1):
      ACPI: scan: initialize local variable to avoid garbage being returned

Dan Carpenter (1):
      platform/x86: intel_skl_int3472: Uninitialized variable in skl_int3472_handle_gpio_resources()

Daniel Scally (6):
      gpiolib: acpi: Introduce acpi_get_and_request_gpiod() helper
      gpiolib: acpi: Add acpi_gpio_get_io_resource()
      ACPI: scan: Extend acpi_walk_dep_device_list()
      ACPI: scan: Add function to fetch dependent of ACPI device
      platform/x86: Add intel_skl_int3472 driver
      mfd: tps68470: Remove tps68470 MFD driver

Hans de Goede (18):
      Input: goodix - platform/x86: touchscreen_dmi - Move upside down quirks to touchscreen_dmi.c
      platform/x86: touchscreen_dmi: Add an extra entry for the upside down Goodix touchscreen on Teclast X89 tablets
      platform/x86: touchscreen_dmi: Add info for the Goodix GT912 panel of TM800A550L tablets
      platform/x86: intel_cht_int33fe: Correct "displayport" fwnode reference
      platform/x86: toshiba_haps: Fix missing newline in pr_debug call in toshiba_haps_notify
      platform/x86: ideapad-laptop: Ignore VPC event bit 10
      platform/x86: dell-wmi: Rename dell-wmi.c to dell-wmi-base.c
      platform/x86: touchscreen_dmi: Fix Chuwi Hi10 Pro comment
      platform/x86: thinkpad-lmi: Remove unused display_name member from struct tlmi_pwd_setting
      platform/x86: dell-wmi-sysman/think-lmi: Make fw_attr_class global static
      platform/x86: think-lmi: Fix check for admin password being set
      platform/x86: think-lmi: Avoid potential read before start of the buffer
      Merge tag 'platform-drivers-x86-goodix-v5.14-1' into review-hans
      Merge tag 'intel-gpio-v5.14-1' into review-hans
      Merge remote-tracking branch 'linux-pm/acpi-scan' into review-hans
      Merge tag 'devm-helpers-v5.14-1' into review-hans
      platform/x86: think-lmi: Return EINVAL when kbdlang gets set to a 0 length string
      platform/x86: think-lmi: Move kfree(setting->possible_values) to tlmi_attr_setting_release()

Jiapeng Chong (2):
      platform/x86: thinkpad_acpi: Fix inconsistent indenting
      platform/x86: toshiba_acpi: Fix missing error code in toshiba_acpi_setup_keyboard()

Luke D. Jones (2):
      platform/x86: asus-nb-wmi: Revert "Drop duplicate DMI quirk structures"
      platform/x86: asus-nb-wmi: Revert "add support for ASUS ROG Zephyrus G14 and G15"

Mario Limonciello (3):
      platform/x86: Rename hp-wireless to wireless-hotkey
      platform/x86: think-lmi: Fix issues with duplicate attributes
      platform/x86: think-lmi: Split current_value to reflect only the value

Mark Pearson (3):
      platform/x86: firmware_attributes_class: Create helper file for handling firmware-attributes class registration events
      platform/x86: dell-wmi-sysman: Use firmware_attributes_class helper
      platform/x86: think-lmi: Add WMI interface support on Lenovo platforms

Matti Vaittinen (5):
      devm-helpers: Add resource managed version of work init
      extcon: extcon-max14577: Fix potential work-queue cancellation race
      extcon: extcon-max77693.c: Fix potential work-queue cancellation race
      extcon: extcon-max8997: Fix IRQ freeing at error path
      extcon: extcon-max8997: Simplify driver using devm

Maximilian Luz (15):
      platform/surface: aggregator_registry: Update comments for 15" AMD Surface Laptop 4
      platform/surface: aggregator_registry: Add support for 13" Intel Surface Laptop 4
      platform/surface: aggregator_registry: Consolidate node groups for 5th- and 6th-gen devices
      platform/surface: aggregator: Fix event disable function
      platform/surface: dtx: Add missing mutex_destroy() call in failure path
      platform/surface: aggregator: Allow registering notifiers without enabling events
      platform/surface: aggregator: Allow enabling of events without notifiers
      platform/surface: aggregator: Update copyright
      platform/surface: aggregator_cdev: Add support for forwarding events to user-space
      platform/surface: aggregator_cdev: Allow enabling of events from user-space
      platform/surface: aggregator_cdev: Add lockdep support
      docs: driver-api: Update Surface Aggregator user-space interface documentation
      platform/surface: aggregator: Do not return uninitialized value
      platform/surface: aggregator: Drop unnecessary variable initialization
      MAINTAINERS: Update IRC link for Surface System Aggregator subsystem

Mykola Kostenok (1):
      platform/mellanox: mlxreg-hotplug: Revert "move to use request_irq by IRQF_NO_AUTOEN flag"

Perry Yuan (1):
      platform/x86: dell-privacy: Add support for Dell hardware privacy

Prasanth KSR (2):
      platform/x86: dell-wmi-sysman: Make populate_foo_data functions more robust
      platform/x86: dell-wmi-sysman: Change user experience when Admin/System Password is modified

Rafael J. Wysocki (1):
      ACPI: scan: Rearrange dep_unmet initialization

Rajneesh Bhardwaj (1):
      MAINTAINERS: Update info for telemetry

Rikard Falkeborn (4):
      platform/x86: hdaps: Constify static attribute_group struct
      platform/x86: intel_pmt_crashlog: Constify static attribute_group struct
      platform/x86: tc1100-wmi: Constify static attribute_group struct
      x86/platform/uv: Constify static attribute_group struct

Srinivas Pandruvada (4):
      tools/power/x86/intel-speed-select: Fix uncore memory frequency display
      tools/power/x86/intel-speed-select: v1.10 release
      platform/x86: ISST: Optimize CPU to PCI device mapping
      platform/x86: ISST: Use numa node id for cpu pci dev mapping

Til Jasper Ullrich (1):
      platform/x86: thinkpad_acpi: Add X1 Carbon Gen 9 second fan support

Wolfram Sang (2):
      platform/x86: samsung-laptop: use octal numbers for rwx file permissions
      platform/x86: samsung-laptop: set debugfs blobs to read only

Yang Li (1):
      platform/x86: dcdbas: drop unneeded assignment in host_control_smi()

Zou Wei (1):
      platform/x86: think-lmi: Add missing MODULE_DEVICE_TABLE

kernel test robot (1):
      platform/x86: dell-wmi-sysman: fw_attr_inuse can be static

yangerkun (1):
      platform/x86: intel_ips: fix set but unused warning in read_mgtv

 .../ABI/testing/sysfs-class-firmware-attributes    |  18 +-
 .../ABI/testing/sysfs-platform-dell-privacy-wmi    |  55 ++
 .../driver-api/surface_aggregator/clients/cdev.rst | 127 ++-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +-
 MAINTAINERS                                        |  25 +-
 drivers/acpi/ec.c                                  |   2 +-
 drivers/acpi/pmic/Kconfig                          |   2 +-
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c            |   2 +-
 drivers/acpi/scan.c                                | 164 ++--
 drivers/extcon/extcon-max14577.c                   |  16 +-
 drivers/extcon/extcon-max77693.c                   |  17 +-
 drivers/extcon/extcon-max8997.c                    |  45 +-
 drivers/gpio/Kconfig                               |   2 +-
 drivers/gpio/gpio-crystalcove.c                    |  10 +-
 drivers/gpio/gpio-wcove.c                          |  39 +-
 drivers/gpio/gpiolib-acpi.c                        |  61 +-
 drivers/i2c/i2c-core-acpi.c                        |   8 +-
 drivers/input/touchscreen/goodix.c                 |  52 --
 drivers/mfd/Kconfig                                |  18 -
 drivers/mfd/Makefile                               |   1 -
 drivers/mfd/tps68470.c                             |  97 ---
 drivers/platform/mellanox/mlxreg-hotplug.c         |   4 +-
 drivers/platform/surface/aggregator/Kconfig        |   2 +-
 drivers/platform/surface/aggregator/Makefile       |   2 +-
 drivers/platform/surface/aggregator/bus.c          |   2 +-
 drivers/platform/surface/aggregator/bus.h          |   2 +-
 drivers/platform/surface/aggregator/controller.c   | 334 ++++++--
 drivers/platform/surface/aggregator/controller.h   |   2 +-
 drivers/platform/surface/aggregator/core.c         |   8 +-
 drivers/platform/surface/aggregator/ssh_msgb.h     |   2 +-
 .../platform/surface/aggregator/ssh_packet_layer.c |  12 +-
 .../platform/surface/aggregator/ssh_packet_layer.h |   2 +-
 drivers/platform/surface/aggregator/ssh_parser.c   |   2 +-
 drivers/platform/surface/aggregator/ssh_parser.h   |   2 +-
 .../surface/aggregator/ssh_request_layer.c         |  12 +-
 .../surface/aggregator/ssh_request_layer.h         |   2 +-
 drivers/platform/surface/aggregator/trace.h        |   2 +-
 drivers/platform/surface/surface3_power.c          |  22 +-
 drivers/platform/surface/surface_acpi_notify.c     |   7 +-
 drivers/platform/surface/surface_aggregator_cdev.c | 534 +++++++++++-
 .../platform/surface/surface_aggregator_registry.c |  54 +-
 drivers/platform/surface/surface_dtx.c             |   1 +
 drivers/platform/x86/Kconfig                       |  49 +-
 drivers/platform/x86/Makefile                      |  10 +-
 drivers/platform/x86/asus-nb-wmi.c                 |  77 --
 drivers/platform/x86/dell/Kconfig                  |  11 +-
 drivers/platform/x86/dell/Makefile                 |   2 +
 drivers/platform/x86/dell/dcdbas.c                 |   3 +-
 drivers/platform/x86/dell/dell-laptop.c            |  13 +-
 .../x86/dell/{dell-wmi.c => dell-wmi-base.c}       |  14 +-
 drivers/platform/x86/dell/dell-wmi-privacy.c       | 391 +++++++++
 drivers/platform/x86/dell/dell-wmi-privacy.h       |  36 +
 .../x86/dell/dell-wmi-sysman/dell-wmi-sysman.h     |   5 +-
 .../x86/dell/dell-wmi-sysman/enum-attributes.c     |  39 +-
 .../x86/dell/dell-wmi-sysman/int-attributes.c      |  16 +
 .../x86/dell/dell-wmi-sysman/passobj-attributes.c  |   6 +
 .../dell/dell-wmi-sysman/passwordattr-interface.c  |   4 +-
 .../x86/dell/dell-wmi-sysman/string-attributes.c   |  16 +-
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |  21 +-
 drivers/platform/x86/firmware_attributes_class.c   |  52 ++
 drivers/platform/x86/firmware_attributes_class.h   |  11 +
 drivers/platform/x86/hdaps.c                       |   2 +-
 drivers/platform/x86/hp-wireless.c                 | 102 ---
 drivers/platform/x86/ideapad-laptop.c              |  12 +
 drivers/platform/x86/intel/Kconfig                 |  22 +
 drivers/platform/x86/intel/Makefile                |   8 +
 drivers/platform/x86/intel/int33fe/Kconfig         |  24 +
 drivers/platform/x86/intel/int33fe/Makefile        |   5 +
 .../{ => intel/int33fe}/intel_cht_int33fe_common.c |   0
 .../{ => intel/int33fe}/intel_cht_int33fe_common.h |   0
 .../{ => intel/int33fe}/intel_cht_int33fe_microb.c |   0
 .../{ => intel/int33fe}/intel_cht_int33fe_typec.c  |   4 +-
 drivers/platform/x86/intel/int3472/Kconfig         |  30 +
 drivers/platform/x86/intel/int3472/Makefile        |   5 +
 .../int3472/intel_skl_int3472_clk_and_regulator.c  | 207 +++++
 .../x86/intel/int3472/intel_skl_int3472_common.c   | 106 +++
 .../x86/intel/int3472/intel_skl_int3472_common.h   | 122 +++
 .../x86/intel/int3472/intel_skl_int3472_discrete.c | 413 ++++++++++
 .../x86/intel/int3472/intel_skl_int3472_tps68470.c | 137 ++++
 drivers/platform/x86/intel_ips.c                   |   2 +-
 drivers/platform/x86/intel_pmt_crashlog.c          |   2 +-
 .../x86/intel_speed_select_if/isst_if_common.c     |  73 +-
 drivers/platform/x86/samsung-laptop.c              |  35 +-
 drivers/platform/x86/tc1100-wmi.c                  |   2 +-
 drivers/platform/x86/think-lmi.c                   | 904 +++++++++++++++++++++
 drivers/platform/x86/think-lmi.h                   |  72 ++
 drivers/platform/x86/thinkpad_acpi.c               |   3 +-
 drivers/platform/x86/toshiba_acpi.c                |   1 +
 drivers/platform/x86/toshiba_haps.c                |   2 +-
 drivers/platform/x86/touchscreen_dmi.c             |  87 +-
 drivers/platform/x86/uv_sysfs.c                    |   4 +-
 drivers/platform/x86/wireless-hotkey.c             | 103 +++
 include/acpi/acpi_bus.h                            |   8 +
 include/linux/acpi.h                               |  11 +-
 include/linux/devm-helpers.h                       |  25 +
 include/linux/gpio/consumer.h                      |   2 +
 include/linux/surface_aggregator/controller.h      |  27 +-
 include/linux/surface_aggregator/device.h          |   2 +-
 include/linux/surface_aggregator/serial_hub.h      |   2 +-
 include/uapi/linux/surface_aggregator/cdev.h       |  73 +-
 tools/power/x86/intel-speed-select/isst-config.c   |  18 +-
 tools/power/x86/intel-speed-select/isst-core.c     |  15 +
 tools/power/x86/intel-speed-select/isst-display.c  |   2 +-
 tools/power/x86/intel-speed-select/isst.h          |   2 +
 104 files changed, 4449 insertions(+), 776 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
 delete mode 100644 drivers/mfd/tps68470.c
 rename drivers/platform/x86/dell/{dell-wmi.c => dell-wmi-base.c} (98%)
 create mode 100644 drivers/platform/x86/dell/dell-wmi-privacy.c
 create mode 100644 drivers/platform/x86/dell/dell-wmi-privacy.h
 create mode 100644 drivers/platform/x86/firmware_attributes_class.c
 create mode 100644 drivers/platform/x86/firmware_attributes_class.h
 delete mode 100644 drivers/platform/x86/hp-wireless.c
 create mode 100644 drivers/platform/x86/intel/Kconfig
 create mode 100644 drivers/platform/x86/intel/Makefile
 create mode 100644 drivers/platform/x86/intel/int33fe/Kconfig
 create mode 100644 drivers/platform/x86/intel/int33fe/Makefile
 rename drivers/platform/x86/{ => intel/int33fe}/intel_cht_int33fe_common.c (100%)
 rename drivers/platform/x86/{ => intel/int33fe}/intel_cht_int33fe_common.h (100%)
 rename drivers/platform/x86/{ => intel/int33fe}/intel_cht_int33fe_microb.c (100%)
 rename drivers/platform/x86/{ => intel/int33fe}/intel_cht_int33fe_typec.c (99%)
 create mode 100644 drivers/platform/x86/intel/int3472/Kconfig
 create mode 100644 drivers/platform/x86/intel/int3472/Makefile
 create mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_clk_and_regulator.c
 create mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_common.c
 create mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_common.h
 create mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_discrete.c
 create mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
 create mode 100644 drivers/platform/x86/think-lmi.c
 create mode 100644 drivers/platform/x86/think-lmi.h
 create mode 100644 drivers/platform/x86/wireless-hotkey.c

