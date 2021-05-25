Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63A238FE32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhEYJwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:45711 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232779AbhEYJwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:31 -0400
IronPort-SDR: 0RfN2obuDNqA+QkCKFy4NwJJ5tQc0/85x7Wxfb3QIauu46oP4qKX7vaRsZ+yjvYTXkCJZpGNhF
 cclTC5FzYtCw==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="266047662"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="266047662"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:51:01 -0700
IronPort-SDR: Edje48bvZaSwV5eVpt5Wulug00EFIWsXn+wV3HQiXL2Xk2+rrEe+kskupIFPH/QiKUELqQKJI1
 +ytxhV8S2CbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224541"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:50:59 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] perf scripting python: Add IPC
Date:   Tue, 25 May 2021 12:51:08 +0300
Message-Id: <20210525095112.1399-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPC to python scripting.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 5d01e4fc50b8..fccd1b415ea0 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -831,6 +831,14 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	if (sample->flags)
 		python_process_sample_flags(sample, dict_sample);
 
+	/* Instructions per cycle (IPC) */
+	if (sample->insn_cnt && sample->cyc_cnt) {
+		pydict_set_item_string_decref(dict_sample, "insn_cnt",
+			PyLong_FromUnsignedLongLong(sample->insn_cnt));
+		pydict_set_item_string_decref(dict_sample, "cyc_cnt",
+			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
+	}
+
 	set_regs_in_dict(dict, sample, evsel);
 
 	return dict;
-- 
2.17.1

