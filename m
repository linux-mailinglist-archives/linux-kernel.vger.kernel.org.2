Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4748A3CF0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379744AbhGSXqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442041AbhGSWdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:33:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A456C08EC3C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 70so17374594pgh.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWMUQjdH4ZDbprSvut7wxKV127xNjHK8gJtD/7EIQLw=;
        b=K29sF5FUnkArMbK3wArjgTleAWa9+vmZDfW1jtU4BadakWze3eLBO/bEpZw1l/1xPe
         CAhiWiCwXNkX/uQYj7LFJcTIG5nGOQaGrBJhgAXJPr7r0wctAEP5HC5clHzKVGHNPO+U
         QflInfZU0mzw0cM57D2OvVdk/sqxeKzOsWQmtRPBxqctQ0M7y76oG4BDMrLSvMtlWvYH
         PDIc0FoyObpS9jhSrKy1bJgLpQLd09827mNTeubDkBm/LPy6YJg8fs2yk9ZvN8QIGFb4
         u3ArbHqxfsIdBD/p+M6t2bM3vrLA/E/CD/Wyyk5sicowGXibGVkrDtyTVTC2+fRDYdQi
         r8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JWMUQjdH4ZDbprSvut7wxKV127xNjHK8gJtD/7EIQLw=;
        b=RuN8R64OBSJLl3B3rz+piCSwWC0CHI+buniqMeHQj76B4iZKTAshJeA/KYxS0PtbIt
         dR+jJu540O9b/2MrApvVqYNdMEHfoYRr2dLxhs4kvlirmANKRbXNkkl57mnbhB4/VC+H
         EDh0/P7gnUwE7+alHHywYyizPrj4WcMm6vX+48HkBXda9hqH9kNTowVkJgOrlzQ72mB5
         2gsy32i7MX29eiTAQwU9ri3KFB3LO0nhNX+qW0b899fmbRPWVNnV4FAKVCua7l0XoBVa
         I756hp6GtepNTU5m+977bZwfF055LRwhdSPzuwxM59S03rD/+5n2TdhCfon7FF5j4/uR
         AbUg==
X-Gm-Message-State: AOAM530TfG6Ij8tiMhxlzI3iQXxZDu9kpaUdsWCLcTQFLOa7+6x4Moxp
        /w41w7++73droglRHz8Nj88=
X-Google-Smtp-Source: ABdhPJy4FHxLuKoFbSC77EG8bu2aXaokDlZ4w9tk/rBsOd9f9EgTVdm6F9m0Hnqf0lEnnKdj2JNFAQ==
X-Received: by 2002:a63:b303:: with SMTP id i3mr27658025pgf.25.1626733930162;
        Mon, 19 Jul 2021 15:32:10 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:ff4e:db29:48ff:3778])
        by smtp.gmail.com with ESMTPSA id q19sm6921569pgj.17.2021.07.19.15.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:32:09 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 5/5] perf tools: Add pipe_test.sh to verify pipe operations
Date:   Mon, 19 Jul 2021 15:31:53 -0700
Message-Id: <20210719223153.1618812-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
In-Reply-To: <20210719223153.1618812-1-namhyung@kernel.org>
References: <20210719223153.1618812-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It builds a test program and use it to verify pipe behavior with perf
record, inject and report.

  $ perf test pipe -v
  80: perf pipe recording and injection test                          :
  --- start ---
  test child forked, pid 1109301
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
     1109315  1109315       -1 |test.file.MGNff
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
      99.99%  test.file.MGNff  test.file.MGNffM  [.] noploop
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
      99.99%  test.file.MGNff  test.file.MGNffM  [.] noploop
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.153 MB /tmp/perf.data.dmsnlx (3995 samples) ]
      99.99%  test.file.MGNff  test.file.MGNffM  [.] noploop
  test child finished with 0
  ---- end ----
  perf pipe recording and injection test: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/pipe_test.sh | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 tools/perf/tests/shell/pipe_test.sh

diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
new file mode 100755
index 000000000000..1b32b4f28391
--- /dev/null
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+# perf pipe recording and injection test
+# SPDX-License-Identifier: GPL-2.0
+
+# skip if there's no compiler
+if ! [ -x "$(command -v cc)" ]; then
+	echo "failed: no compiler, install gcc"
+	exit 2
+fi
+
+file=$(mktemp /tmp/test.file.XXXXXX)
+data=$(mktemp /tmp/perf.data.XXXXXX)
+
+cat <<EOF | cc -o ${file} -x c -
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+volatile int done;
+
+void sigalrm(int sig) {
+	done = 1;
+}
+
+__attribute__((noinline)) void noploop(void) {
+	while (!done)
+		continue;
+}
+
+int main(int argc, char *argv[]) {
+	int sec = 1;
+
+	if (argc > 1)
+		sec = atoi(argv[1]);
+
+	signal(SIGALRM, sigalrm);
+	alarm(sec);
+
+	noploop();
+	return 0;
+}
+EOF
+
+
+if ! perf record -e task-clock:u -o - ${file} | perf report -i - --task | grep test.file; then
+	echo "cannot find the test file in the perf report"
+	exit 1
+fi
+
+if ! perf record -e task-clock:u -o - ${file} | perf inject -b | perf report -i - | grep noploop; then
+	echo "cannot find noploop function in pipe #1"
+	exit 1
+fi
+
+perf record -e task-clock:u -o - ${file} | perf inject -b -o ${data}
+if ! perf report -i ${data} | grep noploop; then
+	echo "cannot find noploop function in pipe #2"
+	exit 1
+fi
+
+perf record -e task-clock:u -o ${data} ${file}
+if ! perf inject -b -i ${data} | perf report -i - | grep noploop; then
+	echo "cannot find noploop function in pipe #3"
+	exit 1
+fi
+
+
+rm -f ${file} ${data} ${data}.old
+exit 0
-- 
2.32.0.402.g57bb445576-goog

