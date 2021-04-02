Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17B33528F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhDBJk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhDBJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:40:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596C5C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 02:40:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j25so3297452pfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fIxu7trDvgJvuqb6WaKRWqsJ3HfbdrqCZyAb+sqDzg=;
        b=f+YJIBLh70Qxov5NfIOm9HsWIIdpcPWJ5XlyXLPcJKz4FChYfGbG1ECYWmQlaGQHh6
         Y+ukQFN6oSPuic9XFl5eweS03o2CxLA8CbzBHpBCffaNElYd9sm4aoI97E6MwqsAo5E0
         f3MoMgx1s6FI5tvf9rUP7chC67a85KQ3WFhK/jyPReOkYpBE4cO2wmsRsoVUC0FZYs8o
         jS7m9VV4lTXgDi5ZMSgzZVvJb/7iG2yRi/O+wh+aT6hbnbuGr29Le0S0pbUHMv7bWp6G
         efYh7OeBY1elVUVtxX+xbc/q0xveTPP/7iZR5tyo4g7npBqaXeC23L/Bvt67hNaDERv+
         5OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0fIxu7trDvgJvuqb6WaKRWqsJ3HfbdrqCZyAb+sqDzg=;
        b=LlUZlv9ojb5LYgiN9v+lJvrB2HTGssmhtQsWEsrn7haJweeXmTVEUR8sOaIU++QN0m
         JLMkUETFwMYdwTcQl2vYJjjhRoO7hlvghfyr1cLkErzzOtxFTPlJMuoevwUvL40OMXn1
         gZlZFSqgDwXWBmHcBm5qCAf6yl+zTks2bzG4NcSZltSb+Y0qcmQOIGJrt1+KWQ3BLRdc
         BiR/KKunoaRk1xElzFTVIsjIHHdtUaNcdSl0ISkymqjeqgcl+Ubw/GpzA6LNxA5yapNX
         kPF6V+grAkuvQuzvW+kS+nJKpTmUfHkd3vZ2mafXhgNik0E8fI8qOXnnPQ3Rp0epDP9Z
         Ki1A==
X-Gm-Message-State: AOAM530HfUcgr4SLjS/6rYSpuWoeY1ErfSJw79Nki73oq2kLwhd/v9WI
        9zyTm+7GfCe+11Hh5BsF5q4=
X-Google-Smtp-Source: ABdhPJwrhsOSPuktljThsBXjc/FdO+apxIu4pGAhtTvhzVgN1mfK41pae0vlGbYrQYb+lext/zZXYg==
X-Received: by 2002:a63:510f:: with SMTP id f15mr11232388pgb.390.1617356425911;
        Fri, 02 Apr 2021 02:40:25 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id d19sm7315827pjs.55.2021.04.02.02.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:40:25 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Subject: [PATCH] perf record: Disallow -c and -F option at the same time
Date:   Fri,  2 Apr 2021 18:40:20 +0900
Message-Id: <20210402094020.28164-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's confusing which one is effective when the both options are given.
The current code happens to use -c in this case but users might not be
aware of it.  We can change it to complain about that instead of
relying on the implicit priority.

Before:
  $ perf record -c 111111 -F 99 true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.031 MB perf.data (8 samples) ]

  $ perf evlist -F
  cycles: sample_period=111111

After:
  $ perf record -c 111111 -F 99 true
  cannot set frequency and period at the same time

So this change can break existing usages, but I think it's rare to
have both options and it'd be better changing them.

Suggested-by: Alexey Alexandrov <aalexand@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/record.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index f99852d54b14..43e5b563dee8 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -157,9 +157,15 @@ static int get_max_rate(unsigned int *rate)
 static int record_opts__config_freq(struct record_opts *opts)
 {
 	bool user_freq = opts->user_freq != UINT_MAX;
+	bool user_interval = opts->user_interval != ULLONG_MAX;
 	unsigned int max_rate;
 
-	if (opts->user_interval != ULLONG_MAX)
+	if (user_interval && user_freq) {
+		pr_err("cannot set frequency and period at the same time\n");
+		return -1;
+	}
+
+	if (user_interval)
 		opts->default_interval = opts->user_interval;
 	if (user_freq)
 		opts->freq = opts->user_freq;
-- 
2.31.0.208.g409f899ff0-goog

