Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C468236EB02
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbhD2M7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:59:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:50831 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237362AbhD2M7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:59:31 -0400
IronPort-SDR: 7P3Hs3WC1JS+7E5LA7Ikq0nD9uNqWEAO4cS1ZjHkoo3TefCdbZIa9j54eL+b60ibXTu4ciUVrH
 hsLkpdhqVmXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177107425"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="177107425"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:58:42 -0700
IronPort-SDR: 2GUTPRorEbUVi/+y6LBwLdyKRDqE71geKgr1BlTfuR87tu1NuChNi5BRjItCVzwDLHyZE3JxK+
 dihZyJeDXm7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="537361615"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2021 05:58:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] perf inject: Add --vm-time-correlation option
Date:   Thu, 29 Apr 2021 15:58:47 +0300
Message-Id: <20210429125854.13905-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429125854.13905-1-adrian.hunter@intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PT timestamps are affected by virtualization. Add a new option
that will allow the Intel PT decoder to correlate the timestamps and
translate the virtual machine timestamps to host timestamps.

The advantages of making this a separate step, rather than a part of
normal decoding are that it is simpler to implement, and it needs to
be done only once.

This patch adds only the option. Later patches add Intel PT support.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-inject.txt | 10 ++++++
 tools/perf/builtin-inject.c              | 43 ++++++++++++++++++++++++
 tools/perf/util/auxtrace.h               |  6 ++++
 3 files changed, 59 insertions(+)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index a8eccff21281..89305b1a6d39 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -68,6 +68,16 @@ include::itrace.txt[]
 --force::
 	Don't complain, do it.
 
+--vm-time-correlation[=OPTIONS]::
+	Some architectures may capture AUX area data which contains timestamps
+	affected by virtualization. This option will update those timestamps
+	in place, to correlate with host timestamps. The in-place update means
+	that an output file is not specified, and instead the input file is
+	modified.  The options are architecture specific, except that they may
+	start with "dry-run" which will cause the file to be processed but
+	without updating it. Currently this option is supported only by
+	Intel PT, refer	linkperf:perf-intel-pt[1]
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-archive[1],
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ddfdeb85c586..8fba0cf746d5 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -698,6 +698,36 @@ static void strip_init(struct perf_inject *inject)
 		evsel->handler = drop_sample;
 }
 
+static int parse_vm_time_correlation(const struct option *opt, const char *str, int unset)
+{
+	struct perf_inject *inject = opt->value;
+	const char *args;
+	char *dry_run;
+
+	if (unset)
+		return 0;
+
+	inject->itrace_synth_opts.set = true;
+	inject->itrace_synth_opts.vm_time_correlation = true;
+	inject->in_place_update = true;
+
+	if (!str)
+		return 0;
+
+	dry_run = strstr(str, "dry-run");
+	if (dry_run) {
+		inject->itrace_synth_opts.vm_tm_corr_dry_run = true;
+		inject->in_place_update_dry_run = true;
+		args = dry_run + strlen("dry-run");
+	} else {
+		args = str;
+	}
+
+	inject->itrace_synth_opts.vm_tm_corr_args = strdup(args);
+
+	return inject->itrace_synth_opts.vm_tm_corr_args ? 0 : -ENOMEM;
+}
+
 static int __cmd_inject(struct perf_inject *inject)
 {
 	int ret = -EINVAL;
@@ -739,6 +769,15 @@ static int __cmd_inject(struct perf_inject *inject)
 			else if (!strncmp(name, "sched:sched_stat_", 17))
 				evsel->handler = perf_inject__sched_stat;
 		}
+	} else if (inject->itrace_synth_opts.vm_time_correlation) {
+		session->itrace_synth_opts = &inject->itrace_synth_opts;
+		memset(&inject->tool, 0, sizeof(inject->tool));
+		inject->tool.id_index	    = perf_event__process_id_index;
+		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
+		inject->tool.auxtrace	    = perf_event__process_auxtrace;
+		inject->tool.auxtrace_error = perf_event__process_auxtrace_error;
+		inject->tool.ordered_events = true;
+		inject->tool.ordering_requires_timestamps = true;
 	} else if (inject->itrace_synth_opts.set) {
 		session->itrace_synth_opts = &inject->itrace_synth_opts;
 		inject->itrace_synth_opts.inject = true;
@@ -880,6 +919,9 @@ int cmd_inject(int argc, const char **argv)
 				    itrace_parse_synth_opts),
 		OPT_BOOLEAN(0, "strip", &inject.strip,
 			    "strip non-synthesized events (use with --itrace)"),
+		OPT_CALLBACK_OPTARG(0, "vm-time-correlation", &inject, NULL, "opts",
+				    "correlate time between VM guests and the host",
+				    parse_vm_time_correlation),
 		OPT_END()
 	};
 	const char * const inject_usage[] = {
@@ -972,5 +1014,6 @@ int cmd_inject(int argc, const char **argv)
 out_delete:
 	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
+	free(inject.itrace_synth_opts.vm_tm_corr_args);
 	return ret;
 }
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 59c3c05384a4..9ac2ac1bd793 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -90,6 +90,9 @@ enum itrace_period_type {
  * @remote_access: whether to synthesize remote access events
  * @mem: whether to synthesize memory events
  * @timeless_decoding: prefer "timeless" decoding i.e. ignore timestamps
+ * @vm_time_correlation: perform VM Time Correlation
+ * @vm_tm_corr_dry_run: VM Time Correlation dry-run
+ * @vm_tm_corr_args:  VM Time Correlation implementation-specific arguments
  * @callchain_sz: maximum callchain size
  * @last_branch_sz: branch context size
  * @period: 'instructions' events period
@@ -130,6 +133,9 @@ struct itrace_synth_opts {
 	bool			remote_access;
 	bool			mem;
 	bool			timeless_decoding;
+	bool			vm_time_correlation;
+	bool			vm_tm_corr_dry_run;
+	char			*vm_tm_corr_args;
 	unsigned int		callchain_sz;
 	unsigned int		last_branch_sz;
 	unsigned long long	period;
-- 
2.17.1

