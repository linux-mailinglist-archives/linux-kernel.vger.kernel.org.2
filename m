Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF273EC8D8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbhHOLwm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 15 Aug 2021 07:52:42 -0400
Received: from mail1.shanghaitech.edu.cn ([119.78.254.90]:4759 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229597AbhHOLwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 07:52:41 -0400
Received: from [10.15.44.216] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 7712015506132;
        Sun, 15 Aug 2021 19:51:51 +0800 (CST)
Received: from DESKTOP-U066CHB.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.216) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Sun, 15 Aug 2021 19:51:53 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next v2] include/linux/mm.h: move nr_free_buffer_pages from swap.h to mm.h
Date:   Sun, 15 Aug 2021 19:50:57 +0800
Message-ID: <20210815115057.1511-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_free_buffer_pages could be exposed through mm.h instead of swap.h.
The advantage of this change is that it can reduce the obsolete includes.
For example, net/ipv4/tcp.c wouldn't need swap.h any more since it has
already included mm.h.
Moreover, after preprocessing all the files that use nr_free_buffer_pages,
it turns out that those files have already included mm.h.
Thus, we can move nr_free_buffer_pages from swap.h to mm.h safely. This change
will not affect the compilation of other files.

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>
---
 include/linux/mm.h   | 1 +
 include/linux/swap.h | 2 +-
 net/ipv4/tcp.c       | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce8fc0fd6..6ca7b7fba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -871,6 +871,7 @@ void put_pages_list(struct list_head *pages);
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
 
+extern unsigned long nr_free_buffer_pages(void);
 /*
  * Compound pages have a destructor function.  Provide a
  * prototype for that function and accessor functions.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index cdf0957a8..22b17431a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -341,7 +341,7 @@ void workingset_update_node(struct xa_node *node);
 
 /* linux/mm/page_alloc.c */
 extern unsigned long totalreserve_pages;
-extern unsigned long nr_free_buffer_pages(void);
+
 
 /* Definition of global_zone_page_state not available yet */
 #define nr_free_pages() global_zone_page_state(NR_FREE_PAGES)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f931def63..dcdd8ebfb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -260,7 +260,6 @@
 #include <linux/random.h>
 #include <linux/memblock.h>
 #include <linux/highmem.h>
-#include <linux/swap.h>
 #include <linux/cache.h>
 #include <linux/err.h>
 #include <linux/time.h>
-- 
2.25.1


