Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA923EE83A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhHQIPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhHQIPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:15:06 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C2DC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:14:33 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l24so16465199qtj.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=DbxPYfIkUPggZAsAtUCUkg6hl6OjGtFlTtB9svwXDrQ=;
        b=MDYcRkXC9AzT6oic9Y7EK7P1oSIPrdRZWVwOjHsGLa0HsxCTUKzB+DS0sGLQjGY/9S
         e8e61iUUn8EsNT83aYltwJUcWEOHDUw/LXFBiZ453w5uthUmSUmdnFQbljDGEUQ9IbUt
         i2Ga/mi050hZMvUnlMdgWb4cjPD2weaNZUWBLmfKuUQ0JbseitjMlkdmG0Ecuq3Q7G9c
         TtWRWYq0W1t9gmpAABN+fQEqNoBoBZ/A1ozRzCbtl6t09dVevv0k1Uyt5gqORKWINAcn
         0WsBBncQjV0O+CFNnf3eEuLfDDwXo15Bno8lhGwndXWjNXHHbLiIhoCmij6Et44IbzLx
         CbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=DbxPYfIkUPggZAsAtUCUkg6hl6OjGtFlTtB9svwXDrQ=;
        b=DyKV+oGLSoadFu8E4Pmha5unpw8nfuSMX3THV/IjStCLWMojcarZcFgARciq1wv1N1
         Ysy2zXa3ZFYG3SGdUxHQ/55p7zqW4I+XXpAk0uNeREDT0T/JdM8js8gSPRT312RXLgwD
         MGplQvAqQFQ1nOavAAEZl0PejpfwD0YEC2ksh6JI3ObvK14vKwbsBPQQ71aqNs9bLBPm
         U7jDJlJ3QWPfvisF5huU+7Gga5YCgmg/sjH/+vPIE6cbKz4sJPNNz9ANYbCwzSaNlN0k
         3317VztjxSbzlyeKhs2LueZ+WOcej241mH0XXEhnNyxYpnxu3W1q3JZhMpiCJEWfRWpy
         v5Lg==
X-Gm-Message-State: AOAM5327iNzMGPR/EQXtxrzIQ8QZQip3o/kx7ZgrZSBHWTZJiVtMvtrL
        84ze4AK3SHYvphLiXIdtfYzZ7w==
X-Google-Smtp-Source: ABdhPJzvjRKbcrqPoj6rWq+pXSIKfeRz0vrhFSmbk/werhszUnq0bvTCdRv0bGfj0WZ24e/T5B6N3Q==
X-Received: by 2002:a05:622a:255:: with SMTP id c21mr1947762qtx.128.1629188072480;
        Tue, 17 Aug 2021 01:14:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x21sm891928qkf.76.2021.08.17.01.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:14:31 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:14:29 -0700 (PDT)
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
Subject: [PATCH 5/9] huge tmpfs: move shmem_huge_enabled() upwards
In-Reply-To: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
Message-ID: <16fec7b7-5c84-415a-8586-69d8bf6a6685@google.com>
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_huge_enabled() is about to be enhanced into shmem_is_huge(),
so that it can be used more widely throughout: before making functional
changes, shift it to its final position (to avoid forward declaration).

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/shmem.c | 72 ++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c6fa6f4f2db8..740d48ef1eb5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -476,6 +476,41 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly;
 
+bool shmem_huge_enabled(struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	loff_t i_size;
+	pgoff_t off;
+
+	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+		return false;
+	if (shmem_huge == SHMEM_HUGE_FORCE)
+		return true;
+	if (shmem_huge == SHMEM_HUGE_DENY)
+		return false;
+	switch (sbinfo->huge) {
+	case SHMEM_HUGE_NEVER:
+		return false;
+	case SHMEM_HUGE_ALWAYS:
+		return true;
+	case SHMEM_HUGE_WITHIN_SIZE:
+		off = round_up(vma->vm_pgoff, HPAGE_PMD_NR);
+		i_size = round_up(i_size_read(inode), PAGE_SIZE);
+		if (i_size >= HPAGE_PMD_SIZE &&
+				i_size >> PAGE_SHIFT >= off)
+			return true;
+		fallthrough;
+	case SHMEM_HUGE_ADVISE:
+		/* TODO: implement fadvise() hints */
+		return (vma->vm_flags & VM_HUGEPAGE);
+	default:
+		VM_BUG_ON(1);
+		return false;
+	}
+}
+
 #if defined(CONFIG_SYSFS)
 static int shmem_parse_huge(const char *str)
 {
@@ -3995,43 +4030,6 @@ struct kobj_attribute shmem_enabled_attr =
 	__ATTR(shmem_enabled, 0644, shmem_enabled_show, shmem_enabled_store);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-bool shmem_huge_enabled(struct vm_area_struct *vma)
-{
-	struct inode *inode = file_inode(vma->vm_file);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-	loff_t i_size;
-	pgoff_t off;
-
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return false;
-	if (shmem_huge == SHMEM_HUGE_FORCE)
-		return true;
-	if (shmem_huge == SHMEM_HUGE_DENY)
-		return false;
-	switch (sbinfo->huge) {
-		case SHMEM_HUGE_NEVER:
-			return false;
-		case SHMEM_HUGE_ALWAYS:
-			return true;
-		case SHMEM_HUGE_WITHIN_SIZE:
-			off = round_up(vma->vm_pgoff, HPAGE_PMD_NR);
-			i_size = round_up(i_size_read(inode), PAGE_SIZE);
-			if (i_size >= HPAGE_PMD_SIZE &&
-					i_size >> PAGE_SHIFT >= off)
-				return true;
-			fallthrough;
-		case SHMEM_HUGE_ADVISE:
-			/* TODO: implement fadvise() hints */
-			return (vma->vm_flags & VM_HUGEPAGE);
-		default:
-			VM_BUG_ON(1);
-			return false;
-	}
-}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-
 #else /* !CONFIG_SHMEM */
 
 /*
-- 
2.26.2

