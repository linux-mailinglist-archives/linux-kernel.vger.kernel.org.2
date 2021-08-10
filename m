Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8F63E57B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbhHJJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237569AbhHJJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zN6qKivEYr8kPW6Y2yws2ebQ9uvWuGxGHnqz0DEl4CU=;
        b=Twe3LfexdkGwpMUWp8IplTrSqxq4m0L8922S0DKp87vbTo7Sdiob1jIvRLyc0ztHOSOlah
        wPfp5/u5Tso5ksFH+qAu06guOdnCFAzilQseZc2PSocG1Rq2gyTVmYGt37WFUhICmKSOd9
        aqWQwr93frNJR15lyopY6eda4f6ijp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-5HKmaxInNt6A6m02IbGpCA-1; Tue, 10 Aug 2021 05:58:58 -0400
X-MC-Unique: 5HKmaxInNt6A6m02IbGpCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5AF8107ACF5;
        Tue, 10 Aug 2021 09:58:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16D1D60C9D;
        Tue, 10 Aug 2021 09:58:50 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org, Kate Hsuan <hpa@redhat.com>
Subject: [PATCH 00/20] Move Intel platform drivers to intel directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:12 +0800
Message-Id: <20210810095832.4234-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the intel platform specific drivers are moved to intel/.
It makes more clear file structure to improve the readability.

Kate Hsuan (20):
  Move Intel hid of pdx86 to intel directory to improve readability.
  Move Intel WMI driver of pdx86 to intel/ directory to improve
    readability.
  Move Intel bxtwc driver of pdx86 to intel/ directory to improve
    readability.
  Move Intel chtdc_ti driver of pdx86 to improve readability.
  Move MRFLD power button driver of pdx86 to intel directory to improve
    readability.
  Move Intel PMC core of pdx86 to intel/ directory to improve
    readability.
  Move Intel PMT driver of pdx86 to intel/ to improve readability.
  Move Intel P-Unit of pdx86 to intel/ directory to improve readability.
  Move Intel SCU IPC of pdx86 to intel directory to increase
    readability.
  Move Intel SoC telemetry driver to intel directory to improve
    readability.
  Move Intel IPS driver of pdx86 to improve readability.
  Move Intel RST driver of pdx86 to intel directory to improve
    readability.
  Move Intel smartconnect driver of pdx86 to intel/ directory to improve
    readability.
  Move Intel SST driver to intel/ directory to improve readability.
  Move Intel turbo max 3 driver to intel/ directory to improve
    readability.
  Move Intel uncore freq driver to intel/ directory to improve
    readability.
  Move Intel int0002 vgpio driver to intel/ directory to inprove
    readability.
  Move Intel thermal driver for menlow platform driver to intel/
    directory to improve readability.
  Move OakTrail driver to the intel/ directory to improve readability.
  Move Intel virtual botton driver to intel/ directory to improve
    readability.

 drivers/platform/x86/Kconfig                  | 297 ------------------
 drivers/platform/x86/Makefile                 |  34 +-
 drivers/platform/x86/intel/Kconfig            |  21 ++
 drivers/platform/x86/intel/Makefile           |  31 ++
 drivers/platform/x86/intel/bxtwc/Kconfig      |  15 +
 drivers/platform/x86/intel/bxtwc/Makefile     |   6 +
 .../x86/{ => intel/bxtwc}/intel_bxtwc_tmu.c   |   0
 drivers/platform/x86/intel/chtdc_ti/Kconfig   |  16 +
 drivers/platform/x86/intel/chtdc_ti/Makefile  |   7 +
 .../chtdc_ti}/intel_chtdc_ti_pwrbtn.c         |   0
 drivers/platform/x86/intel/hid/Kconfig        |  17 +
 drivers/platform/x86/intel/hid/Makefile       |   7 +
 .../platform/x86/{ => intel/hid}/intel-hid.c  |   0
 drivers/platform/x86/intel/int0002/Kconfig    |  23 ++
 drivers/platform/x86/intel/int0002/Makefile   |   6 +
 .../{ => intel/int0002}/intel_int0002_vgpio.c |   0
 .../{ => intel}/intel_speed_select_if/Kconfig |   0
 .../intel_speed_select_if/Makefile            |   0
 .../intel_speed_select_if/isst_if_common.c    |   0
 .../intel_speed_select_if/isst_if_common.h    |   0
 .../intel_speed_select_if/isst_if_mbox_msr.c  |   0
 .../intel_speed_select_if/isst_if_mbox_pci.c  |   0
 .../intel_speed_select_if/isst_if_mmio.c      |   0
 drivers/platform/x86/intel/ips/Kconfig        |  14 +
 drivers/platform/x86/intel/ips/Makefile       |   6 +
 .../platform/x86/{ => intel/ips}/intel_ips.c  |   0
 .../platform/x86/{ => intel/ips}/intel_ips.h  |   0
 drivers/platform/x86/intel/menlow/Kconfig     |  14 +
 drivers/platform/x86/intel/menlow/Makefile    |   6 +
 .../x86/{ => intel/menlow}/intel_menlow.c     |   0
 drivers/platform/x86/intel/mrfld/Kconfig      |  17 +
 drivers/platform/x86/intel/mrfld/Makefile     |   6 +
 .../{ => intel/mrfld}/intel_mrfld_pwrbtn.c    |   0
 drivers/platform/x86/intel/oaktrail/Kconfig   |  15 +
 drivers/platform/x86/intel/oaktrail/Makefile  |   6 +
 .../x86/{ => intel/oaktrail}/intel_oaktrail.c |   0
 drivers/platform/x86/intel/pmc_core/Kconfig   |  26 ++
 drivers/platform/x86/intel/pmc_core/Makefile  |   6 +
 .../x86/{ => intel/pmc_core}/intel_pmc_core.c |   0
 .../x86/{ => intel/pmc_core}/intel_pmc_core.h |   0
 .../pmc_core}/intel_pmc_core_pltdrv.c         |   0
 drivers/platform/x86/intel/pmt/Kconfig        |  41 +++
 drivers/platform/x86/intel/pmt/Makefile       |   9 +
 .../x86/{ => intel/pmt}/intel_pmt_class.c     |   0
 .../x86/{ => intel/pmt}/intel_pmt_class.h     |   0
 .../x86/{ => intel/pmt}/intel_pmt_crashlog.c  |   0
 .../x86/{ => intel/pmt}/intel_pmt_telemetry.c |   0
 drivers/platform/x86/intel/punit/Kconfig      |  10 +
 drivers/platform/x86/intel/punit/Makefile     |   6 +
 .../x86/{ => intel/punit}/intel_punit_ipc.c   |   0
 drivers/platform/x86/intel/rst/Kconfig        |  16 +
 drivers/platform/x86/intel/rst/Makefile       |   6 +
 .../platform/x86/{ => intel/rst}/intel-rst.c  |   0
 drivers/platform/x86/intel/scu/Kconfig        |  52 +++
 drivers/platform/x86/intel/scu/Makefile       |  11 +
 .../x86/{ => intel/scu}/intel_scu_ipc.c       |   0
 .../x86/{ => intel/scu}/intel_scu_ipcutil.c   |   0
 .../x86/{ => intel/scu}/intel_scu_pcidrv.c    |   0
 .../x86/{ => intel/scu}/intel_scu_pltdrv.c    |   0
 .../x86/{ => intel/scu}/intel_scu_wdt.c       |   0
 .../platform/x86/intel/smartconnect/Kconfig   |  18 ++
 .../platform/x86/intel/smartconnect/Makefile  |   6 +
 .../smartconnect}/intel-smartconnect.c        |   0
 drivers/platform/x86/intel/telemetry/Kconfig  |  16 +
 drivers/platform/x86/intel/telemetry/Makefile |   9 +
 .../telemetry}/intel_telemetry_core.c         |   0
 .../telemetry}/intel_telemetry_debugfs.c      |   0
 .../telemetry}/intel_telemetry_pltdrv.c       |   0
 .../platform/x86/intel/turbo_max_3/Kconfig    |  14 +
 .../platform/x86/intel/turbo_max_3/Makefile   |   6 +
 .../turbo_max_3}/intel_turbo_max_3.c          |   0
 .../platform/x86/intel/uncore_freq/Kconfig    |  15 +
 .../platform/x86/intel/uncore_freq/Makefile   |   6 +
 .../uncore_freq}/intel-uncore-frequency.c     |   0
 drivers/platform/x86/intel/vbtn/Kconfig       |  16 +
 drivers/platform/x86/intel/vbtn/Makefile      |   6 +
 .../x86/{ => intel/vbtn}/intel-vbtn.c         |   0
 drivers/platform/x86/intel/wmi/Kconfig        |  26 ++
 drivers/platform/x86/intel/wmi/Makefile       |   7 +
 .../{ => intel/wmi}/intel-wmi-sbl-fw-update.c |   0
 .../{ => intel/wmi}/intel-wmi-thunderbolt.c   |   0
 81 files changed, 562 insertions(+), 330 deletions(-)
 create mode 100644 drivers/platform/x86/intel/bxtwc/Kconfig
 create mode 100644 drivers/platform/x86/intel/bxtwc/Makefile
 rename drivers/platform/x86/{ => intel/bxtwc}/intel_bxtwc_tmu.c (100%)
 create mode 100644 drivers/platform/x86/intel/chtdc_ti/Kconfig
 create mode 100644 drivers/platform/x86/intel/chtdc_ti/Makefile
 rename drivers/platform/x86/{ => intel/chtdc_ti}/intel_chtdc_ti_pwrbtn.c (100%)
 create mode 100644 drivers/platform/x86/intel/hid/Kconfig
 create mode 100644 drivers/platform/x86/intel/hid/Makefile
 rename drivers/platform/x86/{ => intel/hid}/intel-hid.c (100%)
 create mode 100644 drivers/platform/x86/intel/int0002/Kconfig
 create mode 100644 drivers/platform/x86/intel/int0002/Makefile
 rename drivers/platform/x86/{ => intel/int0002}/intel_int0002_vgpio.c (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/Kconfig (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/Makefile (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_common.c (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_common.h (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_mbox_msr.c (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_mbox_pci.c (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_mmio.c (100%)
 create mode 100644 drivers/platform/x86/intel/ips/Kconfig
 create mode 100644 drivers/platform/x86/intel/ips/Makefile
 rename drivers/platform/x86/{ => intel/ips}/intel_ips.c (100%)
 rename drivers/platform/x86/{ => intel/ips}/intel_ips.h (100%)
 create mode 100644 drivers/platform/x86/intel/menlow/Kconfig
 create mode 100644 drivers/platform/x86/intel/menlow/Makefile
 rename drivers/platform/x86/{ => intel/menlow}/intel_menlow.c (100%)
 create mode 100644 drivers/platform/x86/intel/mrfld/Kconfig
 create mode 100644 drivers/platform/x86/intel/mrfld/Makefile
 rename drivers/platform/x86/{ => intel/mrfld}/intel_mrfld_pwrbtn.c (100%)
 create mode 100644 drivers/platform/x86/intel/oaktrail/Kconfig
 create mode 100644 drivers/platform/x86/intel/oaktrail/Makefile
 rename drivers/platform/x86/{ => intel/oaktrail}/intel_oaktrail.c (100%)
 create mode 100644 drivers/platform/x86/intel/pmc_core/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc_core/Makefile
 rename drivers/platform/x86/{ => intel/pmc_core}/intel_pmc_core.c (100%)
 rename drivers/platform/x86/{ => intel/pmc_core}/intel_pmc_core.h (100%)
 rename drivers/platform/x86/{ => intel/pmc_core}/intel_pmc_core_pltdrv.c (100%)
 create mode 100644 drivers/platform/x86/intel/pmt/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmt/Makefile
 rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_class.c (100%)
 rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_class.h (100%)
 rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_crashlog.c (100%)
 rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_telemetry.c (100%)
 create mode 100644 drivers/platform/x86/intel/punit/Kconfig
 create mode 100644 drivers/platform/x86/intel/punit/Makefile
 rename drivers/platform/x86/{ => intel/punit}/intel_punit_ipc.c (100%)
 create mode 100644 drivers/platform/x86/intel/rst/Kconfig
 create mode 100644 drivers/platform/x86/intel/rst/Makefile
 rename drivers/platform/x86/{ => intel/rst}/intel-rst.c (100%)
 create mode 100644 drivers/platform/x86/intel/scu/Kconfig
 create mode 100644 drivers/platform/x86/intel/scu/Makefile
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipc.c (100%)
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipcutil.c (100%)
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_pcidrv.c (100%)
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_pltdrv.c (100%)
 rename drivers/platform/x86/{ => intel/scu}/intel_scu_wdt.c (100%)
 create mode 100644 drivers/platform/x86/intel/smartconnect/Kconfig
 create mode 100644 drivers/platform/x86/intel/smartconnect/Makefile
 rename drivers/platform/x86/{ => intel/smartconnect}/intel-smartconnect.c (100%)
 create mode 100644 drivers/platform/x86/intel/telemetry/Kconfig
 create mode 100644 drivers/platform/x86/intel/telemetry/Makefile
 rename drivers/platform/x86/{ => intel/telemetry}/intel_telemetry_core.c (100%)
 rename drivers/platform/x86/{ => intel/telemetry}/intel_telemetry_debugfs.c (100%)
 rename drivers/platform/x86/{ => intel/telemetry}/intel_telemetry_pltdrv.c (100%)
 create mode 100644 drivers/platform/x86/intel/turbo_max_3/Kconfig
 create mode 100644 drivers/platform/x86/intel/turbo_max_3/Makefile
 rename drivers/platform/x86/{ => intel/turbo_max_3}/intel_turbo_max_3.c (100%)
 create mode 100644 drivers/platform/x86/intel/uncore_freq/Kconfig
 create mode 100644 drivers/platform/x86/intel/uncore_freq/Makefile
 rename drivers/platform/x86/{ => intel/uncore_freq}/intel-uncore-frequency.c (100%)
 create mode 100644 drivers/platform/x86/intel/vbtn/Kconfig
 create mode 100644 drivers/platform/x86/intel/vbtn/Makefile
 rename drivers/platform/x86/{ => intel/vbtn}/intel-vbtn.c (100%)
 create mode 100644 drivers/platform/x86/intel/wmi/Kconfig
 create mode 100644 drivers/platform/x86/intel/wmi/Makefile
 rename drivers/platform/x86/{ => intel/wmi}/intel-wmi-sbl-fw-update.c (100%)
 rename drivers/platform/x86/{ => intel/wmi}/intel-wmi-thunderbolt.c (100%)

-- 
2.31.1

