Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3715A334909
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhCJUlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhCJUlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:41:24 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F8AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:41:23 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id dz17so13587103qvb.14
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tKJVajPcRM0ynF/upsTJnXEW3amsJCTEystjBfDXy2I=;
        b=s5NBgw3ICWxWQimZDAGAWAgiHpwFRMEJ/ySHfxIL70/H3znR+G9V9YIUQ2dlQCAgVM
         ObeoE9hy4icjKHg2eAabuXbqd3cN3OUY5JAUN1uzxCCi2eDXMwECrX1pipL318JXSurw
         fBLWuxZMvTskGNNYRUTG9qDW5OZK0aYW19zy8ekKtrL3/g+uNTB8Nyj9QX6DgjzBqFWs
         CA8e6GTXhCwG57XZ1EaK3rEMupogiRRUoHXzWBosmBncN5u63B5GZEMZpuQs6SRHoYAs
         4iFSEg5oDQV9iyIysw4xLG+TatchRKzEGSHCxaICnrI6WftAjRIyJ9b4P7VaERaivpz9
         P7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tKJVajPcRM0ynF/upsTJnXEW3amsJCTEystjBfDXy2I=;
        b=VYGqfn6nlk+vZ9XzCDAOrxfTIhdOcv0cq13/M0slQ5FzKLLo7v2N1I1Of6dC2FbykY
         0pDgCXytQ+zw7wJZY1txNujWLJCizSQVCSStOOu5MDN13V7arna8gAIbZB2wnjTaNwfe
         uyZkR0H6kiPU6cvdVRjsHX/KK7swvMnVsFUs5yRXLpB+jLfIWGUbIwYkHSmzN/iKfKsW
         m4SfM4IzLzRVK/nF32XoumjtScgYAh7dQZZCgqyqmlOy58CpH6CzgzAH3jIyHVZiFRPh
         Z3G19f4eEvYPQXLOEVrfLdoLCmKYo4l0p7859SGoNS5ESHtTEF5uSaJwn/SF3VVst2kE
         zjxw==
X-Gm-Message-State: AOAM530TZlrxycy6osb4cVSn9Kz1bauONdo5/ayRxLu5R711LjkGcF1Q
        i2iJOQOvmsAThJc2OfHXrudY8eQ7gZ3j
X-Google-Smtp-Source: ABdhPJxUF0i4wtRjId4YGEaahxu2YUeXTnHnhJrSpy9pwA0ZTaNW1jAE8JIZx5rH64fRCKUfcfkO0GG/81K2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f1bc:db2b:fff2:533])
 (user=irogers job=sendgmr) by 2002:a0c:9a04:: with SMTP id
 p4mr4902929qvd.38.1615408883134; Wed, 10 Mar 2021 12:41:23 -0800 (PST)
Date:   Wed, 10 Mar 2021 12:41:16 -0800
Message-Id: <20210310204118.711514-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 1/3] perf test: Remove unused argument
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

Remove unused argument from daemon_exit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/daemon.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index 5ad3ca8d681b..66ad56b4e0a5 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -115,8 +115,7 @@ daemon_start()
 
 daemon_exit()
 {
-	local base=$1
-	local config=$2
+	local config=$1
 
 	local line=`perf daemon --config ${config} -x: | head -1`
 	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
@@ -171,7 +170,7 @@ EOF
 			 ${base}/session-time/ack "0"
 
 	# stop daemon
-	daemon_exit ${base} ${config}
+	daemon_exit ${config}
 
 	rm -rf ${base}
 	rm -f ${config}
@@ -288,7 +287,7 @@ EOF
 	done
 
 	# stop daemon
-	daemon_exit ${base} ${config}
+	daemon_exit ${config}
 
 	rm -rf ${base}
 	rm -f ${config}
@@ -333,7 +332,7 @@ EOF
 	fi
 
 	# stop daemon
-	daemon_exit ${base} ${config}
+	daemon_exit ${config}
 
 	# check that sessions are gone
 	if [ -d "/proc/${pid_size}" ]; then
@@ -374,7 +373,7 @@ EOF
 	perf daemon signal --config ${config}
 
 	# stop daemon
-	daemon_exit ${base} ${config}
+	daemon_exit ${config}
 
 	# count is 2 perf.data for signals and 1 for perf record finished
 	count=`ls ${base}/session-test/ | grep perf.data | wc -l`
@@ -420,7 +419,7 @@ EOF
 	fi
 
 	# stop daemon
-	daemon_exit ${base} ${config}
+	daemon_exit ${config}
 
 	rm -rf ${base}
 	rm -f ${config}
@@ -457,7 +456,7 @@ EOF
 	fi
 
 	# stop daemon
-	daemon_exit ${base} ${config}
+	daemon_exit ${config}
 
 	rm -rf ${base}
 	rm -f ${config}
-- 
2.30.1.766.gb4fecdf3b7-goog

