Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47936BCF4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 03:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhD0BiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 21:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbhD0BiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 21:38:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:23 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n22so3578364qtk.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGZt2e95AKfWt+VYGMGCH1QXq00vnH5tSNHSXr684oc=;
        b=Yeczzi0Ovs+WBm2tmCFsKN4inBB9B7/IMudhqxy9fQc2gDVU1D1pIkdWb9rjCoC0fB
         N/SKg+6HwljBX3QrPXOUk7HK7O3gUSlHuUNQ81MeGfxUxAQ448vBJXggwvdBy+5cykkX
         EX23E9KLqPXCUiXiKln9nw6dtfXhjb5YQulF3klkdPkk+GGeax4KHPX6YzRfnc6TOtHV
         EjCDUohLBROy+VHsP3n9/yiBGCsYnhSWpv+PnrF3XXPNl42RTBvoWTn80F1qoBdyILXy
         RPWRnYPmjZj7cre6rbzkZOqSRR5tPSUuQkgJGQAfljrmeNHG5R2U7b1lEamPg5NPU1dp
         uisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LGZt2e95AKfWt+VYGMGCH1QXq00vnH5tSNHSXr684oc=;
        b=Y0JBFrvxuvWTK3zn4H5JXriaVyKhiDDF/wDFRCqwlIb8Q/kIiUf2zpOI2zxrDUj1go
         ZYM1q0UxwS8cByh/zSVoOb2X+AONxyJUPiaevlSriowiR8OoAmdObO+Vx8wQmZyJjha0
         M+Q8XSKLseMVOKsHGrVHd+tQhmYuzCS+wBwjroY1zHrUBWnLsmhFOEtD5acSSJ9hQVk8
         BykbizoVK/zG5K9zP4ldbBZ9W8WceQ7cVI45cyrHl03ngsZZMYsFfZA/B1DjLYaXRDrD
         c7G3DDuksuTlZK8T/MLAT8TEKsbCC28rtdXGLvVxL1kY6eXNwlqQq9Irsvh05xB44RUE
         wCjw==
X-Gm-Message-State: AOAM532EuNXmnZUon7k8rLAvubYB2A+dpGRyu08NvKrmwM71Pitl6xPS
        8HuBZMMj/LzWfb4RTUtQ5A+UnyUKCMAPfyed
X-Google-Smtp-Source: ABdhPJxRTAY+mkCL3clkaOLmR6w6oR+J24gQkj7rgYfQ90gySovU14yZFDoEovRekNThvNwEFg9/tw==
X-Received: by 2002:ac8:6792:: with SMTP id b18mr4112038qtp.366.1619487442820;
        Mon, 26 Apr 2021 18:37:22 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id q67sm1858622qkb.89.2021.04.26.18.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 18:37:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2 1/6] perf top: Use evlist->events_stat to count events
Date:   Mon, 26 Apr 2021 18:37:12 -0700
Message-Id: <20210427013717.1651674-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210427013717.1651674-1-namhyung@kernel.org>
References: <20210427013717.1651674-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's mainly to count lost events for the warning so it should be ok
to use the evlist->stats instead.  This is needed for changes in the
next commit.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-top.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 173ace43f845..69cb3635f5ef 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -328,13 +328,13 @@ static void perf_top__print_sym_table(struct perf_top *top)
 	printf("%-*.*s\n", win_width, win_width, graph_dotted_line);
 
 	if (!top->record_opts.overwrite &&
-	    (hists->stats.nr_lost_warned !=
-	    hists->stats.nr_events[PERF_RECORD_LOST])) {
-		hists->stats.nr_lost_warned =
-			      hists->stats.nr_events[PERF_RECORD_LOST];
+	    (top->evlist->stats.nr_lost_warned !=
+	     top->evlist->stats.nr_events[PERF_RECORD_LOST])) {
+		top->evlist->stats.nr_lost_warned =
+			      top->evlist->stats.nr_events[PERF_RECORD_LOST];
 		color_fprintf(stdout, PERF_COLOR_RED,
 			      "WARNING: LOST %d chunks, Check IO/CPU overload",
-			      hists->stats.nr_lost_warned);
+			      top->evlist->stats.nr_lost_warned);
 		++printed;
 	}
 
@@ -852,11 +852,9 @@ static void
 perf_top__process_lost(struct perf_top *top, union perf_event *event,
 		       struct evsel *evsel)
 {
-	struct hists *hists = evsel__hists(evsel);
-
 	top->lost += event->lost.lost;
 	top->lost_total += event->lost.lost;
-	hists->stats.total_lost += event->lost.lost;
+	evsel->evlist->stats.total_lost += event->lost.lost;
 }
 
 static void
@@ -864,11 +862,9 @@ perf_top__process_lost_samples(struct perf_top *top,
 			       union perf_event *event,
 			       struct evsel *evsel)
 {
-	struct hists *hists = evsel__hists(evsel);
-
 	top->lost += event->lost_samples.lost;
 	top->lost_total += event->lost_samples.lost;
-	hists->stats.total_lost_samples += event->lost_samples.lost;
+	evsel->evlist->stats.total_lost_samples += event->lost_samples.lost;
 }
 
 static u64 last_timestamp;
@@ -1205,7 +1201,7 @@ static int deliver_event(struct ordered_events *qe,
 	} else if (event->header.type == PERF_RECORD_LOST_SAMPLES) {
 		perf_top__process_lost_samples(top, event, evsel);
 	} else if (event->header.type < PERF_RECORD_MAX) {
-		hists__inc_nr_events(evsel__hists(evsel), event->header.type);
+		events_stats__inc(&session->evlist->stats, event->header.type);
 		machine__process_event(machine, event, &sample);
 	} else
 		++session->evlist->stats.nr_unknown_events;
-- 
2.31.1.527.g47e6f16901-goog

