Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3824D42114C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhJDOaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhJDOae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:30:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D0C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 07:28:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e15so72463797lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eg+DHxAUJJDbSYW1GrSqHaH8uii9mKgTL9ZBpTTfMCo=;
        b=TudXrq7tMBLVPZhR1exlmNn2TNf7Ny2ASPNzv89E4fLTF+2J2twC+Gu5HLmZLJgsoP
         FduwEadxA93I6+0ubwx8WmVEb66OA/KzgM79jghdnH9mBLwlFUvsO/F9FJOTSivOP8gL
         tOmgYNtJl0C9wQBLgSkw80Ei9TX/dFwm+/IsCHg6GBXZY2VkvDeXes76cc/nIHzy6fZq
         aUyW9R0RJ0FUChGjI6tTrFF9POchK++IzKC8EE3i/ROIizPMKbGdwFJkWuRwKAdAKMzK
         fePk9hMYHzm1qoV4kZdUbBMxKtCtuFdBVWmUWxXtqPb1bu7PyyCw7WvCQorlrQ+o4U+m
         x0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eg+DHxAUJJDbSYW1GrSqHaH8uii9mKgTL9ZBpTTfMCo=;
        b=ogZppa+BpQeslOm7qWUJtkAUmr6jaeS401cjOMKOEFHQ/x/7ejwudmrQ7Mb7EjLZnz
         VH+L2OeH6od2G2nOUqYB92deV6yRSScnN1kfTJAz85qL1LXTvhxCLRjNgbE6ITlgBDus
         WpBtQj5DfQ59uIw8F6+bDaUQ9u6xkjprB33N76UV7SySfeAQEqYAeprnjakazmOiHZfi
         eZ3BQP9wc/2h+sS3MaQhKce9Uw77TbhM/cLl4MmifF+Yx2IFX4+ofq3dS0AuZVgTZJWs
         fedjUYZduMYJw5QttngxrUpyYHixhWZdmvgS6vFaBu5d4hkc6eikSa6z3cqESnSLeBfw
         +tKQ==
X-Gm-Message-State: AOAM532pwKCcMj56E7HUCey/r8hjZRsIxXgYNBbIqvxyv3XM4h2PAiPQ
        uKkod9jzozo48syO+OvKtiY=
X-Google-Smtp-Source: ABdhPJwlS3RRUlS3X/6IztFKpVss1d8gRJj4375bw0g0X9mYpqx/pRZZnYdJNluxo8Ofk7ZU0yQOiQ==
X-Received: by 2002:ac2:4f01:: with SMTP id k1mr15147549lfr.266.1633357722615;
        Mon, 04 Oct 2021 07:28:42 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id x15sm1338299lfe.129.2021.10.04.07.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:28:40 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ping Fang <pifang@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 1/2] mm/vmalloc: Do not adjust the search size for alignment overhead
Date:   Mon,  4 Oct 2021 16:28:28 +0200
Message-Id: <20211004142829.22222-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to include an alignment overhead into a search length, in
that case we guarantee that a found area will definitely fit after
applying a specific alignment that user specifies. From the other
hand we do not guarantee that an area has the lowest address if
an alignment is >= PAGE_SIZE.

It means that, when a user specifies a special alignment together
with a range that corresponds to an exact requested size then an
allocation will fail. This is what happens to KASAN, it wants the
free block that exactly matches a specified range during onlining
memory banks:

[root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory82/state
[root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory83/state
[root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory85/state
[root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory84/state
[  223.858115] vmap allocation for size 16777216 failed: use vmalloc=<size> to increase size
[  223.859415] bash: vmalloc: allocation failure: 16777216 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
[  223.860992] CPU: 4 PID: 1644 Comm: bash Kdump: loaded Not tainted 4.18.0-339.el8.x86_64+debug #1
[  223.862149] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  223.863580] Call Trace:
[  223.863946]  dump_stack+0x8e/0xd0
[  223.864420]  warn_alloc.cold.90+0x8a/0x1b2
[  223.864990]  ? zone_watermark_ok_safe+0x300/0x300
[  223.865626]  ? slab_free_freelist_hook+0x85/0x1a0
[  223.866264]  ? __get_vm_area_node+0x240/0x2c0
[  223.866858]  ? kfree+0xdd/0x570
[  223.867309]  ? kmem_cache_alloc_node_trace+0x157/0x230
[  223.868028]  ? notifier_call_chain+0x90/0x160
[  223.868625]  __vmalloc_node_range+0x465/0x840
[  223.869230]  ? mark_held_locks+0xb7/0x120

Fix it by making sure that find_vmap_lowest_match() returns lowest
start address with any given alignment value, i.e. for alignments
bigger then PAGE_SIZE the algorithm rolls back toward parent nodes
checking right sub-trees if the most left free block did not fit
due to alignment overhead.

Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
Reported-by: Ping Fang <pifang@redhat.com>
Tested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 48e717626e94..9cce45dbdee0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1195,18 +1195,14 @@ find_vmap_lowest_match(unsigned long size,
 {
 	struct vmap_area *va;
 	struct rb_node *node;
-	unsigned long length;
 
 	/* Start from the root. */
 	node = free_vmap_area_root.rb_node;
 
-	/* Adjust the search size for alignment overhead. */
-	length = size + align - 1;
-
 	while (node) {
 		va = rb_entry(node, struct vmap_area, rb_node);
 
-		if (get_subtree_max_size(node->rb_left) >= length &&
+		if (get_subtree_max_size(node->rb_left) >= size &&
 				vstart < va->va_start) {
 			node = node->rb_left;
 		} else {
@@ -1216,9 +1212,9 @@ find_vmap_lowest_match(unsigned long size,
 			/*
 			 * Does not make sense to go deeper towards the right
 			 * sub-tree if it does not have a free block that is
-			 * equal or bigger to the requested search length.
+			 * equal or bigger to the requested search size.
 			 */
-			if (get_subtree_max_size(node->rb_right) >= length) {
+			if (get_subtree_max_size(node->rb_right) >= size) {
 				node = node->rb_right;
 				continue;
 			}
@@ -1226,15 +1222,23 @@ find_vmap_lowest_match(unsigned long size,
 			/*
 			 * OK. We roll back and find the first right sub-tree,
 			 * that will satisfy the search criteria. It can happen
-			 * only once due to "vstart" restriction.
+			 * due to "vstart" restriction or an alignment overhead
+			 * that is bigger then PAGE_SIZE.
 			 */
 			while ((node = rb_parent(node))) {
 				va = rb_entry(node, struct vmap_area, rb_node);
 				if (is_within_this_va(va, size, align, vstart))
 					return va;
 
-				if (get_subtree_max_size(node->rb_right) >= length &&
+				if (get_subtree_max_size(node->rb_right) >= size &&
 						vstart <= va->va_start) {
+					/*
+					 * Shift the vstart forward. Please note, we update it with
+					 * parent's start address adding "1" because we do not want
+					 * to enter same sub-tree after it has already been checked
+					 * and no suitable free block found there.
+					 */
+					vstart = va->va_start + 1;
 					node = node->rb_right;
 					break;
 				}
-- 
2.20.1

