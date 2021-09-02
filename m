Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C945E3FEF18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbhIBOFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345351AbhIBOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630591455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8vtdoj0DHIwhd7LHrll2SxN4bn9s7gmm2cBMGtqWsdI=;
        b=Hc5gdxo4Hi9MtwNiIe1+u2GGyXBpzRegbYa3WGTn7EQa4Q6QInJ+G62lpkVNdkW8KYBm+N
        CueH2XzVYAam+IBwogBcZG+p9Er3OwiW/noUZLnkO3fKtXGoGMqN+dkm4B5tO4rHmIuYe9
        p2Gpm7H7ZfBbt/51hEeLiHvZWD84e6g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-wdnSAFrrPImRmQCE7TVBKw-1; Thu, 02 Sep 2021 10:04:14 -0400
X-MC-Unique: wdnSAFrrPImRmQCE7TVBKw-1
Received: by mail-ej1-f72.google.com with SMTP id bo11-20020a170906d04b00b005d477e1e41fso972924ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 07:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8vtdoj0DHIwhd7LHrll2SxN4bn9s7gmm2cBMGtqWsdI=;
        b=LhvGgcd/33+khnA61T22fSNwKa9pXxMllKgqPx116DnHyqTU8GwRC8jUXdzDKs0v5+
         5nTTXTlvWS1m8YX1rF79HrshyxAmIOKxTuSzt++iwzjeFY3KgU31Wgpm6w8wU8+Z9Ppl
         h/VJp1mEZDlmxOcudbD77so3wFIUlFL+HgbChdf9j5BA8xGq9piM5Vl54VuDhZYFEGyT
         xOMkDSB/9C+ZxzX9Cepz9Qb/qYPOQCRWh2HMUV0tISAj8wWAkgJ0bdMtT0nT7wFwjrRR
         dAcEJ/8a/9ac45gxQgmYudYFT7fLlorX0tg4wY/nnEwK+MJY7sLPymtR7XsQwYmaGWhd
         TvXQ==
X-Gm-Message-State: AOAM5318gwAnMwKeknk9nS8zktLqWn218jzeiCOjzSzwyVxjPbTo5G5K
        pupKUCFylt23nDdiGeji2VMqI/Ransq/lRyn63G5JEnZkDmfv/g13qC6PX6ThPtB3a8VgA8b9Y9
        ua0ukykmlWcb0phyM67VUMC1s
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr3914999ejc.263.1630591452931;
        Thu, 02 Sep 2021 07:04:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMfZybRJ7PAvJ198CtjJtwCtF58Q+0NZ4b5+MrqPNigJvYSgDtHvKCFGpq04XEXkgybpKBwQ==
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr3914943ejc.263.1630591452225;
        Thu, 02 Sep 2021 07:04:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k21sm1168607ejj.55.2021.09.02.07.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 07:04:11 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.15-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <eceefa8e-c6be-217c-ef1d-3231d7fbe69f@redhat.com>
Date:   Thu, 2 Sep 2021 16:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.15.

Highlights:
 - Move all the Intel drivers into their own subdir(s)
 - New meraki-mx100 platform driver
 - Asus WMI driver enhancements, including
   /sys/firmware/acpi/platform_profile support
 - New BIOS SAR driver for Intel M.2 WWAM modems
 - Alder Lake support for the Intel PMC driver
 - A whole bunch of cleanups + fixes all over the place

Regards,

Hans


The following changes since commit 9d7b132e62e41b7d49bf157aeaf9147c27492e0f:

  platform/x86: pcengines-apuv2: Add missing terminating entries to gpio-lookup tables (2021-08-06 14:04:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.15-1

for you to fetch changes up to 0487d4fc42d7f31a56cfd9e2237f9ebd889e6112:

  platform/x86: dell-smbios-wmi: Add missing kfree in error-exit from run_smbios_call (2021-08-26 16:09:43 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.15-1

Highlights:
 - Move all the Intel drivers into their own subdir(s) (mostly Kate's work)
 - New meraki-mx100 platform driver
 - Asus WMI driver enhancements, including
   /sys/firmware/acpi/platform_profile support
 - New BIOS SAR driver for Intel M.2 WWAM modems
 - Alder Lake support for the Intel PMC driver
 - A whole bunch of cleanups + fixes all over the place

The following is an automated git shortlog grouped by driver:

BIOS SAR driver for Intel M.2 Modem:
 - BIOS SAR driver for Intel M.2 Modem

ISST:
 -  use semi-colons instead of commas
 -  Fix optimization with use of numa

Replace deprecated CPU-hotplug functions.:
 - Replace deprecated CPU-hotplug functions.

Update Mario Limonciello's email address in the docs:
 - Update Mario Limonciello's email address in the docs

acer-wmi:
 -  Add Turbo Mode support for Acer PH315-53

add meraki-mx100 platform driver:
 - add meraki-mx100 platform driver

asus-nb-wmi:
 -  Add tablet_mode_sw=lid-flip quirk for the TP200s
 -  Allow configuring SW_TABLET_MODE method with a module option

asus-wmi:
 -  Fix "unsigned 'retval' is never less than zero" smatch warning
 -  Delete impossible condition
 -  Add support for platform_profile
 -  Add egpu enable method
 -  Add dgpu disable method
 -  Add panel overdrive functionality

dell-smbios:
 -  Remove unused dmi_system_id table

dell-smbios-wmi:
 -  Add missing kfree in error-exit from run_smbios_call
 -  Avoid false-positive memcpy() warning

dell-smo8800:
 -  Convert to be a platform driver

dual_accel_detect:
 -  Use the new i2c_acpi_client_count() helper

gigabyte-wmi:
 -  add support for B450M S2H V2
 -  add support for X570 GAMING X

hp_accel:
 -  Convert to be a platform driver
 -  Remove _INI method call

i2c:
 -  acpi: Add an i2c_acpi_client_count() helper function

i2c-multi-instantiate:
 -  Use the new i2c_acpi_client_count() helper

ideapad-laptop:
 -  Fix Legion 5 Fn lock LED

intel-hid:
 -  Move to intel sub-directory

intel-rst:
 -  Move to intel sub-directory

intel-smartconnect:
 -  Move to intel sub-directory

intel-uncore-frequency:
 -  Move to intel sub-directory

intel-vbtn:
 -  Move to intel sub-directory

intel-wmi-sbl-fw-update:
 -  Move to intel sub-directory

intel-wmi-thunderbolt:
 -  Move to intel sub-directory

intel_atomisp2:
 -  Move to intel sub-directory

intel_bxtwc_tmu:
 -  Move to intel sub-directory

intel_cht_int33fe:
 -  Use the new i2c_acpi_client_count() helper

intel_chtdc_ti_pwrbtn:
 -  Move to intel sub-directory

intel_int0002_vgpio:
 -  Move to intel sub-directory

intel_mrfld_pwrbtn:
 -  Move to intel sub-directory

intel_oaktrail:
 -  Move to intel sub-directory

intel_pmc_core:
 -  Move to intel sub-directory
 -  Prevent possibile overflow

intel_pmt_telemetry:
 -  Ignore zero sized entries

intel_punit_ipc:
 -  Move to intel sub-directory

intel_scu_ipc:
 -  Fix doc of intel_scu_ipc_dev_command_with_size()

intel_speed_select_if:
 -  Move to intel sub-directory

intel_telemetry:
 -  Move to intel sub-directory

intel_turbo_max_3:
 -  Move to intel sub-directory

lg-laptop:
 -  Use correct event for keyboard backlight FN-key
 -  Use correct event for touchpad toggle FN-key
 -  Support for battery charge limit on newer models

platform/mellanox:
 -  mlxbf-pmc: fix kernel-doc notation

platform/surface:
 -  aggregator: Use y instead of objs in Makefile
 -  surface3_power: Use i2c_acpi_get_i2c_resource() helper

platform/x86/intel:
 -  pmc/core: Add GBE Package C10 fix for Alder Lake PCH
 -  pmc/core: Add Alder Lake low power mode support for pmc core
 -  pmc/core: Add Latency Tolerance Reporting (LTR) support to Alder Lake
 -  pmc/core: Add Alderlake support to pmc core driver
 -  int3472: Use y instead of objs in Makefile
 -  pmt: Use y instead of objs in Makefile
 -  int33fe: Use y instead of objs in Makefile
 -  Move Intel PMT drivers to new subfolder

thermal/drivers/intel:
 -  Move intel_menlow to thermal drivers

think-lmi:
 -  add debug_cmd

----------------------------------------------------------------
Andy Shevchenko (9):
      platform/surface: surface3_power: Use i2c_acpi_get_i2c_resource() helper
      platform/surface: aggregator: Use y instead of objs in Makefile
      platform/x86: dell-smo8800: Convert to be a platform driver
      platform/x86/intel: int33fe: Use y instead of objs in Makefile
      platform/x86/intel: pmt: Use y instead of objs in Makefile
      platform/x86/intel: int3472: Use y instead of objs in Makefile
      platform/x86: intel_scu_ipc: Fix doc of intel_scu_ipc_dev_command_with_size()
      platform/x86: hp_accel: Remove _INI method call
      platform/x86: hp_accel: Convert to be a platform driver

Chris Blake (1):
      platform/x86: add meraki-mx100 platform driver

Dan Carpenter (2):
      platform/x86: asus-wmi: Delete impossible condition
      platform/x86: ISST: use semi-colons instead of commas

David E. Box (4):
      platform/x86/intel: Move Intel PMT drivers to new subfolder
      platform/x86: intel_pmc_core: Prevent possibile overflow
      platform/x86: intel_pmt_telemetry: Ignore zero sized entries
      platform/x86/intel: pmc/core: Add GBE Package C10 fix for Alder Lake PCH

Gayatri Kammela (3):
      platform/x86/intel: pmc/core: Add Alderlake support to pmc core driver
      platform/x86/intel: pmc/core: Add Latency Tolerance Reporting (LTR) support to Alder Lake
      platform/x86/intel: pmc/core: Add Alder Lake low power mode support for pmc core

Hans de Goede (9):
      platform/x86: dell-smbios: Remove unused dmi_system_id table
      platform/x86: asus-nb-wmi: Allow configuring SW_TABLET_MODE method with a module option
      platform/x86: asus-nb-wmi: Add tablet_mode_sw=lid-flip quirk for the TP200s
      i2c: acpi: Add an i2c_acpi_client_count() helper function
      platform/x86: dual_accel_detect: Use the new i2c_acpi_client_count() helper
      platform/x86: i2c-multi-instantiate: Use the new i2c_acpi_client_count() helper
      platform/x86: intel_cht_int33fe: Use the new i2c_acpi_client_count() helper
      platform/x86: Update Mario Limonciello's email address in the docs
      platform/x86: dell-smbios-wmi: Add missing kfree in error-exit from run_smbios_call

JafarAkhondali (1):
      platform/x86: acer-wmi: Add Turbo Mode support for Acer PH315-53

Jiapeng Chong (1):
      platform/x86: asus-wmi: Fix "unsigned 'retval' is never less than zero" smatch warning

Kate Hsuan (18):
      platform/x86: intel_bxtwc_tmu: Move to intel sub-directory
      platform/x86: intel_chtdc_ti_pwrbtn: Move to intel sub-directory
      platform/x86: intel_mrfld_pwrbtn: Move to intel sub-directory
      platform/x86: intel_punit_ipc: Move to intel sub-directory
      platform/x86: intel_pmc_core: Move to intel sub-directory
      platform/x86: intel_telemetry: Move to intel sub-directory
      platform/x86: intel-rst: Move to intel sub-directory
      platform/x86: intel-smartconnect: Move to intel sub-directory
      platform/x86: intel_turbo_max_3: Move to intel sub-directory
      platform/x86: intel-uncore-frequency: Move to intel sub-directory
      platform/x86: intel_speed_select_if: Move to intel sub-directory
      platform/x86: intel_atomisp2: Move to intel sub-directory
      platform/x86: intel-hid: Move to intel sub-directory
      platform/x86: intel_int0002_vgpio: Move to intel sub-directory
      platform/x86: intel_oaktrail: Move to intel sub-directory
      platform/x86: intel-vbtn: Move to intel sub-directory
      platform/x86: intel-wmi-sbl-fw-update: Move to intel sub-directory
      platform/x86: intel-wmi-thunderbolt: Move to intel sub-directory

Kees Cook (1):
      platform/x86: dell-smbios-wmi: Avoid false-positive memcpy() warning

Luke D. Jones (4):
      asus-wmi: Add panel overdrive functionality
      asus-wmi: Add dgpu disable method
      asus-wmi: Add egpu enable method
      asus-wmi: Add support for platform_profile

Mark Pearson (1):
      platform/x86: think-lmi: add debug_cmd

Matan Ziv-Av (3):
      platform/x86: lg-laptop: Support for battery charge limit on newer models
      platform/x86: lg-laptop: Use correct event for touchpad toggle FN-key
      platform/x86: lg-laptop: Use correct event for keyboard backlight FN-key

Meng Dong (1):
      platform/x86: ideapad-laptop: Fix Legion 5 Fn lock LED

Randy Dunlap (1):
      platform/mellanox: mlxbf-pmc: fix kernel-doc notation

Sebastian Andrzej Siewior (1):
      platform/x86: Replace deprecated CPU-hotplug functions.

Shravan S (1):
      platform/x86: BIOS SAR driver for Intel M.2 Modem

Srinivas Pandruvada (2):
      platform/x86: ISST: Fix optimization with use of numa
      thermal/drivers/intel: Move intel_menlow to thermal drivers

Thomas Weißschuh (2):
      platform/x86: gigabyte-wmi: add support for X570 GAMING X
      platform/x86: gigabyte-wmi: add support for B450M S2H V2

 Documentation/ABI/testing/dell-smbios-wmi          |   2 +-
 Documentation/ABI/testing/sysfs-bus-thunderbolt    |   2 +-
 .../ABI/testing/sysfs-class-firmware-attributes    |  19 +-
 Documentation/ABI/testing/sysfs-driver-intc_sar    |  54 +++
 .../ABI/testing/sysfs-platform-dell-smbios         |   2 +-
 .../testing/sysfs-platform-intel-wmi-thunderbolt   |   2 +-
 Documentation/ABI/testing/sysfs-power              |   2 +-
 Documentation/admin-guide/laptops/lg-laptop.rst    |   4 +-
 MAINTAINERS                                        |  35 +-
 drivers/i2c/i2c-core-acpi.c                        |  32 ++
 drivers/misc/lis3lv02d/lis3lv02d.h                 |   1 -
 drivers/platform/mellanox/mlxbf-pmc.c              |  13 +-
 drivers/platform/surface/aggregator/Makefile       |  15 +-
 drivers/platform/surface/surface3_power.c          |   8 +-
 drivers/platform/x86/Kconfig                       | 291 +-------------
 drivers/platform/x86/Makefile                      |  29 +-
 drivers/platform/x86/acer-wmi.c                    | 179 +++++++++
 drivers/platform/x86/asus-nb-wmi.c                 |  28 ++
 drivers/platform/x86/asus-wmi.c                    | 416 ++++++++++++++++++++-
 drivers/platform/x86/dell/Kconfig                  |   2 +-
 drivers/platform/x86/dell/dcdbas.c                 |   4 +-
 drivers/platform/x86/dell/dell-smbios-smm.c        |  31 --
 drivers/platform/x86/dell/dell-smbios-wmi.c        |   3 +-
 drivers/platform/x86/dell/dell-smo8800.c           |  74 +---
 drivers/platform/x86/dual_accel_detect.h           |  26 +-
 drivers/platform/x86/gigabyte-wmi.c                |   2 +
 drivers/platform/x86/hp_accel.c                    |  78 +---
 drivers/platform/x86/i2c-multi-instantiate.c       |  27 +-
 drivers/platform/x86/ideapad-laptop.c              |   9 +
 drivers/platform/x86/intel/Kconfig                 | 149 ++++++++
 drivers/platform/x86/intel/Makefile                |  39 ++
 drivers/platform/x86/intel/atomisp2/Kconfig        |  43 +++
 drivers/platform/x86/intel/atomisp2/Makefile       |   9 +
 .../{intel_atomisp2_led.c => intel/atomisp2/led.c} |   0
 .../{intel_atomisp2_pm.c => intel/atomisp2/pm.c}   |   0
 .../x86/{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c}   |   0
 .../chtdc_ti_pwrbtn.c}                             |   0
 drivers/platform/x86/{intel-hid.c => intel/hid.c}  |   2 +-
 .../int0002_vgpio.c}                               |   0
 drivers/platform/x86/intel/int1092/Kconfig         |  14 +
 drivers/platform/x86/intel/int1092/Makefile        |   1 +
 drivers/platform/x86/intel/int1092/intel_sar.c     | 316 ++++++++++++++++
 drivers/platform/x86/intel/int1092/intel_sar.h     |  86 +++++
 drivers/platform/x86/intel/int33fe/Makefile        |   2 +-
 .../x86/intel/int33fe/intel_cht_int33fe_common.c   |  29 +-
 drivers/platform/x86/intel/int3472/Makefile        |   2 +-
 .../{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c} |   0
 .../x86/{intel_oaktrail.c => intel/oaktrail.c}     |   0
 drivers/platform/x86/intel/pmc/Kconfig             |  25 ++
 drivers/platform/x86/intel/pmc/Makefile            |   9 +
 .../x86/{intel_pmc_core.c => intel/pmc/core.c}     | 374 +++++++++++++++++-
 .../x86/{intel_pmc_core.h => intel/pmc/core.h}     |  19 +
 .../pmc/pltdrv.c}                                  |   0
 drivers/platform/x86/intel/pmt/Kconfig             |  40 ++
 drivers/platform/x86/intel/pmt/Makefile            |  12 +
 .../x86/{intel_pmt_class.c => intel/pmt/class.c}   |   2 +-
 .../x86/{intel_pmt_class.h => intel/pmt/class.h}   |   0
 .../{intel_pmt_crashlog.c => intel/pmt/crashlog.c} |   2 +-
 .../pmt/telemetry.c}                               |  10 +-
 .../x86/{intel_punit_ipc.c => intel/punit_ipc.c}   |   0
 drivers/platform/x86/{intel-rst.c => intel/rst.c}  |   0
 .../{intel-smartconnect.c => intel/smartconnect.c} |   0
 .../speed_select_if}/Kconfig                       |   0
 .../speed_select_if}/Makefile                      |   0
 .../speed_select_if}/isst_if_common.c              |   9 +-
 .../speed_select_if}/isst_if_common.h              |   0
 .../speed_select_if}/isst_if_mbox_msr.c            |   0
 .../speed_select_if}/isst_if_mbox_pci.c            |   0
 .../speed_select_if}/isst_if_mmio.c                |   0
 drivers/platform/x86/intel/telemetry/Kconfig       |  16 +
 drivers/platform/x86/intel/telemetry/Makefile      |  11 +
 .../telemetry/core.c}                              |   0
 .../telemetry/debugfs.c}                           |   0
 .../telemetry/pltdrv.c}                            |   0
 .../{intel_turbo_max_3.c => intel/turbo_max_3.c}   |   0
 .../uncore-frequency.c}                            |   0
 .../platform/x86/{intel-vbtn.c => intel/vbtn.c}    |   2 +-
 drivers/platform/x86/intel/wmi/Kconfig             |  31 ++
 drivers/platform/x86/intel/wmi/Makefile            |   9 +
 .../wmi/sbl-fw-update.c}                           |   0
 .../wmi/thunderbolt.c}                             |   0
 drivers/platform/x86/intel_scu_ipc.c               |   2 +-
 drivers/platform/x86/lg-laptop.c                   | 107 +++++-
 drivers/platform/x86/meraki-mx100.c                | 230 ++++++++++++
 drivers/platform/x86/think-lmi.c                   |  80 ++++
 drivers/platform/x86/think-lmi.h                   |   1 +
 drivers/thermal/intel/Kconfig                      |   9 +
 drivers/thermal/intel/Makefile                     |   1 +
 .../{platform/x86 => thermal/intel}/intel_menlow.c |   0
 include/linux/i2c.h                                |   5 +
 include/linux/platform_data/x86/asus-wmi.h         |   7 +
 91 files changed, 2459 insertions(+), 636 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intc_sar
 create mode 100644 drivers/platform/x86/intel/atomisp2/Kconfig
 create mode 100644 drivers/platform/x86/intel/atomisp2/Makefile
 rename drivers/platform/x86/{intel_atomisp2_led.c => intel/atomisp2/led.c} (100%)
 rename drivers/platform/x86/{intel_atomisp2_pm.c => intel/atomisp2/pm.c} (100%)
 rename drivers/platform/x86/{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c} (100%)
 rename drivers/platform/x86/{intel_chtdc_ti_pwrbtn.c => intel/chtdc_ti_pwrbtn.c} (100%)
 rename drivers/platform/x86/{intel-hid.c => intel/hid.c} (99%)
 rename drivers/platform/x86/{intel_int0002_vgpio.c => intel/int0002_vgpio.c} (100%)
 create mode 100644 drivers/platform/x86/intel/int1092/Kconfig
 create mode 100644 drivers/platform/x86/intel/int1092/Makefile
 create mode 100644 drivers/platform/x86/intel/int1092/intel_sar.c
 create mode 100644 drivers/platform/x86/intel/int1092/intel_sar.h
 rename drivers/platform/x86/{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c} (100%)
 rename drivers/platform/x86/{intel_oaktrail.c => intel/oaktrail.c} (100%)
 create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc/Makefile
 rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (82%)
 rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (94%)
 rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c} (100%)
 create mode 100644 drivers/platform/x86/intel/pmt/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmt/Makefile
 rename drivers/platform/x86/{intel_pmt_class.c => intel/pmt/class.c} (99%)
 rename drivers/platform/x86/{intel_pmt_class.h => intel/pmt/class.h} (100%)
 rename drivers/platform/x86/{intel_pmt_crashlog.c => intel/pmt/crashlog.c} (99%)
 rename drivers/platform/x86/{intel_pmt_telemetry.c => intel/pmt/telemetry.c} (93%)
 rename drivers/platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c} (100%)
 rename drivers/platform/x86/{intel-rst.c => intel/rst.c} (100%)
 rename drivers/platform/x86/{intel-smartconnect.c => intel/smartconnect.c} (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Kconfig (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Makefile (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.c (99%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.h (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_msr.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_pci.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mmio.c (100%)
 create mode 100644 drivers/platform/x86/intel/telemetry/Kconfig
 create mode 100644 drivers/platform/x86/intel/telemetry/Makefile
 rename drivers/platform/x86/{intel_telemetry_core.c => intel/telemetry/core.c} (100%)
 rename drivers/platform/x86/{intel_telemetry_debugfs.c => intel/telemetry/debugfs.c} (100%)
 rename drivers/platform/x86/{intel_telemetry_pltdrv.c => intel/telemetry/pltdrv.c} (100%)
 rename drivers/platform/x86/{intel_turbo_max_3.c => intel/turbo_max_3.c} (100%)
 rename drivers/platform/x86/{intel-uncore-frequency.c => intel/uncore-frequency.c} (100%)
 rename drivers/platform/x86/{intel-vbtn.c => intel/vbtn.c} (99%)
 create mode 100644 drivers/platform/x86/intel/wmi/Kconfig
 create mode 100644 drivers/platform/x86/intel/wmi/Makefile
 rename drivers/platform/x86/{intel-wmi-sbl-fw-update.c => intel/wmi/sbl-fw-update.c} (100%)
 rename drivers/platform/x86/{intel-wmi-thunderbolt.c => intel/wmi/thunderbolt.c} (100%)
 create mode 100644 drivers/platform/x86/meraki-mx100.c
 rename drivers/{platform/x86 => thermal/intel}/intel_menlow.c (100%)

