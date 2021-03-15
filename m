Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B810A33A9EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhCODTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhCODTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:19:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:19:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u18so14569410plc.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52jDCpACoTIEuffvjZ0FAKa55GCX1c3VhDbpnUSdB4w=;
        b=V4M8gjZUJTNpilU+9Dx4ftVZeGNfwNNXH/to/yYD71Pu6tyaFXBjPlGWS+f+A7/TFP
         vAtgj9e3cGWL17QRwpIlVXpBScQl+e1ng3aufOeWfzpedjwjwZopnghNEwBEjsXYXkST
         PrTo+9CmnTtrPYe1u/Ida3EF3veaRbjs14A4GN6vgWhYvpvQLUedv5JqnGY1SHcaPRUU
         JVi/ZzrArB2yhMBo1Jg+B+R2bzvdMNC/ueMJAecvZhNEhg0YINJexIcNGLIgi8fU095r
         TB8VsKJdluyZyRFfDey8FUjpsIvnJw4MbVdqM0TtizjvVkdHB3YgdSYQUUIb/NG/DyUk
         Koug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52jDCpACoTIEuffvjZ0FAKa55GCX1c3VhDbpnUSdB4w=;
        b=EnL/dZghWIhSBdDa3Vw0S3We2G0CcOWldz455NEQg9Hv4BsjXnj2LK4aZfIrIGd1ko
         9gkUq7sK4dLHH+JbbuNZxoXBoxVeoXknbCjc8EjLems4L5SI7RdAGsqawFsrShijBrbT
         6BF2e1Wezo2tlCJw2pP9VvyNv/EUeXKlfQraYM3bK1gxNPG6Dq8OLyI35zZKhv/4jkBa
         yEW0oplu8+eMWdEySatVLgd0Nk2GEfB/LDHAfIKHb4V5LgbHzvbFbBExDBfteEOCJm2P
         aiJ1wd/y1yb9qyGu0ez2droqV8WlXU7/cx5MzO4GuIVWcib6Ks8oa+kS5H1tx/P7tiC6
         A3Vw==
X-Gm-Message-State: AOAM533snfNZRp3fx9uZ485DvLQwpr7z+49q+TnXWAWqwaHaV5NhuNyp
        hJI4jxOnI0Bkxb/TY8/O/p4EW4rgsNc=
X-Google-Smtp-Source: ABdhPJxbRnHH0HDUBnyyumLJRbrHgXzaP7PBLmJbaMKgIF4OiEkhoOtAg8l0iaYZmeSshnGQinSHZA==
X-Received: by 2002:a17:902:f686:b029:e5:de44:af60 with SMTP id l6-20020a170902f686b02900e5de44af60mr9994638plg.64.1615778386317;
        Sun, 14 Mar 2021 20:19:46 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:9e10:6493:2d45:37bd:648d])
        by smtp.gmail.com with ESMTPSA id y29sm11790540pfp.206.2021.03.14.20.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 20:19:45 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: simplify coherent_kvaddr logic
Date:   Sun, 14 Mar 2021 20:19:31 -0700
Message-Id: <20210315031931.11007-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions coherent_kvaddr, clear_page_alias and copy_page_alias use
physical address 0 as a special value that means 'this page is in the
KSEG mapping and its existing virtual address has the same color as the
virtual address of its future mapping, so don't map it to the
TLBTEMP_BASE area'.

Simplify this logic and drop special handling of low memory pages/pages
with coherent mapping and always use TLBTEMP_BASE area.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/mm/cache.c |  9 ++-------
 arch/xtensa/mm/misc.S  | 36 +++++-------------------------------
 2 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/arch/xtensa/mm/cache.c b/arch/xtensa/mm/cache.c
index 085b8c77b9d9..19e5a478a7e8 100644
--- a/arch/xtensa/mm/cache.c
+++ b/arch/xtensa/mm/cache.c
@@ -81,13 +81,8 @@ static inline void kmap_invalidate_coherent(struct page *page,
 static inline void *coherent_kvaddr(struct page *page, unsigned long base,
 				    unsigned long vaddr, unsigned long *paddr)
 {
-	if (PageHighMem(page) || !DCACHE_ALIAS_EQ(page_to_phys(page), vaddr)) {
-		*paddr = page_to_phys(page);
-		return (void *)(base + (vaddr & DCACHE_ALIAS_MASK));
-	} else {
-		*paddr = 0;
-		return page_to_virt(page);
-	}
+	*paddr = page_to_phys(page);
+	return (void *)(base + (vaddr & DCACHE_ALIAS_MASK));
 }
 
 void clear_user_highpage(struct page *page, unsigned long vaddr)
diff --git a/arch/xtensa/mm/misc.S b/arch/xtensa/mm/misc.S
index 25cd67debee6..0527bf6e3211 100644
--- a/arch/xtensa/mm/misc.S
+++ b/arch/xtensa/mm/misc.S
@@ -118,20 +118,13 @@ ENTRY(clear_page_alias)
 
 	abi_entry_default
 
-	/* Skip setting up a temporary DTLB if not aliased low page. */
-
 	movi	a5, PAGE_OFFSET
-	movi	a6, 0
-	beqz	a3, 1f
-
-	/* Setup a temporary DTLB for the addr. */
-
 	addi	a6, a3, (PAGE_KERNEL | _PAGE_HW_WRITE)
 	mov	a4, a2
 	wdtlb	a6, a2
 	dsync
 
-1:	movi	a3, 0
+	movi	a3, 0
 	__loopi	a2, a7, PAGE_SIZE, 32
 	s32i	a3, a2, 0
 	s32i	a3, a2, 4
@@ -143,12 +136,9 @@ ENTRY(clear_page_alias)
 	s32i	a3, a2, 28
 	__endla	a2, a7, 32
 
-	bnez	a6, 1f
-	abi_ret_default
-
-	/* We need to invalidate the temporary idtlb entry, if any. */
+	/* We need to invalidate the temporary dtlb entry. */
 
-1:	idtlb	a4
+	idtlb	a4
 	dsync
 
 	abi_ret_default
@@ -166,22 +156,12 @@ ENTRY(copy_page_alias)
 
 	abi_entry_default
 
-	/* Skip setting up a temporary DTLB for destination if not aliased. */
-
-	movi	a6, 0
-	movi	a7, 0
-	beqz	a4, 1f
-
 	/* Setup a temporary DTLB for destination. */
 
 	addi	a6, a4, (PAGE_KERNEL | _PAGE_HW_WRITE)
 	wdtlb	a6, a2
 	dsync
 
-	/* Skip setting up a temporary DTLB for source if not aliased. */
-
-1:	beqz	a5, 1f
-
 	/* Setup a temporary DTLB for source. */
 
 	addi	a7, a5, PAGE_KERNEL
@@ -219,17 +199,11 @@ ENTRY(copy_page_alias)
 
 	/* We need to invalidate any temporary mapping! */
 
-	bnez	a6, 1f
-	bnez	a7, 2f
-	abi_ret_default
-
-1:	addi	a2, a2, -PAGE_SIZE
+	addi	a2, a2, -PAGE_SIZE
 	idtlb	a2
 	dsync
-	bnez	a7, 2f
-	abi_ret_default
 
-2:	addi	a3, a3, -PAGE_SIZE+1
+	addi	a3, a3, -PAGE_SIZE+1
 	idtlb	a3
 	dsync
 
-- 
2.20.1

