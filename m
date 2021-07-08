Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034303BF3D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 04:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhGHCM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 22:12:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:63770 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhGHCM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 22:12:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="206412136"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="206412136"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 19:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="449770413"
Received: from otcpl-manager.jf.intel.com (HELO localhost.localdomain) ([10.54.39.234])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2021 19:10:14 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     mgross@linux.intel.com, hdegoede@redhat.com,
        irenic.rajneesh@gmail.com, andriy.shevchenko@linux.intel.com,
        vicamo.yang@canonical.com, srinivas.pandruvada@intel.com,
        david.e.box@intel.com, linux-kernel@vger.kernel.org,
        tamar.mashiah@intel.com, gregkh@linuxfoundation.org,
        rajatja@google.com, Gayatri Kammela <gayatri.kammela@intel.com>
Subject: [PATCH v2 0/5] Add Alder Lake PCH-S support to PMC core driver
Date:   Wed,  7 Jul 2021 19:07:20 -0700
Message-Id: <cover.1625709047.git.gayatri.kammela@intel.com>
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
Patch 2: Add Alderlake support to pmc_core driver
Patch 3: Add Latency Tolerance Reporting (LTR) support to Alder Lake
Patch 4: Add Alder Lake low power mode support for pmc_core
Patch 5: Add GBE Package C10 fix for Alder Lake

Changes since v1:
1) Add patch 1 to v2 i.e., Move intel_pmc_core* files to pmc subfolder
2) Modify commit message for patch 2.

David E. Box (1):
  platform/x86: intel_pmc_core: Add GBE Package C10 fix for Alder Lake
    PCH

Gayatri Kammela (4):
  platform/x86: intel_pmc_core: Move intel_pmc_core* files to pmc
    subfolder
  platform/x86/intel: intel_pmc_core: Add Alderlake support to pmc_core
    driver
  platform/x86/intel: intel_pmc_core: Add Latency Tolerance Reporting
    (LTR) support to Alder Lake
  platform/x86/intel: intel_pmc_core: Add Alder Lake low power mode
    support for pmc_core

 drivers/platform/x86/Kconfig                  |  21 --
 drivers/platform/x86/Makefile                 |   1 -
 drivers/platform/x86/intel/Kconfig            |   1 +
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/pmc/Kconfig        |  22 ++
 drivers/platform/x86/intel/pmc/Makefile       |   5 +
 .../x86/{ => intel/pmc}/intel_pmc_core.c      | 307 +++++++++++++++++-
 .../x86/{ => intel/pmc}/intel_pmc_core.h      |  17 +
 .../{ => intel/pmc}/intel_pmc_core_pltdrv.c   |   0
 9 files changed, 350 insertions(+), 25 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
 create mode 100644 drivers/platform/x86/intel/pmc/Makefile
 rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.c (85%)
 rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.h (95%)
 rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core_pltdrv.c (100%)

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Cc: You-Sheng Yang <vicamo.yang@canonical.com>
Cc: Hans de Goede <hdegoede@redhat.com>

base-commit: a931dd33d370896a683236bba67c0d6f3d01144d
-- 
2.25.1

