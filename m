Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD430F2DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhBDMII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbhBDMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:08:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD23C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:07:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nm1so1586164pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3mzpu0qu4PFpcQF0n9tQIBukqG1c/oqU6m6iIUEtS+I=;
        b=Z9OFmDwFxcXtdJ63nGzqgA17+GGUGj9uv4d0QCGfKLCYH6NvGOrSTMS13RalK1U9Go
         O8EJY4+ugocryYThjoKa0wubNNBpfAl8hDo79mqK7C1fjXsUfWJF5UIYtTaXqz3j0nVv
         plnWIGCQTTtP6jEatWslZhYHXC3IcSh4Lc9SmplsXNPdqX2CtN4e8o21VnOjD+9ONlLr
         NKgLY4ViLvCcUb7/xxBLCf49bQ6bVL66RGU+IigWI/j9ABkru8gz5mEfVdGDSIdPT7F+
         SoAyXy13JvrUWhMUbGZlBGJECBIdLcxlgodYgs6L4sqZZN8XLlb1uwwhB4POsKi6xRjz
         B2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3mzpu0qu4PFpcQF0n9tQIBukqG1c/oqU6m6iIUEtS+I=;
        b=qHzdj1t+XmP3PZhnS3e0lXlC8bKr7Keqc4piksIoVbhQXl3hMgZNrWRVll/QdA6A0i
         jLvqY18cuz3R3ZNOuEtLFJrDtPt56yQiIslQLKNdXCPgwjVFMykgT6zxdjOQeK6u+9+g
         YuJ0DYvTEZwVIJvYzoqkwsR1PpTaDV+QllJ5CjvvS0HlhXWsShJZi3p7KZP/c86BDHOu
         K+aQ47dmF+6t9STOS6BNw8/bIdLI/NhJ62vp+puyEJeCLIOi6rLvaIRPog1TM0PVD7sb
         S+y6Iae60cIDlripNJeElH2ZJS42xqMhda2kXp43N9EotCUar3anBEvvZY1YQyzRjosp
         xwJg==
X-Gm-Message-State: AOAM531eHqSo3yFyMxrBQe/q/SvmoHqa5lfu+RvQ7CvBIHuO9ZXredQG
        yal5sgbBjx3zvUJKVdkRSx8=
X-Google-Smtp-Source: ABdhPJyssyf5i6PAJV+qqqOURlKAEXm7dt+uDWFmRmJF1qKSamfPaUoQ02f4yz4gNbhVHmZI9dT/hw==
X-Received: by 2002:a17:90a:53:: with SMTP id 19mr8090330pjb.29.1612440446081;
        Thu, 04 Feb 2021 04:07:26 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id mv14sm9059079pjb.0.2021.02.04.04.07.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 04:07:25 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, gustavoars@kernel.org
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH v4] kdb: kdb_support: Fix debugging information problem
Date:   Thu,  4 Feb 2021 20:07:09 +0800
Message-Id: <1612440429-6391-1-git-send-email-stephenzhangzsd@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several common patterns.

0:
        kdb_printf("...",...);

which is the normal one.

1:
        kdb_printf("%s: "...,__func__,...)

We could improve '1' to this :

        #define kdb_func_printf(format, args...) \
                   kdb_printf("%s: " format, __func__, ## args)

2:
        if(KDB_DEBUG(AR))
                kdb_printf("%s "...,__func__,...);

We could improve '2' to this :
        #define kdb_dbg_printf(mask, format, args...) \
                           do { \
                                        if (KDB_DEBUG(mask)) \
                                                kdb_func_printf(format, ## args); \
                           } while (0)

In additon, we changed the format code of size_t to %zu.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
---
v1->v2 Changelog:
- Add 'mask' parameter in kdb_dbg_printf()

Thanks to Daniel and Doug's suggestions and review.

v2->v4 Changelog:
- Adjust alignment for some lines.

Suggested by Douglas Anderson.

 kernel/debug/kdb/kdb_private.h | 10 ++++++++
 kernel/debug/kdb/kdb_support.c | 53 ++++++++++++++++--------------------------
 2 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index a4281fb..0a56d35 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -254,4 +254,14 @@ extern unsigned long kdb_task_state(const struct task_struct *p,
 #define	KDB_WORD_SIZE	((int)sizeof(unsigned long))
 
 #endif /* CONFIG_KGDB_KDB */
+
+#define kdb_func_printf(format, args...) \
+	kdb_printf("%s: " format, __func__, ## args)
+
+#define kdb_dbg_printf(mask, format, args...) \
+	do { \
+		if (KDB_DEBUG(mask)) \
+			kdb_func_printf(format, ## args); \
+	} while (0)
+
 #endif	/* !_KDBPRIVATE_H */
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 6226502..f7c1885 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -39,20 +39,15 @@
  */
 int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
 {
-	if (KDB_DEBUG(AR))
-		kdb_printf("kdbgetsymval: symname=%s, symtab=%px\n", symname,
-			   symtab);
+	kdb_dbg_printf(AR, "symname=%s, symtab=%px\n", symname, symtab);
 	memset(symtab, 0, sizeof(*symtab));
 	symtab->sym_start = kallsyms_lookup_name(symname);
 	if (symtab->sym_start) {
-		if (KDB_DEBUG(AR))
-			kdb_printf("kdbgetsymval: returns 1, "
-				   "symtab->sym_start=0x%lx\n",
-				   symtab->sym_start);
+		kdb_dbg_printf(AR, "returns 1, symtab->sym_start=0x%lx\n",
+			       symtab->sym_start);
 		return 1;
 	}
-	if (KDB_DEBUG(AR))
-		kdb_printf("kdbgetsymval: returns 0\n");
+	kdb_dbg_printf(AR, "returns 0\n");
 	return 0;
 }
 EXPORT_SYMBOL(kdbgetsymval);
@@ -87,16 +82,14 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 #define knt1_size 128		/* must be >= kallsyms table size */
 	char *knt1 = NULL;
 
-	if (KDB_DEBUG(AR))
-		kdb_printf("kdbnearsym: addr=0x%lx, symtab=%px\n", addr, symtab);
+	kdb_dbg_printf(AR, "addr=0x%lx, symtab=%px\n", addr, symtab);
 	memset(symtab, 0, sizeof(*symtab));
 
 	if (addr < 4096)
 		goto out;
 	knt1 = debug_kmalloc(knt1_size, GFP_ATOMIC);
 	if (!knt1) {
-		kdb_printf("kdbnearsym: addr=0x%lx cannot kmalloc knt1\n",
-			   addr);
+		kdb_func_printf("addr=0x%lx cannot kmalloc knt1\n", addr);
 		goto out;
 	}
 	symtab->sym_name = kallsyms_lookup(addr, &symbolsize , &offset,
@@ -147,11 +140,8 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 
 	if (symtab->mod_name == NULL)
 		symtab->mod_name = "kernel";
-	if (KDB_DEBUG(AR))
-		kdb_printf("kdbnearsym: returns %d symtab->sym_start=0x%lx, "
-		   "symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
-		   symtab->sym_start, symtab->mod_name, symtab->sym_name,
-		   symtab->sym_name);
+	kdb_dbg_printf(AR, "returns %d symtab->sym_start=0x%lx, symtab->mod_name=%px, symtab->sym_name=%px (%s)\n",
+		       ret, symtab->sym_start, symtab->mod_name, symtab->sym_name, symtab->sym_name);
 
 out:
 	debug_kfree(knt1);
@@ -328,7 +318,7 @@ int kdb_getarea_size(void *res, unsigned long addr, size_t size)
 	int ret = copy_from_kernel_nofault((char *)res, (char *)addr, size);
 	if (ret) {
 		if (!KDB_STATE(SUPPRESS)) {
-			kdb_printf("kdb_getarea: Bad address 0x%lx\n", addr);
+			kdb_func_printf("Bad address 0x%lx\n", addr);
 			KDB_STATE_SET(SUPPRESS);
 		}
 		ret = KDB_BADADDR;
@@ -353,7 +343,7 @@ int kdb_putarea_size(unsigned long addr, void *res, size_t size)
 	int ret = copy_from_kernel_nofault((char *)addr, (char *)res, size);
 	if (ret) {
 		if (!KDB_STATE(SUPPRESS)) {
-			kdb_printf("kdb_putarea: Bad address 0x%lx\n", addr);
+			kdb_func_printf("Bad address 0x%lx\n", addr);
 			KDB_STATE_SET(SUPPRESS);
 		}
 		ret = KDB_BADADDR;
@@ -435,7 +425,7 @@ int kdb_getphysword(unsigned long *word, unsigned long addr, size_t size)
 		fallthrough;
 	default:
 		diag = KDB_BADWIDTH;
-		kdb_printf("kdb_getphysword: bad width %ld\n", (long) size);
+		kdb_func_printf("bad width %zu\n", size);
 	}
 	return diag;
 }
@@ -484,7 +474,7 @@ int kdb_getword(unsigned long *word, unsigned long addr, size_t size)
 		fallthrough;
 	default:
 		diag = KDB_BADWIDTH;
-		kdb_printf("kdb_getword: bad width %ld\n", (long) size);
+		kdb_func_printf("bad width %zu\n", size);
 	}
 	return diag;
 }
@@ -528,7 +518,7 @@ int kdb_putword(unsigned long addr, unsigned long word, size_t size)
 		fallthrough;
 	default:
 		diag = KDB_BADWIDTH;
-		kdb_printf("kdb_putword: bad width %ld\n", (long) size);
+		kdb_func_printf("bad width %zu\n", size);
 	}
 	return diag;
 }
@@ -602,8 +592,7 @@ unsigned long kdb_task_state_string(const char *s)
 			res = ~0UL;
 			break;
 		default:
-			  kdb_printf("%s: unknown flag '%c' ignored\n",
-				     __func__, *s);
+			  kdb_func_printf("unknown flag '%c' ignored\n", *s);
 			  break;
 		}
 		++s;
@@ -884,18 +873,16 @@ void debug_kusage(void)
 	if (!debug_kusage_one_time)
 		goto out;
 	debug_kusage_one_time = 0;
-	kdb_printf("%s: debug_kmalloc memory leak dah_first %d\n",
-		   __func__, dah_first);
+	kdb_func_printf("debug_kmalloc memory leak dah_first %d\n", dah_first);
 	if (dah_first) {
 		h_used = (struct debug_alloc_header *)debug_alloc_pool;
-		kdb_printf("%s: h_used %px size %d\n", __func__, h_used,
-			   h_used->size);
+		kdb_func_printf("h_used %px size %d\n", h_used, h_used->size);
 	}
 	do {
 		h_used = (struct debug_alloc_header *)
 			  ((char *)h_free + dah_overhead + h_free->size);
-		kdb_printf("%s: h_used %px size %d caller %px\n",
-			   __func__, h_used, h_used->size, h_used->caller);
+		kdb_func_printf("h_used %px size %d caller %px\n",
+				h_used, h_used->size, h_used->caller);
 		h_free = (struct debug_alloc_header *)
 			  (debug_alloc_pool + h_free->next);
 	} while (h_free->next);
@@ -903,8 +890,8 @@ void debug_kusage(void)
 		  ((char *)h_free + dah_overhead + h_free->size);
 	if ((char *)h_used - debug_alloc_pool !=
 	    sizeof(debug_alloc_pool_aligned))
-		kdb_printf("%s: h_used %px size %d caller %px\n",
-			   __func__, h_used, h_used->size, h_used->caller);
+		kdb_func_printf("h_used %px size %d caller %px\n",
+				h_used, h_used->size, h_used->caller);
 out:
 	spin_unlock(&dap_lock);
 }
-- 
1.8.3.1

