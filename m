Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B793AAC95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFQGm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFQGmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:42:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C406EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:40:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n12so4097747pgs.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1Pi1RzyfsWNKu+C0AG0URkCeCwQ85qxvHvYbK7X+Gk=;
        b=D0qWqK+j9bAxupl/GWzyDACuzv1h1iWk4UZlczb/9+tQhGbi7xxPWBaUpi4kDTbDey
         H/kqsOFeduz6TKC/7oGW33vzxgZ7OKxRZDJ2UBJzYRKsnKluSBNjyXvhB6lbvBoS9lnA
         VNJehADe90JM5Ksgr2/aC4d0Kloqzdw/174pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1Pi1RzyfsWNKu+C0AG0URkCeCwQ85qxvHvYbK7X+Gk=;
        b=ODzNzP2rUFR2Z6hG3pKVxmwfgWo2L7p8EBke6V0Q3B9TE9CnHXzbJ3eVGTQLUWkyzE
         VWBszBfKpbTfhgzwtyylTBJ/gB10kGdMtSzG/Dhq2Az5VFI4+wYR5Nq8WA7LqmDhFzPj
         e0rp2S8P3iBDjyNkEyX1M5eFO7CVtpBrblCmQUQsLQy5oTnmZhi9Fx5YMx1l2F8vYNXX
         3BB+fN9mCP/dEh6DjFD3xkskMF6rIWxAYJp/2g3IqxKEywVapITCOiKWzTAMoWUzdRyF
         yLfe7hKAdvp+/X0W+jeWKhV0flEk8H9jeh4smBJp7SBwy3fxbGKnHjPIP3D0hSD6PM24
         X5lg==
X-Gm-Message-State: AOAM532C9E1SAAw+bOK3Fe0vWUSv++IOwhLngEkFhuy10Cr2O/T6DLvv
        bEtKijQ20tWcZY7HuanuuFKQKrJa0elSoQ==
X-Google-Smtp-Source: ABdhPJw1k3C0RQW96NTpSA3/18qlSWZth0xfR3FedqjMvvE1Q/rgMD0EE6zlpgi6W++lsBaQb4dL9Q==
X-Received: by 2002:a63:1e55:: with SMTP id p21mr3505606pgm.412.1623912017140;
        Wed, 16 Jun 2021 23:40:17 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id o3sm3981688pfd.41.2021.06.16.23.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 23:40:16 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v14 3/4] mm: define default MAX_PTRS_PER_* in include/pgtable.h
Date:   Thu, 17 Jun 2021 16:39:55 +1000
Message-Id: <20210617063956.94061-4-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617063956.94061-1-dja@axtens.net>
References: <20210617063956.94061-1-dja@axtens.net>
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

