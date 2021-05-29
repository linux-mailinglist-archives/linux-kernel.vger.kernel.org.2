Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515A0394E00
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhE2UEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhE2UD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:03:56 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23901C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j75so7948254oih.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSjPAwiLxbB3rBNyB6a3O1R3irr6QlJGKjCkFZ8lCoQ=;
        b=VrFSF9uSJT+DjyMCucP0D+zmycLt/8fTrgG6JKw/VZv5kgiU6Fb2s1LvsvvvERnh85
         EZOS8pcNUoqkuD3ku1zF8KwZb5p5jw/rQHVq5ga+Ezdr+XWFbrjd34Jp6nRjwDU7sfek
         LMRDUY0LJMr4sh0oxedgIoFuZZrop7ftmttEk5bE8dC0RWAgKDlJ89u1KYoOKXdjbaDu
         ftwsgIgXjTcjlUhaf7x0LC8XZ+HoB6N9FC+mrA9gnOmNBH2vUn8RgMKqOXvvtx9LsfsI
         E45rxdpehDiDfJo5UJgduelmfFAAjWOggQI+Ut+XWgl8R4y5fCIhrROJQLyFIBvOA504
         Wpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSjPAwiLxbB3rBNyB6a3O1R3irr6QlJGKjCkFZ8lCoQ=;
        b=Y/lbyxubQ7SvpRi20usI8M8j25CcSyPKdqTt5IHmG3AViPr1w8niFeVIl0U1ny76gC
         meeiZQsaQ5somTNmxqZld48ATV474ahnApwIFJn5pJDKqxgkH0UwAboOX+LRwnAB6Ced
         /1E2UNNIftoAMhqFXoALhn4N8uaGb+ITREtw4LkJsPivkyYXUkVIJXqg4efczyIEOyLM
         s3BUoKhYcVd2znO/qkFzpWjl4/bfdAlH/zRWuZOb8UXcBAqWCY25BgcNorXeeHnRqiM9
         KusjGTNgh82dlXcnl3B7BEuH1lwk+W0ZjEgsDbhHT7rauk+PWEPWc5EzrAHgOZysg74A
         wB4w==
X-Gm-Message-State: AOAM5310W7RJnogdjukUzfgQFpUGliuWaivvlNnt5visRNcGhiY5oN94
        PhxaNk4jTMfouqpsSpbE/go=
X-Google-Smtp-Source: ABdhPJxyWRb0mcALkMjXKSUlYLhZ+ePwYJSZF5oXAoVEBYhqUkmUCQrPKcyxjMSlDqDKmcRo2pYVLA==
X-Received: by 2002:a05:6808:a10:: with SMTP id n16mr13191011oij.71.1622318537453;
        Sat, 29 May 2021 13:02:17 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:17 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 04/34] dyndbg: split struct _ddebug's display fields to new _ddebug_site
Date:   Sat, 29 May 2021 13:59:59 -0600
Message-Id: <20210529200029.205306-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate 3 fields: module, function, file into a new struct _ddebug_site.
These reflect the code's hierarchy, and are inherently ordered by the
compile/link; they exhibit 90%,55%,45% repetition (on my fedora based,
localmodconfig'd, virtme-configkernel --update'd conf).

Since struct _ddebugs are placed in their own elf section, this means
splitting its section also.  The new section is named "__dyndbg_sites"
(the plural name conveys the vector nature of the contents), and
"__dyndbg" is renamed "__dyndbgs" to reinforce this.

Struct _ddebug gets a new .site, pointing to a struct _ddebug_site.
The new ptr increases memory footprint, but it is temporary
scaffolding; once we can map from _ddebugs[N] --> _ddebug_sites[N]
indirectly, we can drop site pointer, regaining worst case memory
parity with master.

The indirection gives several advantages:

- site ptr lets us decouple the 2 arrays
  we can properly isolate dependencies by allowing null site

- the moved display fields are inherently hierarchical, and the linker
  section is ordered; so (module, file, function) have repeating
  values (90%, 85%, 45%).  This is readily compressible, even with a
  simple field-wise run length encoding.  Since I'm splitting the struct,
  I also reordered the fields to match the hierarchy.

- the separate linker section sets up naturally for block compression.
  section compression at build time is practical - how ?
  include/linux/decompress/generic.h has no corresponding compression

- we could drop sites and their storage opportunistically.
  this could reduce per-site mem by 24/56.

  Subsystems may not need/want "module:func:line:" in their logs.
  If they already use format-prefixes such as "drm:kms:",
  they can select on those, and don't need the site info for that.
  forex:
  #> echo module drm format "^drm:kms: " +p >control
  ie: dynamic_debug_exec_queries("format '^drm:kms: '", "drm");

Once we can map: ddebugs[N] -> ddebug_sites[N], we can:

- compress __dyndbg_sites during __init, and mark section __initdata
- store the compressed block instead.
- decompress on-demand, stream for `cat control`
- save chunks of decompressed buffer for enabled callsites
- free chunks on site disable, or on memory pressure.

Whats actually done here is ths rather mechanical, and preparatory.

dynamic_debug.h:

I cut struct _ddebug in half, renamed the optional top-half to
_ddebug_site, kept __align(8) for both halves.  I added a forward decl
for a unified comment for both head & body, and added _ddebug.site to
point at body.

DEFINE_DYNAMIC_DEBUG_METADATA now declares and initializes a 2nd
static struct var holding the _ddebug_site, and refs _ddebug to it.

dynamic_debug.c:

dynamic_debug_init() mem-usage now also counts sites.

dynamic_emit_prefix() & ddebug_change() use those moved fields; they
get a new initialized auto-var, and the field refs get adjusted as
needed to follow the field moves from one struct to the other.

   struct _ddebug_site *dc = dp->site;

ddebug_proc_show() differs slightly; it assigns to (not initializes)
the autovar, to avoid a panic when p == SEQ_START_TOKEN.

vmlinux.lds.h:

1st, move the original set of __dyndbg___start|stop directives into a
new macro; this puts a name (and a block of blamelog) on this and
future changes.  Also, since compressed elf sections are supported,
maybe we can use it on our "__dyndbg_sites" section; the macro better
isolates the items involved in such a move.

Then add in new "__dyndbg_sites" section and its start|stop symbols.

I kept the same align(8) and KEEP as used in the "__dyndbgs" section,
but I think this can be relaxed; I suspect the align is there for the
static-key member, which has state encoded in 2 LSBs, and _ddebug_site
doesnt have a key.  That said, I dont think anything is gained by
changing.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 22 +++++++++++-----
 include/linux/dynamic_debug.h     | 37 +++++++++++++++++---------
 kernel/module.c                   |  2 +-
 lib/dynamic_debug.c               | 44 ++++++++++++++++++-------------
 4 files changed, 66 insertions(+), 39 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0331d5d49551..f4e861282ed7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -335,6 +335,20 @@
 	KEEP(*(.dtb.init.rodata))					\
 	__dtb_end = .;
 
+/* implement dynamic printk debug */
+#if defined(CONFIG_DYNAMIC_DEBUG) || defined(CONFIG_DYNAMIC_DEBUG_CORE)
+#define DYNAMIC_DEBUG_DATA()						\
+	. = ALIGN(8);							\
+	__start___dyndbg_sites = .;					\
+	KEEP(*(__dyndbg_sites))						\
+	__stop___dyndbg_sites = .;					\
+	__start___dyndbg = .;						\
+	KEEP(*(__dyndbgs))						\
+	__stop___dyndbg = .;
+#else
+#define DYNAMIC_DEBUG_DATA()
+#endif
+
 /*
  * .data section
  */
@@ -351,12 +365,8 @@
 	__end_once = .;							\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	__start___dyndbg = .;						\
-	KEEP(*(__dyndbg))						\
-	__stop___dyndbg = .;						\
-	LIKELY_PROFILE()		       				\
+	DYNAMIC_DEBUG_DATA()						\
+	LIKELY_PROFILE()						\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dce631e678dd..130d5b36e08e 100644
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
+	 * - decorate log messages per _ddebug.flags
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
@@ -49,8 +57,7 @@ struct _ddebug {
 		struct static_key_false dd_key_false;
 	} key;
 #endif
-} __attribute__((aligned(8)));
-
+} __aligned(8);
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
@@ -88,11 +95,15 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
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
+	__section("__dyndbgs") name = {				\
+		.site = &name##_site,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
diff --git a/kernel/module.c b/kernel/module.c
index 30479355ab85..592e71f9f99d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3331,7 +3331,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-	info->debug = section_objs(info, "__dyndbg",
+	info->debug = section_objs(info, "__dyndbgs",
 				   sizeof(*info->debug), &info->num_debug);
 
 	return 0;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ab8fc16911ae..691e43d58eef 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
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
@@ -586,12 +587,13 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
+	const struct _ddebug_site *desc = dp->site;
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (dp->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -599,15 +601,15 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
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
@@ -884,6 +886,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
+	struct _ddebug_site *dc;
 	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
@@ -892,9 +895,11 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
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
@@ -1097,17 +1102,17 @@ static int __init dynamic_debug_init(void)
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
@@ -1117,9 +1122,10 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg section\n",
+	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d KiB in __dyndbg section, %d KiB in __dyndbg_sites section\n",
 		 entries, modct, (int)((modct * sizeof(struct ddebug_table)) >> 10),
-		 (int)((entries * sizeof(struct _ddebug)) >> 10));
+		 (int)((entries * sizeof(struct _ddebug)) >> 10),
+		 (int)((entries * sizeof(struct _ddebug_site)) >> 10));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.31.1

