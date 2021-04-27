Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDA36BFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhD0HEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:54923 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234988AbhD0HE1 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:27 -0400
IronPort-SDR: YCdAyzQa7953S0YugbkEnXiahMzfHEHU6eSEPkSNEQPqCVyhCNYGdoR0jmnfKkPwZWwLgMQxLj
 amHPp2Vw74RA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196572994"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196572994"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:41 -0700
IronPort-SDR: Qgvq+ACQpxzFwf335nIluRNqUP3Huj8+OxHcE8SMCVhKwxbnkOSK4giNhLAyGr0EqdCaOBvJ2N
 zw7lqg2bR4kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506798"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:39 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 12/26] perf parse-events: Support event inside hybrid pmu
Date:   Tue, 27 Apr 2021 15:01:25 +0800
Message-Id: <20210427070139.25256-13-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
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

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v6:
 - No change.

v5:
 - Check the head_config list has only one term and if yes then
   do the second parsing. We drop the 'parsed' param and make
   parse_events__with_hybrid_pmu return 0 when we find some event.

   Move 'evsel->use_config_name = true;' to the patch
   '[PATCH v5 07/26] perf stat: Uniquify hybrid event name'.

v4:
 - New in v4.

 tools/perf/util/parse-events.c | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6236513e6369..4dad14265b81 100644
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
+					 struct list_head *list);
 
 static struct perf_pmu_event_symbol *perf_pmu_events_list;
 /*
@@ -1474,6 +1478,33 @@ static bool config_term_percore(struct list_head *config_terms)
 	return false;
 }
 
+static int parse_events__inside_hybrid_pmu(struct parse_events_state *parse_state,
+					   struct list_head *list, char *name,
+					   struct list_head *head_config)
+{
+	struct parse_events_term *term;
+	int ret = -1;
+
+	if (parse_state->fake_pmu || !head_config || list_empty(head_config) ||
+	    !perf_pmu__is_hybrid(name)) {
+		return -1;
+	}
+
+	/*
+	 * More than one term in list.
+	 */
+	if (head_config->next && head_config->next->next != head_config)
+		return -1;
+
+	term = list_first_entry(head_config, struct parse_events_term, list);
+	if (term && term->config && strcmp(term->config, "event")) {
+		ret = parse_events__with_hybrid_pmu(parse_state, term->config,
+						    name, list);
+	}
+
+	return ret;
+}
+
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
@@ -1567,6 +1598,11 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
 		return -ENOMEM;
 
+	if (!parse_events__inside_hybrid_pmu(parse_state, list, name,
+					     head_config)) {
+		return 0;
+	}
+
 	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
 		struct evsel_config_term *pos, *tmp;
 
@@ -2189,6 +2225,33 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	return ret;
 }
 
+static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
+					 const char *str, char *pmu_name,
+					 struct list_head *list)
+{
+	struct parse_events_state ps = {
+		.list            = LIST_HEAD_INIT(ps.list),
+		.stoken          = PE_START_EVENTS,
+		.hybrid_pmu_name = pmu_name,
+		.idx             = parse_state->idx,
+	};
+	int ret;
+
+	ret = parse_events__scanner(str, &ps);
+	perf_pmu__parse_cleanup();
+
+	if (!ret) {
+		if (!list_empty(&ps.list)) {
+			list_splice(&ps.list, list);
+			parse_state->idx = ps.idx;
+			return 0;
+		} else
+			return -1;
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

