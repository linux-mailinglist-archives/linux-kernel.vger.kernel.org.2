Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DBD363F00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhDSJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:42:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:60390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234613AbhDSJmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:42:21 -0400
IronPort-SDR: MJr6zbsY/p/QvaL809o/Uky6REWZRgNo/gV82hYh2wlBGWygvHsaXhD1b/rbbOAtQzgvEkfT72
 pJcucC2t6uQA==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="174787664"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="174787664"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 02:41:50 -0700
IronPort-SDR: HeXTOre01gj4BmDFBQZeZiuGLg66FymHh+p06AWkpv4XjBIE3NuQJCOd77V9+V+T+BJ64e4ssP
 zCALq93mVeCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="452089658"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2021 02:41:48 -0700
From:   alexander.antonov@linux.intel.com
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com
Subject: [RESEND PATCH v5 0/4] perf stat: Introduce iostat mode to provide I/O performance metrics
Date:   Mon, 19 Apr 2021 12:41:43 +0300
Message-Id: <20210419094147.15909-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Resending V5 with added Acked-by: Namhyung Kim <namhyung@kernel.org> tag.

Thanks,
Alexander

The previous version can be found at:
v4: https://lkml.kernel.org/r/20210203135830.38568-1-alexander.antonov@linux.intel.com/
Changes in this revision are:
v4 -> v5:
- Addressed comments from Namhyung Kim:
  1. Removed AGGR_PCIE_PORT aggregation mode
  2. Added iostat_prepare() function
  3. Moved implementation specific fprintf() calls to separate x86-related function
  4. Fixed code-related issues
- Moved __weak iostat's functions to separate util/iostat.c file

The previous version can be found at:
v3: https://lkml.kernel.org/r/20210126080619.30275-1-alexander.antonov@linux.intel.com/
Changes in this revision are:
v3 -> v4:
- Addressed comment from Namhyung Kim:
  1. Removed NULL-termination of root ports list

The previous version can be found at:
v2: https://lkml.kernel.org/r/20201223130320.3930-1-alexander.antonov@linux.intel.com

Changes in this revision are:
v2 -> v3:
- Addressed comments from Namhyung Kim:
  1. Removed perf_device pointer from evsel structure. Use priv field instead
  2. Renamed 'iiostat' to 'iostat'
  3. Renamed 'show' mode to 'list' mode
  4. Renamed iiostat_delete_root_ports() to iiostat_release() and
     iostat_show_root_ports() to iostat_list()

The previous version can be found at:
v1: https://lkml.kernel.org/r/20201210090340.14358-1-alexander.antonov@linux.intel.com

Changes in this revision are:
v1 -> v2:
- Addressed comment from Arnaldo Carvalho de Melo:
  1. Using 'perf iiostat' subcommand instead of 'perf stat --iiostat':
    - Added perf-iiostat.sh script to use short command
    - Updated manual pages to get help for 'perf iiostat'
    - Added 'perf-iiostat' to perf's gitignore file

Mode is intended to provide four I/O performance metrics in MB per each
root port:
 - Inbound Read:   I/O devices below root port read from the host memory
 - Inbound Write:  I/O devices below root port write to the host memory
 - Outbound Read:  CPU reads from I/O devices below root port
 - Outbound Write: CPU writes to I/O devices below root port

Each metric requiries only one uncore event which increments at every 4B
transfer in corresponding direction. The formulas to compute metrics
are generic:
    #EventCount * 4B / (1024 * 1024)

Note: iostat introduces new perf data aggregation mode - per PCIe root port
hence -e and -M options are not supported.

Usage examples:

1. List all PCIe root ports (example for 2-S platform):
   $ perf iostat list
   S0-uncore_iio_0<0000:00>
   S1-uncore_iio_0<0000:80>
   S0-uncore_iio_1<0000:17>
   S1-uncore_iio_1<0000:85>
   S0-uncore_iio_2<0000:3a>
   S1-uncore_iio_2<0000:ae>
   S0-uncore_iio_3<0000:5d>
   S1-uncore_iio_3<0000:d7>

2. Collect metrics for all PCIe root ports:
   $ perf iostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
   357708+0 records in
   357707+0 records out
   375083606016 bytes (375 GB, 349 GiB) copied, 215.974 s, 1.7 GB/s

    Performance counter stats for 'system wide':

      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
   0000:00                    1                    0                    2                    3 
   0000:80                    0                    0                    0                    0 
   0000:17               352552                   43                    0                   21 
   0000:85                    0                    0                    0                    0 
   0000:3a                    3                    0                    0                    0 
   0000:ae                    0                    0                    0                    0 
   0000:5d                    0                    0                    0                    0 
   0000:d7                    0                    0                    0                    0

3. Collect metrics for comma separated list of PCIe root ports:
   $ perf iostat 0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
   357708+0 records in
   357707+0 records out
   375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s

    Performance counter stats for 'system wide':

      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
   0000:17               358559                   44                    0                   22 
   0000:3a                    3                    2                    0                    0 

        197.081983474 seconds time elapsed

Alexander Antonov (4):
  perf stat: Basic support for iostat in perf
  perf stat: Helper functions for PCIe root ports list in iostat mode
  perf stat: Enable iostat mode for x86 platforms
  perf: Update .gitignore file

 tools/perf/.gitignore                    |   1 +
 tools/perf/Documentation/perf-iostat.txt |  88 +++++
 tools/perf/Makefile.perf                 |   5 +-
 tools/perf/arch/x86/util/Build           |   1 +
 tools/perf/arch/x86/util/iostat.c        | 470 +++++++++++++++++++++++
 tools/perf/builtin-stat.c                |  21 +-
 tools/perf/command-list.txt              |   1 +
 tools/perf/perf-iostat.sh                |  12 +
 tools/perf/util/Build                    |   1 +
 tools/perf/util/iostat.c                 |  53 +++
 tools/perf/util/iostat.h                 |  47 +++
 tools/perf/util/stat-display.c           |  40 +-
 tools/perf/util/stat-shadow.c            |   5 +-
 tools/perf/util/stat.h                   |   1 +
 14 files changed, 733 insertions(+), 13 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-iostat.txt
 create mode 100644 tools/perf/arch/x86/util/iostat.c
 create mode 100644 tools/perf/perf-iostat.sh
 create mode 100644 tools/perf/util/iostat.c
 create mode 100644 tools/perf/util/iostat.h


base-commit: 4c391ea001cb2e7bd9a691a886c0dcb030c1791c
-- 
2.21.3

