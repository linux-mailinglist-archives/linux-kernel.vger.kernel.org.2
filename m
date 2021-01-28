Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36E6308168
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhA1Wsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:48:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:61310 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231645AbhA1WrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:47:24 -0500
IronPort-SDR: ESrQw8NWLJFzx91OrrbMWYddvams/JTm97htASZqeRQxbo5ECrx+dZ4FENkQ+YkCDgSmB3bxYr
 tbcYm96L7fLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="244412988"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="244412988"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 14:45:37 -0800
IronPort-SDR: iBwPD+B0KuvDfR8HYD37hqZlgN/MivHhAMepedohfVVYtrPccgTAtwWzuP30ZYbQNaA7ogsFSZ
 pVbpSRh6ZHlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="389034551"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2021 14:45:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 0/5] perf core PMU support for Sapphire Rapids (Kernel)
Date:   Thu, 28 Jan 2021 14:40:06 -0800
Message-Id: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Add the the big-endian and little-endian support for
  union perf_sample_weight.
  Rename the fields of the union perf_sample_weight.
- Move the check for the unsupported topdown events to event creation.
- Update the comments for the auxiliary event and modify the encoding
  of the auxiliary event.

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
 arch/x86/events/intel/core.c      | 363 +++++++++++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c        | 131 ++++++++++++--
 arch/x86/events/perf_event.h      |  39 +++-
 arch/x86/include/asm/perf_event.h |  16 +-
 include/linux/perf_event.h        |   4 +-
 include/uapi/linux/perf_event.h   |  61 ++++++-
 kernel/events/core.c              |  11 +-
 9 files changed, 578 insertions(+), 57 deletions(-)

-- 
2.7.4

