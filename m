Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C49456394
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhKRTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhKRTkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:40:19 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F5EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 11:37:19 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id f16-20020a170902ce9000b001436ba39b2bso3466970plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 11:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R5/tL/rDWxPQEUOLlylgnRCNYpZbnkH43K1OGrjgMBQ=;
        b=GZ+2yw4W+dbPb+KsAI3xbbsFG+EC/IJLhoTZ9CrO3c2d/3fTlQUXBnW/UtQizCe2wx
         t2X5jMJmBKZQdpfFJYegwJgx1RNYOdJLhRST4amEdbnhnRizOf00Nc8Bmq5vYoCL3CPM
         44Mi8MJyH37svWN8Bvgz0cPrwtlF84wOQWE6XZlChqib1G8MMAaA14XHCdlIyR8bIV54
         YaWNTZHlzhgHfmxHXLaN4Hzhs07BwApsG8hT49MK7ExrcJwOC9cAsd2CWrfRPmOwdaUZ
         jEngiJB5T79RhA4VFbO8r2NKDcXQGC/RGXV1Aeo5ELkf+zlSmWmIx9s0hddoAGUraNqL
         eclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R5/tL/rDWxPQEUOLlylgnRCNYpZbnkH43K1OGrjgMBQ=;
        b=RXQjs3Cl8VL3bFgaAyKbfK4mdGmRZVD+LW3hYurXDUSW00oWSa2NiE9yTQxbKogdJ2
         vUBVprpYg1cAxFf/2M9c7u+v2C3u/y6EPCrUGrXLIx4czpYcUnZ2hD9RfKBvsNJ+L27s
         KQgTqmZpGR+xnoWYAxYdjdv+WDj1lRaAyhUpdxoLtcrOLwocHSyoEjVcjtlHHW7CtJOc
         QbZCRYAp4f6axihHNHMz9Oul0kdbno8QH/CnZ29M6/o5DNPJuAergkFOkk1tVRi8bAWK
         4DmNkxcX+E3W3uKHJyIhlYwEYQFnC8XxU6NMGuYAff5otNBrWuRwef8qY07DnP9i7Y3i
         Gxfw==
X-Gm-Message-State: AOAM5320gSN0E0YC3Dsy0meG23vPkZLnbsPOuYzKTBLz/PCen1MYKE+G
        NmbesdtLPh86KJ4xPpggRu3+6lMdPn4p
X-Google-Smtp-Source: ABdhPJxyTIPodpBQC30q2dnJ0SXUgdh0ksxpTRbcPgsXkxz7LfVbGKOyJWndsDShbNsNUWNH9Vi3UC+Zbmxu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3908:af20:80e3:e47])
 (user=irogers job=sendgmr) by 2002:a05:6a00:84c:b0:494:6d40:ed76 with SMTP id
 q12-20020a056a00084c00b004946d40ed76mr58534568pfk.65.1637264238666; Thu, 18
 Nov 2021 11:37:18 -0800 (PST)
Date:   Thu, 18 Nov 2021 11:37:14 -0800
Message-Id: <20211118193714.2293728-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] perf map: Fix namespace memory leak
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This leak was happening reliably with test "Lookup mmap thread" with
stack traces like:

Direct leak of 5504 byte(s) in 172 object(s) allocated from:
    #0 0x7f4685e47987 in __interceptor_calloc
    #1 0x56063b974c2a in nsinfo__new util/namespaces.c:142
    #2 0x56063b9781ff in thread__new util/thread.c:70
    #3 0x56063b944953 in ____machine__findnew_thread util/machine.c:543
    #4 0x56063b944ac6 in __machine__findnew_thread util/machine.c:574
    #5 0x56063b944b36 in machine__findnew_thread util/machine.c:584
    #6 0x56063b94c892 in machine__process_fork_event util/machine.c:1954
    #7 0x56063b94cc1f in machine__process_event util/machine.c:2019
    #8 0x56063b894f18 in perf_event__process util/event.c:567
    #9 0x56063ba17951 in perf_tool__process_synth_event util/synthetic-events.c:65
    #10 0x56063ba19086 in perf_event__synthesize_fork util/synthetic-events.c:287
    #11 0x56063ba1c39d in __event__synthesize_thread util/synthetic-events.c:775
    #12 0x56063ba1cf6f in __perf_event__synthesize_threads util/synthetic-events.c:929
    #13 0x56063ba1d4ab in perf_event__synthesize_threads util/synthetic-events.c:1000
    #14 0x56063b821a3d in synth_all tests/mmap-thread-lookup.c:136
    #15 0x56063b821c86 in mmap_events tests/mmap-thread-lookup.c:174
    #16 0x56063b8221b7 in test__mmap_thread_lookup tests/mmap-thread-lookup.c:230

The dso->nsinfo is overwritten, but without a nsinfo__put this can leak
the overwritten nsinfo.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 8af693d9678c..ceed8f407bc0 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -192,6 +192,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso);
 		}
+		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
 
 		if (build_id__is_defined(bid))
-- 
2.34.0.rc2.393.gf8c9666880-goog

