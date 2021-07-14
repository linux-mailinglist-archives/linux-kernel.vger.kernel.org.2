Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF713C848D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbhGNMks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239284AbhGNMkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:40:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64E6E613C3;
        Wed, 14 Jul 2021 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626266274;
        bh=DGdlwCkZIlF7M2e5FrRY4R5tomviE45g2fM8RW577bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0AmCcOQg+Qu6zi4j2J9dm1OfCK4LkYH8OZGagz34TNSbAJyCp6C27ALPh+cMA0fF
         l51XnU/CogMZ0jxfjFcPYM0c5F5MyEU6xN63vTgIZv3mnunj1Jfv4vb9MSr6SzXjPo
         d9CpzIXZ0OWyGCPw0x9LNc9+Muvl51p1Zz/oWHiDJKw8lGWFthmUf7ssedrY+s1sLq
         6NxSjMNHJsSMwZPRlhRc68+U4mqP0tgJcL/4Yuvpnk+yDXcrZJbBnKCaHD3l988B9+
         6xtPbkwVlnfutCmyUDwk5HXV9CBpmfNvAAIQdPZE+4a3ujeXHRpEP1E3ZPHQ5E30NT
         ttRrd6cThDo2A==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/4] memblock: stop poisoning raw allocations
Date:   Wed, 14 Jul 2021 15:37:39 +0300
Message-Id: <20210714123739.16493-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210714123739.16493-1-rppt@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Functions memblock_alloc_exact_nid_raw() and memblock_alloc_try_nid_raw()
are intended for early memory allocation without overhead of zeroing the
allocated memory. Since these functions were used to allocate the memory
map, they have ended up with addition of a call to page_init_poison() that
poisoned the allocated memory when CONFIG_PAGE_POISON was set.

Since the memory map is allocated using a dedicated memmep_alloc() function
that takes care of the poisoning, remove page poisoning from the
memblock_alloc_*_raw() functions.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memblock.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 0041ff62c584..9748d0689f81 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1490,18 +1490,12 @@ void * __init memblock_alloc_exact_nid_raw(
 			phys_addr_t min_addr, phys_addr_t max_addr,
 			int nid)
 {
-	void *ptr;
-
 	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
 		     __func__, (u64)size, (u64)align, nid, &min_addr,
 		     &max_addr, (void *)_RET_IP_);
 
-	ptr = memblock_alloc_internal(size, align,
-					   min_addr, max_addr, nid, true);
-	if (ptr && size > 0)
-		page_init_poison(ptr, size);
-
-	return ptr;
+	return memblock_alloc_internal(size, align, min_addr, max_addr, nid,
+				       true);
 }
 
 /**
@@ -1528,18 +1522,12 @@ void * __init memblock_alloc_try_nid_raw(
 			phys_addr_t min_addr, phys_addr_t max_addr,
 			int nid)
 {
-	void *ptr;
-
 	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
 		     __func__, (u64)size, (u64)align, nid, &min_addr,
 		     &max_addr, (void *)_RET_IP_);
 
-	ptr = memblock_alloc_internal(size, align,
-					   min_addr, max_addr, nid, false);
-	if (ptr && size > 0)
-		page_init_poison(ptr, size);
-
-	return ptr;
+	return memblock_alloc_internal(size, align, min_addr, max_addr, nid,
+				       false);
 }
 
 /**
-- 
2.28.0

