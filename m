Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E997545DE13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356323AbhKYP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356238AbhKYPyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:54:49 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3CC0613FA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:44:15 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b40so17300518lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjdtC5GIxYnl5iuWdNGFM3Hr3h23E1k1oPnPZHzamQY=;
        b=pqy2TW0bsBo5u1QZ2nCCwi5+QVw2p6auHI5QbjTULerGJrcj7TbW+iaStA4URJwIuO
         fOn8rVo1e8/KRQFsav5cOZvzPKce06KSrbKMRm/+RX+FDZJOzIuJc1OLH4Yl07gOeuvh
         etiGPY5mBWaBpxwbTUQ1cZdZFHSCq7OubyvvyIgyiDijd8tqenSY9FLFzC8HUmlJhb84
         XQcTxgFjcSmXxgoBvC0x/r+0yJKvH2rtat9hVSwiQGoGt9MkPgUreADgdP6RMlTcgOnG
         5SFw4ZHrD+rH5LN06xwLde1VDzIDzATJWkaGRZAtvXH63ufNzuBOxbottQltNiPsYkIm
         yWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjdtC5GIxYnl5iuWdNGFM3Hr3h23E1k1oPnPZHzamQY=;
        b=f9wdJvt/FvBIBucrE9q/RYQF5m5k3B273DG5W9bpT97AZnH/BhV5aSa6Ejj4kH2m4N
         aGjcRSeC1Bw0IlyoRaF3yqOSl0r5m3QcqthxWpoYlKKdQ8U1+CmZkzbtussPRxGvCz5Z
         XBQMAm1B1PjE1knkmy+frygUMk/f1L04A3dw9EpZ4BmyxLtAJFCSIRKGpMkuaxPKHfW6
         oPfy8kNVkcxeV/+w3VkERBxXbOYslE8hKanifF3pHkAJ1zLuO5SZSg5HsUUkZravsO/l
         RShcn5HKOapo5+Un5Fm0jQmw/7KB8yjbvRG22/NRle4N5Lqy/l9oXHZAQwaqvEKEJjff
         pgyA==
X-Gm-Message-State: AOAM530KfG39xuOZHt88Pn/tUwQwETNiVlGVywlF6J3Jr0jR1bcr528H
        /KNGSuaTOvXa1dZL99FH/d+5Tw==
X-Google-Smtp-Source: ABdhPJyiWyvugY0ouHq1meoMZp+lYl8AA/jg9WpkSyn1m8R7vRBtv3L2hntYxgDFLYy/rL7jBtf4eg==
X-Received: by 2002:a05:6512:3602:: with SMTP id f2mr24700962lfs.399.1637855054256;
        Thu, 25 Nov 2021 07:44:14 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id x12sm261627ljc.121.2021.11.25.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:44:13 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     benh@kernel.crashing.org, paulus@samba.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc: mm: radix_tlb: rearrange the if-else block
Date:   Thu, 25 Nov 2021 16:44:06 +0100
Message-Id: <20211125154406.470082-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

arch/powerpc/mm/book3s64/radix_tlb.c:1191:23: error: variable 'hstart' is uninitialized when used here [-Werror,-Wuninitialized]
                                __tlbiel_va_range(hstart, hend, pid,
                                                  ^~~~~~
arch/powerpc/mm/book3s64/radix_tlb.c:1175:23: note: initialize the variable 'hstart' to silence this warning
                unsigned long hstart, hend;
                                    ^
                                     = 0
arch/powerpc/mm/book3s64/radix_tlb.c:1191:31: error: variable 'hend' is uninitialized when used here [-Werror,-Wuninitialized]
                                __tlbiel_va_range(hstart, hend, pid,
                                                          ^~~~
arch/powerpc/mm/book3s64/radix_tlb.c:1175:29: note: initialize the variable 'hend' to silence this warning
                unsigned long hstart, hend;
                                          ^
                                           = 0
2 errors generated.

Rework the if-else to pull the 'IS_ENABLE(CONFIG_TRANSPARENT_HUGEPAGE)'
check one level up, this will silent the warnings. That will also
simplify the 'else' path. Clang is getting confused with these warnings,
but the warnings is a false-positive.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/powerpc/mm/book3s64/radix_tlb.c | 31 +++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 7724af19ed7e..e494a45ce1b4 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -1170,16 +1170,14 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
 				_tlbiel_pid_multicast(mm, pid, RIC_FLUSH_ALL);
 			}
 		}
-	} else {
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 		bool hflush = false;
 		unsigned long hstart, hend;
 
-		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-			hstart = (start + PMD_SIZE - 1) & PMD_MASK;
-			hend = end & PMD_MASK;
-			if (hstart < hend)
-				hflush = true;
-		}
+		hstart = (start + PMD_SIZE - 1) & PMD_MASK;
+		hend = end & PMD_MASK;
+		if (hstart < hend)
+			hflush = true;
 
 		if (type == FLUSH_TYPE_LOCAL) {
 			asm volatile("ptesync": : :"memory");
@@ -1207,6 +1205,25 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
 				_tlbiel_va_range_multicast(mm,
 					hstart, hend, pid, PMD_SIZE, MMU_PAGE_2M, flush_pwc);
 		}
+	} else {
+
+		if (type == FLUSH_TYPE_LOCAL) {
+			asm volatile("ptesync" : : : "memory");
+			if (flush_pwc)
+				/* For PWC, only one flush is needed */
+				__tlbiel_pid(pid, 0, RIC_FLUSH_PWC);
+			__tlbiel_va_range(start, end, pid, page_size, mmu_virtual_psize);
+			ppc_after_tlbiel_barrier();
+		} else if (cputlb_use_tlbie()) {
+			asm volatile("ptesync" : : : "memory");
+			if (flush_pwc)
+				__tlbie_pid(pid, RIC_FLUSH_PWC);
+			__tlbie_va_range(start, end, pid, page_size, mmu_virtual_psize);
+			asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+		} else {
+			_tlbiel_va_range_multicast(mm,
+					start, end, pid, page_size, mmu_virtual_psize, flush_pwc);
+		}
 	}
 out:
 	preempt_enable();
-- 
2.33.0

