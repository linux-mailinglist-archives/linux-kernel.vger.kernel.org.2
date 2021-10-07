Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBC4258A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbhJGRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbhJGRAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:10 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF82AC061786
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 09:57:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id m10-20020ad4448a000000b003833687f674so1436302qvt.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EoTWv39qOV0K5K8xgRfTINzwSs5Jg8RDNsX4WA9cOQ4=;
        b=PMluCx99F8oKmUvfrvzkEucHAfmxhzX8cfXZ31V0b6RbDrh9qnGAEeNtNRB06Wa32m
         xwAj4pzR0GfHJC6Y+TtUpUIOELBPcNsgFOHBjFHJl2/EH0XXwZj65NptQownvrkx7eOP
         twC/Ec4z/200f8JjZFdlgpTcq7vkXkQVGfNef1OU8HuSfkQks8TYa3WRpQ+PNjBgR15c
         fs48mi6FETVzMGUFWKoE07d9woMtTY+RD7xCZJYoryW3GChVyR0QkILH7QqOWUuS+rYD
         +HwddigB3m7xVaezNLvVhx3CSklwXOZxUZuaV9hwsUfRvo/F0iBtOuXTZT4fH+tfKEyk
         emXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EoTWv39qOV0K5K8xgRfTINzwSs5Jg8RDNsX4WA9cOQ4=;
        b=NqJlbx+B/tVrTjJ7LVZzhYVgIAUS7luxNvNPMU5ZuqhMvg0vkqk3K9RXkGqzBbu3wc
         X7BkbWOb2ryu5srVNjbWXUG7br7hUZzRlqriwFO+JSYBdKvtOlTkummEuW9LqAnC/UtR
         Vjnq+Crbo3ND+1/8tGXHosbOHqgASpD89sF/YqKKxHzal9IFLBSwbC2MkmmK7LrTh/Kn
         3d0EhWp3Gag6CMRZVu3100anGA7Wfz3Fmg/s+Q9hFGzrtgnx6p/4Y/hsXOS9ZFOFoYyZ
         FDjsagOVAFNcIRaVdAJ/xE1y6yvKMuUXc9tKryL/hzMTGosogyO3+yQgLWmT+pwN4ytk
         3Z/w==
X-Gm-Message-State: AOAM531n6UlJBA2HG+PbeTDB5A4HKa0D6FMaNQMQ325kWFhuPbvUCBKP
        4/6M5Bp9XpaBMUWBjJBZcSm3Ec1sMGN+
X-Google-Smtp-Source: ABdhPJwiYH7M++h0yB51xY4VcGLl76bHc954P/DC7hd8SyViRXGOjyJHd21INzyveKoMmQWbXznEkyVJ0llR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:ac8:5e14:: with SMTP id
 h20mr2528991qtx.364.1633625872985; Thu, 07 Oct 2021 09:57:52 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:36 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-11-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 10/21] perf metric: Comment data structures.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the data structures maintained by metricgroup.c and used by
stat-shadow.c for metric output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 88ba939a3082..3a51a84f440b 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -14,24 +14,51 @@ struct rblist;
 struct pmu_events_map;
 struct cgroup;
 
+/**
+ * A node in a rblist keyed by the evsel. The global rblist of metric events
+ * generally exists in perf_stat_config. The evsel is looked up in the rblist
+ * yielding a list of metric_expr.
+ */
 struct metric_event {
 	struct rb_node nd;
 	struct evsel *evsel;
 	struct list_head head; /* list of metric_expr */
 };
 
+/**
+ * A metric referenced by a metric_expr. When parsing a metric expression IDs
+ * will be looked up, matching either a value (from metric_events) or a
+ * metric_ref. A metric_ref will then be parsed recursively. The metric_refs and
+ * metric_events need to be known before parsing so that their values may be
+ * placed in the parse context for lookup.
+ */
 struct metric_ref {
 	const char *metric_name;
 	const char *metric_expr;
 };
 
+/**
+ * One in a list of metric_expr associated with an evsel. The data is used to
+ * generate a metric value during stat output.
+ */
 struct metric_expr {
 	struct list_head nd;
+	/** The expression to parse, for example, "instructions/cycles". */
 	const char *metric_expr;
+	/** The name of the meric such as "IPC". */
 	const char *metric_name;
+	/**
+	 * The "ScaleUnit" that scales and adds a unit to the metric during
+	 * output. For example, "6.4e-05MiB" means to scale the resulting metric
+	 * by 6.4e-05 (typically converting a unit like cache lines to something
+	 * more human intelligible) and then add "MiB" afterward when displayed.
+	 */
 	const char *metric_unit;
+	/** Null terminated array of events used by the metric. */
 	struct evsel **metric_events;
+	/** Null terminated array of referenced metrics. */
 	struct metric_ref *metric_refs;
+	/** A value substituted for '?' during parsing. */
 	int runtime;
 };
 
-- 
2.33.0.882.g93a45727a2-goog

