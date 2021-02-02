Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8D30B62F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhBBEFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhBBEFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:05:51 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C07C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:05:10 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id a7so18624685qkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 20:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TgEl1t62b0F8MSCHUvUj30llEevpoe++jneAMJ1Te1Y=;
        b=KWaqzHnwT47pq3HVkl8T4/YKZiplP0EKXd9LLGKMR16m9ottVrzafJ1STmlb/VQrti
         chhpcKzsnf5ipOJH4OR/NmBU5ipCKDne+XOwr3o2YXeUdudiRgz3nC3a7vs+M6cg/nfv
         nZZ4FfcxyrTjmzMfPvSk+UKaRF688R4lY0ok525reHjK/zNcaz8Z+BX+v+oBQ3AqDIcT
         hdl8Q2ssRk+KLY3bIkuCAXKZElqnB2qcZEynYOvyKRkCkt0PdcLSj7USy8s95fq2u473
         KXe1maLvZuComWZZ3qfSQo9sGVr0SrtQS0YYSV0f01pXI/iyC2AfzQlD2fpTNqTrz5Tm
         ZBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TgEl1t62b0F8MSCHUvUj30llEevpoe++jneAMJ1Te1Y=;
        b=ZAnsb1Ey81TuBxXRenWvLGe01jYA31Bv2ZevplyIYOPUuyPzojZE5C+PB41YKetSHC
         wqVcZpN/+rk0zrxDsnMoNz2qJO1UDF2kh20Ztl9y+B1JyLwH3lTpf8SaeWdT6++JXDhm
         np1Az+bHW4Tl0riA4IrV29txqjGLLhWHAEGBDp+rEbWw7zVtzq4g0i/MqL1w3f1sqLkN
         lL5UwU3Grwj/z8Yu8qDSTRScC72UsGUC1jrmRrnkQDvpM5/85dYPkHru9exMdn7JaMih
         AyL48ByuwUG3YWA1aQGE5zEaFrMds43IbS/+aVhJv3HBpNlr8q0viZSRFh6SVfK2Naow
         UT2A==
X-Gm-Message-State: AOAM531BrlPsjha5rIJdl0TWlP6EzfENVfcWyrUnEyn2J0z76sXCZeXg
        +V7rkeerdR/mR6zOtMzmiezo9Q==
X-Google-Smtp-Source: ABdhPJyD57iDoJqHzRKcByUhWJ0LoV2NLkJy881TtZx1CW4u8Bi9xICWh7bnvAI0C9lyb9ACWi3EzQ==
X-Received: by 2002:a37:9d56:: with SMTP id g83mr19487015qke.38.1612238709932;
        Mon, 01 Feb 2021 20:05:09 -0800 (PST)
Received: from xakep (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o3sm15639979qkg.15.2021.02.01.20.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 20:05:09 -0800 (PST)
Date:   Mon, 1 Feb 2021 23:05:07 -0500
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v9 08/14] mm/gup: do not migrate zero page
Message-ID: <CA+CK2bBjC8=cRsL5VhWkcevPsqSXWhsANVjsFNMERLT8vWtiQw@mail.gmail.com>
References: <20210201153827.444374-9-pasha.tatashin@soleen.com>
 <202102021007.udwVXuwA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102021007.udwVXuwA-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Should I send new patches or is the update for this patch sufficient?

Here is updated patch:


From 9fb856f3a5cfda18a4b84e81dfb0266bee4a4ea6 Mon Sep 17 00:00:00 2001
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Jan 2021 17:35:18 -0500
Subject: [PATCH v9 08/14] mm/gup: do not migrate zero page

On some platforms ZERO_PAGE(0) might end-up in a movable zone. Do not
migrate zero page in gup during longterm pinning as migration of zero page
is not allowed.

For example, in x86 QEMU with 16G of memory and kernelcore=5G parameter, I
see the following:

Boot#1: zero_pfn  0x48a8d zero_pfn zone: ZONE_DMA32
Boot#2: zero_pfn 0x20168d zero_pfn zone: ZONE_MOVABLE

On x86, empty_zero_page is declared in .bss and depending on the loader
may end up in different physical locations during boots.

Also, move is_zero_pfn() my_zero_pfn() functions under CONFIG_MMU, because
zero_pfn that they are using is declared in memory.c which is compiled
with CONFIG_MMU.

is_pinnable_page() is needed only when CONFIG_MIGRATION is set, because
without page migration all pages are pinnable, so add a stub version of
is_pinnable_page() for !CONFIG_MIGRATION case. This also solves issues
where mm.h is included but is_zero_pfn() is not available because of
CONFIG_MMU is not set.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/mm.h      | 10 +++++++++-
 include/linux/mmzone.h  |  4 ++++
 include/linux/pgtable.h |  3 +--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index db228aa8d9f7..a5cb32183ac5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1127,11 +1127,19 @@ static inline bool is_zone_movable_page(const struct page *page)
 	return page_zonenum(page) == ZONE_MOVABLE;
 }
 
+#ifdef CONFIG_MIGRATION
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !is_zone_movable_page(page) && !is_migrate_cma_page(page);
+	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
+		is_zero_pfn(page_to_pfn(page));
 }
+#else
+static inline bool is_pinnable_page(struct page *page)
+{
+	return true;
+}
+#endif
 
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 void free_devmap_managed_page(struct page *page);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 87a7f9e2d1c2..aacbed98a1ed 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -427,6 +427,10 @@ enum zone_type {
 	 *    techniques might use alloc_contig_range() to hide previously
 	 *    exposed pages from the buddy again (e.g., to implement some sort
 	 *    of memory unplug in virtio-mem).
+	 * 6. ZERO_PAGE(0), kernelcore/movablecore setups might create
+	 *    situations where ZERO_PAGE(0) which is allocated differently
+	 *    on different platforms may end up in a movable zone. ZERO_PAGE(0)
+	 *    cannot be migrated.
 	 *
 	 * In general, no unmovable allocations that degrade memory offlining
 	 * should end up in ZONE_MOVABLE. Allocators (like alloc_contig_range())
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1d3087753426..bad0f417adb3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1118,6 +1118,7 @@ extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 extern void untrack_pfn_moved(struct vm_area_struct *vma);
 #endif
 
+#ifdef CONFIG_MMU
 #ifdef __HAVE_COLOR_ZERO_PAGE
 static inline int is_zero_pfn(unsigned long pfn)
 {
@@ -1142,8 +1143,6 @@ static inline unsigned long my_zero_pfn(unsigned long addr)
 }
 #endif
 
-#ifdef CONFIG_MMU
-
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-- 
2.25.1

