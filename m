Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1048F375F41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 05:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhEGDye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 23:54:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:56141 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231261AbhEGDyc (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 23:54:32 -0400
IronPort-SDR: sP3tJYGby6W4EfvslXFCUhk+0dvxSmleAVsUnhGUsOonZ/8QKblSxXX1IeGHWwJyPk42gGoIg+
 In3mGr9MY4kQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="195525854"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="195525854"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 20:53:27 -0700
IronPort-SDR: ulFlYVvfhr7ikU75t+xb0GZr5Z5LybosSUPIXTyHhUAo3UV4toDYnsCTpceDw1sXjm3fAnv3Pi
 bmIj27Hj9rsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="533309694"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2021 20:53:25 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/3] perf header: Support HYBRID_TOPOLOGY and hybrid CPU_PMU_CAPS
Date:   Fri,  7 May 2021 11:52:27 +0800
Message-Id: <20210507035230.3079-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AlderLake uses a hybrid architecture utilizing Golden Cove cores
(core cpu) and Gracemont cores (atom cpu). It would be useful to let user
know the hybrid topology, the HYBRID_TOPOLOGY feature in header indicates
which cpus are core cpus, and which cpus are atom cpus.

On hybrid platform, it may have several cpu pmus, such as, "cpu_core" and
"cpu_atom". The CPU_PMU_CAPS feature in perf header is improved to support
multiple cpu pmus.

v2:
---
- In "perf header: Support HYBRID_TOPOLOGY feature", don't use the n->map
  to print the cpu list, just use n->cpus.

- Separate hybrid CPU_PMU_CAPS support into two patches:
  perf header: Write hybrid CPU_PMU_CAPS
  perf header: Process hybrid CPU_PMU_CAPS

- Add some words to perf.data-file-format.txt for HYBRID_TOPOLOGY and
  hybrid CPU_PMU_CAPS.

Jin Yao (3):
  perf header: Support HYBRID_TOPOLOGY feature
  perf header: Write hybrid CPU_PMU_CAPS
  perf header: Process hybrid CPU_PMU_CAPS

 .../Documentation/perf.data-file-format.txt   |  20 ++
 tools/perf/util/cputopo.c                     |  80 ++++++
 tools/perf/util/cputopo.h                     |  13 +
 tools/perf/util/env.c                         |  12 +
 tools/perf/util/env.h                         |  18 +-
 tools/perf/util/header.c                      | 269 ++++++++++++++++--
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/pmu-hybrid.h                  |  11 +
 8 files changed, 400 insertions(+), 24 deletions(-)

-- 
2.17.1

