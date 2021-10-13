Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D173242BB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbhJMJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:08:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:55079 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhJMJIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:08:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="227281623"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="227281623"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="460705910"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2021 02:06:44 -0700
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
Subject: [PATCH v3 0/8] perf session: Extend reader object to allow multiple readers
Date:   Wed, 13 Oct 2021 12:06:34 +0300
Message-Id: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
- set/unset active_decomp within reader__process_events

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

Patchset moves state info and decompressor object into reader object
that made possible to split reader__process_events function into three
logical parts: init, map/unmap and single event reader which are used
in events reader loop. This approach allows reading multiple trace
files at the same time. 

The design and implementation are based on the prototype [1], [2].
The patchset was separated from [3].

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

 tools/perf/util/session.c | 193 ++++++++++++++++++++++++++------------
 tools/perf/util/session.h |  10 +-
 2 files changed, 141 insertions(+), 62 deletions(-)

-- 
2.19.0

