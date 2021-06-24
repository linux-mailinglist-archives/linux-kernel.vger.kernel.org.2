Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72273B2593
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFXDnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhFXDn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:43:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2AFC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:41:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t9so3581141pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvCzMPY1iDnXrmjh/pjQWKgOuSudghioSXufJUjyJjc=;
        b=J2OkXKObl6CYfnxQlkmmMaeOYyf2X6Xqhir66nx7wrcwvPBnkeeC3KAPr2dkh9bBvk
         dcgGqLWR2GuWsJDWbQCbhGoXzXg7rC/UvvUfZbJ3GYgvMU54Aly5ZTKyA54Wb49muTXL
         7cqPneehzSNCUAVQlZrhlJusCiC4Edx4OYisY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvCzMPY1iDnXrmjh/pjQWKgOuSudghioSXufJUjyJjc=;
        b=Nj0JCoJKQKIUzs0cegxfm+pmVSWcBN4I3CB1hRrb7WF4DwWs538nR8Tkf/F7tcnF6X
         jha8H7siJZtRH0qrnb8hbJ0aA34MslD0mQDu/H3tLpvuQ9jj/vN9SU29D0hjcmuMuImk
         NpRHa+7Bti8PEWPwL838qVmGWoZq7ZKFR3a93DcYsBClU0fTdP6xk5rozCFoXKed3Zos
         7rUAS7okkeJ4yMVr+9YsWbCf3VLUwfr8DuRiH9pZVlzXAwUz/W9ZfRqgYvnEVZSoFlsH
         mXNWV/gAfD00Xj61f2bXFQesRa10KauUJ+oznwr1yUrOzMeeVogAsXFCd567clgAdqJV
         GPEA==
X-Gm-Message-State: AOAM530GNt6NJIZXvOHIyhZUPtInkzDx+bYO+xu9q9dDLetJgAMbQirY
        fjVNRNsSq5KwCOwN/YsI2/zH9r5YEKyAzw==
X-Google-Smtp-Source: ABdhPJxG3zy2eS/jaYiZ/EUqvgZ/Z2jIEolGittrt/Ulk+fSsAbrQb8DXATsxr4lxtZy+aRd09K8cw==
X-Received: by 2002:a62:844d:0:b029:308:230c:fe3a with SMTP id k74-20020a62844d0000b0290308230cfe3amr906161pfd.34.1624506069293;
        Wed, 23 Jun 2021 20:41:09 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id j19sm556042pgm.44.2021.06.23.20.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 20:41:08 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v16 3/4] mm: define default MAX_PTRS_PER_* in include/pgtable.h
Date:   Thu, 24 Jun 2021 13:40:49 +1000
Message-Id: <20210624034050.511391-4-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624034050.511391-1-dja@axtens.net>
References: <20210624034050.511391-1-dja@axtens.net>
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

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
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
index 79742f497cb5..dcac7b2df72c 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -343,8 +343,6 @@ static inline int is_module_addr(void *addr)
 #define PTRS_PER_P4D	_CRST_ENTRIES
 #define PTRS_PER_PGD	_CRST_ENTRIES
 
-#define MAX_PTRS_PER_P4D	PTRS_PER_P4D
-
 /*
  * Segment table and region3 table entry encoding
  * (R = read-only, I = invalid, y = young bit):
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 2f1d0aad645c..03b7dae47dd4 100644
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
index fb20c57de2ce..d147480cdefc 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1634,4 +1634,26 @@ typedef unsigned int pgtbl_mod_mask;
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

