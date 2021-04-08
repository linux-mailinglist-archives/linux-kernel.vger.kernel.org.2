Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C413583B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhDHMvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:51:52 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:37157 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhDHMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8804; q=dns/txt; s=iport;
  t=1617886297; x=1619095897;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d3w+xnsiCJEwuqqkc2Scl5nBM60qkUsDZzpS++O3N+g=;
  b=JXfR/QSisyr/X6Z/95d08jOuRZ0cuCHsPEFp6aKFNijKqnLXMIjaWg9Q
   5Han94XJ+BFxVM/FOOoYlL8TCGAKteM/3wzwWJQZORpw9C57doElPbhVz
   gzt8Au6USetMXhluQbgdCDBb+gvCK86t93QHIOrNf7ZDcPpB60ioZz6wu
   Y=;
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A5wBG66Bd/bvrYAzlHek055DYdL4zR+YMi2?=
 =?us-ascii?q?QD/UZ3VBBTb4ikjMiohvsWzlvZjzwWVXEml7m7Scu9aF7V6JId2+csFJi4Wg?=
 =?us-ascii?q?2OggaVBaVDyaen/DH6AS358YdmpMRdWoxzEsf5A1Q/rcuS2miFOu0tytWG76?=
 =?us-ascii?q?yk7N22pxwGcShRd6pi4w1lYzz1LmRKQmB9aaYRJd657spDqyHIQxQqR/X+IG?=
 =?us-ascii?q?UZVO7eoNCOs5TqbXc9dnoawTjLqy+047jnFBXd5DMiandkxLcv9nWtqX2d2p?=
 =?us-ascii?q?me?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BfAwDQ+25g/4gNJK1aHgEBCxIMggc?=
 =?us-ascii?q?Lgit3VgE5MZYVmmyBfAsBAQENAQEgFAQBAYZJAiU0CQ4CAwEBDAEBBQEBAQI?=
 =?us-ascii?q?BBgRxE4VQDYZyCwF0XzISgnEBgweqeoF2M4EBiCOBRIE5iGV0g3QnHIFJQoE?=
 =?us-ascii?q?Tg2CKOQSCNRJTKBMBExCBKIEZnl2cKYMViWOTCg8jg02BPok6hhKQGpUVnjM?=
 =?us-ascii?q?gVIQCAgQGBQIWgVQ6gVkzGggbFYMkCUcZDo4rFoM1hwqECCEDLwI2AgYKAQE?=
 =?us-ascii?q?DCY0RAQE?=
X-IronPort-AV: E=Sophos;i="5.82,206,1613433600"; 
   d="scan'208";a="883645339"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Apr 2021 12:51:36 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 138CpZo2028456
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 8 Apr 2021 12:51:36 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 99AA7CC1251; Thu,  8 Apr 2021 05:51:35 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v3] perf: build reproducibility improvements
Date:   Thu,  8 Apr 2021 05:51:35 -0700
Message-Id: <20210408125135.8445-1-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch helps to make perf build more reproducible

It seems there is some need to have an ability to invoke
perf from build directory without installation
(84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
DOCDIR contains an absolute path to kernel source directory.
This path can be read from .config-detected that is stored in the
same dir as perf executable.

There is also python binding test where PYTHONPATH is used to store
absolute path to python/perf.so library. This path can be
also determined in runtime.

bison stores full paths in generated files. This can be
remapped by using --file-prefix-map option that is available
starting from version 3.7.1.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/perf/Build              |  1 -
 tools/perf/Makefile.config    |  9 +++++
 tools/perf/builtin-report.c   | 13 +++++++-
 tools/perf/tests/Build        |  2 +-
 tools/perf/tests/python-use.c | 14 +++++++-
 tools/perf/util/Build         |  6 ++--
 tools/perf/util/util.c        | 62 +++++++++++++++++++++++++++++++++++
 tools/perf/util/util.h        |  5 +++
 8 files changed, 105 insertions(+), 7 deletions(-)

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
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d8e59d31399a..2035bae6d5c5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -195,6 +195,12 @@ ifeq ($(call get-executable,$(BISON)),)
   dummy := $(error Error: $(BISON) is missing on this system, please install it)
 endif
 
+ifneq ($(OUTPUT),)
+  ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
+    BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
+  endif
+endif
+
 # Treat warnings as errors unless directed not to
 ifneq ($(WERROR),0)
   CORE_CFLAGS += -Werror
@@ -1208,3 +1214,6 @@ $(call detected_var,LIBDIR)
 $(call detected_var,GTK_CFLAGS)
 $(call detected_var,PERL_EMBED_CCOPTS)
 $(call detected_var,PYTHON_EMBED_CCOPTS)
+ifneq ($(BISON_FILE_PREFIX_MAP),)
+$(call detected_var,BISON_FILE_PREFIX_MAP)
+endif
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2a845d6cac09..33f7ac6ed6ce 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -610,12 +610,23 @@ static int report__browse_hists(struct report *rep)
 	struct perf_session *session = rep->session;
 	struct evlist *evlist = session->evlist;
 	const char *help = perf_tip(system_path(TIPDIR));
+	char *exec_path = NULL;
+	char *docdir = NULL;
 
 	if (help == NULL) {
 		/* fallback for people who don't install perf ;-) */
-		help = perf_tip(DOCDIR);
+		exec_path = perf_exe_path();
+		if (exec_path == NULL || perf_src_doc(exec_path, &docdir))
+			docdir = NULL;
+
+		if (docdir != NULL)
+			help = perf_tip(docdir);
+
 		if (help == NULL)
 			help = "Cannot load tips.txt file, please install perf!";
+
+		free(exec_path);
+		free(docdir);
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
index 98c6d474aa6f..930aa4c6264e 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -8,16 +8,28 @@
 #include <linux/compiler.h>
 #include "tests.h"
 #include "util/debug.h"
+#include "util/util.h"
 
 int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char *cmd;
 	int ret;
+	char *exec_path;
+	char *pythonpath;
+
+	exec_path = perf_exe_path();
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
index e3e12f9d4733..33476b1d28d5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -204,7 +204,7 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-
 
 $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_
 
 $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
@@ -214,7 +214,7 @@ $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/e
 
 $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/expr-bison.c -p expr_
 
 $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
@@ -224,7 +224,7 @@ $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-
 
 $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
 
 FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 37a9492edb3e..f5408520a3b5 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -416,3 +416,65 @@ char *perf_exe(char *buf, int len)
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
+
+int perf_src_doc(const char *exec_path, char **strp)
+{
+	FILE *file;
+	char *line = NULL;
+	size_t line_len = 0;
+	ssize_t nread;
+	int ret = -1;
+	char *config_detected = NULL;
+	static const char srcdir[] = "srcdir_SQ";
+
+	if (asprintf(&config_detected, "%s.config-detected", exec_path) < 0)
+		return -1;
+
+	file = fopen(config_detected, "r");
+	if (!file)
+		goto out;
+
+	while (!feof(file)) {
+		nread = getline(&line, &line_len, file);
+		if (nread < 0)
+			break;
+
+		if (!strncmp(line, srcdir, sizeof(srcdir) - 1)) {
+
+			if (line[nread - 1] == '\n')
+				line[nread - 1] = 0;
+
+			if (asprintf(strp, "%s/Documentation", &line[sizeof(srcdir)]) != -1)
+				ret = 0;
+
+			break;
+		}
+	}
+
+	fclose(file);
+out:
+	free(line);
+	free(config_detected);
+	return ret;
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index ad737052e597..e480df3f5993 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -51,6 +51,11 @@ void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
 char *perf_exe(char *buf, int len);
+/* perf_exe_path return malloc'd string and perf_src_doc allocate
+ * memory for strp, caller must free it
+ */
+char *perf_exe_path(void);
+int perf_src_doc(const char *exe_path, char **strp);
 
 #ifndef O_CLOEXEC
 #ifdef __sparc__
-- 
2.26.2.Cisco

