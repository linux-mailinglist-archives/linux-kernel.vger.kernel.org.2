Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5330979E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhA3SqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:46:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:15035 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhA3SqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:46:09 -0500
IronPort-SDR: +zjwaK1SEO/42tpYSU8we4GQkGpP301jHpNYF332SAfhRBETPfl6r9k3iNzsr+aPqcZuKEMOMc
 mAj2daVE/RZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9880"; a="265377340"
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="265377340"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 10:45:28 -0800
IronPort-SDR: a/KzP5c3+pFY7gYOvTYU9k+UK28q2gz+H5skfYj/VSJIyhlbOjbjbvg3vL3YsI6fcsRb1dDbDA
 ZFdF37tEHvSQ==
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="580053458"
Received: from km-skylake-client-platform.sc.intel.com ([172.25.103.115])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 10:45:28 -0800
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org, ricardo.neri@intel.com, ravi.v.shankar@intel.com,
        kevin.tian@intel.com, ashok.raj@intel.com, sohil.mehta@intel.com,
        kyung.min.park@intel.com
Subject: [PATCH v5 0/2] Audit Capability and Extended Capability among IOMMUs
Date:   Sat, 30 Jan 2021 10:44:50 -0800
Message-Id: <20210130184452.31711-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern platforms have more than one IOMMU. Each IOMMU has its own
feature set. Some of these features must be consistent among IOMMUs.
Otherwise, these differences can lead to improper behavior in the system.
On the other hand, for some features, each IOMMU can have different
capacity values. So, different actions are required to deal with the
inconsistencies depending on the IOMMU features.

Currently, some inconsistencies are ignored by the IOMMU driver.
This patchset checks IOMMU capabilities and extended capabilities
centralizedly during boot and take different actions according to
the impacts caused by the mismatches.

For example:
 1. Use common capacity values (normally the lowest capacity value) for
    all IOMMUs.
 2. Report feature mismatches.

Detailed information on the IOMMU Capability / Extended Capability can
be found in Intel VT-d Specification.

Link: https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf

ChangeLog:
- Change from v4 to v5:
  1. Drop the SVM coherency policy from this patchset.
- Change from v3 to v4:
  1. fix the build error for when only enabled irq remapping.
- Change from v2 to v3:
  1. fix the wrong macro names and rebase to v5.10.
- Change from v1 to v2:
  1. Add missing cap/ecaps for audit.
  2. Refactor function/macros overal suggested by Lu, Baolu.
  2. Skip audit for gfx dedicated IOMMU.
  3. Change commit message.

Kyung Min Park (2):
  iommu/vt-d: Audit IOMMU Capabilities and add helper functions
  iommu/vt-d: Move capability check code to cap_audit files

 drivers/iommu/intel/Makefile        |   4 +-
 drivers/iommu/intel/cap_audit.c     | 205 ++++++++++++++++++++++++++++
 drivers/iommu/intel/cap_audit.h     | 130 ++++++++++++++++++
 drivers/iommu/intel/iommu.c         |  85 ++----------
 drivers/iommu/intel/irq_remapping.c |   8 ++
 include/linux/intel-iommu.h         |  39 +++---
 6 files changed, 377 insertions(+), 94 deletions(-)
 create mode 100644 drivers/iommu/intel/cap_audit.c
 create mode 100644 drivers/iommu/intel/cap_audit.h

-- 
2.17.1

