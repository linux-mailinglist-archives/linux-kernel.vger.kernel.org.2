Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE5368CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbhDWFhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:37:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:9279 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235684AbhDWFhT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:37:19 -0400
IronPort-SDR: oDnaJ8u6YqC3aX2frmYKpduhCuTqBDqrMAB1fSKUazeQc1g/h5Ab5d6HffCAvdFvmaJ48vWOiz
 fiWFcKtvPcbw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501772"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501772"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:36:42 -0700
IronPort-SDR: aaHvhrndfAGjd8s3Is2is+C0we8/U4wCA/g1WPcmGKaNehHdknIWLqQ7tJ5A//wcVqaoPqaumf
 wf1wZVvRpiKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293519"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:36:39 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 02/26] perf jevents: Support unit value "cpu_core" and "cpu_atom"
Date:   Fri, 23 Apr 2021 13:35:17 +0800
Message-Id: <20210423053541.12521-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
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
v5:
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

