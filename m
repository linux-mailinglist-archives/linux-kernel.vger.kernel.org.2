Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56468319104
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhBKR1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhBKQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:27:54 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0468C061226
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:24:42 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id r13so2801862qvm.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vFtb7b0TLXam2e0aSgOj3DDhIq1OSPT7SAwjt/JgMSo=;
        b=GuSLnZfP8wJEXP3BvQ+7AnENrHoKxCqomT/DlUEKn8z/43ED1ocN+7Rjb5Xy9YLI7D
         PMvihL04KPGberT/PXD29PCzYnmUf7r2qu0nc4+uowMSJ9tRymgKYkn4hJqQO1LjJHij
         lcIjjVMuc1ZyVKAHY2hfAcvmVkzLB0S1h9/6IMFOB1vegIEKnqRuwjIE3fQzUnFQgys9
         xIYUEH37orhL0JpDvprzfPSs6GL9vUyWtVc0Sy7x7+6uFB88Bgr+W+xwf3Usp2TwVZ8l
         FwOGshdMCz44xib67tlBOu0DEu0P3Nwd8uyzATPsdk4ZQtVN1B618BcB+SKvt4r6rqdQ
         5qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vFtb7b0TLXam2e0aSgOj3DDhIq1OSPT7SAwjt/JgMSo=;
        b=JA4OE6fDdn7342DiLejGxSgtixrMk+aLjWOpgAIZN2WQte6lKWZMFE0JM+pV3r4Dli
         yvxUBkozCui5antylRErt3YlM1T8jGTKoKTXQCoMjdNEwHW+aewQ1ChwpEX8GkPI/NNu
         7GiEN/bKeiWnairTEIT0srIn2vwiu+c/8rSUAynp8BRFzvccMTytNKeBzvWCRPwnhrIo
         A2I5XQDjradaqMJDIizAT9eaE385Bqz3lPTe8KshcPVz7r9ht/DnJSASien6LiO3Nvls
         93AT+ojdZ1Y4IJk5eyYEJYPhQ9acHOFXPCTdXwtSwUEwInwCkz3HfDHmE5p2dkQEGspY
         wmKA==
X-Gm-Message-State: AOAM531T8jujirujH+cKnZ4VxF6VKDltsiC0ZFFKsParNgUTqJZ+7+mq
        SxdGVIkbK/7Dy9jzJxdyR5FCDA==
X-Google-Smtp-Source: ABdhPJyDv3BizAlWiHVEhqxZDYR768wuEmVRtyBG373FDXh51pcNa96wloLfU8fidQTqpajQEDtbIQ==
X-Received: by 2002:a0c:b66c:: with SMTP id q44mr8438487qvf.3.1613060682040;
        Thu, 11 Feb 2021 08:24:42 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:41 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v10 08/14] mm/gup: do not migrate zero page
Date:   Thu, 11 Feb 2021 11:24:21 -0500
Message-Id: <20210211162427.618913-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/mm.h      |  3 ++-
 include/linux/mmzone.h  |  4 ++++
 include/linux/pgtable.h | 12 ++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9a31b2298c1d..9ea4b9305ae5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1131,7 +1131,8 @@ static inline bool is_zone_movable_page(const struct page *page)
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !is_zone_movable_page(page) && !is_migrate_cma_page(page);
+	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
+		is_zero_pfn(page_to_pfn(page));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 47946cec7584..66132f8f051e 100644
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
index cdfc4e9f253e..9a218d7eed06 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1107,6 +1107,7 @@ extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 extern void untrack_pfn_moved(struct vm_area_struct *vma);
 #endif
 
+#ifdef CONFIG_MMU
 #ifdef __HAVE_COLOR_ZERO_PAGE
 static inline int is_zero_pfn(unsigned long pfn)
 {
@@ -1130,6 +1131,17 @@ static inline unsigned long my_zero_pfn(unsigned long addr)
 	return zero_pfn;
 }
 #endif
+#else
+static inline int is_zero_pfn(unsigned long pfn)
+{
+	return 0;
+}
+
+static inline unsigned long my_zero_pfn(unsigned long addr)
+{
+	return 0;
+}
+#endif /* CONFIG_MMU */
 
 #ifdef CONFIG_MMU
 
-- 
2.25.1

