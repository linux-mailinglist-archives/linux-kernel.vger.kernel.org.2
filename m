Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8973E333646
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhCJHT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhCJHS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:18:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69C6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:18:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w8so1085954pjf.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIA/QB2KU+rrzZfq152LcTIhO8HMik78jGjN3khGL2w=;
        b=vz2ANmllNrB/6zQ9cHOSxTTl8EVWr8HiijV1nbwR/L0G7Z1gsPxSgS5CY2R9mA1izi
         MWZuURk1fl7leO2hdYc3lGNOTHROW53XdZCojj80ctOKedD0uJuEX/uzOb1GPlah9DEK
         FC5eiKETAaCYD0sFveY1tzmALg3F9ux6F+nd790OK3crxRek97CJQ7CFiZiKRioARWRk
         v/XXyyx10LsMyZ6DQjx/6Rs6b3rxfXoZJbo7isYy/d2bvxafS4y7ZuhvRyDI53qoBKkv
         zossrebZe9rEq6Ym8OP54i0Qvt5nui64C8yKdBnVYMXE9d/MgkN5eA87yqfl84Xq5WRJ
         kq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIA/QB2KU+rrzZfq152LcTIhO8HMik78jGjN3khGL2w=;
        b=eTgySdIsBdiGJVDCMHXDwW1hvFWG5WT3pJ5y8j/ST02uolrkQ77yJTnm/q7VaKOTfa
         kjrX+kcLlJZYdXU2lP1iYEaSdRrFS11cvzW32V1aUiESNU68SPvLWTUPjfnjv97b4l2m
         8z5Lq35GK4rmFVyFmPXn2cXoXgJTygVeoqVHV4K1X2ZaIWMrkTdKQDlMLXDdrAdQaBH5
         bMvVmH4FO+aTHOv7n5+/aH3G4qfcJYyI8FdV4In+XY7npx40HJiO7Z7uKI4YD3TfBQb+
         bvD3XxinswyJxAW0FFvsu/tT/5JNPp8scXJCdvypHw4eIHwRlI9mOZ7BBtrxkphyKDKc
         MVBA==
X-Gm-Message-State: AOAM531tDo2u/mXky3C7Ufjg+R3LIC2HHOS5UnyETTZPGnijNDlpJOwx
        YPqYkvNSmyuti0lGHOs964p/vQ==
X-Google-Smtp-Source: ABdhPJwowWjHya3/6Nc15zurktLPm17MKjE9NrlSzAz5tNvj1VTRUBM73Bxtm4hu/RA+iDjyEo8a6Q==
X-Received: by 2002:a17:90a:6e44:: with SMTP id s4mr2058884pjm.112.1615360735426;
        Tue, 09 Mar 2021 23:18:55 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h15sm2828868pfo.20.2021.03.09.23.18.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:18:55 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/3] arm64: mm: hugetlb: add support for free vmemmap pages of HugeTLB
Date:   Wed, 10 Mar 2021 15:15:35 +0800
Message-Id: <20210310071535.35245-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210310071535.35245-1-songmuchun@bytedance.com>
References: <20210310071535.35245-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preparation of supporting freeing vmemmap associated with each
infrastructure is ready, so now we can support it for arm64.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/mm/mmu.c | 5 +++++
 fs/Kconfig          | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3802cfbdd20d..6051a120c906 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/hugetlb.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -1109,6 +1110,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	pmd_t *pmdp;
 
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
+
+	if (is_hugetlb_free_vmemmap_enabled() && !altmap)
+		return vmemmap_populate_basepages(start, end, node, altmap);
+
 	do {
 		next = pmd_addr_end(addr, end);
 
diff --git a/fs/Kconfig b/fs/Kconfig
index b5dcc68aab25..d90860135844 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -239,9 +239,9 @@ config HUGETLB_PAGE
 
 config HUGETLB_PAGE_FREE_VMEMMAP
 	def_bool HUGETLB_PAGE
-	depends on X86_64
+	select HAVE_BOOTMEM_INFO_NODE if X86_64
 	depends on SPARSEMEM_VMEMMAP
-	depends on HAVE_BOOTMEM_INFO_NODE
+	depends on X86_64 || ARM64
 
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
-- 
2.11.0

