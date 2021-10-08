Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01143426CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242787AbhJHOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242698AbhJHOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633704549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=esSNc2qnd5aPNAP91qJWefw1R8AxJUeu2dYjPboEMLA=;
        b=hd05lTKSb2CDavBpYQ6cKMYihyrCdRAyyWZMdQZJNbnQ9Iewc5pMJZO5cxadmAWC51MhCi
        EvMxRD5B4VMSQMeSycIOit2o0CGUmZ3NVlDIpNQGfjv3xZ1ulQMoru++HgDSYTpEH/gCbN
        5uj/TqTYmTI/Dzjd9YN5LeNIT4dSXbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-uP2Mk12LNniEcESnmQ68ow-1; Fri, 08 Oct 2021 10:49:08 -0400
X-MC-Unique: uP2Mk12LNniEcESnmQ68ow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D41F5802C8F;
        Fri,  8 Oct 2021 14:49:06 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A36FD60BF1;
        Fri,  8 Oct 2021 14:48:52 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 533EA42A51C8; Fri,  8 Oct 2021 11:48:19 -0300 (-03)
Date:   Fri, 8 Oct 2021 11:48:19 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: [patch v4] util-linux: add chisol tool to configure task isolation
Message-ID: <20211008144819.GA4045@fuller.cnet>
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

To launch an unmodified application:

./chisol -q vmstat_sync -a -I active command args

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff -Nur util-linux.orig/configure.ac util-linux/configure.ac
--- util-linux.orig/configure.ac	2021-10-07 14:15:15.334935842 -0300
+++ util-linux/configure.ac	2021-10-05 15:11:54.197269076 -0300
@@ -2272,6 +2272,9 @@
 	[UL_CHECK_SYSCALL([sched_setattr])], [sched_setattr])
 AM_CONDITIONAL([BUILD_UCLAMPSET], [test "x$build_uclampset" = xyes])
 
+UL_ENABLE_ALIAS([chisol], [chisol])
+UL_BUILD_INIT([chisol])
+AM_CONDITIONAL([BUILD_CHISOL], [test "x$build_chisol" = xyes])
 
 AC_ARG_ENABLE([wall],
   AS_HELP_STRING([--disable-wall], [do not build wall]),
diff -Nur util-linux.orig/schedutils/chisol.c util-linux/schedutils/chisol.c
--- util-linux.orig/schedutils/chisol.c	1969-12-31 21:00:00.000000000 -0300
+++ util-linux/schedutils/chisol.c	2021-10-07 14:17:38.710937831 -0300
@@ -0,0 +1,304 @@
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
+	int ret;
+	unsigned int i, j;
+	unsigned long long feats = 0;
+
+	FILE *out = stdout;
+
+	/* Retrieve supported task isolation features */
+	ret = prctl(PR_ISOL_FEAT_GET, 0, &feats, 0, 0);
+	if (ret == -1) {
+		perror(_("prctl PR_ISOL_FEAT_GET"));
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < 16; i++) {
+		if (feats & (1<<i)) {
+			char *fn;
+			unsigned long long featmask;
+			struct task_isol_quiesce_extensions qext;
+
+			fn = featname(1<<i, featnames, sizeof(featnames)/SSZ);
+
+			fprintf(out, "%s: ", fn);
+			free(fn);
+
+			if (i != 0)
+				continue;
+
+			ret = prctl(PR_ISOL_FEAT_GET, (1<<i), &qext, 0, 0);
+			if (ret == -1) {
+				perror(_("prctl PR_ISOL_FEAT_GET"));
+				exit(EXIT_FAILURE);
+			}
+
+			featmask = qext.supported_quiesce_bits;
+			for (j = 0; j < 16; j++) {
+				if (featmask & (1<<j)) {
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
+	unsigned long long quiesce_act_mask = 0;
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
+		struct task_isol_quiesce_control qctrl;
+
+		qctrl.quiesce_mask = quiesce_act_mask;
+		ret = prctl(PR_ISOL_CFG_SET, I_CFG_FEAT, ISOL_F_QUIESCE, &qctrl, 0);
+		if (ret == -1) {
+			perror("prctl PR_ISOL_CFG_SET");
+			exit(EXIT_FAILURE);
+        	}
+	}
+
+	if (activate && quiesce_act_mask) {
+		unsigned long long activate_mask = ISOL_F_QUIESCE;
+
+		ret = prctl(PR_ISOL_ACTIVATE_SET, &activate_mask, 0, 0, 0);
+		if (ret == -1) {
+			perror("prctl PR_ISOL_ACTIVATE_SET (ISOL_F_QUIESCE)");
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
+		ret = prctl(PR_ISOL_CFG_SET, I_CFG_INHERIT, &i_ctrl, 0, 0);
+		if (ret == -1) {
+			perror("prctl PR_ISOL_CFG_SET (I_CFG_INHERIT)");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	argv += optind;
+	execvp(argv[0], argv);
+	errexec(argv[0]);
+
+	return EXIT_SUCCESS;
+}
+
diff -Nur util-linux.orig/schedutils/Makemodule.am util-linux/schedutils/Makemodule.am
--- util-linux.orig/schedutils/Makemodule.am	2021-10-07 14:15:15.334935842 -0300
+++ util-linux/schedutils/Makemodule.am	2021-10-05 15:11:54.199269088 -0300
@@ -29,3 +29,11 @@
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

