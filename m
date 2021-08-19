Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7E83F1198
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhHSDbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236048AbhHSDa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629343823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NGXQZDGM2/GOGMfJGWUTZlzTZlgVi46X8EkUfmafloo=;
        b=OAsVNx1QgNgpdjRJ+4fJ3MMuaOGluK7zEYI6Ct98QkiaVIQiIo2eC1muszCFg8vZWoPnQ0
        Upf8lKDFZ8TyupPa1g8eW2aKZSfyjSU7+wBWIHfgSu64mxVu/BdodBLC//SqKtgrtu8Aye
        sQBpemMBCYixLJMOcZzcnYuxMivMQ7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-8NAls8AhMWizA8YAJFh_jg-1; Wed, 18 Aug 2021 23:30:21 -0400
X-MC-Unique: 8NAls8AhMWizA8YAJFh_jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 296DD8799EE;
        Thu, 19 Aug 2021 03:30:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E06302C00F;
        Thu, 19 Aug 2021 03:30:15 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org, Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v3 00/20] Intel platform driver code movement
Date:   Thu, 19 Aug 2021 11:29:41 +0800
Message-Id: <20210819033001.20136-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 has some improvement and listed below.
kconfig typo correction.
commit message improvement.
Fix two kernel test robot fail issues.

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
  platform/x86: intel_atomisp2_led: Move to intel sub-directory
  platform/x86: intel-hid: Move to intel sub-directory
  platform/x86: intel_int0002_vgpio: Move to intel sub-directory
  platform/x86: intel_oaktrail: Move to intel sub-directory
  platform/x86: intel-vbtn: Move to intel sub-directory
  platform/x86: intel-wmi-sbl-fw-updat: Move to intel sub-directory
  platform/x86: intel-wmi-thunderbolt: Move to intel sub-directory

 drivers/platform/x86/Kconfig                  | 287 ------------------
 drivers/platform/x86/Makefile                 |  34 +--
 drivers/platform/x86/intel/Kconfig            | 160 ++++++++++
 drivers/platform/x86/intel/Makefile           |  44 +++
 drivers/platform/x86/intel/atomisp2/Kconfig   |  38 +++
 drivers/platform/x86/intel/atomisp2/Makefile  |   9 +
 .../atomisp2/led.c}                           |   0
 .../atomisp2/pm.c}                            |   0
 .../{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c}  |   0
 .../chtdc_ti_pwrbtn.c}                        |   0
 .../platform/x86/{intel-hid.c => intel/hid.c} |   2 +-
 .../int0002_vgpio.c}                          |   0
 .../platform/x86/{intel_ips.c => intel/ips.c} |   2 +-
 .../mrfld_pwrbtn.c}                           |   0
 .../{intel_oaktrail.c => intel/oaktrail.c}    |   0
 drivers/platform/x86/intel/pmc/Kconfig        |  26 ++
 drivers/platform/x86/intel/pmc/Makefile       |   9 +
 .../x86/{ => intel/pmc}/intel_pmc_core.h      |   0
 .../pmc/pmc_core.c}                           |   0
 .../pmc/pmc_core_pltdrv.c}                    |   0
 .../{intel_punit_ipc.c => intel/punit_ipc.c}  |   0
 .../platform/x86/{intel-rst.c => intel/rst.c} |   0
 drivers/platform/x86/intel/scu/Kconfig        |  52 ++++
 drivers/platform/x86/intel/scu/Makefile       |  13 +
 .../x86/{intel_scu_ipc.c => intel/scu/ipc.c}  |   0
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
 drivers/platform/x86/intel/wmi/Kconfig        |  26 ++
 drivers/platform/x86/intel/wmi/Makefile       |   9 +
 .../wmi/sbl-fw-update.c}                      |   0
 .../wmi/thunderbolt.c}                        |   0
 49 files changed, 419 insertions(+), 321 deletions(-)
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
 rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.h (100%)
 rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/pmc_core.c} (100%)
 rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pmc_core_pltdrv.c} (100%)
 rename drivers/platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c} (100%)
 rename drivers/platform/x86/{intel-rst.c => intel/rst.c} (100%)
 create mode 100644 drivers/platform/x86/intel/scu/Kconfig
 create mode 100644 drivers/platform/x86/intel/scu/Makefile
 rename drivers/platform/x86/{intel_scu_ipc.c => intel/scu/ipc.c} (100%)
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
2.31.1

