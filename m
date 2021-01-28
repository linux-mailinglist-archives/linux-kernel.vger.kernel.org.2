Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3389D30703D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhA1Hwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhA1Hv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:51:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6E0C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:50:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cq1so3378497pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hT80TtmG5OwKagfHit/H5eiRj+ThJh8wbDF2bWBnIXM=;
        b=az/eVNzirGkm+vaBPFwmPpvXG6bhWkMbG2rX4mFSKcr/ho897PJj/i6JnS0QgXKZUC
         yvzERcT9VoyZga4VqkSFxe8U27587u7mkQTxkQFjFmihBlNMAZy5iFs2F43XYL8vnedm
         kaDtoFn2jfYmP1XpArxUPn+6NbKfnByo/8CR1wvzD50f5iqfnFaCN56iePihTSpj9sBV
         an6zm1rnQtNJpqHNM3z/2u9c/WaRtwIDBw0b0dWFcAjWxZFhL/1EmkoMMkZFEpnjjsu+
         7mP69nDkLp36vgU55Be+iRjTnnuYv1P35XFVYlLfkJhBruQMiJlArrtA7ZEN+gYQqzPO
         t1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hT80TtmG5OwKagfHit/H5eiRj+ThJh8wbDF2bWBnIXM=;
        b=piQ2BbcP3YDnsMDWyakO1Dgu33CBverD4eqTL8EVXGqmVLNgK4HPC0HkraJEbfl3IR
         vPt62aP/mViqrUFh/EMpnTbAV80fkAkCqMGd521hs0U64FatKELNmJeCU+2drxlHrL/U
         0UX8k7uTq76B5Jry14H/4uaA5O68FPei+ueVn0qf9KXtzyz9Rq2ECK27EwGStUeVmiKU
         Ll2AJQjbeHxjOpemU0ZDTbhkWcmQN18cyE5j8+qbKt7pl475ftPk0aLYGkT7oEAns5WO
         ig6G1PC3m6cm7XJkbbViPnh73i76/B5TeUWVCbdqNktPHAiMDjlCzeOm0IsQDFGSDkzb
         dv0A==
X-Gm-Message-State: AOAM530kxlI+NJDzpwLX/EX7tj6i5T3cIxRvDP+eke8E+rQB8OIWFGAa
        uM4boqUR+YUUGq/++Ov1ANw=
X-Google-Smtp-Source: ABdhPJwjPsSkUYriKV0MMeAuZLm1Tb6hXi6QweSfRjTG6GQaQW9NWwDvbZ0OjRk9YvfC0gaGm+BDiw==
X-Received: by 2002:a17:903:1cc:b029:de:98bb:d46d with SMTP id e12-20020a17090301ccb02900de98bbd46dmr15423814plh.54.1611820202819;
        Wed, 27 Jan 2021 23:50:02 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id q15sm4514816pgk.11.2021.01.27.23.50.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 23:50:02 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, gustavoars@kernel.org
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH v2] kdb: kdb_support: Fix debugging information problem
Date:   Thu, 28 Jan 2021 15:49:50 +0800
Message-Id: <1611820190-12559-1-git-send-email-stephenzhangzsd@gmail.com>
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

 kernel/debug/kdb/kdb_private.h | 10 ++++++++
 kernel/debug/kdb/kdb_support.c | 56 +++++++++++++++++++-----------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

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
index 6226502..0f6fc77 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -39,20 +39,17 @@
  */
 int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
 {
-	if (KDB_DEBUG(AR))
-		kdb_printf("kdbgetsymval: symname=%s, symtab=%px\n", symname,
-			   symtab);
+	kdb_dbg_printf(AR, "symname=%s, symtab=%px\n", symname,
+		symtab);
 	memset(symtab, 0, sizeof(*symtab));
 	symtab->sym_start = kallsyms_lookup_name(symname);
 	if (symtab->sym_start) {
-		if (KDB_DEBUG(AR))
-			kdb_printf("kdbgetsymval: returns 1, "
-				   "symtab->sym_start=0x%lx\n",
-				   symtab->sym_start);
+		kdb_dbg_printf(AR, "returns 1, "
+			"symtab->sym_start=0x%lx\n",
+			symtab->sym_start);
 		return 1;
 	}
-	if (KDB_DEBUG(AR))
-		kdb_printf("kdbgetsymval: returns 0\n");
+	kdb_dbg_printf(AR, "returns 0\n");
 	return 0;
 }
 EXPORT_SYMBOL(kdbgetsymval);
@@ -87,15 +84,14 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
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
+		kdb_func_printf("addr=0x%lx cannot kmalloc knt1\n",
 			   addr);
 		goto out;
 	}
@@ -147,11 +143,10 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 
 	if (symtab->mod_name == NULL)
 		symtab->mod_name = "kernel";
-	if (KDB_DEBUG(AR))
-		kdb_printf("kdbnearsym: returns %d symtab->sym_start=0x%lx, "
-		   "symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
-		   symtab->sym_start, symtab->mod_name, symtab->sym_name,
-		   symtab->sym_name);
+	kdb_dbg_printf(AR, "returns %d symtab->sym_start=0x%lx, "
+		"symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
+		symtab->sym_start, symtab->mod_name, symtab->sym_name,
+		symtab->sym_name);
 
 out:
 	debug_kfree(knt1);
@@ -328,7 +323,7 @@ int kdb_getarea_size(void *res, unsigned long addr, size_t size)
 	int ret = copy_from_kernel_nofault((char *)res, (char *)addr, size);
 	if (ret) {
 		if (!KDB_STATE(SUPPRESS)) {
-			kdb_printf("kdb_getarea: Bad address 0x%lx\n", addr);
+			kdb_func_printf("Bad address 0x%lx\n", addr);
 			KDB_STATE_SET(SUPPRESS);
 		}
 		ret = KDB_BADADDR;
@@ -353,7 +348,7 @@ int kdb_putarea_size(unsigned long addr, void *res, size_t size)
 	int ret = copy_from_kernel_nofault((char *)addr, (char *)res, size);
 	if (ret) {
 		if (!KDB_STATE(SUPPRESS)) {
-			kdb_printf("kdb_putarea: Bad address 0x%lx\n", addr);
+			kdb_func_printf("Bad address 0x%lx\n", addr);
 			KDB_STATE_SET(SUPPRESS);
 		}
 		ret = KDB_BADADDR;
@@ -435,7 +430,7 @@ int kdb_getphysword(unsigned long *word, unsigned long addr, size_t size)
 		fallthrough;
 	default:
 		diag = KDB_BADWIDTH;
-		kdb_printf("kdb_getphysword: bad width %ld\n", (long) size);
+		kdb_func_printf("bad width %zu\n", size);
 	}
 	return diag;
 }
@@ -484,7 +479,7 @@ int kdb_getword(unsigned long *word, unsigned long addr, size_t size)
 		fallthrough;
 	default:
 		diag = KDB_BADWIDTH;
-		kdb_printf("kdb_getword: bad width %ld\n", (long) size);
+		kdb_func_printf("bad width %zu\n", size);
 	}
 	return diag;
 }
@@ -528,7 +523,7 @@ int kdb_putword(unsigned long addr, unsigned long word, size_t size)
 		fallthrough;
 	default:
 		diag = KDB_BADWIDTH;
-		kdb_printf("kdb_putword: bad width %ld\n", (long) size);
+		kdb_func_printf("bad width %zu\n", size);
 	}
 	return diag;
 }
@@ -602,8 +597,7 @@ unsigned long kdb_task_state_string(const char *s)
 			res = ~0UL;
 			break;
 		default:
-			  kdb_printf("%s: unknown flag '%c' ignored\n",
-				     __func__, *s);
+			  kdb_func_printf("unknown flag '%c' ignored\n", *s);
 			  break;
 		}
 		++s;
@@ -884,18 +878,18 @@ void debug_kusage(void)
 	if (!debug_kusage_one_time)
 		goto out;
 	debug_kusage_one_time = 0;
-	kdb_printf("%s: debug_kmalloc memory leak dah_first %d\n",
-		   __func__, dah_first);
+	kdb_func_printf("debug_kmalloc memory leak dah_first %d\n",
+		dah_first);
 	if (dah_first) {
 		h_used = (struct debug_alloc_header *)debug_alloc_pool;
-		kdb_printf("%s: h_used %px size %d\n", __func__, h_used,
+		kdb_func_printf("h_used %px size %d\n", h_used,
 			   h_used->size);
 	}
 	do {
 		h_used = (struct debug_alloc_header *)
 			  ((char *)h_free + dah_overhead + h_free->size);
-		kdb_printf("%s: h_used %px size %d caller %px\n",
-			   __func__, h_used, h_used->size, h_used->caller);
+		kdb_func_printf("h_used %px size %d caller %px\n",
+			  h_used, h_used->size, h_used->caller);
 		h_free = (struct debug_alloc_header *)
 			  (debug_alloc_pool + h_free->next);
 	} while (h_free->next);
@@ -903,8 +897,8 @@ void debug_kusage(void)
 		  ((char *)h_free + dah_overhead + h_free->size);
 	if ((char *)h_used - debug_alloc_pool !=
 	    sizeof(debug_alloc_pool_aligned))
-		kdb_printf("%s: h_used %px size %d caller %px\n",
-			   __func__, h_used, h_used->size, h_used->caller);
+		kdb_func_printf("h_used %px size %d caller %px\n",
+			   h_used, h_used->size, h_used->caller);
 out:
 	spin_unlock(&dap_lock);
 }
-- 
1.8.3.1

