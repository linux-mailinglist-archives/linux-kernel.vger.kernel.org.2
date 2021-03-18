Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A343410A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 00:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhCRXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 19:07:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:25251 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhCRXHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 19:07:36 -0400
IronPort-SDR: tl1U9nYTzcwrIFn5Et9KmncSMk42yY8Qptf+U29qvkE1woh3rXWc5b1y45P4s7LZ9ZsfFYTwpT
 ff4u7ulIQqBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169709420"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="169709420"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 16:07:36 -0700
IronPort-SDR: ROBBYi5htD/iEBHdDoX3qJtSWU1/iyEaKJRh0vT1pYOYf6qNaOFaHH7ZYdydX4UMTTJtF9RnHN
 3OF30KKTmiow==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="450654431"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 16:07:29 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Sang <oliver.sang@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/highmem: Fix CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
Date:   Thu, 18 Mar 2021 16:06:57 -0700
Message-Id: <20210318230657.1497881-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The kernel test robot found that __kmap_local_sched_out() was not
correctly skipping the guard pages when
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP was set.[1]  This was due to
CONFIG_DEBUG_HIGHMEM check being used.

Change the configuration check to be correct.

[1] https://lore.kernel.org/lkml/20210304083825.GB17830@xsang-OptiPlex-9020/

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Oliver Sang <oliver.sang@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 0e91a0c6984c ("mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/highmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 86f2b9495f9c..6ef8f5e05e7e 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -618,7 +618,7 @@ void __kmap_local_sched_out(void)
 		int idx;
 
 		/* With debug all even slots are unmapped and act as guard */
-		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+		if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL) && !(i & 0x01)) {
 			WARN_ON_ONCE(!pte_none(pteval));
 			continue;
 		}
@@ -654,7 +654,7 @@ void __kmap_local_sched_in(void)
 		int idx;
 
 		/* With debug all even slots are unmapped and act as guard */
-		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+		if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL) && !(i & 0x01)) {
 			WARN_ON_ONCE(!pte_none(pteval));
 			continue;
 		}
-- 
2.28.0.rc0.12.gb6a658bd00c9

