Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0088233490B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhCJUlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhCJUlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:41:25 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F2AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:41:25 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id m8so11804679qtp.14
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qRkxSnGo8p+8YE9t0u58+XLT5fPoV2yHdc+VOwdi69k=;
        b=s/jdTAyAVHaRPYRqgCJsab3nMQAy29gaI73WvMeoo7Q2TKbbzK553dP83ty6n2VKWN
         LoRyOPsqE+fjboRbShrNA9pHrvSBjgVYaiPUuqvubd2izdU9MjdCZQ7iIUMfNZUBOYx3
         s1BuBWPrkRw7j6NM5xYcJ7/HMAkQPIPwaeVK1BTiq099XgSfky73Mom7YcYvn4ZuRoHh
         XO8pLLWR+LCMZnDeVyEyFBABSOCV9wVRXuqnJjk87k/Cnh1HowvG7adg68LF072shFgh
         6Xif5wo35EEj6iMnk4yePEDFXbCUoJqqSlmmXUFBSnkcGt2j8hFlxq+9Dur8idFFprM9
         Afog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qRkxSnGo8p+8YE9t0u58+XLT5fPoV2yHdc+VOwdi69k=;
        b=lgcRktxXratVAjPUqbUCNg1uOt9B2YEuCRQv2+42qbS+eQWDQcUWXHNm+vRhcXABH+
         Lfo7j7iIe1OmmvMtNeWlkkB3rZzYnxr7JUtQbHGUxAwScjwgXC26uLijOaTWy5kTnkTY
         a5EFIdlbf1cSetZDcxHkgHiEjIVYsZfUyrnt5i0/Odgkgh0KgTRUoLVmtJAppTZVpSl+
         iX/yO8p+GomGSejUw0PThbV5Z2x8UgDG1yf0HsQ01tx0abYRvJGNDMmdJDKMbPadQDel
         59i4Cp3PAj1hhzUpzDyjd2oIRaouUqsalFKadGzcCtFdtVrdGlwWE2F9I1uFqXDSWL5P
         6seA==
X-Gm-Message-State: AOAM5311iDdVYnvfZp6eDVCySBwM9bLZ/sTD5zo1o15DjP69NIST5dy4
        KVglIwjdTuJLJbbpbNJhHS4GRyLt/CQ3
X-Google-Smtp-Source: ABdhPJy5h14ucuYxeFr4sr50OjRPEPEP5SA/TSUkUgEulqVYNJyFx8CyAz0A3IV160sYylIRxgR/37eWMB85
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f1bc:db2b:fff2:533])
 (user=irogers job=sendgmr) by 2002:a05:6214:1146:: with SMTP id
 b6mr4612979qvt.62.1615408884955; Wed, 10 Mar 2021 12:41:24 -0800 (PST)
Date:   Wed, 10 Mar 2021 12:41:17 -0800
In-Reply-To: <20210310204118.711514-1-irogers@google.com>
Message-Id: <20210310204118.711514-2-irogers@google.com>
Mime-Version: 1.0
References: <20210310204118.711514-1-irogers@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 2/3] perf test: Cleanup daemon if test is interrupted.
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
index 66ad56b4e0a5..a02cedc76de6 100755
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
+        # Reset trap handler.
+        trap - SIGINT SIGTERM
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
 
+        # Clean up daemon if interrupted.
+        trap "daemon_exit ${config}; exit 4" SIGINT SIGTERM
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
2.30.1.766.gb4fecdf3b7-goog

