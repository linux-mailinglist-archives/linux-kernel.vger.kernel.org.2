Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D03730F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhEDToa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhEDTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:44:29 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88500C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:43:34 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d16-20020ac811900000b02901bbebf64663so4306742qtj.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1FnFnn4wDfYMWQqvn7hSz/1lOfOioIUbh4DjTNFjqJE=;
        b=kViYkO9TIKTlBg5tDqdI5ZVgGE5/StSOxh6VL+ktWyy3Y44ItEQ/XQPFu1fYX/vLKH
         FD4xtMj7hqXqwe3GNljcENVZqEaTXqypAWpLpyCtp4Cvch/jaghp35q6yFOQo0k0suJH
         GdYS1RoMMpiKs+RX7MBQmzJ3Ll1MRTBcCWQ6LsMF728Y99b8EPLY90ZRJq9ieQBR91gn
         /LLXVTKWdUNsp2bnaZdcuQei86vZWBjSvru1g3GEb0D/Sa8GlMCF5VIr62BZna9lL1ri
         E0nwPQ+RpVZT6TDaBg5o4bzPtpvatqs7ytFUhu1nQWrUt4ndC6UE6n7yARK3JTludK2U
         wPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1FnFnn4wDfYMWQqvn7hSz/1lOfOioIUbh4DjTNFjqJE=;
        b=GSzIGoLeVdIGGzzHxOV9XIvL4M0hh8nhmaaX/ZDYNg9/QG+hooyfqqkWyRiditMs2A
         y9XFMeIFuqotnAfkDyUCC/dzhmWTWIkfLsCHz/fSDggjkdPs9dd1r8BvMY8liAROrK32
         mnWpVtBPMdc+Jq2enSQ7nl+Yy6ByeUdXbKaZTuKjux9wHJi43GiJupUXVkIJXljQWunU
         kNngZq3eYnSOEfAnlsZd6+7pyFmWB1aqC6p1Y0zsEBVxpwppHEOglkO9ordljBgaXphg
         aoR8fM8nbvKtg4X9wMKFwLOHr73ei+o7lIOGub3v68fQJSKtPfWpdHptCkrSsmmWUXww
         L0Gg==
X-Gm-Message-State: AOAM532R65K7q6huT8ZWnBZQjj8fz7oQXbULo88gxYssRKKa+CTYid4v
        UGSIBPh72MuUPDMgWPqfaX2xoggoKO+M
X-Google-Smtp-Source: ABdhPJwKkimx4a054iRJK7kgTW2d9OhbvG1mRn/VpC5JH8W6IuJGqvaRm6pn2JhRmSgNeny+QlyTpcs0mhY5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6f05:c90a:7892:8680])
 (user=irogers job=sendgmr) by 2002:a0c:b38b:: with SMTP id
 t11mr27290262qve.25.1620157413615; Tue, 04 May 2021 12:43:33 -0700 (PDT)
Date:   Tue,  4 May 2021 12:43:29 -0700
Message-Id: <20210504194329.840964-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] libperf test: Silence printf flag warning
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__u64 maybe an unsigned long, it may also differ from the format
expected by PRIu64. Add a cast to silence the warning:

tools/lib/perf/tests/test-evsel.c:176:33: error: format specifies type 'unsigned long long' but the argument has type 'unsigned long' [-Werror,-Wformat]
                __T_VERBOSE("count = %llu\n", end - start);
                                     ~~~~     ^~~~~~~~~~~
                                     %lu

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 288b5feaefe2..558097bbbfd0 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -173,7 +173,7 @@ static int test_stat_user_read(int event)
 
 		__T("invalid counter data", (end - start) > last);
 		last = end - start;
-		__T_VERBOSE("count = %llu\n", end - start);
+		__T_VERBOSE("count = %llu\n", (unsigned long long)(end - start));
 	}
 
 	perf_evsel__munmap(evsel);
-- 
2.31.1.607.g51e8a6a459-goog

