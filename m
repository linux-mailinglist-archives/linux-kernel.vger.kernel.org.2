Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994EF38FE31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhEYJwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:40280 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232749AbhEYJw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:28 -0400
IronPort-SDR: ZGtx9lFM0USjhFTZ0DsqmF1fGCFzmsPl+y/ln5RCVvuX1jx5BRONsICBbXpLMaeAn8nVzu6M3b
 XIf52K43JGUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181793039"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="181793039"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:50:59 -0700
IronPort-SDR: 9dl+Z3ApstaxkMwiLlyFX1H7kyRRUY4AONk9yTQT2D5LtLNZ5Gw/JdiAE8NuD6QZX/rvrjRVTN
 8SYcHc7ipA9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224524"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:50:57 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] perf scripting python: Add sample flags
Date:   Tue, 25 May 2021 12:51:07 +0300
Message-Id: <20210525095112.1399-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sample flags to python scripting.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripting-engines/trace-event-python.c    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index a434f4bc25a4..5d01e4fc50b8 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -742,6 +742,29 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 	}
 }
 
+static void set_sample_flags(PyObject *dict, u32 flags)
+{
+	const char *ch = PERF_IP_FLAG_CHARS;
+	char *p, str[33];
+
+	for (p = str; *ch; ch++, flags >>= 1) {
+		if (flags & 1)
+			*p++ = *ch;
+	}
+	*p = 0;
+	pydict_set_item_string_decref(dict, "flags", _PyUnicode_FromString(str));
+}
+
+static void python_process_sample_flags(struct perf_sample *sample, PyObject *dict_sample)
+{
+	char flags_disp[SAMPLE_FLAGS_BUF_SIZE];
+
+	set_sample_flags(dict_sample, sample->flags);
+	perf_sample__sprintf_flags(sample->flags, flags_disp, sizeof(flags_disp));
+	pydict_set_item_string_decref(dict_sample, "flags_disp",
+		_PyUnicode_FromString(flags_disp));
+}
+
 static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 					 struct evsel *evsel,
 					 struct addr_location *al,
@@ -805,6 +828,9 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_symbol", "addr_symoff");
 	}
 
+	if (sample->flags)
+		python_process_sample_flags(sample, dict_sample);
+
 	set_regs_in_dict(dict, sample, evsel);
 
 	return dict;
-- 
2.17.1

