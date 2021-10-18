Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB165431607
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhJRK2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhJRK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:28:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA73C061765
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:25:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so12168503pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UoWjZzOHViEmzMC0Qv5p6Aol3nKS7az97fC7P92qe4=;
        b=Gd5h2gBCnRqEtZChFB1olUuihrmox4cKyIUyPvGqjLMLY6jUZ3uNVPFTHJpBzZo6qf
         5Hl+3LYSiOcMkFuJpfr5+FRq/6ej3achjCnGkj1gjgWjsrPpaglpOzUccBvGHbXhyaRJ
         U3bqhb81C6A//0N06JgcY1sw7snoGzjn3zeZaH/myJFRSRFGM91aXvZqjOVwPG3AKLCg
         l92aTjdVAWMtEzATNw6Dq1y+py7fkGmsKDAM3Z1yAreL6h1LPiSSfEJ8xS/viJRZD3xZ
         hZM5KDPXAdAWFQK0ron8FDsAZCo02VaPhkeRYGlsOXRWMa+c05HGLFF0lVGshnjQkaOo
         ZLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UoWjZzOHViEmzMC0Qv5p6Aol3nKS7az97fC7P92qe4=;
        b=qCAKW+0fV6YJlbkjqvX761qEA2zNYJ85dlfOWTNiD7nVJUDGuELN6cx1AFUxsysu0t
         bEyi5v3xpYOtbGzBAybfBT3UDCLX8rQGsEjiY3ZWKR2y/Ctb8MW8olA3eW5spwb6m6Fe
         pRLFQed9XAD7z10fcCd1C//oaeuGfRs6zUJ3NKTW4BCstGS8Yt1N/+4kbqjGOagxW35D
         u+iiyrZDLHoEqjRlldhqkBTPu61QXR9098tSxEh8zH4brIpf2PXxuBc6Gy2RQNIK6TAq
         yetVO0WGyWKGH3KJVXDOOkIMRrP7Jkk7Eb7VXak1vXfbO+QA5mhlBt0oJrTWGmfzlS3r
         zvSg==
X-Gm-Message-State: AOAM532QxcVXncro3vgUq6s7+zZAfCz3b1J24jhszQptq/LKafy6n5YT
        Kei4Y3oz1ozSh5aP959gdDYu2w==
X-Google-Smtp-Source: ABdhPJwYZ3gvRiwyFh8hGZtiS4aEnAV/VG+UgzKIi92f3MeJyhYUk6ojpZOUzHRjbfYDUeAIK1iKTw==
X-Received: by 2002:a17:90a:1a4c:: with SMTP id 12mr47381855pjl.89.1634552754998;
        Mon, 18 Oct 2021 03:25:54 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id nn14sm12762232pjb.27.2021.10.18.03.25.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:25:54 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 5/5] mm: sparsemem: move vmemmap related to HugeTLB to CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
Date:   Mon, 18 Oct 2021 18:20:43 +0800
Message-Id: <20211018102043.78685-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211018102043.78685-1-songmuchun@bytedance.com>
References: <20211018102043.78685-1-songmuchun@bytedance.com>
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

