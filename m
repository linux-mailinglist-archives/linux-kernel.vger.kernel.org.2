Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CEA422357
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhJEK27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:28:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:46740 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhJEK25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:28:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="225603001"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="225603001"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="714164452"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2021 03:27:03 -0700
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH v2 0/5] perf session: Extend reader object to allow multiple readers
Date:   Tue,  5 Oct 2021 13:26:57 +0300
Message-Id: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- introduced struct decomp_data suggested by Jiri Olsa
- removed unnecessary [PATCH v1 1/6]
- removed unnecessary extra line in [PATCH v2 4/5]
- removed unnecessary reader_state.eof flag in [PATCH v2 5/5]

Patch set adds state info and decompressor object into reader object
that made possible to split reader__process_events function into three
logical parts: init/exit, map/unmap and single event reader which are
used in events reader loop. This approach allows reading multiple trace
files at the same time. 

The design and implementation are based on the prototype [1], [2].

The patch set was separated from [3] and already was rewieved by
Namhyung Kim and Riccardo Mancini. The difference from [3] is that
this patch set keeps reader object allocation on the stack.

Tested:

tools/perf/perf record -o prof.data -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data -z -- matrix.gcc.g.O3
tools/perf/perf report -i prof.data
tools/perf/perf report -i prof.data --call-graph=callee
tools/perf/perf report -i prof.data --stdio --header
tools/perf/perf report -i prof.data -D --header

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
[3] https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/

Alexey Bayduraev (5):
  perf session: Introduce reader_state in reader object
  perf session: Introduce decompressor in reader object
  perf session: Move init/exit code to separate functions
  perf session: Move map/unmap to separate function
  perf session: Load single file for analysis

 tools/perf/util/session.c | 215 +++++++++++++++++++++++++-------------
 tools/perf/util/session.h |  10 +-
 2 files changed, 151 insertions(+), 74 deletions(-)

-- 
2.19.0

