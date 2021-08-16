Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0130B3ED275
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhHPKw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232390AbhHPKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BIzgbmYZkr1EEatnyen10+GPtx+Y05HjwFLgssfCMqU=;
        b=i4sadv410e3o65QhTfBJ2SP1MDytfYa/6jncunFFNTvmOQP0XJRNvCWtKmRBS1mZoLQMmp
        WPgPooykkzPeUN+p661hZIXGPhwa4gi6eEP1LSfAFVG7HGkYw1opiDEeMmjTLHu/hqoTic
        gIUo3fyUGROLyhCxgYJlxR+Ij8WlYug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-di-BVEugNmWftIhtt-udVg-1; Mon, 16 Aug 2021 06:52:20 -0400
X-MC-Unique: di-BVEugNmWftIhtt-udVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C1A87D541;
        Mon, 16 Aug 2021 10:52:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E8796788D;
        Mon, 16 Aug 2021 10:52:15 +0000 (UTC)
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
Subject: [PATCH v2 00/20] Intel platform driver code movement.
Date:   Mon, 16 Aug 2021 18:50:59 +0800
Message-Id: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the version 2 of code movement for Intel platform drivers. 
All the Intel related platform drivers were moved to intel sub-directory
to improve readability. The filenames with prefix intel_ were removed
and all the module ko files kept their original names.

Since intel_ips.h was refered by Intel i915 GPU DRM driver, it
was ketp in original localtion.

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
  platform/x86: intel_oaktrail.c: Move to intel sub-directory
  platform/x86: intel-vbtn: Move to intel sub-directory
  platform/x86: intel-wmi-sbl-fw-updat: Move to intel sub-directory
  platform/x86: intel-wmi-thunderbolt: Move to intel sub-directory

 drivers/platform/x86/Kconfig                  | 287 ------------------
 drivers/platform/x86/Makefile                 |  32 +-
 drivers/platform/x86/intel/Kconfig            | 160 ++++++++++
 drivers/platform/x86/intel/Makefile           |  47 +++
 drivers/platform/x86/intel/atomisp2/Kconfig   |  35 +++
 drivers/platform/x86/intel/atomisp2/Makefile  |   5 +
 .../atomisp2/led.c}                           |   0
 .../atomisp2/pm.c}                            |   0
 .../{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c}  |   0
 .../chtdc_ti_pwrbtn.c}                        |   0
 .../platform/x86/{intel-hid.c => intel/hid.c} |   0
 .../int0002_vgpio.c}                          |   0
 .../platform/x86/{intel_ips.c => intel/ips.c} |   0
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
 drivers/platform/x86/intel/scu/Makefile       |  16 +
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
 .../telemetry/telemetry_core.c}               |   0
 .../telemetry/telemetry_debugfs.c}            |   0
 .../telemetry/telemetry_pltdrv.c}             |   0
 .../turbo_max_3.c}                            |   0
 .../uncore-frequency.c}                       |   0
 .../x86/{intel-vbtn.c => intel/vbtn.c}        |   0
 drivers/platform/x86/intel/wmi/Kconfig        |  26 ++
 drivers/platform/x86/intel/wmi/Makefile       |   9 +
 .../wmi/sbl-fw-update.c}                      |   0
 .../wmi/thunderbolt.c}                        |   0
 49 files changed, 413 insertions(+), 318 deletions(-)
 create mode 100644 drivers/platform/x86/intel/atomisp2/Kconfig
 create mode 100644 drivers/platform/x86/intel/atomisp2/Makefile
 rename drivers/platform/x86/{intel_atomisp2_led.c => intel/atomisp2/led.c} (100%)
 rename drivers/platform/x86/{intel_atomisp2_pm.c => intel/atomisp2/pm.c} (100%)
 rename drivers/platform/x86/{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c} (100%)
 rename drivers/platform/x86/{intel_chtdc_ti_pwrbtn.c => intel/chtdc_ti_pwrbtn.c} (100%)
 rename drivers/platform/x86/{intel-hid.c => intel/hid.c} (100%)
 rename drivers/platform/x86/{intel_int0002_vgpio.c => intel/int0002_vgpio.c} (100%)
 rename drivers/platform/x86/{intel_ips.c => intel/ips.c} (100%)
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
 rename drivers/platform/x86/{intel_telemetry_core.c => intel/telemetry/telemetry_core.c} (100%)
 rename drivers/platform/x86/{intel_telemetry_debugfs.c => intel/telemetry/telemetry_debugfs.c} (100%)
 rename drivers/platform/x86/{intel_telemetry_pltdrv.c => intel/telemetry/telemetry_pltdrv.c} (100%)
 rename drivers/platform/x86/{intel_turbo_max_3.c => intel/turbo_max_3.c} (100%)
 rename drivers/platform/x86/{intel-uncore-frequency.c => intel/uncore-frequency.c} (100%)
 rename drivers/platform/x86/{intel-vbtn.c => intel/vbtn.c} (100%)
 create mode 100644 drivers/platform/x86/intel/wmi/Kconfig
 create mode 100644 drivers/platform/x86/intel/wmi/Makefile
 rename drivers/platform/x86/{intel-wmi-sbl-fw-update.c => intel/wmi/sbl-fw-update.c} (100%)
 rename drivers/platform/x86/{intel-wmi-thunderbolt.c => intel/wmi/thunderbolt.c} (100%)

-- 
2.31.1

