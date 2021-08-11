Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4523E8E31
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhHKKLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:11:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:17196 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237055AbhHKKLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:11:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="195363681"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="195363681"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 03:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="506891103"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2021 03:10:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/6] perf tools: Add dlfilter test
Date:   Wed, 11 Aug 2021 13:10:36 +0300
Message-Id: <20210811101036.17986-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811101036.17986-1-adrian.hunter@intel.com>
References: <20210811101036.17986-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a perf test to test the dlfilter C API.

A perf.data file is synthesized and then processed by perf script with a
dlfilter named dlfilter-test-api-v0.so. Also a C file is compiled to
provide a dso to match the synthesized perf.data file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Makefile.perf                    |  15 +-
 tools/perf/dlfilters/dlfilter-test-api-v0.c | 336 ++++++++++++++++
 tools/perf/tests/Build                      |   1 +
 tools/perf/tests/builtin-test.c             |   4 +
 tools/perf/tests/dlfilter-test.c            | 411 ++++++++++++++++++++
 tools/perf/tests/tests.h                    |   1 +
 tools/perf/util/dlfilter.c                  |   4 +-
 tools/perf/util/dlfilter.h                  |   2 +
 8 files changed, 771 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/dlfilters/dlfilter-test-api-v0.c
 create mode 100644 tools/perf/tests/dlfilter-test.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6dafde69d5e3..24623599113d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -360,8 +360,11 @@ ifndef NO_JVMTI
 PROGRAMS += $(OUTPUT)$(LIBJVMTI)
 endif
 
+DLFILTERS := dlfilter-test-api-v0.so
+DLFILTERS := $(patsubst %,$(OUTPUT)dlfilters/%,$(DLFILTERS))
+
 # what 'all' will build and 'install' will install, in perfexecdir
-ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
+ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS) $(DLFILTERS)
 
 # what 'all' will build but not install in perfexecdir
 OTHER_PROGRAMS = $(OUTPUT)perf
@@ -780,6 +783,13 @@ $(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
+$(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
+	$(Q)$(MKDIR) -p $(OUTPUT)dlfilters
+	$(QUIET_CC)$(CC) -c -Iinclude -o $@ -fpic $<
+
+$(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
+	$(QUIET_LINK)$(CC) -shared -o $@ $<
+
 ifndef NO_JVMTI
 LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
 
@@ -978,6 +988,9 @@ ifndef NO_LIBPYTHON
 		$(INSTALL) scripts/python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
 		$(INSTALL) scripts/python/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/bin'
 endif
+	$(call QUIET_INSTALL, dlfilters) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/dlfilters'; \
+		$(INSTALL) $(DLFILTERS) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/dlfilters';
 	$(call QUIET_INSTALL, perf_completion-script) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d'; \
 		$(INSTALL) perf-completion.sh '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d/perf'
diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
new file mode 100644
index 000000000000..7565a1852c74
--- /dev/null
+++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dlfilter-test-api-v0.c: test original (v0) API for perf --dlfilter shared object
+ * Copyright (c) 2021, Intel Corporation.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+
+/*
+ * Copy original (v0) API instead of including current API
+ */
+#include <linux/perf_event.h>
+#include <linux/types.h>
+
+/* Definitions for perf_dlfilter_sample flags */
+enum {
+	PERF_DLFILTER_FLAG_BRANCH	= 1ULL << 0,
+	PERF_DLFILTER_FLAG_CALL		= 1ULL << 1,
+	PERF_DLFILTER_FLAG_RETURN	= 1ULL << 2,
+	PERF_DLFILTER_FLAG_CONDITIONAL	= 1ULL << 3,
+	PERF_DLFILTER_FLAG_SYSCALLRET	= 1ULL << 4,
+	PERF_DLFILTER_FLAG_ASYNC	= 1ULL << 5,
+	PERF_DLFILTER_FLAG_INTERRUPT	= 1ULL << 6,
+	PERF_DLFILTER_FLAG_TX_ABORT	= 1ULL << 7,
+	PERF_DLFILTER_FLAG_TRACE_BEGIN	= 1ULL << 8,
+	PERF_DLFILTER_FLAG_TRACE_END	= 1ULL << 9,
+	PERF_DLFILTER_FLAG_IN_TX	= 1ULL << 10,
+	PERF_DLFILTER_FLAG_VMENTRY	= 1ULL << 11,
+	PERF_DLFILTER_FLAG_VMEXIT	= 1ULL << 12,
+};
+
+/*
+ * perf sample event information (as per perf script and <linux/perf_event.h>)
+ */
+struct perf_dlfilter_sample {
+	__u32 size; /* Size of this structure (for compatibility checking) */
+	__u16 ins_lat;		/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
+	__u16 p_stage_cyc;	/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
+	__u64 ip;
+	__s32 pid;
+	__s32 tid;
+	__u64 time;
+	__u64 addr;
+	__u64 id;
+	__u64 stream_id;
+	__u64 period;
+	__u64 weight;		/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
+	__u64 transaction;	/* Refer PERF_SAMPLE_TRANSACTION in <linux/perf_event.h> */
+	__u64 insn_cnt;	/* For instructions-per-cycle (IPC) */
+	__u64 cyc_cnt;		/* For instructions-per-cycle (IPC) */
+	__s32 cpu;
+	__u32 flags;		/* Refer PERF_DLFILTER_FLAG_* above */
+	__u64 data_src;		/* Refer PERF_SAMPLE_DATA_SRC in <linux/perf_event.h> */
+	__u64 phys_addr;	/* Refer PERF_SAMPLE_PHYS_ADDR in <linux/perf_event.h> */
+	__u64 data_page_size;	/* Refer PERF_SAMPLE_DATA_PAGE_SIZE in <linux/perf_event.h> */
+	__u64 code_page_size;	/* Refer PERF_SAMPLE_CODE_PAGE_SIZE in <linux/perf_event.h> */
+	__u64 cgroup;		/* Refer PERF_SAMPLE_CGROUP in <linux/perf_event.h> */
+	__u8  cpumode;		/* Refer CPUMODE_MASK etc in <linux/perf_event.h> */
+	__u8  addr_correlates_sym; /* True => resolve_addr() can be called */
+	__u16 misc;		/* Refer perf_event_header in <linux/perf_event.h> */
+	__u32 raw_size;		/* Refer PERF_SAMPLE_RAW in <linux/perf_event.h> */
+	const void *raw_data;	/* Refer PERF_SAMPLE_RAW in <linux/perf_event.h> */
+	__u64 brstack_nr;	/* Number of brstack entries */
+	const struct perf_branch_entry *brstack; /* Refer <linux/perf_event.h> */
+	__u64 raw_callchain_nr;	/* Number of raw_callchain entries */
+	const __u64 *raw_callchain; /* Refer <linux/perf_event.h> */
+	const char *event;
+};
+
+/*
+ * Address location (as per perf script)
+ */
+struct perf_dlfilter_al {
+	__u32 size; /* Size of this structure (for compatibility checking) */
+	__u32 symoff;
+	const char *sym;
+	__u64 addr; /* Mapped address (from dso) */
+	__u64 sym_start;
+	__u64 sym_end;
+	const char *dso;
+	__u8  sym_binding; /* STB_LOCAL, STB_GLOBAL or STB_WEAK, refer <elf.h> */
+	__u8  is_64_bit; /* Only valid if dso is not NULL */
+	__u8  is_kernel_ip; /* True if in kernel space */
+	__u32 buildid_size;
+	__u8 *buildid;
+	/* Below members are only populated by resolve_ip() */
+	__u8 filtered; /* True if this sample event will be filtered out */
+	const char *comm;
+};
+
+struct perf_dlfilter_fns {
+	/* Return information about ip */
+	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
+	/* Return information about addr (if addr_correlates_sym) */
+	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
+	/* Return arguments from --dlarg option */
+	char **(*args)(void *ctx, int *dlargc);
+	/*
+	 * Return information about address (al->size must be set before
+	 * calling). Returns 0 on success, -1 otherwise.
+	 */
+	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
+	/* Return instruction bytes and length */
+	const __u8 *(*insn)(void *ctx, __u32 *length);
+	/* Return source file name and line number */
+	const char *(*srcline)(void *ctx, __u32 *line_number);
+	/* Return perf_event_attr, refer <linux/perf_event.h> */
+	struct perf_event_attr *(*attr)(void *ctx);
+	/* Read object code, return numbers of bytes read */
+	__s32 (*object_code)(void *ctx, __u64 ip, void *buf, __u32 len);
+	/* Reserved */
+	void *(*reserved[120])(void *);
+};
+
+struct perf_dlfilter_fns perf_dlfilter_fns;
+
+static int verbose;
+
+#define pr_debug(fmt, ...) do { \
+		if (verbose) \
+			fprintf(stderr, fmt, ##__VA_ARGS__); \
+	} while (0)
+
+static int test_fail(const char *msg)
+{
+	pr_debug("%s\n", msg);
+	return -1;
+}
+
+#define CHECK(x) do { \
+		if (!(x)) \
+			return test_fail("Check '" #x "' failed\n"); \
+	} while (0)
+
+struct filter_data {
+	__u64 ip;
+	__u64 addr;
+	int do_early;
+	int early_filter_cnt;
+	int filter_cnt;
+};
+
+static struct filter_data *filt_dat;
+
+int start(void **data, void *ctx)
+{
+	int dlargc;
+	char **dlargv;
+	struct filter_data *d;
+	static bool called;
+
+	verbose = 1;
+
+	CHECK(!filt_dat && !called);
+	called = true;
+
+	d = calloc(1, sizeof(*d));
+	if (!d)
+		test_fail("Failed to allocate memory");
+	filt_dat = d;
+	*data = d;
+
+	dlargv = perf_dlfilter_fns.args(ctx, &dlargc);
+
+	CHECK(dlargc == 6);
+	CHECK(!strcmp(dlargv[0], "first"));
+	verbose = strtol(dlargv[1], NULL, 0);
+	d->ip = strtoull(dlargv[2], NULL, 0);
+	d->addr = strtoull(dlargv[3], NULL, 0);
+	d->do_early = strtol(dlargv[4], NULL, 0);
+	CHECK(!strcmp(dlargv[5], "last"));
+
+	pr_debug("%s API\n", __func__);
+
+	return 0;
+}
+
+#define CHECK_SAMPLE(x) do { \
+		if (sample->x != expected.x) \
+			return test_fail("'" #x "' not expected value\n"); \
+	} while (0)
+
+static int check_sample(struct filter_data *d, const struct perf_dlfilter_sample *sample)
+{
+	struct perf_dlfilter_sample expected = {
+		.ip		= d->ip,
+		.pid		= 12345,
+		.tid		= 12346,
+		.time		= 1234567890,
+		.addr		= d->addr,
+		.id		= 99,
+		.stream_id	= 101,
+		.period		= 543212345,
+		.cpu		= 31,
+		.cpumode	= PERF_RECORD_MISC_USER,
+		.addr_correlates_sym = 1,
+		.misc		= PERF_RECORD_MISC_USER,
+	};
+
+	CHECK(sample->size >= sizeof(struct perf_dlfilter_sample));
+
+	CHECK_SAMPLE(ip);
+	CHECK_SAMPLE(pid);
+	CHECK_SAMPLE(tid);
+	CHECK_SAMPLE(time);
+	CHECK_SAMPLE(addr);
+	CHECK_SAMPLE(id);
+	CHECK_SAMPLE(stream_id);
+	CHECK_SAMPLE(period);
+	CHECK_SAMPLE(cpu);
+	CHECK_SAMPLE(cpumode);
+	CHECK_SAMPLE(addr_correlates_sym);
+	CHECK_SAMPLE(misc);
+
+	CHECK(!sample->raw_data);
+	CHECK_SAMPLE(brstack_nr);
+	CHECK(!sample->brstack);
+	CHECK_SAMPLE(raw_callchain_nr);
+	CHECK(!sample->raw_callchain);
+
+#define EVENT_NAME "branches:"
+	CHECK(!strncmp(sample->event, EVENT_NAME, strlen(EVENT_NAME)));
+
+	return 0;
+}
+
+static int check_al(void *ctx)
+{
+	const struct perf_dlfilter_al *al;
+
+	al = perf_dlfilter_fns.resolve_ip(ctx);
+	if (!al)
+		return test_fail("resolve_ip() failed");
+
+	CHECK(al->sym && !strcmp("foo", al->sym));
+	CHECK(!al->symoff);
+
+	return 0;
+}
+
+static int check_addr_al(void *ctx)
+{
+	const struct perf_dlfilter_al *addr_al;
+
+	addr_al = perf_dlfilter_fns.resolve_addr(ctx);
+	if (!addr_al)
+		return test_fail("resolve_addr() failed");
+
+	CHECK(addr_al->sym && !strcmp("bar", addr_al->sym));
+	CHECK(!addr_al->symoff);
+
+	return 0;
+}
+
+static int check_attr(void *ctx)
+{
+	struct perf_event_attr *attr = perf_dlfilter_fns.attr(ctx);
+
+	CHECK(attr);
+	CHECK(attr->type == PERF_TYPE_HARDWARE);
+	CHECK(attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
+
+	return 0;
+}
+
+static int do_checks(void *data, const struct perf_dlfilter_sample *sample, void *ctx, bool early)
+{
+	struct filter_data *d = data;
+
+	CHECK(data && filt_dat == data);
+
+	if (early) {
+		CHECK(!d->early_filter_cnt);
+		d->early_filter_cnt += 1;
+	} else {
+		CHECK(!d->filter_cnt);
+		CHECK(d->early_filter_cnt);
+		CHECK(d->do_early != 2);
+		d->filter_cnt += 1;
+	}
+
+	if (check_sample(data, sample))
+		return -1;
+
+	if (check_attr(ctx))
+		return -1;
+
+	if (early && !d->do_early)
+		return 0;
+
+	if (check_al(ctx) || check_addr_al(ctx))
+		return -1;
+
+	if (early)
+		return d->do_early == 2;
+
+	return 1;
+}
+
+int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	pr_debug("%s API\n", __func__);
+
+	return do_checks(data, sample, ctx, true);
+}
+
+int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	struct filter_data *d = data;
+
+	pr_debug("%s API\n", __func__);
+
+	return do_checks(data, sample, ctx, false);
+}
+
+int stop(void *data, void *ctx)
+{
+	static bool called;
+
+	pr_debug("%s API\n", __func__);
+
+	CHECK(data && filt_dat == data && !called);
+	called = true;
+
+	free(data);
+	filt_dat = NULL;
+	return 0;
+}
+
+const char *filter_description(const char **long_description)
+{
+	*long_description = "Filter used by the 'dlfilter C API' perf test";
+	return "dlfilter to test v0 C API";
+}
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 650aec19d490..803ca426f8e6 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -64,6 +64,7 @@ perf-y += parse-metric.o
 perf-y += pe-file-parsing.o
 perf-y += expand-cgroup.o
 perf-y += perf-time-to-tsc.o
+perf-y += dlfilter-test.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 5e6242576236..fb5846db02e1 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -360,6 +360,10 @@ static struct test generic_tests[] = {
 		.func = test__perf_time_to_tsc,
 		.is_supported = test__tsc_is_supported,
 	},
+	{
+		.desc = "dlfilter C API",
+		.func = test__dlfilter,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
new file mode 100644
index 000000000000..7eba7955d531
--- /dev/null
+++ b/tools/perf/tests/dlfilter-test.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test dlfilter C API. A perf.data file is synthesized and then processed
+ * by perf script with a dlfilter named dlfilter-test-api-v0.so. Also a C file
+ * is compiled to provide a dso to match the synthesized perf.data file.
+ */
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/perf_event.h>
+#include <internal/lib.h>
+#include <subcmd/exec-cmd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <libgen.h>
+#include <string.h>
+#include <errno.h>
+#include "debug.h"
+#include "tool.h"
+#include "event.h"
+#include "header.h"
+#include "machine.h"
+#include "dso.h"
+#include "map.h"
+#include "symbol.h"
+#include "synthetic-events.h"
+#include "util.h"
+#include "archinsn.h"
+#include "dlfilter.h"
+#include "tests.h"
+
+#define MAP_START 0x400000
+
+struct test_data {
+	struct perf_tool tool;
+	struct machine *machine;
+	int fd;
+	u64 foo;
+	u64 bar;
+	u64 ip;
+	u64 addr;
+	char perf[PATH_MAX];
+	char perf_data_file_name[PATH_MAX];
+	char c_file_name[PATH_MAX];
+	char prog_file_name[PATH_MAX];
+	char dlfilters[PATH_MAX];
+};
+
+static int test_result(const char *msg, int ret)
+{
+	pr_debug("%s\n", msg);
+	return ret;
+}
+
+static int process(struct perf_tool *tool, union perf_event *event,
+		   struct perf_sample *sample __maybe_unused,
+		   struct machine *machine __maybe_unused)
+{
+	struct test_data *td = container_of(tool, struct test_data, tool);
+	int fd = td->fd;
+
+	if (writen(fd, event, event->header.size) != event->header.size)
+		return -1;
+
+	return 0;
+}
+
+#define MAXCMD 4096
+#define REDIRECT_TO_DEV_NULL " >/dev/null 2>&1"
+
+static __printf(1, 2) int system_cmd(const char *fmt, ...)
+{
+	char cmd[MAXCMD + sizeof(REDIRECT_TO_DEV_NULL)];
+	int ret;
+
+	va_list args;
+
+	va_start(args, fmt);
+	ret = vsnprintf(cmd, MAXCMD, fmt, args);
+	va_end(args);
+
+	if (ret <= 0 || ret >= MAXCMD)
+		return -1;
+
+	if (!verbose)
+		strcat(cmd, REDIRECT_TO_DEV_NULL);
+
+	pr_debug("Command: %s\n", cmd);
+	ret = system(cmd);
+	if (ret)
+		pr_debug("Failed with return value %d\n", ret);
+
+	return ret;
+}
+
+static bool have_gcc(void)
+{
+	pr_debug("Checking for gcc\n");
+	return !system_cmd("gcc --version");
+}
+
+static int write_attr(struct test_data *td, u64 sample_type, u64 *id)
+{
+	struct perf_event_attr attr = {
+		.size = sizeof(attr),
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS,
+		.sample_type = sample_type,
+		.sample_period = 1,
+	};
+
+	return perf_event__synthesize_attr(&td->tool, &attr, 1, id, process);
+}
+
+static int write_comm(int fd, pid_t pid, pid_t tid, const char *comm_str)
+{
+	struct perf_record_comm comm;
+	ssize_t sz = sizeof(comm);
+
+	comm.header.type = PERF_RECORD_COMM;
+	comm.header.misc = PERF_RECORD_MISC_USER;
+	comm.header.size = sz;
+
+	comm.pid = pid;
+	comm.tid = tid;
+	strncpy(comm.comm, comm_str, 16);
+
+	if (writen(fd, &comm, sz) != sz) {
+		pr_debug("%s failed\n", __func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int write_mmap(int fd, pid_t pid, pid_t tid, u64 start, u64 len, u64 pgoff,
+		      const char *filename)
+{
+	char buf[PERF_SAMPLE_MAX_SIZE];
+	struct perf_record_mmap *mmap = (struct perf_record_mmap *)buf;
+	size_t fsz = roundup(strlen(filename) + 1, 8);
+	ssize_t sz = sizeof(*mmap) - sizeof(mmap->filename) + fsz;
+
+	mmap->header.type = PERF_RECORD_MMAP;
+	mmap->header.misc = PERF_RECORD_MISC_USER;
+	mmap->header.size = sz;
+
+	mmap->pid   = pid;
+	mmap->tid   = tid;
+	mmap->start = start;
+	mmap->len   = len;
+	mmap->pgoff = pgoff;
+	strncpy(mmap->filename, filename, sizeof(mmap->filename));
+
+	if (writen(fd, mmap, sz) != sz) {
+		pr_debug("%s failed\n", __func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int write_sample(struct test_data *td, u64 sample_type, u64 id, pid_t pid, pid_t tid)
+{
+	char buf[PERF_SAMPLE_MAX_SIZE];
+	union perf_event *event = (union perf_event *)buf;
+	struct perf_sample sample = {
+		.ip		= td->ip,
+		.addr		= td->addr,
+		.id		= id,
+		.time		= 1234567890,
+		.cpu		= 31,
+		.pid		= pid,
+		.tid		= tid,
+		.period		= 543212345,
+		.stream_id	= 101,
+	};
+	int err;
+
+	event->header.type = PERF_RECORD_SAMPLE;
+	event->header.misc = PERF_RECORD_MISC_USER;
+	event->header.size = perf_event__sample_event_size(&sample, sample_type, 0);
+	err = perf_event__synthesize_sample(event, sample_type, 0, &sample);
+	if (err)
+		return test_result("perf_event__synthesize_sample() failed", TEST_FAIL);
+
+	err = process(&td->tool, event, &sample, td->machine);
+	if (err)
+		return test_result("Failed to write sample", TEST_FAIL);
+
+	return TEST_OK;
+}
+
+static void close_fd(int fd)
+{
+	if (fd >= 0)
+		close(fd);
+}
+
+static const char *prog = "int bar(){};int foo(){bar();};int main(){foo();return 0;}";
+
+static int write_prog(char *file_name)
+{
+	int fd = creat(file_name, 0644);
+	ssize_t n = strlen(prog);
+	bool err = fd < 0 || writen(fd, prog, n) != n;
+
+	close_fd(fd);
+	return err ? -1 : 0;
+}
+
+static int get_dlfilters_path(char *buf, size_t sz)
+{
+	char perf[PATH_MAX];
+	char path[PATH_MAX];
+	char *perf_path;
+	char *exec_path;
+
+	perf_exe(perf, sizeof(perf));
+	perf_path = dirname(perf);
+	snprintf(path, sizeof(path), "%s/dlfilters/dlfilter-test-api-v0.so", perf_path);
+	if (access(path, R_OK)) {
+		exec_path = get_argv_exec_path();
+		if (!exec_path)
+			return -1;
+		snprintf(path, sizeof(path), "%s/dlfilters/dlfilter-test-api-v0.so", exec_path);
+		free(exec_path);
+		if (access(path, R_OK))
+			return -1;
+	}
+	strlcpy(buf, dirname(path), sz);
+	return 0;
+}
+
+static int check_filter_desc(struct test_data *td)
+{
+	char *long_desc;
+	char *desc;
+
+	if (get_filter_desc(td->dlfilters, "dlfilter-test-api-v0.so", &desc, &long_desc) &&
+	    long_desc && !strcmp(long_desc, "Filter used by the 'dlfilter C API' perf test") &&
+	    desc && !strcmp(desc, "dlfilter to test v0 C API"))
+		return 0;
+
+	return -1;
+}
+
+static int get_ip_addr(struct test_data *td)
+{
+	struct map *map;
+	struct symbol *sym;
+
+	map = dso__new_map(td->prog_file_name);
+	if (!map)
+		return -1;
+
+	sym = map__find_symbol_by_name(map, "foo");
+	if (sym)
+		td->foo = sym->start;
+
+	sym = map__find_symbol_by_name(map, "bar");
+	if (sym)
+		td->bar = sym->start;
+
+	map__put(map);
+
+	td->ip = MAP_START + td->foo;
+	td->addr = MAP_START + td->bar;
+
+	return td->foo && td->bar ? 0 : -1;
+}
+
+static int do_run_perf_script(struct test_data *td, int do_early)
+{
+	return system_cmd("%s script -i %s "
+			  "--dlfilter %s/dlfilter-test-api-v0.so "
+			  "--dlarg first "
+			  "--dlarg %d "
+			  "--dlarg %" PRIu64 " "
+			  "--dlarg %" PRIu64 " "
+			  "--dlarg %d "
+			  "--dlarg last",
+			  td->perf, td->perf_data_file_name, td->dlfilters,
+			  verbose, td->ip, td->addr, do_early);
+}
+
+static int run_perf_script(struct test_data *td)
+{
+	int do_early;
+	int err;
+
+	for (do_early = 0; do_early < 3; do_early++) {
+		err = do_run_perf_script(td, do_early);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+#define TEST_SAMPLE_TYPE (PERF_SAMPLE_IP | PERF_SAMPLE_TID | \
+			  PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_TIME | \
+			  PERF_SAMPLE_ADDR | PERF_SAMPLE_CPU | \
+			  PERF_SAMPLE_PERIOD | PERF_SAMPLE_STREAM_ID)
+
+static int test__dlfilter_test(struct test_data *td)
+{
+	u64 sample_type = TEST_SAMPLE_TYPE;
+	pid_t pid = 12345;
+	pid_t tid = 12346;
+	u64 id = 99;
+	int err;
+
+	if (get_dlfilters_path(td->dlfilters, PATH_MAX))
+		return test_result("dlfilters not found", TEST_SKIP);
+
+	if (check_filter_desc(td))
+		return test_result("Failed to get expected filter description", TEST_FAIL);
+
+	if (!have_gcc())
+		return test_result("gcc not found", TEST_SKIP);
+
+	pr_debug("dlfilters path: %s\n", td->dlfilters);
+
+	if (write_prog(td->c_file_name))
+		return test_result("Failed to write test C file", TEST_FAIL);
+
+	if (verbose > 1)
+		system_cmd("cat %s ; echo", td->c_file_name);
+
+	if (system_cmd("gcc -g -o %s %s", td->prog_file_name, td->c_file_name))
+		return TEST_FAIL;
+
+	if (verbose > 2)
+		system_cmd("objdump -x -dS %s", td->prog_file_name);
+
+	if (get_ip_addr(td))
+		return test_result("Failed to find program symbols", TEST_FAIL);
+
+	pr_debug("Creating new host machine structure\n");
+	td->machine = machine__new_host();
+	td->machine->env = &perf_env;
+
+	td->fd = creat(td->perf_data_file_name, 0644);
+	if (td->fd < 0)
+		return test_result("Failed to create test perf.data file", TEST_FAIL);
+
+	err = perf_header__write_pipe(td->fd);
+	if (err < 0)
+		return test_result("perf_header__write_pipe() failed", TEST_FAIL);
+
+	err = write_attr(td, sample_type, &id);
+	if (err)
+		return test_result("perf_event__synthesize_attr() failed", TEST_FAIL);
+
+	if (write_comm(td->fd, pid, tid, "test-prog"))
+		return TEST_FAIL;
+
+	if (write_mmap(td->fd, pid, tid, MAP_START, 0x10000, 0, td->prog_file_name))
+		return TEST_FAIL;
+
+	if (write_sample(td, sample_type, id, pid, tid) != TEST_OK)
+		return TEST_FAIL;
+
+	if (verbose > 1)
+		system_cmd("%s script -i %s -D", td->perf, td->perf_data_file_name);
+
+	err = run_perf_script(td);
+	if (err)
+		return TEST_FAIL;
+
+	return TEST_OK;
+}
+
+static void unlink_path(const char *path)
+{
+	if (*path)
+		unlink(path);
+}
+
+static void test_data__free(struct test_data *td)
+{
+	machine__delete(td->machine);
+	close_fd(td->fd);
+	if (verbose <= 2) {
+		unlink_path(td->c_file_name);
+		unlink_path(td->prog_file_name);
+		unlink_path(td->perf_data_file_name);
+	}
+}
+
+int test__dlfilter(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct test_data td = {.fd = -1};
+	int pid = getpid();
+	int err;
+
+	perf_exe(td.perf, sizeof(td.perf));
+
+	snprintf(td.perf_data_file_name, PATH_MAX, "/tmp/dlfilter-test-%u-perf-data", pid);
+	snprintf(td.c_file_name, PATH_MAX, "/tmp/dlfilter-test-%u-prog.c", pid);
+	snprintf(td.prog_file_name, PATH_MAX, "/tmp/dlfilter-test-%u-prog", pid);
+
+	err = test__dlfilter_test(&td);
+	test_data__free(&td);
+	return err;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 1100dd55b657..fe1306f58495 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -127,6 +127,7 @@ int test__parse_metric(struct test *test, int subtest);
 int test__pe_file_parsing(struct test *test, int subtest);
 int test__expand_cgroup_events(struct test *test, int subtest);
 int test__perf_time_to_tsc(struct test *test, int subtest);
+int test__dlfilter(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 7d11ce76157c..db964d5a52af 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -530,8 +530,8 @@ int dlfilter__do_filter_event(struct dlfilter *d,
 	return ret;
 }
 
-static bool get_filter_desc(const char *dirname, const char *name,
-			    char **desc, char **long_desc)
+bool get_filter_desc(const char *dirname, const char *name, char **desc,
+		     char **long_desc)
 {
 	char path[PATH_MAX];
 	void *handle;
diff --git a/tools/perf/util/dlfilter.h b/tools/perf/util/dlfilter.h
index 505980442360..cc4bb9657d05 100644
--- a/tools/perf/util/dlfilter.h
+++ b/tools/perf/util/dlfilter.h
@@ -93,5 +93,7 @@ static inline int dlfilter__filter_event_early(struct dlfilter *d,
 }
 
 int list_available_dlfilters(const struct option *opt, const char *s, int unset);
+bool get_filter_desc(const char *dirname, const char *name, char **desc,
+		     char **long_desc);
 
 #endif
-- 
2.17.1

