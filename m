Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB83DA82E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhG2QA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:00:57 -0400
Received: from foss.arm.com ([217.140.110.172]:51346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238298AbhG2P6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:58:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B6E1042;
        Thu, 29 Jul 2021 08:58:51 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB6603F73D;
        Thu, 29 Jul 2021 08:58:48 -0700 (PDT)
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
Subject: [RFC PATCH 2/6] perf tools: Re-add annotate_warned functionality
Date:   Thu, 29 Jul 2021 16:58:01 +0100
Message-Id: <20210729155805.2830-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210729155805.2830-1-james.clark@arm.com>
References: <20210729155805.2830-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting annotate_warned to true on errors was removed in
commit ee51d851392e ("perf annotate: Introduce strerror for handling
symbol__disassemble() errors") which means when 'perf annotate
--skip-missing' is used warnings are shown multiple times for the same
DSO.

Setting this again restores the original behavior of only one warning
each.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/ui/browsers/annotate.c | 1 +
 tools/perf/ui/gtk/annotate.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 701130ad43a2..ef4da4295bf7 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -966,6 +966,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 	err = symbol__annotate2(ms, evsel, opts, &browser.arch);
 	if (err) {
 		char msg[BUFSIZ];
+		ms->map->dso->annotate_warned = true;
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
 		goto out_free_offsets;
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 94167bfed722..0a50e962f9a3 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -177,6 +177,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	err = symbol__annotate(ms, evsel, &annotation__default_options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
+		ms->map->dso->annotate_warned = true;
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 		ui__error("Couldn't annotate %s: %s\n", sym->name, msg);
 		return -1;
-- 
2.28.0

