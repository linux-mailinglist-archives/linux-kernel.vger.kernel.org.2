Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA2347AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbhCXObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:31:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:34034 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236210AbhCXOa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:30:56 -0400
IronPort-SDR: glyNnNWFyV2LfiK5uem9QXqjJ51wBzyD17FsvnLq4xX43Re5avyFGFDsyI+A7SnrHT0SlWSpex
 JBgcMId17C1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="188412927"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="188412927"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:30:56 -0700
IronPort-SDR: OnMCmCP7vi9bY6SeAX6AfPxcIqE9JkvOXXLpf3eq4nfWpiPBVMKsvXMWcs58+yClS/XC8kKiya
 en5uaAvqNiEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="391319551"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2021 07:30:52 -0700
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH v5 4/4] perf: Update .gitignore file
Date:   Wed, 24 Mar 2021 17:30:37 +0300
Message-Id: <20210324143037.3810-5-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210324143037.3810-1-alexander.antonov@linux.intel.com>
References: <20210324143037.3810-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a "make -C tools/perf", git reports the following untracked file:
perf-iostat

Add this generated file to perf's .gitignore file.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f3f84781fd74..e555e9729758 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -20,6 +20,7 @@ perf.data.old
 output.svg
 perf-archive
 perf-with-kcore
+perf-iostat
 tags
 TAGS
 cscope*
-- 
2.19.1

