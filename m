Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2191A3261B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBZLDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhBZLCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:02:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CEFC061786
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bMrEqdrhAB+jJXZ11FvsBJiwst1BEBG2pLVkBPy7dbE=; b=GidSRGfCkNGjwtRYgmJgvNbaaQ
        2NhDxrYAe3m3Sqx+6TxUm/RxLqMv1tFqKf4OtdMExFE5w/PNiIL/L09LspxzZRcf8P7gViXJ8EsV6
        VBz3hZxApF9pv4EXDD3+cckxwNn5+4iIDMNqzaDIW9HRrt+iIP/+F8oNIcffOiQAlC7vujSo0nOpb
        ReRrUPU36Tvd03d1yIm34b97jPvpmwB+GYjux+dKAz7bYhh1RmnlM6Xlzx2TIwvL/6sYhNqgAQklp
        fgcXpwpUART9lrp0P+S1wfVoIrqYtLuT1rOX6w49T799rWpSALqXUSBxzS2oyAo53wDdrZDYawbBS
        zDo4UxZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lFarU-00Btt1-Qq; Fri, 26 Feb 2021 11:00:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 739C8305C11;
        Fri, 26 Feb 2021 12:00:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5C89E2065B4A4; Fri, 26 Feb 2021 12:00:43 +0100 (CET)
Message-ID: <20210226110004.133170708@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Feb 2021 11:57:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     bp@alien8.de, jpoimboe@redhat.com, mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org
Subject: [PATCH 1/3] objtool: Add --backup
References: <20210226105742.844988140@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach objtool to write backups files, such that it becomes easier to
see what objtool did to the object file.

Backup files will be ${name}bj, such that file.o becomes file.obj.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c           |    4 +-
 tools/objtool/include/objtool/builtin.h |    3 +
 tools/objtool/objtool.c                 |   64 ++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -18,7 +18,8 @@
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
+bool validate_dup, vmlinux, backup;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -35,6 +36,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
 	OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
+	OPT_BOOLEAN('B', "backup", &backup, "create .obj files before modification"),
 	OPT_END(),
 };
 
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -8,7 +8,8 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
+extern bool validate_dup, vmlinux, backup;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -17,6 +17,7 @@
 #include <stdbool.h>
 #include <string.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <subcmd/exec-cmd.h>
 #include <subcmd/pager.h>
 #include <linux/kernel.h>
@@ -44,6 +45,64 @@ bool help;
 const char *objname;
 static struct objtool_file file;
 
+static bool objtool_create_backup(const char *_objname)
+{
+	int len = strlen(_objname);
+	char *buf, *base, *name = malloc(len+3);
+	int s, d, l, t;
+
+	if (!name) {
+		WARN("failed backup name malloc");
+		return false;
+	}
+
+	strcpy(name, _objname);
+	strcpy(name + len, "bj");
+
+	d = open(name, O_CREAT|O_WRONLY|O_TRUNC);
+	if (d < 0) {
+		WARN("failed to create backup file");
+		return false;
+	}
+
+	s = open(_objname, O_RDONLY);
+	if (s < 0) {
+		WARN("failed to open orig file");
+		return false;
+	}
+
+	buf = malloc(4096);
+	if (!buf) {
+		WARN("failed backup data malloc");
+		return false;
+	}
+
+	while ((l = read(s, buf, 4096)) > 0) {
+		base = buf;
+		do {
+			t = write(d, base, l);
+			if (t < 0) {
+				WARN("failed backup write");
+				return false;
+			}
+			base += t;
+			l -= t;
+		} while (l);
+	}
+
+	if (l < 0) {
+		WARN("failed backup read");
+		return false;
+	}
+
+	free(name);
+	free(buf);
+	close(d);
+	close(s);
+
+	return true;
+}
+
 struct objtool_file *objtool_open_read(const char *_objname)
 {
 	if (objname) {
@@ -59,6 +118,11 @@ struct objtool_file *objtool_open_read(c
 	if (!file.elf)
 		return NULL;
 
+	if (backup && !objtool_create_backup(objname)) {
+		WARN("can't create backup file");
+		return NULL;
+	}
+
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	INIT_LIST_HEAD(&file.static_call_list);


