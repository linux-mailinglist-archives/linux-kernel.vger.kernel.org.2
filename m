Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C2434C485
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhC2HDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:20045 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhC2HCw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:52 -0400
IronPort-SDR: fFhIIcPe0HTbrbs9SIdjqMNga7CTdeDESjMwHBnbLYzR2t63twmwXxMhd54oL11vm1aNitGTzJ
 c9WUvW0BAsTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956335"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956335"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:51 -0700
IronPort-SDR: AlxYYldW18YTeLt55oiZGzbVqy1hXAjrcRJJwsXm7WGVGO3dVi4qSkZFkGNdz14kXP17Q5tbfY
 3lE5ObVsh8fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677691"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:49 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 26/27] perf tests: Skip 'perf stat metrics (shadow stat) test' for hybrid
Date:   Mon, 29 Mar 2021 15:00:45 +0800
Message-Id: <20210329070046.8815-27-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
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
v3:
 - No functional change.

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

