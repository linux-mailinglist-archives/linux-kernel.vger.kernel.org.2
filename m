Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2340B6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhINSZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:25:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:52821 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhINSZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:25:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="283094766"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="283094766"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 11:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="470309638"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by fmsmga007.fm.intel.com with ESMTP; 14 Sep 2021 11:23:53 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, ak@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 2/3] Fix IIO event constraints for Skylake Server
Date:   Tue, 14 Sep 2021 21:23:48 +0300
Message-Id: <20210914182349.36186-3-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210914182349.36186-1-alexander.antonov@linux.intel.com>
References: <20210914182349.36186-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

According to the latest uncore document, COMP_BUF_OCCUPANCY (0xd5) event
can be collected on 2-3 counters. Update uncore IIO event constraints for
Skylake Server.

Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 9cc65a4194ce..4aa675a8a8eb 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3677,6 +3677,7 @@ static struct event_constraint skx_uncore_iio_constraints[] = {
 	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xd4, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
 	EVENT_CONSTRAINT_END
 };
 
-- 
2.21.3

