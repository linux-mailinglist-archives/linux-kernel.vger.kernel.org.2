Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A587F33D834
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhCPPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbhCPPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:51:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FCCC061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:51:14 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id q9so4277400qvm.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFfwZ4qSjv9JDq3MovzsosYjUylfCABrGnmB6REE4+Q=;
        b=jCMCuO3YXdJaLGcuSSeVnvoh0fNDoFOu/KymxE5r6UAVCyl0UeV31Dg9RIrDu7aVk9
         +ikJ1CmkaaAzJBYVTRyvHjEbc7uWD9AjOj3L+pr0Q6zCR3mxoEUWGd+IoCCX6E9pII+m
         ZyYK77+Puep0VgK2chIfjWeSMSH40yKp6UShtjMwgwxSYOx+UfKNJKVVdIuO7wucTvdT
         iduZRUvaiVPWLYRN4n9YdfdgzWCQNbc4yHrm2E0pATPIJssJGVkxvQeVY7qz/xqPTFPQ
         1gwlvrTcc4OEr1t2xeNwGRYHrDDCZVA0R+CVGDBcF+UJlxZrBmURh3y+D/bbKkYarEom
         xJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFfwZ4qSjv9JDq3MovzsosYjUylfCABrGnmB6REE4+Q=;
        b=F3tzW9iLbbTrs46Mw9otrs79E4MA5duha7IVUH7sr5uXWWScLaUWVviYLO3j7+oJDa
         DxQZikQmRpsqcWxvCU8n9S3hSAQGWTzOFxLk+47I19m40SCC5SQpj/H8HT6zpWx3Sugy
         8lGa/6LZxI6Zp+mnJCUvsHfo5U4+4traDUd5ImxP+36DLj7Hsc2RqkvANg7HzDG9wcK8
         tgcIJV8dSBFaP/8eG4KuH8jnaXdJ63ii6SD+JY10to/hWffVCNLicQwsjivLYLTe942t
         +yg+zguAvlb5/VXOYlhMii6HRe7n9Jc/RuajZABNfBz2dz2H62ymB+c7aLW7teCOcxSh
         VG0A==
X-Gm-Message-State: AOAM5322uUFMoum+lKifcjznLOtJAkJJ3CEx7LrUbaepoiiqUPV3K8nA
        W29nqqCL/mg4Y822hSfd+8o=
X-Google-Smtp-Source: ABdhPJxXXPc3BU5gMrGLLb5XbHOwhOFcrnN8D2fcdU+51WQ0guN5DBPEUhpn3gV1fM417znl8chdIA==
X-Received: by 2002:a0c:df0a:: with SMTP id g10mr2213622qvl.57.1615909873371;
        Tue, 16 Mar 2021 08:51:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1ee])
        by smtp.gmail.com with ESMTPSA id o89sm13678234qte.84.2021.03.16.08.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:51:13 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH 1/1] perf: display raw event for mem report
Date:   Tue, 16 Mar 2021 08:51:03 -0700
Message-Id: <20210316155103.568872-2-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316155103.568872-1-schatzberg.dan@gmail.com>
References: <20210316155103.568872-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`perf mem record` can be used to capture memory loads/stores using
PEBS counters. `perf mem report -D` can be used to dump the raw
samples (e.g. each sampled memory access). However, it does not output
the raw event (load vs store).

This patch supplements the output of `perf mem report -D` with the
event name.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 tools/perf/builtin-mem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index cdd2b9f643f6..1f4ec350bca3 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -172,6 +172,7 @@ static int
 dump_raw_samples(struct perf_tool *tool,
 		 union perf_event *event,
 		 struct perf_sample *sample,
+		 struct evsel *evsel,
 		 struct machine *machine)
 {
 	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
@@ -220,6 +221,11 @@ dump_raw_samples(struct perf_tool *tool,
 			symbol_conf.field_sep);
 	}
 
+	if (evsel->name)
+		printf("%s%s", evsel->name, symbol_conf.field_sep);
+	else
+		printf("%s", symbol_conf.field_sep);
+
 	if (field_sep)
 		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
 	else
@@ -240,10 +246,10 @@ dump_raw_samples(struct perf_tool *tool,
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel __maybe_unused,
+				struct evsel *evsel,
 				struct machine *machine)
 {
-	return dump_raw_samples(tool, event, sample, machine);
+	return dump_raw_samples(tool, event, sample, evsel, machine);
 }
 
 static int report_raw_events(struct perf_mem *mem)
@@ -287,7 +293,7 @@ static int report_raw_events(struct perf_mem *mem)
 	if (mem->data_page_size)
 		printf("DATA PAGE SIZE, ");
 
-	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
+	printf("EVENT, LOCAL WEIGHT, DSRC, SYMBOL\n");
 
 	ret = perf_session__process_events(session);
 
-- 
2.30.2

