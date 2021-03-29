Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E234C49C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhC2HJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:09:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:42205 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhC2HJd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:09:33 -0400
IronPort-SDR: 6ghwyP7c+DTwziECI+3wEwOBE4Dlt8I/rmWXH3RyqdPSLqL9ZE3DDvmuIte2dHNuEzUWGQGUyL
 PVlFPy9FM2Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="170895413"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="170895413"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:09:32 -0700
IronPort-SDR: 9y3o4pZzF1F4AeXLRBxzyw1oRrMOMYrkwz3q4jWv3PsAfBBzsx7MT6sP3t4RowLcgPI70td6df
 UlVREcP9DAgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444679957"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:09:30 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf vendor events: Add missing model numbers
Date:   Mon, 29 Mar 2021 15:09:03 +0800
Message-Id: <20210329070903.8894-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel has supported COMETLAKE/COMETLAKE_L to use the SKYLAKE
events and supported TIGERLAKE_L/TIGERLAKE/ROCKETLAKE to use
the ICELAKE events. But pmu-events mapfile.csv is missing
these model numbers.

Now add the missing model numbers to mapfile.csv.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 2f2a209e87e1..6455f06f35d3 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -24,6 +24,7 @@ GenuineIntel-6-1F,v2,nehalemep,core
 GenuineIntel-6-1A,v2,nehalemep,core
 GenuineIntel-6-2E,v2,nehalemex,core
 GenuineIntel-6-[4589]E,v24,skylake,core
+GenuineIntel-6-A[56],v24,skylake,core
 GenuineIntel-6-37,v13,silvermont,core
 GenuineIntel-6-4D,v13,silvermont,core
 GenuineIntel-6-4C,v13,silvermont,core
@@ -35,6 +36,8 @@ GenuineIntel-6-55-[01234],v1,skylakex,core
 GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
+GenuineIntel-6-8[CD],v1,icelake,core
+GenuineIntel-6-A7,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-- 
2.17.1

