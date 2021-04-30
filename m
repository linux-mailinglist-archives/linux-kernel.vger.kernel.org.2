Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4FE36F615
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhD3HDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:03:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:34039 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhD3HDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:03:44 -0400
IronPort-SDR: VuSFh6vx3UzbOUg9bF1ewV2NP0WOq2oSP1gHzEWm64CXdk3L8nYYh6ouH4H3zCFvWA2LADLfmO
 /GRm5A4r7Z0g==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197312421"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="197312421"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:02:57 -0700
IronPort-SDR: lspXuqoeCvXw+M5yVjfTLH1zkXkq4S4BsyJLM2yhJnj7/ycGJj22Haz2LJVb6vykBkis3TY5XR
 bSELufjKkPuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404492263"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2021 00:02:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/12] perf intel-pt: Support Z itrace option for timeless decoding
Date:   Fri, 30 Apr 2021 10:03:00 +0300
Message-Id: <20210430070309.17624-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430070309.17624-1-adrian.hunter@intel.com>
References: <20210430070309.17624-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correlating virtual machine TSC packets is not supported at present, so
instead support the Z itrace option.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 5 +++++
 tools/perf/util/intel-pt.c                 | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 1dcec73c910c..33df7898c378 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -869,6 +869,7 @@ The letters are:
 	L	synthesize last branch entries on existing event records
 	s	skip initial number of events
 	q	quicker (less detailed) decoding
+	Z	prefer to ignore timestamps (so-called "timeless" decoding)
 
 "Instructions" events look like they were recorded by "perf record -e
 instructions".
@@ -1062,6 +1063,10 @@ What *will* be decoded with the qq option:
 
 	- instruction pointer associated with PSB packets
 
+The Z option is equivalent to having recorded a trace without TSC
+(i.e. config term tsc=0). It can be useful to avoid timestamp issues when
+decoding a trace of a virtual machine.
+
 
 dump option
 ~~~~~~~~~~~
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index eef8970d98fe..7bee969eb335 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -899,7 +899,7 @@ static bool intel_pt_timeless_decoding(struct intel_pt *pt)
 	bool timeless_decoding = true;
 	u64 config;
 
-	if (!pt->tsc_bit || !pt->cap_user_time_zero)
+	if (!pt->tsc_bit || !pt->cap_user_time_zero || pt->synth_opts.timeless_decoding)
 		return true;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-- 
2.25.1

