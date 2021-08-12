Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77B3EA7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbhHLPvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237013AbhHLPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:50:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652B860E93;
        Thu, 12 Aug 2021 15:50:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mECyU-003ths-8r; Thu, 12 Aug 2021 11:50:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v2 1/2] libtracefs: Add random number to keep synthetic variables unique
Date:   Thu, 12 Aug 2021 11:50:28 -0400
Message-Id: <20210812155029.929048-2-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812155029.929048-1-rostedt@goodmis.org>
References: <20210812155029.929048-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The 'hist' triggers expect that all variables are unique. If two synthetic
events are created, it is possible that they will use the same variable
names, and this can break the logic for synthetic events. Add a random
number to the argument names that will help prevent that from happening.
There's no guarantee that there wont be collisions, but the chances of
that happening is 1 in 32768. If this is a problem, we could possibly look
for variables that are already in use.

Link: https://lore.kernel.org/linux-trace-devel/20210812005546.910833-2-rostedt@goodmis.org/

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 src/tracefs-hist.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/src/tracefs-hist.c b/src/tracefs-hist.c
index 7f9cf3820611..9de70579a871 100644
--- a/src/tracefs-hist.c
+++ b/src/tracefs-hist.c
@@ -13,6 +13,8 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <sys/time.h>
+#include <sys/types.h>
 
 #include "tracefs.h"
 #include "tracefs-local.h"
@@ -558,6 +560,7 @@ struct tracefs_synth {
 	unsigned int		end_parens;
 	unsigned int		end_state;
 	int			*start_type;
+	char			arg_name[16];
 	int			arg_cnt;
 };
 
@@ -951,13 +954,31 @@ int tracefs_synth_add_match_field(struct tracefs_synth *synth,
 	return -1;
 }
 
+static unsigned int make_rand(void)
+{
+	struct timeval tv;
+	unsigned long seed;
+
+	gettimeofday(&tv, NULL);
+	seed = (tv.tv_sec + tv.tv_usec) + gettid();
+
+	/* taken from the rand(3) man page */
+	seed = seed * 1103515245 + 12345;
+	return((unsigned)(seed/65536) % 32768);
+}
+
 static char *new_arg(struct tracefs_synth *synth)
 {
 	int cnt = synth->arg_cnt + 1;
 	char *arg;
 	int ret;
 
-	ret = asprintf(&arg, "__arg__%d", cnt);
+	/* Create a unique argument name */
+	if (!synth->arg_name[0]) {
+		/* make_rand() returns at most 32768 (total 13 bytes in use) */
+		sprintf(synth->arg_name, "__arg_%u_", make_rand());
+	}
+	ret = asprintf(&arg, "%s%d", synth->arg_name, cnt);
 	if (ret < 0)
 		return NULL;
 
-- 
2.30.2

