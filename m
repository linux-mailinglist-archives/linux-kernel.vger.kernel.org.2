Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCD33621BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhDPOHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:07:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:23086 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236295AbhDPOHQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:07:16 -0400
IronPort-SDR: zwEZr196I3k2UlTL6t8mkdJB2ZvCYxM0S75r+x4dOG5zpHM2v0elRR4BglxMX5XDWduzjnYzHS
 jzVufLSbxbYw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854313"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854313"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:06:51 -0700
IronPort-SDR: egLh6y2fBAWRgDfgqqx9Mru1FXz2VbfLNLhLuhMYynejeBClW5DpfDLW+4Zx0dQef4P6EuRVQj
 n5prXWiGR7vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766767"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:06:49 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 12/25] perf parse-events: Support event inside hybrid pmu
Date:   Fri, 16 Apr 2021 22:05:04 +0800
Message-Id: <20210416140517.18206-13-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, user may want to enable events on one pmu.

Following syntax are supported:

cpu_core/<event>/
cpu_atom/<event>/

But the syntax doesn't work for cache event.

Before:

  # perf stat -e cpu_core/LLC-loads/ -a -- sleep 1
  event syntax error: 'cpu_core/LLC-loads/'
                                \___ unknown term 'LLC-loads' for pmu 'cpu_core'

Cache events are a bit complex. We can't create aliases for them.
We use another solution. For example, if we use "cpu_core/LLC-loads/",
in parse_events_add_pmu(), term->config is "LLC-loads".

Then we create a new parser to scan "LLC-loads". The
parse_events_add_cache() would be called during parsing.
The parse_state->hybrid_pmu_name is used to identify the pmu
where the event should be enabled on.

After:

  # perf stat -e cpu_core/LLC-loads/ -a -- sleep 1

   Performance counter stats for 'system wide':

              24,593      cpu_core/LLC-loads/

         1.003911601 seconds time elapsed

If the user sets the config name, we will not uniquify hybrid
event name.

  # perf stat -e cpu_core/r3c/ -a -- sleep 1

   Performance counter stats for 'system wide':

           5,072,048      cpu_core/r3c/

         1.001989415 seconds time elapsed

  # perf stat -e cpu_core/r3c,name=EVENT/ -a -- sleep 1

   Performance counter stats for 'system wide':

           6,819,847      EVENT

         1.001795630 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v4:
 - New in v4.

 tools/perf/util/parse-events.c | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f69475a158bb..bd3fd722b4ac 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -38,6 +38,7 @@
 #include "util/event.h"
 #include "util/pfm.h"
 #include "util/parse-events-hybrid.h"
+#include "util/pmu-hybrid.h"
 #include "perf.h"
 
 #define MAX_NAME_LEN 100
@@ -48,6 +49,9 @@ extern int parse_events_debug;
 int parse_events_parse(void *parse_state, void *scanner);
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused);
+static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
+					 const char *str, char *pmu_name,
+					 struct list_head *list, bool *parsed);
 
 static struct perf_pmu_event_symbol *perf_pmu_events_list;
 /*
@@ -1567,6 +1571,27 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
 		return -ENOMEM;
 
+	if (!parse_state->fake_pmu && head_config &&
+	    perf_pmu__is_hybrid(name)) {
+		struct parse_events_term *term;
+		bool parsed;
+		int ret;
+
+		term = list_first_entry(head_config, struct parse_events_term,
+					list);
+		if (term && term->config && strcmp(term->config, "event")) {
+			ret = parse_events__with_hybrid_pmu(parse_state,
+							    term->config, name,
+							    list, &parsed);
+			/*
+			 * If the string inside the pmu can't be parsed,
+			 * don't return, try next steps.
+			 */
+			if (parsed)
+				return ret;
+		}
+	}
+
 	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
 		struct evsel_config_term *pos, *tmp;
 
@@ -1585,6 +1610,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (!evsel)
 		return -ENOMEM;
 
+	if (evsel->name)
+		evsel->use_config_name = true;
+
 	evsel->pmu_name = name ? strdup(name) : NULL;
 	evsel->use_uncore_alias = use_uncore_alias;
 	evsel->percore = config_term_percore(&evsel->config_terms);
@@ -2180,6 +2208,33 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	return ret;
 }
 
+static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
+					 const char *str, char *pmu_name,
+					 struct list_head *list, bool *parsed)
+{
+	struct parse_events_state ps = {
+		.list            = LIST_HEAD_INIT(ps.list),
+		.stoken          = PE_START_EVENTS,
+		.hybrid_pmu_name = pmu_name,
+		.idx             = parse_state->idx,
+	};
+	int ret;
+
+	*parsed = false;
+	ret = parse_events__scanner(str, &ps);
+	perf_pmu__parse_cleanup();
+
+	if (!ret) {
+		if (!list_empty(&ps.list)) {
+			*parsed = true;
+			list_splice(&ps.list, list);
+			parse_state->idx = ps.idx;
+		}
+	}
+
+	return ret;
+}
+
 int __parse_events(struct evlist *evlist, const char *str,
 		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
 {
-- 
2.17.1

