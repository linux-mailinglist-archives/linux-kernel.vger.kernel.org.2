Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF634760B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhCXKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235714AbhCXKZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616581505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLr3oxEF1/9Rhj8o+UPHLCrvFG5XatLxuy2W9STTzPM=;
        b=GMAgQFoFt1RltsFR5cE9jXVsf/FyQDge8FbHrszlKQ8vIagBZwpx5UERAXXVXRhYtF5mmc
        vSNG110zCifRGXMBjVUvTPllJgZu1tq/OwB2EDDULrf94pinAOGnCP8JFBCcUKMlXo46Jp
        vujdXIlPxDC8zBKKPHl9kMYeDV601bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-shSdeTk8O9ahfEpodI8hHw-1; Wed, 24 Mar 2021 06:25:01 -0400
X-MC-Unique: shSdeTk8O9ahfEpodI8hHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D16DA81621;
        Wed, 24 Mar 2021 10:24:59 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-66.ams2.redhat.com [10.36.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6ECA10013D7;
        Wed, 24 Mar 2021 10:24:56 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: [PATCH v1 3/3] mm/vmalloc: remove vwrite()
Date:   Wed, 24 Mar 2021 11:23:51 +0100
Message-Id: <20210324102351.6932-4-david@redhat.com>
In-Reply-To: <20210324102351.6932-1-david@redhat.com>
References: <20210324102351.6932-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last user (/dev/kmem) is gone. Let's drop it.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: huang ying <huang.ying.caritas@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/vmalloc.h |   1 -
 mm/nommu.c              |  10 ----
 mm/vmalloc.c            | 116 +---------------------------------------
 3 files changed, 1 insertion(+), 126 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 390af680e916..9c1b17c7dd95 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -200,7 +200,6 @@ static inline void set_vm_flush_reset_perms(void *addr)
 
 /* for /proc/kcore */
 extern long vread(char *buf, char *addr, unsigned long count);
-extern long vwrite(char *buf, char *addr, unsigned long count);
 
 /*
  *	Internals.  Dont't use..
diff --git a/mm/nommu.c b/mm/nommu.c
index 5c9ab799c0e6..85a3a68dffb6 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -210,16 +210,6 @@ long vread(char *buf, char *addr, unsigned long count)
 	return count;
 }
 
-long vwrite(char *buf, char *addr, unsigned long count)
-{
-	/* Don't allow overflow */
-	if ((unsigned long) addr + count < count)
-		count = -(unsigned long) addr;
-
-	memcpy(addr, buf, count);
-	return count;
-}
-
 /*
  *	vmalloc  -  allocate virtually contiguous memory
  *
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccb405b82581..434f61c9c466 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2802,10 +2802,7 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
 		 * kmap() and get small overhead in this access function.
 		 */
 		if (p) {
-			/*
-			 * we can expect USER0 is not used (see vread/vwrite's
-			 * function description)
-			 */
+			/* We can expect USER0 is not used -- see vread() */
 			void *map = kmap_atomic(p);
 			memcpy(buf, map + offset, length);
 			kunmap_atomic(map);
@@ -2820,43 +2817,6 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
 	return copied;
 }
 
-static int aligned_vwrite(char *buf, char *addr, unsigned long count)
-{
-	struct page *p;
-	int copied = 0;
-
-	while (count) {
-		unsigned long offset, length;
-
-		offset = offset_in_page(addr);
-		length = PAGE_SIZE - offset;
-		if (length > count)
-			length = count;
-		p = vmalloc_to_page(addr);
-		/*
-		 * To do safe access to this _mapped_ area, we need
-		 * lock. But adding lock here means that we need to add
-		 * overhead of vmalloc()/vfree() calles for this _debug_
-		 * interface, rarely used. Instead of that, we'll use
-		 * kmap() and get small overhead in this access function.
-		 */
-		if (p) {
-			/*
-			 * we can expect USER0 is not used (see vread/vwrite's
-			 * function description)
-			 */
-			void *map = kmap_atomic(p);
-			memcpy(map + offset, buf, length);
-			kunmap_atomic(map);
-		}
-		addr += length;
-		buf += length;
-		copied += length;
-		count -= length;
-	}
-	return copied;
-}
-
 /**
  * vread() - read vmalloc area in a safe way.
  * @buf:     buffer for reading data
@@ -2936,80 +2896,6 @@ long vread(char *buf, char *addr, unsigned long count)
 	return buflen;
 }
 
-/**
- * vwrite() - write vmalloc area in a safe way.
- * @buf:      buffer for source data
- * @addr:     vm address.
- * @count:    number of bytes to be read.
- *
- * This function checks that addr is a valid vmalloc'ed area, and
- * copy data from a buffer to the given addr. If specified range of
- * [addr...addr+count) includes some valid address, data is copied from
- * proper area of @buf. If there are memory holes, no copy to hole.
- * IOREMAP area is treated as memory hole and no copy is done.
- *
- * If [addr...addr+count) doesn't includes any intersects with alive
- * vm_struct area, returns 0. @buf should be kernel's buffer.
- *
- * Note: In usual ops, vwrite() is never necessary because the caller
- * should know vmalloc() area is valid and can use memcpy().
- * This is for routines which have to access vmalloc area without
- * any information, as /dev/kmem.
- *
- * Return: number of bytes for which addr and buf should be
- * increased (same number as @count) or %0 if [addr...addr+count)
- * doesn't include any intersection with valid vmalloc area
- */
-long vwrite(char *buf, char *addr, unsigned long count)
-{
-	struct vmap_area *va;
-	struct vm_struct *vm;
-	char *vaddr;
-	unsigned long n, buflen;
-	int copied = 0;
-
-	/* Don't allow overflow */
-	if ((unsigned long) addr + count < count)
-		count = -(unsigned long) addr;
-	buflen = count;
-
-	spin_lock(&vmap_area_lock);
-	list_for_each_entry(va, &vmap_area_list, list) {
-		if (!count)
-			break;
-
-		if (!va->vm)
-			continue;
-
-		vm = va->vm;
-		vaddr = (char *) vm->addr;
-		if (addr >= vaddr + get_vm_area_size(vm))
-			continue;
-		while (addr < vaddr) {
-			if (count == 0)
-				goto finished;
-			buf++;
-			addr++;
-			count--;
-		}
-		n = vaddr + get_vm_area_size(vm) - addr;
-		if (n > count)
-			n = count;
-		if (!(vm->flags & VM_IOREMAP)) {
-			aligned_vwrite(buf, addr, n);
-			copied++;
-		}
-		buf += n;
-		addr += n;
-		count -= n;
-	}
-finished:
-	spin_unlock(&vmap_area_lock);
-	if (!copied)
-		return 0;
-	return buflen;
-}
-
 /**
  * remap_vmalloc_range_partial - map vmalloc pages to userspace
  * @vma:		vma to cover
-- 
2.29.2

