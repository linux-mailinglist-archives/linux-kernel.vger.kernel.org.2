Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275113F1E03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhHSQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:38:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:38684 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhHSQie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:38:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216630803"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="216630803"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="512158764"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2021 09:37:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7BDBFE7; Thu, 19 Aug 2021 19:37:52 +0300 (EEST)
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
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
Subject: [PATCH v4 00/21] platform/x86: Intel platform driver code movement
Date:   Thu, 19 Aug 2021 19:37:14 +0300
Message-Id: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v4 of the Intel drivers move on in the source tree.
v3 has been done by Kate:
https://lore.kernel.org/platform-driver-x86/20210819033001.20136-1-hpa@redhat.com/

I have taken the initial set from review-hans branch and removed Hans' SoB
along with Link, while leaving others' tags.

Changelog v4:
- spelled fully the driver names in the commit messages
- fixed SCU *.ko module names
- dropped extra prefix in PMC files
- dropped stray changes within the series
- removed confusing comments in Makefile and Kconfig files
- embedded a few of Kconfig improvements here and there (ordering, spelling)
- split miscellaneous group
- added a patch to fix kernel doc issue in SCU IPC code

Andy Shevchenko (1):
  platform/x86/intel: scu: Fix doc of
    intel_scu_ipc_dev_command_with_size()

Kate Hsuan (20):
  platform/x86: intel_bxtwc_tmu: Move to intel sub-directory
  platform/x86: intel_chtdc_ti_pwrbtn: Move to intel sub-directory
  platform/x86: intel_mrfld_pwrbtn: Move to intel sub-directory
  platform/x86: intel_punit_ipc: Move to intel sub-directory
  platform/x86: intel_pmc_core: Move to intel sub-directory
  platform/x86: intel_scu: Move to intel sub-directory
  platform/x86: intel_telemetry: Move to intel sub-directory
  platform/x86: intel_ips: Move to intel sub-directory
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

 MAINTAINERS                                   |  24 +-
 drivers/platform/x86/Kconfig                  | 288 ------------------
 drivers/platform/x86/Makefile                 |  31 --
 drivers/platform/x86/intel/Kconfig            | 158 ++++++++++
 drivers/platform/x86/intel/Makefile           |  40 +++
 drivers/platform/x86/intel/atomisp2/Kconfig   |  43 +++
 drivers/platform/x86/intel/atomisp2/Makefile  |   9 +
 .../atomisp2/led.c}                           |   0
 .../atomisp2/pm.c}                            |   0
 .../{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c}  |   0
 .../chtdc_ti_pwrbtn.c}                        |   0
 .../platform/x86/{intel-hid.c => intel/hid.c} |   2 +-
 .../int0002_vgpio.c}                          |   0
 .../platform/x86/{intel_ips.c => intel/ips.c} |   3 +-
 .../mrfld_pwrbtn.c}                           |   0
 .../{intel_oaktrail.c => intel/oaktrail.c}    |   0
 drivers/platform/x86/intel/pmc/Kconfig        |  25 ++
 drivers/platform/x86/intel/pmc/Makefile       |   9 +
 .../{intel_pmc_core.c => intel/pmc/core.c}    |   2 +-
 .../{intel_pmc_core.h => intel/pmc/core.h}    |   0
 .../pmc/pltdrv.c}                             |   0
 .../{intel_punit_ipc.c => intel/punit_ipc.c}  |   0
 .../platform/x86/{intel-rst.c => intel/rst.c} |   0
 drivers/platform/x86/intel/scu/Kconfig        |  51 ++++
 drivers/platform/x86/intel/scu/Makefile       |  15 +
 .../x86/{intel_scu_ipc.c => intel/scu/ipc.c}  |   2 +-
 .../scu/ipcutil.c}                            |   0
 .../scu/pcidrv.c}                             |   0
 .../scu/pltdrv.c}                             |   0
 .../x86/{intel_scu_wdt.c => intel/scu/wdt.c}  |   0
 .../smartconnect.c}                           |   0
 .../speed_select_if}/Kconfig                  |   0
 .../speed_select_if}/Makefile                 |   0
 .../speed_select_if}/isst_if_common.c         |   0
 .../speed_select_if}/isst_if_common.h         |   0
 .../speed_select_if}/isst_if_mbox_msr.c       |   0
 .../speed_select_if}/isst_if_mbox_pci.c       |   0
 .../speed_select_if}/isst_if_mmio.c           |   0
 drivers/platform/x86/intel/telemetry/Kconfig  |  16 +
 drivers/platform/x86/intel/telemetry/Makefile |  11 +
 .../telemetry/core.c}                         |   0
 .../telemetry/debugfs.c}                      |   0
 .../telemetry/pltdrv.c}                       |   0
 .../turbo_max_3.c}                            |   0
 .../uncore-frequency.c}                       |   0
 .../x86/{intel-vbtn.c => intel/vbtn.c}        |   2 +-
 drivers/platform/x86/intel/wmi/Kconfig        |  31 ++
 drivers/platform/x86/intel/wmi/Makefile       |   9 +
 .../wmi/sbl-fw-update.c}                      |   0
 .../wmi/thunderbolt.c}                        |   0
 50 files changed, 435 insertions(+), 336 deletions(-)
 create mode 100644 drivers/platform/x86/intel/atomisp2/Kconfig
 create mode 100644 drivers/platform/x86/intel/atomisp2/Makefile
 rename drivers/platform/x86/{intel_atomisp2_led.c => intel/atomisp2/led.c} (100%)
 rename drivers/platform/x86/{intel_atomisp2_pm.c => intel/atomisp2/pm.c} (100%)
 rename drivers/platform/x86/{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c} (100%)
 rename drivers/platform/x86/{intel_chtdc_ti_pwrbtn.c => intel/chtdc_ti_pwrbtn.c} (100%)
 rename drivers/platform/x86/{intel-hid.c => intel/hid.c} (99%)
 rename drivers/platform/x86/{intel_int0002_vgpio.c => intel/int0002_vgpio.c} (100%)
 rename drivers/platform/x86/{intel_ips.c => intel/ips.c} (99%)
 rename drivers/platform/x86/{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c} (100%)
 rename drivers/platform/x86/{intel_oaktrail.c => intel/oaktrail.c} (100%)
 create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc/Makefile
 rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (99%)
 rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (100%)
 rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c} (100%)
 rename drivers/platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c} (100%)
 rename drivers/platform/x86/{intel-rst.c => intel/rst.c} (100%)
 create mode 100644 drivers/platform/x86/intel/scu/Kconfig
 create mode 100644 drivers/platform/x86/intel/scu/Makefile
 rename drivers/platform/x86/{intel_scu_ipc.c => intel/scu/ipc.c} (99%)
 rename drivers/platform/x86/{intel_scu_ipcutil.c => intel/scu/ipcutil.c} (100%)
 rename drivers/platform/x86/{intel_scu_pcidrv.c => intel/scu/pcidrv.c} (100%)
 rename drivers/platform/x86/{intel_scu_pltdrv.c => intel/scu/pltdrv.c} (100%)
 rename drivers/platform/x86/{intel_scu_wdt.c => intel/scu/wdt.c} (100%)
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

