Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A793AFF75
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFVIo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:44:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:57595 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFVIov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:44:51 -0400
IronPort-SDR: N4qQu75L8SgsCG2wC9xL6wvE/Wo7zFzDMGX4x3rPSNq3ImW17ETJ8FrZzk3hmxBxHt+0GYFMeS
 nwEXDK4oQiOA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292641495"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292641495"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 01:42:33 -0700
IronPort-SDR: bHRs3/DwyyZuzerUZZIrLFO+mi+VEUldqzgENXmYWzr03us6/+VIdgXAU+R10bXga1owu8RYE0
 z4/dWlpYK44g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="417332444"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2021 01:42:29 -0700
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
Subject: [PATCH v7 00/20] Introduce threaded trace streaming for basic perf record operation
Date:   Tue, 22 Jun 2021 11:42:09 +0300
Message-Id: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v7:
- fixed possible crash after out_free_threads label
- added missing pthread_attr_destroy() call
- added check of correctness of user masks 
- fixed zsts_data finalization

v6: https://lore.kernel.org/lkml/cover.1622025774.git.alexey.v.bayduraev@linux.intel.com/

Changes in v6:
- fixed leaks and possible double free in record__thread_mask_alloc()
- fixed leaks in record__init_thread_user_masks()
- fixed final mmaps flushing for threads id > 0
- merged with origin/perf/core

v5: https://lore.kernel.org/lkml/cover.1619781188.git.alexey.v.bayduraev@linux.intel.com/

Changes in v5:
- fixed leaks in record__init_thread_masks_spec()
- fixed leaks after failed realloc
- replaced "%m" to strerror()
- added masks examples to the documentation
- captured Acked-by: tags by Andi Kleen
- do not allow --thread option for full_auxtrace mode 
- split patch 06/12 to 06/20 and 07/20
- split patch 08/12 to 09/20 and 10/20
- split patches 11/12 and 11/12 to 13/20-20/20

v4: https://lore.kernel.org/lkml/6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com/

Changes in v4:
- renamed 'comm' structure to 'pipes'
- moved thread fd/maps messages to verbose=2
- fixed leaks during allocation of thread_data structures
- fixed leaks during allocation of thread masks
- fixed possible fails when releasing thread masks

v3: https://lore.kernel.org/lkml/7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com/

Changes in v3:
- avoided skipped redundant patch 3/15
- applied "data file" and "data directory" terms allover the patch set
- captured Acked-by: tags by Namhyung Kim
- avoided braces where don't needed
- employed thread local variable for serial trace streaming 
- added specs for --thread option - core, socket, numa and user defined
- added parallel loading of data directory files similar to the prototype [1]

v2: https://lore.kernel.org/lkml/1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com/

Changes in v2:
- explicitly added credit tags to patches 6/15 and 15/15,
  additionally to cites [1], [2]
- updated description of 3/15 to explicitly mention the reason
  to open data directories in read access mode (e.g. for perf report)
- implemented fix for compilation error of 2/15
- explicitly elaborated on found issues to be resolved for
  threaded AUX trace capture

v1: https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/

Patch set provides parallel threaded trace streaming mode for basic
perf record operation. Provided mode mitigates profiling data losses
and resolves scalability issues of serial and asynchronous (--aio)
trace streaming modes on multicore server systems. The design and
implementation are based on the prototype [1], [2].

Parallel threaded mode executes trace streaming threads that read kernel
data buffers and write captured data into several data files located at
data directory. Layout of trace streaming threads and their mapping to data
buffers to read can be configured using a value of --thread command line
option. Specification value provides masks separated by colon so the masks
define cpus to be monitored by one thread and thread affinity mask is
separated by slash. <cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
specifies parallel threads layout that consists of two threads with
corresponding assigned cpus to be monitored. Specification value can be
a string e.g. "cpu", "core" or "socket" meaning creation of data streaming
thread for monitoring every cpu, whole core or socket. The option provided
with no or empty value defaults to "cpu" layout creating data streaming
thread for every cpu being monitored. Specification masks are filtered
by the mask provided via -C option.

Parallel streaming mode is compatible with Zstd compression/decompression
(--compression-level) and external control commands (--control). The mode
is not enabled for pipe mode. The mode is not enabled for AUX area tracing,
related and derived modes like --snapshot or --aux-sample. --switch-output-*
and --timestamp-filename options are not enabled for parallel streaming.
Initial intent to enable AUX area tracing faced the need to define some
optimal way to store index data in data directory. --switch-output-* and
--timestamp-filename use cases are not clear for data directories.
Asynchronous(--aio) trace streaming and affinity (--affinity) modes are
mutually exclusive to parallel streaming mode.

Basic analysis of data directories is provided in perf report mode.
Raw dump and aggregated reports are available for data directories,
still with no memory consumption optimizations.

Tested:

tools/perf/perf record -o prof.data --threads -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads= -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=cpu -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=core -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=socket -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=numa -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data -C 2,5 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data -C 3,4 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=core -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=numa -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 --compression-level=3 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads -a
tools/perf/perf record -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30
tools/perf/perf record --threads -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30

tools/perf/perf report -i prof.data
tools/perf/perf report -i prof.data --call-graph=callee
tools/perf/perf report -i prof.data --stdio --header
tools/perf/perf report -i prof.data -D --header

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Alexey Bayduraev (20):
  perf record: Introduce thread affinity and mmap masks
  perf record: Introduce thread specific data array
  perf record: Introduce thread local variable
  perf record: Stop threads in the end of trace streaming
  perf record: Start threads in the beginning of trace streaming
  perf record: Introduce data file at mmap buffer object
  perf record: Introduce data transferred and compressed stats
  perf record: Init data file at mmap buffer object
  tools lib: Introduce bitmap_intersects() operation
  perf record: Introduce --threads=<spec> command line option
  perf record: Document parallel data streaming mode
  perf report: Output data file name in raw trace dump
  perf session: Move reader structure to the top
  perf session: Introduce reader_state in reader object
  perf session: Introduce reader objects in session object
  perf session: Introduce decompressor into trace reader object
  perf session: Move init into reader__init function
  perf session: Move map/unmap into reader__mmap function
  perf session: Load single file for analysis
  perf session: Load data directory files for analysis

 tools/include/linux/bitmap.h             |   11 +
 tools/lib/api/fd/array.c                 |   17 +
 tools/lib/api/fd/array.h                 |    1 +
 tools/lib/bitmap.c                       |   14 +
 tools/perf/Documentation/perf-record.txt |   30 +
 tools/perf/builtin-inject.c              |    3 +-
 tools/perf/builtin-record.c              | 1094 ++++++++++++++++++++--
 tools/perf/util/evlist.c                 |   16 +
 tools/perf/util/evlist.h                 |    1 +
 tools/perf/util/mmap.c                   |    6 +
 tools/perf/util/mmap.h                   |    6 +
 tools/perf/util/ordered-events.h         |    1 +
 tools/perf/util/record.h                 |    2 +
 tools/perf/util/session.c                |  500 +++++++---
 tools/perf/util/session.h                |    5 +
 tools/perf/util/tool.h                   |    3 +-
 16 files changed, 1508 insertions(+), 202 deletions(-)

-- 
2.19.0

