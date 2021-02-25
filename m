Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C68324F15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhBYLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbhBYLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:23:55 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730BFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 03:23:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e6so3579242pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 03:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fT5ZJ7ptu7a4J8WYOCMKxd9gNGF8BQfmCfHE7FDGbTs=;
        b=EqhHmamyqIw3JrPopf1F3JDEEuPNMws7udc1QldbrQc0kBHBpTZoBylugNe1GJo8iQ
         XKpvjCRFiOMae8XWn1oVAmXxvJVPfy5dYqazJ5+LytRVU/l19ozdcXdurysPMXEoxWR3
         cfyjsMZgPCTWnj9VEE6lAceJ4LyjW438nIaklxXLNw+HOz/36+thXvT0TC9hYxFOTWLB
         s8iBvhDmHXduTS1ZSejN0nLNHdxvU91Y7t8HDENZSAdBLR81C6TWr/NPi4dqo3OEIAHj
         HZGsRhyAgUaWtpyajzVEjF3kf2j51g98xTBVZbxSDYjJ3SXjQyk2lqUirTe+1Kyib1lw
         y3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fT5ZJ7ptu7a4J8WYOCMKxd9gNGF8BQfmCfHE7FDGbTs=;
        b=U7CH3fP5pLkkTzNdhn3djPESTklt++o3QniubnU6rGPpXskRoQOQX5pQqNSemWFUoB
         KiyzsDEtDLN4UtTJ2O9RLil6gUWKh5D5dkBHCNJN/XXj7RlozPyD7FPXYNCFE9M9W26p
         SxcdEP7hwzFdjOaSakEPsQy+OHLrPv2ztTEqBPS2qYPETs9z7SJsND9mDOJnU/6uOFgC
         pv1P9VEu9Fm5cfx5EAXrueYMzrbWJaf1Z88N519LDyzm66Zeuy0YfVOCONLhw1Z9OJtP
         9cP+IB5OAMXUq14mXj9TijlBSgWPE2nwI4QdAzijwP3pwmvEvu/MOKnPTT/SdC5PZ5z+
         6Dvg==
X-Gm-Message-State: AOAM532iynvURQK1NNbWA2uyhsZu9nTAfaxWBzohNyOy+qtu6n7lH8Nx
        q0i8iK1SuQo2T9kHsh0BkeUosw==
X-Google-Smtp-Source: ABdhPJyib+T1PlD2JpbN2ROMDw5tlN6ufndlCiIBUqDZzyj1avRRnTaQR6UbfOYYqllPPsaEPcmgkQ==
X-Received: by 2002:a63:4d41:: with SMTP id n1mr2609785pgl.147.1614252194750;
        Thu, 25 Feb 2021 03:23:14 -0800 (PST)
Received: from sumit-XPS.supermicro.com ([122.173.196.104])
        by smtp.gmail.com with ESMTPSA id q126sm5905380pfb.111.2021.02.25.03.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 03:23:14 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] kdb: Get rid of custom debug heap allocator
Date:   Thu, 25 Feb 2021 16:52:58 +0530
Message-Id: <20210225112258.978417-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the only user for debug heap is kdbnearsym() which can be
modified to rather ask the caller to supply a buffer for symbol name.
So do that and modify kdbnearsym() callers to pass a symbol name buffer
allocated from stack and hence remove custom debug heap allocator.

This change has been tested using kgdbtest on arm64 which doesn't show
any regressions.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_debugger.c |   1 -
 kernel/debug/kdb/kdb_main.c     |   6 +-
 kernel/debug/kdb/kdb_private.h  |   7 +-
 kernel/debug/kdb/kdb_support.c  | 294 +-------------------------------
 4 files changed, 11 insertions(+), 297 deletions(-)

diff --git a/kernel/debug/kdb/kdb_debugger.c b/kernel/debug/kdb/kdb_debugger.c
index 0220afda3200..e91fc3e4edd5 100644
--- a/kernel/debug/kdb/kdb_debugger.c
+++ b/kernel/debug/kdb/kdb_debugger.c
@@ -140,7 +140,6 @@ int kdb_stub(struct kgdb_state *ks)
 	 */
 	kdb_common_deinit_state();
 	KDB_STATE_CLEAR(PAGER);
-	kdbnearsym_cleanup();
 	if (error == KDB_CMD_KGDB) {
 		if (KDB_STATE(DOING_KGDB))
 			KDB_STATE_CLEAR(DOING_KGDB);
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 9d69169582c6..ca525a3e0032 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
 	char symbol = '\0';
 	char *cp;
 	kdb_symtab_t symtab;
+	char namebuf[KSYM_NAME_LEN];
 
 	/*
 	 * If the enable flags prohibit both arbitrary memory access
@@ -585,7 +586,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
 	}
 
 	if (!found)
-		found = kdbnearsym(addr, &symtab);
+		found = kdbnearsym(addr, &symtab, namebuf);
 
 	(*nextarg)++;
 
@@ -1503,6 +1504,7 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 	int i;
 	int j;
 	unsigned long word;
+	char namebuf[KSYM_NAME_LEN];
 
 	memset(cbuf, '\0', sizeof(cbuf));
 	if (phys)
@@ -1518,7 +1520,7 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 			break;
 		kdb_printf(fmtstr, word);
 		if (symbolic)
-			kdbnearsym(word, &symtab);
+			kdbnearsym(word, &symtab, namebuf);
 		else
 			memset(&symtab, 0, sizeof(symtab));
 		if (symtab.sym_name) {
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index b857a84de3b5..1707eeebc59a 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -108,8 +108,7 @@ extern char *kdbgetenv(const char *);
 extern int kdbgetaddrarg(int, const char **, int*, unsigned long *,
 			 long *, char **);
 extern int kdbgetsymval(const char *, kdb_symtab_t *);
-extern int kdbnearsym(unsigned long, kdb_symtab_t *);
-extern void kdbnearsym_cleanup(void);
+extern int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab, char *namebuf);
 extern char *kdb_strdup(const char *str, gfp_t type);
 extern void kdb_symbol_print(unsigned long, const kdb_symtab_t *, unsigned int);
 
@@ -233,10 +232,6 @@ extern struct task_struct *kdb_curr_task(int);
 
 #define GFP_KDB (in_dbg_master() ? GFP_ATOMIC : GFP_KERNEL)
 
-extern void *debug_kmalloc(size_t size, gfp_t flags);
-extern void debug_kfree(void *);
-extern void debug_kusage(void);
-
 extern struct task_struct *kdb_current_task;
 extern struct pt_regs *kdb_current_regs;
 
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index b59aad1f0b55..319b36ceedf9 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -57,8 +57,6 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
 }
 EXPORT_SYMBOL(kdbgetsymval);
 
-static char *kdb_name_table[100];	/* arbitrary size */
-
 /*
  * kdbnearsym -	Return the name of the symbol with the nearest address
  *	less than 'addr'.
@@ -79,13 +77,11 @@ static char *kdb_name_table[100];	/* arbitrary size */
  *	hold active strings, no kdb caller of kdbnearsym makes more
  *	than ~20 later calls before using a saved value.
  */
-int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
+int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab, char *namebuf)
 {
 	int ret = 0;
 	unsigned long symbolsize = 0;
 	unsigned long offset = 0;
-#define knt1_size 128		/* must be >= kallsyms table size */
-	char *knt1 = NULL;
 
 	if (KDB_DEBUG(AR))
 		kdb_printf("kdbnearsym: addr=0x%lx, symtab=%px\n", addr, symtab);
@@ -93,14 +89,9 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 
 	if (addr < 4096)
 		goto out;
-	knt1 = debug_kmalloc(knt1_size, GFP_ATOMIC);
-	if (!knt1) {
-		kdb_printf("kdbnearsym: addr=0x%lx cannot kmalloc knt1\n",
-			   addr);
-		goto out;
-	}
+
 	symtab->sym_name = kallsyms_lookup(addr, &symbolsize , &offset,
-				(char **)(&symtab->mod_name), knt1);
+				(char **)(&symtab->mod_name), namebuf);
 	if (offset > 8*1024*1024) {
 		symtab->sym_name = NULL;
 		addr = offset = symbolsize = 0;
@@ -109,42 +100,6 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 	symtab->sym_end = symtab->sym_start + symbolsize;
 	ret = symtab->sym_name != NULL && *(symtab->sym_name) != '\0';
 
-	if (ret) {
-		int i;
-		/* Another 2.6 kallsyms "feature".  Sometimes the sym_name is
-		 * set but the buffer passed into kallsyms_lookup is not used,
-		 * so it contains garbage.  The caller has to work out which
-		 * buffer needs to be saved.
-		 *
-		 * What was Rusty smoking when he wrote that code?
-		 */
-		if (symtab->sym_name != knt1) {
-			strncpy(knt1, symtab->sym_name, knt1_size);
-			knt1[knt1_size-1] = '\0';
-		}
-		for (i = 0; i < ARRAY_SIZE(kdb_name_table); ++i) {
-			if (kdb_name_table[i] &&
-			    strcmp(kdb_name_table[i], knt1) == 0)
-				break;
-		}
-		if (i >= ARRAY_SIZE(kdb_name_table)) {
-			debug_kfree(kdb_name_table[0]);
-			memmove(kdb_name_table, kdb_name_table+1,
-			       sizeof(kdb_name_table[0]) *
-			       (ARRAY_SIZE(kdb_name_table)-1));
-		} else {
-			debug_kfree(knt1);
-			knt1 = kdb_name_table[i];
-			memmove(kdb_name_table+i, kdb_name_table+i+1,
-			       sizeof(kdb_name_table[0]) *
-			       (ARRAY_SIZE(kdb_name_table)-i-1));
-		}
-		i = ARRAY_SIZE(kdb_name_table) - 1;
-		kdb_name_table[i] = knt1;
-		symtab->sym_name = kdb_name_table[i];
-		knt1 = NULL;
-	}
-
 	if (symtab->mod_name == NULL)
 		symtab->mod_name = "kernel";
 	if (KDB_DEBUG(AR))
@@ -152,23 +107,10 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 		   "symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
 		   symtab->sym_start, symtab->mod_name, symtab->sym_name,
 		   symtab->sym_name);
-
 out:
-	debug_kfree(knt1);
 	return ret;
 }
 
-void kdbnearsym_cleanup(void)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(kdb_name_table); ++i) {
-		if (kdb_name_table[i]) {
-			debug_kfree(kdb_name_table[i]);
-			kdb_name_table[i] = NULL;
-		}
-	}
-}
-
 static char ks_namebuf[KSYM_NAME_LEN+1], ks_namebuf_prev[KSYM_NAME_LEN+1];
 
 /*
@@ -259,11 +201,13 @@ void kdb_symbol_print(unsigned long addr, const kdb_symtab_t *symtab_p,
 		      unsigned int punc)
 {
 	kdb_symtab_t symtab, *symtab_p2;
+	char namebuf[KSYM_NAME_LEN];
+
 	if (symtab_p) {
 		symtab_p2 = (kdb_symtab_t *)symtab_p;
 	} else {
 		symtab_p2 = &symtab;
-		kdbnearsym(addr, symtab_p2);
+		kdbnearsym(addr, symtab_p2, namebuf);
 	}
 	if (!(symtab_p2->sym_name || (punc & KDB_SP_VALUE)))
 		return;
@@ -665,232 +609,6 @@ unsigned long kdb_task_state(const struct task_struct *p, unsigned long mask)
 	return (mask & kdb_task_state_string(state)) != 0;
 }
 
-/* Last ditch allocator for debugging, so we can still debug even when
- * the GFP_ATOMIC pool has been exhausted.  The algorithms are tuned
- * for space usage, not for speed.  One smallish memory pool, the free
- * chain is always in ascending address order to allow coalescing,
- * allocations are done in brute force best fit.
- */
-
-struct debug_alloc_header {
-	u32 next;	/* offset of next header from start of pool */
-	u32 size;
-	void *caller;
-};
-
-/* The memory returned by this allocator must be aligned, which means
- * so must the header size.  Do not assume that sizeof(struct
- * debug_alloc_header) is a multiple of the alignment, explicitly
- * calculate the overhead of this header, including the alignment.
- * The rest of this code must not use sizeof() on any header or
- * pointer to a header.
- */
-#define dah_align 8
-#define dah_overhead ALIGN(sizeof(struct debug_alloc_header), dah_align)
-
-static u64 debug_alloc_pool_aligned[256*1024/dah_align];	/* 256K pool */
-static char *debug_alloc_pool = (char *)debug_alloc_pool_aligned;
-static u32 dah_first, dah_first_call = 1, dah_used, dah_used_max;
-
-/* Locking is awkward.  The debug code is called from all contexts,
- * including non maskable interrupts.  A normal spinlock is not safe
- * in NMI context.  Try to get the debug allocator lock, if it cannot
- * be obtained after a second then give up.  If the lock could not be
- * previously obtained on this cpu then only try once.
- *
- * sparse has no annotation for "this function _sometimes_ acquires a
- * lock", so fudge the acquire/release notation.
- */
-static DEFINE_SPINLOCK(dap_lock);
-static int get_dap_lock(void)
-	__acquires(dap_lock)
-{
-	static int dap_locked = -1;
-	int count;
-	if (dap_locked == smp_processor_id())
-		count = 1;
-	else
-		count = 1000;
-	while (1) {
-		if (spin_trylock(&dap_lock)) {
-			dap_locked = -1;
-			return 1;
-		}
-		if (!count--)
-			break;
-		udelay(1000);
-	}
-	dap_locked = smp_processor_id();
-	__acquire(dap_lock);
-	return 0;
-}
-
-void *debug_kmalloc(size_t size, gfp_t flags)
-{
-	unsigned int rem, h_offset;
-	struct debug_alloc_header *best, *bestprev, *prev, *h;
-	void *p = NULL;
-	if (!get_dap_lock()) {
-		__release(dap_lock);	/* we never actually got it */
-		return NULL;
-	}
-	h = (struct debug_alloc_header *)(debug_alloc_pool + dah_first);
-	if (dah_first_call) {
-		h->size = sizeof(debug_alloc_pool_aligned) - dah_overhead;
-		dah_first_call = 0;
-	}
-	size = ALIGN(size, dah_align);
-	prev = best = bestprev = NULL;
-	while (1) {
-		if (h->size >= size && (!best || h->size < best->size)) {
-			best = h;
-			bestprev = prev;
-			if (h->size == size)
-				break;
-		}
-		if (!h->next)
-			break;
-		prev = h;
-		h = (struct debug_alloc_header *)(debug_alloc_pool + h->next);
-	}
-	if (!best)
-		goto out;
-	rem = best->size - size;
-	/* The pool must always contain at least one header */
-	if (best->next == 0 && bestprev == NULL && rem < dah_overhead)
-		goto out;
-	if (rem >= dah_overhead) {
-		best->size = size;
-		h_offset = ((char *)best - debug_alloc_pool) +
-			   dah_overhead + best->size;
-		h = (struct debug_alloc_header *)(debug_alloc_pool + h_offset);
-		h->size = rem - dah_overhead;
-		h->next = best->next;
-	} else
-		h_offset = best->next;
-	best->caller = __builtin_return_address(0);
-	dah_used += best->size;
-	dah_used_max = max(dah_used, dah_used_max);
-	if (bestprev)
-		bestprev->next = h_offset;
-	else
-		dah_first = h_offset;
-	p = (char *)best + dah_overhead;
-	memset(p, POISON_INUSE, best->size - 1);
-	*((char *)p + best->size - 1) = POISON_END;
-out:
-	spin_unlock(&dap_lock);
-	return p;
-}
-
-void debug_kfree(void *p)
-{
-	struct debug_alloc_header *h;
-	unsigned int h_offset;
-	if (!p)
-		return;
-	if ((char *)p < debug_alloc_pool ||
-	    (char *)p >= debug_alloc_pool + sizeof(debug_alloc_pool_aligned)) {
-		kfree(p);
-		return;
-	}
-	if (!get_dap_lock()) {
-		__release(dap_lock);	/* we never actually got it */
-		return;		/* memory leak, cannot be helped */
-	}
-	h = (struct debug_alloc_header *)((char *)p - dah_overhead);
-	memset(p, POISON_FREE, h->size - 1);
-	*((char *)p + h->size - 1) = POISON_END;
-	h->caller = NULL;
-	dah_used -= h->size;
-	h_offset = (char *)h - debug_alloc_pool;
-	if (h_offset < dah_first) {
-		h->next = dah_first;
-		dah_first = h_offset;
-	} else {
-		struct debug_alloc_header *prev;
-		unsigned int prev_offset;
-		prev = (struct debug_alloc_header *)(debug_alloc_pool +
-						     dah_first);
-		while (1) {
-			if (!prev->next || prev->next > h_offset)
-				break;
-			prev = (struct debug_alloc_header *)
-				(debug_alloc_pool + prev->next);
-		}
-		prev_offset = (char *)prev - debug_alloc_pool;
-		if (prev_offset + dah_overhead + prev->size == h_offset) {
-			prev->size += dah_overhead + h->size;
-			memset(h, POISON_FREE, dah_overhead - 1);
-			*((char *)h + dah_overhead - 1) = POISON_END;
-			h = prev;
-			h_offset = prev_offset;
-		} else {
-			h->next = prev->next;
-			prev->next = h_offset;
-		}
-	}
-	if (h_offset + dah_overhead + h->size == h->next) {
-		struct debug_alloc_header *next;
-		next = (struct debug_alloc_header *)
-			(debug_alloc_pool + h->next);
-		h->size += dah_overhead + next->size;
-		h->next = next->next;
-		memset(next, POISON_FREE, dah_overhead - 1);
-		*((char *)next + dah_overhead - 1) = POISON_END;
-	}
-	spin_unlock(&dap_lock);
-}
-
-void debug_kusage(void)
-{
-	struct debug_alloc_header *h_free, *h_used;
-#ifdef	CONFIG_IA64
-	/* FIXME: using dah for ia64 unwind always results in a memory leak.
-	 * Fix that memory leak first, then set debug_kusage_one_time = 1 for
-	 * all architectures.
-	 */
-	static int debug_kusage_one_time;
-#else
-	static int debug_kusage_one_time = 1;
-#endif
-	if (!get_dap_lock()) {
-		__release(dap_lock);	/* we never actually got it */
-		return;
-	}
-	h_free = (struct debug_alloc_header *)(debug_alloc_pool + dah_first);
-	if (dah_first == 0 &&
-	    (h_free->size == sizeof(debug_alloc_pool_aligned) - dah_overhead ||
-	     dah_first_call))
-		goto out;
-	if (!debug_kusage_one_time)
-		goto out;
-	debug_kusage_one_time = 0;
-	kdb_printf("%s: debug_kmalloc memory leak dah_first %d\n",
-		   __func__, dah_first);
-	if (dah_first) {
-		h_used = (struct debug_alloc_header *)debug_alloc_pool;
-		kdb_printf("%s: h_used %px size %d\n", __func__, h_used,
-			   h_used->size);
-	}
-	do {
-		h_used = (struct debug_alloc_header *)
-			  ((char *)h_free + dah_overhead + h_free->size);
-		kdb_printf("%s: h_used %px size %d caller %px\n",
-			   __func__, h_used, h_used->size, h_used->caller);
-		h_free = (struct debug_alloc_header *)
-			  (debug_alloc_pool + h_free->next);
-	} while (h_free->next);
-	h_used = (struct debug_alloc_header *)
-		  ((char *)h_free + dah_overhead + h_free->size);
-	if ((char *)h_used - debug_alloc_pool !=
-	    sizeof(debug_alloc_pool_aligned))
-		kdb_printf("%s: h_used %px size %d caller %px\n",
-			   __func__, h_used, h_used->size, h_used->caller);
-out:
-	spin_unlock(&dap_lock);
-}
-
 /* Maintain a small stack of kdb_flags to allow recursion without disturbing
  * the global kdb state.
  */
-- 
2.25.1

