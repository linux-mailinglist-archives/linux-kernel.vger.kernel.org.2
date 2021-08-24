Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC23F61F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhHXPrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238469AbhHXPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629819979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sRTtj7soYKz+ErBezLHxKBD2FHdlpZpwJnJfiry7FNI=;
        b=VcumqYKDDHmwJk08I9sFNDfgnQvgGQKUR2bXyiDGCrRQTLf4lq0j/9UxKdf8ORhDnBZy61
        frj1OjtsVAacnULtSjQQeMZFWqCEy4Q/E2kL/SIors+8j5aQKzxC06fkhT2sRIsrHOFj57
        mrDSp/1e4zDO9g83MJF51fBY7hJFCIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-OPeFlpI9NTOKMuLbT81NCw-1; Tue, 24 Aug 2021 11:43:24 -0400
X-MC-Unique: OPeFlpI9NTOKMuLbT81NCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 822D787D550;
        Tue, 24 Aug 2021 15:43:09 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BCB460C05;
        Tue, 24 Aug 2021 15:43:03 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 3261E416D8BC; Tue, 24 Aug 2021 12:42:55 -0300 (-03)
Date:   Tue, 24 Aug 2021 12:42:55 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: util-linux: add chisol tool to configure task isolation
Message-ID: <20210824154255.GA105413@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add chisol tool to configure task isolation. See chisol -h 
for details.

For example, to launch a version of oslat that activates 
task isolation:  

chisol -q vmstat_sync -I conf ./oslat -f 1 -c 5 -D 5m

-q vmstat_sync: enable quiescing of per-CPU vmstats 
-I conf: inherit task isolation configuration.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: util-linux/schedutils/chisol.c
===================================================================
--- /dev/null
+++ util-linux/schedutils/chisol.c
@@ -0,0 +1,294 @@
+/*
+ * chisol.c - change task isolation parameters
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Copyright (C) 2021 Marcelo Tosatti <mtosatti@redhat.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <errno.h>
+#include <sched.h>
+#include <stddef.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+#include <errno.h>
+
+#include "nls.h"
+#include "strutils.h"
+#include "xalloc.h"
+#include "procutils.h"
+#include "c.h"
+#include "closestream.h"
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	FILE *out = stdout;
+	fprintf(out,
+		_("Usage: %s [options] cmd [args...]]\n\n"),
+		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Change task isolation parameters.\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+
+	fprintf(out, _(
+		"Options:\n"
+		" -q, --quiesce      configure quiescing of particular activities\n"
+		"                    (to list supported activities see --info)\n"
+		" -i, --info         show supported task isolation features\n"
+		" -a, --activate     activate isolation before exec\n"
+		" -I, --inherit      set inheritance across fork/exec.\n"
+		" 		     Two modes are available: conf, where only task\n"
+		"		     isolation configuration is inherited, or active,\n"
+		"		     where configuration and activation are inherited.\n"
+		));
+	printf(USAGE_HELP_OPTIONS(20));
+
+	fputs(USAGE_SEPARATOR, out);
+	fprintf(out, _(
+		"Configure task isolation and run a new command:\n"
+		"    %1$s -q vmstat_sync cmd\n"
+		"Configure, activate task isolation and run a new command:\n"
+		"    %1$s -a -q vmstat_sync cmd\n"
+		"To query the supported task isolation features:\n"
+		"    %1$s -i\n"),
+		program_invocation_short_name);
+
+	printf(USAGE_MAN_TAIL("chisol(1)"));
+	exit(EXIT_SUCCESS);
+}
+
+struct isol_feat_name {
+	int val;
+	char *name;
+};
+
+struct isol_feat_name featnames[] = {
+	{ ISOL_F_QUIESCE, "quiesce" },
+};
+
+struct isol_feat_name qfeatnames[] = {
+	{ ISOL_F_QUIESCE_VMSTATS, "vmstat_sync" },
+};
+
+#define SSZ sizeof(struct isol_feat_name)
+
+static char *featname(int val, struct isol_feat_name *fnames,
+		      unsigned int nrentries)
+{
+	unsigned int i;
+	char *name;
+
+	for (i = 0; i < nrentries; i++) {
+		struct isol_feat_name *f = &fnames[i];
+
+		if (f->val == val)
+			return strdup(f->name);
+	}
+
+	name = malloc(100);
+	snprintf(name, 100, "0x%x\n", val);
+
+	return name;
+}
+
+static void __attribute__((__noreturn__)) task_isol_info(void)
+{
+	int ret, feats;
+	unsigned int i, j;
+
+	FILE *out = stdout;
+
+	/* Retrieve supported task isolation features */
+	ret = prctl(PR_ISOL_FEAT, 0, 0, 0, 0);
+	if (ret == -1) {
+		perror(_("prctl PR_ISOL_FEAT"));
+		exit(EXIT_FAILURE);
+	}
+	feats = ret;
+
+	for (i = 0; i < 16; i++) {
+		if (feats & (1<<i)) {
+			char *fn;
+
+			fn = featname(1<<i, featnames, sizeof(featnames)/SSZ);
+
+			fprintf(out, "%s: ", fn);
+			free(fn);
+
+			ret = prctl(PR_ISOL_FEAT, (1<<i), 0, 0, 0);
+			if (ret == -1) {
+				perror(_("prctl PR_ISOL_FEAT"));
+				exit(EXIT_FAILURE);
+			}
+
+			for (j = 0; j < 16; j++) {
+				if (ret & (1<<j)) {
+					fn = featname(1<<j, qfeatnames,
+						      sizeof(qfeatnames)/SSZ);
+					fprintf(out, "%s ", fn);
+					free(fn);
+				}
+			}
+		}
+	}
+
+	fprintf(out, "\n");
+	exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	int c, ret, activate = 0;
+	short int inherit_mask = 0;
+	unsigned long quiesce_act_mask = 0;
+	char *subopts;
+	char *value;
+
+	static const struct option longopts[] = {
+		{ "quiesce",	required_argument, NULL, 'q' },
+		{ "info",	no_argument, 	   NULL, 'i' },
+		{ "inherit",	required_argument, NULL, 'I' },
+		{ "activate",	no_argument,	   NULL, 'a' },
+		{ "help",	no_argument,	   NULL, 'h' },
+		{ "version",	no_argument,	   NULL, 'V' },
+		{ NULL,		no_argument,       NULL,  0  }
+	};
+
+	enum {
+		VMSTAT_SYNC_OPT = 0,
+	};
+	char *const token[] = {
+		[VMSTAT_SYNC_OPT]   = "vmstat_sync",
+		NULL
+	};
+
+	enum {
+		INHERIT_CONF = 0,
+		INHERIT_ACTIVE,
+
+	};
+	char *const itoken[] = {
+		[INHERIT_CONF]   = "conf",
+		[INHERIT_ACTIVE] = "active",
+		NULL
+	};
+
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
+
+	while ((c = getopt_long(argc, argv, "+q:I:iahV", longopts, NULL)) != -1) {
+	switch (c) {
+		case 'q':
+			subopts = optarg;
+			while (*subopts != '\0') {
+				switch (getsubopt(&subopts, token, &value)) {
+					case VMSTAT_SYNC_OPT:
+						quiesce_act_mask |=
+							ISOL_F_QUIESCE_VMSTATS;
+						break;
+					default:
+						fprintf(stderr, "Unknown "
+							"quiesce activity "
+							"/%s/\n", value);
+						errtryhelp(EXIT_FAILURE);
+						break;
+				}
+			}
+			break;
+		case 'I':
+			subopts = optarg;
+			while (*subopts != '\0') {
+				switch (getsubopt(&subopts, itoken, &value)) {
+					case INHERIT_CONF:
+						inherit_mask |= ISOL_INHERIT_CONF;
+						break;
+					case INHERIT_ACTIVE:
+						inherit_mask |= ISOL_INHERIT_CONF;
+						inherit_mask |= ISOL_INHERIT_ACTIVE;
+						break;
+					default:
+						fprintf(stderr, "Unknown "
+							"inheritance "
+							"/%s/\n", value);
+						errtryhelp(EXIT_FAILURE);
+						break;
+				}
+			}
+			break;
+		case 'i':
+			task_isol_info();
+			break;
+		case 'a':
+			activate = 1;
+			break;
+		case 'V':
+			print_version(EXIT_SUCCESS);
+		case 'h':
+			usage();
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
+	}
+
+	if (argc - optind < 1) {
+		warnx(_("bad usage"));
+		errtryhelp(EXIT_FAILURE);
+	}
+
+	if (quiesce_act_mask) {
+		ret = prctl(PR_ISOL_SET, ISOL_F_QUIESCE, quiesce_act_mask, 0, 0);
+		if (ret == -1) {
+			perror("prctl PR_ISOL_SET");
+			exit(EXIT_FAILURE);
+        	}
+	}
+
+	if (activate && quiesce_act_mask) {
+		ret = prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE, 0, 0, 0);
+		if (ret == -1) {
+			perror("prctl PR_ISOL_CTRL_SET (ISOL_F_QUIESCE)");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	if (inherit_mask != 0) {
+		struct task_isol_inherit_control i_ctrl;
+
+		memset(&i_ctrl, 0, sizeof(i_ctrl));
+		i_ctrl.inherit_mask = inherit_mask;
+
+		ret = prctl(PR_ISOL_INT_SET, INHERIT_CFG, &inherit_mask, 0, 0);
+		if (ret == -1) {
+			perror("prctl PR_ISOL_INT_SET");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+
+	argv += optind;
+	execvp(argv[0], argv);
+	errexec(argv[0]);
+
+	return EXIT_SUCCESS;
+}
+
Index: util-linux/configure.ac
===================================================================
--- util-linux.orig/configure.ac
+++ util-linux/configure.ac
@@ -2272,6 +2272,9 @@ UL_REQUIRES_SYSCALL_CHECK([uclampset],
 	[UL_CHECK_SYSCALL([sched_setattr])], [sched_setattr])
 AM_CONDITIONAL([BUILD_UCLAMPSET], [test "x$build_uclampset" = xyes])
 
+UL_ENABLE_ALIAS([chisol], [chisol])
+UL_BUILD_INIT([chisol])
+AM_CONDITIONAL([BUILD_CHISOL], [test "x$build_chisol" = xyes])
 
 AC_ARG_ENABLE([wall],
   AS_HELP_STRING([--disable-wall], [do not build wall]),
Index: util-linux/schedutils/Makemodule.am
===================================================================
--- util-linux.orig/schedutils/Makemodule.am
+++ util-linux/schedutils/Makemodule.am
@@ -29,3 +29,11 @@ dist_noinst_DATA += schedutils/uclampset
 uclampset_SOURCES = schedutils/uclampset.c schedutils/sched_attr.h
 uclampset_LDADD = $(LDADD) libcommon.la
 endif
+
+if BUILD_CHISOL
+usrbin_exec_PROGRAMS += chisol
+#MANPAGES += schedutils/chisol.1
+#dist_noinst_DATA += schedutils/chisol.1.adoc
+chisol_SOURCES = schedutils/chisol.c
+chisol_LDADD = $(LDADD) libcommon.la
+endif

