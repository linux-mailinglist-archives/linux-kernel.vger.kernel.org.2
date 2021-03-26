Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E429934A670
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCZL1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:27:17 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:56738 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbhCZL04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:26:56 -0400
Received: by sf.home (Postfix, from userid 1000)
        id E89FA5A22061; Fri, 26 Mar 2021 11:26:51 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>
Subject: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
Date:   Fri, 26 Mar 2021 11:26:50 +0000
Message-Id: <20210326112650.307890-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_on_free=1 does not guarantee that free pages contain only zero bytes.

Some examples:
1. page_poison=on takes presedence over init_on_alloc=1 / ini_on_free=1
2. free_pages_prepare() always poisons pages:

       if (want_init_on_free())
           kernel_init_free_pages(page, 1 << order);
       kernel_poison_pages(page, 1 << order

I observed use of poisoned pages as the crash on ia64 booted with
init_on_free=1 init_on_alloc=1 (CONFIG_PAGE_POISONING=y config).
There pmd page contained 0xaaaaaaaa poison pages and led to early crash.

The change drops the assumption that init_on_free=1 guarantees free
pages to contain zeros.

Alternative would be to make interaction between runtime poisoning and
sanitizing options and build-time debug flags like CONFIG_PAGE_POISONING
more coherent. I took the simpler path.

Tested the fix on rx3600.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-mm@kvack.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc72873961d..d57d9b4f7089 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2301,7 +2301,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	kernel_unpoison_pages(page, 1 << order);
 	set_page_owner(page, order, gfp_flags);
 
-	if (!want_init_on_free() && want_init_on_alloc(gfp_flags))
+	if (want_init_on_alloc(gfp_flags))
 		kernel_init_free_pages(page, 1 << order);
 }
 
-- 
2.31.0

