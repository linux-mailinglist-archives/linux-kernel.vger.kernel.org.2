Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06A3928F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhE0H4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:56:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:39405 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234487AbhE0H4F (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:56:05 -0400
IronPort-SDR: vm9wIhrKzOlWiCBph8CYmFATAB97QhUpqiAu+PjTv4z0DXnO8AaOZ/f+07X8XNppdsNUiNu1o1
 PoPiuSsIGHrA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288262813"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288262813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:32 -0700
IronPort-SDR: MHsk+3rZcAOL8nq6NHcZF8Umx4zrdNP+DYDvl3yuK273JE+cQK5d6hr83ektburuwjCtzRTwCi
 2Mi1eX2cYi9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547586486"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 00:54:29 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/8] perf: Support perf-mem/perf-c2c for AlderLake
Date:   Thu, 27 May 2021 08:16:02 +0800
Message-Id: <20210527001610.10553-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AlderLake uses a hybrid architecture utilizing Golden Cove cores
(core CPU) and Gracemont cores (atom CPU). This patchset supports
perf-mem and perf-c2c for AlderLake.

v2:
---
- Use mem_loads_name__init to keep original behavior for non-hybrid platform.
- Move x86 specific perf_mem_events[] to arch/x86/util/mem-events.c.
- Move mem-store event to a new patch.
- Add a new patch to fix wrong verbose output for recording events
- Add a new patch to disable 'mem-loads-aux' group before reporting

Jin Yao (8):
  perf tools: Check mem-loads auxiliary event
  perf tools: Support pmu prefix for mem-load event
  perf tools: Support pmu prefix for mem-store event
  perf tools: Check if mem_events is supported for hybrid platform
  perf mem: Support record for hybrid platform
  perf mem: Fix wrong verbose output for recording events
  perf mem: Disable 'mem-loads-aux' group before reporting
  perf c2c: Support record for hybrid platform

 tools/perf/arch/arm64/util/mem-events.c   |   2 +-
 tools/perf/arch/powerpc/util/mem-events.c |   2 +-
 tools/perf/arch/x86/util/mem-events.c     |  54 ++++++++++--
 tools/perf/builtin-c2c.c                  |  40 +++++----
 tools/perf/builtin-mem.c                  |  51 ++++++-----
 tools/perf/builtin-report.c               |   2 +
 tools/perf/util/evlist.c                  |  25 ++++++
 tools/perf/util/evlist.h                  |   1 +
 tools/perf/util/mem-events.c              | 101 ++++++++++++++++++++--
 tools/perf/util/mem-events.h              |   4 +-
 10 files changed, 225 insertions(+), 57 deletions(-)

-- 
2.17.1

