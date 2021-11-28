Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679F146055F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 10:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhK1JDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 04:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhK1JBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 04:01:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF269C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 00:58:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so17714162ybj.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 00:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=B+bepFFO60RHu083vmt4BCiYb9T8HQxbga3/n6RHU9Q=;
        b=XDdX8MnED/VSwoaAVg6qptHPu+vCMYQdvGnOvsXMUpiwlqBuZrvj5FZJ2eIa9SJ40v
         QRg7EbhhPPEzzgdt4BRNFS8ADBlpl1pR2MhJh1k15vfAKAIH/Dp+YrSBwxu/P2Hp+Uv5
         gpH0LzbgViA0A5KbSKvSBARAx4iB9kwWzW5OCwfQYZwDKyo3QoWFk/4S/WBB0CmB4Olp
         sEvNtmkrSoy2uXDiUJz7zKE2ohIbuuNIOIH1ooYb3sbjnAw8PX/TPBRNGNK7Kmi4YDkB
         eIGMaB2wkpU5Mbyv0spIXKR94guJma9vLTz+imcP1MqfVRH6XCdtJB4GatrZjS0VpewY
         wr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=B+bepFFO60RHu083vmt4BCiYb9T8HQxbga3/n6RHU9Q=;
        b=yIb8j2P6yLMyEHDdfX6mQ5QqGgYCkZG5cMXxWpXaMES6AgW104pyeS9HNr5NQL9RVy
         4UiZ1rZD/ptMQvbESs2vgvEeIQfCDnYBfdQuGrOf+FeXkAwS/YfkHZkWk3+L3lau2EnI
         v5hAW1z5fOWFLwdiA7R4uIWF+keoIN65HzdLZytqXkcR3HEFZwbm5zMiQ9muRgJ30ec1
         81jXahH5RlI2sIpGy+9o1Ksqfu2BEUYeDa3NmbmNwjBIRYnmhpG+7NlLBYkTS4GCYkNS
         tUxnkrw4fTc5DBA0dwjSk+GXzqNb2KelwIQbdwEYJ4jET4SfLQoyJVaQ2UXes1b8rgcT
         7R0A==
X-Gm-Message-State: AOAM533sDT4CX3Yi2qdgcYERH8fgu14JgxkvC9+g6I9fhqwUCrkbA/me
        dm3UO/CeU/GwaYqulzjmqKgDTn0xWfsv
X-Google-Smtp-Source: ABdhPJzmEIPX+KpstpW0QlHCvyNyp2Hfk5Y4i62l/KwfAm7bAHYPdiwD98ymagB8SC72m50dmi8i6a5yFWL6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:24f5:bc1a:df07:6b3d])
 (user=irogers job=sendgmr) by 2002:a25:311:: with SMTP id 17mr27600974ybd.483.1638089897440;
 Sun, 28 Nov 2021 00:58:17 -0800 (PST)
Date:   Sun, 28 Nov 2021 00:58:10 -0800
Message-Id: <20211128085810.4027314-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] perf test: Reset shadow counts before loading
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise load counting is an average. Without this change
duration_time in test_memory_bandwidth will alter its value if an
earlier test contains duration_time.

This patch fixes an issue that's introduced in the proposed patch:
https://lore.kernel.org/lkml/20211124015226.3317994-1-irogers@google.com/
in perf test "Parse and process metrics".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-metric.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 574b7e4efd3a..07b6f4ec024f 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -109,6 +109,7 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
 	struct evsel *evsel;
 	u64 count;
 
+	perf_stat__reset_shadow_stats();
 	evlist__for_each_entry(evlist, evsel) {
 		count = find_value(evsel->name, vals);
 		perf_stat__update_shadow_stats(evsel, count, 0, st);
-- 
2.34.0.rc2.393.gf8c9666880-goog

