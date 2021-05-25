Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8690838FE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhEYJwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:40266 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhEYJwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:22 -0400
IronPort-SDR: lBiwB1kxI/+bSMv5jeWzUWdvRoQQSMQpMOAovOKUlMlxzcxYtup2ErkYtW0WfXX8YOLneWuMAx
 MyhgV6HM6LcA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181793004"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="181793004"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:50:53 -0700
IronPort-SDR: spjIIjaTUcMCNeaupmeLEHB2AtXaKWKwFzvWRnGcpI2YSNaFBzo/akWRbhgQDXLO5pqZY93ebu
 R+NyE6wFuJlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224492"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:50:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] perf scripting python: Factor out set_sym_in_dict()
Date:   Tue, 25 May 2021 12:51:04 +0300
Message-Id: <20210525095112.1399-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out set_sym_in_dict() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripting-engines/trace-event-python.c    | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 1d718ac5f574..4c067601595c 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -726,6 +726,22 @@ static void set_regs_in_dict(PyObject *dict,
 			_PyUnicode_FromString(bf));
 }
 
+static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
+			    const char *dso_field, const char *sym_field,
+			    const char *symoff_field)
+{
+	if (al->map) {
+		pydict_set_item_string_decref(dict, dso_field,
+			_PyUnicode_FromString(al->map->dso->name));
+	}
+	if (al->sym) {
+		pydict_set_item_string_decref(dict, sym_field,
+			_PyUnicode_FromString(al->sym->name));
+		pydict_set_item_string_decref(dict, symoff_field,
+			PyLong_FromUnsignedLong(get_offset(al->sym, al)));
+	}
+}
+
 static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 					 struct evsel *evsel,
 					 struct addr_location *al,
@@ -772,14 +788,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			(const char *)sample->raw_data, sample->raw_size));
 	pydict_set_item_string_decref(dict, "comm",
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
-	if (al->map) {
-		pydict_set_item_string_decref(dict, "dso",
-			_PyUnicode_FromString(al->map->dso->name));
-	}
-	if (al->sym) {
-		pydict_set_item_string_decref(dict, "symbol",
-			_PyUnicode_FromString(al->sym->name));
-	}
+	set_sym_in_dict(dict, al, "dso", "symbol", "symoff");
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
-- 
2.17.1

