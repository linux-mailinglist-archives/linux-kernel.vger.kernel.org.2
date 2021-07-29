Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB583DA829
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhG2QAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:00:35 -0400
Received: from foss.arm.com ([217.140.110.172]:51362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238179AbhG2P66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:58:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F3091063;
        Thu, 29 Jul 2021 08:58:54 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 483A93F73D;
        Thu, 29 Jul 2021 08:58:52 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Cc:     leo.yan@linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/6] perf tools: Add disassembly warnings for annotate --stdio
Date:   Thu, 29 Jul 2021 16:58:02 +0100
Message-Id: <20210729155805.2830-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210729155805.2830-1-james.clark@arm.com>
References: <20210729155805.2830-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently 'perf annotate --stdio' (and --stdio2) will exit without
printing anything if there are disassembly errors. Apply the same
error handler that's used for TUI and GTK modes. This makes comparing
disassembly across the different modes more consistent.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/annotate.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index aa04a3655236..1ed097bcb78a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2787,9 +2787,17 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
 	struct rb_root source_line = RB_ROOT;
 	struct hists *hists = evsel__hists(evsel);
 	char buf[1024];
+	int err;
+
+	err = symbol__annotate2(ms, evsel, opts, NULL);
+	if (err) {
+		char msg[BUFSIZ];
 
-	if (symbol__annotate2(ms, evsel, opts, NULL) < 0)
+		dso->annotate_warned = true;
+		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
+		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
 		return -1;
+	}
 
 	if (opts->print_lines) {
 		srcline_full_filename = opts->full_path;
@@ -2813,9 +2821,17 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
 	struct dso *dso = ms->map->dso;
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
+	int err;
+
+	err = symbol__annotate(ms, evsel, opts, NULL);
+	if (err) {
+		char msg[BUFSIZ];
 
-	if (symbol__annotate(ms, evsel, opts, NULL) < 0)
+		dso->annotate_warned = true;
+		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
+		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
 		return -1;
+	}
 
 	symbol__calc_percent(sym, evsel);
 
-- 
2.28.0

