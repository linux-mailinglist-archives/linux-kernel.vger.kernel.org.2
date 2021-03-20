Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90E6342A25
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 04:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCTDEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 23:04:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:61111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCTDDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 23:03:49 -0400
IronPort-SDR: wx+LIm3kxa2oFvF3OsyEATQUXQaqu1wfFZ9Qtyjmz5mqLpyX0uyLwPRufXt6flrd7rHG9/wPt4
 aNnt0wIEiQ3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="186661577"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="186661577"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 20:03:49 -0700
IronPort-SDR: GtzBBybHgTE+q3gu17H1/MN7s+4+3UH6qtj1OQ6e8CwwqZDyOkXzcS0jT7MpqN0HdGy37AVFAE
 tRcWQAiNCrTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="441520667"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2021 20:03:47 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 5/5] iommu/vt-d: Avoid unnecessary cache flush in pasid entry teardown
Date:   Sat, 20 Mar 2021 10:54:15 +0800
Message-Id: <20210320025415.641201-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210320025415.641201-1-baolu.lu@linux.intel.com>
References: <20210320025415.641201-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a present pasid entry is disassembled, all kinds of pasid related
caches need to be flushed. But when a pasid entry is not being used
(PRESENT bit not set), we don't need to do this. Check the PRESENT bit
in intel_pasid_tear_down_entry() and avoid flushing caches if it's not
set.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index dd69df5a188a..7a73385edcc0 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -502,6 +502,9 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	if (WARN_ON(!pte))
 		return;
 
+	if (!(pte->val[0] & PASID_PTE_PRESENT))
+		return;
+
 	did = pasid_get_domain_id(pte);
 	intel_pasid_clear_entry(dev, pasid, fault_ignore);
 
-- 
2.25.1

