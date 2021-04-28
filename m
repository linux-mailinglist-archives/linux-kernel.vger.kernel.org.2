Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED336D6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhD1L7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhD1L7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:59:03 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC27C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:58:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q10so44532654pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TYUGP32ELQ91eeKz1nQb+O8oINCtciccCgqAO5/P6s=;
        b=SwO1Cki2YHfxZwsKvbvXhnIEvBmM4MIBhk3Z/7NlhTA6KlpJWwtzGmYiC7PKL2wCa2
         lX47hXVAzgGGalNSpJ+PxW0lY0ZdF0cmcNE8g8ayE7aypyyDIxPys5DC4OfUhaVwH/hW
         83JgeEFscfhGF7HYZ6rw5RhvbjPxcCTXGhfDpULA3aaNw6S04Iy9f4H01YdU/e3WsiHb
         AnMN/wGIBRDG5myXktdz/sFFKWHhP2lBeInn3BY08qWLYLigxtaBDHfOw06N/nBSTdJ7
         fW6oX9UZ2yiKi00kSNUHfo4QSyug+w6C6pcrhZZEiNK9aZTHTnRRjTmNGIbfTFYpNBH6
         ANxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TYUGP32ELQ91eeKz1nQb+O8oINCtciccCgqAO5/P6s=;
        b=KT1uBkyKYjp+I8KB9jdqA7tpaUkYdYUZjTkgOyEsEZIsBhPCqcilaupy5PPfDZjKny
         oo1Pw+SNJEzYiuLscR7mgbRPbrt1wX1N1QYCOwjANGJeqC2Hwdze/LqUsLv7kEpn0djQ
         rwyDqm+aQzeah4OQx5Ku6OH3MAV/hdWpw3qRxsqsO3jkc4HtiGFMjELPEbRGqru2msTl
         MYZ112TjmYKersGANHmQdRXWKCDXj69KW5nt0ajQV+JFhBophvz3ex9dShLNFiIeN7l2
         d9NfyPsp7LbR3oD8e+0Uj2O+QO/i5oWnIKUSP13+KlPdogdbAW+GXwzFo+3U5hNGF2Re
         SYdg==
X-Gm-Message-State: AOAM53173jrUWEcBlUMNtUlXzLBqfgo/6Mgst8RGTYxOsuPLmNq6m7M2
        qhnMWFPk1Tw0Fb7R3ZFxKSmCeQ==
X-Google-Smtp-Source: ABdhPJzX1shsl35YYHvKORX3D32BZ4PTFBgGmSg7j63pKEGbLy9CKFVFVo1PFqi5p20jRG4PFPW1qw==
X-Received: by 2002:a63:c111:: with SMTP id w17mr26090480pgf.127.1619611098543;
        Wed, 28 Apr 2021 04:58:18 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id b140sm5002800pfb.98.2021.04.28.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:58:18 -0700 (PDT)
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
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/4] perf jit: Let convert_timestamp() to be backwards-compatible
Date:   Wed, 28 Apr 2021 19:57:47 +0800
Message-Id: <20210428115749.5229-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428115749.5229-1-leo.yan@linaro.org>
References: <20210428115749.5229-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d110162cafc8 ("perf tsc: Support cap_user_time_short for event
TIME_CONV") supports the extended parameters for event TIME_CONV, but it
broke the backwards compatibility, so any perf data file with old event
format fails to convert timestamp.

This patch introduces a helper event_contains() to checks if an event
contains a specific member or not.  For the backwards-compatibility, if
the event size confirms the extended parameters are supported in the
event TIME_CONV, then copies these parameters.

Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/include/perf/event.h |  2 ++
 tools/perf/util/jitdump.c           | 30 +++++++++++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 48583e441d9b..4d0c02ba3f7d 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -8,6 +8,8 @@
 #include <linux/bpf.h>
 #include <sys/types.h> /* pid_t */
 
+#define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(obj), mem))
+
 struct perf_record_mmap {
 	struct perf_event_header header;
 	__u32			 pid, tid;
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 9760d8e7b386..5d388622b7ac 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -396,21 +396,31 @@ static pid_t jr_entry_tid(struct jit_buf_desc *jd, union jr_entry *jr)
 
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
+	if (event_contains(*time_conv, time_cycles)) {
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

