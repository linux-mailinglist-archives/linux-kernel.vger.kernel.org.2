Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC79F40CEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhIOVP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhIOVP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:15:57 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C648CC061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:14:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o22-20020ac872d60000b029029817302575so9933881qtp.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=k/ci0x8Pob6HrJahPR/bxUPeBFawoqrCO14kks/Ud10=;
        b=bXn4abxHwa9qsWASljO8uildDNkGyRGViMNwGmCUfo4LpAut/q0yhENfjylj/aPthp
         Rbtg1Cijyunpu9V/WVFbWdeESv6BHYwk9JCiE17qqmaIjExPPhIpw8iR4Yy5W8T+1O5s
         pAQuzyYJhvsh5UXUh42IRK2fmYNNJbQyd0BBlIbwfD3Ace/NRm59W8TpRXaec1OSk8Bi
         dMzqtjRLKJMerskYkecd/ng4T13rEvkopFF3bMUTdtEm9KFnxsU8n+v+x3w0g7XPsr8K
         l83+Qicst5jwvh7FvqVGCFIW74FN9M/0cuy88tXREWXug9qtAspouaBvyGxpNeBw7b+w
         qTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=k/ci0x8Pob6HrJahPR/bxUPeBFawoqrCO14kks/Ud10=;
        b=lHczyLSVENp2WK6H/zFG2pLtr66+1PZzIhOwYBhY6Wu1k3wQMwfhyRYR2Kb6hLTFBW
         NEaDuKa6CNO4ATKKMnmoyjmARaIrs0Nv1IodCYxKEX07voLB8CQhcz53vY2vACZ/uWCz
         9MZrs0gQX2RAiO5SAwj4FtRTBDiBWohfoecE5L65vbdxjkidO16gdRuUVG0F+0JWS/bH
         mTr8e6U/eQZKSh8J8osi2VClApnwrAWw4qiNOO6nPmBALj7BuDv9Hpt1w8tADg1Z4Nyy
         AwMl+/PSXKNEe7ftzK3RGJEwylQiguNOWapyHTAOZMAluZ7fJyVAPZTsAeL/APDSHh6h
         j5Jw==
X-Gm-Message-State: AOAM532+6evDzwmJvbaMjmOcerkEiZy0MMoM+h0++SntQXFXpkK+31Xr
        U4WSaRWhXfL3GxRFtzA6iYyQS4J4UJ5M
X-Google-Smtp-Source: ABdhPJze96Gku2BQ+17hp0+ZDvvc3Q21O0RePgKvPHGBY3bEGcU+SMN/8Z//ptjGYkgfPuEV3oHxwJxPI7KB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7b71:ab93:de5f:617b])
 (user=irogers job=sendgmr) by 2002:a0c:fb4f:: with SMTP id
 b15mr2058639qvq.44.1631740476965; Wed, 15 Sep 2021 14:14:36 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:14:28 -0700
Message-Id: <20210915211428.1773567-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] perf parse-events: Avoid enum forward declaration.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enum forward declarations aren't allowed as the size can't be implied.
Switch to just using an int. This fixes a clang warning:

In file included from tools/perf/bench/evlist-open-close.c:13:
tools/perf/bench/../util/parse-events.h:185:6: error: redeclaration of already-defined enum 'perf_tool_event' is a GNU extension [-Werror,-Wgnu-redeclared-enum]
enum perf_tool_event;
     ^
tools/perf/bench/../util/evsel.h:28:6: note: previous definition is here
enum perf_tool_event {
     ^

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 +-
 tools/perf/util/parse-events.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 51a2219df601..5d1346aa0627 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1471,7 +1471,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
-			  enum perf_tool_event tool_event)
+			  int tool_event)
 {
 	return add_event_tool(list, &parse_state->idx, tool_event);
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index bf6e41aa9b6a..b32ed3064c49 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -182,10 +182,9 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
 			     struct list_head *head_config);
-enum perf_tool_event;
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
-			  enum perf_tool_event tool_event);
+			  int tool_event);
 int parse_events_add_cache(struct list_head *list, int *idx,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *error,
-- 
2.33.0.309.g3052b89438-goog

