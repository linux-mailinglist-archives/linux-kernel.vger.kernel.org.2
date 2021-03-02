Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9503F32A56B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446930AbhCBMl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243409AbhCBL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:59:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADDCC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 03:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=amDxSuZONZicXwjqp/yYEsbNlJXQfnfYrOIF0hd3olo=; b=oHn64Qs5vxoebhIkjXNLDy8aUZ
        aD+G/V2AEUOtI0i50fk9ZexCQ5J3IEwWSjW2oS7miy2QXzv/eEiEH2WA82gq6Pf8lNzgwqqekiLOP
        SnIa+3nzY2O82i+4DI8mxZtACWyHUbgSgy8IcnmGeV46qEWKO+BxgAQ/f9dHvcsCKN/+QOo2MzMZK
        DEjUpbBP6cylzwgfqDeC1pW8+NrP/x5Ii8q4AnLc7STNUxSMPa29uFK4G3Ka/YjrkVxg8IexF5mFr
        KVTs+wkQ7fIcJOO1eCJIkcmMFxxaH3PjmMATRQ+pK9U1BJikt44Ky1vTZ8M43B4hJumjzRnYfrs0e
        NHRn8bnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH3fk-00H3OS-U5; Tue, 02 Mar 2021 11:58:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD5AF30018A;
        Tue,  2 Mar 2021 12:58:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 982B72027C1AB; Tue,  2 Mar 2021 12:58:37 +0100 (CET)
Date:   Tue, 2 Mar 2021 12:58:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     jpoimboe@redhat.com, mbenes@suze.cz, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/3] objtool: Add --backup
Message-ID: <YD4obT3aoXPWl7Ax@hirez.programming.kicks-ass.net>
References: <20210226105742.844988140@infradead.org>
 <20210226110004.133170708@infradead.org>
 <20210226114819.GC19284@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226114819.GC19284@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:48:19PM +0100, Borislav Petkov wrote:
> Yah, as mentioned on IRC and let me paste it here too, you need to
> supply mode with O_CREAT:
> 
> 	d = open(name, O_CREAT|O_RDWR|O_TRUNC,S_IRUSR);
> 
> or so. Also you could add perror("open") to those error paths so that it
> can say why it failed creating the backup file.

Patch now reads like:

---
Subject: objtool: Add --backup
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Feb 26 10:59:59 CET 2021

Teach objtool to write backups files, such that it becomes easier to
see what objtool did to the object file.

Backup files will be ${name}bj, such that file.o becomes file.obj.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Borislav Petkov <bp@suse.de>
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
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount, noinstr;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
+     validate_dup, vmlinux, mcount, noinstr, backup;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -37,6 +38,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('n', "noinstr", &noinstr, "noinstr validation for vmlinux.o"),
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
 	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
+	OPT_BOOLEAN('B', "backup", &backup, "create .obj files before modification"),
 	OPT_END(),
 };
 
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -8,7 +8,8 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount, noinstr;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
+            validate_dup, vmlinux, mcount, noinstr, backup;
 
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
+		perror("failed backup name malloc");
+		return false;
+	}
+
+	strcpy(name, _objname);
+	strcpy(name + len, "bj");
+
+	d = open(name, O_CREAT|O_WRONLY|O_TRUNC, 0644);
+	if (d < 0) {
+		perror("failed to create backup file");
+		return false;
+	}
+
+	s = open(_objname, O_RDONLY);
+	if (s < 0) {
+		perror("failed to open orig file");
+		return false;
+	}
+
+	buf = malloc(4096);
+	if (!buf) {
+		perror("failed backup data malloc");
+		return false;
+	}
+
+	while ((l = read(s, buf, 4096)) > 0) {
+		base = buf;
+		do {
+			t = write(d, base, l);
+			if (t < 0) {
+				perror("failed backup write");
+				return false;
+			}
+			base += t;
+			l -= t;
+		} while (l);
+	}
+
+	if (l < 0) {
+		perror("failed backup read");
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
