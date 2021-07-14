Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDA63C7AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 02:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhGNAhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 20:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbhGNAho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 20:37:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59655C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a127so320671pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tnaDYMoO+BP6cypoHeUCeFUeCHxOAKViaMWCxrs75Ps=;
        b=j6LuNkQfX6ngxEfhFpJVMrlTeRnTn5zWsxF5kb8W4oxiQfq1Sq7Y/fqv8b33Ik2E0N
         2cEVc0aE6hTtx/y56cwkmLR1HPxDrhP3qZOuh5q0V4XExf0pAPtJ5mQeqFmd8Lk2mfdT
         lEBsSSy4lL5oiqyjrWY/hvr861jzJut+UhhaQYcRpPB9F4spTytM1hw8O4gFBYoDeMvI
         P+/6IKL7EP6C9qA74zpxLwcn33csZqKZbdvS8XvFQ0N1we5vHdi31p2EX0r3fhokqjde
         wTW4fWKhTbmm1WXsFd+WRyXkqAfOa+kMww8GlJ/zU7eR0fXnMcxAcd3yDA+WJqvDjnWu
         4o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tnaDYMoO+BP6cypoHeUCeFUeCHxOAKViaMWCxrs75Ps=;
        b=M/hFZ8B1VOYsknU1mUnQhu9dmXKusLPj1nw4GWIlXLI609TLtB9vfCset/SXT1drEF
         VF1IJ8YNbQGq0sEl6iI4VYhh5j/GIVwAkP3h/y76AkZrR9giYgadQH/kW4BambXLr6zT
         2jvEFjJ0JcLdUuJcvKTfIJqdicnjRN6nRWd35LKnFYlK4VFOxkyI8CH7G3j0P5ogSDSv
         RcQFDsr8yzFfPTQRFOn0pBl3Uumd0FgjsN6SqQ1p//RIUkq/gWV3D/gS+F+mlp348xdq
         Drz2LLq2F9oRt8YjpqtiZxgUudcyPpoGM9RZl24I9nm5eqA+lBCpheJeYkr58Sr8GhAt
         gItg==
X-Gm-Message-State: AOAM530CXLRUDZJiDPqXp1ugdTQANb3v8myHRcR0VZjJSUyyD4he9OK/
        WwSEd15K+vVEFH8IMWHxWrA=
X-Google-Smtp-Source: ABdhPJx9DaQyb/OhZXXtWru74lQ/qxGejbXZBtILwl0FyKTSJdMT58miYPlLeJ1S9ldU74w75dBZYA==
X-Received: by 2002:a63:f202:: with SMTP id v2mr6755344pgh.30.1626222891933;
        Tue, 13 Jul 2021 17:34:51 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:9b12:1fd4:6232:5315])
        by smtp.gmail.com with ESMTPSA id x6sm285896pgq.67.2021.07.13.17.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:34:51 -0700 (PDT)
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
Date:   Tue, 13 Jul 2021 17:34:42 -0700
Message-Id: <20210714003442.1111502-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210714003442.1111502-1-namhyung@kernel.org>
References: <20210714003442.1111502-1-namhyung@kernel.org>
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
index 000000000000..b6a89c6896c3
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
+if ! perf record -e cycles:u -o - ${file} | perf report -i - --task | grep test.file; then
+	echo "cannot find the test file in the perf report"
+	exit 1
+fi
+
+if ! perf record -e cycles:u -o - ${file} | perf inject -b | perf report -i - | grep noploop; then
+	echo "cannot find noploop function in pipe #1"
+	exit 1
+fi
+
+perf record -e cycles:u -o - ${file} | perf inject -b -o ${data}
+if ! perf report -i ${data} | grep noploop; then
+	echo "cannot find noploop function in pipe #2"
+	exit 1
+fi
+
+perf record -e cycles:u -o ${data} ${file}
+if ! perf inject -b -i ${data} | perf report -i - | grep noploop; then
+	echo "cannot find noploop function in pipe #3"
+	exit 1
+fi
+
+
+rm -f ${file} ${data} ${data}.old
+exit 0
-- 
2.32.0.93.g670b81a890-goog

