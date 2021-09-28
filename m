Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0567241AF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbhI1Moz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240809AbhI1Mow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:44:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5070CC061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:43:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1640002pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LAyp9r8bOnwik80mbEioL/ye7jfFZ1gOmLErvcKKTI=;
        b=PZHYivOVjs95VPpnWAgIp+6wL2rO4Ei1SF0+27DUnepUrm/zMtRtbU2mlqVRY+S+rA
         WRC6aCYL7YVeOOL4f+Su0wYtNgIfZO4XjOkC/AfgbjLb33+gN/mK7v6hWZTFPdWfyBb4
         y5wCkJC/tBASlA2Q+PAXCQtkDkcht+yuoPr06set4eSvacjapOusf94iiGD5QhwyB2Hx
         xq3Gwr95haRW+fg4am3pCo4Y4qBKo1v1N48C7ZLMj/9H4I7/wwxNNvU4D/M99CAK9Q5X
         QTnpNehLBkPuY0sE2GYO28xP9feWQH+OVCHqpJ+rbPxj7roisp7IdHRwnuRUB+krQVJy
         Y5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LAyp9r8bOnwik80mbEioL/ye7jfFZ1gOmLErvcKKTI=;
        b=qFJSVax9VInEci0Ur//eOYWdhTFrUpMi9QQSAA4gMngfGitwA+J0lzzLA6B+EHzk7y
         ERttzgz30rj0w+DNR9zqd44oerKiwuCFwIJJUtg2/G/9VPcPffJSD4OIpJGBBYGAG9MP
         lS3KWWDO1ly4cSV3nuAFWm0a+PQyZWOCsUUCUcJgt6xdCk8EHkfP/BQKEv5ReYUm3MJJ
         Hu1rNqfk0fCTsfTXU8M213k5oD8ibANzZia+jSp1EjXbwy47zrItaDnEijrQawwA4/Qd
         GFWOy7fpZ/jNOwwDCG2Up+zO4CqaU7sn/4f5FQbMDq1z9yZlYLDj8Kc/eNL1J3Arshfx
         XBkw==
X-Gm-Message-State: AOAM530oSmhhGO1LGCBO4JKXn/jw85iRupZRUUCQSZvz9tYA03Q3bTE3
        e3o5/5RbcAcwlwEn5yg14s95Jw6Ba1CXfg==
X-Google-Smtp-Source: ABdhPJyZWXa2EClSDC6dnvkI3nryJK9ZCpSndKPVprcLvqe+9w4aBO4h5eUHs1nGNfjmVqKd7FShJQ==
X-Received: by 2002:a17:90a:c914:: with SMTP id v20mr5330329pjt.208.1632832992907;
        Tue, 28 Sep 2021 05:43:12 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id s17sm10055287pge.50.2021.09.28.05.43.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:43:12 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 5/5] mm: sparsemem: move vmemmap related to HugeTLB to CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
Date:   Tue, 28 Sep 2021 20:41:52 +0800
Message-Id: <20210928124152.33634-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210928124152.33634-1-songmuchun@bytedance.com>
References: <20210928124152.33634-1-songmuchun@bytedance.com>
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
index 00bb2d938df4..a706e7ffda94 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3182,10 +3182,12 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
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
index ba76d8765211..ad73650809ed 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -34,6 +34,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
  *
@@ -423,6 +424,7 @@ int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 
 	return 0;
 }
+#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
-- 
2.11.0

