Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4425F369995
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbhDWS25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbhDWS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:28:56 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660E3C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z2so13563390qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mE6rQee6kWh13givt51gTVPRCLz+zTbnJEBwrgnDe5E=;
        b=BFAwE528inFfWVZoRdelS82n/e8RGGuqJiXcHYT/GeSG0AbjMYMZJPEMLU6pV+VOk9
         YIOP6GsYxq0/WGN8Us2XjcA0pnJLD0i5xZ+JQq3VaA+prdugZYSW+SVCzppvrQWMTCoq
         RrxyHdWhaOr9R0Rv3tSnGTPJpoQLuQmXCQ2SyhlVBxPa6wEl5gFUxTvptE86qwkmYzIl
         pmHvHdyslf0hiDX98dE8q6AU4kyP7Lt4GIGBctbuEuGxRnxZKtu0pAYzVjiFqk6l6+S4
         jzaY39opc2cOi/DY7CuBzA/x3KwS6BPk6z0O12htMi2905RsupHxYBQmI+DTr02gpl4F
         Or7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mE6rQee6kWh13givt51gTVPRCLz+zTbnJEBwrgnDe5E=;
        b=ktoZlquPUyVl78kZ3+yvPE+FyRP8XdvlOd5sSipgap21ImZqaOo9LFiWLpmJCiN24p
         oFvGK11xMm5XB92+Myu5hBbj9tQ+UFeOvtSleiE1B7wqlzhTXSQ37fiDZ8zm6PjCHF/p
         /yfwdvGGdzR9DrYl4ud+YSKYDY06UFQXndXbB2+YeVurHT4PD4s4R5baTZ2NmSTKJBwr
         kZxh+t0huCGdvrNhx0VK6ULFuQZDF9LgghMATfRtGoxOg1ksq2HduHnEQopF3jvwQtQV
         lStaobkP+ySQnPP4A2j1Ybyxse9VVTSYK04JNtyzu1pAEqQ/Rcip35EGWCYCwkTjWedv
         HLVQ==
X-Gm-Message-State: AOAM532JoglMG2B9lGjDzLBTxk3l0ClFIQiAHE5w6BOEWWXUqcu9+5bi
        e1sEqWzB/awCrSg8Aaaq+ZU=
X-Google-Smtp-Source: ABdhPJzxO9VKg13S0vDpH8j7gqECPxMPyEZmrfhvEvMw4W0ZouQhsPAFB9aDmIG9uqTewL0i3OlOKw==
X-Received: by 2002:ae9:ec1a:: with SMTP id h26mr5415133qkg.238.1619202497687;
        Fri, 23 Apr 2021 11:28:17 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id c5sm4783863qkl.7.2021.04.23.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:28:17 -0700 (PDT)
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
Subject: [PATCH 1/5] perf top: Use evlist->events_stat to count events
Date:   Fri, 23 Apr 2021 11:28:09 -0700
Message-Id: <20210423182813.1472902-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423182813.1472902-1-namhyung@kernel.org>
References: <20210423182813.1472902-1-namhyung@kernel.org>
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
2.31.1.498.g6c1eba8ee3d-goog

