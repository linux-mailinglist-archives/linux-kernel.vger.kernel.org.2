Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30FA3DD00F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 07:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhHBFg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 01:36:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:50150 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhHBFgZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:36:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="210281225"
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="210281225"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 22:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="457815883"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2021 22:36:13 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/2] perf vendor events intel: Add core events and metrics for Elkhartlake
Date:   Mon,  2 Aug 2021 13:34:38 +0800
Message-Id: <20210802053440.21035-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON events and metrics for Elkhartlake to perf.

Based on JSON list v1.02:

https://download.01.org/perfmon/EHL/

v2:
---
Based on JSON list v1.02.
Patchset is based on tmp.perf/core branch.

v1:
---
Based on JSON list v1.01

Jin Yao (2):
  perf vendor events intel: Add core event list for Elkhartlake
  perf vendor events intel: Add basic metrics for Elkhartlake

 .../arch/x86/elkhartlake/cache.json           | 226 ++++++++++
 .../arch/x86/elkhartlake/ehl-metrics.json     |  57 +++
 .../arch/x86/elkhartlake/floating-point.json  |  24 +
 .../arch/x86/elkhartlake/frontend.json        |  93 ++++
 .../arch/x86/elkhartlake/memory.json          |  86 ++++
 .../arch/x86/elkhartlake/other.json           | 424 ++++++++++++++++++
 .../arch/x86/elkhartlake/pipeline.json        | 278 ++++++++++++
 .../arch/x86/elkhartlake/virtual-memory.json  | 273 +++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 9 files changed, 1462 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json

-- 
2.17.1

