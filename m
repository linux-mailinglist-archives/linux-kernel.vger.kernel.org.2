Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E43C369D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGJTyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 15:54:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:28006 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhGJTyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 15:54:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10041"; a="197114993"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="197114993"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 12:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="411671328"
Received: from otcpl-manager.jf.intel.com (HELO localhost.localdomain) ([10.54.39.234])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2021 12:51:21 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     mgross@linux.intel.com, hdegoede@redhat.com,
        irenic.rajneesh@gmail.com, andriy.shevchenko@linux.intel.com,
        vicamo.yang@canonical.com, srinivas.pandruvada@intel.com,
        david.e.box@intel.com, linux-kernel@vger.kernel.org,
        tamar.mashiah@intel.com, gregkh@linuxfoundation.org,
        rajatja@google.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, mlimonci@amd.com,
        Gayatri Kammela <gayatri.kammela@intel.com>
Subject: [PATCH v3 0/5] Add Alder Lake PCH-S support to PMC core driver
Date:   Sat, 10 Jul 2021 12:48:12 -0700
Message-Id: <cover.1625944730.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The patch series move intel_pmc_core* files to pmc subfolder as well as
add Alder Lake PCH-S support to PMC core driver.

Patch 1: Move intel_pmc_core* files to pmc subfolder
Patch 2: Add Alderlake support to pmc core driver
Patch 3: Add Latency Tolerance Reporting (LTR) support to Alder Lake
Patch 4: Add Alder Lake low power mode support for pmc core
Patch 5: Add GBE Package C10 fix for Alder Lake

Changes since v1:
1) Add patch 1 to v2 i.e., Move intel_pmc_core* files to pmc subfolder
2) Modify commit message for patch 2.

Changes since v2:
1) Dropped intel_pmc_ prefix from the file names 

David E. Box (1):
  platform/x86/intel: pmc/core: Add GBE Package C10 fix for Alder Lake
    PCH

Gayatri Kammela (4):
  platform/x86/intel: intel_pmc_core: Move intel_pmc_core* files to pmc
    subfolder
  platform/x86/intel: pmc/core: Add Alderlake support to pmc core driver
  platform/x86/intel: pmc/core: Add Latency Tolerance Reporting (LTR)
    support to Alder Lake
  platform/x86/intel: pmc/core: Add Alder Lake low power mode support
    for pmc core

 drivers/platform/x86/Kconfig                  |  21 --
 drivers/platform/x86/Makefile                 |   1 -
 drivers/platform/x86/intel/Kconfig            |   1 +
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/pmc/Kconfig        |  22 ++
 drivers/platform/x86/intel/pmc/Makefile       |   5 +
 .../{intel_pmc_core.c => intel/pmc/core.c}    | 307 +++++++++++++++++-
 .../{intel_pmc_core.h => intel/pmc/core.h}    |  17 +
 .../pmc/pltdrv.c}                             |   0
 9 files changed, 350 insertions(+), 25 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc/Makefile
 rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (85%)
 rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (95%)
 rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c} (100%)

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Cc: You-Sheng Yang <vicamo.yang@canonical.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>

base-commit: 81361b837a3450f0a44255fddfd7a4c72502b667
-- 
2.25.1

