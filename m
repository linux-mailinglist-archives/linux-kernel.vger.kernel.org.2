Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E188315DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 04:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhBJDZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 22:25:46 -0500
Received: from foss.arm.com ([217.140.110.172]:60346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhBJDZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 22:25:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E48CE1042;
        Tue,  9 Feb 2021 19:24:58 -0800 (PST)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D082B3F73D;
        Tue,  9 Feb 2021 19:24:53 -0800 (PST)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, agerstmayr@redhat.com,
        kan.liang@linux.intel.com, adrian.hunter@intel.com
Cc:     Jianlin.Lv@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf tools: Fix arm64 build error with gcc-11
Date:   Wed, 10 Feb 2021 11:24:47 +0800
Message-Id: <20210210032447.2248255-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc version: 11.0.0 20210208 (experimental) (GCC)

Following build error on arm64:

.......
In function ‘printf’,
    inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
    inlined from ‘regs__printf’ at util/session.c:1169:2:
/usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
  error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]

107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
                __va_arg_pack ());

......
In function ‘fprintf’,
  inlined from ‘perf_sample__fprintf_regs.isra’ at \
    builtin-script.c:622:14:
/usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
    error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
  100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
  101 |                         __va_arg_pack ());

cc1: all warnings being treated as errors
.......

This patch fixes Wformat-overflow warnings. Add ternary operator,
The statement evaluates to "Unknown" if reg_name==NULL is met.

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
v2: Add ternary operator to avoid similar errors in other arch.
---
 tools/perf/builtin-script.c                            | 4 +++-
 tools/perf/util/scripting-engines/trace-event-python.c | 4 +++-
 tools/perf/util/session.c                              | 5 +++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 42dad4a0f8cf..d59da3a063d0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -635,6 +635,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
 {
 	unsigned i = 0, r;
 	int printed = 0;
+	const char *reg_name;
 
 	if (!regs || !regs->regs)
 		return 0;
@@ -643,7 +644,8 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		reg_name = perf_reg_name(r);
+		printed += fprintf(fp, "%5s:0x%"PRIx64" ", reg_name ?: "Unknown", val);
 	}
 
 	return printed;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c83c2c6564e0..e1222cc6a699 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -691,6 +691,7 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
 {
 	unsigned int i = 0, r;
 	int printed = 0;
+	const char *reg_name;
 
 	bf[0] = 0;
 
@@ -700,9 +701,10 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
 
+		reg_name = perf_reg_name(r);
 		printed += scnprintf(bf + printed, size - printed,
 				     "%5s:0x%" PRIx64 " ",
-				     perf_reg_name(r), val);
+				     reg_name ?: "Unknown", val);
 	}
 
 	return printed;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 25adbcce0281..1058d8487e98 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1135,12 +1135,13 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 static void regs_dump__printf(u64 mask, u64 *regs)
 {
 	unsigned rid, i = 0;
+	const char *reg_name;
 
 	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs[i++];
-
+		reg_name = perf_reg_name(rid);
 		printf(".... %-5s 0x%016" PRIx64 "\n",
-		       perf_reg_name(rid), val);
+		       reg_name ?: "Unknown", val);
 	}
 }
 
-- 
2.25.1

