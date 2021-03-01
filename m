Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716C73297D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344504AbhCAWym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbhCARtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:49:46 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4A5C06121E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:47:58 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q20so12000268pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wshkt8l8FrWJwzfMDHkPetk+cACmLQC6B2ayLm9ZVq0=;
        b=N6PBZj7Pd7xIg7E3dTc2K/JuPk49LNWwbD1X1s00G4eb9oc/vvaGcMxls8yS907RXN
         xxcwzXerI0vDsNnlwCSWNw9MsWKFAIL5OdrWTkxgEtTrz56clfgFaRtUmbxdfV7sm/t4
         O8FMq/tuJWL4iSS1rIzUT9hI2HBXJryH2va+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wshkt8l8FrWJwzfMDHkPetk+cACmLQC6B2ayLm9ZVq0=;
        b=VEC2OKzbOk6N+wt0dNZGgZxQaBOeX1We7lXeAKJddy1QL946lPSVz7NP9bpLyK2Kfu
         /+COneMrMkkAXIGjEIDLgi99L6MyPf4hLU2EkiH9rUNzAaHkij+7MulW/BUcGOeiCv1w
         CbyyJgBdF1yY9LvZtWEOCZVWY5vxY8xLIUX7163QQdELsDAeanNmNmpQtpmOuxWFe8oc
         SdaPNgKD6gDg/wQJ8aeOcYcmphZSJOS9uoSDnELAFJgU4ho3iI+Qetk+IdQFKfpnH2aK
         O2rUcnRMnT/X7RDkia4U9jNU4o/q/mttPZfK5L9R4ygzhiQp3xrE+Exb/RCySr8cMF26
         sSgA==
X-Gm-Message-State: AOAM531pF4XV6UPvLIVCclL+MvY1zYZB6juVslWm/53Pd/tZhzbAaBZ8
        5qBFd7o80qUmC6lR8xhfM56BYg==
X-Google-Smtp-Source: ABdhPJy6R9TXUerH72CO6pbJ+lYTrH5prITFBBz3lpvofDWNIpixeapbzCShJrdBNc5l8jKB/5vwIA==
X-Received: by 2002:a63:5044:: with SMTP id q4mr3937871pgl.178.1614620877938;
        Mon, 01 Mar 2021 09:47:57 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3c20:df33:e36:93df])
        by smtp.gmail.com with ESMTPSA id y202sm19071325pfb.153.2021.03.01.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:47:57 -0800 (PST)
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
        linux-doc@vger.kernel.org
Subject: [PATCH 5/7] printk: Make %pS and friends print module build ID
Date:   Mon,  1 Mar 2021 09:47:47 -0800
Message-Id: <20210301174749.1269154-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301174749.1269154-1-swboyd@chromium.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The %pS printk format (among some others) is used to print kernel
addresses symbolically. When the kernel prints an address inside of a
module, the kernel prints the addresses' symbol name along with the
module's name that contains the address. Let's make kernel stacktraces
easier to identify on KALLSYMS builds by including the build ID of a
module when we print the address.

This is especially helpful for crash debugging with pstore or crashdump
kernels. If we have the build ID for the module in the stacktrace we can
request the debug symbols for the module from a remote debuginfod server
or parse stacktraces at a later time with decode_stacktrace.sh by
downloading the correct symbols based on the build ID. This cuts down on
the amount of time and effort needed to find the correct kernel modules
for a stacktrace by encoding that information into it.

An alternative to changing the printk format would be to update the
"Modules linked in:" line to include the build ID of each module linked
in. This can become quite long when many modules are loaded (i.e. on a
distro) so I've opted for the printk format instead. Similarly,
collecting each module build ID in a stacktrace and then printing it
after the trace would require some architecture level surgery to the
dump stack code and also provide the ID "too late" for code that is
parsing each line of the stacktrace.

Example:

 WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
 Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
 CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
 lr : lkdtm_do_action+0x24/0x40 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
 sp : ffffffc0134fbca0
 x29: ffffffc0134fbca0 x28: ffffff92d53ba240
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000000000000 x24: ffffffe3622352c0
 x23: 0000000000000020 x22: ffffffe362233366
 x21: ffffffe3622352e0 x20: ffffffc0134fbde0
 x19: 0000000000000008 x18: 0000000000000000
 x17: ffffff929b6536fc x16: 0000000000000000
 x15: 0000000000000000 x14: 0000000000000012
 x13: ffffffe380ed892c x12: ffffffe381d05068
 x11: 0000000000000000 x10: 0000000000000000
 x9 : 0000000000000001 x8 : ffffffe362237000
 x7 : aaaaaaaaaaaaaaaa x6 : 0000000000000000
 x5 : 0000000000000000 x4 : 0000000000000001
 x3 : 0000000000000008 x2 : ffffff93fef25a70
 x1 : ffffff93fef15788 x0 : ffffffe3622352e0
 Call trace:
  lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
  direct_entry+0x16c/0x1b4 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
  full_proxy_write+0x74/0xa4
  vfs_write+0xec/0x2e8
  ksys_write+0x84/0xf0
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xf4/0x1c0
  do_el0_svc_compat+0x28/0x3c
  el0_svc_compat+0x10/0x1c
  el0_sync_compat_handler+0xa8/0xcc
  el0_sync_compat+0x178/0x180
 ---[ end trace 3d95032303e59e68 ]---

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
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Yet another alternative is to add a printk format like %pSB for
backtrace prints. This would require a handful of architecture updates
and I'm not sure it's worth the effort for that.

 Documentation/core-api/printk-formats.rst |  6 +++
 include/linux/kallsyms.h                  |  6 ++-
 include/linux/module.h                    |  2 +-
 kernel/kallsyms.c                         | 45 +++++++++++++++--------
 kernel/module.c                           |  4 +-
 5 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 160e710d992f..7f05962f7f68 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -114,6 +114,12 @@ used when printing stack backtraces. The specifier takes into
 consideration the effect of compiler optimisations which may occur
 when tail-calls are used and marked with the noreturn GCC attribute.
 
+If the pointer is within a module, the module name and build ID is printed after
+the symbol name.
+
+::
+	%pS	versatile_init+0x0/0x110 [module_name] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
+
 Probed Pointers from BPF / tracing
 ----------------------------------
 
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 465060acc981..c2f1660823cb 100644
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
+#define KSYM_SYMBOL_LEN (sizeof("%s+%#lx/%#lx [%s] (%s)") + (KSYM_NAME_LEN - 1) + \
+			 2*(BITS_PER_LONG*3/10) + (MODULE_NAME_LEN - 1) + \
+			 (BUILD_ID_STR_SIZE_MAX - 1) + 1)
 
 struct cred;
 struct module;
diff --git a/include/linux/module.h b/include/linux/module.h
index 9d1f6a5240c1..c12f9215f63e 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -634,7 +634,7 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr);
 const char *module_address_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname,
+			    char **modname, char **modbuildid,
 			    char *namebuf);
 int lookup_module_symbol_name(unsigned long addr, char *symname);
 int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 8043a90aa50e..a70c53764b8a 100644
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
+				    char **modbuildid, char *namebuf)
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
@@ -362,12 +372,14 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 			   int symbol_offset, int add_offset)
 {
 	char *modname;
+	char *modbuildid;
 	const char *name;
 	unsigned long offset, size;
 	int len;
 
 	address += symbol_offset;
-	name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
+	name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &modbuildid,
+				       buffer);
 	if (!name)
 		return sprintf(buffer, "0x%lx", address - symbol_offset);
 
@@ -379,8 +391,11 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	if (add_offset)
 		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);
 
-	if (modname)
+	if (modname) {
 		len += sprintf(buffer + len, " [%s]", modname);
+		if (modbuildid)
+			len += sprintf(buffer + len, " (%s)", modbuildid);
+	}
 
 	return len;
 }
diff --git a/kernel/module.c b/kernel/module.c
index a7559a0de9d8..2909e62f147b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4255,7 +4255,7 @@ void * __weak dereference_module_function_descriptor(struct module *mod,
 const char *module_address_lookup(unsigned long addr,
 			    unsigned long *size,
 			    unsigned long *offset,
-			    char **modname,
+			    char **modname, char **modbuildid,
 			    char *namebuf)
 {
 	const char *ret = NULL;
@@ -4266,6 +4266,8 @@ const char *module_address_lookup(unsigned long addr,
 	if (mod) {
 		if (modname)
 			*modname = mod->name;
+		if (modbuildid)
+			*modbuildid = mod->build_id;
 
 		ret = find_kallsyms_symbol(mod, addr, size, offset);
 	}
-- 
https://chromeos.dev

