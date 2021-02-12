Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7B531A340
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhBLRFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:05:44 -0500
Received: from foss.arm.com ([217.140.110.172]:39924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhBLREy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:04:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 980BB1063;
        Fri, 12 Feb 2021 09:04:03 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.5.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82B613F73B;
        Fri, 12 Feb 2021 09:04:02 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>
Subject: [PATCH v2 1/4] perf tools: record aarch64 registers automatically
Date:   Fri, 12 Feb 2021 17:03:40 +0000
Message-Id: <20210212170343.7729-1-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, automatically record all the registers if the frame pointer
mode is on. They will be used to do a dwarf unwind to find the caller
of the leaf frame if the frame pointer was omitted.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
---
 tools/perf/arch/arm64/util/machine.c | 7 +++++++
 tools/perf/builtin-record.c          | 7 +++++++
 tools/perf/util/callchain.h          | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index 40c5e0b5bda8..bf2f9c447867 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -5,6 +5,8 @@
 #include <string.h>
 #include "debug.h"
 #include "symbol.h"
+#include "callchain.h"
+#include "record.h"
 
 /* On arm64, kernel text segment start at high memory address,
  * for example 0xffff 0000 8xxx xxxx. Modules start at a low memory
@@ -26,3 +28,8 @@ void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
 		p->end = c->start;
 	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
 }
+
+void arch__add_leaf_frame_record_opts(struct record_opts *opts)
+{
+	opts->sample_user_regs = arch__user_reg_mask();
+}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8a0127d4fb52..496307ef490e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2244,6 +2244,10 @@ static int record__parse_mmap_pages(const struct option *opt,
 	return ret;
 }
 
+void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
+{
+}
+
 static int parse_control_option(const struct option *opt,
 				const char *str,
 				int unset __maybe_unused)
@@ -2813,6 +2817,9 @@ int cmd_record(int argc, const char **argv)
 	/* Enable ignoring missing threads when -u/-p option is defined. */
 	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
+	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP)
+		arch__add_leaf_frame_record_opts(&rec->opts);
+
 	err = -ENOMEM;
 	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
 		usage_with_options(record_usage, record_options);
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 5824134f983b..77fba053c677 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -280,6 +280,8 @@ static inline int arch_skip_callchain_idx(struct thread *thread __maybe_unused,
 }
 #endif
 
+void arch__add_leaf_frame_record_opts(struct record_opts *opts);
+
 char *callchain_list__sym_name(struct callchain_list *cl,
 			       char *bf, size_t bfsize, bool show_dso);
 char *callchain_node__scnprintf_value(struct callchain_node *node,
-- 
2.23.0

