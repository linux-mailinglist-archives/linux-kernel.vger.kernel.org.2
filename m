Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBD333645
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhCJHSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhCJHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:18:49 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:18:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n17so4475838plc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXWkEpHfeuofSvkF2rXCRT+BvK4vU6jK5MQilOA5vKw=;
        b=Tyud/GHIH0dgt6aYgsfzCiNwIEsV6xRhkJ9Q9Wwvgkm7Bz/m3taQq/EVcILyQlJ4t0
         OCRXRuT/ud0hIi5IVpDkkHDNXFwGPjlUxF7P5T96YtJEXiVzicNIZ4KOA2P3iaNm/4fF
         0IdJDctkPSkdIYw81XMd5u3CHTEuPPS209H4QPNt12XKGTbejKmt6vIDzvkVXbPmtfr3
         xyvSljYHdZwbhybcBw28HeK+A+pALSULAC5gojHPXudQczeanLrNCzSgbktl6A8BGdJF
         CAj7AvFeI9TihJ42DcRj8ujsYjDnyO3Q5yvBIRg6vQRmBpCrhfabOeWaNykRUnUpAmJ+
         8QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXWkEpHfeuofSvkF2rXCRT+BvK4vU6jK5MQilOA5vKw=;
        b=n5PmKtgkqJGYbWrk08f2WK4r+dhEZMzrmgOgaZ28eL2gp3pZq97ImlD6dSJBdBWMPc
         EfHYYxhwd6DXI1C1mfRa7TAmFSut6d/b1QkikMz9QIUDuhpgV13ANJyb8X2NljOvbfe5
         UIna38yFJ4/yItUD68Dslxs7iXWuJ49f+H9nYgrVnE7Dw8ksxEUO/1xB4Ppz/EWttlH3
         ltIjE9caILI1Szj11v5fs7b04Z303tZttnPC4sUVjqdKBxjmRLq6eZ6dIy5MtbcoOaGU
         bT+i2w0PDXhc/DVSkPRhbBaWc2v2+9OyIKMATwSCwOhh16uaUXd24xxFqIakmvu83Bwl
         aDaw==
X-Gm-Message-State: AOAM530ARpb/bYCMECEJD0meuPD15xLGLYFUjmmbDIEljiajBd6PIW6K
        GDeIfCegmYIniyDDTm9Xqaqhwg==
X-Google-Smtp-Source: ABdhPJxyJ/btALuDsu0SeQYdLFebI/E042dTZnHmOxOdJsJ1TP8Y1eFAv0pn/8jZN1lc4hNkZrvUtA==
X-Received: by 2002:a17:903:92:b029:e4:bf7c:cbf with SMTP id o18-20020a1709030092b02900e4bf7c0cbfmr1611247pld.55.1615360728977;
        Tue, 09 Mar 2021 23:18:48 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h15sm2828868pfo.20.2021.03.09.23.18.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:18:48 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/3] mm: hugetlb: introduce arch_free_vmemmap_page
Date:   Wed, 10 Mar 2021 15:15:34 +0800
Message-Id: <20210310071535.35245-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210310071535.35245-1-songmuchun@bytedance.com>
References: <20210310071535.35245-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We register bootmem info for vmemmap pages when boot on x86-64, so
the vmemmap pages must be freed by using free_bootmem_page(). But
on some other architectures, we do not need bootmem info. In this
case, free_reserved_page() is enough to free vmemmap pages.
Currently, only x86-64 need free_bootmem_page(), so introduce a
default arch_free_vmemmap_page() which use free_reserved_page()
to free vmemmap pages directly. On x86-64, we can implement
arch_free_vmemmap_page() to override the default behavior.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/init_64.c | 5 +++++
 mm/sparse-vmemmap.c   | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 39f88c5faadc..732609dad0ec 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1575,6 +1575,11 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 }
 
 #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
+void arch_free_vmemmap_page(struct page *page)
+{
+	free_bootmem_page(page);
+}
+
 void register_page_bootmem_memmap(unsigned long section_nr,
 				  struct page *start_page, unsigned long nr_pages)
 {
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 60fc6cd6cd23..76f7b52820e3 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -156,16 +156,21 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
 	flush_tlb_kernel_range(start + PAGE_SIZE, end);
 }
 
+void __weak arch_free_vmemmap_page(struct page *page)
+{
+	free_reserved_page(page);
+}
+
 /*
  * Free a vmemmap page. A vmemmap page can be allocated from the memblock
  * allocator or buddy allocator. If the PG_reserved flag is set, it means
  * that it allocated from the memblock allocator, just free it via the
- * free_bootmem_page(). Otherwise, use __free_page().
+ * arch_free_vmemmap_page(). Otherwise, use __free_page().
  */
 static inline void free_vmemmap_page(struct page *page)
 {
 	if (PageReserved(page))
-		free_bootmem_page(page);
+		arch_free_vmemmap_page(page);
 	else
 		__free_page(page);
 }
-- 
2.11.0

