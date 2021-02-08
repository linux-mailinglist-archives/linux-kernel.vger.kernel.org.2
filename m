Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8FE313D1E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhBHSUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:20:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:62781 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234042AbhBHPp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:45:27 -0500
IronPort-SDR: lksYl8JgQrZPVP+C8WAJMlNiZn4mFJTvxk6/Dn6MDwdz0dj3I1d3eFfCMlyJCVhyQL7wpzpMax
 fi2ybAueAaeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180952043"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180952043"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:36 -0800
IronPort-SDR: GaVUM4292SQNiAbdIjwnWrsMC0GjatfIEbbLKISSjY/L4UrdyV47CD+wwElzZ8jiWG3DAm1n3a
 j/blRmTkKmbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820866"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:35 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 26/49] perf jevents: Support unit value "cpu_core" and "cpu_atom"
Date:   Mon,  8 Feb 2021 07:25:23 -0800
Message-Id: <1612797946-18784-27-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

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

But if without this patch, the "uncore_" prefix is added by the internal
JSON file parser.
        .pmu = "uncore_cpu_atom"

That would be a wrong pmu.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e1f3f5c..b1a15f5 100644
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
2.7.4

