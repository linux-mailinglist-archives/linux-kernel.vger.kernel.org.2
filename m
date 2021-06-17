Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDEE3AAE88
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhFQIPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFQIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:15:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4627C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:13:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso3389807pjp.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OTHwuB2mCohnRjYeuyJYonCC4hSvfxMb+kfGOcySdeA=;
        b=N15/0qJHRaxdK+1VySkk0d0jIwo8SlPuin0WQQVvHBYrySoP+yRym1fJMbOfreAfef
         eqM1NJ+tuludBCFBDNl9haZ3F20WnIecBcjiOE3/BP9zneTMZaHYo7HtMyQTs6fel3gO
         KKm4HAwC+QN7k+z6FGJQ/GviG3Uq5j6pvanCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OTHwuB2mCohnRjYeuyJYonCC4hSvfxMb+kfGOcySdeA=;
        b=OBgMYxXxXKTXZrrpCYHfgn/5P7flrlAcd0tX8ODSwGPgn1Gs0B+IiiJ+7fyX5spt94
         nr9kJlmZEjyB8XfkpKLco6uxjl14M4Yqg+q5TOoY24Ks7t+90meqqd2M8nx4bk++zPOr
         kUDjK57o80OJUaSPBC6HvBF/6MNbb6khj0/LUKMM9tqPrhHGWrb41GrR29rFqt/FIbam
         QQFrE/BMx6fvZ/54vTjqDFg4A/Wm9j4UKcu1DDQsh64YxTb4ghdYMV3LLLswVZ6z4RGp
         vcf92zpg9FvCDSyOGDIpnQkMFMjiZgP8nPNbVCcCdFpoqD/MomV6TshMvqLdtUgTw3DN
         cEUw==
X-Gm-Message-State: AOAM531Dc6hRhnwh9bPk3d3cB8eTpWYA7heJtOSsazL6AK5CLNqW3AHR
        7QKvGEHOiMnHrPs43Exv2crRDW+uflo5rg==
X-Google-Smtp-Source: ABdhPJwnn9p/GSeDbeOv7fhw7LPunrrnAI/UcB7rcCrlRnWpmZKWDDtr0tQ2fyoT7txyc+fa4A88LQ==
X-Received: by 2002:a17:902:748c:b029:103:267f:a2b3 with SMTP id h12-20020a170902748cb0290103267fa2b3mr3483380pll.23.1623917615084;
        Thu, 17 Jun 2021 01:13:35 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id z6sm4623868pgs.24.2021.06.17.01.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 01:13:34 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, akpm@linux-foundation.org
Cc:     Daniel Axtens <dja@axtens.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Gow <davidgow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH] mm/vmalloc: unbreak kasan vmalloc support
Date:   Thu, 17 Jun 2021 18:13:30 +1000
Message-Id: <20210617081330.98629-1-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
__vmalloc_node_range was changed such that __get_vm_area_node was no
longer called with the requested/real size of the vmalloc allocation, but
rather with a rounded-up size.

This means that __get_vm_area_node called kasan_unpoision_vmalloc() with
a rounded up size rather than the real size. This led to it allowing
access to too much memory and so missing vmalloc OOBs and failing the
kasan kunit tests.

Pass the real size and the desired shift into __get_vm_area_node. This
allows it to round up the size for the underlying allocators while
still unpoisioning the correct quantity of shadow memory.

Adjust the other call-sites to pass in PAGE_SHIFT for the shift value.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Gow <davidgow@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213335
Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 mm/vmalloc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aaad569e8963..3471cbeb083c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2362,15 +2362,16 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 }
 
 static struct vm_struct *__get_vm_area_node(unsigned long size,
-		unsigned long align, unsigned long flags, unsigned long start,
-		unsigned long end, int node, gfp_t gfp_mask, const void *caller)
+		unsigned long align, unsigned long shift, unsigned long flags,
+		unsigned long start, unsigned long end, int node,
+		gfp_t gfp_mask, const void *caller)
 {
 	struct vmap_area *va;
 	struct vm_struct *area;
 	unsigned long requested_size = size;
 
 	BUG_ON(in_interrupt());
-	size = PAGE_ALIGN(size);
+	size = ALIGN(size, 1ul << shift);
 	if (unlikely(!size))
 		return NULL;
 
@@ -2402,8 +2403,8 @@ struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
 				       unsigned long start, unsigned long end,
 				       const void *caller)
 {
-	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
-				  GFP_KERNEL, caller);
+	return __get_vm_area_node(size, 1, PAGE_SHIFT, flags, start, end,
+				  NUMA_NO_NODE, GFP_KERNEL, caller);
 }
 
 /**
@@ -2419,7 +2420,8 @@ struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
  */
 struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 {
-	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
+	return __get_vm_area_node(size, 1, PAGE_SHIFT, flags,
+				  VMALLOC_START, VMALLOC_END,
 				  NUMA_NO_NODE, GFP_KERNEL,
 				  __builtin_return_address(0));
 }
@@ -2427,7 +2429,8 @@ struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				const void *caller)
 {
-	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
+	return __get_vm_area_node(size, 1, PAGE_SHIFT, flags,
+				  VMALLOC_START, VMALLOC_END,
 				  NUMA_NO_NODE, GFP_KERNEL, caller);
 }
 
@@ -2949,9 +2952,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	}
 
 again:
-	size = PAGE_ALIGN(size);
-	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
-				vm_flags, start, end, node, gfp_mask, caller);
+	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
+				  VM_UNINITIALIZED | vm_flags, start, end, node,
+				  gfp_mask, caller);
 	if (!area) {
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, vm_struct allocation failed",
@@ -2970,6 +2973,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	 */
 	clear_vm_uninitialized_flag(area);
 
+	size = PAGE_ALIGN(size);
 	kmemleak_vmalloc(area, size, gfp_mask);
 
 	return addr;
-- 
2.30.2

