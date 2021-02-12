Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46631A85F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 00:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBLXlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 18:41:44 -0500
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:51848 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229650AbhBLXlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:41:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id F2AFA180A8CBE;
        Fri, 12 Feb 2021 23:41:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2914:3138:3139:3140:3141:3142:3352:3865:3867:3868:4321:5007:6119:7652:7903:8603:8660:10004:10400:10848:11026:11473:11658:11914:12043:12297:12555:12760:13069:13148:13230:13311:13357:13439:14181:14394:14659:14721:21080:21433:21627:21939:21990:30012:30054:30090,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: thumb59_1407e5a27625
X-Filterd-Recvd-Size: 2131
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 12 Feb 2021 23:41:00 +0000 (UTC)
Message-ID: <a6e105886338f68afd35f7a13d73bcf06b0cc732.camel@perches.com>
Subject: [PATCH] mm: Reduce mem_dump_obj() object size
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Feb 2021 15:40:59 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by using a temporary and reduce the object size
by using a single call to pr_cont().  Reverse a test and unindent
a block too.

$ size mm/util.o* (defconfig x86-64)
   text	   data	    bss	    dec	    hex	filename
   7419	    372	     40	   7831	   1e97	mm/util.o.new
   7477	    372	     40	   7889	   1ed1	mm/util.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 mm/util.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index c37e24d5fa43..143c627fb3e8 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -997,22 +997,26 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
  */
 void mem_dump_obj(void *object)
 {
+	const char *type;
+
 	if (kmem_valid_obj(object)) {
 		kmem_dump_obj(object);
 		return;
 	}
+
 	if (vmalloc_dump_obj(object))
 		return;
-	if (!virt_addr_valid(object)) {
-		if (object == NULL)
-			pr_cont(" NULL pointer.\n");
-		else if (object == ZERO_SIZE_PTR)
-			pr_cont(" zero-size pointer.\n");
-		else
-			pr_cont(" non-paged memory.\n");
-		return;
-	}
-	pr_cont(" non-slab/vmalloc memory.\n");
+
+	if (virt_addr_valid(object))
+		type = "non-slab/vmalloc memory";
+	else if (object == NULL)
+		type = "NULL pointer";
+	else if (object == ZERO_SIZE_PTR)
+		type = "zero-size pointer";
+	else
+		type = "non-paged memory";
+
+	pr_cont(" %s\n", type);
 }
 EXPORT_SYMBOL_GPL(mem_dump_obj);
 #endif

