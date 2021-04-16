Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34788362ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhDPWOU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Apr 2021 18:14:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62400 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235708AbhDPWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:14:12 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GMD9Fu014689
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:13:46 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37y7tfkw5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:13:46 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 15:13:45 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 595B262E1FDE; Fri, 16 Apr 2021 15:13:41 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 4/4] perf-stat: introduce ':b' modifier
Date:   Fri, 16 Apr 2021 15:13:25 -0700
Message-ID: <20210416221325.2373497-5-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416221325.2373497-1-song@kernel.org>
References: <20210416221325.2373497-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _v4plTQsBrWxGHRD_TgQxwdByV1boCDx
X-Proofpoint-ORIG-GUID: _v4plTQsBrWxGHRD_TgQxwdByV1boCDx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160155
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce 'b' modifier to event parser, which means use BPF program to
manage this event. This is the same as --bpf-counters option, but only
applies to this event. For example,

  perf stat -e cycles:b,cs               # use bpf for cycles, but not cs
  perf stat -e cycles,cs --bpf-counters  # use bpf for both cycles and cs

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/perf/util/bpf_counter.c  | 2 +-
 tools/perf/util/evsel.h        | 1 +
 tools/perf/util/parse-events.c | 8 +++++++-
 tools/perf/util/parse-events.l | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 3189b63714371..7b4d511c7e6ec 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -790,7 +790,7 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
 {
 	if (target->bpf_str)
 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
-	else if (target->use_bpf)
+	else if (target->use_bpf || evsel->bpf_counter)
 		evsel->bpf_counter_ops = &bperf_ops;
 	else if (evsel__match_bpf_counter_events(evsel->name))
 		evsel->bpf_counter_ops = &bperf_ops;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ce4b629d659c2..8f66cdcb338d0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -82,6 +82,7 @@ struct evsel {
 		bool			auto_merge_stats;
 		bool			collect_stat;
 		bool			weak_group;
+		bool			bpf_counter;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 	};
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8123d218ad17c..46ebd269a98d1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1804,6 +1804,7 @@ struct event_modifier {
 	int pinned;
 	int weak;
 	int exclusive;
+	int bpf_counter;
 };
 
 static int get_event_modifier(struct event_modifier *mod, char *str,
@@ -1824,6 +1825,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	int exclude = eu | ek | eh;
 	int exclude_GH = evsel ? evsel->exclude_GH : 0;
 	int weak = 0;
+	int bpf_counter = 0;
 
 	memset(mod, 0, sizeof(*mod));
 
@@ -1867,6 +1869,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 			exclusive = 1;
 		} else if (*str == 'W') {
 			weak = 1;
+		} else if (*str == 'b') {
+			bpf_counter = 1;
 		} else
 			break;
 
@@ -1898,6 +1902,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	mod->sample_read = sample_read;
 	mod->pinned = pinned;
 	mod->weak = weak;
+	mod->bpf_counter = bpf_counter;
 	mod->exclusive = exclusive;
 
 	return 0;
@@ -1912,7 +1917,7 @@ static int check_modifier(char *str)
 	char *p = str;
 
 	/* The sizeof includes 0 byte as well. */
-	if (strlen(str) > (sizeof("ukhGHpppPSDIWe") - 1))
+	if (strlen(str) > (sizeof("ukhGHpppPSDIWeb") - 1))
 		return -1;
 
 	while (*p) {
@@ -1953,6 +1958,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->sample_read         = mod.sample_read;
 		evsel->precise_max         = mod.precise_max;
 		evsel->weak_group	   = mod.weak;
+		evsel->bpf_counter	   = mod.bpf_counter;
 
 		if (evsel__is_group_leader(evsel)) {
 			evsel->core.attr.pinned = mod.pinned;
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 0b36285a9435d..fb8646cc3e834 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -210,7 +210,7 @@ name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
-modifier_event	[ukhpPGHSDIWe]+
+modifier_event	[ukhpPGHSDIWeb]+
 modifier_bp	[rwx]{1,3}
 
 %%
-- 
2.30.2

