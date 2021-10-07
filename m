Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDFA425102
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhJGK1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:27:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:3730 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231825AbhJGK1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:27:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249532625"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="249532625"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 03:25:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="657335423"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2021 03:25:45 -0700
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
Subject: [PATCH v3 0/5] perf session: Extend reader object to allow multiple readers
Date:   Thu,  7 Oct 2021 13:25:35 +0300
Message-Id: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
- removed struct reader_state in [PATCH v3 1/8]
- fixed repeating code in [PATCH v3 2/8]
- split [PATCH v2 4/5] to [PATCH v3 4/8], [PATCH v3 5/8]
- split [PATCH v2 5/5] to [PATCH v3 6/8] - [PATCH v3 8/8]

Changes in v2:
- introduced struct decomp_data suggested by Jiri Olsa
- removed unnecessary [PATCH v1 1/6]
- removed unnecessary extra line in [PATCH v2 4/5]
- removed unnecessary reader_state.eof flag in [PATCH v2 5/5]

Patch set moves state info and decompressor object into reader object
that made possible to split reader__process_events function into three
logical parts: init, map/unmap and single event reader which are used
in events reader loop. This approach allows reading multiple trace
files at the same time. 

The design and implementation are based on the prototype [1], [2].
The patch set was separated from [3].

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

Alexey Bayduraev (8):
  perf session: Move all state items to reader object
  perf session: Introduce decompressor in reader object
  perf session: Move init/release code to separate functions
  perf session: Move map code to separate function
  perf session: Move unmap code to reader__mmap
  perf session: Move event read code to separate function
  perf session: Introduce reader return codes
  perf session: Introduce reader EOF function

 tools/perf/util/session.c | 192 ++++++++++++++++++++++++++------------
 tools/perf/util/session.h |  10 +-
 2 files changed, 140 insertions(+), 62 deletions(-)

-- 
2.19.0

