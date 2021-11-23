Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA104599EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhKWCG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhKWCGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:06:54 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC844C061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:03:47 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c6-20020aa781c6000000b004a4fcdf1d6dso1052524pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9bHMOu3pVxAcj8i0iDu0iZsIvZlw+K8b/2K5VjmoKFQ=;
        b=cjrU4RfOO6IuOwzjgfYXWDz2sOUOVtUSAQsoqlcxE5JfVmnHtlNHRaS6C3WayROvB9
         YYLHS8X9KLdLcSwUj8ffwf5hKSZWaS90yjgu4R77h5uQzejrq3ddWNltsJy2BKBOPHl8
         mZCBxuIfglNOkPFL7Jt69qOFCWuuo54pOBBnhAtAFsEunxEaskab0VIWkMcggVi4bdAg
         dg3m4gdu9nMVxUdL1UFsGwK5ugPf9vImP8/jkSFmGUfPLVByw8vdmm7j6WPqciIoujoL
         x7W4qTSJmRiN8ziHM22GIn89Gu4SMthscEKvfMmZ02U2kRZlqjOMfVbo2xdTqAQQGBgm
         WPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9bHMOu3pVxAcj8i0iDu0iZsIvZlw+K8b/2K5VjmoKFQ=;
        b=ZorQATFZuY2Aolq5kBy+16mKBS6ZSup/87iIA6ckeT0re83hCDQXvXkeDN36J5gzfz
         CmPjIgviCbZtFgWoNam6qoXQy/x+cBpocC6zo3cNCOgX788aBhtCj7ZVvNq9/Zz4CgIz
         G2Y1ryoDVesI2b+GhanMVC7zNL3wYF4cz954a6buo1pMymwtYb2maKTNpCShjN+hN6Vh
         u6JIBFiw7KJ3aWdEeBAVq+1zK5H0d970rHrkhXt4xsxKohc34LiXvs7vfZjyATCTJwCQ
         BxV0dHwsYnPCuHA2OkQKgonnEmxv5ADZ9yPrk/wCBvNNiMbbRR+l/P/gJi8ENjdhVrO8
         qNVg==
X-Gm-Message-State: AOAM531zpehj5tEibJ3hGOH1CYRsdSWlm5XdJQWEnb0cI0xWkDLnXTcS
        rS1h0sEYSiuIMsgXdrAyMcpZXoJth96S
X-Google-Smtp-Source: ABdhPJycTRwXN9gmdLqW3irXaVYc+LF5thv+7Y2LWvSPRZm9GM3VG3I1NnlgwOqK9hhsZKFIErErJqO5aiNc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8e01:f22:909b:4ff])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1883:b0:49f:a8be:af29 with SMTP
 id x3-20020a056a00188300b0049fa8beaf29mr1404124pfh.22.1637633027210; Mon, 22
 Nov 2021 18:03:47 -0800 (PST)
Date:   Mon, 22 Nov 2021 18:03:41 -0800
In-Reply-To: <20211123020341.3073673-1-irogers@google.com>
Message-Id: <20211123020341.3073673-2-irogers@google.com>
Mime-Version: 1.0
References: <20211123020341.3073673-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 2/2] perf evsel: Improve error message for uncore events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a group has multiple events and the leader fails it can yield
errors like:

$ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc/cas_count_read/).
/bin/dmesg | grep -i perf may provide additional information.

However, when not the group leader <not supported> is given:

$ perf stat -e '{instructions,uncore_imc/cas_count_read/}' /bin/true
...
         1,619,057      instructions
   <not supported> MiB  uncore_imc/cas_count_read/

This is necessary because get_group_fd will fail if the leader fails and
is the direct result of the check on line 750 of builtin-stat.c in
stat_handle_error that returns COUNTER_SKIP for the latter case.

This patch improves the error message to:

$ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
Error:
Invalid event (uncore_imc/cas_count_read/) in per-thread mode, enable system wide with '-a'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a59fb2ecb84e..48696ff4bddb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2950,6 +2950,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
+		if ((evsel__leader(evsel) == evsel) &&
+		    (evsel->core.leader->nr_members > 1))
+			return scnprintf(msg, size,
+	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
+					evsel__name(evsel));
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.34.0.rc2.393.gf8c9666880-goog

