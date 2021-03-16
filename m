Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A7733CCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhCPFJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhCPFIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:36 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E0BC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:35 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d5so11565247iln.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58uILiTmCwCiHE2A6E5zlptHTfRXOP4l3B07M2FVpzg=;
        b=M+EDiJXAegr9uZyyLGpBV++Db0VeG0uLCPIyOTQZKGxF/0UJUPGGmODGpvkHra4ZVw
         GaXg2f95LkNG64hw7kakbNkksbf7dFp8FRhSVT2OF74Rc5kaHnLjPCjYt/V25+lOzueO
         YGyMxPbp6meocjHULsV4Ttybn+yf2XkrqYG63sLn7kFO5A1Pl1zdYvK63uNkaFU8Qi6U
         rJg0eSxGVaOhKGMu70xmjN3yk5yDgFCDl9iA6fUP2U8h5+t4fD9TGRvMf5d3qkulFKN0
         8mNRDvdhCqEkNAEXIR7lMPeCW2BJjc0+97iYGkDk7sR33vN7nWxtAejdwxRNCBlqCGsM
         dxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58uILiTmCwCiHE2A6E5zlptHTfRXOP4l3B07M2FVpzg=;
        b=kblvRuDlUCzT3EY+RfI0KEHjTaTEB5h856pI5uOR5W6lsN49n4A9C1ntN8y9R4VAdZ
         s9xGy2iAkBXbOHR3CzXEM+tu5wapeHPRsIcI9pDGCeBa1tu4X4uE7r5+AHBqYJmgediL
         h6am4zmZ6fBTvhrUNUej8wguOJMrxTce4VQ8IBr/2y6dop6mTcPHNur46DlTDKUAGokM
         GSU7kmGY38K89U/s8OxV8fKjT9SVTiKYznsMrlFBYFvHfhsc8fZdv4MFPOFM7xIcuKmg
         9t5t3ZyXnrbZs1GdpyKntNgLm/QWoXZrhdJGU4uTgwqMpu+Vn9ZsY00osiyf1mkXY6/9
         L7CA==
X-Gm-Message-State: AOAM533Trqb8vUnZKFBg334GG52eD/t8k2PEUtpYtF2ghCdp+whQaX38
        vfegdvoM45cnyZ7melrR6EM=
X-Google-Smtp-Source: ABdhPJzTSLCHlifVeYeIYxWnSH0iODbX4fX0BzWzccBUIQ/8yksA80RN5Q7HPI5P/1msEcRm/2LWNQ==
X-Received: by 2002:a92:c883:: with SMTP id w3mr2601054ilo.212.1615871315236;
        Mon, 15 Mar 2021 22:08:35 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:34 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 17/18] dyndbg: RFC - DECLARE/DEFINE_DYNAMIC_DEBUG_TABLE
Date:   Mon, 15 Mar 2021 23:08:00 -0600
Message-Id: <20210316050801.2446401-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4-proto - now currently diet-3i

Simplify:
.gnu.linkonce._mod_.dyndbg -> .gnu.linkonce.dyndbg
ie drop _mod_

This puts a single header record at front of the vectors, solving 2
problems (discussed below) simultaneously:

- header in front, allowing flex-array rep of layout.
- single header, not per-module. adequate for needs, no wasted space.

this now appears to work
- get: dp range-check good on builtin, !builtin.

todo:
- _sym_##_site symbols in init/main.i still busted
- _index init in __ddebug_add_module
- cleanup commentary below.

DEFINE_DYNAMIC_DEBUG_TABLE is based on DECLARE_DYNAMIC_DEBUG_METADATA.
Like its model, it creates/allocates a pair of structs: _ddebug &
_ddebug_site, and inits them distinctively.

Its purpose is to create an in-situ module-header-pair for each
module's sub-vectors of _ddebug[], _ddebug_sites[].  Once the
header-pair is reliably linked into the vectors, code can get from
_ddebug[N] to the header-pair, then to _ddebug_sites[N] at runtime by
saving N into _ddebug._index during init.  With this, we can drop the
site pointer in struct _ddebug.

Eventually, this module-header-pair can be adapted to be an in-situ
replacement for the separately allocated struct ddebug_tables, and be
linked into the ddebug_tables list.

RFC, NOTES:

DYNAMIC_DEBUG is a 'transparent' facility, in that uses of pr_debug
get extra features without additional api.  Because of this,
DEFINE_DYNAMIC_DEBUG_TABLE is 'transparently' invoked by
dynamic_debug.h on behalf of all its (indirect) users, including
printk.h.

IOW this has wide effects; it results in multiple redundant
declarations of header records, even single object files may get
multiple copies.  Using .gnu.linkonce._mod_.dyndbg(|_site) section
names and "__used __weak " seems to resolve the redundancies.  I
havent tried with clang.

In vmlinux-lds.h, the 2 KEEPs are modified to append those 2 new
header sections to their respective existing __dyndbg* sections, in an
interleaved manner.  This places the header records immediately after
the modules' block of _ddebug*s, in a knowable offset from &__dyndbg[0].

scripts/Makefile.lib gets a new -DKBUILD_MODSYM defn, with a value
like KBUILD_MODNAME, except that its not __stringified.  It is used to
create a pair of module-ish named variables: _sym_##_dyndbg_base.

For some non-obvious reason, the substitution doesnt work, resulting
in per-module symbol names like KBUILD_MODSYM_dyndbg_base.  This
subtly alters the header initialization and is_dyndbg_header_pair(),
which is used in __init to find the headers adjacent to each modules'
block of _ddebug records.  This isnt fatal to the plan; we just need
the storage reserved where its accessible by known offset from the
_ddebug[N] record of an enabled pr-debug.  But it would be nice to
have the symbol names consistent with the intent.  I looked for a
MODULE_SINGLETON(name_suffix) to use, similarly to how UNIQUE_ID is
used to construct names, but found nothing.

The .gnu.linkonce._mod_. works to eliminate all the extra headers in
each module, but a problem remains; it adds unneeded headers for
modules with zero pr-debugs.  So Im seeing ~1500 extra headers.

I tried several flavors of conditional linking, now think I want/need
a linker-script language extension:

  KEEP ( *(__dyndbg) AND *(.gnu.linkonce.dyndbg) )  # my need
  KEEP ( *(foo_tbl)   OR *(.gnu.linkonce.foo_alt) ) # for completeness

I've managed to alter ld's grammar, but its only compile tested, and
is missing the conditional linking pieces.  Since this patchset's
value proposition is a memory shrink, ~1500 extra headers is fatal,
and this patchset must be a slow-cook.

V4 todo:

Time to simplify, drop _mod_, and change _ddebug.module_index to
._index, indicating that its no longer keyed to module, but to the
whole compilation unit, which for the kernel includes all the builtin
modules.  loadable modules should get their own. tbt.

this could obsolete all the above problems.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/i915_drv.c   |   2 +
 include/asm-generic/vmlinux.lds.h |  27 +++++---
 include/linux/dynamic_debug.h     | 100 +++++++++++++++++++++++++++++-
 lib/dynamic_debug.c               |  28 ++++++---
 scripts/Makefile.lib              |   2 +
 5 files changed, 139 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 8e9cb44e66e5..51163e0d40cf 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -91,6 +91,8 @@
 
 static const struct drm_driver driver;
 
+//DEFINE_DYNAMIC_DEBUG_TABLE();
+
 static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
 {
 	int domain = pci_domain_nr(dev_priv->drm.pdev->bus);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 4f2af9de2f03..482d94078785 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -335,6 +335,22 @@
 	KEEP(*(.dtb.init.rodata))					\
 	__dtb_end = .;
 
+/* implement dynamic printk debug */
+#if defined(CONFIG_DYNAMIC_DEBUG) ||					\
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE)				\
+	 && defined(DYNAMIC_DEBUG_MODULE))
+#define DYNAMIC_DEBUG_DATA()						\
+	. = ALIGN(8);							\
+	__start___dyndbg_sites = .;					\
+	KEEP(*(__dyndbg_sites .gnu.linkonce.dyndbg_site))		\
+	__stop___dyndbg_sites = .;					\
+	__start___dyndbg = .;						\
+	KEEP(*(__dyndbg .gnu.linkonce.dyndbg))				\
+	__stop___dyndbg = .;
+#else
+#define DYNAMIC_DEBUG_DATA()
+#endif
+
 /*
  * .data section
  */
@@ -351,15 +367,8 @@
 	__end_once = .;							\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	__start___dyndbg_sites = .;					\
-	KEEP(*(__dyndbg_sites))					\
-	__stop___dyndbg_sites = .;					\
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
index 18689db0e2c0..229cfd81ffb3 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -101,10 +101,92 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const struct ib_device *ibdev,
 			 const char *fmt, ...);
 
-#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
+/**
+ * DEFINE_DYNAMIC_DEBUG_TABLE(), DECLARE_DYNAMIC_DEBUG_TABLE()
+ *
+ * These are special versions of DEFINE_DYNAMIC_DEBUG_METADATA().  The
+ * job is to create/reserve a module-header struct-pair as the last
+ * element of the module's sub-vectors of __dyndbg & __dyndbg_sites,
+ * ie at a fixed offset from them.  I expect to settle on 1 of these
+ * 2; DEFINE_ has seen most testing recently, and is favored.
+ *
+ * With this record reliably in-situ at a fixed offset for each
+ * callsite, we can use ._index to remember this offset, find the
+ * header, find the parallel vector, then index the corresponding site
+ * data.
+ *
+ * This macro is invoked at the bottom of this header.  It is
+ * typically invoked multiple times for a module, generally at least
+ * once per object file.  The combination of .gnu.linkonce._ and
+ * __weak appear to resolve earlier troubles with compile errors or
+ * multiple copies of headers.
+ */
+
+#define DECLARE_DYNAMIC_DEBUG_TABLE_(_sym_, _mod_)	       	\
+	static struct _ddebug_site				\
+	__section(".gnu.linkonce.dyndbg_site")			\
+		__aligned(8)					\
+		__maybe_unused					\
+		_sym_##_dyndbg_site;				\
+	static struct _ddebug					\
+	__section(".gnu.linkonce.dyndbg")			\
+		__aligned(8)					\
+		__maybe_unused					\
+		_sym_##_dyndbg_base
+
+#define DYNAMIC_DEBUG_TABLE_refer(_sym_)			\
+	static void __used _sym_##_take_internal_refs(void)	\
+{								\
+	struct _ddebug_site * dc = &_sym_##_dyndbg_site;	\
+	struct _ddebug * dp = &_sym_##_dyndbg_base;		\
+	printk(KERN_INFO "%s %d\n", dc->function, dp->lineno);	\
+}
+
+#define DECLARE_DYNAMIC_DEBUG_TABLE()		       			\
+	DECLARE_DYNAMIC_DEBUG_TABLE_(KBUILD_MODSYM, KBUILD_MODNAME);	\
+	DYNAMIC_DEBUG_TABLE_refer(KBUILD_MODSYM)
+
+//#define DEFN_SC static // clashes with extern forward decl
+//#define DEFN_SC extern // warning: ‘KBUILD_MODNAME_dyndbg_site’ initialized and declared ‘extern’
+//#define DEFN_SC // no section allowd on locals
+#define DEFN_SC __weak
+
+#define DEFINE_DYNAMIC_DEBUG_TABLE_(_sym_,_mod_)	       	\
+	DEFN_SC struct _ddebug_site				\
+	__section(".gnu.linkonce.dyndbg_site")			\
+		__used __aligned(8)				\
+	_sym_ ##_dyndbg_site = {				\
+		.modname = _mod_,				\
+		.filename = __FILE__,				\
+		.function = (void*) _mod_			\
+	};							\
+	DEFN_SC struct _ddebug					\
+	__section(".gnu.linkonce.dyndbg")			\
+		__used __aligned(8)				\
+	_sym_ ##_dyndbg_base = {				\
+		.site = & _sym_ ##_dyndbg_site,			\
+		.format = _mod_,				\
+		.lineno = 0					\
+	}
+
+/* above init conditions as distinguishing predicate.
+ * (site == iter->site) should work but doesnt, possibly cuz MODSYM
+ * expansion problem
+ */
+#define is_dyndbg_header_pair(iter, site)			\
+	((iter->format == site->modname)			\
+	 && (site->modname == site->function))
+
+// build-time expensive, shows repetitive includes
+// #pragma message "<" __stringify(KBUILD_MODSYM) "> adding DYNDBG_TABLE"
+
+#define DEFINE_DYNAMIC_DEBUG_TABLE()				\
+	DEFINE_DYNAMIC_DEBUG_TABLE_(KBUILD_MODSYM, KBUILD_MODNAME);
+
+#define DEFINE_DYNAMIC_DEBUG_METADATA_(_mod_, name, fmt)	\
 	static struct _ddebug_site  __aligned(8)		\
 	__section("__dyndbg_sites") name##_site = {		\
-		.modname = KBUILD_MODNAME,			\
+		.modname = _mod_,				\
 		.filename = __FILE__,				\
 		.function = __func__,				\
 	};							\
@@ -114,9 +196,13 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
+		._index = 0,					\
 		_DPRINTK_KEY_INIT				\
 	}
 
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
+	DEFINE_DYNAMIC_DEBUG_METADATA_(KBUILD_MODNAME, name, fmt)
+
 #ifdef CONFIG_JUMP_LABEL
 
 #ifdef DEBUG
@@ -247,4 +333,14 @@ static inline int dynamic_debug_exec_queries(const char *query, const char *modn
 
 #endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
+#if ((defined(CONFIG_DYNAMIC_DEBUG) ||						\
+      (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE)))	\
+     && defined(KBUILD_MODNAME)							\
+     && !defined(NO_DYNAMIC_DEBUG_TABLE))
+
+/* transparently invoked, except for -DNO_DYNAMIC_DEBUG_TABLE */
+DEFINE_DYNAMIC_DEBUG_TABLE()
+
+#endif
+
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3b53035d63d6..c1a7345277eb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1203,8 +1203,7 @@ static int __init dynamic_debug_init(void)
 	const char *modname = NULL;
 	char *cmdline;
 	int ret = 0;
-	int site_ct = 0, entries = 0, modct = 0;
-	int mod_index = 0;
+	int i, site_ct = 0, modct = 0, mod_index = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1220,10 +1219,20 @@ static int __init dynamic_debug_init(void)
 	site = site_mod_start = __start___dyndbg_sites;
 	modname = site->modname;
 
-	for (; iter < __stop___dyndbg; iter++, site++) {
+	for (i = 0; iter < __stop___dyndbg; iter++, site++, i++) {
 
+		/* we should have 1 header for kernel, at beginning of blocks
+		 * but lets be safe for a while 
+		 */
+		if (is_dyndbg_header_pair(iter, site)) {
+			v3pr_info("header.%d: %s\n", i, site->modname);
+			iter->site = site; /* fixup bad init */
+			continue;
+		}
 		BUG_ON(site != iter->site);
-		entries++;
+
+		v3pr_info("site: %s.%s.%d\n", site->modname,
+			  site->function, iter->lineno);
 
 		if (strcmp(modname, site->modname)) {
 			modct++;
@@ -1232,13 +1241,14 @@ static int __init dynamic_debug_init(void)
 						  site_ct, mod_index, modname);
 			if (ret)
 				goto out_err;
-			site_ct = 0;
+
 			modname = site->modname;
 			iter_mod_start = iter;
 			site_mod_start = site;
+			mod_index += site_ct;
+			site_ct = 0;
 		}
 		site_ct++;
-		iter->_index = index++;
 	}
 	ret = __ddebug_add_module(iter_mod_start, site_mod_start, site_ct, mod_index, modname);
 	if (ret)
@@ -1246,9 +1256,9 @@ static int __init dynamic_debug_init(void)
 
 	ddebug_init_success = 1;
 	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section, %d bytes in __dyndbg_sites section\n",
-		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 (int)(entries * sizeof(struct _ddebug)),
-		 (int)(entries * sizeof(struct _ddebug_site)));
+		 modct, i, (int)(modct * sizeof(struct ddebug_table)),
+		 (int)(i * sizeof(struct _ddebug)),
+		 (int)(i * sizeof(struct _ddebug_site)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8cd67b1b6d15..051993ef9b92 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -111,10 +111,12 @@ target-stem = $(basename $(patsubst $(obj)/%,%,$@))
 # These flags are needed for modversions and compiling, so we define them here
 # $(modname_flags) defines KBUILD_MODNAME as the name of the module it will
 # end up in (or would, if it gets compiled in)
+
 name-fix-token = $(subst $(comma),_,$(subst -,_,$1))
 name-fix = $(call stringify,$(call name-fix-token,$1))
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
 modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname)) \
+	         -DKBUILD_MODSYM=$(call name-fix-token,$(modname)) \
 		 -D__KBUILD_MODNAME=kmod_$(call name-fix-token,$(modname))
 modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile))
 
-- 
2.29.2

