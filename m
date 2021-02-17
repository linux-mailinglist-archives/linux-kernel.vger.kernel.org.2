Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B031D8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhBQMAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:00:36 -0500
Received: from foss.arm.com ([217.140.110.172]:57448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhBQL7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:59:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D45CF31B;
        Wed, 17 Feb 2021 03:58:50 -0800 (PST)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 810A63F694;
        Wed, 17 Feb 2021 03:58:45 -0800 (PST)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, agerstmayr@redhat.com,
        kan.liang@linux.intel.com, adrian.hunter@intel.com
Cc:     Jianlin.Lv@arm.com, iecedge@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4] perf tools: Fix arm64 build error with gcc-11
Date:   Wed, 17 Feb 2021 19:58:30 +0800
Message-Id: <20210217115830.1414355-1-Jianlin.Lv@arm.com>
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

This patch fixes Wformat-overflow warnings. Add helper function to
convert NULL to "unknown".

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
v2: Add ternary operator to avoid similar errors in other arch.
v3: Declared reg_name in inner block.
v4: Add helper function: perf_reg_name_str, update changelog.
---
 tools/perf/builtin-script.c                           |  2 +-
 tools/perf/util/perf_regs.h                           | 11 ++++++++++-
 .../perf/util/scripting-engines/trace-event-python.c  |  2 +-
 tools/perf/util/session.c                             |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 42dad4a0f8cf..35cddca2c7a7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -643,7 +643,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name_str(r), val);
 	}
 
 	return printed;
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index a45499126184..e4a0a6f5408e 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -33,13 +33,22 @@ extern const struct sample_reg sample_reg_masks[];
 
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 
+static inline const char *perf_reg_name_str(int id)
+{
+	const char *str = perf_reg_name(id);
+
+	if (!str)
+		return "unknown";
+	return str;
+}
+
 #else
 #define PERF_REGS_MASK	0
 #define PERF_REGS_MAX	0
 
 #define DWARF_MINIMAL_REGS PERF_REGS_MASK
 
-static inline const char *perf_reg_name(int id __maybe_unused)
+static inline const char *perf_reg_name_str(int id __maybe_unused)
 {
 	return "unknown";
 }
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c83c2c6564e0..361307026485 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -702,7 +702,7 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
 
 		printed += scnprintf(bf + printed, size - printed,
 				     "%5s:0x%" PRIx64 " ",
-				     perf_reg_name(r), val);
+				     perf_reg_name_str(r), val);
 	}
 
 	return printed;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 25adbcce0281..0737d3e7e698 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1140,7 +1140,7 @@ static void regs_dump__printf(u64 mask, u64 *regs)
 		u64 val = regs[i++];
 
 		printf(".... %-5s 0x%016" PRIx64 "\n",
-		       perf_reg_name(rid), val);
+		       perf_reg_name_str(rid), val);
 	}
 }
 
-- 
2.25.1

