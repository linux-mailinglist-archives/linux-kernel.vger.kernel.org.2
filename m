Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610083779C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 03:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhEJB05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 21:26:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:13561 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhEJB04 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 21:26:56 -0400
IronPort-SDR: EhrJoonMlZNwqFW0nRQPA2nEBBzEnS0ZOkDhePh/slRhw6t+2Vvi5GFpVViH9uYmfETU8IYmaT
 684OQTB4oR3Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="186534544"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="186534544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 18:25:52 -0700
IronPort-SDR: dOVz/7o4Abo5T007mbQ1t5BmYZqI7EVLwb2KNGAzYuLa8Gx7niNKm76Wq4GhuKLpEP7VPUamio
 PhkSVIOqsN9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="536197606"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2021 18:25:50 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 0/4] perf vendor events: Add events for Icelake Server and update for Icelake Client
Date:   Mon, 10 May 2021 09:24:34 +0800
Message-Id: <20210510012438.6293-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 3 patches add events and metrics for Icelake Server.
The last patch updates the event list for Icelake Client.

The patches can be found at:
https://github.com/yaoj/icx-events.git

Jin Yao (4):
  perf vendor events: Add core event list for Icelake Server
  perf vendor events: Add uncore event list for Icelake Server
  perf vendor events: Add metrics for Icelake Server
  perf vendor events: Update event list for Icelake Client

 .../pmu-events/arch/x86/icelake/cache.json    |  724 +++--
 .../arch/x86/icelake/floating-point.json      |  101 +-
 .../pmu-events/arch/x86/icelake/frontend.json |  610 ++--
 .../arch/x86/icelake/icl-metrics.json         |  273 ++
 .../pmu-events/arch/x86/icelake/memory.json   |  654 +++--
 .../pmu-events/arch/x86/icelake/other.json    | 1089 +++++++-
 .../pmu-events/arch/x86/icelake/pipeline.json | 1169 ++++----
 .../arch/x86/icelake/virtual-memory.json      |  251 +-
 .../pmu-events/arch/x86/icelakex/cache.json   |  706 +++++
 .../arch/x86/icelakex/floating-point.json     |   95 +
 .../arch/x86/icelakex/frontend.json           |  469 ++++
 .../arch/x86/icelakex/icx-metrics.json        |  327 +++
 .../pmu-events/arch/x86/icelakex/memory.json  |  291 ++
 .../pmu-events/arch/x86/icelakex/other.json   |  181 ++
 .../arch/x86/icelakex/pipeline.json           |  972 +++++++
 .../arch/x86/icelakex/uncore-memory.json      |  333 +++
 .../arch/x86/icelakex/uncore-other.json       | 2476 +++++++++++++++++
 .../arch/x86/icelakex/uncore-power.json       |   10 +
 .../arch/x86/icelakex/virtual-memory.json     |  245 ++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +
 20 files changed, 9403 insertions(+), 1575 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json

-- 
2.17.1

