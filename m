Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B9C40D0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhIPATN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhIPATK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:19:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:17:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 5so2692970plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hvxbROddFiGxemHQk/+w2AlHAFOeCsIO60McMDpLD4=;
        b=C5ilt55y4ASNlvyL/LjXz72JqJIJkq1XuAQ3yyTOyH9yggN93fhqOU7xtYImNrkpLB
         fXBga8iX9ZRW+RaeKakS119TZlXcPPWzBkv9FN1FEFpyEOZMtsSUmM3fFNFMnAqB21pz
         +IdjDpsjJMCpMIym6IH2rw+RujYLzUb0GfcsZFbi1lhHkHpZqzideUxht1HIvBHx3AmH
         ksWMv2z9U5x00qrt23yzOGjjn128ksAfJaT2BrfnMLMu1TXHg8jNmQAoINSM/HqoXSKk
         0cUH8UQHzXTMgXyioIHKvOVa3gQEGTbkhRY3ZsJqOjmbNxOzC/XM7reU26Y3xCRGVZEw
         caRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/hvxbROddFiGxemHQk/+w2AlHAFOeCsIO60McMDpLD4=;
        b=Y/jqR0XwHTusmhdhiIVuE9on9qur0k0BJ7sMA+oSqcMqJ8vvu2tf2YK0jsKu4EuyOs
         1ek7UjFJ+1nLh8iUkdQv6HMvH0ffHnEciixMsXvRLMRbld3ecJrsoYV1daYpi8netf8t
         zWF3choBa0+ASObA4TBeQZyrHawkmJc0TmKLIKZqhRFj00padkjJ5mPfE0A29bl9QEzX
         uPBt2UKONScb8crYl1cCPhBNCDXO0i7CB4vpPAYHz/q53AvL9hJJE7TJCd6LAafUfeDa
         A7TNxJ1kxDly5whZ2bioc6lxDp+rYqPB0nO2orQAnwMqjNzxsp0Ow/VQ5tT33x6WPjfX
         FBGA==
X-Gm-Message-State: AOAM531ZpdhoYqBUKSuIc9lMTfSD9mw8g0R+zItM2lns6dlxeCGW1Bl4
        oJQi15X9nnlnXE1jSf/xnS0=
X-Google-Smtp-Source: ABdhPJzz0WZddWbOVQoCFHjeUa+TD6FE+2sYGX6ppdSwzaorufDlHJ5GW6p7SfcOjk7gV+sUjf2PuQ==
X-Received: by 2002:a17:90b:3ec5:: with SMTP id rm5mr6275222pjb.225.1631751471098;
        Wed, 15 Sep 2021 17:17:51 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:8150:82a5:eb2c:c97d:8de7])
        by smtp.gmail.com with ESMTPSA id y4sm639227pjw.57.2021.09.15.17.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 17:17:50 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC] perf arm-spe: Track task context switch for cpu-mode events
Date:   Wed, 15 Sep 2021 17:17:48 -0700
Message-Id: <20210916001748.1525291-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf report synthesize events from ARM SPE data, it refers to
current cpu, pid and tid in the machine.  But there's no place to set
them in the ARM SPE decoder.  I'm seeing all pid/tid is set to -1 and
user symbols are not resolved in the output.

  # perf record -a -e arm_spe_0/ts_enable=1/ sleep 1

  # perf report -q | head
     8.77%     8.77%  :-1      [kernel.kallsyms]  [k] format_decode
     7.02%     7.02%  :-1      [kernel.kallsyms]  [k] seq_printf
     7.02%     7.02%  :-1      [unknown]          [.] 0x0000ffff9f687c34
     5.26%     5.26%  :-1      [kernel.kallsyms]  [k] vsnprintf
     3.51%     3.51%  :-1      [kernel.kallsyms]  [k] string
     3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f66ae20
     3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f670b3c
     3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f67c040
     1.75%     1.75%  :-1      [kernel.kallsyms]  [k] ___cache_free
     1.75%     1.75%  :-1      [kernel.kallsyms]  [k] __count_memcg_events

Like Intel PT, add context switch records to track task info.  As ARM
SPE support was added later than PERF_RECORD_SWITCH_CPU_WIDE, I think
we can safely set the attr.context_switch bit and use it.

Cc: Leo Yan <leo.yan@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/arm64/util/arm-spe.c |  6 +++++-
 tools/perf/util/arm-spe.c            | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index a4420d4df503..58ba8d15c573 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -166,8 +166,12 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	tracking_evsel->core.attr.sample_period = 1;
 
 	/* In per-cpu case, always need the time of mmap events etc */
-	if (!perf_cpu_map__empty(cpus))
+	if (!perf_cpu_map__empty(cpus)) {
 		evsel__set_sample_bit(tracking_evsel, TIME);
+		evsel__set_sample_bit(tracking_evsel, CPU);
+		/* also track task context switch */
+		tracking_evsel->core.attr.context_switch = 1;
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 58b7069c5a5f..0acac0431c48 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -681,6 +681,25 @@ static int arm_spe_process_timeless_queues(struct arm_spe *spe, pid_t tid,
 	return 0;
 }
 
+static int arm_spe_context_switch(struct arm_spe *spe, union perf_event *event,
+				  struct perf_sample *sample)
+{
+	pid_t pid, tid;
+	int cpu;
+
+	if (!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT))
+		return 0;
+
+	pid = event->context_switch.next_prev_pid;
+	tid = event->context_switch.next_prev_tid;
+	cpu = sample->cpu;
+
+	if (tid == -1)
+		pr_warn("context_switch event has no tid\n");
+
+	return machine__set_current_tid(spe->machine, cpu, pid, tid);
+}
+
 static int arm_spe_process_event(struct perf_session *session,
 				 union perf_event *event,
 				 struct perf_sample *sample,
@@ -718,6 +737,11 @@ static int arm_spe_process_event(struct perf_session *session,
 		}
 	} else if (timestamp) {
 		err = arm_spe_process_queues(spe, timestamp);
+		if (err)
+			return err;
+
+		if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+			err = arm_spe_context_switch(spe, event, sample);
 	}
 
 	return err;
-- 
2.33.0.464.g1972c5931b-goog

