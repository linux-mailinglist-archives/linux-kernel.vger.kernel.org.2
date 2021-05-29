Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F97394E0E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhE2UEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhE2UEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:11 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F9C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:33 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so6950131otc.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhmENfq2ddmpBLtc+MJfQv/hyN61SzWwuc83j/dzBM0=;
        b=kSyzQr751rihNltWnubG9ux5Faj2lvBkWxCD38fWHr4FSty5Ulth2AiP+EyEaRhDQD
         QG6UGI0fCl5PUBLddvMh7XUmGvByIk1qukQ/r7vqqAbUMDLrfEwdeGYxX76of7Yi4wML
         aLK6bLDiABNN9PUZzYumVNLhGWA+XtzvkLMrxJjgu1ekcsyaq5vJmmSIwpjGdjSmoKp6
         QckLfH+pWjg2r5QiyvRs9LnfvPybCV8DOkgaf3VPxsDeZpPCj5t3qiTVtNq5WAi6knOY
         bvgqc8VQ7YAMZA1A6HM0iFTT6dSKMW0deaGmzZ0izsdD3eXebwMIpSAyTHJ/8vXmkuGj
         c8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhmENfq2ddmpBLtc+MJfQv/hyN61SzWwuc83j/dzBM0=;
        b=Hq/af+N/ST3vRJmgdBKp9NfCsNA4i9fNTg13o0N9FO5P1yrL5BujOQ5QwQ0EQnbh88
         yA6lY3/NqpH7A3JvRoakeM8I5YrEc79WPGjU840duMM4WgAgO0yyhMQWccUJjip2r8SY
         ah6PxPa0lzopGkWvYX0vFdYVnxWBnH/FTnjh58mInK+xEWLtKjy99H0nRTDBpomwd5Xo
         YZFxS3110j8Fqqhj3u0Ko8gwVpx04QDQgzl9RkMOgg3V0vsZG4OJgjHWtlkHUrqgRnSH
         ZukgwYH+gFcesjWRZuLtI9nmibuWJ/7sv0+iGC4deRS6QSK/cKg5RtKv3yY7Ihmut8O/
         R7+A==
X-Gm-Message-State: AOAM531naddRx++CN43IMWz4xwX4giz3sjOC+/JNgF4Pi5QhDs69QpnS
        YakZPS4jdnxC0hlafvTaF00=
X-Google-Smtp-Source: ABdhPJwdZrIBGZix+KK6xd2JDtZd+xZwObzWJe4IqqbPnHIhUJP3xXcCjJE92F/JoP0bPRc6GPeXog==
X-Received: by 2002:a9d:6645:: with SMTP id q5mr11536497otm.80.1622318553270;
        Sat, 29 May 2021 13:02:33 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 19/34] dyndbg: RFC - DEFINE_DYNAMIC_DEBUG_TABLE
Date:   Sat, 29 May 2021 14:00:14 -0600
Message-Id: <20210529200029.205306-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINE_DYNAMIC_DEBUG_TABLE is based on DEFINE_DYNAMIC_DEBUG_METADATA.
Like its model, it creates/allocates a pair of structs: _ddebug &
_ddebug_site.  It inits them distinctively, so is_dyndbg_header_pair()
macro can verify them.

Its purpose is to reserve a single pair of header records in the front
of the "__dyndbgs" & "__dyndbg_sites" sections.  This has several parts;

- the pair of structs are defined in 2 .gnu.linkonce.dyndbg* sections
  corresponding to the 2 dyndbg* sections populated by _METADATA

- vmlinux.lds.h places these 2 new sections into the dyndbg* sections,
  right after the start___dyndbg*s, before existing contents.

- the pair has "__used __weak" to qualm compiler concerns.
  explicit externs were problematic with initialization, static decls too.

With this, the header record is now really __dyndbg[0].

Notes:

DYNAMIC_DEBUG is a 'transparent' facility, in that pr_debug() users
get extra features without additional api.  Because of this,
DEFINE_DYNAMIC_DEBUG_TABLE is invoked by dynamic_debug.h on behalf of
all its (indirect) users, including printk.h.

IOW this has wide effects; it resulted in multiple redundant
definitions of header records.  By hunch then trial and error, using
.gnu.linkonce. sections and "__used __weak " modifiers resolved the
problems. RFC.

In vmlinux-lds.h, I added 2 more KEEPs to place the .gnu.linkonce.*
headers at the front of their respective __dyndbg* sections.  I moved
the __dyndbg lines into a new macro, which maybe should be done as a
separate commit, or in the earlier commit that touched it.

The headers are really just struct _ddebug*s, they are initialized
distinctively so that they're recogizable by code, using macro
is_dyndbg_header_pair(dbg, dbgsite).

DECLARE_DYNAMIC_DEBUG_TABLE() initializes the header record pairs with
values which are "impossible" for pr_debug()s: (and therefor distinctive)

- lineno == 0
- site == iter->site
- modname == function		not possible in proper linkage
- modname == format		not possible in normal linkage
- filename = (void*) iter	forced loopback

Next:

Get __dyndbg[0] from any *dp within __dyndbg[N].  Then with
__dyndbg[0].site, we can get __dyndbg_sites[N].  This is a little
slower than a direct pointer, but this is an unlikely debug path, so
this 'up-N-over-down-N' access is ok.

Eventually we can adapt the header (as a new struct/union) to keep its
pointer to the __dyndbg_sites[] section/block, while allowing us to
drop it from struct _ddebug, regaining memory parity with master.  But
for now, we keep .site, and will soon use it to validate the
'up-N-over-down-N' computation.

For clarity, N is _ddebug._index.  For both builtins & loadable
modules, it is init'd to remember the fixed offset from the beginning
of the section/block/memory-allocation (actual elf sections for *ko's,
and a __start/__stop delineated part of .data for builtins).

N/_index will be used solely to get to __debugs[0] and over to
__debug_sites[N].  It is distinct from a module's numdbgs, which is
used mainly when walking control, and is kept in struct _ddeug_table.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  2 ++
 include/linux/dynamic_debug.h     | 45 +++++++++++++++++++++++++++++++
 lib/dynamic_debug.c               | 18 ++++++-------
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f4e861282ed7..11a194fe3cd9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -340,9 +340,11 @@
 #define DYNAMIC_DEBUG_DATA()						\
 	. = ALIGN(8);							\
 	__start___dyndbg_sites = .;					\
+	KEEP(*(.gnu.linkonce.dyndbg_site))				\
 	KEEP(*(__dyndbg_sites))						\
 	__stop___dyndbg_sites = .;					\
 	__start___dyndbg = .;						\
+	KEEP(*(.gnu.linkonce.dyndbg))					\
 	KEEP(*(__dyndbgs))						\
 	__stop___dyndbg = .;
 #else
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index c866b4a9760a..a99973221f94 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -113,6 +113,43 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		_DPRINTK_KEY_INIT				\
 	}
 
+/*
+ * DEFINE_DYNAMIC_DEBUG_TABLE(): This is a special version of
+ * DEFINE_DYNAMIC_DEBUG_METADATA().  It creates a single pair of
+ * header records, which linker scripts place into __dyndbg[0] &
+ * __dyndbg_sites[0].
+ * To allow a robust runtime test for is_dyndbg_header_pair(I,S),
+ * force-initialize S->filename to point back to I, an otherwize
+ * pathological condition.
+ */
+#define DEFINE_DYNAMIC_DEBUG_TABLE()				\
+	/* forward decl, allowing loopback pointer */		\
+	__weak struct _ddebug __used __aligned(8)		\
+		__section(".gnu.linkonce.dyndbg")		\
+		_LINKONCE_dyndbg_header;			\
+	__weak struct _ddebug_site __used __aligned(8)		\
+		__section(".gnu.linkonce.dyndbg_site")		\
+	_LINKONCE_dyndbg_site_header = {			\
+		.modname = KBUILD_MODNAME,			\
+		.function = KBUILD_MODNAME,			\
+		/* forced pointer loopback, for distinction */	\
+		.filename = (void *) &_LINKONCE_dyndbg_header	\
+	};							\
+	__weak struct _ddebug __used __aligned(8)		\
+		__section(".gnu.linkonce.dyndbg")		\
+	_LINKONCE_dyndbg_header = {				\
+		.site = &_LINKONCE_dyndbg_site_header,		\
+		.format = KBUILD_MODNAME			\
+	}
+
+/* The header initializations as a distinguishing predicate */
+#define is_dyndbg_header_pair(iter, sitep)			\
+	(sitep == iter->site					\
+	 && (!iter->lineno)					\
+	 && (iter->format == sitep->modname)			\
+	 && (sitep->modname == sitep->function)			\
+	 && ((void *)sitep->filename == (void *)iter))
+
 #ifdef CONFIG_JUMP_LABEL
 
 #ifdef DEBUG
@@ -243,4 +280,12 @@ static inline int dynamic_debug_exec_queries(const char *query, const char *modn
 
 #endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
+#if ((defined(CONFIG_DYNAMIC_DEBUG) ||						\
+      (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE)))	\
+     && defined(KBUILD_MODNAME) && !defined(NO_DYNAMIC_DEBUG_TABLE))
+
+/* transparently invoked, except when -DNO_DYNAMIC_DEBUG_TABLE */
+DEFINE_DYNAMIC_DEBUG_TABLE();
+#endif
+
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ce134c939f01..e4a22f7b153f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1190,8 +1190,7 @@ static int __init dynamic_debug_init(void)
 	const char *modname = NULL;
 	char *cmdline;
 	int ret = 0;
-	int site_ct = 0, entries = 0, modct = 0;
-	int mod_index = 0;
+	int i, site_ct = 0, modct = 0, mod_index = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1207,10 +1206,9 @@ static int __init dynamic_debug_init(void)
 	site = site_mod_start = __start___dyndbg_sites;
 	modname = site->modname;
 
-	for (; iter < __stop___dyndbg; iter++, site++) {
+	for (i = 0; iter < __stop___dyndbg; iter++, site++, i++) {
 
-		BUG_ON(site != iter->site);
-		entries++;
+		WARN_ON(site != iter->site);
 
 		if (strcmp(modname, site->modname)) {
 			modct++;
@@ -1219,10 +1217,12 @@ static int __init dynamic_debug_init(void)
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
 	}
@@ -1232,9 +1232,9 @@ static int __init dynamic_debug_init(void)
 
 	ddebug_init_success = 1;
 	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d KiB in __dyndbg section, %d KiB in __dyndbg_sites section\n",
-		 entries, modct, (int)((modct * sizeof(struct ddebug_table)) >> 10),
-		 (int)((entries * sizeof(struct _ddebug)) >> 10),
-		 (int)((entries * sizeof(struct _ddebug_site)) >> 10));
+		 i, modct, (int)((modct * sizeof(struct ddebug_table)) >> 10),
+		 (int)((i * sizeof(struct _ddebug)) >> 10),
+		 (int)((i * sizeof(struct _ddebug_site)) >> 10));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.31.1

