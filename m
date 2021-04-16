Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3FA3621AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhDPOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:06:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:11215 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhDPOGn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:06:43 -0400
IronPort-SDR: a31aVgcnOLHxZDW5u74aLpPcBNNdZWrAaaD20YNaZCnG742gqzDWTi0qG9MK9IFpv7/9DfwEw1
 Xh0JPd1fF1Ow==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256358330"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="256358330"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:06:19 -0700
IronPort-SDR: VZ48TuyAK6hLkH6eSe3q/CyhzAbA1bcZaI3rggX/IBz6x3NbfT36fBBeKGbMMgEupqltFvHkv5
 4MmSnh1DLs+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766615"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:06:15 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 02/25] perf jevents: Support unit value "cpu_core" and "cpu_atom"
Date:   Fri, 16 Apr 2021 22:04:54 +0800
Message-Id: <20210416140517.18206-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
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

The unit "cpu_atom" indicates this event is only available on "cpu_atom".

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
v4:
 - No change.

 tools/perf/pmu-events/jevents.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 33aa3c885eaf..ed4f0bd72e5a 100644
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

