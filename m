Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A4B382759
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhEQIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:47:35 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:32866 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhEQIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3303; q=dns/txt; s=iport;
  t=1621241173; x=1622450773;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KbFZDWkGt8kzcR9X06TbPX2AtPcqhdc0Fhkd6PkZBx4=;
  b=AABWUoR6DR4ts9W9TW1XUvSpgovlIXSOwLD+QqYwWYnoechK51bLuPQA
   WRxEVvyH2roTBdDMUoorbsq1qtUD7u78v9A+wdnyDyformyxnOfBHanl+
   os0D55oQ4W+cDhfZNu7MHgAqmMDAVY0UOtNLguwdJFC20STFGlnEjifvl
   M=;
X-IPAS-Result: =?us-ascii?q?A0AiAQDsLKJgmIsNJK1aHgEBCxIMggwLgyJWATkxsVaBf?=
 =?us-ascii?q?AsBAQENAQEtFAQBAYRPAoF0AiU0CQ4CBAEBAQEDAgMBAQEBBQEBBQEBAQIBB?=
 =?us-ascii?q?gQUAQEBAQEBAQFohVANhkUGMgFWHjMsKwcSgnEBgweoMIIsgQGIE4FEgTqId?=
 =?us-ascii?q?naDdyccgUlEgRWDYIo9BIJHgQ8Tk1uOHJxLgyCKApMyESiFG6AilTafdoQMA?=
 =?us-ascii?q?gQGBQIWgVQ4gVszGggbFYMkCUcZDo4rDQmDNYcKhAwhAy8CNgIGCgEBAwmNE?=
 =?us-ascii?q?AEB?=
IronPort-HdrOrdr: A9a23:HHRpt6r/qp1N6zpmoKv8ZHUaV5oqeYIsimQD101hICG9Ffbo8/
 xG88506faZslsssTQb6LO90cq7MBbhHOBOgLX5VI3KNGKNhILrFvAB0WKI+VLd8kPFmtK1rZ
 0BT0C7Y+eAa2STSq3BkW6FL+o=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,306,1613433600"; 
   d="scan'208";a="695982374"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 17 May 2021 08:46:11 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 14H8k5oW028517
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 May 2021 08:46:07 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id EADFDCC1254; Mon, 17 May 2021 01:46:04 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v5 2/3] perf tests: avoid storing an absolute path in perf binary
Date:   Mon, 17 May 2021 01:46:03 -0700
Message-Id: <20210517084604.2895-2-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210517084604.2895-1-dzagorui@cisco.com>
References: <20210517084604.2895-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

python binding test uses PYTHONPATH definition to find python/perf.so
library. This definition is an absolute path that makes perf binary
unreproducible. This path can be found during runtime execution.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/perf/tests/Build        |  2 +-
 tools/perf/tests/python-use.c | 23 +++++++++++++++++++++--
 tools/perf/util/util.c        | 18 ++++++++++++++++++
 tools/perf/util/util.h        |  1 +
 4 files changed, 41 insertions(+), 3 deletions(-)

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
index 98c6d474aa6f..37c3c774180e 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -8,18 +8,37 @@
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
+	if (asprintf(&pythonpath, "%s/python", exec_path) < 0)
+		return -1;
+
+	if (stat(pythonpath, &sb) || !S_ISDIR(sb.st_mode))
+		pythonpath[0] = 0;
 
 	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
-		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
-		return -1;
+		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0) {
+		ret = -1;
+		goto out;
+	}
 
 	pr_debug("python usage test: \"%s\"\n", cmd);
 	ret = system(cmd) ? -1 : 0;
 	free(cmd);
+out:
+	free(pythonpath);
 	return ret;
 }
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 3bba74e431ed..79ec528827a2 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -22,6 +22,7 @@
 #include "cap.h"
 #include "strlist.h"
 #include "string2.h"
+#include <libgen.h>
 
 /*
  * XXX We need to find a better place for these things...
@@ -388,3 +389,20 @@ char *perf_exe(char *buf, int len)
 	}
 	return strcpy(buf, "perf");
 }
+
+char *perf_exe_path(void)
+{
+	char *buf;
+	char *dname;
+
+	buf = malloc(PATH_MAX);
+	if (buf == NULL)
+		return NULL;
+
+	buf = perf_exe(buf, PATH_MAX);
+
+	dname = dirname(buf);
+
+	free(buf);
+	return dname;
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 80b194ee6c7d..4b506df4e8b9 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -49,6 +49,7 @@ void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
 char *perf_exe(char *buf, int len);
+char *perf_exe_path(void);
 
 #ifndef O_CLOEXEC
 #ifdef __sparc__
-- 
2.26.2.Cisco

