Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0036D706
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhD1MKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhD1MKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:10:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFFCC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t2-20020a17090a0242b0290155433387beso3046945pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TYUGP32ELQ91eeKz1nQb+O8oINCtciccCgqAO5/P6s=;
        b=MVzOF562sEeeqk1JTtTIk0+gLzm9XYBDmZY9ZCJI32nx8L4GenNYDPgdcJyzy5QPLA
         zXQVJUPf5Am/KucN7JVdUtGHIPPt7+WywL1JlcboTkTiB5LKTmXEIh88/yfDP2q33lWQ
         5Q/Os4M+2TCa39k/1PpVSHPZ5dthUnT2jOfL9sYgJu59dRDv9PUSo8h/NQ5K8i+FtvQl
         U241vj+sU7+RLm7wVebjVMTa2Nzqrh5hxBNKeXm7VcXjmBxv7D6ISEwPlRZlYzTErDZo
         NX/MQ6xiEE++bo6051rhIG3Zi15WXd+GO2StTMR9aXvG4phvQwG72FNKJ2t0bJtvQb5p
         IUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TYUGP32ELQ91eeKz1nQb+O8oINCtciccCgqAO5/P6s=;
        b=VyyyPcmnBXyGWe5wF0DcMGy1lHiPrXFLf6Ka7PuozlPSrnkzzb9Pv4z6bnBt2UVIK5
         0oWqdlD2nC5fX/TiiI8hMSSDuwJn8jwke+GLDV0HKrLClBms+H6V7EJKGPlSTaODVErO
         z9y6/TcZXau+2yJReG9uMO/K3VXDIX6kymmIPdX0lqWotdpSgaxduPzXIi28KF7Q/ZAz
         +p1nlqCS+/+XftQIWgfWXxOQWZzAkRBru4QmvIbx4H5sgIo3ZH/VWVPZUqCZx/0n3lAq
         zWy2BKGmd/OmDOEGhA9WXHfudRIjKVI6EhwUE38AangoptEcwRENsdioAB8rnL3gGLGd
         zP1w==
X-Gm-Message-State: AOAM533XOAEwT4EawQQjBzC0iSPHWTE9Q+i8pGcG7mFjcRypTYOGhdR7
        sBDLuS9VUwfJJJF6lS9wFAxL8A==
X-Google-Smtp-Source: ABdhPJy4+EFDgD2SoVfeXGivU3NAZAQpUopEtNmaNG379LC/GO6HEVfhfUi8VcTTZEcW06d9u5HAFw==
X-Received: by 2002:a17:90a:5b15:: with SMTP id o21mr33370459pji.193.1619611771634;
        Wed, 28 Apr 2021 05:09:31 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id s184sm2473681pgc.29.2021.04.28.05.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:09:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/4] perf jit: Let convert_timestamp() to be backwards-compatible
Date:   Wed, 28 Apr 2021 20:09:13 +0800
Message-Id: <20210428120915.7123-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428120915.7123-1-leo.yan@linaro.org>
References: <20210428120915.7123-1-leo.yan@linaro.org>
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

