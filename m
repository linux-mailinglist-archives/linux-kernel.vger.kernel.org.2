Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61156443172
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 16:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhKBPW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 11:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231437AbhKBPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635866421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vNSUC75MW3Rag4yi3yU5sdzZ16qiIKBSUKnsbLPnd9A=;
        b=WRmSydJ/GH3J6WScJ/eUgqxISgq+ZyF8cGOKmVZGFtCS5JAj7h9dADu1BbrJRkszpvPnC2
        XR0LGRG2st7MZmXGNKF6YNfa7Shym8HFMVQvs7HR2Fhq8pUL0WWO7uDAlI1QlFlGUoii2V
        EB6R0rT5QDaHFw2n1iZJVgn2qGHdniA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-nMEQzN1dMq-tZoM2TQ_yUA-1; Tue, 02 Nov 2021 11:20:20 -0400
X-MC-Unique: nMEQzN1dMq-tZoM2TQ_yUA-1
Received: by mail-ed1-f71.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so19152682edv.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 08:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=vNSUC75MW3Rag4yi3yU5sdzZ16qiIKBSUKnsbLPnd9A=;
        b=Pr7v+ExOz+8f8ytpDL0IMXUdTRXcxVbLD4VHi8aK9AwxqJyt2UYenRMeKNMfG2Z/lD
         SnAo/KgrZbjWpjmLg+WQCCXb6GHRYdBisAtSbWZkc1tfI2I5wxXM+crNU9Yk0BcmsmvA
         ODVQ8dCaD4anBv2HfBomEa969fGZiEpkkkThhgE8K82PPC+8VzJWFWnP88LTLwprjCly
         cc8j2WQ+dCVefkrUBeg5qJdMRpysHtpRFm0IixRD4UWAtWaypB6cVM7aJ+sbg7vwvDMU
         gdrruJm6WQ4wb/1Ub1JbVx1Jyp8BTASHTJ+h85sRmj1TTLE+wrhmX/l3dVbefTAfOLG4
         0Dag==
X-Gm-Message-State: AOAM532roMnR/bg9IO9qvonW7ilyyL1Hz47+qxbR+JxycIQCdNwjx2Gl
        scNuiwXNZT0OPu+RbWuT59LHJ3sooJvPKZUEquEXtGhRhXkwqhfluKpjle+GgfnpojxDdyVYcdx
        TABpTrXikape+hTFzX71blGwx
X-Received: by 2002:a05:6402:278e:: with SMTP id b14mr2843757ede.321.1635866418793;
        Tue, 02 Nov 2021 08:20:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHCjfEx5NHO1IAzV8rkJ3vJryBbZxyK2niJ3+JBFuv/kssLByIFx6IBYrDcbsd6AHk1euAdg==
X-Received: by 2002:a05:6402:278e:: with SMTP id b14mr2843720ede.321.1635866418476;
        Tue, 02 Nov 2021 08:20:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e19sm11340396edz.53.2021.11.02.08.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 08:20:18 -0700 (PDT)
Message-ID: <34147942-cc36-29ae-02ed-226bd3a56bec@redhat.com>
Date:   Tue, 2 Nov 2021 16:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.16-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.16.

Highlights:
 - AMD-PMC S0ix support fixes and improvements
 - HP-WMI support for Omen laptops
 - New nvidia-wmi-ec-backlight driver
 - New Intel ISH ECLITE driver
 - WMI core cleanups
 - Support for various new Melanox platforms
 - System76 Laptop support improvements
 - Surface Laptop Studio support and initial Surface Pro 8 support
 - Various other small fixes and hardware-id additions

Regards,

Hans


The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-1

for you to fetch changes up to 97ae45953ea957887170078f488fd629dd1ce786:

  platform/x86: system76_acpi: Fix input device error handling (2021-11-02 11:23:55 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.16-1

Highlights:
 - AMD-PMC S0ix support fixes and improvements
 - HP-WMI support for Omen laptops
 - New nvidia-wmi-ec-backlight driver
 - New Intel ISH ECLITE driver
 - WMI core cleanups
 - Support for various new Melanox platforms
 - System76 Laptop support improvements
 - Surface Laptop Studio support and initial Surface Pro 8 support
 - Various other small fixes and hardware-id additions

The following is an automated git shortlog grouped by driver:

ABI:
 -  sysfs-platform-intel-pmc: add blank lines to make it valid for ReST
 -  sysfs-platform-dell-privacy-wmi: correct ABI entries

ASoC:
 -  Intel: Move soc_intel_is_foo() helpers to a generic header

Add Intel ishtp eclite driver:
 - Add Intel ishtp eclite driver

Add driver for ACPI WMAA EC-based backlight control:
 - Add driver for ACPI WMAA EC-based backlight control

Documentation/ABI:
 -  Add new line card attributes for mlxreg-io sysfs interfaces
 -  Add new attributes for mlxreg-io sysfs interfaces

HID:
 -  surface-hid: Allow driver matching for target ID 1 devices
 -  surface-hid: Use correct event registry for managing HID events

Input:
 -  axp20x-pek - Use new soc_intel_is_cht() helper

Remove "WMAA" from identifier names in wmaa-backlight-wmi.c:
 - Remove "WMAA" from identifier names in wmaa-backlight-wmi.c

Rename wmaa-backlight-wmi to nvidia-wmi-ec-backlight:
 - Rename wmaa-backlight-wmi to nvidia-wmi-ec-backlight

Support for EC-connected GPIOs for identify LED/button on Barco P50 board:
 - Support for EC-connected GPIOs for identify LED/button on Barco P50 board

acer-wmi:
 -  use __packed instead of __attribute__((packed))

amd-pmc:
 -  Drop check for valid alarm time
 -  Downgrade dev_info message to dev_dbg
 -  fix compilation without CONFIG_RTC_SYSTOHC_DEVICE
 -  Add special handling for timer based S0i3 wakeup
 -  adjust arguments for `amd_pmc_send_cmd`
 -  Add alternative acpi id for PMC controller
 -  Add a message to print resume time info
 -  Send command to dump data after clearing OS_HINT
 -  Fix compilation when CONFIG_DEBUGFS is disabled
 -  Export Idlemask values based on the APU
 -  Check s0i3 cycle status
 -  Increase the response register timeout

asus-wmi:
 -  rename platform_profile_* function symbols

barco-p50-gpio:
 -  use KEY_VENDOR for button instead of KEY_RESTART

dell:
 -  Make DELL_WMI_PRIVACY depend on DELL_WMI
 -  fix DELL_WMI_PRIVACY dependencies & build error

dell-wmi:
 -  Recognise or support new switches

docs:
 -  ABI: fix documentation warning in sysfs-driver-mlxreg-io

gigabyte-wmi:
 -  add support for B550 AORUS ELITE AX V2
 -  add support for B550I Aorus Pro AX

hp-wmi:
 -  rename platform_profile_* function symbols
 -  add support for omen laptops

ideapad-laptop:
 -  Add platform support for Ideapad 5 Pro 16ACH6-82L5

int1092:
 -  Fix non sequential device mode handling

intel_int0002_vgpio:
 -  Use the new soc_intel_is_byt()/_cht() helpers

intel_scu_ipc:
 -  Update timeout value in comment
 -  Increase virtual timeout to 10s
 -  Fix busy loop expiry time

intel_skl_int3472:
 -  Correct null check

lg-laptop:
 -  replace snprintf in show functions with sysfs_emit
 -  Correctly handle dmi_get_system_info() returning NULL

mlx-platform:
 -  Add support for new system SGN2410
 -  Add BIOS attributes for CoffeeLake COMEx based systems
 -  Extend FAN and LED configuration to support new MQM97xx systems
 -  Add support for multiply cooling devices
 -  Configure notifier callbacks for modular system
 -  Add initial support for new modular system

panasonic-laptop:
 -  Replace snprintf in show functions with sysfs_emit

platform:
 -  x86: ideapad-laptop: Use ACPI_COMPANION() directly
 -  lg-laptop: drop unneeded MODULE_ALIAS

platform/mellanox:
 -  mlxreg-lc: Add initial support for Nvidia line card devices
 -  mlxreg-io: Extend number of hwmon attributes
 -  mlxreg-hotplug: Extend logic for hotplug devices operations
 -  mlxreg-io: Fix read access of n-bytes size attributes
 -  mlxreg-io: Fix argument base in kstrtou32() call

platform/surface:
 -  aggregator_registry: Add initial support for Surface Pro 8
 -  aggregator_registry: Add support for Surface Laptop Studio
 -  gpe: Add support for Surface Laptop Studio

platform/x86/intel:
 -  hid: Add DMI switches allow list
 -  punit_ipc: Drop wrong use of ACPI_PTR()

platform_data/mlxreg:
 -  Add new field for secured access
 -  Add new type to support modular systems

sony-laptop:
 -  replace snprintf in show functions with sysfs_emit

surface:
 -  surface3_power: Drop redundant acpi_bus_get_device() call
 -  surface3-wmi: Use ACPI_COMPANION() directly

system76_acpi:
 -  Fix input device error handling
 -  fix Kconfig dependencies
 -  Add attribute group for kb_led_color
 -  Add battery charging thresholds
 -  Replace Fn+F2 function for OLED models
 -  Report temperature and fan speed

thinkpad_acpi:
 -  Fix bitwise vs. logical warning
 -  Fix coccinelle warnings
 -  Switch to common use of attributes

touchscreen_dmi:
 -  Add info for the Viglen Connect 10 tablet
 -  Update info for the Chuwi Hi10 Plus (CWI527) tablet
 -  Add info for the Chuwi HiBook (CWI514) tablet

update email addresses. Change all email addresses for Mark Gross to use markgross@kernel.org.:
 - update email addresses. Change all email addresses for Mark Gross to use markgross@kernel.org.

wmi:
 -  change notification handler type
 -  more detailed error reporting in find_guid()
 -  introduce helper to retrieve event data
 -  introduce helper to determine type
 -  introduce helper to generate method names
 -  introduce helper to convert driver to WMI driver
 -  simplify error handling logic
 -  do not fail if disabling fails
 -  improve debug messages
 -  align arguments of functions
 -  move variables
 -  remove variable
 -  use sizeof(*p) in allocation
 -  use !p to check for NULL
 -  use sysfs_emit()
 -  make GUID block packed
 -  use guid_t and guid_equal()
 -  use bool instead of int
 -  use BIT() macro
 -  remove unnecessary checks
 -  remove stray empty line
 -  remove unnecessary casts
 -  remove unnecessary argument
 -  remove unnecessary variable
 -  remove unnecessary initializations
 -  remove unnecessary initialization
 -  remove commas
 -  fix checkpatch warnings
 -  fix kernel doc

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/x86/intel: punit_ipc: Drop wrong use of ACPI_PTR()

Arnd Bergmann (1):
      platform/x86: system76_acpi: fix Kconfig dependencies

Barnabás Pőcze (28):
      platform/x86: wmi: fix kernel doc
      platform/x86: wmi: fix checkpatch warnings
      platform/x86: wmi: remove commas
      platform/x86: wmi: remove unnecessary initialization
      platform/x86: wmi: remove unnecessary initializations
      platform/x86: wmi: remove unnecessary variable
      platform/x86: wmi: remove unnecessary argument
      platform/x86: wmi: remove unnecessary casts
      platform/x86: wmi: remove stray empty line
      platform/x86: wmi: remove unnecessary checks
      platform/x86: wmi: use BIT() macro
      platform/x86: wmi: use bool instead of int
      platform/x86: wmi: use guid_t and guid_equal()
      platform/x86: wmi: make GUID block packed
      platform/x86: wmi: use sysfs_emit()
      platform/x86: wmi: use !p to check for NULL
      platform/x86: wmi: use sizeof(*p) in allocation
      platform/x86: wmi: remove variable
      platform/x86: wmi: move variables
      platform/x86: wmi: align arguments of functions
      platform/x86: wmi: improve debug messages
      platform/x86: wmi: do not fail if disabling fails
      platform/x86: wmi: simplify error handling logic
      platform/x86: wmi: introduce helper to convert driver to WMI driver
      platform/x86: wmi: introduce helper to generate method names
      platform/x86: wmi: introduce helper to determine type
      platform/x86: wmi: introduce helper to retrieve event data
      platform/x86: wmi: more detailed error reporting in find_guid()

Daniel Dadap (3):
      platform/x86: Add driver for ACPI WMAA EC-based backlight control
      platform/x86: Remove "WMAA" from identifier names in wmaa-backlight-wmi.c
      platform/x86: Rename wmaa-backlight-wmi to nvidia-wmi-ec-backlight

Daniel Scally (1):
      platform/x86: intel_skl_int3472: Correct null check

Enver Balalic (1):
      platform/x86: hp-wmi: add support for omen laptops

Hans de Goede (7):
      platform/x86: touchscreen_dmi: Add info for the Chuwi HiBook (CWI514) tablet
      platform/x86: touchscreen_dmi: Update info for the Chuwi Hi10 Plus (CWI527) tablet
      platform/x86: amd-pmc: Fix compilation when CONFIG_DEBUGFS is disabled
      platform/x86: dell: Make DELL_WMI_PRIVACY depend on DELL_WMI
      ASoC: Intel: Move soc_intel_is_foo() helpers to a generic header
      platform/x86: intel_int0002_vgpio: Use the new soc_intel_is_byt()/_cht() helpers
      Input: axp20x-pek - Use new soc_intel_is_cht() helper

Jeremy Soller (2):
      platform/x86: system76_acpi: Report temperature and fan speed
      platform/x86: system76_acpi: Replace Fn+F2 function for OLED models

Jonathan Corbet (1):
      docs: ABI: fix documentation warning in sysfs-driver-mlxreg-io

José Expósito (1):
      platform/x86/intel: hid: Add DMI switches allow list

Jules Irenge (1):
      platform/x86: acer-wmi: use __packed instead of __attribute__((packed))

K Naduvalath, Sumesh (1):
      platform/x86: Add Intel ishtp eclite driver

Kelly Anderson (1):
      platform/x86: ideapad-laptop: Add platform support for Ideapad 5 Pro 16ACH6-82L5

Krzysztof Kozlowski (1):
      platform: lg-laptop: drop unneeded MODULE_ALIAS

Len Baker (1):
      platform/x86: thinkpad_acpi: Switch to common use of attributes

Mario Limonciello (8):
      platform/x86: amd-pmc: Increase the response register timeout
      platform/x86: amd-pmc: adjust arguments for `amd_pmc_send_cmd`
      platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup
      platform/x86: amd-pmc: fix compilation without CONFIG_RTC_SYSTOHC_DEVICE
      platform/x86: amd-pmc: Downgrade dev_info message to dev_dbg
      platform/x86: amd-pmc: Drop check for valid alarm time
      platform/x86: hp-wmi: rename platform_profile_* function symbols
      platform/x86: asus-wmi: rename platform_profile_* function symbols

Mark Gross (1):
      update email addresses. Change all email addresses for Mark Gross to use markgross@kernel.org.

Mark Stamp (1):
      platform/x86: touchscreen_dmi: Add info for the Viglen Connect 10 tablet

Matan Ziv-Av (1):
      lg-laptop: Correctly handle dmi_get_system_info() returning NULL

Mauro Carvalho Chehab (2):
      ABI: sysfs-platform-dell-privacy-wmi: correct ABI entries
      ABI: sysfs-platform-intel-pmc: add blank lines to make it valid for ReST

Maximilian Luz (5):
      platform/surface: gpe: Add support for Surface Laptop Studio
      platform/surface: aggregator_registry: Add support for Surface Laptop Studio
      HID: surface-hid: Use correct event registry for managing HID events
      HID: surface-hid: Allow driver matching for target ID 1 devices
      platform/surface: aggregator_registry: Add initial support for Surface Pro 8

Mikalai Ramanovich (1):
      platform/x86: wmi: change notification handler type

Nathan Chancellor (1):
      platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning

Peter Korsgaard (1):
      platform/x86: barco-p50-gpio: use KEY_VENDOR for button instead of KEY_RESTART

Prashant Malani (3):
      platform/x86: intel_scu_ipc: Fix busy loop expiry time
      platform/x86: intel_scu_ipc: Increase virtual timeout to 10s
      platform/x86: intel_scu_ipc: Update timeout value in comment

Qing Wang (1):
      platform/x86: panasonic-laptop: Replace snprintf in show functions with sysfs_emit

Rafael J. Wysocki (3):
      surface: surface3-wmi: Use ACPI_COMPANION() directly
      surface: surface3_power: Drop redundant acpi_bus_get_device() call
      platform: x86: ideapad-laptop: Use ACPI_COMPANION() directly

Randy Dunlap (1):
      platform/x86: dell: fix DELL_WMI_PRIVACY dependencies & build error

Sachi King (1):
      platform/x86: amd-pmc: Add alternative acpi id for PMC controller

Sanket Goswami (4):
      platform/x86: amd-pmc: Check s0i3 cycle status
      platform/x86: amd-pmc: Export Idlemask values based on the APU
      platform/x86: amd-pmc: Send command to dump data after clearing OS_HINT
      platform/x86: amd-pmc: Add a message to print resume time info

Santosh Kumar Yadav (1):
      platform/x86: Support for EC-connected GPIOs for identify LED/button on Barco P50 board

Shravan S (1):
      platform/x86: int1092: Fix non sequential device mode handling

Tim Crawford (3):
      platform/x86: system76_acpi: Add battery charging thresholds
      platform/x86: system76_acpi: Add attribute group for kb_led_color
      platform/x86: system76_acpi: Fix input device error handling

Tobias Jakobi (1):
      platform/x86: gigabyte-wmi: add support for B550I Aorus Pro AX

Troy Rollo (1):
      platform/x86: dell-wmi: Recognise or support new switches

Vadim Pasternak (15):
      platform/mellanox: mlxreg-io: Fix argument base in kstrtou32() call
      platform/mellanox: mlxreg-io: Fix read access of n-bytes size attributes
      platform_data/mlxreg: Add new type to support modular systems
      platform/x86: mlx-platform: Add initial support for new modular system
      platform/mellanox: mlxreg-hotplug: Extend logic for hotplug devices operations
      platform/x86: mlx-platform: Configure notifier callbacks for modular system
      platform/mellanox: mlxreg-io: Extend number of hwmon attributes
      platform_data/mlxreg: Add new field for secured access
      platform/mellanox: mlxreg-lc: Add initial support for Nvidia line card devices
      Documentation/ABI: Add new attributes for mlxreg-io sysfs interfaces
      Documentation/ABI: Add new line card attributes for mlxreg-io sysfs interfaces
      platform/x86: mlx-platform: Add support for multiply cooling devices
      platform/x86: mlx-platform: Extend FAN and LED configuration to support new MQM97xx systems
      platform/x86: mlx-platform: Add BIOS attributes for CoffeeLake COMEx based systems
      platform/x86: mlx-platform: Add support for new system SGN2410

Ye Guojin (3):
      platform/x86: thinkpad_acpi: Fix coccinelle warnings
      platform/x86: lg-laptop: replace snprintf in show functions with sysfs_emit
      platform/x86: sony-laptop: replace snprintf in show functions with sysfs_emit

Zephaniah E. Loss-Cutler-Hull (1):
      platform/x86: gigabyte-wmi: add support for B550 AORUS ELITE AX V2

 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |  244 ++
 .../ABI/testing/sysfs-platform-dell-privacy-wmi    |   60 +-
 Documentation/ABI/testing/sysfs-platform-intel-pmc |    2 +
 MAINTAINERS                                        |   30 +-
 drivers/hid/surface-hid/surface_hid.c              |    4 +-
 drivers/input/misc/axp20x-pek.c                    |   26 +-
 drivers/platform/mellanox/Kconfig                  |   12 +
 drivers/platform/mellanox/Makefile                 |    1 +
 drivers/platform/mellanox/mlxreg-hotplug.c         |  123 +-
 drivers/platform/mellanox/mlxreg-io.c              |    6 +-
 drivers/platform/mellanox/mlxreg-lc.c              |  906 ++++++++
 drivers/platform/surface/surface3-wmi.c            |    9 +-
 drivers/platform/surface/surface3_power.c          |    3 +-
 .../platform/surface/surface_aggregator_registry.c |   66 +
 drivers/platform/surface/surface_gpe.c             |   13 +
 drivers/platform/x86/Kconfig                       |   29 +
 drivers/platform/x86/Makefile                      |    4 +
 drivers/platform/x86/acer-wmi.c                    |   14 +-
 drivers/platform/x86/amd-pmc.c                     |  155 +-
 drivers/platform/x86/asus-wmi.c                    |   12 +-
 drivers/platform/x86/barco-p50-gpio.c              |  436 ++++
 drivers/platform/x86/dell/Kconfig                  |    2 +-
 drivers/platform/x86/dell/dell-wmi-base.c          |   76 +-
 drivers/platform/x86/gigabyte-wmi.c                |    2 +
 drivers/platform/x86/hp-wmi.c                      |  337 ++-
 drivers/platform/x86/ideapad-laptop.c              |   35 +-
 drivers/platform/x86/intel/Kconfig                 |   16 +
 drivers/platform/x86/intel/Makefile                |    1 +
 drivers/platform/x86/intel/hid.c                   |   27 +-
 drivers/platform/x86/intel/int0002_vgpio.c         |   14 +-
 drivers/platform/x86/intel/int1092/intel_sar.c     |   23 +-
 .../x86/intel/int3472/intel_skl_int3472_discrete.c |    2 +-
 drivers/platform/x86/intel/ishtp_eclite.c          |  701 ++++++
 drivers/platform/x86/intel/punit_ipc.c             |    3 +-
 drivers/platform/x86/intel_scu_ipc.c               |    6 +-
 drivers/platform/x86/lg-laptop.c                   |   13 +-
 drivers/platform/x86/mlx-platform.c                | 2420 ++++++++++++++++++--
 drivers/platform/x86/nvidia-wmi-ec-backlight.c     |  213 ++
 drivers/platform/x86/panasonic-laptop.c            |   18 +-
 drivers/platform/x86/sony-laptop.c                 |   46 +-
 drivers/platform/x86/system76_acpi.c               |  427 +++-
 drivers/platform/x86/thinkpad_acpi.c               |  195 +-
 drivers/platform/x86/touchscreen_dmi.c             |   79 +-
 drivers/platform/x86/wmi.c                         |  375 +--
 include/linux/platform_data/mlxreg.h               |   82 +
 include/linux/platform_data/x86/soc.h              |   65 +
 include/linux/surface_aggregator/controller.h      |    4 +-
 sound/soc/intel/common/soc-intel-quirks.h          |   51 +-
 48 files changed, 6534 insertions(+), 854 deletions(-)
 create mode 100644 drivers/platform/mellanox/mlxreg-lc.c
 create mode 100644 drivers/platform/x86/barco-p50-gpio.c
 create mode 100644 drivers/platform/x86/intel/ishtp_eclite.c
 create mode 100644 drivers/platform/x86/nvidia-wmi-ec-backlight.c
 create mode 100644 include/linux/platform_data/x86/soc.h

