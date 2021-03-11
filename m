Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20448336CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhCKHI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:08:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhCKHIY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:24 -0500
IronPort-SDR: VSnMJ6C15CiPysblHvbX76BHDBPNzNitbxSARaxvJ2sF/bS2HJTZrEcUMflzqif9W9tbIN8Tcz
 pfy1Pddnswig==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246012"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:24 -0800
IronPort-SDR: zrZky0rSQUzAvA8enR1TtgV+q616y2N6gL2QnIyXAmKCWnEyppowX3ELhEIy5zdaSWGAAA4JgZ
 GjJWP8GKSsGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937814"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:22 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 02/27] perf jevents: Support unit value "cpu_core" and "cpu_atom"
Date:   Thu, 11 Mar 2021 15:07:17 +0800
Message-Id: <20210311070742.9318-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some Intel platforms, such as Alderlake, which is a hybrid platform
and it consists of atom cpu and core cpu. Each cpu has dedicated event
list. Part of events are available on core cpu, part of events are
available on atom cpu.

The kernel exports new cpu pmus: cpu_core and cpu_atom. The event in
json is added with a new field "Unit" to indicate which pmu the event
is available on.

For example, one event in cache.json,

    {
        "BriefDescription": "Counts the number of load ops retired that",
        "CollectPEBSRecord": "2",
        "Counter": "0,1,2,3",
        "EventCode": "0xd2",
        "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.MMIO",
        "PEBScounters": "0,1,2,3",
        "SampleAfterValue": "1000003",
        "UMask": "0x80",
        "Unit": "cpu_atom"
    },

The unit "cpu_atom" indicates this event is only availabe on "cpu_atom".

In generated pmu-events.c, we can see:

{
        .name = "mem_load_uops_retired_misc.mmio",
        .event = "period=1000003,umask=0x80,event=0xd2",
        .desc = "Counts the number of load ops retired that. Unit: cpu_atom ",
        .topic = "cache",
        .pmu = "cpu_atom",
},

But if without this patch, the "uncore_" prefix is added before "cpu_atom",
such as:
        .pmu = "uncore_cpu_atom"

That would be a wrong pmu.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e1f3f5c8c550..b1a15f57c9ad 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -285,6 +285,8 @@ static struct map {
 	{ "imx8_ddr", "imx8_ddr" },
 	{ "L3PMC", "amd_l3" },
 	{ "DFPMC", "amd_df" },
+	{ "cpu_core", "cpu_core" },
+	{ "cpu_atom", "cpu_atom" },
 	{}
 };
 
-- 
2.17.1

