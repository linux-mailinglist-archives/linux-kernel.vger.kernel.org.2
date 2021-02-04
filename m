Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8730FBC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhBDSl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbhBDSgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:36:15 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BAC061797
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:34:50 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id t186so3471489qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OEiarKErHeQBPZKsYeL3IkSXq4c5mYMZ0dIk1JQlp5Y=;
        b=HaC1/BN3UFOD+8cUBOspMU73ct/e+qcOiXXFRVMYRHECbtjGH4eFsMreWMsc1gLI8E
         D4HwfqBpv8ifvkQ0WTBn6pGbOvbPMH5naPNpoq6uIrdBp6aAsuqDwCDf2SHMU8U7EnQf
         as+ddooJ5YbrDa0uuHll/bhyoJhHSwd8mgvYbwJbZpIPtS3RdBrNlhZIAxBzHn83KTEe
         ColYJ67sQiwpnOsZb66BnQz+LGNeOAusyJeYaEc/NUueGhZQKpMBT4BxAkZqBVp13ukv
         WAAZ4mkE7OgDpUP7dnncZRPz8SVVk3PinhZ4MkQv9OelGo/fPIj3rr0yOBddPveGFIiu
         udHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OEiarKErHeQBPZKsYeL3IkSXq4c5mYMZ0dIk1JQlp5Y=;
        b=Uit7St1iCN6PnDT6bbfUoKG/+lNp0B/qiCESTmUeXjj88M2fsQ66OBWNZSU9N8sU5j
         qQbvz8CCUNb6n5pcVsvux+ez9nnJ1N/BiZgI6WGSF8Kro9KgnPAXPr3vIea/MX2KujeU
         uLyQhy+CmxtskziVo8gRhoQ/qBqSEyoGUEReozuzm4V6RVaQKyfF+bHR3xqiXb32yjhZ
         woyyuZBVuAKbXpGbcgmbf3SfMJmh88DpqIJUMjvdjqu16eLyOqpVTQ3VqYOj2kCUIVaA
         N9zfmPGRTZCpuRf9dGGgFJ1XjjqFr7A1YAolCMGdTSDRN6KBg+zD3YHMCd20JzXK0/Rl
         gwqA==
X-Gm-Message-State: AOAM533qawn+gl72lEyntey/PjQPxIHSmz44wAhpy76ursTjOeV8vdxR
        9qoQgTaz5uKbG2fkOIPxssJUPMBfwSaw70R2jyQz
X-Google-Smtp-Source: ABdhPJwoP//UfZwpJJBLBfBtdgwOdsWrZ/lchYHtEI3yC3eDyBTvQXSkLtfePQ0byVtVxFApIJiz12FKAuAPClXh2/pD
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:b001:12c1:dc19:2089])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:a692:: with SMTP id
 t18mr803070qva.18.1612463689620; Thu, 04 Feb 2021 10:34:49 -0800 (PST)
Date:   Thu,  4 Feb 2021 10:34:26 -0800
In-Reply-To: <20210204183433.1431202-1-axelrasmussen@google.com>
Message-Id: <20210204183433.1431202-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210204183433.1431202-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 03/10] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Prepare for it to be called outside of mm/hugetlb.c.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 8 ++++++++
 mm/hugetlb.c            | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f6d5939a6eb0..af40500c99f0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -950,4 +950,12 @@ static inline __init void hugetlb_cma_check(void)
 
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 
+#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
+/*
+ * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
+ * implement this.
+ */
+#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#endif
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 588c4c28c44d..5b3f00a1e276 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4924,14 +4924,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
-/*
- * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
- * implement this.
- */
-#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
-#endif
-
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
-- 
2.30.0.365.g02bc693789-goog

