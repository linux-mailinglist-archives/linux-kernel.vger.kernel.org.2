Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D739B3874F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347816AbhERJWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbhERJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:22:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:21:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1212739pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=av1Oh98AjSqD3EqUtlRs5SqXwoUpF6yWirgoJQzOgDs=;
        b=1L3udiYJUhcuPlReJBTEnyZTAVVvIIjaSUD5Pfa87FqrpZodOYwUtjD/PCKtLAH7vu
         oWs5mvMA5upa5qr6kG0RInr45E5xuirNQYuEuhngZvhtePmVp09JfDCE4v0WtVKuRerJ
         lE0Wpap9ZUcWFb/SVDqpR2FfXWJgAvCLJFLyNQn+LcMHRVkyweET4N+5LuwRGSxVE+Lm
         JtOodVnyWaLPKM30PsbTEBKgN6VYEIeT3RE6gjZud1FWSyprI+Kp+CTI2k7H/DnOCIzV
         CWaUZCffH5XTHtFzEngLp6YueyZzaJTMx67cfs4EYAttGczQDWPkkpcXa0yN4XNojV4h
         y+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=av1Oh98AjSqD3EqUtlRs5SqXwoUpF6yWirgoJQzOgDs=;
        b=FqFqT85H0/1McJ0QzcZEnVs3Sg6OibWiCpwRlYa86cfJf8L/HSBMEwwPHXILtDJjxm
         H91TK22Jcq/wIucDAba1hCNmH89y1rdqBU3+Cz9zVphuVWPmG24BdHJ5np7xs0pDEgP5
         6tXv/jNSyVwPKXokiOC21doaR0N1r9Pq/3NHvJUFb0u5OotJfyvIl9ZWMXRtP9cvF1li
         5bcqfFxvnL0EOTh2ABDfrcppY/fR17jyAjr182zTPw2aolKJB0WSYXUgT/ByeK5Ed5qD
         wLd86cnvKkpFDUECmEV0B5vXQWGawzcXdHQURMkdICMYUm8ekPAI6/5mTDEdQa3x2MzW
         T31g==
X-Gm-Message-State: AOAM530vbZq0aoGLdQGerQPwaAGor6nUgC1gqbSq3dNLCdVUKFnztPnG
        417ysyUWcs/HKXIEroanDUAsmQ==
X-Google-Smtp-Source: ABdhPJzDPmbgt9y+IQNNyRtJP0Pqx2akeskwHAD/9soF2DwjZGGkLEEVWUw42Zn8i46hVz4YpN+TVg==
X-Received: by 2002:a17:902:e309:b029:f1:9342:2036 with SMTP id q9-20020a170902e309b02900f193422036mr3573888plc.53.1621329691556;
        Tue, 18 May 2021 02:21:31 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id p11sm12025262pgn.65.2021.05.18.02.21.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 02:21:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] arm64: mm: hugetlb: add support for free vmemmap pages of HugeTLB
Date:   Tue, 18 May 2021 17:18:26 +0800
Message-Id: <20210518091826.36937-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preparation of supporting freeing vmemmap associated with each
HugeTLB page is ready, so we can support this feature for arm64.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/mm/mmu.c | 5 +++++
 fs/Kconfig          | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5d37e461c41f..967b01ce468d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -23,6 +23,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/hugetlb.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -1134,6 +1135,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	pmd_t *pmdp;
 
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
+
+	if (is_hugetlb_free_vmemmap_enabled() && !altmap)
+		return vmemmap_populate_basepages(start, end, node, altmap);
+
 	do {
 		next = pmd_addr_end(addr, end);
 
diff --git a/fs/Kconfig b/fs/Kconfig
index 6ce6fdac00a3..02c2d3bf1cb8 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -242,7 +242,7 @@ config HUGETLB_PAGE
 
 config HUGETLB_PAGE_FREE_VMEMMAP
 	def_bool HUGETLB_PAGE
-	depends on X86_64
+	depends on X86_64 || ARM64
 	depends on SPARSEMEM_VMEMMAP
 
 config MEMFD_CREATE
-- 
2.11.0

