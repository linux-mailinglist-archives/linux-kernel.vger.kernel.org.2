Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504BA4185E5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 05:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhIZDRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 23:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhIZDRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 23:17:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0795CC061604
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 20:15:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q23so12411805pfs.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 20:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBVREcbULLdqaPu2xVXA/zzEvcIr2XcW00aGGgEt1R0=;
        b=AIt908PRuKK8faRpMJ6vdoIzcoydx21Jsb8fY7MrXRpJmjdkBtjzxlfPQLHCUXvqZK
         DVOLTHIHa8EYlxC1ziWx5RVNhDDrFwtVgEJQavOLkucLoYFg91hCTvk+edMhvHzWrzIA
         qQY+h1deTymLNbzXPLNvYsUXEHylU81xQ3UJP+oaphv2oWJ+6UeGctVlXDvL2XAL/2rQ
         8VzPBewHjvvhGKcAJOcTB2cHkrRdvEJ+xEI+574MDWiFtj3KE5Q8Nu4SkeXEfdOwxFYp
         QwMMm5vMMTeU+ytG6apzi2wRMvgqQM+kyH78VD9nQGBel77Duf619wZr/sYVdj+wlF0g
         /ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBVREcbULLdqaPu2xVXA/zzEvcIr2XcW00aGGgEt1R0=;
        b=iAdhfBiDBy+0j/V/I4z5d3WKSZ3NcSCqQYuJoXQxRL4beuWlM2ELtp4B5TJpV7Q5QN
         AoI1EIRBQMJNOr/o2xKKW6qwaOgDuC423VCWkxvqtuhrXde6EkN5Bzw/PRe2peHw+hXg
         KUzzSL71i6r0W0UfgiLEtpf5D7XoX/V+8RydDsw01VvaS3AyUqgH1PTm8bjV79MlllCP
         7uLflwPCFht7Ls6IeaGNVLyvrf63BNmUmGnsc+kZBQDJRMGF6c8k8v8OezO0ewX3qB16
         yURb3hHM2VfZglNu124b2aRM5VXztzw1HQqhRSej8JaQpqDXqltQfraD9Hfg+ABBVoEk
         9dhw==
X-Gm-Message-State: AOAM530fociP3ztHIvF+NGX5MBY+PeWqhN3hLWQnrSuv/K9GOw8bFzUc
        aB5B4XH9P9OIi5fYlw0vCL5Ktg==
X-Google-Smtp-Source: ABdhPJy4n8ITV5TO8x69HoiW/b5VWS7o6Hbt05+tkS6I4fn84pt8iljnvISDWFvfVDkdcEfSaiBJJg==
X-Received: by 2002:a65:640f:: with SMTP id a15mr510106pgv.106.1632626127582;
        Sat, 25 Sep 2021 20:15:27 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id v26sm13374862pfm.175.2021.09.25.20.15.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 20:15:27 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 5/5] mm: sparsemem: move vmemmap related to HugeTLB to CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
Date:   Sun, 26 Sep 2021 11:13:39 +0800
Message-Id: <20210926031339.40043-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210926031339.40043-1-songmuchun@bytedance.com>
References: <20210926031339.40043-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmemmap_remap_free/alloc are relevant to HugeTLB, so move those
functiongs to the scope of CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
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
index d486a7a48512..3c7dd41c3164 100644
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

