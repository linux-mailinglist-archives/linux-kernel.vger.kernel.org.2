Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC536BF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhD0HEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:3176 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234764AbhD0HD5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:03:57 -0400
IronPort-SDR: IIbG31vqdIcMyJDeteBA5uKTiGpdxcmTNp0To+GI0FlsvKfxyPrOEAo/4pG54uGrY9x8uP4i7D
 KbfiRimH+N/A==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175944148"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="175944148"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:13 -0700
IronPort-SDR: dkSiJHabp0DQ/L93TpaW7h9Db/aCIdaIqjGsI+X9FulY0d04r2GVH083O6zRNdHEoDXXHWIa87
 /OWEuKFWx8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506594"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:11 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 02/26] perf jevents: Support unit value "cpu_core" and "cpu_atom"
Date:   Tue, 27 Apr 2021 15:01:15 +0800
Message-Id: <20210427070139.25256-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
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
v6:
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

