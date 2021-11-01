Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271D644125F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhKADZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhKADZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:25:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A9C061767
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:22:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b4so8933979pgh.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UoWjZzOHViEmzMC0Qv5p6Aol3nKS7az97fC7P92qe4=;
        b=mKP0ohFbfVQvapDd1cxSSUQoOhILeQQNi04r/0XIuYy1v7A0lxlwD8CJhLGlYGDL+S
         GEwrDudJKGSatRGKbpSPvwuO7/uK/brOWGDHxw8QH4w8v4O6lRhWgzHlaJX0KHouSdXu
         u0u7n3nu9tzbLrbcfNOvYIlsXGBjzfbEjI0dcoW2RSktQMUfiFAecvgel+yiR4Eqo2Ih
         vQPvdA8EygpJ/SIYaQh53HxuObxRie7bqsspLrdsPsTCKPGrz6K5Mb1T3nAYB1Y7gRla
         z2cqsQzcfnRBPevYTo3Uwu6XH1ez9MDwMwA64GF7nlWljkoay9o9g20tENUSudsXTJ89
         wQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UoWjZzOHViEmzMC0Qv5p6Aol3nKS7az97fC7P92qe4=;
        b=u8DXyWD9pG9zpgeOjUi4wZTEiajPAhX+PB2Iub3nTDyY/kEZ9VcJH6U+Hc6yTuQGi3
         AiRKM7cfBt76E/A4RYPu0nK06BuE7ZkSUgYzIKkjqrEbyg2FyIPOvvPffTisGKNnKqzz
         rMu5NSKIPDb8CuUdYDyNcnV2EEqCgWATchpVTaG/KUL02Ay3eSusjWk3rLAbDW81BIB9
         5fz4f616rxyJrEbQwq3g76ZapLSYQGLK1nRBVrhHy7exCj9kwsZ4SynBGFvOJsBQl2ov
         BiuIdlP6WK6XTjKuTaGrYVn7qZtSXJ+mU+J38bDgqggNiMxS9eNHt9o+DseLgqutQaxx
         G5XQ==
X-Gm-Message-State: AOAM530wbgifTaA7hamUCervjz+9RJ4x2qLxVwk0pDnP85LJJA15PUHz
        7stn5CsciHxJ21AJTmK2AbHheg==
X-Google-Smtp-Source: ABdhPJx2a87GRNdgfXSLRJ0wr6CnW8L0BkmTvheFr9coFV82vt+FtcwdaXTOQpqDZtlezPC7KbtRNg==
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id j25-20020aa78019000000b0044dd7616f79mr26229514pfi.3.1635736960495;
        Sun, 31 Oct 2021 20:22:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id f8sm11860963pjq.29.2021.10.31.20.22.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 20:22:40 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 5/5] mm: sparsemem: move vmemmap related to HugeTLB to CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
Date:   Mon,  1 Nov 2021 11:16:51 +0800
Message-Id: <20211101031651.75851-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211101031651.75851-1-songmuchun@bytedance.com>
References: <20211101031651.75851-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmemmap_remap_free/alloc are relevant to HugeTLB, so move those
functiongs to the scope of CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
---
 include/linux/mm.h  | 2 ++
 mm/sparse-vmemmap.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..8c85863a067c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3184,10 +3184,12 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 int vmemmap_remap_free(unsigned long start, unsigned long end,
 		       unsigned long reuse);
 int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 			unsigned long reuse, gfp_t gfp_mask);
+#endif
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c64d1aa3c4b5..8aecd6b3896c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -34,6 +34,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
  *
@@ -419,6 +420,7 @@ int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 
 	return 0;
 }
+#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
-- 
2.11.0

