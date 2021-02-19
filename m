Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A03931F369
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhBSAt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhBSAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:49:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C78C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c12so4817283ybf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Gqbdv7dcKJ3HCSbhGAkcVMLKp5XjaZ2pyZBQ0WD1HYc=;
        b=Ik5mLa+wIzQ9zfYIXzCW8txps5b0LOtlw5SCrz0oCUlrnn7+7YcukDUOv592BKXIqA
         XyMpq/lVfamEDV77jRUDPpYomIaSg3srYMmwkz4alfwvoOPbJWqLB0s4hfvKyGQmNSjh
         SAvyLDI68vF48r++B4/5iUJqMpniXnHnA186xd0b+LGQigqd7YehpirHSvL8pzcClIdG
         tblMLXy0TyMR+kiVbvV74wD5F6ko1FL2kimeYxojeJbkG5WBJJal+0ySZ9HVCMhuGoNK
         B87mVtEI4pnGDDEI82to7662ighQZ673OxM1jDpoBdoODkD66MnmLr0kYQrwJHg+9Oej
         KYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gqbdv7dcKJ3HCSbhGAkcVMLKp5XjaZ2pyZBQ0WD1HYc=;
        b=qYlUv5kHWBChn4cvt356Az5CWpMavp9DJFom1uo6h4KmaCA5aYowc5GFYSZPRX6A0m
         gg0vb/k7L8neFa6D+HLJKjomKOHdxfgp+NZI9Q1+mYsvJB6DPMfj7WGVlMI1lkGTL93U
         4x4Z6wX3TvWFivpShVUJnCRXZuS8wTkIbmgF0k7zlCcrwh0MJSCO+/CCD0oPlWdIs9WJ
         +OqqJTzOFWPCmc2W18f+AIi+OOXvl4fFmDOF0dyr2xugi6PFIp2SP4Z0/AQmLLxS2fMz
         IUz/J8ocFol/aAEDuxt6ZEUlAdcFvJoXLVTiIBLJi4hAhcI8klAZvx90bGB4zpjat4Co
         q9FA==
X-Gm-Message-State: AOAM533NElQ1F9ffNa0Vu2hO6w7GtLM3Zz9Ka9/1AOWi4YiJENqzfIZP
        2T74CHJQOS6Se8iLkY1F8t4EYs0gK0f2PEus5ogO
X-Google-Smtp-Source: ABdhPJy58+nl+97/Bd88jvU8zeF4QbRXiH9mdsFm7pt16swihROM91O3O2VWhD1CU7In7elQn2DEoUgM9zB2OdCtvM/s
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:e939:4cce:117:5af3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:c090:: with SMTP id
 c138mr6712073ybf.279.1613695715827; Thu, 18 Feb 2021 16:48:35 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:48:20 -0800
In-Reply-To: <20210219004824.2899045-1-axelrasmussen@google.com>
Message-Id: <20210219004824.2899045-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210219004824.2899045-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v7 2/6] userfaultfd: disable huge PMD sharing for MINOR
 registered VMAs
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

As the comment says: for the MINOR fault use case, although the page
might be present and populated in the other (non-UFFD-registered) half
of the mapping, it may be out of date, and we explicitly want userspace
to get a minor fault so it can check and potentially update the page's
contents.

Huge PMD sharing would prevent these faults from occurring for
suitably aligned areas, so disable it upon UFFD registration.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 0390e5ac63b3..e060d5f77cc5 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -56,12 +56,19 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 }
 
 /*
- * Never enable huge pmd sharing on uffd-wp registered vmas, because uffd-wp
- * protect information is per pgtable entry.
+ * Never enable huge pmd sharing on some uffd registered vmas:
+ *
+ * - VM_UFFD_WP VMAs, because write protect information is per pgtable entry.
+ *
+ * - VM_UFFD_MINOR VMAs, because otherwise we would never get minor faults for
+ *   VMAs which share huge pmds. (If you have two mappings to the same
+ *   underlying pages, and fault in the non-UFFD-registered one with a write,
+ *   with huge pmd sharing this would *also* setup the second UFFD-registered
+ *   mapping, and we'd not get minor faults.)
  */
 static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_WP;
+	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
-- 
2.30.0.617.g56c4b15f3c-goog

