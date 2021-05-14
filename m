Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B573C38098A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhENMcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:32:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:40120 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233226AbhENMcU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:32:20 -0400
IronPort-SDR: FhEzetW0ps4EjK3L9lnjetVQVQMIRIV9cLap0/PsDh9AhuLvwhWXYOkTS+hpPPzzOxFljioWwU
 465CDDC5DaXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="264090967"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="264090967"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 05:31:01 -0700
IronPort-SDR: nVt2jHOHIHR/bGytrWUtwYHNyQbvrU2yCGeeXGp4jqytMLLjvfwapZvNkHUX8WyLY+7YTnDcLw
 KbCe8UXoeE9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="431694648"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga007.jf.intel.com with ESMTP; 14 May 2021 05:30:58 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 0/2] perf header: Support HYBRID_TOPOLOGY and HYBRID_CPU_PMU_CAPS
Date:   Fri, 14 May 2021 20:29:46 +0800
Message-Id: <20210514122948.9472-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AlderLake uses a hybrid architecture utilizing Golden Cove cores
(core cpu) and Gracemont cores (atom cpu). It would be useful to let user
know the hybrid topology, the HYBRID_TOPOLOGY feature in header indicates
which cpus are core cpus, and which cpus are atom cpus.

On hybrid platform, it may have several cpu pmus, such as, "cpu_core" and
"cpu_atom". The HYBRID_CPU_PMU_CAPS feature in perf header is created to
support multiple cpu pmus.

v4:
---
- Only minor update in '[PATCH v4 2/2] perf header: Support HYBRID_CPU_PMU_CAPS feature'.
  1. Directly return process_per_cpu_pmu_caps() in process_cpu_pmu_caps.
     Remove the variable 'ret'.
  2. Set 'ret = -1' if (!n->pmu_name) in process_hybrid_cpu_pmu_caps().

v3:
---
- For "[PATCH v3 1/2] perf header: Support HYBRID_TOPOLOGY feature",
  update HEADER_HYBRID_TOPOLOGY format in perf.data-file-format.txt.

- For "[PATCH v3 2/2] perf header: Support HYBRID_CPU_PMU_CAPS feature",
  Don't extend the original CPU_PMU_CAPS to support hybrid cpu pmus.
  Instead, create a new feature 'HYBRID_CPU_PMU_CAPS' in header.

v2:
---
- In "perf header: Support HYBRID_TOPOLOGY feature", don't use the n->map
  to print the cpu list, just use n->cpus.

- Separate hybrid CPU_PMU_CAPS support into two patches:
  perf header: Write hybrid CPU_PMU_CAPS
  perf header: Process hybrid CPU_PMU_CAPS

- Add some words to perf.data-file-format.txt for HYBRID_TOPOLOGY and
  hybrid CPU_PMU_CAPS.

Jin Yao (2):
  perf header: Support HYBRID_TOPOLOGY feature
  perf header: Support HYBRID_CPU_PMU_CAPS feature

 .../Documentation/perf.data-file-format.txt   |  33 +++
 tools/perf/util/cputopo.c                     |  80 ++++++
 tools/perf/util/cputopo.h                     |  13 +
 tools/perf/util/env.c                         |  12 +
 tools/perf/util/env.h                         |  16 ++
 tools/perf/util/header.c                      | 249 ++++++++++++++++--
 tools/perf/util/header.h                      |   2 +
 tools/perf/util/pmu-hybrid.h                  |  11 +
 8 files changed, 397 insertions(+), 19 deletions(-)

-- 
2.17.1

