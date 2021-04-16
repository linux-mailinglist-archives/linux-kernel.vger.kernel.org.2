Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C543621CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbhDPOJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:09:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:23091 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244408AbhDPOJQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:09:16 -0400
IronPort-SDR: MX0FP0TAjxEPtma/sjFE4xDBJTypKpl5FudksUKCAiMqf+dDVbPtNJSxliMIz2Agd2gOZ/OBG8
 OF6sUKlpkJsw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854457"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854457"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:07:37 -0700
IronPort-SDR: NnmW2e7S+mIqvqy4rBBKZmMDMSBxmKcuILZ7EURNplWrQzOvaXaQ0VUDc3ceMi54WDNYkO7qEc
 AwSsr6TsofEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612767048"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:07:33 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 25/25] perf tests: Skip 'perf stat metrics (shadow stat) test' for hybrid
Date:   Fri, 16 Apr 2021 22:05:17 +0800
Message-Id: <20210416140517.18206-26-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
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

