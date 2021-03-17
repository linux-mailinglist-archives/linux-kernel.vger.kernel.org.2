Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E848C33E30F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 01:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCQAz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQAzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:55:17 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:55:17 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id da16so26600739qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sEoOOfzl8seVEQxt7AKb/MB7g4+cwCvdVL+g/G4yCaI=;
        b=O1ePT2YK+FfWGO1llf1NXHAFoDzaZoFYL1Ioxj3DP2XqGsit36lSXWxtK+fzF7iprB
         k+b2aFvi0yZoNp8liIzPHJ1ZR6I49vLQrMXjl0I8YdcOTvUafAlJLCllupM5LAwAzS7+
         u6Yc3SAiUsqbVFJNT9RT4xZGyQ3a+l65j7Q3jFfFRMmpQ92L9vkI7mHhgruwr/unZvVf
         S4YKsp9zjQSjYmK9Cefir+l1kci3lIIMwQHkviBEs4nAgb5iUnMxOmAJQg8a7aNirAa8
         PYveWTpSgI66xh58cgTSPSy3l8CmWhhMEs0h8zvqU+oMVedTxlJjF2CTBJ6krw+sO972
         L1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sEoOOfzl8seVEQxt7AKb/MB7g4+cwCvdVL+g/G4yCaI=;
        b=scnvoCnHSZ+A/XCnf5KI4uOYYioqmoGKGMPhMFz1tOrGH+uTHdTe3TzyF098wj0ux4
         EKPUED7mbyx57SAqw2wKvllIQCZisHx38wadl41KKx+eou9mibYoQQ/aM9dj7mS5cxvX
         aiHSRNWt/B8CKt3zHxqnoZBAXRh4De705nAzivopV/1QJ09QgkwQ6jWEZSebVA3Ru/GI
         igrbJ3s1y7PG8gZ4H1PQ5OKTBxHYVPqyfj4vKPIfmQ3ztEd2eO+QZL+JxAZtaJvX5N2z
         7F5kcxrRI3DHSwSsp6aXfTtbchWj1A2NGUrR5ptNXvA9Vl4s067hLzI9enMiqPQliBCZ
         keuw==
X-Gm-Message-State: AOAM532SkPUlWetF8ovbnxhuLqTAOZimLpoS8j1R6cU/CqCTcvaZYOKt
        7KGwZqEDN/a/2yn73io9TtlCjQcuPh2l
X-Google-Smtp-Source: ABdhPJwXb6EtPFEN5njHDlY6/phMEUdaEMQVqp5dfCh/cDeww+5c5qi6gp76B14eaoGON7/ucon24AlpFCes
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:dd81:7319:7b35:a87a])
 (user=irogers job=sendgmr) by 2002:a0c:aa45:: with SMTP id
 e5mr2412051qvb.44.1615942516532; Tue, 16 Mar 2021 17:55:16 -0700 (PDT)
Date:   Tue, 16 Mar 2021 17:55:04 -0700
In-Reply-To: <20210317005505.2794804-1-irogers@google.com>
Message-Id: <20210317005505.2794804-2-irogers@google.com>
Mime-Version: 1.0
References: <20210317005505.2794804-1-irogers@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 2/3] perf test: Cleanup daemon if test is interrupted.
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

Reorder daemon_start and daemon_exit as the trap handler is added in
daemon_start referencing daemon_exit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/daemon.sh | 34 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index 66ad56b4e0a5..61d13c4c64b8 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -98,6 +98,23 @@ check_line_other()
 	fi
 }
 
+daemon_exit()
+{
+	local config=$1
+
+	local line=`perf daemon --config ${config} -x: | head -1`
+	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
+
+	# Reset trap handler.
+	trap - SIGINT SIGTERM
+
+	# stop daemon
+	perf daemon stop --config ${config}
+
+	# ... and wait for the pid to go away
+	tail --pid=${pid} -f /dev/null
+}
+
 daemon_start()
 {
 	local config=$1
@@ -105,6 +122,9 @@ daemon_start()
 
 	perf daemon start --config ${config}
 
+	# Clean up daemon if interrupted.
+	trap "echo 'FAILED: Signal caught'; daemon_exit ${config}; exit 1" SIGINT SIGTERM
+
 	# wait for the session to ping
 	local state="FAIL"
 	while [ "${state}" != "OK" ]; do
@@ -113,20 +133,6 @@ daemon_start()
 	done
 }
 
-daemon_exit()
-{
-	local config=$1
-
-	local line=`perf daemon --config ${config} -x: | head -1`
-	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
-
-	# stop daemon
-	perf daemon stop --config ${config}
-
-	# ... and wait for the pid to go away
-	tail --pid=${pid} -f /dev/null
-}
-
 test_list()
 {
 	echo "test daemon list"
-- 
2.31.0.rc2.261.g7f71774620-goog

