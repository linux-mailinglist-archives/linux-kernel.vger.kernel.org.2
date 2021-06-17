Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92F3AAFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhFQJdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhFQJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:32:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1304C061767
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:30:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ei4so3435679pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nxkv0O/k/UB4v+Xu5eY5paN7/JzM4aFGdvV8fAfzbmY=;
        b=MHJxWIovP6QPbQfpNJwTtkJ1N8BPMstXj33UgXdcn6tm9In+reJtsZtOQpYslq8mPE
         NyoONyT9vRCtwke7GYQmV9voyDhxZXQGhIwgzsNmp8PXFAlDUJQRoSKRcMK63LapHgfX
         YaPm3/CAm6p6Nau9KHQPAHQ4oYbFQWDnFSQAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nxkv0O/k/UB4v+Xu5eY5paN7/JzM4aFGdvV8fAfzbmY=;
        b=NRJwtcNhHIejblmNs4T6ajqh9smxas3ie5Z8s0JbVbrn4pcxxRpNQ74ssxpAu76F34
         vNvaSZNLPtlmAhUNSTD48fhMe0kerwULZ+m48/ykbJjIjwfZstKZeO77HB60w4FnsabC
         xqpC7Cz+h4od7HlqkKyhx4ls04WDqNVoP4gmkX3AbpaZbdNwn4ArWu64Wihn/6ljBpzN
         qqlOzomQFVzUPBEusVexw7tnAiGaFwFsmPCimgIww/JOMGIlGVSBRLZl/oVj/E6NWVgC
         resw9hzHXUKfTf3klttgajx1RFetj8tU145obQN2Q2KQpG62/oh+emaC5Qls1r6cI2sw
         PpaQ==
X-Gm-Message-State: AOAM530hZRrwefqmyGwvcE/229XziCGOn3UxNEFYoJ8STfRIKp5TQHX+
        PnxaNcnFJHVCli046w4Bi+IbQRbfSkdHmw==
X-Google-Smtp-Source: ABdhPJzOOCMkqO+yzl7cQxSeb9G1HmppdYlcsLp9lVbxpXhoQzl4HpWo9T4rPKjf0rRmqmkeYB3Saw==
X-Received: by 2002:a17:902:dac2:b029:110:994a:abc3 with SMTP id q2-20020a170902dac2b0290110994aabc3mr3626941plx.78.1623922251151;
        Thu, 17 Jun 2021 02:30:51 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id v8sm4557656pff.34.2021.06.17.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:30:50 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v15 3/4] mm: define default MAX_PTRS_PER_* in include/pgtable.h
Date:   Thu, 17 Jun 2021 19:30:31 +1000
Message-Id: <20210617093032.103097-4-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617093032.103097-1-dja@axtens.net>
References: <20210617093032.103097-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c65e774fb3f6 ("x86/mm: Make PGDIR_SHIFT and PTRS_PER_P4D variable")
made PTRS_PER_P4D variable on x86 and introduced MAX_PTRS_PER_P4D as a
constant for cases which need a compile-time constant (e.g. fixed-size
arrays).

powerpc likewise has boot-time selectable MMU features which can cause
other mm "constants" to vary. For KASAN, we have some static
PTE/PMD/PUD/P4D arrays so we need compile-time maximums for all these
constants. Extend the MAX_PTRS_PER_ idiom, and place default definitions
in include/pgtable.h. These define MAX_PTRS_PER_x to be PTRS_PER_x unless
an architecture has defined MAX_PTRS_PER_x in its arch headers.

Clean up pgtable-nop4d.h and s390's MAX_PTRS_PER_P4D definitions while
we're at it: both can just pick up the default now.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

s390 was compile tested only.
---
 arch/s390/include/asm/pgtable.h     |  2 --
 include/asm-generic/pgtable-nop4d.h |  1 -
 include/linux/pgtable.h             | 22 ++++++++++++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 7c66ae5d7e32..cf05954ce013 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -342,8 +342,6 @@ static inline int is_module_addr(void *addr)
 #define PTRS_PER_P4D	_CRST_ENTRIES
 #define PTRS_PER_PGD	_CRST_ENTRIES
 
-#define MAX_PTRS_PER_P4D	PTRS_PER_P4D
-
 /*
  * Segment table and region3 table entry encoding
  * (R = read-only, I = invalid, y = young bit):
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index ce2cbb3c380f..2f6b1befb129 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -9,7 +9,6 @@
 typedef struct { pgd_t pgd; } p4d_t;
 
 #define P4D_SHIFT		PGDIR_SHIFT
-#define MAX_PTRS_PER_P4D	1
 #define PTRS_PER_P4D		1
 #define P4D_SIZE		(1UL << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE-1))
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9e6f71265f72..69700e3e615f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1625,4 +1625,26 @@ typedef unsigned int pgtbl_mod_mask;
 #define pte_leaf_size(x) PAGE_SIZE
 #endif
 
+/*
+ * Some architectures have MMUs that are configurable or selectable at boot
+ * time. These lead to variable PTRS_PER_x. For statically allocated arrays it
+ * helps to have a static maximum value.
+ */
+
+#ifndef MAX_PTRS_PER_PTE
+#define MAX_PTRS_PER_PTE PTRS_PER_PTE
+#endif
+
+#ifndef MAX_PTRS_PER_PMD
+#define MAX_PTRS_PER_PMD PTRS_PER_PMD
+#endif
+
+#ifndef MAX_PTRS_PER_PUD
+#define MAX_PTRS_PER_PUD PTRS_PER_PUD
+#endif
+
+#ifndef MAX_PTRS_PER_P4D
+#define MAX_PTRS_PER_P4D PTRS_PER_P4D
+#endif
+
 #endif /* _LINUX_PGTABLE_H */
-- 
2.30.2

