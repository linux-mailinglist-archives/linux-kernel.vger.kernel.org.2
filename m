Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94AB3CC78E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 06:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhGREeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 00:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhGREeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 00:34:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1CC061764
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:07 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s18so15157518pgg.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRajOpLA0v1TNv8hnPmCgKVUqgXOc73LdDDlPiANufk=;
        b=rBZ5wgb9Doxy7AHPWbdepUo9lcn6ND7c7FJWOSnkIoEE4k8CYaxkBxncbBQa5LCg4G
         0TdSDv59/Vufe4EeGZ/3OwhHGxZviq9sQ6fvTUXyg9FB7Gets1PiLBwXnGckqcLRL422
         yWtu/GbOnL+dmSgzrE8l7Ze9reuub+QlD9tdJsV9vqRHtw2ZwhmAd5/QI6951KFNr+g4
         QxPg0hoSt3IzyWpOmrsQVWKeSUGNx3pCW8jNsf9qle7LcZy1/DeYZ2GYUh/6MDRJlwHR
         6dLBWEOGC12V2+ZypC12fopRWtEvcMCjf+AAdBQJKK5LybYs3YXBoqKlU9O046UxPei6
         PVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRajOpLA0v1TNv8hnPmCgKVUqgXOc73LdDDlPiANufk=;
        b=i3TaiwhThoFOq7ZdcoxeNw/mY+iSoTImZ+gk5+IzPSVowtcyHiZsgsWbSZLOcJ+7qG
         Jk4c4iyDizD3YowXwGKAWTSdrFH5FaRlwonTd9CI4rLbZGOTOAQeSg7jkA+TSv/KdXTA
         YrMT0la+Ks5rbO/Vqjz/8Ev1d8n2hndyrmvjh8dW48SuDfVfTj3NNDdW+jturwMFgUaI
         rCuWH4Wn5NQjQ6TPwJ2ITeBc0VUtO1zVyu6T3YcVIZTjL3GPHMTFSqzJzQk2NaVTj1Gf
         46y6uJ3qPTmuXDxtAcBR2UAuUOwkOC1BAI5+qdDYBCFf0j/jG2g0o9vmzEcNaobhioVu
         oePQ==
X-Gm-Message-State: AOAM5326O4wCbRQI1SulQKlmisLV0QnlbTYh1rGcYcUNw21T0u8OtgWy
        QPwa9Scgd4bd/OlPdphpQCYy9w==
X-Google-Smtp-Source: ABdhPJxEcAv0pVXtSymweg/qeyMcrHmxw3wFaXKXm0btaki4iny96UKNgdRKdU2xwo7CdiLjrZptgw==
X-Received: by 2002:a63:3704:: with SMTP id e4mr18222378pga.310.1626582667438;
        Sat, 17 Jul 2021 21:31:07 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a22sm16263217pgv.84.2021.07.17.21.31.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 21:31:07 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 4/7] mm: rework the parameter of lock_page_or_retry()
Date:   Sun, 18 Jul 2021 12:30:30 +0800
Message-Id: <20210718043034.76431-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we need the vmf in lock_page_or_retry() in the subsequent patch,
so pass in it directly.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pagemap.h | 8 +++-----
 mm/filemap.c            | 6 ++++--
 mm/memory.c             | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b071babc6629..bc23f6ff4fce 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -653,8 +653,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 extern void __lock_page(struct page *page);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
-extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
-				unsigned int flags);
+extern int __lock_page_or_retry(struct page *page, struct vm_fault *vmf);
 extern void unlock_page(struct page *page);
 
 /*
@@ -712,11 +711,10 @@ static inline int lock_page_async(struct page *page,
  * Return value and mmap_lock implications depend on flags; see
  * __lock_page_or_retry().
  */
-static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
-				     unsigned int flags)
+static inline int lock_page_or_retry(struct page *page, struct vm_fault *vmf)
 {
 	might_sleep();
-	return trylock_page(page) || __lock_page_or_retry(page, mm, flags);
+	return trylock_page(page) || __lock_page_or_retry(page, vmf);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 4955641f2cf0..db0184884890 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1686,9 +1686,11 @@ int __lock_page_async(struct page *page, struct wait_page_queue *wait)
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return 1
  * with the page locked and the mmap_lock unperturbed.
  */
-int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
-			 unsigned int flags)
+int __lock_page_or_retry(struct page *page, struct vm_fault *vmf)
 {
+	unsigned int flags = vmf->flags;
+	struct mm_struct *mm = vmf->vma->vm_mm;
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
diff --git a/mm/memory.c b/mm/memory.c
index 540f0c9d0970..3bf2636413ee 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3451,7 +3451,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct mmu_notifier_range range;
 
-	if (!lock_page_or_retry(page, vma->vm_mm, vmf->flags))
+	if (!lock_page_or_retry(page, vmf))
 		return VM_FAULT_RETRY;
 	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0, vma,
 				vma->vm_mm, vmf->address & PAGE_MASK,
@@ -3583,7 +3583,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
+	locked = lock_page_or_retry(page, vmf);
 
 	delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
 	if (!locked) {
-- 
2.11.0

