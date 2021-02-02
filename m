Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B639730B6B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhBBEwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:52:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:54657 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231597AbhBBEwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:52:46 -0500
IronPort-SDR: hdoM7WeHwap2ft3IFB+MW7tI9UoCsqft7ouvGdOWONKRsO4di8UeHfWtr7ebj5PYMwA5ZmzubT
 qsfOUK3h4Viw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180020411"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="180020411"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 20:49:25 -0800
IronPort-SDR: 1lAE3OWH1MDJokNweNf9yHQ+WZ8pajDbquDw52AHFbF93hyDajy5+HMrR6BxbxX9dJFgPKxLfZ
 cgAHU5OjOzOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="479423171"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2021 20:49:23 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Yian Chen <yian.chen@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/3] iommu/vt-d: Add support for ACPI/SATC table
Date:   Tue,  2 Feb 2021 12:40:54 +0800
Message-Id: <20210202044057.615277-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel platform VT-d (v3.2) comes with a new type of DMAR subtable
SATC. The SATC table includes a list of SoC integrated devices
that require SATC. OS software can use this table to enable ATS
only for the devices in the list.

Yian Chen (3):
  iommu/vt-d: Add new enum value and structure for SATC
  iommu/vt-d: Parse SATC reporting structure
  iommu/vt-d: Apply SATC policy

 drivers/iommu/intel/dmar.c  |   9 ++
 drivers/iommu/intel/iommu.c | 161 +++++++++++++++++++++++++++++++++++-
 include/acpi/actbl1.h       |  11 ++-
 include/linux/dmar.h        |   2 +
 4 files changed, 178 insertions(+), 5 deletions(-)

-- 
2.25.1

