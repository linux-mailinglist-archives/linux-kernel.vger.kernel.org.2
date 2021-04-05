Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D4354337
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbhDEPOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241459AbhDEPOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:14:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D565613B4;
        Mon,  5 Apr 2021 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617635644;
        bh=dKxdMLE70oczgojZKEiPHLISr6esx3l3vKWLu92+n+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWmLlHcQ5oy464b097eFGyU1HzfhO7KbZp1VD8J1nsJXWn4DR+OmKpiLgELNa8+RA
         t1ur2wgLZKmaor4sPvxKNMdWV/ipEe7pkYMZsrUvU1dTAQAEwn6kcy/lJa5evsxouc
         Rrkx8G2gKloXSZV0QDboyvO7U35WFKhaqzGOGXfw8VQY2lXbVUkYRZE4wu6gNKh7nn
         JtZdJGtlE96YpZPCit1dbZhJrPPiLuVirUeApNTUqsZmdHnv1fBKC94y5FHOI6BBxJ
         gJ+ruGkL99sPgqemBXCdOsxh0+08dkLnLQvnq6P7TK3AvRHYai1/XIMxqlJSlMmwvg
         MGcuUfZcRjDhw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: move page_rmapping() and page_anon_vma() to mm/internal.h
Date:   Mon,  5 Apr 2021 18:13:54 +0300
Message-Id: <20210405151355.9867-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210405151355.9867-1-rppt@kernel.org>
References: <20210405151355.9867-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The functions page_rmapping() and page_anon_vma() are not used outside core
mm. Move their declaration from include/linux/mm.h to mm/internal.h

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mm.h | 2 --
 mm/internal.h      | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ec63f37a78d..74a05dbdcc19 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1619,8 +1619,6 @@ void page_address_init(void);
 #define page_address_init()  do { } while(0)
 #endif
 
-extern void *page_rmapping(struct page *page);
-extern struct anon_vma *page_anon_vma(struct page *page);
 extern struct address_space *page_mapping(struct page *page);
 
 extern struct address_space *__page_file_mapping(struct page *);
diff --git a/mm/internal.h b/mm/internal.h
index 547a8d7f0cbb..77e0b726eef3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -358,6 +358,9 @@ void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev);
 void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
 
+void *page_rmapping(struct page *page);
+struct anon_vma *page_anon_vma(struct page *page);
+
 #ifdef CONFIG_MMU
 extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *nonblocking);
-- 
2.28.0

