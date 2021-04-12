Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8735BC43
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhDLIfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbhDLIfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:35:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:35:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w10so8818009pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FqNGER5VhYmDIEwrqf/7rjpfdrKRWu/vTm1BFqAWzmA=;
        b=iho7M1fBSpW61kxL3Lti+6Zvme0HG+CUkMZMiuC5ocHvLMB8H4664r/10F1PINWyX2
         nK8M6OulfApx1+extM7ZE4EmFtQgn234OFm25Xz3xNLXysEOZF2p173E2RnU9OLbyoGx
         YN8+WreSWyJ4nHKkwE182gKn1QGKfIpd/4Tt/LMbFqottXTH3D3wGCvU5gequsVcK4TB
         6uAYw5pFn9VOG0t4SLQ7L2cND7b8mdneLkHkmzy7LyI+3dyDvwYJlx/j5WKLMlSLX6nI
         h6EYVYGyC4YXtcgwxN6JPPJ433L9n65grst2d+pdzHzXqBNfVuR5BSg8ncnjvaq0Nprb
         WNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FqNGER5VhYmDIEwrqf/7rjpfdrKRWu/vTm1BFqAWzmA=;
        b=fisq7di5FBO8+Ewzd08ZtNwaOLVAIruU4kpuh+w+qEYNV3F4V+YA42MkR9O+K1nfwA
         LCcmtl3dxRZeaaAR9rbphl7erH3ET10XvJB3DKqvewDgdEsz9RLcS/QpjHoPG7QhQ6Ss
         ET1z7pAaOgkDRczwQatc3k2tnbxEdlLVfqYB2BgZw0lgVSChwwYJarvHNAhc1gzWjPax
         cNnlUf4nVU6l6orKs5lpc3/DDfcTXNGhrnT30/U8zE7gEgrJcs1qVZVxD9nQhg4j16QK
         tJzELyIgqHhvWF18cg1p6JWiJMo5zzaqvz44o8374MVejtjFKDQPi1vbnF6anptH7ALn
         MEsw==
X-Gm-Message-State: AOAM5319Pl++pao6FKNRtTRwLRq3HXHEZm/pne9Y1R8ji9XojW9n4awW
        tDb/gCqaut9Q55JA6TUh2tIXuQ==
X-Google-Smtp-Source: ABdhPJw5VVVEnrfHTn/g0gf9SgVJxiIiIasCj17v0Td3CymAgjxityJsBNUsnu4pAcELPCX/yVTJQg==
X-Received: by 2002:a63:4d24:: with SMTP id a36mr18895112pgb.64.1618216512846;
        Mon, 12 Apr 2021 01:35:12 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id o3sm10784813pjm.30.2021.04.12.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 01:35:12 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/3] perf jit: Let convert_timestamp() to be backwards-compatible
Date:   Mon, 12 Apr 2021 16:34:57 +0800
Message-Id: <20210412083459.462817-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412083459.462817-1-leo.yan@linaro.org>
References: <20210412083459.462817-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d110162cafc8 ("perf tsc: Support cap_user_time_short for event
TIME_CONV") supports the extended parameters for event TIME_CONV, but it
broke the backwards compatibility, so any perf data file with old event
format fails to convert timestamp.

For the backwards-compatibility, this patch checks the event size, if
the event size confirms the extended parameters are supported in the
event TIME_CONV, then copies these parameters.

Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/jitdump.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 9760d8e7b386..67b514c38a43 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -396,21 +396,32 @@ static pid_t jr_entry_tid(struct jit_buf_desc *jd, union jr_entry *jr)
 
 static uint64_t convert_timestamp(struct jit_buf_desc *jd, uint64_t timestamp)
 {
-	struct perf_tsc_conversion tc;
+	struct perf_tsc_conversion tc = { 0 };
+	struct perf_record_time_conv *time_conv = &jd->session->time_conv;
 
 	if (!jd->use_arch_timestamp)
 		return timestamp;
 
-	tc.time_shift	       = jd->session->time_conv.time_shift;
-	tc.time_mult	       = jd->session->time_conv.time_mult;
-	tc.time_zero	       = jd->session->time_conv.time_zero;
-	tc.time_cycles	       = jd->session->time_conv.time_cycles;
-	tc.time_mask	       = jd->session->time_conv.time_mask;
-	tc.cap_user_time_zero  = jd->session->time_conv.cap_user_time_zero;
-	tc.cap_user_time_short = jd->session->time_conv.cap_user_time_short;
+	tc.time_shift = time_conv->time_shift;
+	tc.time_mult  = time_conv->time_mult;
+	tc.time_zero  = time_conv->time_zero;
 
-	if (!tc.cap_user_time_zero)
-		return 0;
+	/*
+	 * The event TIME_CONV was extended for the fields from "time_cycles"
+	 * when supported cap_user_time_short, for backward compatibility,
+	 * checks the event size and assigns these extended fields if these
+	 * fields are contained in the event.
+	 */
+	if (time_conv->header.size >
+		((void *)&time_conv->time_cycles - (void *)time_conv)) {
+		tc.time_cycles	       = time_conv->time_cycles;
+		tc.time_mask	       = time_conv->time_mask;
+		tc.cap_user_time_zero  = time_conv->cap_user_time_zero;
+		tc.cap_user_time_short = time_conv->cap_user_time_short;
+
+		if (!tc.cap_user_time_zero)
+			return 0;
+	}
 
 	return tsc_to_perf_time(timestamp, &tc);
 }
-- 
2.25.1

