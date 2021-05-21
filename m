Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E394238CC19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhEUR3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:29:19 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:38076 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhEUR3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3248; q=dns/txt; s=iport;
  t=1621618075; x=1622827675;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JvTqOTjUDtT8xKRvqRDFpCWK+apz7Wz1lqutJWoWXT0=;
  b=m+KouVuWrAFJ/Mc3o+GxaNAeEaIx0NTyVbS2+l2yl6wEpMg+7fJUGcQ9
   DVo+TF2oy/+I4TOQ8nZ3GAi9Wm7OQbNZLmHVKRbzzy44ktPvfD0DERoeF
   83Y7OHNQuXwgXHZ1LZzTt6BXw3QJNG3CvvVEypMemwPd+YsL9UHqTBwXx
   g=;
X-IPAS-Result: =?us-ascii?q?A0AiAQD87Kdgl4oNJK1agmCDIlYBOTGxY4F8CwEBAQ0BA?=
 =?us-ascii?q?S0UBAEBhE8CgX4CJTQJDgIEAQEBAQMCAwEBAQEFAQEFAQEBAgEGBBQBAQEBA?=
 =?us-ascii?q?QEBAWiFaA2GRQYyAVYeMywrBxKCcQGDB6legiyBAYg/gUSBOoh2doN4JxyBS?=
 =?us-ascii?q?USEdYo9BIJHgQ8Tk1+OIJxVgyGKCpM9EymFHaAulTqgC4QNAgQGBQIWgVQ5g?=
 =?us-ascii?q?VszGggbFYMkCUcZDo4rDQmDNYcKhAwhAy8CNgIGCgEBAwmJZAEB?=
IronPort-Data: A9a23:HIEeJKPbMrzccQPvrR11l8FynXyQoLVcMsEvi/4bfWQNrUoj0zBRm
 2IaXmHSbqmOMGP0fd1wPo/joEpSupHUm4BjGXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmh1qpwPkcFhcwnD/1WlTahSQ6hfvgqobUUraeY3gsH1Y8EU/NtDo68wIHqt8w6TSGK1vlV
 ePa+6Uz73f8hlaYmkpNg06ygEsHUMba4Vv0jXRiDRx/h2IyolFOZH4pyQ5dGFOjKmVcNrbSq
 +8uV9hV9EuBl/smIovNfroW7iTmT5aKVTVihEa6VICmpCQTiwgjg51qE90aUGBTtjKzgttun
 YAlWZyYEW/FP4XFnOAbFhJfCSw7YOtN+aTMJj60tsn7I0/uKiS3ha4wShhte9RDqo6bAkkWn
 RAcADwfZx+Enf+36Lm6UeJrwM8kKaEHOatA4y85lGuIVa1OrZbrHrjG9PlJ7TUL3+dnPOqDW
 MsUWwd+RUGVC/FIEg5HVM1h9AuyvVH7cjtFuBeWqLAx7mz70gN8yv7uPcDTd9jMQt9a9m6dp
 2TJ+EzjDx0aPcDZwj2AmlqugevUlAvhVY4SHaH+/flv6HWawmEDARsaWEH9uvm4kU69WtR3L
 00S5zporK4u+UjtRd74NzW+qXuErwMaVPJTHvc85QXLzbDbiy6QDW0JZj1MctorsIkxXzNC/
 keEg97zFxRutrOPQH6Q/7vSqim9UQAQJHUBIzUZUQ8M5dXLqZs2yBnIS75e/LWdh9nxH3T7x
 CqH6XV4jLQIhslN3KK+lbzav96yjpzvcl8YwhSGZTOCyQVAQ4qYYLa14keOuJ6sM72lokm9U
 GkswpbEtb1eU8nSyURhU81WR+n4vabt3Cn0xA8xQcV8q1xB7lb+JehtDCdCyFCF2yruURbtZ
 ELV0e+6zMAOZCPwBUObjn7YNijH5aHkEdKgXffOY58TCnSQSONl1Hw1DaJz9zmw+KTJrU3ZE
 cvDGSpLJS1HYZmLNBLsG48gPUYDn0jSP18/oKwXKTz5j9Jyg1bLEN843KemNYjVEYvd+lyOq
 oYDXyd040sBD4USnRU7AaZKfQxVchDX9Ljdqtdccaa4MxF6FWQ6Y8I9MptwJtM/wfU9qws8x
 VngCh4w4Aeu3hXvdFTVAk2PnZuyBP6TW1pgZndyVbtpslB+CbuSAFA3J8pvIeZ/rLQ9pRO2J
 tFcE/i97j10Ymyv01wggVPV9eSOqDzDadqyAheY
IronPort-HdrOrdr: A9a23:6JmmyK6QPIZttu9PigPXwMnXdLJyesId70hD6qkXc20wTiX2ra
 6TdZgguCMczQxhO03I+urwXZVoP0m8yXcd2+B4Vt2ftUvdyQmVxepZgrcKrQeNJ8SHzI5gPW
 MKSdkZNDU2ZmIK6vrH3A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,319,1613433600"; 
   d="scan'208";a="716112903"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 21 May 2021 17:27:54 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 14LHRsCN023275
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 May 2021 17:27:54 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 06425CC1253; Fri, 21 May 2021 10:27:54 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v6 2/3] perf tests: avoid storing an absolute path in perf binary
Date:   Fri, 21 May 2021 10:27:52 -0700
Message-Id: <20210521172753.55399-2-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210521172753.55399-1-dzagorui@cisco.com>
References: <20210521172753.55399-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-5.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

python binding test uses PYTHONPATH definition to find python/perf.so
library. This definition is an absolute path that makes perf binary
unreproducible. This path can be found during runtime execution.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/perf/tests/Build        |  2 +-
 tools/perf/tests/python-use.c | 21 +++++++++++++++++++--
 tools/perf/util/util.c        | 12 ++++++++++++
 tools/perf/util/util.h        |  1 +
 4 files changed, 33 insertions(+), 3 deletions(-)

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
index 98c6d474aa6f..4a6ff7db2bf1 100644
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
 
-	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
-		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
+	exec_path = perf_exe_path();
+
+	if (asprintf(&pythonpath, "%s/python", exec_path) < 0)
 		return -1;
 
+	if (stat(pythonpath, &sb) || !S_ISDIR(sb.st_mode))
+		pythonpath[0] = 0;
+
+	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
+		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0) {
+		ret = -1;
+		goto out;
+	}
+
 	pr_debug("python usage test: \"%s\"\n", cmd);
 	ret = system(cmd) ? -1 : 0;
 	free(cmd);
+out:
+	free(pythonpath);
 	return ret;
 }
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 3bba74e431ed..53f3dbf02f58 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -22,6 +22,7 @@
 #include "cap.h"
 #include "strlist.h"
 #include "string2.h"
+#include <libgen.h>
 
 /*
  * XXX We need to find a better place for these things...
@@ -388,3 +389,14 @@ char *perf_exe(char *buf, int len)
 	}
 	return strcpy(buf, "perf");
 }
+
+char *perf_exe_path(void)
+{
+	char buf[PATH_MAX];
+	char *dname;
+
+	perf_exe(buf, PATH_MAX);
+	dname = dirname(buf);
+
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

