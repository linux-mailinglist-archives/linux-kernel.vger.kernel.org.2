Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91233E310
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 01:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCQAz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhCQAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:55:19 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E431C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:55:19 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p133so4402867qka.17
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QQhSd5q0jCv0bGK9WK8MiwR/o4DaFUkS5Nq3ARQeY/8=;
        b=Z1MCQGzkE/4N/qs+W9t1/ZMjHEafjrXaRHY15YDGy+lF0H+saR1hsbspIJ6rma1W3k
         CCRYEy1fur7xy+DYo8vV+76tGaSuLE/Ks0FiqkwHQ5Iwo7A05sI8nnZ+pzvBsrmXOyhg
         UsQzN5fSzKrjsQ/Cwd5XcT5TMuru4RyekGogQSpqerzXVGwHD1MsWIVLiEDW0DTETsfJ
         Q4DAy3TGyrgEOwP3tuo4e11SfjTGAeY0Bdnrtq1OuifJf5dyPIiB5vd438EhdZVPja17
         fD7HN5Mpdh1dQtpD+GWbuuF2N+CNuhQRj3Y01QEyJoYj6eM1Hn6Pp3SNUZHGvAhFssIc
         dfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QQhSd5q0jCv0bGK9WK8MiwR/o4DaFUkS5Nq3ARQeY/8=;
        b=smx8hblaChhn4xRln+Df/UVTvR/mjOHn3x8ElgjKLm2xHmGLkeVpB/It8yFvDpaujL
         8O4UWxZsDjPvvjQ76kGc2X6oHlUSYX9kzAjBP5KG3hz+AIwcreIPEnUcOdehzPRvDiSg
         kJ8X4O5VNa0omVYRxbu1BqOHjO8JGXRTCRV5/xozegst9QEeX/uWwHr4sbWZPLU02aLA
         5l5Y1kBs76KQmReqKqe4BPfq9CuUBfi5ViB40R6nuE7xVNx8GBZxN0aLGckkRb4g1eqB
         C+yU4TlJrwDQeliuKwgD4ImIR++WVYLLRo16hqkMSq8VcCktTOOBYaKY3jqW3FaLFjgz
         ve0A==
X-Gm-Message-State: AOAM533VoOJN/t8KK//9BqQ74vwGtx3JNOwo8eRSMwjtZIohfRM19UgR
        V53e149rVvJvd2xqNl4rlfEPi1YKDxTY
X-Google-Smtp-Source: ABdhPJzPrxZnrUDoc4VR3LivjF33TPxUrUi5gVJO3/c1Gh3PZCPW3L8uLhxjmqsT7jHjok+gx53URHIfAwua
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:dd81:7319:7b35:a87a])
 (user=irogers job=sendgmr) by 2002:ad4:510d:: with SMTP id
 g13mr2827650qvp.3.1615942518456; Tue, 16 Mar 2021 17:55:18 -0700 (PDT)
Date:   Tue, 16 Mar 2021 17:55:05 -0700
In-Reply-To: <20210317005505.2794804-1-irogers@google.com>
Message-Id: <20210317005505.2794804-3-irogers@google.com>
Mime-Version: 1.0
References: <20210317005505.2794804-1-irogers@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 3/3] perf test: Add 30s timeout for wait for daemon start.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retry the ping loop upto 600 times, or approximately 30 seconds, to make
sure the test does hang at start up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/daemon.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index 61d13c4c64b8..ee4a30ca3f57 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -127,9 +127,16 @@ daemon_start()
 
 	# wait for the session to ping
 	local state="FAIL"
+	local retries=0
 	while [ "${state}" != "OK" ]; do
 		state=`perf daemon ping --config ${config} --session ${session} | awk '{ print $1 }'`
 		sleep 0.05
+		retries=$((${retries} +1))
+		if [ ${retries} -ge 600 ]; then
+			echo "FAILED: Timeout waiting for daemon to ping"
+			daemon_exit ${config}
+			exit 1
+		fi
 	done
 }
 
-- 
2.31.0.rc2.261.g7f71774620-goog

