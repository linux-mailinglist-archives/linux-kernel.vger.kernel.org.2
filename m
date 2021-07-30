Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139EC3DB6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhG3KGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbhG3KGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:06:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C69C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:06:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n11so5612427wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZCcGFkX6Bqo+Hf34lmVda/LH6/X1FTt2E15C0rpUPo=;
        b=vs3d+ul5MQqZmNw+pxbcyplj2PTslWz1HeB7H2zIrjkPAXubWI+bDCEGXEo5mCqyBn
         3WMBO/RdXk8mJYVFGHWVQ1On7XdJij+TG2Z7cVxWT3u7sKRDFOidi7bSVsKZoIUmUsed
         31uWfOzpsMHnarxbUIh1p2ilqQj1nPw/PSSrzeIITl00cmyxbzEy+IF5mEMCRS4CwpDL
         JvaOTuthY7/qhFuf6hpX+kKQTZpVjoi8FObWdBFFtf2Y7NCe66sMv/uPkOwnls9gf0Yn
         Zh//S7fpUH5KNq72ZQBnbW2TDhlYIe89Xr83sMa9bbz57JlIbyPY79BJ1546YD1UHfRe
         aJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZCcGFkX6Bqo+Hf34lmVda/LH6/X1FTt2E15C0rpUPo=;
        b=pmE0yjHnkV9RgGKUw/SYnOiZ9k+oC/CQbsgkbh9v8RPCkAGpY7/WL3lXbOfVGYo4uN
         V9Wr+ICqogut6zN8IkyvTHkeVFDeoCGSi2AUpBfot0pE/45vsZSHBQmBI2e9uiKiuLRT
         892wQG+5O2yG02dDlTFrf4Cax0Ek/wcTFQF/XZzz3a/aMG30LYzLcLYlaqb4JmhShfZ3
         9sshSeoTm71/YQSOAE+UUTXbODc/6zGYj6mMv73EWqqjAvUUs0n2xxevI8N1djcCJe3v
         p7yTpM6gxL9JkJqTmvQ7azxCVQyzsarHl/r+3/BIQ3ZbfspHnpQ3PAa56h5jHQtU12MA
         NNpA==
X-Gm-Message-State: AOAM533kfnpaEPDufajEZ4yWoWG3tIOkVwr2H7dV6OWYtm7cguYe4Y6C
        rmNXWa9WjRO6AqJzWGVwcWIjvQ==
X-Google-Smtp-Source: ABdhPJzaoRinW6ngWboXwLkcl7u2/0RUszPKtewjSfr+GLRgNCtKz0EQeebDgIeWP8Bd4qEMza9jng==
X-Received: by 2002:a05:600c:1551:: with SMTP id f17mr2125992wmg.38.1627639571804;
        Fri, 30 Jul 2021 03:06:11 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l5sm1235137wrc.90.2021.07.30.03.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 03:06:11 -0700 (PDT)
Date:   Fri, 30 Jul 2021 11:06:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kdb: Get rid of custom debug heap allocator
Message-ID: <20210730100609.cbag3rwesgdrskub@maple.lan>
References: <20210714055620.369915-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714055620.369915-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 11:26:20AM +0530, Sumit Garg wrote:
> Currently the only user for debug heap is kdbnearsym() which can be
> modified to rather use statically allocated buffer for symbol name as
> per it's current usage. So do that and hence remove custom debug heap
> allocator.
> 
> Note that this change puts a restriction on kdbnearsym() callers to
> carefully use shared namebuf such that a caller should consume the symbol
> returned immediately prior to another call to fetch a different symbol.
> 
> Also, this change uses standard KSYM_NAME_LEN macro for namebuf
> allocation instead of local variable: knt1_size which should avoid any
> conflicts caused by changes to KSYM_NAME_LEN macro value.
> 
> This change has been tested using kgdbtest on arm64 which doesn't show
> any regressions.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Applied, thanks!


> ---
> 
> Changes in v4:
> - Addressed minor comments from Doug.
> - Picked up Doug's review tag.
> 
> Changes in v3:
> - Rebased to tip of upstream master.
> - Updated function header comment for kdbnearsym().
> 
> Changes in v2:
> - Use single static buffer for symbol name in kdbnearsym() instead of
>   per caller buffers allocated on stack.
> 
>  kernel/debug/kdb/kdb_debugger.c |   1 -
>  kernel/debug/kdb/kdb_private.h  |   5 -
>  kernel/debug/kdb/kdb_support.c  | 329 +++-----------------------------
>  3 files changed, 28 insertions(+), 307 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_debugger.c b/kernel/debug/kdb/kdb_debugger.c
> index 0220afda3200..e91fc3e4edd5 100644
> --- a/kernel/debug/kdb/kdb_debugger.c
> +++ b/kernel/debug/kdb/kdb_debugger.c
> @@ -140,7 +140,6 @@ int kdb_stub(struct kgdb_state *ks)
>  	 */
>  	kdb_common_deinit_state();
>  	KDB_STATE_CLEAR(PAGER);
> -	kdbnearsym_cleanup();
>  	if (error == KDB_CMD_KGDB) {
>  		if (KDB_STATE(DOING_KGDB))
>  			KDB_STATE_CLEAR(DOING_KGDB);
> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index 170c69aedebb..8dbc840113c9 100644
> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -109,7 +109,6 @@ extern int kdbgetaddrarg(int, const char **, int*, unsigned long *,
>  			 long *, char **);
>  extern int kdbgetsymval(const char *, kdb_symtab_t *);
>  extern int kdbnearsym(unsigned long, kdb_symtab_t *);
> -extern void kdbnearsym_cleanup(void);
>  extern char *kdb_strdup(const char *str, gfp_t type);
>  extern void kdb_symbol_print(unsigned long, const kdb_symtab_t *, unsigned int);
>  
> @@ -233,10 +232,6 @@ extern struct task_struct *kdb_curr_task(int);
>  
>  #define GFP_KDB (in_dbg_master() ? GFP_ATOMIC : GFP_KERNEL)
>  
> -extern void *debug_kmalloc(size_t size, gfp_t flags);
> -extern void debug_kfree(void *);
> -extern void debug_kusage(void);
> -
>  extern struct task_struct *kdb_current_task;
>  extern struct pt_regs *kdb_current_regs;
>  
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index 9f50d22d68e6..c605b17b2a0d 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -52,48 +52,48 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
>  }
>  EXPORT_SYMBOL(kdbgetsymval);
>  
> -static char *kdb_name_table[100];	/* arbitrary size */
> -
> -/*
> - * kdbnearsym -	Return the name of the symbol with the nearest address
> - *	less than 'addr'.
> +/**
> + * kdbnearsym() - Return the name of the symbol with the nearest address
> + *                less than @addr.
> + * @addr: Address to check for near symbol
> + * @symtab: Structure to receive results
>   *
> - * Parameters:
> - *	addr	Address to check for symbol near
> - *	symtab  Structure to receive results
> - * Returns:
> - *	0	No sections contain this address, symtab zero filled
> - *	1	Address mapped to module/symbol/section, data in symtab
> - * Remarks:
> - *	2.6 kallsyms has a "feature" where it unpacks the name into a
> - *	string.  If that string is reused before the caller expects it
> - *	then the caller sees its string change without warning.  To
> - *	avoid cluttering up the main kdb code with lots of kdb_strdup,
> - *	tests and kfree calls, kdbnearsym maintains an LRU list of the
> - *	last few unique strings.  The list is sized large enough to
> - *	hold active strings, no kdb caller of kdbnearsym makes more
> - *	than ~20 later calls before using a saved value.
> + * WARNING: This function may return a pointer to a single statically
> + * allocated buffer (namebuf). kdb's unusual calling context (single
> + * threaded, all other CPUs halted) provides us sufficient locking for
> + * this to be safe. The only constraint imposed by the static buffer is
> + * that the caller must consume any previous reply prior to another call
> + * to lookup a new symbol.
> + *
> + * Note that, strictly speaking, some architectures may re-enter the kdb
> + * trap if the system turns out to be very badly damaged and this breaks
> + * the single-threaded assumption above. In these circumstances successful
> + * continuation and exit from the inner trap is unlikely to work and any
> + * user attempting this receives a prominent warning before being allowed
> + * to progress. In these circumstances we remain memory safe because
> + * namebuf[KSYM_NAME_LEN-1] will never change from '\0' although we do
> + * tolerate the possibility of garbled symbol display from the outer kdb
> + * trap.
> + *
> + * Return:
> + * * 0 - No sections contain this address, symtab zero filled
> + * * 1 - Address mapped to module/symbol/section, data in symtab
>   */
>  int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
>  {
>  	int ret = 0;
>  	unsigned long symbolsize = 0;
>  	unsigned long offset = 0;
> -#define knt1_size 128		/* must be >= kallsyms table size */
> -	char *knt1 = NULL;
> +	static char namebuf[KSYM_NAME_LEN];
>  
>  	kdb_dbg_printf(AR, "addr=0x%lx, symtab=%px\n", addr, symtab);
>  	memset(symtab, 0, sizeof(*symtab));
>  
>  	if (addr < 4096)
>  		goto out;
> -	knt1 = debug_kmalloc(knt1_size, GFP_ATOMIC);
> -	if (!knt1) {
> -		kdb_func_printf("addr=0x%lx cannot kmalloc knt1\n", addr);
> -		goto out;
> -	}
> +
>  	symtab->sym_name = kallsyms_lookup(addr, &symbolsize , &offset,
> -				(char **)(&symtab->mod_name), knt1);
> +				(char **)(&symtab->mod_name), namebuf);
>  	if (offset > 8*1024*1024) {
>  		symtab->sym_name = NULL;
>  		addr = offset = symbolsize = 0;
> @@ -102,63 +102,14 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
>  	symtab->sym_end = symtab->sym_start + symbolsize;
>  	ret = symtab->sym_name != NULL && *(symtab->sym_name) != '\0';
>  
> -	if (ret) {
> -		int i;
> -		/* Another 2.6 kallsyms "feature".  Sometimes the sym_name is
> -		 * set but the buffer passed into kallsyms_lookup is not used,
> -		 * so it contains garbage.  The caller has to work out which
> -		 * buffer needs to be saved.
> -		 *
> -		 * What was Rusty smoking when he wrote that code?
> -		 */
> -		if (symtab->sym_name != knt1) {
> -			strncpy(knt1, symtab->sym_name, knt1_size);
> -			knt1[knt1_size-1] = '\0';
> -		}
> -		for (i = 0; i < ARRAY_SIZE(kdb_name_table); ++i) {
> -			if (kdb_name_table[i] &&
> -			    strcmp(kdb_name_table[i], knt1) == 0)
> -				break;
> -		}
> -		if (i >= ARRAY_SIZE(kdb_name_table)) {
> -			debug_kfree(kdb_name_table[0]);
> -			memmove(kdb_name_table, kdb_name_table+1,
> -			       sizeof(kdb_name_table[0]) *
> -			       (ARRAY_SIZE(kdb_name_table)-1));
> -		} else {
> -			debug_kfree(knt1);
> -			knt1 = kdb_name_table[i];
> -			memmove(kdb_name_table+i, kdb_name_table+i+1,
> -			       sizeof(kdb_name_table[0]) *
> -			       (ARRAY_SIZE(kdb_name_table)-i-1));
> -		}
> -		i = ARRAY_SIZE(kdb_name_table) - 1;
> -		kdb_name_table[i] = knt1;
> -		symtab->sym_name = kdb_name_table[i];
> -		knt1 = NULL;
> -	}
> -
>  	if (symtab->mod_name == NULL)
>  		symtab->mod_name = "kernel";
>  	kdb_dbg_printf(AR, "returns %d symtab->sym_start=0x%lx, symtab->mod_name=%px, symtab->sym_name=%px (%s)\n",
>  		       ret, symtab->sym_start, symtab->mod_name, symtab->sym_name, symtab->sym_name);
> -
>  out:
> -	debug_kfree(knt1);
>  	return ret;
>  }
>  
> -void kdbnearsym_cleanup(void)
> -{
> -	int i;
> -	for (i = 0; i < ARRAY_SIZE(kdb_name_table); ++i) {
> -		if (kdb_name_table[i]) {
> -			debug_kfree(kdb_name_table[i]);
> -			kdb_name_table[i] = NULL;
> -		}
> -	}
> -}
> -
>  static char ks_namebuf[KSYM_NAME_LEN+1], ks_namebuf_prev[KSYM_NAME_LEN+1];
>  
>  /*
> @@ -656,230 +607,6 @@ unsigned long kdb_task_state(const struct task_struct *p, unsigned long mask)
>  	return (mask & kdb_task_state_string(state)) != 0;
>  }
>  
> -/* Last ditch allocator for debugging, so we can still debug even when
> - * the GFP_ATOMIC pool has been exhausted.  The algorithms are tuned
> - * for space usage, not for speed.  One smallish memory pool, the free
> - * chain is always in ascending address order to allow coalescing,
> - * allocations are done in brute force best fit.
> - */
> -
> -struct debug_alloc_header {
> -	u32 next;	/* offset of next header from start of pool */
> -	u32 size;
> -	void *caller;
> -};
> -
> -/* The memory returned by this allocator must be aligned, which means
> - * so must the header size.  Do not assume that sizeof(struct
> - * debug_alloc_header) is a multiple of the alignment, explicitly
> - * calculate the overhead of this header, including the alignment.
> - * The rest of this code must not use sizeof() on any header or
> - * pointer to a header.
> - */
> -#define dah_align 8
> -#define dah_overhead ALIGN(sizeof(struct debug_alloc_header), dah_align)
> -
> -static u64 debug_alloc_pool_aligned[256*1024/dah_align];	/* 256K pool */
> -static char *debug_alloc_pool = (char *)debug_alloc_pool_aligned;
> -static u32 dah_first, dah_first_call = 1, dah_used, dah_used_max;
> -
> -/* Locking is awkward.  The debug code is called from all contexts,
> - * including non maskable interrupts.  A normal spinlock is not safe
> - * in NMI context.  Try to get the debug allocator lock, if it cannot
> - * be obtained after a second then give up.  If the lock could not be
> - * previously obtained on this cpu then only try once.
> - *
> - * sparse has no annotation for "this function _sometimes_ acquires a
> - * lock", so fudge the acquire/release notation.
> - */
> -static DEFINE_SPINLOCK(dap_lock);
> -static int get_dap_lock(void)
> -	__acquires(dap_lock)
> -{
> -	static int dap_locked = -1;
> -	int count;
> -	if (dap_locked == smp_processor_id())
> -		count = 1;
> -	else
> -		count = 1000;
> -	while (1) {
> -		if (spin_trylock(&dap_lock)) {
> -			dap_locked = -1;
> -			return 1;
> -		}
> -		if (!count--)
> -			break;
> -		udelay(1000);
> -	}
> -	dap_locked = smp_processor_id();
> -	__acquire(dap_lock);
> -	return 0;
> -}
> -
> -void *debug_kmalloc(size_t size, gfp_t flags)
> -{
> -	unsigned int rem, h_offset;
> -	struct debug_alloc_header *best, *bestprev, *prev, *h;
> -	void *p = NULL;
> -	if (!get_dap_lock()) {
> -		__release(dap_lock);	/* we never actually got it */
> -		return NULL;
> -	}
> -	h = (struct debug_alloc_header *)(debug_alloc_pool + dah_first);
> -	if (dah_first_call) {
> -		h->size = sizeof(debug_alloc_pool_aligned) - dah_overhead;
> -		dah_first_call = 0;
> -	}
> -	size = ALIGN(size, dah_align);
> -	prev = best = bestprev = NULL;
> -	while (1) {
> -		if (h->size >= size && (!best || h->size < best->size)) {
> -			best = h;
> -			bestprev = prev;
> -			if (h->size == size)
> -				break;
> -		}
> -		if (!h->next)
> -			break;
> -		prev = h;
> -		h = (struct debug_alloc_header *)(debug_alloc_pool + h->next);
> -	}
> -	if (!best)
> -		goto out;
> -	rem = best->size - size;
> -	/* The pool must always contain at least one header */
> -	if (best->next == 0 && bestprev == NULL && rem < dah_overhead)
> -		goto out;
> -	if (rem >= dah_overhead) {
> -		best->size = size;
> -		h_offset = ((char *)best - debug_alloc_pool) +
> -			   dah_overhead + best->size;
> -		h = (struct debug_alloc_header *)(debug_alloc_pool + h_offset);
> -		h->size = rem - dah_overhead;
> -		h->next = best->next;
> -	} else
> -		h_offset = best->next;
> -	best->caller = __builtin_return_address(0);
> -	dah_used += best->size;
> -	dah_used_max = max(dah_used, dah_used_max);
> -	if (bestprev)
> -		bestprev->next = h_offset;
> -	else
> -		dah_first = h_offset;
> -	p = (char *)best + dah_overhead;
> -	memset(p, POISON_INUSE, best->size - 1);
> -	*((char *)p + best->size - 1) = POISON_END;
> -out:
> -	spin_unlock(&dap_lock);
> -	return p;
> -}
> -
> -void debug_kfree(void *p)
> -{
> -	struct debug_alloc_header *h;
> -	unsigned int h_offset;
> -	if (!p)
> -		return;
> -	if ((char *)p < debug_alloc_pool ||
> -	    (char *)p >= debug_alloc_pool + sizeof(debug_alloc_pool_aligned)) {
> -		kfree(p);
> -		return;
> -	}
> -	if (!get_dap_lock()) {
> -		__release(dap_lock);	/* we never actually got it */
> -		return;		/* memory leak, cannot be helped */
> -	}
> -	h = (struct debug_alloc_header *)((char *)p - dah_overhead);
> -	memset(p, POISON_FREE, h->size - 1);
> -	*((char *)p + h->size - 1) = POISON_END;
> -	h->caller = NULL;
> -	dah_used -= h->size;
> -	h_offset = (char *)h - debug_alloc_pool;
> -	if (h_offset < dah_first) {
> -		h->next = dah_first;
> -		dah_first = h_offset;
> -	} else {
> -		struct debug_alloc_header *prev;
> -		unsigned int prev_offset;
> -		prev = (struct debug_alloc_header *)(debug_alloc_pool +
> -						     dah_first);
> -		while (1) {
> -			if (!prev->next || prev->next > h_offset)
> -				break;
> -			prev = (struct debug_alloc_header *)
> -				(debug_alloc_pool + prev->next);
> -		}
> -		prev_offset = (char *)prev - debug_alloc_pool;
> -		if (prev_offset + dah_overhead + prev->size == h_offset) {
> -			prev->size += dah_overhead + h->size;
> -			memset(h, POISON_FREE, dah_overhead - 1);
> -			*((char *)h + dah_overhead - 1) = POISON_END;
> -			h = prev;
> -			h_offset = prev_offset;
> -		} else {
> -			h->next = prev->next;
> -			prev->next = h_offset;
> -		}
> -	}
> -	if (h_offset + dah_overhead + h->size == h->next) {
> -		struct debug_alloc_header *next;
> -		next = (struct debug_alloc_header *)
> -			(debug_alloc_pool + h->next);
> -		h->size += dah_overhead + next->size;
> -		h->next = next->next;
> -		memset(next, POISON_FREE, dah_overhead - 1);
> -		*((char *)next + dah_overhead - 1) = POISON_END;
> -	}
> -	spin_unlock(&dap_lock);
> -}
> -
> -void debug_kusage(void)
> -{
> -	struct debug_alloc_header *h_free, *h_used;
> -#ifdef	CONFIG_IA64
> -	/* FIXME: using dah for ia64 unwind always results in a memory leak.
> -	 * Fix that memory leak first, then set debug_kusage_one_time = 1 for
> -	 * all architectures.
> -	 */
> -	static int debug_kusage_one_time;
> -#else
> -	static int debug_kusage_one_time = 1;
> -#endif
> -	if (!get_dap_lock()) {
> -		__release(dap_lock);	/* we never actually got it */
> -		return;
> -	}
> -	h_free = (struct debug_alloc_header *)(debug_alloc_pool + dah_first);
> -	if (dah_first == 0 &&
> -	    (h_free->size == sizeof(debug_alloc_pool_aligned) - dah_overhead ||
> -	     dah_first_call))
> -		goto out;
> -	if (!debug_kusage_one_time)
> -		goto out;
> -	debug_kusage_one_time = 0;
> -	kdb_func_printf("debug_kmalloc memory leak dah_first %d\n", dah_first);
> -	if (dah_first) {
> -		h_used = (struct debug_alloc_header *)debug_alloc_pool;
> -		kdb_func_printf("h_used %px size %d\n", h_used, h_used->size);
> -	}
> -	do {
> -		h_used = (struct debug_alloc_header *)
> -			  ((char *)h_free + dah_overhead + h_free->size);
> -		kdb_func_printf("h_used %px size %d caller %px\n",
> -				h_used, h_used->size, h_used->caller);
> -		h_free = (struct debug_alloc_header *)
> -			  (debug_alloc_pool + h_free->next);
> -	} while (h_free->next);
> -	h_used = (struct debug_alloc_header *)
> -		  ((char *)h_free + dah_overhead + h_free->size);
> -	if ((char *)h_used - debug_alloc_pool !=
> -	    sizeof(debug_alloc_pool_aligned))
> -		kdb_func_printf("h_used %px size %d caller %px\n",
> -				h_used, h_used->size, h_used->caller);
> -out:
> -	spin_unlock(&dap_lock);
> -}
> -
>  /* Maintain a small stack of kdb_flags to allow recursion without disturbing
>   * the global kdb state.
>   */
> -- 
> 2.25.1
