Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACD38D3DF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhEVGVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 02:21:42 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:61893 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhEVGVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 02:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5250; q=dns/txt; s=iport;
  t=1621664418; x=1622874018;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f7KkmiD67k482FiyPYG2FhcNqhM3Qxwr6ZxK5dM0wIc=;
  b=F5XNvAA88VSwfBs4nXw5MTLoIdXig6hoaixGWYPpspCFCotxrCOixCRm
   HnAsglPLZHcXiif7lTkQdbowo7wgPK5YTC/PFBT5+CkZVN1xfu+NLM2NV
   74kxSxKcDHHLU5AgIGHO3UovFcj9cgd93rYUREGUvyd89rRlA3RzP0RWz
   8=;
X-IPAS-Result: =?us-ascii?q?A0AABAC0oahg/4ENJK1agmCCK3dWATkxljebK4F8CwEBA?=
 =?us-ascii?q?Q0BAS0UBAEBhk8CJTQJDgIEAQEBAQMCAwEBAQEFAQEFAQEBAgEGBHEThWgNh?=
 =?us-ascii?q?nILAXRfMhKCcQGDB6g+gXkzgQGITIFEgTqIdnaDeCccgUlEgRWDYGmJVASCJ?=
 =?us-ascii?q?xkHAYENAYFLgRmRNI16nFWDIZ1HEymDW4sZlleGa45PoAuEDQIEBgUCFoFUO?=
 =?us-ascii?q?4FZMxoIGxWDJAlHGQ6OKxaDNYsWIQMvAjYCBgoBAQMJiT4BAQ?=
IronPort-Data: A9a23:9krKuawcJqzIrmv9sj56t+cvxyrEfRIJ4+MujC+fZmUNrF6WrkUGz
 DROCzrQPviOZWfzeIokYY60/UxV78LXxt82QFdq/1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4wUNdokb0/n9BCJC5xZVH/fzOFuCU5NLsYHgrHFc5En550HqPpsZg6mJWqYnha++yk
 YuaT/33YDdJDBYtbwr4Q4rawP9elKyaVAEw5zTSVtgX1LPqrET5ObpETU2Hw9QUdaEPdgKyb
 76rILhUZQo19T91Yj+uuu6TnkHn3tc+MCDW4ke6VZROjTB7pDAI0qQXCMA9VkV9gja5wohU0
 +5k4MnYpQcBZsUgmcwUVx1eVip5J6ADqfnMIGO0toqYyEiun3nEmqo1Shpoe9RDvL8tUAmi9
 tRAQNwJRhyRju2x2q+6YuJtnc8kasLsOevzv1k/lW2JUal/Hs6rr6Pi9/Rq4R02vcx3MNXMP
 5Q2aCo+NijJWkgaUrsQINdk9AuyvVH7cjtFuBeWqLAx7mz70gN8yv7uPcDTd9jMQt9a9m6dp
 2TJ+EzjDx0aPcDZwj2AmlqugevUlAvhVY4SHaH+/flv6HWawmEDARsaWEH9uvm4kU69WtR3L
 00S5zporK4u+UjtRd74NzW+qXuErwMaVPJTHvc85QXLzbDbiy6QDW0JZj1MctorsIkxXzNC/
 keEg97zFxRutrOPQH6Q/7vSqim9UQAQJHUBIzUZUQ8M5dXLqZs2yBnIS75e/LWdh9nxH3T7x
 CqH6Xl4jLQIhslN3KK+lbzavw+RSlHyZlZdzm3qsqiNt2uVuKbNi1SU1GXm
IronPort-HdrOrdr: A9a23:7XIpiK9xkLn1S5q0chJuk+DNI+orL9Y04lQ7vn2ZLiYlEPBw+P
 rBoB1273LJYVUqKRIdcK67WZVoKEm0nfUe3WB7B9iftWfd1FdAVLsD0WMnqAeQfxEXMYVmpM
 JdT5Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,319,1613433600"; 
   d="scan'208";a="704847176"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 May 2021 06:20:17 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 14M6KHPe028323
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 22 May 2021 06:20:17 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id D3EF5CC1251; Fri, 21 May 2021 23:20:16 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v7 1/3] perf report: compile tips.txt in perf binary
Date:   Fri, 21 May 2021 23:20:14 -0700
Message-Id: <20210522062016.84677-1-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-9.cisco.com
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

