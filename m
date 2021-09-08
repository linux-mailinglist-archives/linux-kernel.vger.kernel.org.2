Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6623403A92
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349353AbhIHN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235294AbhIHN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631107656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4zJCMyAEhGNeqtEq1uHSEAAohctgkdWhGGLuAjpd4pI=;
        b=WhWCvsq94uaKR5T+/+I5mSL64ZbuhtRciK/1HOyqTFadJZgpUKfRxWpd+6+Kkj3Be0HtFM
        zjoHnNJmQH1yL4mKZlfBrU8QRF+rbMZHPgeS+q9p3UO5lRrwqJEmVdDSeCqriG2zvfN8i/
        8G9aLvCYKUcTJRoXzoQStewaFJH0j5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416--9IIZwwuMYWWGNmY0bHy9w-1; Wed, 08 Sep 2021 09:27:35 -0400
X-MC-Unique: -9IIZwwuMYWWGNmY0bHy9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82ED0802929;
        Wed,  8 Sep 2021 13:27:34 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71CE4194B9;
        Wed,  8 Sep 2021 13:27:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org
Subject: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment > 1
Date:   Wed,  8 Sep 2021 15:27:27 +0200
Message-Id: <20210908132727.16165-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_vmap_lowest_match() is imprecise such that it won't always
find "the first free block ... that will accomplish the request" if
an alignment > 1 was specified: especially also when the alignment is
PAGE_SIZE. Unfortuantely, the way the vmalloc data structures were
designed, propagating the max size without alignment information through
the tree, it's hard to make it precise again when an alignment > 1 is
specified.

The issue is that in order to be able to eventually align later,
find_vmap_lowest_match() has to search for a slightly bigger area and
might skip some applicable subtrees just by lookign at the result of
get_subtree_max_size(). While this usually doesn't matter, it matters for
exact allocations as performed by KASAN when onlining a memory block,
when the free block exactly matches the request.
(mm/kasn/shadow.c:kasan_mem_notifier()).

In case we online memory blocks out of order (not lowest to highest
address), find_vmap_lowest_match() with PAGE_SIZE alignment will reject
an exact allocation if it corresponds exactly to a free block. (there are
some corner cases where it would still work, if we're lucky and hit the
first is_within_this_va() inside the while loop)

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

While we could fix this in kasan_mem_notifier() by passing an alignment
of "1", this is actually an implementation detail of vmalloc and to be
handled internally.

So use an alignment of 1 when calling find_vmap_lowest_match() for exact
allocations that are expected to succeed -- if the given range can
satisfy the alignment requirements.

Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
Reported-by: Ping Fang <pifang@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/vmalloc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d5cd52805149..c6071f5f8de3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1153,7 +1153,8 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
 /*
  * Find the first free block(lowest start address) in the tree,
  * that will accomplish the request corresponding to passing
- * parameters.
+ * parameters. Note that with an alignment > 1, this function
+ * can be imprecise and skip applicable free blocks.
  */
 static __always_inline struct vmap_area *
 find_vmap_lowest_match(unsigned long size,
@@ -1396,7 +1397,15 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 	enum fit_type type;
 	int ret;
 
-	va = find_vmap_lowest_match(size, align, vstart);
+	/*
+	 * For exact allocations, ignore the alignment, such that
+	 * find_vmap_lowest_match() won't search for a bigger free area just
+	 * able to align later and consequently fail the search.
+	 */
+	if (vend - vstart == size && IS_ALIGNED(vstart, align))
+		va = find_vmap_lowest_match(size, 1, vstart);
+	else
+		va = find_vmap_lowest_match(size, align, vstart);
 	if (unlikely(!va))
 		return vend;
 

base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.31.1

