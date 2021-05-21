Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5040938CC1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhEUR3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:29:22 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:2968 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhEUR3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5250; q=dns/txt; s=iport;
  t=1621618075; x=1622827675;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f7KkmiD67k482FiyPYG2FhcNqhM3Qxwr6ZxK5dM0wIc=;
  b=dlwr+hvK/TnvlXe9Lo8UJ8jOI779qOjVZwL93+DAYyTtPVljFhsXRP2f
   xkarPzqDNnqLkosvA8NMMw11n62731Ru+Y42D6iolaPB4FjVB7m9s9ytp
   pZFpI38p/600adshJPpojLGC377d+KwIIoN3TAeasN0jQlMYBhvTg4af6
   M=;
X-IPAS-Result: =?us-ascii?q?A0AMBAD87Kdg/4oNJK1agmCCK3dWATkxljibK4F8CwEBA?=
 =?us-ascii?q?Q0BAS0UBAEBhk8CJTQJDgIEAQEBAQMCAwEBAQEFAQEFAQEBAgEGBHEThWgNh?=
 =?us-ascii?q?nILAXRfMhKCcQGDB6legXkzgQGIP4FEgTqIdnaDeCccgUlEgRWDYGmJVASCJ?=
 =?us-ascii?q?xkHAYENAYFLgRmRNI16nFWDIZ1HEymDW4sZlleGa45PoAuEDQIEBgUCFoFUO?=
 =?us-ascii?q?4FZMxoIGxWDJAlHGQ6OKxaDNYsWIQMvAjYCBgoBAQMJiWQBAQ?=
IronPort-Data: A9a23:9wlQ2quQVOgosPQ9ZKfXh8eYd+fnVE5fMUV32f8akzHdYApBsoF/q
 tZmKWyPaauPZzbze952OYjn9kkEvpaHzNZjS1NkqSFjES9DgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokcxJX5BC5C5xZVG/fngqoHUVaiUYEideSc+EH140U85wrZg6mJVqYHR7z2l6
 IuaT/L3YDdJ6xYsWo7Dw/vewP/HlK2aVAIw5jTSV9gS1LPtvyV94KYkGE2EByCQrr+4sQKNb
 72rILmRpgs19vq2Yz+vuu6TnkYiGtY+MeUS45Zbc/DKv/RMmsA9+p0DBsgtc1d8ty6Yutd90
 dwRrq2MCgh8a8UgmMxFO/VZOyh6OasD87jdLD3i98eS1EbBNXDrxp2CDmlvYtZeobgxWDoIr
 KdIQNwORkjra+aezKCyRe52m8ULJ8jwN4RZsXZlpd3cJal+Hc6fGfSUu7e02h8pnupPHs3vT
 PEjUgdQMUvyID11HVsuXcdWcOCAwyOXnydjgFaUo7cnpmve1gp81JDzP9fPPN+HX8NYmgCfv
 G2u12H4BB4dHMaSxTqM7jSngeqntSH8XJkbPKe1+v5jnBuYwWl7IBQSWEuyp/W0kAilW9NEK
 08V/AIqrK4v5AqqSMXwW1uzp3vslhgVXtpBDus1wAKA0KzZ50CeHGdsZjdKbdEOt8IsQzEuk
 FiTkLvBHTFzvaeHYXOb+K2doT67NW4SN2BqTSoNVwhD+cT/pIg1gjrGVNMlG6mw5uAZAhn5x
 zSM6SM5nbhW0IgA1r6w+hbMhDfESoX1czPZLz7/BgqNhj6Vrqb/D2B0wTA3Ncp9Ebs=
IronPort-HdrOrdr: A9a23:xCP266GmkbbZLe+VpLqE/ceALOsnbusQ8zAXPidKOH5om6Oj+f
 xG8M536faWskdzZJhfo7G90cC7KBu2n6KdirN/AV7NZmXbUROTTL2LKeDZslnd8+qUzJ856Z
 td
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,319,1613433600"; 
   d="scan'208";a="704642966"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 21 May 2021 17:27:55 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 14LHRsOb023280
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 May 2021 17:27:54 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 03679CC1251; Fri, 21 May 2021 10:27:53 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v6 1/3] perf report: compile tips.txt in perf binary
Date:   Fri, 21 May 2021 10:27:51 -0700
Message-Id: <20210521172753.55399-1-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-5.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems there is some need to have an ability to invoke perf from
build directory without installation
(84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
DOCDIR definition contains an absolute path to kernel source directory.
It is build machine related info and it makes perf binary unreproducible.

This can be avoided by compiling tips.txt in perf directly.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/perf/Build               |  2 +-
 tools/perf/Documentation/Build |  9 +++++++++
 tools/perf/builtin-report.c    | 34 +++++++++++++++++++++++++---------
 tools/perf/util/util.c         | 28 ----------------------------
 tools/perf/util/util.h         |  2 --
 5 files changed, 35 insertions(+), 40 deletions(-)
 create mode 100644 tools/perf/Documentation/Build

diff --git a/tools/perf/Build b/tools/perf/Build
index db61dbe2b543..3a2e768d7576 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -45,12 +45,12 @@ CFLAGS_perf.o              += -DPERF_HTML_PATH="BUILD_STR($(htmldir_SQ))"	\
 			      -DPREFIX="BUILD_STR($(prefix_SQ))"
 CFLAGS_builtin-trace.o	   += -DSTRACE_GROUPS_DIR="BUILD_STR($(STRACE_GROUPS_DIR_SQ))"
 CFLAGS_builtin-report.o	   += -DTIPDIR="BUILD_STR($(tipdir_SQ))"
-CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
 
 perf-y += util/
 perf-y += arch/
 perf-y += ui/
 perf-y += scripts/
 perf-$(CONFIG_TRACE) += trace/beauty/
+perf-y += Documentation/
 
 gtk-y += ui/gtk/
diff --git a/tools/perf/Documentation/Build b/tools/perf/Documentation/Build
new file mode 100644
index 000000000000..83e16764caa4
--- /dev/null
+++ b/tools/perf/Documentation/Build
@@ -0,0 +1,9 @@
+perf-y += tips.o
+
+quiet_cmd_ld_tips = LD       $@
+      cmd_ld_tips = $(LD) -r -b binary -o $@ $<
+
+$(OUTPUT)Documentation/tips.o: Documentation/tips.txt FORCE
+	$(call rule_mkdir)
+	$(call if_changed,ld_tips)
+
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 36f9ccfeb38a..4f2c7ee8fea1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,7 +47,6 @@
 #include "util/time-utils.h"
 #include "util/auxtrace.h"
 #include "util/units.h"
-#include "util/util.h" // perf_tip()
 #include "ui/ui.h"
 #include "ui/progress.h"
 #include "util/block-info.h"
@@ -109,6 +108,9 @@ struct report {
 	int			nr_block_reports;
 };
 
+extern char _binary_Documentation_tips_txt_start[];
+extern char _binary_Documentation_tips_txt_end[];
+
 static int report__config(const char *var, const char *value, void *cb)
 {
 	struct report *rep = cb;
@@ -614,19 +616,33 @@ static int report__gtk_browse_hists(struct report *rep, const char *help)
 	return hist_browser(rep->session->evlist, help, NULL, rep->min_percent);
 }
 
+static const char *perf_tip(void)
+{
+	char *start = _binary_Documentation_tips_txt_start;
+	char *tok, *tmp, *prev;
+	int pick, size;
+
+	size = _binary_Documentation_tips_txt_end - start;
+	pick = random() % size;
+
+	_binary_Documentation_tips_txt_start[size - 1] = 0;
+
+	for (tok = strtok_r(start, "\n", &tmp); tok;
+	     tok = strtok_r(NULL, "\n", &tmp)) {
+		if (pick < (tok - start))
+			return prev;
+		prev = tok;
+	}
+
+	return prev;
+}
+
 static int report__browse_hists(struct report *rep)
 {
 	int ret;
 	struct perf_session *session = rep->session;
 	struct evlist *evlist = session->evlist;
-	const char *help = perf_tip(system_path(TIPDIR));
-
-	if (help == NULL) {
-		/* fallback for people who don't install perf ;-) */
-		help = perf_tip(DOCDIR);
-		if (help == NULL)
-			help = "Cannot load tips.txt file, please install perf!";
-	}
+	const char *help = perf_tip();
 
 	switch (use_browser) {
 	case 1:
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 37a9492edb3e..3bba74e431ed 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -379,34 +379,6 @@ fetch_kernel_version(unsigned int *puint, char *str,
 	return 0;
 }
 
-const char *perf_tip(const char *dirpath)
-{
-	struct strlist *tips;
-	struct str_node *node;
-	char *tip = NULL;
-	struct strlist_config conf = {
-		.dirname = dirpath,
-		.file_only = true,
-	};
-
-	tips = strlist__new("tips.txt", &conf);
-	if (tips == NULL)
-		return errno == ENOENT ? NULL :
-			"Tip: check path of tips.txt or get more memory! ;-p";
-
-	if (strlist__nr_entries(tips) == 0)
-		goto out;
-
-	node = strlist__entry(tips, random() % strlist__nr_entries(tips));
-	if (asprintf(&tip, "Tip: %s", node->s) < 0)
-		tip = (char *)"Tip: get more memory! ;-)";
-
-out:
-	strlist__delete(tips);
-
-	return tip;
-}
-
 char *perf_exe(char *buf, int len)
 {
 	int n = readlink("/proc/self/exe", buf, len);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index ad737052e597..80b194ee6c7d 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -39,8 +39,6 @@ int fetch_kernel_version(unsigned int *puint,
 #define KVER_FMT	"%d.%d.%d"
 #define KVER_PARAM(x)	KVER_VERSION(x), KVER_PATCHLEVEL(x), KVER_SUBLEVEL(x)
 
-const char *perf_tip(const char *dirpath);
-
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
-- 
2.26.2.Cisco

