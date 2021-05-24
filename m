Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B2B38E537
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhEXLQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:16:57 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:63994 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhEXLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2222; q=dns/txt; s=iport;
  t=1621854915; x=1623064515;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/x1hGeCwMtshLjZHcErVJlS+wMeuvBwQYyQcghRtbKM=;
  b=jhKtpCl6EX7Utat6W9BxYtzkLYjHt7vQ+qKxuznKmDpW1I59Hnh4mw5D
   8bjjPY0D6GFCvI4imJW1lvLOq4wPmvROWMxQPv8zhqoohVr+6/fQoJsxS
   TpJcvyNaGKw2XBts7Ay0yWy7zxmRs5qUWY2hioMTg1T9MSlRDLNEJEpF3
   Y=;
X-IPAS-Result: =?us-ascii?q?A0CTBAC/iatg/49dJa1agmCCK3dWATkxsWiBfAsBAQENA?=
 =?us-ascii?q?QEtFAQBAYRQAoF+AiU0CQ4CBAEBAQEDAgMBAQEBBQEBBQEBAQIBBgRxE4VoD?=
 =?us-ascii?q?YZFBjIBVh4zLCsHEoJxAYMHp16CLIEBiDOBRIE6iHZ2g3gnHIFJRIR1ij0Eg?=
 =?us-ascii?q?keBDxOTYY4inFWDIYoKkz4UKYUdoC+VPaAMhA0CBAYFAhaBVDuBWTMaCBsVg?=
 =?us-ascii?q?yQJRxkOkXaHCoQNIQMvAjYCBgoBAQMJiW4BAQ?=
IronPort-Data: A9a23:Ky5By60QFhZQ5wRTwvbD5ctwkn2cJEfYwER7XKvMYLTBsI5bp2EOz
 GFLWG+Pbv6JNGWhKY12Oou3/BlXv5KGx9RmHQFs3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huEtr6nYd1eEzvuXGuCJQUJUiOfYHNIQNMaeYnooHVI+FH944f5es7dRbrBA0IDR7zyl4
 bsek+WHULNy82cpWo68w/vrRCJH5JweihtB1rANTawjUGvlqpUgJMl3yZddgJfPatI88uaSH
 44vxVwil4/T109F5tiNyt4XfqCWK1LfFVDmt5ZYZ0StqjlbngcT36kmDt5GS2tOpBnWufwy4
 vwY4PRcSS9xVkHNsP4WXx8dGCZkMOgZvrTGOnO498eUyiUqcVO1nK4oVx5wbNZeo7osaY1N3
 aRwxDQlYgKKiOWs3bOTQeh3jcNlJ87uVG8aki44kG+JUqh4GPgvRY3B6452zS8gtvlQGPfSW
 9Q5dGdVNC3PNkgn1lA/TchWcP2Trn3+dSBI7VGYv6w650DNwwFrlrvgKtzYfpqNX8o9tkOZo
 G3B1370DhETKJqUzj/t2nCrgvTGtTn2VIIbCPuz8fsCqFSXy3waDhEbTx2gofiiik2/XfpbK
 koJ6mwvq7Q/8AqgSdyVdxuxpX6VoxgTc9ldCes37EeK0KW8yw+SA2UsTTNbbtEi8sgsSlQCz
 lKVksn7LT1pvqecRX+U+vGTtzzaES0cN2xEfzIYSQID7/HquoR1hRXKJuuPC4avhdHzXDr32
 T3P8241hq4YiogA0KDTEU37vg9Ab6PhFmYdjjg7lEr8hu+lTOZJv7CV1GU=
IronPort-HdrOrdr: A9a23:+h4qV6w1OAQp7yjBkwkUKrPwLb1zdoMgy1knxilNoHtuA6ilfq
 +V8sjzuSWYtN9VYgBCpTniAtjkfZqjz/9ICOAqVN/INjUO+lHYTr2KhrGM/9SPIUHDH5ZmtZ
 uJt8NFebvN5Z8Qt7ec3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,319,1613433600"; 
   d="scan'208";a="705687661"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 24 May 2021 11:15:14 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 14OBFEkr017265
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 May 2021 11:15:14 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 31ABFCC1253; Mon, 24 May 2021 04:15:14 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v8 2/3] perf tests: avoid storing an absolute path in perf binary
Date:   Mon, 24 May 2021 04:15:13 -0700
Message-Id: <20210524111514.65713-2-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210524111514.65713-1-dzagorui@cisco.com>
References: <20210524111514.65713-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: rcdn-core-7.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

python binding test uses PYTHONPATH definition to find python/perf.so
library. This definition is an absolute path that makes perf binary
unreproducible. This path can be found during runtime execution.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/perf/tests/Build        |  2 +-
 tools/perf/tests/python-use.c | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 650aec19d490..a20098dcdbc4 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -98,5 +98,5 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif
 
 CFLAGS_attr.o         += -DBINDIR="BUILD_STR($(bindir_SQ))" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
-CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
+CFLAGS_python-use.o   += -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 98c6d474aa6f..32af71300aa3 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -8,18 +8,37 @@
 #include <linux/compiler.h>
 #include "tests.h"
 #include "util/debug.h"
+#include "util/util.h"
+#include <sys/stat.h>
+#include <limits.h>
+#include <libgen.h>
 
 int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char *cmd;
-	int ret;
+	int ret = -1;
+	char *exec_path;
+	char buf[PATH_MAX];
+	char *pythonpath;
+	struct stat sb;
+
+	perf_exe(buf, PATH_MAX);
+	exec_path = dirname(buf);
+
+	if (asprintf(&pythonpath, "%s/python", exec_path) < 0)
+		return ret;
+
+	if (stat(pythonpath, &sb) || !S_ISDIR(sb.st_mode))
+		pythonpath[0] = 0;
 
 	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
-		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
-		return -1;
+		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
+		goto out;
 
 	pr_debug("python usage test: \"%s\"\n", cmd);
 	ret = system(cmd) ? -1 : 0;
 	free(cmd);
+out:
+	free(pythonpath);
 	return ret;
 }
-- 
2.26.2.Cisco

