Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3C36B093
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhDZJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232078AbhDZJbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619429469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GyNP8taae2usABxJziJb6TIx8R8LGFZ5dWEUBPf40hY=;
        b=H5tXjyEKEZ4C93dJ28KgxXaccplVb5ArmOQIy7VCY8yJq8tpIOxxK/jRIzi5+hI16POWIQ
        un8TlfGyL0I470vBzLLR6POkZAQKlA83GFMWSRPpVT05QwFOGScYX9yNd1cmsyAVa4QM9T
        ZIL5FJWqJ0Q+bndeFtBLaocc9d7rCrU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-DaD59NoiM2W7Tm19fchwBw-1; Mon, 26 Apr 2021 05:31:07 -0400
X-MC-Unique: DaD59NoiM2W7Tm19fchwBw-1
Received: by mail-ed1-f69.google.com with SMTP id c13-20020a05640227cdb0290385526e5de5so12598170ede.21
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GyNP8taae2usABxJziJb6TIx8R8LGFZ5dWEUBPf40hY=;
        b=SyjKvTpKcu8w5oOiCOccB3wBDverXN97rp1WHcQxJ8qlZcvS1Rid4faKQHw8ehzjmc
         VqIOgGwdqViE2xoxoIH4Ccc/YWv/76lH5HsQqQr4iRmlF3BvZtV/efssmadr4rU5g6tI
         XURc6z75db54dQwb083djuLshrXkTAsPFWlZ5/Y0Nko7J3bGdIwpK3Qujm896AGy91p8
         FSExAyMp/NlIYvN3XLHcYgh0ErrjUdVlra43aJ5Z/Ed5jtVwGRcPhXrOkLUu6tJP2PI8
         GtNVdinE3Ux4d0EWfT4TZkBziMoeU1uMqYg5ET9bnxMFi1AdDjOY+4PjYN3I+L/pk0EL
         aBOw==
X-Gm-Message-State: AOAM533/Zfog+aJV85kmgq8tQdUrH7ucFchNkoIx4hXM1M5MI4LZ1409
        S8H8aeCnlpXDeAy7OQzNtKFvodkQgmYHjxYidHSUzxgNxXcvAAJhgz21cx2aUFasczT1cialsg9
        T6Q4o3GtcYSNgqEo3dlBkHW2X8mrxzexAht8WGiKR1ikKRXsGnlSLnkO05OXWecE0HWYhFn0mg5
        WA
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr20241600eds.166.1619429465773;
        Mon, 26 Apr 2021 02:31:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQODRgHHXheJGbwE/ClFSbHwXkld0KnSqkW7j5xZEOR9vDWZJyqS91FHD2SLMoNmg7hyZKUw==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr20241569eds.166.1619429465502;
        Mon, 26 Apr 2021 02:31:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id mm8sm11192257ejb.28.2021.04.26.02.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 02:31:05 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.13-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <9f212b4e-c153-8c68-15da-9474c41e0769@redhat.com>
Date:   Mon, 26 Apr 2021 11:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.13.

Highlights:
 - Lots of Microsoft Surface work
 - platform-profile support for HP and Microsoft Surface devices
 - New WMI Gigabyte motherboard temperature monitoring driver
 - Intel PMC improvements for Tiger Lake and Alder Lake
 - Misc. bugfixes, improvements and quirk additions all over

Some notes about merging this. Due to fixes which have landed in master post
5.12-rc2 + further work done in my for-next branch there are conflicts in:

  drivers/platform/x86/thinkpad_acpi.c
  drivers/platform/x86/intel_pmc_core.c

in both cases the conflicts can be solved by taking the version of the files
from this pull-req.

A note about the drivers/platform/x86/intel_pmc_core.c conflict. After
merging this blurb around line 1690 of drivers/platform/x86/intel_pmc_core.c :
   
        /*
         * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
         * a cable is attached. Tell the PMC to ignore it.
         */
        if (pmcdev->map == &tgl_reg_map) {
                dev_dbg(&pdev->dev, "ignoring GBE LTR\n");
                pmc_core_send_ltr_ignore(pmcdev, 3);
        }

will show up twice in the file after the merge once with:

                pmc_core_send_ltr_ignore(pmcdev, 3);

and once as:

                pmc_core_send_ltr_ignore(3);

The first one is the correct one.

Regards,

Hans


The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.13-1

for you to fetch changes up to e7882cd7aebe0696fbe178df1f30257e5729fdda:

  platform/x86: gigabyte-wmi: add support for B550M AORUS PRO-P (2021-04-23 19:18:35 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.13-1

Highlights:
 - Lots of Microsoft Surface work
 - platform-profile support for HP and Microsoft Surface devices
 - New WMI Gigabyte motherboard temperature monitoring driver
 - Intel PMC improvements for Tiger Lake and Alder Lake
 - Misc. bugfixes, improvements and quirk additions all over

The following is an automated git shortlog grouped by driver:

Add support for DYTC MMC_GET BIOS API.:
 - Add support for DYTC MMC_GET BIOS API.

Adjust Dell drivers to a personal email address:
 - Adjust Dell drivers to a personal email address

Fix typo in Kconfig:
 - Fix typo in Kconfig

ISST:
 -  Account for increased timeout in some cases

MAINTAINERS:
 -  Add missing section for alienware-wmi driver
 -  Adjust Dell drivers to email alias
 -  update MELLANOX HARDWARE PLATFORM SUPPORT maintainers

Merge tag 'ib-mfd-platform-x86-v5.13' into review-hans:
 - Merge tag 'ib-mfd-platform-x86-v5.13' into review-hans

Merge tag 'irq-no-autoen-2021-03-25' into review-hans:
 - Merge tag 'irq-no-autoen-2021-03-25' into review-hans

Typo fix in the file classmate-laptop.c:
 - Typo fix in the file classmate-laptop.c

add Gigabyte WMI temperature driver:
 - add Gigabyte WMI temperature driver

add support for Advantech software defined button:
 - add support for Advantech software defined button

asus-laptop:
 -  fix kobj_to_dev.cocci warnings

asus-wmi:
 -  Add param to turn fn-lock mode on by default

dell-wmi-sysman:
 -  Make init_bios_attributes() ACPI object parsing more robust
 -  Cleanup create_attributes_level_sysfs_files()
 -  Make sysman_init() return -ENODEV of the interfaces are not found
 -  Cleanup sysman_init() error-exit handling
 -  Fix release_attributes_data() getting called twice on init_bios_attributes() failure
 -  Make it safe to call exit_foo_attributes() multiple times
 -  Fix possible NULL pointer deref on exit
 -  Fix crash caused by calling kset_unregister twice

docs:
 -  driver-api: Add Surface DTX driver documentation

genirq:
 -  Add IRQF_NO_AUTOEN for request_irq/nmi()

gigabyte-wmi:
 -  add support for B550M AORUS PRO-P
 -  add X570 AORUS ELITE

hp-wmi:
 -  add platform profile support
 -  rename "thermal policy" to "thermal profile"

intel-hid:
 -  Fix spurious wakeups caused by tablet-mode events during suspend
 -  Support Lenovo ThinkPad X1 Tablet Gen 2

intel-vbtn:
 -  Remove unused KEYMAP_LEN define
 -  Stop reporting SW_DOCK events

intel_chtdc_ti_pwrbtn:
 -  Fix missing IRQF_ONESHOT as only threaded handler

intel_pmc_core:
 -  Uninitialized data in pmc_core_lpm_latch_mode_write()
 -  add ACPI dependency
 -  Fix "unsigned 'ret' is never less than zero" smatch warning
 -  Add support for Alder Lake PCH-P
 -  Add LTR registers for Tiger Lake
 -  Add option to set/clear LPM mode
 -  Add requirements file to debugfs
 -  Get LPM requirements for Tiger Lake
 -  Show LPM residency in microseconds
 -  Handle sub-states generically
 -  Remove global struct pmc_dev
 -  Don't use global pmcdev in quirks
 -  export platform global reset bits via etr3 sysfs file
 -  Ignore GBE LTR on Tiger Lake platforms
 -  Update Kconfig

intel_pmt_class:
 -  Initial resource to 0

intel_pmt_crashlog:
 -  Fix incorrect macros

mfd:
 -  intel_pmt: Add support for DG1
 -  intel_pmt: Fix nuisance messages and handling of disabled capabilities

panasonic-laptop:
 -  remove redundant assignment of variable result

platform:
 -  x86: ACPI: Get rid of ACPICA message printing

platform/mellanox:
 -  mlxreg-hotplug: move to use request_irq by IRQF_NO_AUTOEN flag
 -  Typo fix in the file mlxbf-bootctl.c

platform/surface:
 -  aggregator: fix a bit test
 -  aggregator: move to use request_irq by IRQF_NO_AUTOEN flag
 -  aggregator_registry: Give devices time to set up when connecting
 -  clean up a variable in surface_dtx_read()
 -  fix semicolon.cocci warnings
 -  aggregator_registry: Add support for Surface Pro 7+
 -  aggregator_registry: Make symbol 'ssam_base_hub_group' static
 -  dtx: Add support for native SSAM devices
 -  Add DTX driver
 -  aggregator: Make SSAM_DEFINE_SYNC_REQUEST_x define static functions
 -  Add platform profile driver
 -  aggregator_registry: Add HID subsystem devices
 -  aggregator_registry: Add DTX device
 -  aggregator_registry: Add platform profile device
 -  aggregator_registry: Add battery subsystem devices
 -  aggregator_registry: Add base device hub
 -  Set up Surface Aggregator device registry

pmc_atom:
 -  Match all Beckhoff Automation baytrail boards with critclk_systems DMI table

thinkpad_acpi:
 -  Add labels to the first 2 temperature sensors
 -  Correct thermal sensor allocation
 -  Correct minor typo
 -  sysfs interface to get wwan antenna type
 -  Disable DYTC CQL mode around switching to balanced mode
 -  Allow the FnLock LED to change state
 -  check dytc version for lapmode sysfs
 -  Handle keyboard cover attach/detach events

tools/power/x86/intel-speed-select:
 -  v1.9 release
 -  Drop __DATE__ and __TIME__ macros
 -  Add options to force online
 -  Process mailbox read error for core-power
 -  Increase string size

touchscreen_dmi:
 -  Add info for the Teclast Tbook 11 tablet
 -  Handle device properties with software node API

wmi:
 -  Make remove callback return void

----------------------------------------------------------------
Alban Bedel (1):
      platform/x86: intel-hid: Support Lenovo ThinkPad X1 Tablet Gen 2

Alexander Kobel (1):
      platform/x86: thinkpad_acpi: Handle keyboard cover attach/detach events

Alexey Klimov (1):
      platform/x86: gigabyte-wmi: add support for B550M AORUS PRO-P

Andrea.Ho (1):
      platform/x86: add support for Advantech software defined button

Antonio Terceiro (1):
      tools/power/x86/intel-speed-select: Drop __DATE__ and __TIME__ macros

Arnd Bergmann (1):
      platform/x86: intel_pmc_core: add ACPI dependency

Barry Song (1):
      genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()

Bhaskar Chowdhury (2):
      platform/x86: Typo fix in the file classmate-laptop.c
      platform/mellanox: Typo fix in the file mlxbf-bootctl.c

Colin Ian King (1):
      platform/x86: panasonic-laptop: remove redundant assignment of variable result

Dan Carpenter (3):
      platform/surface: clean up a variable in surface_dtx_read()
      platform/surface: aggregator: fix a bit test
      platform/x86: intel_pmc_core: Uninitialized data in pmc_core_lpm_latch_mode_write()

David E. Box (10):
      mfd: intel_pmt: Fix nuisance messages and handling of disabled capabilities
      mfd: intel_pmt: Add support for DG1
      platform/x86: intel_pmt_class: Initial resource to 0
      platform/x86: intel_pmt_crashlog: Fix incorrect macros
      platform/x86: intel_pmc_core: Update Kconfig
      platform/x86: intel_pmc_core: Ignore GBE LTR on Tiger Lake platforms
      platform/x86: intel_pmc_core: Don't use global pmcdev in quirks
      platform/x86: intel_pmc_core: Remove global struct pmc_dev
      platform/x86: intel_pmc_core: Add option to set/clear LPM mode
      platform/x86: intel_pmc_core: Add support for Alder Lake PCH-P

Elia Devito (2):
      platform/x86: hp-wmi: rename "thermal policy" to "thermal profile"
      platform/x86: hp-wmi: add platform profile support

Esteve Varela Colominas (2):
      platform/x86: thinkpad_acpi: Allow the FnLock LED to change state
      platform/x86: thinkpad_acpi: Correct minor typo

Gayatri Kammela (5):
      platform/x86: intel_pmc_core: Handle sub-states generically
      platform/x86: intel_pmc_core: Show LPM residency in microseconds
      platform/x86: intel_pmc_core: Get LPM requirements for Tiger Lake
      platform/x86: intel_pmc_core: Add requirements file to debugfs
      platform/x86: intel_pmc_core: Add LTR registers for Tiger Lake

Guangqing Zhu (1):
      platform/x86: intel_chtdc_ti_pwrbtn: Fix missing IRQF_ONESHOT as only threaded handler

Hans de Goede (18):
      MAINTAINERS: update MELLANOX HARDWARE PLATFORM SUPPORT maintainers
      Merge tag 'ib-mfd-platform-x86-v5.13' into review-hans
      platform/x86: thinkpad_acpi: Disable DYTC CQL mode around switching to balanced mode
      platform/x86: dell-wmi-sysman: Fix crash caused by calling kset_unregister twice
      platform/x86: dell-wmi-sysman: Fix possible NULL pointer deref on exit
      platform/x86: dell-wmi-sysman: Make it safe to call exit_foo_attributes() multiple times
      platform/x86: dell-wmi-sysman: Fix release_attributes_data() getting called twice on init_bios_attributes() failure
      platform/x86: dell-wmi-sysman: Cleanup sysman_init() error-exit handling
      platform/x86: dell-wmi-sysman: Make sysman_init() return -ENODEV of the interfaces are not found
      platform/x86: dell-wmi-sysman: Cleanup create_attributes_level_sysfs_files()
      platform/x86: intel-vbtn: Stop reporting SW_DOCK events
      platform/x86: intel-hid: Fix spurious wakeups caused by tablet-mode events during suspend
      platform/x86: intel-vbtn: Remove unused KEYMAP_LEN define
      platform/x86: dell-wmi-sysman: Make init_bios_attributes() ACPI object parsing more robust
      Merge tag 'irq-no-autoen-2021-03-25' into review-hans
      platform/x86: thinkpad_acpi: Add labels to the first 2 temperature sensors
      platform/x86: touchscreen_dmi: Add info for the Teclast Tbook 11 tablet
      platform/x86: intel_pmc_core: Fix "unsigned 'ret' is never less than zero" smatch warning

Heikki Krogerus (1):
      platform/x86: touchscreen_dmi: Handle device properties with software node API

Julian Labus (1):
      platform/x86: gigabyte-wmi: add X570 AORUS ELITE

Luca Stefani (1):
      platform/x86: asus-wmi: Add param to turn fn-lock mode on by default

Mario Limonciello (3):
      MAINTAINERS: Adjust Dell drivers to email alias
      MAINTAINERS: Add missing section for alienware-wmi driver
      platform/x86: Adjust Dell drivers to a personal email address

Mark Pearson (3):
      platform/x86: thinkpad_acpi: check dytc version for lapmode sysfs
      Add support for DYTC MMC_GET BIOS API.
      platform/x86: thinkpad_acpi: Correct thermal sensor allocation

Maximilian Luz (13):
      platform/surface: Set up Surface Aggregator device registry
      platform/surface: aggregator_registry: Add base device hub
      platform/surface: aggregator_registry: Add battery subsystem devices
      platform/surface: aggregator_registry: Add platform profile device
      platform/surface: aggregator_registry: Add DTX device
      platform/surface: aggregator_registry: Add HID subsystem devices
      platform/surface: Add platform profile driver
      platform/surface: aggregator: Make SSAM_DEFINE_SYNC_REQUEST_x define static functions
      platform/surface: Add DTX driver
      platform/surface: dtx: Add support for native SSAM devices
      docs: driver-api: Add Surface DTX driver documentation
      platform/surface: aggregator_registry: Add support for Surface Pro 7+
      platform/surface: aggregator_registry: Give devices time to set up when connecting

Nitin Joshi (1):
      platform/x86: thinkpad_acpi: sysfs interface to get wwan antenna type

Petr Vaněk (1):
      platform/x86: Fix typo in Kconfig

Rafael J. Wysocki (1):
      platform: x86: ACPI: Get rid of ACPICA message printing

Srinivas Pandruvada (5):
      tools/power/x86/intel-speed-select: Increase string size
      tools/power/x86/intel-speed-select: Process mailbox read error for core-power
      tools/power/x86/intel-speed-select: Add options to force online
      tools/power/x86/intel-speed-select: v1.9 release
      platform/x86: ISST: Account for increased timeout in some cases

Steffen Dirkwinkel (1):
      platform/x86: pmc_atom: Match all Beckhoff Automation baytrail boards with critclk_systems DMI table

Tamar Mashiah (1):
      platform/x86: intel_pmc_core: export platform global reset bits via etr3 sysfs file

Thomas Weißschuh (1):
      platform/x86: add Gigabyte WMI temperature driver

Tian Tao (2):
      platform/mellanox: mlxreg-hotplug: move to use request_irq by IRQF_NO_AUTOEN flag
      platform/surface: aggregator: move to use request_irq by IRQF_NO_AUTOEN flag

Uwe Kleine-König (1):
      platform/x86: wmi: Make remove callback return void

Wei Yongjun (1):
      platform/surface: aggregator_registry: Make symbol 'ssam_base_hub_group' static

kernel test robot (2):
      platform/x86: asus-laptop: fix kobj_to_dev.cocci warnings
      platform/surface: fix semicolon.cocci warnings

 Documentation/ABI/testing/sysfs-platform-intel-pmc |   20 +
 .../admin-guide/laptops/thinkpad-acpi.rst          |   20 +
 .../driver-api/surface_aggregator/client.rst       |    4 +-
 .../driver-api/surface_aggregator/clients/dtx.rst  |  718 +++++++++++
 .../surface_aggregator/clients/index.rst           |    1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 +
 MAINTAINERS                                        |   49 +-
 drivers/mfd/intel_pmt.c                            |  112 +-
 drivers/platform/mellanox/mlxbf-bootctl.c          |    2 +-
 drivers/platform/mellanox/mlxreg-hotplug.c         |    4 +-
 drivers/platform/surface/Kconfig                   |   69 ++
 drivers/platform/surface/Makefile                  |    3 +
 drivers/platform/surface/aggregator/controller.c   |   16 +-
 .../platform/surface/surface_aggregator_registry.c |  626 ++++++++++
 drivers/platform/surface/surface_dtx.c             | 1289 ++++++++++++++++++++
 .../platform/surface/surface_platform_profile.c    |  190 +++
 drivers/platform/surface/surfacepro3_button.c      |    2 -
 drivers/platform/x86/Kconfig                       |   37 +-
 drivers/platform/x86/Makefile                      |    4 +
 drivers/platform/x86/adv_swbutton.c                |  121 ++
 drivers/platform/x86/asus-laptop.c                 |    2 +-
 drivers/platform/x86/asus-wmi.c                    |    5 +-
 drivers/platform/x86/classmate-laptop.c            |    2 +-
 drivers/platform/x86/dell/alienware-wmi.c          |    4 +-
 drivers/platform/x86/dell/dell-smbios-base.c       |    2 +-
 drivers/platform/x86/dell/dell-smbios-wmi.c        |    3 +-
 drivers/platform/x86/dell/dell-wmi-descriptor.c    |    5 +-
 .../x86/dell/dell-wmi-sysman/biosattr-interface.c  |    3 +-
 .../x86/dell/dell-wmi-sysman/enum-attributes.c     |    3 +
 .../x86/dell/dell-wmi-sysman/int-attributes.c      |    3 +
 .../x86/dell/dell-wmi-sysman/passobj-attributes.c  |    3 +
 .../dell/dell-wmi-sysman/passwordattr-interface.c  |    3 +-
 .../x86/dell/dell-wmi-sysman/string-attributes.c   |    3 +
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |  118 +-
 drivers/platform/x86/dell/dell-wmi.c               |    3 +-
 drivers/platform/x86/gigabyte-wmi.c                |  203 +++
 drivers/platform/x86/hp-wmi.c                      |  101 +-
 drivers/platform/x86/intel-hid.c                   |   23 +-
 drivers/platform/x86/intel-vbtn.c                  |   15 +-
 drivers/platform/x86/intel-wmi-sbl-fw-update.c     |    3 +-
 drivers/platform/x86/intel-wmi-thunderbolt.c       |    3 +-
 drivers/platform/x86/intel_chtdc_ti_pwrbtn.c       |    2 +-
 drivers/platform/x86/intel_pmc_core.c              |  537 +++++++-
 drivers/platform/x86/intel_pmc_core.h              |   53 +-
 drivers/platform/x86/intel_pmt_class.c             |   48 +-
 drivers/platform/x86/intel_pmt_class.h             |    1 +
 drivers/platform/x86/intel_pmt_crashlog.c          |   13 +-
 drivers/platform/x86/intel_pmt_telemetry.c         |   20 -
 .../x86/intel_speed_select_if/isst_if_mbox_pci.c   |   33 +-
 drivers/platform/x86/lg-laptop.c                   |    2 +-
 drivers/platform/x86/panasonic-laptop.c            |    2 +-
 drivers/platform/x86/pmc_atom.c                    |   28 +-
 drivers/platform/x86/thinkpad_acpi.c               |  362 +++++-
 drivers/platform/x86/touchscreen_dmi.c             |   37 +-
 drivers/platform/x86/wmi-bmof.c                    |    3 +-
 drivers/platform/x86/wmi.c                         |    6 +-
 drivers/platform/x86/xo15-ebook.c                  |    6 +-
 include/linux/interrupt.h                          |    4 +
 include/linux/surface_aggregator/controller.h      |   74 +-
 include/linux/surface_aggregator/device.h          |   31 +-
 include/linux/wmi.h                                |    2 +-
 include/uapi/linux/surface_aggregator/dtx.h        |  146 +++
 kernel/irq/manage.c                                |   11 +-
 tools/power/x86/intel-speed-select/isst-config.c   |   30 +-
 tools/power/x86/intel-speed-select/isst-display.c  |   12 +-
 65 files changed, 4851 insertions(+), 411 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-pmc
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/dtx.rst
 create mode 100644 drivers/platform/surface/surface_aggregator_registry.c
 create mode 100644 drivers/platform/surface/surface_dtx.c
 create mode 100644 drivers/platform/surface/surface_platform_profile.c
 create mode 100644 drivers/platform/x86/adv_swbutton.c
 create mode 100644 drivers/platform/x86/gigabyte-wmi.c
 create mode 100644 include/uapi/linux/surface_aggregator/dtx.h


