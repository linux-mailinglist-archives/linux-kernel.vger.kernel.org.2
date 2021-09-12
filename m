Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB14E407DAB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhILNiz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Sep 2021 09:38:55 -0400
Received: from mail.shanghaitech.edu.cn ([119.78.254.11]:39017 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhILNiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 09:38:52 -0400
Received: from [10.15.44.216] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 4804012443630103;
        Sun, 12 Sep 2021 21:37:16 +0800 (CST)
Received: from DESKTOP-U066CHB.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.216) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Sun, 12 Sep 2021 21:37:16 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>,
        Pravin B Shelar <pshelar@ovn.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next v3] include/linux/mm.h: move nr_free_buffer_pages from swap.h to mm.h
Date:   Sun, 12 Sep 2021 21:36:40 +0800
Message-ID: <20210912133640.1624-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_free_buffer_pages could be exposed through mm.h instead of swap.h. The
advantage of this change is that it can reduce the obsolete includes. For
example, net/ipv4/tcp.c wouldn't need swap.h any more since it has already
included mm.h. Similarly, after checking all the other files, it comes that
tcp.c, udp.c meter.c ,... follow the same rule, so these files can have swap.h
removed too.

Moreover, after preprocessing all the files that use nr_free_buffer_pages, it
turns out that those files have already included mm.h.Thus, we can move
nr_free_buffer_pages from swap.h to mm.h safely. This change will not affect
the compilation of other files.

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>
---
 drivers/mmc/core/mmc_test.c    | 1 -
 include/linux/mm.h             | 2 +-
 include/linux/swap.h           | 1 -
 net/ipv4/tcp.c                 | 1 -
 net/ipv4/udp.c                 | 1 -
 net/netfilter/ipvs/ip_vs_ctl.c | 1 -
 net/openvswitch/meter.c        | 1 -
 net/sctp/protocol.c            | 1 -
 8 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 63524551a..e6a2fd2c6 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -10,7 +10,6 @@
 #include <linux/slab.h>
 
 #include <linux/scatterlist.h>
-#include <linux/swap.h>		/* For nr_free_buffer_pages() */
 #include <linux/list.h>
 
 #include <linux/debugfs.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d0b5c5e19..d499fde70 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -869,7 +869,7 @@ void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
-
+unsigned long nr_free_buffer_pages(void);
 /*
  * Compound pages have a destructor function.  Provide a
  * prototype for that function and accessor functions.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index cdf0957a8..d1ea44b31 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -341,7 +341,6 @@ void workingset_update_node(struct xa_node *node);
 
 /* linux/mm/page_alloc.c */
 extern unsigned long totalreserve_pages;
-extern unsigned long nr_free_buffer_pages(void);
 
 /* Definition of global_zone_page_state not available yet */
 #define nr_free_pages() global_zone_page_state(NR_FREE_PAGES)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e8b48df73..0109279df 100644
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
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8851c9463..c99983b43 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -78,7 +78,6 @@
 #include <asm/ioctls.h>
 #include <linux/memblock.h>
 #include <linux/highmem.h>
-#include <linux/swap.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/module.h>
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index c25097092..034e537bb 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -24,7 +24,6 @@
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
-#include <linux/swap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index 896b8f5bc..04a060ac7 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -12,7 +12,6 @@
 #include <linux/openvswitch.h>
 #include <linux/netlink.h>
 #include <linux/rculist.h>
-#include <linux/swap.h>
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index ec0f52567..35928fefa 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -33,7 +33,6 @@
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 #include <linux/highmem.h>
-#include <linux/swap.h>
 #include <linux/slab.h>
 #include <net/net_namespace.h>
 #include <net/protocol.h>
-- 
2.25.1


