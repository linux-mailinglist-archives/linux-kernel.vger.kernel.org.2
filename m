Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B590C354EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbhDFIhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:37:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:40834 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbhDFIhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:37:39 -0400
IronPort-SDR: yI0VzMrlhPLZmyRDNt6338xFtfCrSVGhl+/3inuESKVQqXuvaDe4KlKuO83CPiTY9Sg9vLeqf7
 70rF3dyH0uSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213378345"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="213378345"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:37:31 -0700
IronPort-SDR: xI6VxEdezYdodO5AKXQpMfdMtLxZiuKBvKoKw/qKLVlAV5WTDWCGNeArPZ+Z18tWuyZ7/FQb+F
 zX/OAaFgkDQA==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421118966"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.164]) ([10.249.228.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:37:28 -0700
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Subject: [PATCH v4 00/12] Introduce threaded trace streaming for basic perf
 record operation
Organization: Intel Corporation
Message-ID: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:37:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

---
Alexey Bayduraev (12):
  perf record: introduce thread affinity and mmap masks
  perf record: introduce thread specific data array
  perf record: introduce thread local variable
  perf record: stop threads in the end of trace streaming
  perf record: start threads in the beginning of trace streaming
  perf record: introduce data file at mmap buffer object
  perf record: init data file at mmap buffer object
  perf record: introduce --threads=<spec> command line option
  perf record: document parallel data streaming mode
  perf report: output data file name in raw trace dump
  perf session: load data directory files for analysis
  perf session: use reader functions to load perf data file

 tools/include/linux/bitmap.h             |   11 +
 tools/lib/api/fd/array.c                 |   17 +
 tools/lib/api/fd/array.h                 |    1 +
 tools/lib/bitmap.c                       |   14 +
 tools/perf/Documentation/perf-record.txt |   18 +
 tools/perf/builtin-inject.c              |    3 +-
 tools/perf/builtin-record.c              | 1027 ++++++++++++++++++++--
 tools/perf/util/evlist.c                 |   16 +
 tools/perf/util/evlist.h                 |    1 +
 tools/perf/util/mmap.c                   |    6 +
 tools/perf/util/mmap.h                   |    6 +
 tools/perf/util/ordered-events.h         |    1 +
 tools/perf/util/record.h                 |    2 +
 tools/perf/util/session.c                |  484 +++++++---
 tools/perf/util/session.h                |    5 +
 tools/perf/util/tool.h                   |    3 +-
 16 files changed, 1407 insertions(+), 208 deletions(-)

-- 
2.19.0


