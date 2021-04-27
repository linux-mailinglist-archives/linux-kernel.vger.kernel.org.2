Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969FA36BFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhD0HFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:05:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:54968 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237395AbhD0HFE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:05:04 -0400
IronPort-SDR: dztcLzEOH5Ay3ScbSRs7JGVcbDGKOoAO6BIGfrPs60qCoOTAId1ejjUlqmg5DZqiQ+yEZ5VBAB
 F7wArSl2nOqA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573096"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573096"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:04:16 -0700
IronPort-SDR: nbnZzQYe1v9dYkXP8cS0m+kiVWvaYoj9r0LuCG9UdWPWy9jJbsmKQLIncqe1tR1K7vOuQCiDb9
 efBAdy/F4OSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447507046"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:04:13 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 25/26] perf tests: Skip 'perf stat metrics (shadow stat) test' for hybrid
Date:   Tue, 27 Apr 2021 15:01:38 +0800
Message-Id: <20210427070139.25256-26-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we don't support shadow stat for hybrid.

  root@ssp-pwrt-002:~# ./perf stat -e cycles,instructions -a -- sleep 1

   Performance counter stats for 'system wide':

      12,883,109,591      cpu_core/cycles/
       6,405,163,221      cpu_atom/cycles/
         555,553,778      cpu_core/instructions/
         841,158,734      cpu_atom/instructions/

         1.002644773 seconds time elapsed

Now there is no shadow stat 'insn per cycle' reported. We will support
it later and now just skip the 'perf stat metrics (shadow stat) test'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v6:
 - No change.

 tools/perf/tests/shell/stat+shadow_stat.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index ebebd3596cf9..e6e35fc6c882 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -7,6 +7,9 @@ set -e
 # skip if system-wide mode is forbidden
 perf stat -a true > /dev/null 2>&1 || exit 2
 
+# skip if on hybrid platform
+perf stat -a -e cycles sleep 1 2>&1 | grep -e cpu_core && exit 2
+
 test_global_aggr()
 {
 	perf stat -a --no-big-num -e cycles,instructions sleep 1  2>&1 | \
-- 
2.17.1

