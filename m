Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D793EEABD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhHQKQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:16:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40796 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhHQKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:16:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F1F321961;
        Tue, 17 Aug 2021 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629195337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+z7FtdjNQux67/Yi+O5hafYpmsQ5k1hYOyygjVnZTU=;
        b=Dkhh1OKkYIGDQUqrV/oxS/GEFMAbLr65t3RzwHxiKBfNcnCS2/p4+F6V3rQN98QHamnZ66
        1U4j9g8oZJyrfC06VmSGR5mSBDCSiKV116HCbXHey6XMnZpJ/3cVU0a23ggHugVUwUffZY
        g5vggvcRs0D5CNXTw4arLmPr9BwXNOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629195337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+z7FtdjNQux67/Yi+O5hafYpmsQ5k1hYOyygjVnZTU=;
        b=6OP7ySCPhjsr1NA9QbhAkb2JfAt+Bn8Ds7ZcecUIoPRXwlmu+v5AYxSRKqxIkneH2OYhVH
        aH2b1QTvRaj1b7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C224313DF7;
        Tue, 17 Aug 2021 10:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GjUOLUiMG2E+YQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Aug 2021 10:15:36 +0000
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-36-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e907c2b6-6df1-8038-8c6c-aa9c1fd11259@suse.cz>
Date:   Tue, 17 Aug 2021 12:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805152000.12817-36-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 5:20 PM, Vlastimil Babka wrote:
> Embed local_lock into struct kmem_cpu_slab and use the irq-safe versions of
> local_lock instead of plain local_irq_save/restore. On !PREEMPT_RT that's
> equivalent, with better lockdep visibility. On PREEMPT_RT that means better
> preemption.
> 
> However, the cost on PREEMPT_RT is the loss of lockless fast paths which only
> work with cpu freelist. Those are designed to detect and recover from being
> preempted by other conflicting operations (both fast or slow path), but the
> slow path operations assume they cannot be preempted by a fast path operation,
> which is guaranteed naturally with disabled irqs. With local locks on
> PREEMPT_RT, the fast paths now also need to take the local lock to avoid races.
> 
> In the allocation fastpath slab_alloc_node() we can just defer to the slowpath
> __slab_alloc() which also works with cpu freelist, but under the local lock.
> In the free fastpath do_slab_free() we have to add a new local lock protected
> version of freeing to the cpu freelist, as the existing slowpath only works
> with the page freelist.
> 
> Also update the comment about locking scheme in SLUB to reflect changes done
> by this series.
> 
> [ Mike Galbraith <efault@gmx.de>: use local_lock() without irq in PREEMPT_RT
>   scope; debugging of RT crashes resulting in put_cpu_partial() locking changes ]
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Another fixup. Is it too many and should we replace it all with a v5?
----8<----
From b13291ca13effc2b22a55619aada688ad5defa4b Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 17 Aug 2021 11:47:16 +0200
Subject: [PATCH] mm, slub: fix kmem_cache_cpu fields alignment for double
 cmpxchg

Sven Eckelmann reports [1] that the addition of local_lock to kmem_cache_cpu
breaks a config with 64BIT+LOCK_STAT:

    general protection fault, maybe for address 0xffff888007fcf1c8: 0000 [#1] NOPTI
    CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.0-rc5+ #7
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
    RIP: 0010:kmem_cache_alloc+0x81/0x180
    Code: 79 48 00 4c 8b 41 38 0f 84 89 00 00 00 4d 85 c0 0f 84 80 00 00 00 41 8b 44 24 28 49 8b 3c 24 48 8d 4a 01 49 8b 1c 00 4c 89 c0 <48> 0f c7 4f 38 0f 943
    RSP: 0000:ffffffff81803c10 EFLAGS: 00000286
    RAX: ffff88800244e7c0 RBX: ffff88800244e800 RCX: 0000000000000024
    RDX: 0000000000000023 RSI: 0000000000000100 RDI: ffff888007fcf190
    RBP: ffffffff81803c38 R08: ffff88800244e7c0 R09: 0000000000000dc0
    R10: 0000000000004000 R11: 0000000000000000 R12: ffff8880024413c0
    R13: ffffffff810d18f4 R14: 0000000000000dc0 R15: 0000000000000100
    FS:  0000000000000000(0000) GS:ffffffff81840000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffff888002001000 CR3: 0000000001824000 CR4: 00000000000006b0
    Call Trace:
     __get_vm_area_node.constprop.0.isra.0+0x74/0x150
     __vmalloc_node_range+0x5a/0x2b0
     ? kernel_clone+0x88/0x390
     ? copy_process+0x1ac/0x17e0
     copy_process+0x768/0x17e0
     ? kernel_clone+0x88/0x390
     kernel_clone+0x88/0x390
     ? _vm_unmap_aliases.part.0+0xe9/0x110
     ? change_page_attr_set_clr+0x10d/0x180
     kernel_thread+0x43/0x50
     ? rest_init+0x100/0x100
     rest_init+0x1e/0x100
     arch_call_rest_init+0x9/0xc
     start_kernel+0x481/0x493
     x86_64_start_reservations+0x24/0x26
     x86_64_start_kernel+0x80/0x84
     secondary_startup_64_no_verify+0xc2/0xcb
    random: get_random_bytes called from oops_exit+0x34/0x60 with crng_init=0
    ---[ end trace 2cac18ac38f640c1 ]---
    RIP: 0010:kmem_cache_alloc+0x81/0x180
    Code: 79 48 00 4c 8b 41 38 0f 84 89 00 00 00 4d 85 c0 0f 84 80 00 00 00 41 8b 44 24 28 49 8b 3c 24 48 8d 4a 01 49 8b 1c 00 4c 89 c0 <48> 0f c7 4f 38 0f 943
    RSP: 0000:ffffffff81803c10 EFLAGS: 00000286
    RAX: ffff88800244e7c0 RBX: ffff88800244e800 RCX: 0000000000000024
    RDX: 0000000000000023 RSI: 0000000000000100 RDI: ffff888007fcf190
    RBP: ffffffff81803c38 R08: ffff88800244e7c0 R09: 0000000000000dc0
    R10: 0000000000004000 R11: 0000000000000000 R12: ffff8880024413c0
    R13: ffffffff810d18f4 R14: 0000000000000dc0 R15: 0000000000000100
    FS:  0000000000000000(0000) GS:ffffffff81840000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffff888002001000 CR3: 0000000001824000 CR4: 00000000000006b0
    Kernel panic - not syncing: Attempted to kill the idle task!
    ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Decoding the RIP points to this_cpu_cmpxchg_double() call in slab_alloc_node().

The problem is the particular size of local_lock_t with LOCK_STAT resulting
in the following layout:

struct kmem_cache_cpu {
        local_lock_t               lock;                 /*     0    56 */
        void * *                   freelist;             /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        long unsigned int          tid;                  /*    64     8 */
        struct page *              page;                 /*    72     8 */
        struct page *              partial;              /*    80     8 */

        /* size: 88, cachelines: 2, members: 5 */
        /* last cacheline: 24 bytes */
};

As pointed out by Sebastian Andrzej Siewior, this_cpu_cmpxchg_double()
needs the freelist and tid fields to be aligned to sum of their sizes
(16 bytes) but they are not in this configuration. This didn't happen
with non-debug RT and !RT configs as well as lockdep.

To fix this, move the lock field below partial field, so that it doesn't
affect the layout.

[1] https://lore.kernel.org/linux-mm/2666777.vCjUEy5FO1@sven-desktop/

This is a fixup for mmotm patch
mm-slub-convert-kmem_cpu_slab-protection-to-local_lock.patch

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slub_def.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index b5bcac29b979..85499f0586b0 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -41,14 +41,18 @@ enum stat_item {
 	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
 	NR_SLUB_STAT_ITEMS };
 
+/*
+ * When changing the layout, make sure freelist and tid are still compatible
+ * with this_cpu_cmpxchg_double() alignment requirements.
+ */
 struct kmem_cache_cpu {
-	local_lock_t lock;	/* Protects the fields below except stat */
 	void **freelist;	/* Pointer to next available object */
 	unsigned long tid;	/* Globally unique transaction id */
 	struct page *page;	/* The slab from which we are allocating */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct page *partial;	/* Partially allocated frozen slabs */
 #endif
+	local_lock_t lock;	/* Protects the fields above */
 #ifdef CONFIG_SLUB_STATS
 	unsigned stat[NR_SLUB_STAT_ITEMS];
 #endif
-- 
2.32.0


