Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50683DA933
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhG2Qf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:35:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:25656 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhG2QfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:35:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="212961209"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="212961209"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 09:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="476466664"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jul 2021 09:35:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A2030108; Thu, 29 Jul 2021 19:35:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] iommu/vt-d: Drop the kernel doc annotation
Date:   Thu, 29 Jul 2021 19:35:38 +0300
Message-Id: <20210729163538.40101-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
References: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel doc validator is unhappy with the following

.../perf.c:16: warning: Function parameter or member 'latency_lock' not described in 'DEFINE_SPINLOCK'
.../perf.c:16: warning: expecting prototype for perf.c(). Prototype was for DEFINE_SPINLOCK() instead

Drop kernel doc annotation since the top comment is not in the required format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/intel/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index 73b7ec705552..0e8e03252d92 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * perf.c - performance monitor
  *
  * Copyright (C) 2021 Intel Corporation
-- 
2.30.2

