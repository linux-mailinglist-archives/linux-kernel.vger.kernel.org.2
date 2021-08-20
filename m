Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697963F2AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhHTLG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:06:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:45785 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239910AbhHTLF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:05:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216753819"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="216753819"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="424376359"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 20 Aug 2021 04:05:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 91CB7199; Fri, 20 Aug 2021 14:05:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Dell.Client.Kernel@dell.com
Cc:     Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
Subject: [PATCH v5 00/20] platform/x86: Intel platform driver code movement
Date:   Fri, 20 Aug 2021 14:04:38 +0300
Message-Id: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v5 of the Intel drivers move on in the source tree.
v4: https://lore.kernel.org/platform-driver-x86/20210819163735.81803-1-andriy.shevchenko@linux.intel.com/
v3 has been done by Kate:
https://lore.kernel.org/platform-driver-x86/20210819033001.20136-1-hpa@redhat.com/

I have taken the initial set from review-hans branch and removed Hans' SoB
along with Link, while leaving others' tags.

Changelog v5:
- dropped SCU and IPS patches since there are somehow problematic
- added Intel Atom PMC driver move
- moved SCU kernel doc fix to be first in the series

Changelog v4:
- spelled fully the driver names in the commit messages
- fixed SCU *.ko module names
- dropped extra prefix in PMC files
- dropped stray changes within the series
- removed confusing comments in Makefile and Kconfig files
- embedded a few of Kconfig improvements here and there (ordering, spelling)
- split miscellaneous group
- added a patch to fix kernel doc issue in SCU IPC code

Andy Shevchenko (2):
  platform/x86: intel_scu_ipc: Fix doc of
    intel_scu_ipc_dev_command_with_size()
  platform/x86: pmc_atom: Move to intel sub-directory

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

 MAINTAINERS                                   |  22 +-
 drivers/platform/x86/Kconfig                  | 236 ------------------
 drivers/platform/x86/Makefile                 |  23 --
 drivers/platform/x86/intel/Kconfig            | 152 +++++++++++
 drivers/platform/x86/intel/Makefile           |  38 +++
 drivers/platform/x86/intel/atomisp2/Kconfig   |  43 ++++
 drivers/platform/x86/intel/atomisp2/Makefile  |   9 +
 .../atomisp2/led.c}                           |   0
 .../atomisp2/pm.c}                            |   0
 .../{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c}  |   0
 .../chtdc_ti_pwrbtn.c}                        |   0
 .../platform/x86/{intel-hid.c => intel/hid.c} |   2 +-
 .../int0002_vgpio.c}                          |   0
 .../mrfld_pwrbtn.c}                           |   0
 .../{intel_oaktrail.c => intel/oaktrail.c}    |   0
 drivers/platform/x86/intel/pmc/Kconfig        |  25 ++
 drivers/platform/x86/intel/pmc/Makefile       |   9 +
 .../{intel_pmc_core.c => intel/pmc/core.c}    |   2 +-
 .../{intel_pmc_core.h => intel/pmc/core.h}    |   0
 .../pmc/pltdrv.c}                             |   0
 drivers/platform/x86/{ => intel}/pmc_atom.c   |   0
 .../{intel_punit_ipc.c => intel/punit_ipc.c}  |   0
 .../platform/x86/{intel-rst.c => intel/rst.c} |   0
 .../smartconnect.c}                           |   0
 .../speed_select_if}/Kconfig                  |   0
 .../speed_select_if}/Makefile                 |   0
 .../speed_select_if}/isst_if_common.c         |   0
 .../speed_select_if}/isst_if_common.h         |   0
 .../speed_select_if}/isst_if_mbox_msr.c       |   0
 .../speed_select_if}/isst_if_mbox_pci.c       |   0
 .../speed_select_if}/isst_if_mmio.c           |   0
 drivers/platform/x86/intel/telemetry/Kconfig  |  16 ++
 drivers/platform/x86/intel/telemetry/Makefile |  11 +
 .../telemetry/core.c}                         |   0
 .../telemetry/debugfs.c}                      |   0
 .../telemetry/pltdrv.c}                       |   0
 .../turbo_max_3.c}                            |   0
 .../uncore-frequency.c}                       |   0
 .../x86/{intel-vbtn.c => intel/vbtn.c}        |   2 +-
 drivers/platform/x86/intel/wmi/Kconfig        |  31 +++
 drivers/platform/x86/intel/wmi/Makefile       |   9 +
 .../wmi/sbl-fw-update.c}                      |   0
 .../wmi/thunderbolt.c}                        |   0
 drivers/platform/x86/intel_scu_ipc.c          |   2 +-
 44 files changed, 358 insertions(+), 274 deletions(-)
 create mode 100644 drivers/platform/x86/intel/atomisp2/Kconfig
 create mode 100644 drivers/platform/x86/intel/atomisp2/Makefile
 rename drivers/platform/x86/{intel_atomisp2_led.c => intel/atomisp2/led.c} (100%)
 rename drivers/platform/x86/{intel_atomisp2_pm.c => intel/atomisp2/pm.c} (100%)
 rename drivers/platform/x86/{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c} (100%)
 rename drivers/platform/x86/{intel_chtdc_ti_pwrbtn.c => intel/chtdc_ti_pwrbtn.c} (100%)
 rename drivers/platform/x86/{intel-hid.c => intel/hid.c} (99%)
 rename drivers/platform/x86/{intel_int0002_vgpio.c => intel/int0002_vgpio.c} (100%)
 rename drivers/platform/x86/{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c} (100%)
 rename drivers/platform/x86/{intel_oaktrail.c => intel/oaktrail.c} (100%)
 create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc/Makefile
 rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (99%)
 rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (100%)
 rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c} (100%)
 rename drivers/platform/x86/{ => intel}/pmc_atom.c (100%)
 rename drivers/platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c} (100%)
 rename drivers/platform/x86/{intel-rst.c => intel/rst.c} (100%)
 rename drivers/platform/x86/{intel-smartconnect.c => intel/smartconnect.c} (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Kconfig (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Makefile (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.c (100%)
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

-- 
2.32.0

