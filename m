Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BF7346F34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhCXCFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhCXCEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:04:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF1C0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v23so7097968ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opK5mOcP2v6ZsfO/IEwfDFGjA4+Llr3EQ3BJOh7bMNU=;
        b=f9E0MwSAsYSgkU+zWUVhfWJhxnZ1l1vhCjRpVuYETV93hOQTOs7dAl4ONX3zExIFHA
         fLhugA7qye4X/Ezaq898JCEE42f8PwKmijaxM14BM/RkXX0GAGl3NUgmNLecJkDjC8Uk
         7jkNVLBvOYgFWzKru0s8GIB/0jbR0C4uW6VU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opK5mOcP2v6ZsfO/IEwfDFGjA4+Llr3EQ3BJOh7bMNU=;
        b=lDWrRKqpVrfI4plRssr/9kkHLpQKl79mME+kOV7nnAw4V1GpRb/ThLkjMd0LyUZAE3
         dcPas85pw+ygUuBcZeerko/IyQw2+JujgXDV0uMPIB54DW/gAHoDtUeWwiS32YrcWHQn
         qVpFq7HSiwh6RYGZgydiUKccw4cq/bUGPrv2uWPqw3IU8WiN+XA+rRU7AMfwho9kV70I
         tAOpAylT7EwXgGHrzAnDRR3z5F9dQsSQ6jbLxffHWGMjvwG9ixjqOU6whbBxhtJh2KSP
         jEfC9pYBWGszIKLq0E7q/O2YWT2RnsAMVm0m0kOX480WsN0fGwqp2BVPIjCnVcSqwATv
         B/Mg==
X-Gm-Message-State: AOAM531DsNkvcGlWqP8Nh98ufvydaH06/iNJf/u6HOIHMWrfHq9Njoy7
        4l2pte2hbvQyYaiJdRpvqghCWg==
X-Google-Smtp-Source: ABdhPJzjTaJks9/LJLo4q2Cykh6B7haQX5locUwrJBGIp6afti0TzhTPAGoReWD6DNxG7wfLfPPlAw==
X-Received: by 2002:a17:90a:516:: with SMTP id h22mr905921pjh.222.1616551491342;
        Tue, 23 Mar 2021 19:04:51 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:51 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 04/12] module: Add printk format to add module build ID to stacktraces
Date:   Tue, 23 Mar 2021 19:04:35 -0700
Message-Id: <20210324020443.1815557-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make kernel stacktraces easier to identify by including the build
ID[1] of a module if the stacktrace is printing a symbol from a module.
This makes it simpler for developers to locate a kernel module's full
debuginfo for a particular stacktrace. Combined with
scripts/decode_stracktrace.sh, a developer can download the matching
debuginfo from a debuginfod[2] server and find the exact file and line
number for the functions plus offsets in a stacktrace that match the
module. This is especially useful for pstore crash debugging where the
kernel crashes are recorded in something like console-ramoops and the
recovery kernel/modules are different or the debuginfo doesn't exist on
the device due to space concerns (the debuginfo can be too large for
space limited devices).

Originally, I put this on the %pS format, but that was quickly rejected
given that %pS is used in other places such as ftrace where build IDs
aren't meaningful. There was some discussions on the list to put every
module build ID into the "Modules linked in:" section of the stacktrace
message but that quickly becomes very hard to read once you have more
than three or four modules linked in. It also provides too much
information when we don't expect each module to be traversed in a
stacktrace. Having the build ID for modules that aren't important just
makes things messy. Splitting it to multiple lines for each module
quickly explodes the number of lines printed in an oops too, possibly
wrapping the warning off the console. And finally, trying to stash away
each module used in a callstack to provide the ID of each symbol printed
is cumbersome and would require changes to each architecture to stash
away modules and return their build IDs once unwinding has completed.

Instead, we opt for the simpler approach of introducing a new printk
format '%p[sS][br]' for "pointer symbolic backtrace with module build ID"
and then updating the few places in the architecture layer where the
stacktrace is printed to use this new format.

Example:

 WARNING: CPU: 3 PID: 3373 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
 Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE hci_uart <modules trimmed>
 CPU: 3 PID: 3373 Comm: bash Not tainted 5.11 #12 a8c0d47f7051f3e6670ceaea724af66a39c6cec8
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
 lr : lkdtm_do_action+0x24/0x40 [lkdtm]
 sp : ffffffc013febca0
 x29: ffffffc013febca0 x28: ffffff88d9438040
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000000000000 x24: ffffffdd0e9772c0
 x23: 0000000000000020 x22: ffffffdd0e975366
 x21: ffffffdd0e9772e0 x20: ffffffc013febde0
 x19: 0000000000000008 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000037
 x15: ffffffdd102ab174 x14: 0000000000000003
 x13: 0000000000000004 x12: 0000000000000000
 x11: 0000000000000000 x10: 0000000000000000
 x9 : 0000000000000001 x8 : ffffffdd0e979000
 x7 : 0000000000000000 x6 : ffffffdd10ff6b54
 x5 : 0000000000000000 x4 : 0000000000000000
 x3 : ffffffc013feb938 x2 : ffffff89fef05a70
 x1 : ffffff89feef5788 x0 : ffffffdd0e9772e0
 Call trace:
  lkdtm_WARNING+0x28/0x30 [lkdtm 6c2215028606bda50de823490723dc4bc5bf46f9]
  direct_entry+0x16c/0x1b4 [lkdtm 6c2215028606bda50de823490723dc4bc5bf46f9]
  full_proxy_write+0x74/0xa4
  vfs_write+0xec/0x2e8
  ksys_write+0x84/0xf0
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xf4/0x1c0
  do_el0_svc_compat+0x28/0x3c
  el0_svc_compat+0x10/0x1c
  el0_sync_compat_handler+0xa8/0xcc
  el0_sync_compat+0x178/0x180
 ---[ end trace f89bc7f5417cbcc6 ]---

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: <linux-doc@vger.kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Link: https://fedoraproject.org/wiki/Releases/FeatureBuildId [1]
Link: https://sourceware.org/elfutils/Debuginfod.html [2]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/core-api/printk-formats.rst |  9 +++
 include/linux/kallsyms.h                  | 13 +++-
 include/linux/module.h                    |  6 +-
 kernel/kallsyms.c                         | 73 ++++++++++++++++-------
 kernel/module.c                           | 24 +++++++-
 lib/vsprintf.c                            |  6 +-
 6 files changed, 106 insertions(+), 25 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 160e710d992f..c0844cb275eb 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -114,6 +114,15 @@ used when printing stack backtraces. The specifier takes into
 consideration the effect of compiler optimisations which may occur
 when tail-calls are used and marked with the noreturn GCC attribute.
 
+If the pointer is within a module, the module name and optionally build ID is
+printed after the symbol name.
+
+::
+	%pS	versatile_init+0x0/0x110 [module_name]
+	%pSb	versatile_init+0x0/0x110 [module_name ed5019fdf5e53be37cb1ba7899292d7e143b259e]
+	%pSr	versatile_init+0x9/0x110 [module_name ed5019fdf5e53be37cb1ba7899292d7e143b259e]
+		(with __builtin_extract_return_addr() translation)
+
 Probed Pointers from BPF / tracing
 ----------------------------------
 
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 465060acc981..9f489aaa4127 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -7,6 +7,7 @@
 #define _LINUX_KALLSYMS_H
 
 #include <linux/errno.h>
+#include <linux/buildid.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/mm.h>
@@ -15,8 +16,9 @@
 #include <asm/sections.h>
 
 #define KSYM_NAME_LEN 128
-#define KSYM_SYMBOL_LEN (sizeof("%s+%#lx/%#lx [%s]") + (KSYM_NAME_LEN - 1) + \
-			 2*(BITS_PER_LONG*3/10) + (MODULE_NAME_LEN - 1) + 1)
+#define KSYM_SYMBOL_LEN (sizeof("%s+%#lx/%#lx [%s %s]") + (KSYM_NAME_LEN - 1) + \
+			 2*(BITS_PER_LONG*3/10) + (MODULE_NAME_LEN - 1) + \
+			 (BUILD_ID_SIZE_MAX * 2) + 1)
 
 struct cred;
 struct module;
@@ -91,6 +93,7 @@ const char *kallsyms_lookup(unsigned long addr,
 
 /* Look up a kernel symbol and return it in a text buffer. */
 extern int sprint_symbol(char *buffer, unsigned long address);
+extern int sprint_symbol_stacktrace(char *buffer, unsigned long address);
 extern int sprint_symbol_no_offset(char *buffer, unsigned long address);
 extern int sprint_backtrace(char *buffer, unsigned long address);
 
@@ -128,6 +131,12 @@ static inline int sprint_symbol(char *buffer, unsigned long addr)
 	return 0;
 }
 
+static inline int sprint_symbol_stacktrace(char *buffer, unsigned long address)
+{
+	*buffer = '\0';
+	return 0;
+}
+
 static inline int sprint_symbol_no_offset(char *buffer, unsigned long addr)
 {
 	*buffer = '\0';
diff --git a/include/linux/module.h b/include/linux/module.h
index 59f094fa6f74..0d17c7eb4c8a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -11,6 +11,7 @@
 
 #include <linux/list.h>
 #include <linux/stat.h>
+#include <linux/buildid.h>
 #include <linux/compiler.h>
 #include <linux/cache.h>
 #include <linux/kmod.h>
@@ -367,6 +368,9 @@ struct module {
 	/* Unique handle for this module */
 	char name[MODULE_NAME_LEN];
 
+	/* Module build ID */
+	unsigned char build_id[BUILD_ID_SIZE_MAX];
+
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
 	struct module_attribute *modinfo_attrs;
@@ -630,7 +634,7 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr);
 const char *module_address_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname,
+			    char **modname, unsigned char **modbuildid,
 			    char *namebuf);
 int lookup_module_symbol_name(unsigned long addr, char *symname);
 int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 8043a90aa50e..e77a1b6680a9 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -273,21 +273,13 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 		get_symbol_pos(addr, symbolsize, offset);
 		return 1;
 	}
-	return !!module_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
+	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf) ||
 	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
 
-/*
- * Lookup an address
- * - modname is set to NULL if it's in the kernel.
- * - We guarantee that the returned name is valid until we reschedule even if.
- *   It resides in a module.
- * - We also guarantee that modname will be valid until rescheduled.
- */
-const char *kallsyms_lookup(unsigned long addr,
-			    unsigned long *symbolsize,
-			    unsigned long *offset,
-			    char **modname, char *namebuf)
+const char *kallsyms_lookup_buildid(unsigned long addr, unsigned long *symbolsize,
+				    unsigned long *offset, char **modname,
+				    unsigned char **modbuildid, char *namebuf)
 {
 	const char *ret;
 
@@ -303,12 +295,14 @@ const char *kallsyms_lookup(unsigned long addr,
 				       namebuf, KSYM_NAME_LEN);
 		if (modname)
 			*modname = NULL;
+		if (modbuildid)
+			*modbuildid = NULL;
 		return namebuf;
 	}
 
 	/* See if it's in a module or a BPF JITed image. */
 	ret = module_address_lookup(addr, symbolsize, offset,
-				    modname, namebuf);
+				    modname, modbuildid, namebuf);
 	if (!ret)
 		ret = bpf_address_lookup(addr, symbolsize,
 					 offset, modname, namebuf);
@@ -319,6 +313,22 @@ const char *kallsyms_lookup(unsigned long addr,
 	return ret;
 }
 
+/*
+ * Lookup an address
+ * - modname is set to NULL if it's in the kernel.
+ * - We guarantee that the returned name is valid until we reschedule even if.
+ *   It resides in a module.
+ * - We also guarantee that modname will be valid until rescheduled.
+ */
+const char *kallsyms_lookup(unsigned long addr,
+			    unsigned long *symbolsize,
+			    unsigned long *offset,
+			    char **modname, char *namebuf)
+{
+	return kallsyms_lookup_buildid(addr, symbolsize, offset, modname,
+				       NULL, namebuf);
+}
+
 int lookup_symbol_name(unsigned long addr, char *symname)
 {
 	symname[0] = '\0';
@@ -359,15 +369,17 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 
 /* Look up a kernel symbol and return it in a text buffer. */
 static int __sprint_symbol(char *buffer, unsigned long address,
-			   int symbol_offset, int add_offset)
+			   int symbol_offset, int add_offset, int add_buildid)
 {
 	char *modname;
+	unsigned char *buildid;
 	const char *name;
 	unsigned long offset, size;
 	int len;
 
 	address += symbol_offset;
-	name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
+	name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
+				       buffer);
 	if (!name)
 		return sprintf(buffer, "0x%lx", address - symbol_offset);
 
@@ -379,8 +391,12 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	if (add_offset)
 		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);
 
-	if (modname)
-		len += sprintf(buffer + len, " [%s]", modname);
+	if (modname) {
+		len += sprintf(buffer + len, " [%s", modname);
+		if (add_buildid && buildid)
+			len += sprintf(buffer + len, " %20phN", buildid);
+		len += sprintf(buffer + len, "]");
+	}
 
 	return len;
 }
@@ -398,10 +414,27 @@ static int __sprint_symbol(char *buffer, unsigned long address,
  */
 int sprint_symbol(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1);
+	return __sprint_symbol(buffer, address, 0, 1, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol);
 
+/**
+ * sprint_symbol_stacktrace - Look up a kernel symbol and return it in a text buffer
+ * @buffer: buffer to be stored
+ * @address: address to lookup
+ *
+ * This function looks up a kernel symbol with @address and stores its name,
+ * offset, size, module name and module build ID to @buffer if possible. If no
+ * symbol was found, just saves its @address as is.
+ *
+ * This function returns the number of bytes stored in @buffer.
+ */
+int sprint_symbol_stacktrace(char *buffer, unsigned long address)
+{
+	return __sprint_symbol(buffer, address, 0, 1, 1);
+}
+EXPORT_SYMBOL_GPL(sprint_symbol_stacktrace);
+
 /**
  * sprint_symbol_no_offset - Look up a kernel symbol and return it in a text buffer
  * @buffer: buffer to be stored
@@ -415,7 +448,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol);
  */
 int sprint_symbol_no_offset(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 0);
+	return __sprint_symbol(buffer, address, 0, 0, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
 
@@ -435,7 +468,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
  */
 int sprint_backtrace(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1);
+	return __sprint_symbol(buffer, address, -1, 1, 0);
 }
 
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
diff --git a/kernel/module.c b/kernel/module.c
index 30479355ab85..9e9cb502fb33 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -13,6 +13,7 @@
 #include <linux/trace_events.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
+#include <linux/buildid.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
@@ -2770,6 +2771,20 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 	}
 	mod->core_kallsyms.num_symtab = ndst;
 }
+
+static void init_build_id(struct module *mod, const struct load_info *info)
+{
+	const Elf_Shdr *sechdr;
+	unsigned int i;
+
+	for (i = 0; i < info->hdr->e_shnum; i++) {
+		sechdr = &info->sechdrs[i];
+		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
+		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
+					sechdr->sh_size))
+			break;
+	}
+}
 #else
 static inline void layout_symtab(struct module *mod, struct load_info *info)
 {
@@ -2778,6 +2793,10 @@ static inline void layout_symtab(struct module *mod, struct load_info *info)
 static void add_kallsyms(struct module *mod, const struct load_info *info)
 {
 }
+
+static void init_build_id(struct module *mod, const struct load_info *info)
+{
+}
 #endif /* CONFIG_KALLSYMS */
 
 static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsigned int num)
@@ -4004,6 +4023,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto free_arch_cleanup;
 	}
 
+	init_build_id(mod, info);
 	dynamic_debug_setup(mod, info->debug, info->num_debug);
 
 	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
@@ -4235,7 +4255,7 @@ void * __weak dereference_module_function_descriptor(struct module *mod,
 const char *module_address_lookup(unsigned long addr,
 			    unsigned long *size,
 			    unsigned long *offset,
-			    char **modname,
+			    char **modname, unsigned char **modbuildid,
 			    char *namebuf)
 {
 	const char *ret = NULL;
@@ -4246,6 +4266,8 @@ const char *module_address_lookup(unsigned long addr,
 	if (mod) {
 		if (modname)
 			*modname = mod->name;
+		if (modbuildid)
+			*modbuildid = mod->build_id;
 
 		ret = find_kallsyms_symbol(mod, addr, size, offset);
 	}
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 41ddc353ebb8..9cd62e84e4aa 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -961,13 +961,15 @@ char *symbol_string(char *buf, char *end, void *ptr,
 	char sym[KSYM_SYMBOL_LEN];
 #endif
 
-	if (fmt[1] == 'R')
+	if (fmt[1] == 'R' || fmt[1] == 'r')
 		ptr = __builtin_extract_return_addr(ptr);
 	value = (unsigned long)ptr;
 
 #ifdef CONFIG_KALLSYMS
 	if (*fmt == 'B')
 		sprint_backtrace(sym, value);
+	else if (*fmt == 'S' && (fmt[1] == 'b' || fmt[1] == 'r'))
+		sprint_symbol_stacktrace(sym, value);
 	else if (*fmt != 's')
 		sprint_symbol(sym, value);
 	else
@@ -2129,6 +2131,8 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  * - 'S' For symbolic direct pointers (or function descriptors) with offset
  * - 's' For symbolic direct pointers (or function descriptors) without offset
  * - '[Ss]R' as above with __builtin_extract_return_addr() translation
+ * - '[Ss]r' as above with __builtin_extract_return_addr() translation and module build ID
+ * - '[Ss]b' as above with module build ID (for use in backtraces)
  * - '[Ff]' %pf and %pF were obsoleted and later removed in favor of
  *	    %ps and %pS. Be careful when re-using these specifiers.
  * - 'B' For backtraced symbolic direct pointers with offset
-- 
https://chromeos.dev

