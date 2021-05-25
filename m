Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C833C38FE30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhEYJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:40276 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhEYJw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:26 -0400
IronPort-SDR: ITjikprvdooPcgEn1qUIHp9KpaKGhcYkAiwmKHAoDwMcw1MWgytzupSG2fXY5JHTSex2BfwXlB
 9obpoJJJXUaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181793015"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="181793015"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:50:57 -0700
IronPort-SDR: V7SsPooYrhTAP9FqgyxeZ3B39Mn3BIAX94NuTjTslPpAuSf58z0jba8Ucwfs1UJRqOCeKFmGW8
 hiquSVJ1nzFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224512"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:50:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] perf script: Factor out perf_sample__sprintf_flags()
Date:   Tue, 25 May 2021 12:51:06 +0300
Message-Id: <20210525095112.1399-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out perf_sample__sprintf_flags() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c   | 28 ++++++++++++++++++----------
 tools/perf/util/trace-event.h |  3 +++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f502d1c8a353..69bce65ea430 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1553,41 +1553,49 @@ static const char *sample_flags_to_name(u32 flags)
 	return NULL;
 }
 
-static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
+int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
 {
 	const char *chars = PERF_IP_FLAG_CHARS;
-	const int n = strlen(PERF_IP_FLAG_CHARS);
+	const size_t n = strlen(PERF_IP_FLAG_CHARS);
 	bool in_tx = flags & PERF_IP_FLAG_IN_TX;
 	const char *name = NULL;
-	char str[33];
-	int i, pos = 0;
+	size_t i, pos = 0;
 
 	name = sample_flags_to_name(flags & ~PERF_IP_FLAG_IN_TX);
 	if (name)
-		return fprintf(fp, "  %-15s%4s ", name, in_tx ? "(x)" : "");
+		return snprintf(str, sz, "%-15s%4s", name, in_tx ? "(x)" : "");
 
 	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
 		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_BEGIN));
 		if (name)
-			return fprintf(fp, "  tr strt %-7s%4s ", name, in_tx ? "(x)" : "");
+			return snprintf(str, sz, "tr strt %-7s%4s", name, in_tx ? "(x)" : "");
 	}
 
 	if (flags & PERF_IP_FLAG_TRACE_END) {
 		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_END));
 		if (name)
-			return fprintf(fp, "  tr end  %-7s%4s ", name, in_tx ? "(x)" : "");
+			return snprintf(str, sz, "tr end  %-7s%4s", name, in_tx ? "(x)" : "");
 	}
 
 	for (i = 0; i < n; i++, flags >>= 1) {
-		if (flags & 1)
+		if ((flags & 1) && pos < sz)
 			str[pos++] = chars[i];
 	}
 	for (; i < 32; i++, flags >>= 1) {
-		if (flags & 1)
+		if ((flags & 1) && pos < sz)
 			str[pos++] = '?';
 	}
-	str[pos] = 0;
+	if (pos < sz)
+		str[pos] = 0;
+
+	return pos;
+}
+
+static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
+{
+	char str[SAMPLE_FLAGS_BUF_SIZE];
 
+	perf_sample__sprintf_flags(flags, str, sizeof(str));
 	return fprintf(fp, "  %-19s ", str);
 }
 
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 24694463c0be..7276674e2971 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -105,4 +105,7 @@ int common_pc(struct scripting_context *context);
 int common_flags(struct scripting_context *context);
 int common_lock_depth(struct scripting_context *context);
 
+#define SAMPLE_FLAGS_BUF_SIZE 64
+int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
+
 #endif /* _PERF_UTIL_TRACE_EVENT_H */
-- 
2.17.1

