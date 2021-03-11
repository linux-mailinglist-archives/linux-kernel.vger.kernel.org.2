Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A0A336CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhCKHJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231863AbhCKHJX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:09:23 -0500
IronPort-SDR: WTJ0PJ7WCUOo2EbU7PoKn+sRtyR3n7PywWwMSdfgrDY1Sfu5aM8It9mK61akNS39YQqODCfU8N
 oLjXSEysawPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246131"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246131"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:09:23 -0800
IronPort-SDR: /BoT5uFE2PbCmSYokGIXZkY5wXkvDe2RiGl2VHZgUZ1rUKQ1hP4gPfrcDl6iRl15FrZQjelXjb
 vZW/67oWiJsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509938044"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:09:20 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 26/27] perf tests: Skip 'perf stat metrics (shadow stat) test' for hybrid
Date:   Thu, 11 Mar 2021 15:07:41 +0800
Message-Id: <20210311070742.9318-27-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
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

