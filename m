Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E12379F30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhEKFcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:32:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:29162 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhEKFcR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:32:17 -0400
IronPort-SDR: fsvEh7uOoorjwIt89y3T9lRmcyW71pUHH5ZNO0VNW+33xi+iCOnOmsEuGUbBxYQ5bOx8oKbd6v
 MKbFD9TaKwVg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284846667"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="284846667"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:31:11 -0700
IronPort-SDR: 31vh5zt6V85sY1hYt1PVgCgxNiJlxfHx+exA33g4RChnA+VrINSS3orgOG+8K7b3RhhKO26eof
 VG52/TczhxAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="461769859"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 10 May 2021 22:31:09 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/2] perf header: Support HYBRID_TOPOLOGY and HYBRID_CPU_PMU_CAPS
Date:   Tue, 11 May 2021 13:30:01 +0800
Message-Id: <20210511053003.27015-1-yao.jin@linux.intel.com>
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
 tools/perf/util/header.c                      | 250 ++++++++++++++++--
 tools/perf/util/header.h                      |   2 +
 tools/perf/util/pmu-hybrid.h                  |  11 +
 8 files changed, 398 insertions(+), 19 deletions(-)

-- 
2.17.1

