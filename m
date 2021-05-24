Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7036838E538
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhEXLRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:17:02 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:14525 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhEXLQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5250; q=dns/txt; s=iport;
  t=1621854916; x=1623064516;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f7KkmiD67k482FiyPYG2FhcNqhM3Qxwr6ZxK5dM0wIc=;
  b=XyHyDoGp6XEcJcUqTAuRdOzwLHM2c/a/VdhxtA0AMOPBwp67qacJLwxs
   iirFyYAmuQgAKPvLfGN27GhBtFdB+oUPMif3fde0Za9cKPlibygaZ1awc
   oq8zAl55iMFDYdD7f24bZqqQlc9hJn1bSzsLu8B9lFSf82T4PavdzZJhE
   o=;
X-IPAS-Result: =?us-ascii?q?A0AiAQA9iqtgl5tdJa1agmCDIlYBOTGWOJswgXwLAQEBD?=
 =?us-ascii?q?QEBLRQEAQGGUAIlNAkOAgQBAQEBAwIDAQEBAQUBAQUBAQECAQYEFAEBAQEBA?=
 =?us-ascii?q?QEBaIVoDYZyCwF0XzISgnEBgwenYoF5M4EBiDOBRIE6iHZ2g3gnHIFJRIEVg?=
 =?us-ascii?q?2BpiVQEgicZBwGBDQGBS4EZkTaNfJxVgyGdSBQpg1uLGZZYhm2OUKAMhA0CB?=
 =?us-ascii?q?AYFAhaBVDmBWzMaCBsVgyQJRxkOjisNCYM1ixchAy8CNgIGCgEBAwmJbgEB?=
IronPort-Data: A9a23:Dbc3EqPSeC3LUWPvrR1xl8FynXyQoLVcMsEvi/4bfWQNrUpwhDZSn
 DFLDWuEOveKZWT2LdlyaYnl9EIB6JHSytM2SHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmh1qpwPkcFhcwnD/1WlTahSQ6hfvgqobUUraeY3gsH1M8EU/NtDo68wIHqt8w6TSGK1vlV
 ePa+6Uz73f8hlaYmkpNg06ygEsHUMba4Vv0jXRiDRx/h2IyolFOZH4pyQ5dGFOjKmVcNrbSq
 +8uV9hV9EuBl/smIovNfroW7iTmT5aKVTVihEa6VICZrVt/jysp/5pqd/ABV19Ysg2UjfpIn
 YAlWZyYEW/FP4XWk+gbFhJfCSw7YetN+aTMJj60tsn7I0/uKiS3ha4xShBte9RFp46bAkkWn
 RAcADwfZx+Enf+36Lm6UeJrwM8kKaEHOatA5io8nW2GUqpOrZbrGbz6tNFf5G4Koe8XFsTRW
 elEawBkY0GVC/FIEg5HVM1h9AuyvVH7cjtFuBeWqLAx7mz70gN8yv7uPcDTd9jMQt9a9m6dp
 2TJ+EzjDx0aPcDZwj2AmlqugevUlAvhVY4SHaH+/flv6HWawmEDARsaWEH9uvm4kU69WtR3L
 00S5zporK4u+UjtRd74NzW+qXuErwMaVPJTHvc85QXLzbDbiy6QDW0JZj1MctorsIkxXzNC/
 keEg97zFxRutrOPQH6Q/7vSqim9UQAQJHUBIzUZUQ8M5dXLqZs2yBnIS75e/LWdlNb5H3T7x
 CqH6XR4jLQIhslN3KK+lbzav96yjqPmDTMc4R76YjPm5B5HfIGcX5G6w2GOuJ6sM72lokm9U
 GkswpbEtb1eU8nSyERhU81WRuD1uK3t3Cn0xA8xQMF7p1xB7lb6JdgIiAySMnuFJSrtldXBW
 k7YuQpL6IRUOhNGhocoPtrhUqzGIUUcfOkJu9jOZdZIJ5N2bgLCoEmChHJ8PUiwzSDAcolmZ
 P93lPpA6l5BUsxaIMKeHbt17FPS7nlWKZnvqXXHI/KPj+P2iJm9F+5tDbdyRrpRAF6s+V+Mq
 I8Pa6NmNT0CALWWjtbrHX47dABWcidT6WHegM1MfenLGRt9BGwkEJfsLUAJKtE7xf8M/tokC
 kqVBx4DoHKi1CKvFOl/Qi06AF8Zdc0n/SxT0O1FFQvA5kXPlq7/vf9DKMNvJedPGS4K5accc
 sTpsv6oWpxnIgkrMRxEBXUhhOSOrCiWuD8=
IronPort-HdrOrdr: A9a23:uL652KC64vNRIIDlHem555DYdb4zR+YMi2TDsHoBKyC9Hfb3qy
 nDppkmPHzP+VUssQ8b+OxoUZPoKRi3yXcf2+Ys1NmZMDUOwFHJEGmnhrGSpwEJ3EbFh4tg6Z
 s=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,319,1613433600"; 
   d="scan'208";a="743484774"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 24 May 2021 11:15:14 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 14OBFEIT002464
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 May 2021 11:15:14 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 2EFD8CC1251; Mon, 24 May 2021 04:15:14 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v8 1/3] perf report: compile tips.txt in perf binary
Date:   Mon, 24 May 2021 04:15:12 -0700
Message-Id: <20210524111514.65713-1-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
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

