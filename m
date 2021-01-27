Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819F2306005
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhA0Ppw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:45:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:12371 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236553AbhA0PoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:44:03 -0500
IronPort-SDR: V8auCnuN+fV8ZQ49fhjyBFB3zy8Yt+3voY+58GT/MKZYshpSGdPFbSVKnNV4G1631Xvvn7DMpj
 L7d4J+XV+iFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159861122"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="159861122"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 07:42:15 -0800
IronPort-SDR: KxOJRjphBvt9bykiQg8vh/mlUiXpaN4wZB+/2eRT32yEXn1PqtceuKnGABU654RgzAksozM6fa
 mV2phSz41Wmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="369514612"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2021 07:42:14 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/5] perf core PMU support for Sapphire Rapids (Kernel)
Date:   Wed, 27 Jan 2021 07:38:40 -0800
Message-Id: <1611761925-159055-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Use PERF_SAMPLE_WEIGHT_STRUCT to replace PERF_SAMPLE_WEIGHT_EXT.
  The new sample type PERF_SAMPLE_WEIGHT_STRUCT shares the same space as
  the current PERF_SAMPLE_WEIGHT.
- Move the check for the unsupported Topdown event into a separate patch
- Use the 'pebs_block' to replace the 'pebs_no_block'.
- Apply Peter's suggestion for the patch ("perf/x86/intel: Support CPUID
  10.ECX to disable fixed counters")
- Only include Kernel patches

Intel Sapphire Rapids server is the successor of the Intel Ice Lake
server. The enabling code is based on Ice Lake, but there are several
new features introduced.
- The event encoding is changed and simplified.
- A new Precise Distribution (PDist) facility.
- Two new data source fields, data block & address block, are added in
  the PEBS Memory Info Record for the load latency event.
- A new store Latency facility is introduced.
- The layout of access latency field of PEBS Memory Info Record has been
  changed. Two latency, instruction latency and cache access latency are
  recorded. To support the new latency fields, a new sample type,
  PERF_SAMPLE_WEIGHT_EXT, is introduced.
- Extends the PERF_METRICS MSR to feature TMA method level 2 metrics.

Besides the Sapphire Rapids specific features, the CPUID 10.ECX
extension is also supported, which is available for all platforms with
Architectural Performance Monitoring Version 5.

The full description for the SPR features can be found at Intel
Architecture Instruction Set Extensions and Future Features Programming
Reference, 319433-041 (and later).

Kan Liang (5):
  perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT
  perf/x86/intel: Factor out intel_update_topdown_event()
  perf/x86/intel: Filter unsupported Topdown metrics event
  perf/x86/intel: Add perf core PMU support for Sapphire Rapids
  perf/x86/intel: Support CPUID 10.ECX to disable fixed counters

 arch/powerpc/perf/core-book3s.c   |   2 +-
 arch/x86/events/core.c            |   8 +-
 arch/x86/events/intel/core.c      | 374 +++++++++++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c        | 131 ++++++++++++-
 arch/x86/events/perf_event.h      |  17 +-
 arch/x86/include/asm/perf_event.h |  16 +-
 include/linux/perf_event.h        |   4 +-
 include/uapi/linux/perf_event.h   |  36 +++-
 kernel/events/core.c              |  11 +-
 9 files changed, 550 insertions(+), 49 deletions(-)

-- 
2.7.4

