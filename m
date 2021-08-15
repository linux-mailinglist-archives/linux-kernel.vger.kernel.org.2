Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5DE3EC885
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhHOKX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 06:23:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51772 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhHOKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 06:23:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE4CF21F0C;
        Sun, 15 Aug 2021 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629023005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xo704mebc/syYfIi/wcQUHNmYtjm6oia/oZJqqT5aM=;
        b=QKcI25TlPcUKQudQfl409Ityt1jrLVbxcEo+op9nAAlZk8Mz2Mna9LSNKQ77eCjjFR5N71
        FuP/oUGE5C+ndKiCmtUDIrwJs4cHD4oSAreufloegBR+JOjWAUz/kCX9asDKN1NZv0HYp0
        KpKCRtEFFeru0Z3YltPKHInC5TccuUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629023005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xo704mebc/syYfIi/wcQUHNmYtjm6oia/oZJqqT5aM=;
        b=Txk+sbcTeq9SHCPTaBx1NEoQOEZTAt8jTduHL/4e/OV6yMJzhEmnDK70HXJRcjxNH2fxnZ
        YefWVqSkrRUZ+oBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 261701445E;
        Sun, 15 Aug 2021 10:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rt0lBh3rGGGSbgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 15 Aug 2021 10:23:25 +0000
Subject: Re: [PATCH v4 13/35] mm, slub: do initial checks in ___slab_alloc()
 with irqs enabled
From:   Vlastimil Babka <vbabka@suse.cz>
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
        Jann Horn <jannh@google.com>,
        Clark Williams <williams@redhat.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-14-vbabka@suse.cz>
 <f4756ee5-a7e9-ab02-3aba-1355f77b7c79@suse.cz>
Message-ID: <ec98bce0-fef4-0fbc-2067-e358510e0321@suse.cz>
Date:   Sun, 15 Aug 2021 12:22:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f4756ee5-a7e9-ab02-3aba-1355f77b7c79@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/21 12:14 PM, Vlastimil Babka wrote:
> On 8/5/21 5:19 PM, Vlastimil Babka wrote:
>> As another step of shortening irq disabled sections in ___slab_alloc(), delay
>> disabling irqs until we pass the initial checks if there is a cached percpu
>> slab and it's suitable for our allocation.
>>
>> Now we have to recheck c->page after actually disabling irqs as an allocation
>> in irq handler might have replaced it.
> 
> Please add an extra paragraph that related to the fixup below (which I
> assume will be squashed as usual):
> 
> Because we call pfmemalloc_match() as one of the checks, we might hit
> VM_BUG_ON_PAGE(!PageSlab(page)) in PageSlabPfmemalloc in case we get
> interrupted and the page is freed. Thus introduce a
> pfmemalloc_match_unsafe() variant that lacks the PageSlab check.
> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> And the fixup:

Oops, renaming snafu. Again.

----8<----
From bf81bca38b127a8d717978467cf7264580c81248 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Sun, 15 Aug 2021 11:49:46 +0200
Subject: [PATCH] mm, slub: prevent VM_BUG_ON in PageSlabPfmemalloc from
 ___slab_alloc

Clark Williams reported [1] a VM_BUG_ON in PageSlabPfmemalloc:

 page:000000009ac5dd73 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ab3db
 flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
 raw: 0017ffffc0000000 ffffee1286aceb88 ffffee1287b66288 0000000000000000
 raw: 0000000000000000 0000000000100000 00000000ffffffff 0000000000000000
 page dumped because: VM_BUG_ON_PAGE(!PageSlab(page))
 ------------[ cut here ]------------
 kernel BUG at include/linux/page-flags.h:814!
 invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
 CPU: 3 PID: 12345 Comm: hackbench Not tainted 5.14.0-rc5-rt8+ #12
 Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0359.2016.0906.1028 09/06/2016
 RIP: 0010:___slab_alloc+0x340/0x940
 Code: c6 48 0f a3 05 b1 7b 57 03 72 99 c7 85 78 ff ff ff ff ff ff ff 48 8b 7d 88 e9 8d fd ff ff 48 c7 c6 50 5a 7c b0 e>
 RSP: 0018:ffffba1c4a8b7ab0 EFLAGS: 00010293
 RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9bb765118000
 RDX: 0000000000000000 RSI: ffffffffaf426050 RDI: 00000000ffffffff
 RBP: ffffba1c4a8b7b70 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffff9bb7410d3600
 R13: 0000000000400cc0 R14: 00000000001f7770 R15: ffff9bbe76df7770
 FS:  00007f474b1be740(0000) GS:ffff9bbe76c00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f60c04bdaf8 CR3: 0000000124f3a003 CR4: 00000000003706e0
 Call Trace:
  ? __alloc_skb+0x1db/0x270
  ? __alloc_skb+0x1db/0x270
  ? kmem_cache_alloc_node+0xa4/0x2b0
  kmem_cache_alloc_node+0xa4/0x2b0
  __alloc_skb+0x1db/0x270
  alloc_skb_with_frags+0x64/0x250
  sock_alloc_send_pskb+0x260/0x2b0
  ? bpf_lsm_socket_getpeersec_dgram+0xa/0x10
  unix_stream_sendmsg+0x27c/0x550
  ? unix_seqpacket_recvmsg+0x60/0x60
  sock_sendmsg+0xbd/0xd0
  sock_write_iter+0xb9/0x120
  new_sync_write+0x175/0x200
  vfs_write+0x3c4/0x510
  ksys_write+0xc9/0x110
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

The problem is that we are opportunistically checking flags on a page in irq
enabled section. If we are interrupted and the page is freed, it's not an
issue as we detect it after disabling irqs. But on kernels with
CONFIG_DEBUG_VM. The check for PageSlab flag in PageSlabPfmemalloc() can fail.

Fix this by creating an "unsafe" version of the check that doesn't check
PageSlab.

This is a fixup for mmotm patch
mm-slub-do-initial-checks-in-___slab_alloc-with-irqs-enabled.patch

[1] https://lore.kernel.org/lkml/20210812151803.52f84aaf@theseus.lan/

Reported-by: Clark Williams <williams@redhat.com>
Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/page-flags.h |  9 +++++++++
 mm/slub.c                  | 15 ++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5922031ffab6..7fda4fb85bdc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -815,6 +815,15 @@ static inline int PageSlabPfmemalloc(struct page *page)
 	return PageActive(page);
 }
 
+/*
+ * A version of PageSlabPfmemalloc() for opportunistic checks where the page
+ * might have been freed under us and not be a PageSlab anymore.
+ */
+static inline int __PageSlabPfmemalloc(struct page *page)
+{
+	return PageActive(page);
+}
+
 static inline void SetPageSlabPfmemalloc(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageSlab(page), page);
diff --git a/mm/slub.c b/mm/slub.c
index 7eb06fe9d7a0..d60d48c35f98 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2603,6 +2603,19 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags)
 	return true;
 }
 
+/*
+ * A variant of pfmemalloc_match() that tests page flags without asserting
+ * PageSlab. Intended for opportunistic checks before taking a lock and
+ * rechecking that nobody else freed the page under us.
+ */
+static inline bool pfmemalloc_match_unsafe(struct page *page, gfp_t gfpflags)
+{
+	if (unlikely(__PageSlabPfmemalloc(page)))
+		return gfp_pfmemalloc_allowed(gfpflags);
+
+	return true;
+}
+
 /*
  * Check the page->freelist of a page and either transfer the freelist to the
  * per cpu freelist or deactivate the page.
@@ -2704,7 +2717,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * PFMEMALLOC but right now, we are losing the pfmemalloc
 	 * information when the page leaves the per-cpu allocator
 	 */
-	if (unlikely(!pfmemalloc_match(page, gfpflags)))
+	if (unlikely(!pfmemalloc_match_unsafe(page, gfpflags)))
 		goto deactivate_slab;
 
 	/* must check again c->page in case IRQ handler changed it */
-- 
2.32.0


