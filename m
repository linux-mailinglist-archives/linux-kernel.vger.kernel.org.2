Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DE33CCE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhCPFIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhCPFIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:21 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97775C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:21 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id p10so11565588ils.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXHCVis3Qaq4r8T5a1j1xyX2piqlLa2Fox5BS+PXNyk=;
        b=HqsqpjYGv3Qly1qz90+O3OleJZTxQYRWp/cXhVr9fMNQrb72aT4KHHcO4BeM+gsn7P
         8wTxx2r09YEdk2irXO4LyT9TJjNsSEQNhnXQp0/xFZJFz2n1GQgnvJXZAAs5rAe2Cwvb
         6sS2uP4GklIksR9YNhJ03IK7+EzCXNkTy0CHCX942f4XOR627w5e2djKq/7Io1w095lF
         JNLAO8HbxqyTQSEqizB41irwk+5goKVOO1ZQ32LY/qClOcrGbCsJSScPj7EQn0Kj8boO
         EVuZ/haBNB+fyHzx9r34BEwyjB3qcz4EwY7NFSz2cq4zTzHzGYc03HtkHjGzX7Q+EfSz
         jC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXHCVis3Qaq4r8T5a1j1xyX2piqlLa2Fox5BS+PXNyk=;
        b=Oj9Pd3FO7R2KxRui0jaopJ0yQJsLc/IgKzMqj3aJN+yCXbir1vnw9ZPg6q6tnqh0dv
         ZcRVAconDEwZmREfjnvvACEFJb5usGHFSt9DkII3mw5VHaPmjZz7NVIY8jKpQR6CjPF/
         W5bcD8uAnGM6GmW379t5OOtijF2NJbYl1kmEsLR01IoA86LHSgD/rr5q6dCPc0mgWCaF
         uAUXieZiEFRWBYUCBQlCiSMPOwl9uMNFUePppdeyjLPrxanrdeBYYStlkouoFLo6O0k+
         Qai938107U60Ncie4SPmODWtq1wtqoFkbZswz5r3bB4Ji6o8XG/Hct0rO4QFlXgs71mk
         Q1jQ==
X-Gm-Message-State: AOAM5301KRAZejCC37k28y+p6+3sqAvyUvpq3+edGlHIhtTFE0/7k94P
        W7EJ3pVXGue2R4HzeG/WqmpFwV6K5wC0ww==
X-Google-Smtp-Source: ABdhPJyBQQnFY/4yoWYseQP2zJurKRz/6Um3602Tg7+eObmi50ZOgQoESDX53Zg+lP0e67PoQtssew==
X-Received: by 2002:a92:194a:: with SMTP id e10mr2413497ilm.213.1615871300982;
        Mon, 15 Mar 2021 22:08:20 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 01/18] dyndbg: split struct _ddebug, move display fields to new _ddebug_site
Date:   Mon, 15 Mar 2021 23:07:44 -0600
Message-Id: <20210316050801.2446401-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct _ddebug has 2 flavors of fields: essential and optional.  Split
the 3 optional fields: module, function, file into a new struct
_ddebug_site, and add pointer to it from _ddebug.

These fields are optional in that they are primarily used to generate
the optional "module:func:line" log prefix.  They're also used to
select callsites to >control.  lineno is arguably optional too, but
leaving it uses spare bytes in struct _ddebug.

The new ptr increases memory footprint by 1 ptr per pr_debug, but I
think its temporary, and the indirection gives several advantages:

- we can drop sites and their storage opportunistically.
  this reduces per-site mem by 24/64.

  Subsystems may not need/want "module:func:line:" in their logs.
  If they already use format-prefixes such as "drm:kms:",
  they can select on those, and don't need the site info for that.
  forex:
  #> echo module drm format "^drm:kms: " +p >control
  ie: dynamic_debug_exec_queries("format '^drm:kms: '", "drm");

- the moved display fields are inherently hierarchical, and the linker
  section is ordered; so (module, file, function) have repeating
  values (90%, 85%, 45%).  This is readily compressible, even with a
  simple field-wise run length encoding.  Since I'm splitting the struct,
  I also reordered the fields to match the hierarchy.

- the separate linker section sets up naturally for block compression.

IFF we can on-demand map:  ddebugs[N] -> ddebug_sites[N]

- we can compress __dyndbg_sites during __init, and mark section __initdata

- can decompress on-demand, say for `cat control`
- can save chunks of decompressed buffer for enabled callsites
- free chunks on site disable, or on memory pressure.

Whats actually done here is rather mechanical, and preparatory.

dynamic_debug.h:

I cut struct _ddebug in half, renamed optional top-half to
_ddebug_site, kept __align(8) for both halves.  I added a forward decl
for a unified comment for both head & body, and added head.site to
point at body.

DECLARE_DYNAMIC_DEBUG_METADATA does the core of the work; it declares
and initializes both static struct variables together, and refs one to
the other.

dynamic_debug.c:

dynamic_debug_init() mem-usage now also counts sites.

dynamic_emit_prefix() & ddebug_change() use those moved fields; they
get a new initialized auto-var, and the field refs get adjusted as
needed to follow the move from one struct to the other.

   struct _ddebug_site *dc = dp->site;

ddebug_proc_show() differs slightly; it assigns to (not initializes)
the autovar, to avoid a panic when p == SEQ_START_TOKEN.

vmlinux.lds.h:

add __dyndbg_sites section, with the same align(8) and KEEP as
used in the __dyndbg section.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  3 ++
 include/linux/dynamic_debug.h     | 37 ++++++++++++++++---------
 lib/dynamic_debug.c               | 46 +++++++++++++++++--------------
 3 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0331d5d49551..4f2af9de2f03 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -353,6 +353,9 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
+	__start___dyndbg_sites = .;					\
+	KEEP(*(__dyndbg_sites))					\
+	__stop___dyndbg_sites = .;					\
 	__start___dyndbg = .;						\
 	KEEP(*(__dyndbg))						\
 	__stop___dyndbg = .;						\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a57ee75342cf..bc8027292c02 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -7,20 +7,28 @@
 #endif
 
 /*
- * An instance of this structure is created in a special
- * ELF section at every dynamic debug callsite.  At runtime,
- * the special section is treated as an array of these.
+ * A pair of these structs are created in 2 special ELF sections
+ * (__dyndbg, __dyndbg_sites) for every dynamic debug callsite.
+ * At runtime, the sections are treated as arrays.
  */
-struct _ddebug {
+struct _ddebug;
+struct _ddebug_site {
 	/*
-	 * These fields are used to drive the user interface
-	 * for selecting and displaying debug callsites.
+	 * These fields (and lineno) are used to:
+	 * - decorate log messages per site flags
+	 * - select callsites for modification via >control
+	 * - display callsites & settings in `cat control`
 	 */
 	const char *modname;
-	const char *function;
 	const char *filename;
+	const char *function;
+} __aligned(8);
+
+struct _ddebug {
+	struct _ddebug_site *site;
+	/* format is always needed, lineno shares word with flags */
 	const char *format;
-	unsigned int lineno:18;
+	const unsigned lineno:18;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -44,8 +52,7 @@ struct _ddebug {
 		struct static_key_false dd_key_false;
 	} key;
 #endif
-} __attribute__((aligned(8)));
-
+} __aligned(8);
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
@@ -83,11 +90,15 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const char *fmt, ...);
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
-	static struct _ddebug  __aligned(8)			\
-	__section("__dyndbg") name = {				\
+	static struct _ddebug_site  __aligned(8)		\
+	__section("__dyndbg_sites") name##_site = {		\
 		.modname = KBUILD_MODNAME,			\
-		.function = __func__,				\
 		.filename = __FILE__,				\
+		.function = __func__,				\
+	};							\
+	static struct _ddebug  __aligned(8)			\
+	__section("__dyndbg") name = {				\
+		.site = &name##_site,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c70d6347afa2..738c4ce28046 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -142,7 +142,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
- * callsites, normally the same as number of changes.  If verbose,
+ * sites, normally the same as number of changes.  If verbose,
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
@@ -165,19 +165,20 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
+			struct _ddebug_site *dc = dp->site;
 
 			/* match against the source filename */
 			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
+			    !match_wildcard(query->filename, dc->filename) &&
 			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
+					   kbasename(dc->filename)) &&
 			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
+					   trim_prefix(dc->filename)))
 				continue;
 
 			/* match against the function */
 			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
+			    !match_wildcard(query->function, dc->function))
 				continue;
 
 			/* match against the format */
@@ -214,8 +215,8 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			dp->flags = newflags;
 			v2pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
+				 trim_prefix(dc->filename), dp->lineno,
+				 dt->mod_name, dc->function,
 				 ddebug_describe_flags(dp->flags, &fbuf));
 		}
 	}
@@ -586,14 +587,15 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
+	const struct _ddebug_site *desc = dp->site;
 
 	*buf = '\0';
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (dp->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -601,15 +603,15 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+	if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+	if (dp->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->function);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+	if (dp->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
-				desc->lineno);
+				dp->lineno);
 	if (pos - pos_after_tid)
 		pos += snprintf(buf + pos, remaining(pos), " ");
 	if (pos >= PREFIX_SIZE)
@@ -879,6 +881,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
+	struct _ddebug_site *dc;
 	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
@@ -887,9 +890,11 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
+	dc = dp->site;
+
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   trim_prefix(dc->filename), dp->lineno,
+		   iter->table->mod_name, dc->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
@@ -1093,17 +1098,17 @@ static int __init dynamic_debug_init(void)
 		return 0;
 	}
 	iter = __start___dyndbg;
-	modname = iter->modname;
+	modname = iter->site->modname;
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		if (strcmp(modname, iter->modname)) {
+		if (strcmp(modname, iter->site->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
 			if (ret)
 				goto out_err;
 			n = 0;
-			modname = iter->modname;
+			modname = iter->site->modname;
 			iter_start = iter;
 		}
 		n++;
@@ -1113,9 +1118,10 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section, %d bytes in __dyndbg_sites section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 (int)(entries * sizeof(struct _ddebug)));
+		 (int)(entries * sizeof(struct _ddebug)),
+		 (int)(entries * sizeof(struct _ddebug_site)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.29.2

