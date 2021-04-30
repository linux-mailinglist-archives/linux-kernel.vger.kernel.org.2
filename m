Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6288436FB92
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhD3Nes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:34:48 -0400
Received: from alln-iport-1.cisco.com ([173.37.142.88]:65247 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhD3Nek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3236; q=dns/txt; s=iport;
  t=1619789632; x=1620999232;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=adNIZso9q1kbiUR4eIwO4BJi1sMG6M01i1QikJyNMkA=;
  b=Jbrxr/DBoQ+bIwMDSwe7U1keL7VLxRazpy+e6loEnCk54g24Q3gMFKSs
   KAq6IMYlszpiCDln6RphCuOFs0XMjALECeQCKzP0p4cbH1RSzlHXybuiI
   SQbun50uKZyBPMYWJR6fDAR9zrkAMlHtk0BMl6TU1KV3ZQwS+cXqbMbyn
   o=;
X-IPAS-Result: =?us-ascii?q?A0AiAQCABoxgmIkNJK1aHgEBCxIMggwLgyJWATkxsTKBf?=
 =?us-ascii?q?AsBAQENAQEgFAQBAYRQAoF7AiU0CQ4CBAEBAQMCAwEBAQEBBQEBAQIBBgQUA?=
 =?us-ascii?q?QEBAQEBAQFohVANhkUGMgFWHjMsKwcSgnEBgwenKIIsgQGINIFEgTqIbXSDd?=
 =?us-ascii?q?iccgUlCgRWDYIgHgjMEgjUSgQ8Tk0+OD5w+gxqJdpMkECaFFKAKlSyfVYQHA?=
 =?us-ascii?q?gQGBQIWNYEfOIFbMxoIGxWDJAlHGQ6OKw0JgzWHCoQMIQMvAjYCBgoBAQMJj?=
 =?us-ascii?q?Q8BAQ?=
IronPort-HdrOrdr: A9a23:f7RjSqyvEkOeBJ4Pg1q/KrPwlb1zdoIgy1knxilNYDZSddGVkN
 3roe8S0gX6hC1UdHYrn92BP6foewK5ybdZ6ZQcVI3NYCDIo22tRbsO0aLDxHnaFzT65qph08
 5bAstDIfnRKXQ/ssrg+gm/FL8bsby62YSln/3XwXsobQwCUcBdxjx0AAqaDUF6LTMubfFSKL
 Om6sVKvDamc3gMB/7LZEUtZfTJpNHAifvdDiIuOhhP0mWzpALtzLb7FhSCty1/bxp/hZE/7G
 PCjwv1ooKkvv3T8G6760bjq7JLhdDm1txPQPapt/FQADDthgG0Db4RPIG/gA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,262,1613433600"; 
   d="scan'208";a="684724661"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Apr 2021 13:33:51 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 13UDXovV022060
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Apr 2021 13:33:51 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 29D4BCC1253; Fri, 30 Apr 2021 06:33:50 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v4 2/3] perf tests: avoid storing an absolute path in perf binary
Date:   Fri, 30 Apr 2021 06:33:49 -0700
Message-Id: <20210430133350.20504-2-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210430133350.20504-1-dzagorui@cisco.com>
References: <20210430133350.20504-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-4.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

python binding test uses PYTHONPATH definition to find python/perf.so
library. This definition is an absolute path that makes perf binary
unreproducible. This path can be found during runtime execution.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/perf/tests/Build        |  2 +-
 tools/perf/tests/python-use.c | 19 ++++++++++++++++++-
 tools/perf/util/util.c        | 21 +++++++++++++++++++++
 tools/perf/util/util.h        |  2 ++
 4 files changed, 42 insertions(+), 2 deletions(-)

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
index 98c6d474aa6f..c7a0c9b5366f 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -8,18 +8,35 @@
 #include <linux/compiler.h>
 #include "tests.h"
 #include "util/debug.h"
+#include "util/util.h"
+#include <sys/stat.h>
 
 int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char *cmd;
 	int ret;
+	char *exec_path;
+	char *pythonpath;
+	struct stat sb;
+
+	exec_path = perf_exe_path();
+	if (exec_path == NULL)
+		return -1;
+
+	if (asprintf(&pythonpath, "%spython", exec_path) < 0)
+		return -1;
+
+	if (stat(pythonpath, &sb) || !S_ISDIR(sb.st_mode))
+		pythonpath[0] = 0;
 
 	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
-		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
+		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
 		return -1;
 
 	pr_debug("python usage test: \"%s\"\n", cmd);
 	ret = system(cmd) ? -1 : 0;
 	free(cmd);
+	free(exec_path);
+	free(pythonpath);
 	return ret;
 }
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 3bba74e431ed..54e80452887c 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -388,3 +388,24 @@ char *perf_exe(char *buf, int len)
 	}
 	return strcpy(buf, "perf");
 }
+
+char *perf_exe_path(void)
+{
+	int i;
+	char *buf;
+
+	buf = malloc(PATH_MAX);
+	buf = perf_exe(buf, PATH_MAX);
+
+	for (i = strlen(buf) - 1; i != 0 && buf[i] != '/'; i--)
+		;
+
+	if (!i) {
+		free(buf);
+		return NULL;
+	}
+
+	buf[i + 1] = 0;
+
+	return buf;
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 80b194ee6c7d..4e871e890ef8 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -49,6 +49,8 @@ void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
 char *perf_exe(char *buf, int len);
+/* perf_exe_path return malloc'd string on success, caller must free it */
+char *perf_exe_path(void);
 
 #ifndef O_CLOEXEC
 #ifdef __sparc__
-- 
2.26.2.Cisco

