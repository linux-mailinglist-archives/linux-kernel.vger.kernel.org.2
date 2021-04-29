Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4360A36EB01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbhD2M7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:59:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:50834 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237366AbhD2M7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:59:31 -0400
IronPort-SDR: A/xcjP9D6dWU3oyppbWUoyXeoKrzQg8XxsBzQQ3EHZApx+rnmE7ZTqiyD8+RWy7Hs9D7ibiENs
 KJfJPIXOhA7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177107407"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="177107407"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:58:34 -0700
IronPort-SDR: JjxtUtEkRQiQMjnejTPola45zhJvo4iP/uvnYNBp2NqB3ERYlNPFfGSMP0nkAg1DDTvRFMER7r
 gZLvV9kXBeTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="537361567"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2021 05:58:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] perf auxtrace: Add Z itrace option for timeless decoding
Date:   Thu, 29 Apr 2021 15:58:43 +0300
Message-Id: <20210429125854.13905-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429125854.13905-1-adrian.hunter@intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issues correlating timestamps can be avoided with timeless decoding. Add
an option for that, so that timeless decoding can be used even when
timestamps are present.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/util/auxtrace.c          | 3 +++
 tools/perf/util/auxtrace.h          | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 0f1005209a2b..2d586fe5e4c5 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -20,6 +20,7 @@
 		L	synthesize last branch entries on existing event records
 		s       skip initial number of events
 		q	quicker (less detailed) decoding
+		Z	prefer to ignore timestamps (so-called "timeless" decoding)
 
 	The default is all events i.e. the same as --itrace=ibxwpe,
 	except for perf script where it is --itrace=ce
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 5b6ccb90b397..48b88e2bca1e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1569,6 +1569,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 		case 'q':
 			synth_opts->quick += 1;
 			break;
+		case 'Z':
+			synth_opts->timeless_decoding = true;
+			break;
 		case ' ':
 		case ',':
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a4fbb33b7245..59c3c05384a4 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -89,6 +89,7 @@ enum itrace_period_type {
  * @tlb: whether to synthesize TLB events
  * @remote_access: whether to synthesize remote access events
  * @mem: whether to synthesize memory events
+ * @timeless_decoding: prefer "timeless" decoding i.e. ignore timestamps
  * @callchain_sz: maximum callchain size
  * @last_branch_sz: branch context size
  * @period: 'instructions' events period
@@ -128,6 +129,7 @@ struct itrace_synth_opts {
 	bool			tlb;
 	bool			remote_access;
 	bool			mem;
+	bool			timeless_decoding;
 	unsigned int		callchain_sz;
 	unsigned int		last_branch_sz;
 	unsigned long long	period;
-- 
2.17.1

