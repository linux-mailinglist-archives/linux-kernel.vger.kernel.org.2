Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFE6362D1C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhDQDNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:13:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:34209 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233847AbhDQDNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:13:15 -0400
IronPort-SDR: ZFsJDSCMbK+qc6mLIE989boTh0LHCAEXhzeWFh/ZIl8B4tWHF4bGc8f4U8HK5SmzBsMlmK0fNu
 5BKA+of0j36Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256455864"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="256455864"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 20:12:48 -0700
IronPort-SDR: ijXxBUt3JSXVOQQhof1CCgz8uPK45mTXdoH4FcBu01J/vkzXCf2Lg2mzia5TQthoUHH728up66
 iyVgAEOfu/wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="384487374"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 16 Apr 2021 20:12:48 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id C1649580890;
        Fri, 16 Apr 2021 20:12:48 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/9] intel_pmc_core: Add sub-state requirements and mode
Date:   Fri, 16 Apr 2021 20:12:43 -0700
Message-Id: <20210417031252.3020837-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Patch 1 and 2 remove the use of the global struct pmc_dev
- Patches 3-7 add support for reading low power mode sub-state
  requirements, latching sub-state status on different low power mode
  events, and displaying the sub-state residency in microseconds
- Patch 8 adds missing LTR IPs for TGL
- Patch 9 adds support for ADL-P which is based on TGL

Applied on top of latest hans-review/review-hans

Patches that changed in V2:
	Patch 3: Variable name change
	Patch 5: Do proper cleanup after fail
	Patch 7: Debugfs write function fixes

David E. Box (4):
  platform/x86: intel_pmc_core: Don't use global pmcdev in quirks
  platform/x86: intel_pmc_core: Remove global struct pmc_dev
  platform/x86: intel_pmc_core: Add option to set/clear LPM mode
  platform/x86: intel_pmc_core: Add support for Alder Lake PCH-P

Gayatri Kammela (5):
  platform/x86: intel_pmc_core: Handle sub-states generically
  platform/x86: intel_pmc_core: Show LPM residency in microseconds
  platform/x86: intel_pmc_core: Get LPM requirements for Tiger Lake
  platform/x86: intel_pmc_core: Add requirements file to debugfs
  platform/x86: intel_pmc_core: Add LTR registers for Tiger Lake

 drivers/platform/x86/intel_pmc_core.c | 384 +++++++++++++++++++++++---
 drivers/platform/x86/intel_pmc_core.h |  47 +++-
 2 files changed, 395 insertions(+), 36 deletions(-)


base-commit: 823b31517ad3196324322804ee365d5fcff704d6
-- 
2.25.1

