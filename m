Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43E34163D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhCSHC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 03:02:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:58016 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233963AbhCSHC2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:02:28 -0400
IronPort-SDR: 5QvUNEeeNRrVnZIWi42ggNSRB/RZpPib0IQCKVY5gI0JJeHu7A3uSMC0vH6PtGm+2kbltj3xFc
 yBNlo9qm2SDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189219776"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="189219776"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 00:02:28 -0700
IronPort-SDR: sLpwBksAEHc7uuGglWEz8eccnnQklvD1kWqh+5bR+8aFq5VwXENO5/cGE07NCNwR8AkYG58VRh
 RO1A9KmIaWMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="413403392"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2021 00:02:25 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 2/2] perf test: Add CVS summary test
Date:   Fri, 19 Mar 2021 15:01:56 +0800
Message-Id: <20210319070156.20394-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319070156.20394-1-yao.jin@linux.intel.com>
References: <20210319070156.20394-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch "perf stat: Align CSV output for summary mode" aligned
CVS output and added "summary" to the first column of summary
lines.

Now we check if the "summary" string is added to the CVS output.

If we set '--no-cvs-summary' option, the "summary" string would
not be added, also check with this case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v3:
   - New in v3.
 
 tools/perf/tests/shell/stat+cvs_summary.sh | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat+cvs_summary.sh

diff --git a/tools/perf/tests/shell/stat+cvs_summary.sh b/tools/perf/tests/shell/stat+cvs_summary.sh
new file mode 100755
index 000000000000..dd14f2ce7f6b
--- /dev/null
+++ b/tools/perf/tests/shell/stat+cvs_summary.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# perf stat cvs summary test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+#
+#     1.001364330 9224197  cycles 8012885033 100.00
+#         summary 9224197  cycles 8012885033 100.00
+#
+perf stat -e cycles  -x' ' -I1000 --interval-count 1 --summary 2>&1 | \
+grep -e summary | \
+while read summary num event run pct
+do
+	if [ $summary != "summary" ]; then
+		exit 1
+	fi
+done
+
+#
+#     1.001360298 9148534  cycles 8012853854 100.00
+#9148534  cycles 8012853854 100.00
+#
+perf stat -e cycles  -x' ' -I1000 --interval-count 1 --summary --no-cvs-summary 2>&1 | \
+grep -e summary | \
+while read num event run pct
+do
+	exit 1
+done
+
+exit 0
-- 
2.17.1

