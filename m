Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68EE362BD8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhDPXQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhDPXQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:16:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91385C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Aex13N1mj02W6YuhwMiGvmFi1HUcFpH8YDLXt7so1pg=; b=XIDsz8sR0NXIJuEAiDe/JQCrW0
        7Z7h+02Nsl4XrzHer2flK6cx9JRDCdEG+hYsgLWuRztPSSRMajjQg8rajl4QTkTpvEqvmK06W8uiF
        gtMZKPVNbBl8KxUNZly9Kt4PhuFNkZJR7pyJx51ZKbSmxQTi6rDWXAHaj6RvfhgEGNzrrd/7PhXZR
        sl8nhKhErmthqd2uPiVfZv/ryxwW8I9PdNg/WukTctwdoYV+4VdhW7trSZuZwf+V4yHZf6UHBMzYI
        FOZSgvXIplhfgmwOcgEpnTuiIe1RLze8fLhVlClJYCUJbZKDNNkq3L8BsQ5M1h17G0Xe35P07ez8M
        8VxmuZpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXXgk-00AZwu-SC; Fri, 16 Apr 2021 23:15:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mm: Make __dump_page static
Date:   Sat, 17 Apr 2021 00:15:26 +0100
Message-Id: <20210416231531.2521383-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210416231531.2521383-1-willy@infradead.org>
References: <20210416231531.2521383-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of __dump_page() now opencodes dump_page(), so
remove it as an externally visible symbol.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mmdebug.h | 3 +--
 mm/debug.c              | 2 +-
 mm/page_alloc.c         | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 5d0767cb424a..1935d4c72d10 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -9,8 +9,7 @@ struct page;
 struct vm_area_struct;
 struct mm_struct;
 
-extern void dump_page(struct page *page, const char *reason);
-extern void __dump_page(struct page *page, const char *reason);
+void dump_page(struct page *page, const char *reason);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
 
diff --git a/mm/debug.c b/mm/debug.c
index 0bdda8407f71..84cdcd0f7bd3 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -42,7 +42,7 @@ const struct trace_print_flags vmaflag_names[] = {
 	{0, NULL}
 };
 
-void __dump_page(struct page *page, const char *reason)
+static void __dump_page(struct page *page, const char *reason)
 {
 	struct page *head = compound_head(page);
 	struct address_space *mapping;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5a35f21b57c6..0152670c6f04 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -658,8 +658,7 @@ static void bad_page(struct page *page, const char *reason)
 
 	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
 		current->comm, page_to_pfn(page));
-	__dump_page(page, reason);
-	dump_page_owner(page);
+	dump_page(page, reason);
 
 	print_modules();
 	dump_stack();
-- 
2.30.2

