Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6163EE803
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhHQIJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbhHQIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:09:05 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CEC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:08:32 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y144so9074962qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=yPVqNjs8S0x0LLXwfSsq3Ltg/Qi8LUyfAy6QtPUapKA=;
        b=g/Fg6bZrAxIbupmhS5dSbFCnNgJkj/wYTVJIYprq/8PyNs3Gh15tIagFO6PrLyoCqa
         MHaXZtFVvPEsOwCWGrgU+lo74kMB+iqHHD3FYVq10vRvxDJwzhWzVxxiF93jjcYsSycr
         qPdR+niUBfn11+/fDaA4ZrZvFVb8pcAWADn3mxd0FdewnLiix0Zlgdbkd9UMxR6V+Iup
         9ZrshxPtY8rrkOdvLUba+5ydIbYOl3WEyrowIF2GIgKajoYmIzvyenz99bvVv/bpwjx3
         mlLMvrSfEMyD1g273t3m3+NmP9+NYcuk6GWJifpj07u5v0ut5zTx4suQM0YlTxUTMbTA
         K6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=yPVqNjs8S0x0LLXwfSsq3Ltg/Qi8LUyfAy6QtPUapKA=;
        b=dQlfA7AakH6xIizLYGShTPf/9lfLMo6GOmiTa82KqFFNYBm1rwQtrpHAk5+W1+Mdnz
         IJM4x2ZTj1PutMplQqdSK2Arn+naktaicIXbC8hpnEdovr25peNlKsFaY+Nr9FllJwDK
         WSQUFgeFjVnkLmd1iYFP+CIQYi0r+noJ/bRnaGdGhhRspJfqsTF0FVJnDqy5TNm7Dw0w
         Cfn+f4RPswlkCfL1aFW6ab2UB0GUZTj+KC9VWGNAVLD55K6JZ0uYvRRlSxsGfAAMTviI
         I4mI2iPg+MWMTt+NfHeshDr/NlRlCedqaiy2kTbmfKoxm6clhZqBZ2F9rRTCzmOVzu9b
         Eg+Q==
X-Gm-Message-State: AOAM5313oH+fvS4ulwBpD2Eo9BDsUMFV/jHXqeHZcHHCbRtwDF6OJ1on
        t5ia393b/vtcm3sQh9ojTFIC0g==
X-Google-Smtp-Source: ABdhPJzGQykj6ORsSgfbNvY9x6ME3qPyZ0Focfx6ABQXFjHxBZquAYhAqcicy73+i54YlidrRixbcg==
X-Received: by 2002:a37:e306:: with SMTP id y6mr2594089qki.203.1629187711636;
        Tue, 17 Aug 2021 01:08:31 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ay36sm851455qkb.72.2021.08.17.01.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:08:31 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:08:28 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/9] huge tmpfs: fix split_huge_page() after
 FALLOC_FL_KEEP_SIZE
In-Reply-To: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
Message-ID: <ca9a146-3a59-6cd3-7f28-e9a044bb1052@google.com>
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A successful shmem_fallocate() guarantees that the extent has been
reserved, even beyond i_size when the FALLOC_FL_KEEP_SIZE flag was used.
But that guarantee is broken by shmem_unused_huge_shrink()'s attempts to
split huge pages and free their excess beyond i_size; and by other uses
of split_huge_page() near i_size.

It's sad to add a shmem inode field just for this, but I did not find a
better way to keep the guarantee.  A flag to say KEEP_SIZE has been used
would be cheaper, but I'm averse to unclearable flags.  The fallocend
field is not perfect either (many disjoint ranges might be fallocated),
but good enough; and gains another use later on.

Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/shmem_fs.h | 13 +++++++++++++
 mm/huge_memory.c         |  6 ++++--
 mm/shmem.c               | 15 ++++++++++++++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 8e775ce517bb..9b7f7ac52351 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -18,6 +18,7 @@ struct shmem_inode_info {
 	unsigned long		flags;
 	unsigned long		alloced;	/* data pages alloced to file */
 	unsigned long		swapped;	/* subtotal assigned to swap */
+	pgoff_t			fallocend;	/* highest fallocate endindex */
 	struct list_head        shrinklist;     /* shrinkable hpage inodes */
 	struct list_head	swaplist;	/* chain of maybes on swap */
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
@@ -119,6 +120,18 @@ static inline bool shmem_file(struct file *file)
 	return shmem_mapping(file->f_mapping);
 }
 
+/*
+ * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
+ * beyond i_size's notion of EOF, which fallocate has committed to reserving:
+ * which split_huge_page() must therefore not delete.  This use of a single
+ * "fallocend" per inode errs on the side of not deleting a reservation when
+ * in doubt: there are plenty of cases when it preserves unreserved pages.
+ */
+static inline pgoff_t shmem_fallocend(struct inode *inode, pgoff_t eof)
+{
+	return max(eof, SHMEM_I(inode)->fallocend);
+}
+
 extern bool shmem_charge(struct inode *inode, long pages);
 extern void shmem_uncharge(struct inode *inode, long pages);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index afff3ac87067..890fb73ac89b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2454,11 +2454,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	for (i = nr - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
-		/* Some pages can be beyond i_size: drop them from page cache */
+		/* Some pages can be beyond EOF: drop them from page cache */
 		if (head[i].index >= end) {
 			ClearPageDirty(head + i);
 			__delete_from_page_cache(head + i, NULL);
-			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
+			if (shmem_mapping(head->mapping))
 				shmem_uncharge(head->mapping->host, 1);
 			put_page(head + i);
 		} else if (!PageAnon(page)) {
@@ -2686,6 +2686,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		 * head page lock is good enough to serialize the trimming.
 		 */
 		end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+		if (shmem_mapping(mapping))
+			end = shmem_fallocend(mapping->host, end);
 	}
 
 	/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 0cd5c9156457..24c9da6b41c2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -905,6 +905,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
 
+	if (info->fallocend > start && info->fallocend <= end && !unfalloc)
+		info->fallocend = start;
+
 	pagevec_init(&pvec);
 	index = start;
 	while (index < end && find_lock_entries(mapping, index, end - 1,
@@ -2667,7 +2670,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_falloc shmem_falloc;
-	pgoff_t start, index, end;
+	pgoff_t start, index, end, undo_fallocend;
 	int error;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
@@ -2736,6 +2739,15 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	inode->i_private = &shmem_falloc;
 	spin_unlock(&inode->i_lock);
 
+	/*
+	 * info->fallocend is only relevant when huge pages might be
+	 * involved: to prevent split_huge_page() freeing fallocated
+	 * pages when FALLOC_FL_KEEP_SIZE committed beyond i_size.
+	 */
+	undo_fallocend = info->fallocend;
+	if (info->fallocend < end)
+		info->fallocend = end;
+
 	for (index = start; index < end; ) {
 		struct page *page;
 
@@ -2750,6 +2762,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		else
 			error = shmem_getpage(inode, index, &page, SGP_FALLOC);
 		if (error) {
+			info->fallocend = undo_fallocend;
 			/* Remove the !PageUptodate pages we added */
 			if (index > start) {
 				shmem_undo_range(inode,
-- 
2.26.2

