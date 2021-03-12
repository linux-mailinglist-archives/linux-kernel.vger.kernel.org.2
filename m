Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B59A339133
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhCLPY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:24:26 -0500
Received: from alln-iport-6.cisco.com ([173.37.142.93]:6151 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhCLPYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:24:09 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2021 10:24:08 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8652; q=dns/txt; s=iport;
  t=1615562648; x=1616772248;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rUO2gsNILpW2J16h6+sCzM16e3TcNCuSfmG3wHNXbMM=;
  b=NN6ubrqvgxWPCFOr4YjNW9DIZOogDnUFHnVOdZZP7cwIj2qCRtzYFwug
   /1TAMBUR/Acmp1n8kcxLMuhjjX7Mfv9Tcj7a62wnrO9PunUnGkcJ5LEYH
   b311EHBgDpyQ7bL1l1pYlrqajkpwI6ncieQwJ075hIhsKliW26zgGxOLL
   c=;
X-IPAS-Result: =?us-ascii?q?A0ClAgC+hEtgkIwNJK1ahXlWATkxlgWcWAsBAQENAQEgF?=
 =?us-ascii?q?AQBAYZDAiU4EwIDAQEBAwIDAQEBAQUBAQECAQYEFAEBAQEBAYY4DYZyCwGBU?=
 =?us-ascii?q?zISgnABgwesBoF1M4kQgUWBOYhddINyJhyBSkKBEYNZijYEgjULB3sTARMQW?=
 =?us-ascii?q?FCBGZBVqViDC4lJkl8PIoM9gTiJI5V3AZRynleDdwIEBgUCFoFrIYFZMxoIG?=
 =?us-ascii?q?xWDJAlHGQ2OKw0Jij6DaEEDLzgCBgoBAQMJlAABAQ?=
IronPort-HdrOrdr: A9a23:dVSeX67dekvLWZf46APXwFDXdLJzesId70hD6mlaTxtJfsuE0/
 20lPMA2hPuzBoXUncsmdePUZPwI0/02JZp7eAqU4uKcxLhvAKTQb1KyavH73neFzbl9uhbvJ
 0QEJRWLNHrF1B1gYLb7WCDcuoI+9WM/KC2ieq29R4EJmtXQpt95AR0ABvzKCJLbTRBbKBUKL
 Osou5Opz+tYh0sDviTNz0iQ/XJocHNmdbAZxMLbiRXjDWmvHeP9KPwFQSe01Mldw53hZ0m8W
 TDjmXCl8Cej80=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.81,243,1610409600"; 
   d="scan'208";a="701246419"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 12 Mar 2021 15:17:01 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 12CFH0S8006026
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Mar 2021 15:17:01 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id AFD5BCC1251; Fri, 12 Mar 2021 07:17:00 -0800 (PST)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: build reproducibility improvements
Date:   Fri, 12 Mar 2021 15:17:00 +0000
Message-Id: <20210312151700.79714-1-dzagorui@cisco.com>
X-Mailer: git-send-email 2.23.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch helps to make perf build more reproducible

It seems there is some need to have an ability to invoke
perf from build directory without installation
(84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
DOCDIR contains an absolute path to kernel source directory.
In such case this path can be determined in runtime by using
/proc/self/exe link. In case of building perf with O=
Documentation/tips.txt can be copied to output directory.

There is also python binding test where PYTHONPATH is used to store
absolute path to python/perf.so library. This path can be
also determined in runtime.

bison stores full paths in generated files. This can be
remapped by using --file-prefix-map option that is available
starting from version 3.6.3.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/lib/subcmd/exec-cmd.c   | 21 +++++++++++++++++++++
 tools/lib/subcmd/exec-cmd.h   |  1 +
 tools/perf/Build              |  1 -
 tools/perf/Makefile.perf      |  3 +++
 tools/perf/builtin-report.c   | 21 ++++++++++++++++++---
 tools/perf/tests/Build        |  2 +-
 tools/perf/tests/python-use.c | 14 +++++++++++++-
 tools/perf/util/Build         | 10 +++++++---
 8 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/tools/lib/subcmd/exec-cmd.c b/tools/lib/subcmd/exec-cmd.c
index 33e94fb83986..9c293a810159 100644
--- a/tools/lib/subcmd/exec-cmd.c
+++ b/tools/lib/subcmd/exec-cmd.c
@@ -208,3 +208,24 @@ int execl_cmd(const char *cmd,...)
 	argv[argc] = NULL;
 	return execv_cmd(argv);
 }
+
+/* The caller is responsible to free the returned buffer */
+char *get_exec_abs_path(void)
+{
+	int ret;
+	int i;
+	char *buf;
+
+	buf = malloc(PATH_MAX);
+	ret = readlink("/proc/self/exe", buf, PATH_MAX - 1);
+	if (ret <= 0) {
+		free(buf);
+		return NULL;
+	}
+
+	for (i = ret - 1; buf[i] != '/'; i--)
+		; /* just counting */
+	buf[i + 1] = 0;
+
+	return buf;
+}
diff --git a/tools/lib/subcmd/exec-cmd.h b/tools/lib/subcmd/exec-cmd.h
index aba591b8d254..9dc98248dadf 100644
--- a/tools/lib/subcmd/exec-cmd.h
+++ b/tools/lib/subcmd/exec-cmd.h
@@ -13,5 +13,6 @@ extern int execl_cmd(const char *cmd, ...);
 /* get_argv_exec_path and system_path return malloc'd string, caller must free it */
 extern char *get_argv_exec_path(void);
 extern char *system_path(const char *path);
+extern char *get_exec_abs_path(void);
 
 #endif /* __SUBCMD_EXEC_CMD_H */
diff --git a/tools/perf/Build b/tools/perf/Build
index db61dbe2b543..56d0189f1029 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -45,7 +45,6 @@ CFLAGS_perf.o              += -DPERF_HTML_PATH="BUILD_STR($(htmldir_SQ))"	\
 			      -DPREFIX="BUILD_STR($(prefix_SQ))"
 CFLAGS_builtin-trace.o	   += -DSTRACE_GROUPS_DIR="BUILD_STR($(STRACE_GROUPS_DIR_SQ))"
 CFLAGS_builtin-report.o	   += -DTIPDIR="BUILD_STR($(tipdir_SQ))"
-CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
 
 perf-y += util/
 perf-y += arch/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f6e609673de2..2bebff69b064 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -627,6 +627,9 @@ $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_D
 	  --quiet build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
 
+_dummy := $(shell [ -d '$(OUTPUT)Documentation' ] || mkdir -p '$(OUTPUT)Documentation' && \
+		cp '$(srcdir)/Documentation/tips.txt' '$(OUTPUT)Documentation/')
+
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	$(Q)$$(:)
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2a845d6cac09..d9441055357e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -610,12 +610,27 @@ static int report__browse_hists(struct report *rep)
 	struct perf_session *session = rep->session;
 	struct evlist *evlist = session->evlist;
 	const char *help = perf_tip(system_path(TIPDIR));
+	char *exec_path;
+	char *docdir;
 
 	if (help == NULL) {
 		/* fallback for people who don't install perf ;-) */
-		help = perf_tip(DOCDIR);
-		if (help == NULL)
-			help = "Cannot load tips.txt file, please install perf!";
+		exec_path = get_exec_abs_path();
+		if (exec_path == NULL || asprintf(&docdir, "%sDocumentation", exec_path) < 0) {
+			docdir = NULL;
+			help = "Not enough memory or some other internal error occurred!";
+		}
+
+		if (docdir != NULL) {
+			help = perf_tip(docdir);
+			if (help == NULL)
+				help = "Cannot load tips.txt file, please install perf!";
+		}
+
+		if (exec_path)
+			free(exec_path);
+		if (docdir)
+			free(docdir);
 	}
 
 	switch (use_browser) {
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
index 98c6d474aa6f..8b4865c90d5d 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -8,16 +8,28 @@
 #include <linux/compiler.h>
 #include "tests.h"
 #include "util/debug.h"
+#include <subcmd/exec-cmd.h>
 
 int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char *cmd;
 	int ret;
+	char *exec_path = NULL;
+	char *pythonpath;
+
+	exec_path = get_exec_abs_path();
+	if (exec_path == NULL)
+		return -1;
+
+	if (asprintf(&pythonpath, "%spython", exec_path) < 0)
+		return -1;
 
 	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
-		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
+		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
 		return -1;
 
+	free(exec_path);
+	free(pythonpath);
 	pr_debug("python usage test: \"%s\"\n", cmd);
 	ret = system(cmd) ? -1 : 0;
 	free(cmd);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e3e12f9d4733..05454c6340e5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -197,6 +197,10 @@ CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
 # avoid compiler warnings in 32-bit mode
 CFLAGS_genelf_debug.o  += -Wno-packed
 
+ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 363), 1)
+  BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
+endif
+
 $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
@@ -204,7 +208,7 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-
 
 $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_
 
 $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
@@ -214,7 +218,7 @@ $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/e
 
 $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/expr-bison.c -p expr_
 
 $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
@@ -224,7 +228,7 @@ $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-
 
 $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
 
 FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
-- 
2.23.1

