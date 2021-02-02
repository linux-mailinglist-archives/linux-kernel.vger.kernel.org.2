Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F230CCE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhBBUQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:16:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:59905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231915AbhBBUPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:15:51 -0500
IronPort-SDR: wo2/YTmysBdUf9R/yHvEnBiz3a9oYOTVbC+TYOMTncm4pgwSp+rt4UF3PY/MljZnTldC9xZS+/
 8CKfsX8Fdjww==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180148763"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="180148763"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:14:05 -0800
IronPort-SDR: 64czTOs7yHie1gRpUOj1tzg9t6McNlMqMtkfYoLEdDn+zghGB0fp7JIuXWQh5ybdcIOww82rrg
 zdyAONkl1rEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="356442487"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2021 12:14:03 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/9] perf core PMU support for Sapphire Rapids (User tools)
Date:   Tue,  2 Feb 2021 12:09:04 -0800
Message-Id: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intel Sapphire Rapids server is the successor of the Intel Ice Lake
server. There are several user-visible features introduced.
- Two new data source fields, data block & address block, are added in
  the PEBS Memory Info Record for the load latency event.
  Improve the c2c and mem tools to display the reasons of a memory load
  block.
- Support the new instruction latency in perf mem.
  Support the new sample type, PERF_SAMPLE_WEIGHT_STRUCT.
- Support TMA method level 2 metrics with the perf stat --topdown option.
  Update the topdown documentation accordingly.

The full description for the SPR features can be found at Intel
Architecture Instruction Set Extensions and Future Features Programming
Reference, 319433-041 (and later).

The kernel patches has been merged into the tip:perf/core branch.

Kan Liang (9):
  tools headers uapi: Update tools's copy of linux/perf_event.h
  perf tools: Support the auxiliary event
  perf tools: Support data block and addr block
  perf c2c: Support data block and addr block
  perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT
  perf report: Support instruction latency
  perf test: Support PERF_SAMPLE_WEIGHT_STRUCT
  perf stat: Support L2 Topdown events
  perf, tools: Update topdown documentation for Sapphire Rapids

 tools/include/uapi/linux/perf_event.h     | 54 ++++++++++++++++--
 tools/perf/Documentation/perf-report.txt  |  9 ++-
 tools/perf/Documentation/perf-stat.txt    | 14 ++++-
 tools/perf/Documentation/topdown.txt      | 78 ++++++++++++++++++++++++--
 tools/perf/arch/x86/util/Build            |  2 +
 tools/perf/arch/x86/util/evsel.c          |  8 +++
 tools/perf/arch/x86/util/mem-events.c     | 44 +++++++++++++++
 tools/perf/builtin-c2c.c                  |  3 +
 tools/perf/builtin-mem.c                  |  2 +-
 tools/perf/builtin-stat.c                 | 34 +++++++++++-
 tools/perf/tests/sample-parsing.c         | 14 ++++-
 tools/perf/util/event.h                   |  1 +
 tools/perf/util/evsel.c                   | 33 +++++++++--
 tools/perf/util/evsel.h                   |  3 +
 tools/perf/util/hist.c                    | 13 ++++-
 tools/perf/util/hist.h                    |  3 +
 tools/perf/util/intel-pt.c                | 23 +++++++-
 tools/perf/util/mem-events.c              | 36 ++++++++++++
 tools/perf/util/mem-events.h              |  5 ++
 tools/perf/util/parse-events.l            |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 tools/perf/util/record.c                  |  5 +-
 tools/perf/util/session.c                 |  8 ++-
 tools/perf/util/sort.c                    | 83 +++++++++++++++++++++++++++-
 tools/perf/util/sort.h                    |  4 ++
 tools/perf/util/stat-shadow.c             | 92 +++++++++++++++++++++++++++++++
 tools/perf/util/stat.c                    |  4 ++
 tools/perf/util/stat.h                    |  9 +++
 tools/perf/util/synthetic-events.c        |  8 ++-
 29 files changed, 560 insertions(+), 35 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/evsel.c
 create mode 100644 tools/perf/arch/x86/util/mem-events.c

-- 
2.7.4

