Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292DF33E30D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 01:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhCQAz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhCQAzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:55:15 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A56C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:55:15 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u15so26620454qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O5PEMlLSAq+LyueDqmW5RVFaLVdutgyuRVQI8RWpsnc=;
        b=Y1613x+Idy9bMPk9Mh7JCS/alQULth98ehMHbc9I0vKp6iC5Y+RLCKoUCm+o2ZAo0B
         P0N0eCV8RaP2ium94ppT6PG2fyWIe3GY7D49vbGLNl7WIPmVy1UPXz/fxi9EmHGwS1DO
         naCQt03VFdypeCD3IEqlIwlhh9b2cgET3BghxXhv+H8FcJ99178CvZkrJaVoRytJ8lPp
         S7MNN2J8KrGe+2OwRHdXiAfx5XwmE6vSfF9bZNT1xXCsVhMbuXYFRFrOnPIZnnDPp6b5
         cLD07fGldEz1Nro2KNMACx4fxBj1o6sCaGYyIW9JAg8yOFT05mJfDdKik1NHICeOM/jH
         jo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O5PEMlLSAq+LyueDqmW5RVFaLVdutgyuRVQI8RWpsnc=;
        b=iXL+8ysMd+px+2sBZm0r5ThTlWueLwX+oU7cU9eLCkGB9Mhze147/OCoB1MUaTovbi
         yWw8k19YLIerFhG+M4cz3g1aw/tsNWRwtm1XcFdsbjMs8asI8sDutMLgHpps9GrbOgoI
         a+v6vWZish/q2xkz9Z0F3L4i4Q7Q32yze65Ha7oJTgTtMOh1mmVQwHWMCVpbaTQEKr5y
         ijgXPVJRSXI5dBm6rfmOkzKsIgBW3Quth4ef63RWVF7966HQEcZrrTw0tinoAt9yjOSD
         of68jszwSACC/0vvMdji7NYHIE5RS/I6KW9ROcWrryCbTqEwDpEPc/UBk3bYkjgon/1d
         DKTg==
X-Gm-Message-State: AOAM532ID887fo/YB+E75M+z/qvA0G1JvXzQadqpxYo5UC+zb/kkQ0xa
        qn1BKnnRRsC4TQhARXky7Fxw0ykx13ob
X-Google-Smtp-Source: ABdhPJxHX08qs+diyAkDNiNXBbcNtcHlB8G4rXCquu821qDZAsTH2l21y4E8CxePA72t/ka/LlSiuFN0ebmp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:dd81:7319:7b35:a87a])
 (user=irogers job=sendgmr) by 2002:a0c:ff48:: with SMTP id
 y8mr2912353qvt.8.1615942514678; Tue, 16 Mar 2021 17:55:14 -0700 (PDT)
Date:   Tue, 16 Mar 2021 17:55:03 -0700
Message-Id: <20210317005505.2794804-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 1/3] perf test: Remove unused argument
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
2.31.0.rc2.261.g7f71774620-goog

