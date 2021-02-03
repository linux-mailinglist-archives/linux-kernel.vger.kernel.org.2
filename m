Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E042A30D684
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhBCJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:44:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:52802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233105AbhBCJnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:43:55 -0500
IronPort-SDR: wv0GdXsq+ihYGybs5XCBrjBKDuQXXbi1hwIaztW+bMyuSlNtd2kpCDuARyDNEZFLGxU3RviT+G
 3h+GvbiSChpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="199968612"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="199968612"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:42:09 -0800
IronPort-SDR: 4di4MGDNauou9gr9WYEvpec2zJ1u4a8jz8BZpnPBC6F9Xc4pmyEn1r9gPN4EwTyYPVfRmIb12r
 P0PlzUbkrWkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="480285024"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2021 01:42:08 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Yian Chen <yian.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/3] iommu/vt-d: Add support for ACPI/SATC table
Date:   Wed,  3 Feb 2021 17:33:25 +0800
Message-Id: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel VT-d specification v3.2 comes with a new ACPI SATC (SoC-
Integrated Address Translation Cache) reporting structure. The SoC
integrated device enumerated in this table has a functional
requirement to enable its ATC (Address Translation Cache) via the
ATS capability for device operation.

This patch set adds the code to parse the SATC table, enumerates the
devices in it and satisfies the ATS requirement for them. Please help
to review. I will queue it in VT-d update for v5.12 if no objection.

Yian Chen (3):
  iommu/vt-d: Add new enum value and structure for SATC
  iommu/vt-d: Parse SATC reporting structure
  iommu/vt-d: Apply SATC policy

 drivers/iommu/intel/dmar.c  |   8 ++
 drivers/iommu/intel/iommu.c | 162 +++++++++++++++++++++++++++++++++++-
 include/acpi/actbl1.h       |  11 ++-
 include/linux/dmar.h        |   2 +
 4 files changed, 178 insertions(+), 5 deletions(-)

-- 
2.25.1

