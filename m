Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96701327E39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhCAMYY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Mar 2021 07:24:24 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:26053 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232363AbhCAMYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:24:17 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-WOGKyZHtPzWtnZOLOtgx3A-1; Mon, 01 Mar 2021 07:23:22 -0500
X-MC-Unique: WOGKyZHtPzWtnZOLOtgx3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D1EC801965;
        Mon,  1 Mar 2021 12:23:20 +0000 (UTC)
Received: from krava.cust.in.nbox.cz (unknown [10.40.192.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDEB05C1C4;
        Mon,  1 Mar 2021 12:23:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf tools: Fix event's pmu name parsing
Date:   Mon,  1 Mar 2021 13:23:15 +0100
Message-Id: <20210301122315.63471-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jin Yao reported parser error for software event:

  # perf stat -e software/r1a/ -a -- sleep 1
  event syntax error: 'software/r1a/'
                       \___ parser error

This happens after commit 8c3b1ba0e7ea, where new
software-gt-awake-time event's non-pmu-event-style
makes event parser conflict with software pmu.

If we allow PE_PMU_EVENT_PRE to be parsed as pmu name,
we fix the conflict and the following character '/' for
pmu or '-' for non-pmu-event-style event allows parser
to decide what even is specified.

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Fixes: 8c3b1ba0e7ea ("drm/i915/gt: Track the overall awake/busy time") # 1
Reported-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.y | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d5b6aff82f21..d57ac86ce7ca 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -89,6 +89,7 @@ static void inc_group_count(struct list_head *list,
 %type <str> PE_EVENT_NAME
 %type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %type <str> PE_DRV_CFG_TERM
+%type <str> event_pmu_name
 %destructor { free ($$); } <str>
 %type <term> event_term
 %destructor { parse_events_term__delete ($$); } <term>
@@ -272,8 +273,11 @@ event_def: event_pmu |
 	   event_legacy_raw sep_dc |
 	   event_bpf_file
 
+event_pmu_name:
+PE_NAME | PE_PMU_EVENT_PRE
+
 event_pmu:
-PE_NAME opt_pmu_config
+event_pmu_name opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct parse_events_error *error = parse_state->error;
-- 
2.29.2

