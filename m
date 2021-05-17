Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E5382758
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhEQIrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:47:31 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:32866 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbhEQIr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5287; q=dns/txt; s=iport;
  t=1621241173; x=1622450773;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=brPNNt9WZ/eVr872phkhdnMIXCTuIwqzAx+BVbOQplM=;
  b=DHep2fo0MnGQqE9szSvlOf/h0CIalbN1UZMS3QgWFPv6BHlXq4igqQhi
   Y/EJootRV7EaaaLeTtVBzyWgsO4ah5/ncS5ci9GzRpkYSF+/JdwGxyHJg
   +IDWgIIFTuS/+dTWkzJ0X6csEo1gvE31Lu3inw/fEaXbwUFTTiJ714x8e
   E=;
X-IPAS-Result: =?us-ascii?q?A0AhAQDsLKJgmIENJK1aHgEBCxIMggwLgyJWATkxlj6bG?=
 =?us-ascii?q?IF8CwEBAQ0BAS0UBAEBhkUCJTQJDgIEAQEBAQMCAwEBAQEFAQEFAQEBAgEGB?=
 =?us-ascii?q?BQBAQEBAQEBAWiFUA2GcgsBdF8yEoJxAYMHqDCBeTOBAYgTgUSBOoh2doN3J?=
 =?us-ascii?q?xyBSUSBFYNgaYlUBIInGQcBgQ0BgUuBGZEwjXacS4MgnTQRKINaixOWUIZqj?=
 =?us-ascii?q?kyfdoQMAgQGBQIWgVQ4gVszGggbFYMkCUcZDo4rDQmDNYsWIQMvAjYCBgoBA?=
 =?us-ascii?q?QMJjRABAQ?=
IronPort-HdrOrdr: A9a23:dvBPLqpqyYoLBDnvBKo0d+oaV5o+eYIsimQD101hICG9Ffbo9f
 xG88506faZslsssRIb6LO90de7IE80nKQdieJ6AV7IZmbbUQWTQL2KlbGD/9UlcBeOktK0Es
 xbAs1DNOE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,306,1613433600"; 
   d="scan'208";a="695982248"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 17 May 2021 08:46:08 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 14H8k5Wt027484
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 May 2021 08:46:07 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id E2E1BCC1253; Mon, 17 May 2021 01:46:04 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v5 1/3] perf report: compile tips.txt in perf binary
Date:   Mon, 17 May 2021 01:46:02 -0700
Message-Id: <20210517084604.2895-1-dzagorui@cisco.com>
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
 tools/perf/Documentation/Build |  9 ++++++++
 tools/perf/builtin-report.c    | 39 ++++++++++++++++++++++++++--------
 tools/perf/util/util.c         | 28 ------------------------
 tools/perf/util/util.h         |  2 --
 5 files changed, 40 insertions(+), 40 deletions(-)
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
index 36f9ccfeb38a..ef6f25a521b4 100644
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
@@ -614,19 +616,38 @@ static int report__gtk_browse_hists(struct report *rep, const char *help)
 	return hist_browser(rep->session->evlist, help, NULL, rep->min_percent);
 }
 
+#define MAX_TIPS        60
+
+static const char *perf_tip(void)
+{
+	char *str[MAX_TIPS];
+	int i = 0;
+
+	_binary_Documentation_tips_txt_start[_binary_Documentation_tips_txt_end -
+		_binary_Documentation_tips_txt_start - 1] = 0;
+
+	str[i] = strtok(_binary_Documentation_tips_txt_start, "\n");
+	if (!str[i])
+		return "Tips cannot be found!";
+
+	i++;
+
+	while (i < MAX_TIPS) {
+		str[i] = strtok(NULL, "\n");
+		if (!str[i])
+			break;
+		i++;
+	}
+
+	return str[random() % i];
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

