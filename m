Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7D3952AF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhE3TYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:21268 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhE3TYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:41 -0400
IronPort-SDR: ZRgG5Ufo61/qzXajlrFM0slsH3itV8YNDMZeCquUIt7TAvRqRyYyDmXUJkl2mjet3CIL6rpYkh
 bRwhKiNv/jXA==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362462"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362462"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:23:03 -0700
IronPort-SDR: 1Um4LUdS9nBCOtphpfP/moE05OJVMO6LQ7ZHttybYwWHiDBn7/hztTM8mOsj256ggBrFxUf6oS
 yhsqhD3QYJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926302"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:23:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] perf auxtrace: Factor out itrace_do_parse_synth_opts()
Date:   Sun, 30 May 2021 22:23:03 +0300
Message-Id: <20210530192308.7382-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out itrace_do_parse_synth_opts() so that it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 10 +++++++---
 tools/perf/util/auxtrace.h | 10 ++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 62268f8b6c4f..9350eeb3a3fc 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1405,10 +1405,9 @@ static int get_flags(const char **ptr, unsigned int *plus_flags, unsigned int *m
  * about the options parsed here, which is introduced after this cset,
  * when support in 'perf script' for these options is introduced.
  */
-int itrace_parse_synth_opts(const struct option *opt, const char *str,
-			    int unset)
+int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
+			       const char *str, int unset)
 {
-	struct itrace_synth_opts *synth_opts = opt->value;
 	const char *p;
 	char *endptr;
 	bool period_type_set = false;
@@ -1596,6 +1595,11 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 	return -EINVAL;
 }
 
+int itrace_parse_synth_opts(const struct option *opt, const char *str, int unset)
+{
+	return itrace_do_parse_synth_opts(opt->value, str, unset);
+}
+
 static const char * const auxtrace_error_type_name[] = {
 	[PERF_AUXTRACE_ERROR_ITRACE] = "instruction trace",
 };
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 4283a4befcb6..efca761e8b84 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -607,6 +607,8 @@ s64 perf_event__process_auxtrace(struct perf_session *session,
 				 union perf_event *event);
 int perf_event__process_auxtrace_error(struct perf_session *session,
 				       union perf_event *event);
+int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
+			       const char *str, int unset);
 int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			    int unset);
 void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
@@ -738,6 +740,14 @@ void events_stats__auxtrace_error_warn(const struct events_stats *stats
 {
 }
 
+static inline
+int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts __maybe_unused,
+			       const char *str __maybe_unused, int unset __maybe_unused)
+{
+	pr_err("AUX area tracing not supported\n");
+	return -EINVAL;
+}
+
 static inline
 int itrace_parse_synth_opts(const struct option *opt __maybe_unused,
 			    const char *str __maybe_unused,
-- 
2.17.1

