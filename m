Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F290350CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhDADGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:06:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:60449 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232419AbhDADGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:06:16 -0400
IronPort-SDR: nyo7uTnkdZYpvusaMcqTefu9CaoHLo+JLKDJJHH4o25U5JdCCZ8ML9BWOCL4WjCxip7ib1P9A2
 EJTC/i9ihymw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192241095"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="192241095"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 20:06:16 -0700
IronPort-SDR: cwcJR3Vt1jGgo7FXlwK7cIzVnFrGCNdCGImzxEOWCOCoFl+dUy2yMwImJBBI4QGnBx8iMhH1gz
 IS+83p9e5kHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="416487602"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2021 20:06:16 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 35A72580932;
        Wed, 31 Mar 2021 20:06:16 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        david.e.box@linux.intel.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] intel_pmc_core: Add sub-state requirements and mode latching support
Date:   Wed, 31 Mar 2021 20:05:49 -0700
Message-Id: <20210401030558.2301621-1-david.e.box@linux.intel.com>
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

Applied on top of latest 5.12-rc2 based hans-review/review-hans

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

 drivers/platform/x86/intel_pmc_core.c | 359 +++++++++++++++++++++++---
 drivers/platform/x86/intel_pmc_core.h |  47 +++-
 2 files changed, 370 insertions(+), 36 deletions(-)

-- 
2.25.1

